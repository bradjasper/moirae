/*
Beej's code modified as needed for mp2 cs438
** listener.c -- a datagram sockets "server" demo
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <pthread.h>


#define MYPORT "1357"	// the port users will be connecting to

#define MAXBUFLEN 10000
#define FRAMESIZE 100


struct frameHeader
{
	uint16_t checksum;
	uint16_t frameNum;
	uint8_t slt;
	char data[FRAMESIZE];
};


// get sockaddr, IPv4 or IPv6:
void *get_in_addr(struct sockaddr *sa)
{
	if (sa->sa_family == AF_INET) {
		return &(((struct sockaddr_in*)sa)->sin_addr);
	}

	return &(((struct sockaddr_in6*)sa)->sin6_addr);
}


int main(int argc, char *argv[])
{
	int sockfd;
	struct addrinfo hints, *servinfo, *p;
	int rv;
	int numbytes;
	struct sockaddr_storage their_addr;
	char buf[MAXBUFLEN];
	size_t addr_len;
	char s[INET6_ADDRSTRLEN];
	int fsize;
	char filesize[6];
	FILE * inputFile;
	struct frameHeader frH;
	int i;
	
	memset(&frH, 0, sizeof(frH));

	
	//check if the name of the file present in the command line
	if (argc < 2) {
		fprintf(stderr,"usage: missing file name\n");
		exit(1);
	}
	else if(argc > 2) {
		fprintf(stderr,"usage: too many arguments\n");
		exit(1);
	}
	
	//open the file for reading
	inputFile = fopen(argv[1], "r");
	if(inputFile == NULL)
	{
		fprintf(stderr, "error: file does not exist");
		exit(1);
	}
	

	memset(&hints, 0, sizeof hints);
	hints.ai_family = AF_UNSPEC; // set to AF_INET to force IPv4
	hints.ai_socktype = SOCK_DGRAM;
	hints.ai_flags = AI_PASSIVE; // use my IP

	if ((rv = getaddrinfo(NULL, MYPORT, &hints, &servinfo)) != 0) {
		fprintf(stderr, "getaddrinfo error: %s\n", gai_strerror(rv));
		return 1;
	}

	// loop through all the results and bind to the first we can
	for(p = servinfo; p != NULL; p = p->ai_next) {
		if ((sockfd = socket(p->ai_family, p->ai_socktype,
				p->ai_protocol)) == -1) {
			perror("socket error");
			continue;
		}

		if (bind(sockfd, p->ai_addr, p->ai_addrlen) == -1) {
			close(sockfd);
			perror("bind error");
			continue;
		}

		break;
	}

	if (p == NULL) {
		fprintf(stderr, "bind socket error\n");
		return 2;
	}

	freeaddrinfo(servinfo);

	printf("server: waiting to recvfrom...\n");

	
	addr_len = sizeof their_addr;
	if ((numbytes = recvfrom(sockfd, buf, MAXBUFLEN-1 , 0,
			(struct sockaddr *)&their_addr, &addr_len)) == -1) {
			perror("recvfrom error");
			exit(1);
	}

	// print out data received
    printf("server: got packet from %s\n",
        inet_ntop(their_addr.ss_family,
            get_in_addr((struct sockaddr *)&their_addr),
            s, sizeof s));
    printf("server: packet is %d bytes long\n", numbytes);
    buf[numbytes] = '\0';
    printf("server: packet contains \"%s\"\n", buf);
		

	
	//send file name
	if ((numbytes = sendto(sockfd, argv[1], strlen(argv[1]), 0,
			 (struct sockaddr *) &their_addr, p->ai_addrlen)) == -1) {
		perror("sendto error");
		exit(1);
	}
	printf("server: sent %d bytes\n", numbytes);
	printf("server: sent %s\n", argv[1]);
	
	
	// determine and send file size
    fseek(inputFile, 0, SEEK_END);
    fsize = ftell(inputFile); 
    fseek(inputFile, 0, SEEK_SET);
    printf("File size: %d \n", fsize);
	sprintf(filesize, "%d", (int) fsize);
	
	if ((numbytes = sendto(sockfd, filesize, strlen(filesize), 0,
			 (struct sockaddr *) &their_addr, p->ai_addrlen)) == -1) {
		perror("sendto error");
		exit(1);
	}
	printf("server: sent %d bytes\n", numbytes);
	printf("server: sent %s\n", filesize);
	
	
	//initialize and create frames
	frH.checksum = 0xaa;	//checksum initialized to 16 bit ones
	frH.frameNum = 0x0;		//frame number initialized to zero
	frH.slt = 0x04;		//the last byte initialized to sequence number zero, last frame mark set to one, and the frame type 3 bit zeros
	uint8_t seq = 0x0;
	uint8_t last = 0x1;
	uint8_t type = 0x0;
	uint16_t frame = 0x0;
	
	//iterate through the content of a file and send data in separate frames
	for(i = fsize/FRAMESIZE; i > 0; i--)
	{
		fseek(inputFile, (frame * FRAMESIZE), SEEK_SET);
		fgets(frH.data, FRAMESIZE+1, inputFile);
		printf("----------------\n");
		
		if((fsize-(frame*FRAMESIZE)) >= FRAMESIZE)
		{
			last = 0x0;
			frH.slt &= last;
		}
		
		frH.slt = (seq << 4) | (last << 3) | (type);
		frH.frameNum = frame;
		
		printf("frame: %d\n", frame);
		printf("data: %s\n", frH.data);	
		
		if ((numbytes = sendto(sockfd, &frH, sizeof(frH), 0,
			 (struct sockaddr *) &their_addr, p->ai_addrlen)) == -1) {
			perror("server: sendto error\n");
			exit(1);
		}
		
		//wrap around sequence and frame numbers when they reach the limit
		if(seq < 16)
			seq = seq + 0x01;
		else
			seq = 0x0;
			
		if(frame < 65536)
			frame = frame + 0x01;
		else
			frame = 0x0;
	}
	
	//send the last frame for the file
	last = 0x1;
	frH.slt = (seq << 4) | (last << 3) | (type);
	fseek(inputFile, (frame * FRAMESIZE), SEEK_SET);
	fgets(frH.data, FRAMESIZE, inputFile);
	frH.frameNum = frame;
	printf("----------------\n");
	printf("frame: %d\n", frame);
	printf("data: %s\n", frH.data);
	
	if ((numbytes = sendto(sockfd, &frH, sizeof(frH), 0,
			 (struct sockaddr *) &their_addr, p->ai_addrlen)) == -1) {
		perror("server: sendto error\n");
		exit(1);
	}
	
	//close socket
	close(sockfd);
	
	//close file
	fclose(inputFile);

	return 0;
}
