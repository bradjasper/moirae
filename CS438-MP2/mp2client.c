/*
 * client.c -- a datagram "client" demo
 * Code is derived from Beej's Guide: 
 * http://beej.us/guide/bgnet/output/html/multipage/clientserver.html#simpleserver
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

#include "mp2_given/mp2.c"
#include "mp2frame.c"

#define SERVERPORT "1357"    // the port users will be connecting to

#define MAXBUFLEN 1000
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
    struct sockaddr_storage their_addr;
	size_t addr_len;
	int rv;
    int numbytes;
	char buf[MAXBUFLEN];
	char s[INET6_ADDRSTRLEN];
	char * filename;
	FILE * outputFile;
	int filesize;
	int i;
	struct frameHeader frH;
	
	memset(&frH, 0, sizeof(frH));

	// check number of arguments
	if (argc < 2) {
		fprintf(stderr,"usage: missing 1 argument (hostname address)\n");
		exit(1);
	}
	else if(argc > 2) {
		fprintf(stderr,"usage: too many arguments\n");
		exit(1);
	}

    // initialize variables
    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_DGRAM;

    // retrieve address info for given IP address, port, hints, and server info
    if ((rv = getaddrinfo(argv[1], SERVERPORT, &hints, &servinfo)) != 0) {
        fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(rv));
        return 1;
    }

    // loop through all the results and make a socket
    for(p = servinfo; p != NULL; p = p->ai_next) {
        if ((sockfd = socket(p->ai_family, p->ai_socktype,
                p->ai_protocol)) == -1) {
            perror("client: socket");
            continue;
        }

        break;
    }

    // if addrinfo p is null, then unable to bind
    if (p == NULL) {
        fprintf(stderr, "client: failed to bind socket\n");
        return 2;
    }

    // send message 
    if ((numbytes = sendto(sockfd, "Beginning Client", strlen("Beginning Client"), 0,
             p->ai_addr, p->ai_addrlen)) == -1) {
        perror("client: sendto");
        exit(1);
    }

    printf("client: sent %d bytes to %s\n", numbytes, argv[1]);
	
	// wait to receive:
    printf("client: waiting to recvfrom...\n");
	
	// 1. file name	
    addr_len = sizeof their_addr;
    if ((numbytes = recvfrom(sockfd, buf, MAXBUFLEN-1 , 0,
        (struct sockaddr *)&their_addr, &addr_len)) == -1) {
        perror("client: recvfrom error\n");
        exit(1);
    }

	// 1.5 print file name
	printf("*******************************\n");
	buf[numbytes] = '\0';
	filename = buf;
	printf("client: got file name \"%s\" from %s\n", filename, 
		inet_ntop(their_addr.ss_family,
			get_in_addr((struct sockaddr *)&their_addr),
			s, sizeof s));


	// 2. file size
    addr_len = sizeof their_addr;
    if ((numbytes = recvfrom(sockfd, buf, MAXBUFLEN-1 , 0,
        (struct sockaddr *)&their_addr, &addr_len)) == -1) {
        perror("client: recvfrom error\n");
        exit(1);
    }

	// 2.5 print file name
	printf("*******************************\n");
	buf[numbytes] = '\0';
	filesize = atoi(buf);
	printf("client: got file size \"%d\" from %s\n", filesize, 
		inet_ntop(their_addr.ss_family,
			get_in_addr((struct sockaddr *)&their_addr),
			s, sizeof s));

    
    freeaddrinfo(servinfo);
	outputFile = fopen(filename, "w");
	if(outputFile == NULL)
	{
		printf("client: output file open error\n");
		exit(1);
	}
	
	//receive each frame and write it to the file stream at the offset 
	//location that we can find from multiplying frame number (found in 
	//the header) by the frame size
	for(i = (filesize/FRAMESIZE); i >= 0; i--)
	{
		if ((numbytes = recvfrom(sockfd, &frH, sizeof(struct frameHeader), 0,
        (struct sockaddr *)&their_addr, &addr_len)) == -1) {
			perror("client: recvfrom error\n");
			exit(1);
		}

		//move the file pointer and write to that location
		fseek(outputFile, (frH.frameNum * FRAMESIZE), SEEK_SET);
		fputs(frH.data, outputFile);
	}
	
	//output the final file content for testing purposes
	printf("*******************************\n");
	outputFile = freopen(filename, "r", outputFile);
	char temp[10000];
	rewind(outputFile);
	printf("File content:\n");
	fgets(temp, 10000, outputFile);
	puts(temp);
	
	// close socket
    close(sockfd);
	
	//close file
	fclose(outputFile);

    return 0;
}

