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
	char fileContent[10000];
	char filesize[6];
	FILE * fd;
	
	struct frameHeader frH;
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
	
	//retrieve the first N bytes or less from the file
	memset(&fileContent, 0, sizeof(fileContent));
	fd = fopen(argv[1], "r");
	if(fd == NULL)
	{
		fprintf(stderr, "error: file does not exist");
		exit(1);
	}
	fgets(fileContent, 10000, fd);
	fclose(fd);
	

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
    printf("listener: got packet from %s\n",
        inet_ntop(their_addr.ss_family,
            get_in_addr((struct sockaddr *)&their_addr),
            s, sizeof s));
    printf("server: packet is %d bytes long\n", numbytes);
    buf[numbytes] = '\0';
    printf("server: packet contains \"%s\"\n", buf);
		

	
	
	if ((numbytes = sendto(sockfd, argv[1], strlen(argv[1]), 0,
			 (struct sockaddr *) &their_addr, p->ai_addrlen)) == -1) {
		perror("sendto error");
		exit(1);
	}
	printf("server: sent %d bytes\n", numbytes);
	printf("server: sent %s\n", argv[1]);
	
	memset(&filesize, 0, sizeof(filesize));
	sprintf(filesize, "%d", (int) (strlen(fileContent)));
	
	if ((numbytes = sendto(sockfd, filesize, strlen(filesize), 0,
			 (struct sockaddr *) &their_addr, p->ai_addrlen)) == -1) {
		perror("sendto error");
		exit(1);
	}
	printf("server: sent %d bytes\n", numbytes);
	printf("server: sent %s\n", filesize);
	
	
	char * filePointer;
	filePointer = fileContent;
	printf("%d\n", strlen(filePointer));
	frH.checksum = 0xaa;
	frH.frameNum = 0x0;
	frH.slt = 0x04;
	uint8_t seq = 0x0;
	uint8_t last = 0x1;
	uint8_t type = 0x0;
	
	while(strlen(filePointer)/FRAMESIZE)
	{
		memcpy(frH.data, filePointer, FRAMESIZE);
		if(strlen(filePointer) >= FRAMESIZE)
		{
			filePointer = filePointer+FRAMESIZE;
			last = 0x0;
			frH.slt &= last;
		}
		
		frH.slt = (seq << 4) | (last << 3) | (type);
			
		printf("value: %02X \n", frH.slt);
		printf("%d\n", strlen(filePointer));
		
		seq = seq + 0x01;
	}
	
	last = 0x1;
	frH.slt = (seq << 4) | (last << 3) | (type);	
	printf("value: %02X \n", frH.slt);
	printf("%d\n", strlen(filePointer));
	
	close(sockfd);

	return 0;
}
