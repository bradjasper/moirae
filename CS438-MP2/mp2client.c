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

#include "mp2_given/mp2.h"
#include "mp2frame.h"

#define SERVERPORT "1357"    // the port users will be connecting to

#define MAXBUFLEN 100

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

	frame swf;
	swf.poo = 32;
    
	// check number of arguments
    if (argc != 3) {
        fprintf(stderr,"usage: client hostname message\n");
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
    if ((numbytes = sendto(sockfd, argv[2], strlen(argv[2]), 0,
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
        perror("client: recvfrom for file");
        exit(1);
    }

	// 1.5 print file name
	printf("*******************************\n");
	printf("client: got file name from %s\n", 
		inet_ntop(their_addr.ss_family,
			get_in_addr((struct sockaddr *)&their_addr),
			s, sizeof s));
	printf("client: packet is %d bytes long\n", numbytes);
	buf[numbytes] = '\0';
	printf("client: file name is \"%s\"\n", buf);

	// 2. file size
    addr_len = sizeof their_addr;
    if ((numbytes = recvfrom(sockfd, buf, MAXBUFLEN-1 , 0,
        (struct sockaddr *)&their_addr, &addr_len)) == -1) {
        perror("recvfrom");
        exit(1);
    }

	// 2.5 print file name
	printf("*******************************\n");
	printf("client: got file size from %s\n", 
		inet_ntop(their_addr.ss_family,
			get_in_addr((struct sockaddr *)&their_addr),
			s, sizeof s));
	printf("client: packet is %d bytes long\n", numbytes);
	buf[numbytes] = '\0';
	printf("client: file size is \"%d\"\n", atoi(buf));
    
	// close socket
    freeaddrinfo(servinfo);

    close(sockfd);

    return 0;
}
