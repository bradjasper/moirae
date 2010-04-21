/** 
 * router.c
 *
 * Part of code as copied from Beej's tutorial example
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <netdb.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>

#define PORT "1357" // the port client will be connecting to 

#define MAXDATASIZE 100 // max number of bytes we can get at once 
 
 
void sigchld_handler(int s)
{
	while(waitpid(-1, NULL, WNOHANG) > 0);
}
 
// get sockaddr, IPv4 or IPv6:
void *get_in_addr(struct sockaddr *sa)
{
	if (sa->sa_family == AF_INET) {
		return &(((struct sockaddr_in*)sa)->sin_addr);
	}

	return &(((struct sockaddr_in6*)sa)->sin6_addr);
}



int executeRouter()
{
	int sockfd, numbytes;  
	char buf[MAXDATASIZE];
	struct addrinfo hints, *servinfo, *p;
	int rv;
	char s[INET6_ADDRSTRLEN];

	memset(&hints, 0, sizeof hints);
	hints.ai_family = AF_UNSPEC;
	hints.ai_socktype = SOCK_STREAM;
	
	char * hostname;
	int len;
	
	//get address of the current machine
	if(gethostname(hostname, len) != 0) {
		fprintf(stderr, "router: gethostname error\n");
		return 1;
	}

	if ((rv = getaddrinfo(hostname, PORT, &hints, &servinfo)) != 0) {
		fprintf(stderr, "router: getaddrinfo error: %s\n", gai_strerror(rv));
		return 1;
	}

	// loop through all the results and connect to the first we can
	for(p = servinfo; p != NULL; p = p->ai_next) {
		if ((sockfd = socket(p->ai_family, p->ai_socktype,
				p->ai_protocol)) == -1) {
			perror("router: socket");
			continue;
		}

		if (connect(sockfd, p->ai_addr, p->ai_addrlen) == -1) {
			close(sockfd);
			perror("router: connect");
			continue;
		}

		break;
	}

	if (p == NULL) {
		fprintf(stderr, "router: failed to connect\n");
		return 2;
	}

	inet_ntop(p->ai_family, get_in_addr((struct sockaddr *)p->ai_addr),
			s, sizeof s);
	printf("router: connecting to %s\n", s);

	freeaddrinfo(servinfo); // all done with this structure
	
	if ((numbytes = recv(sockfd, buf, MAXDATASIZE-1, 0)) == -1) {
	    perror("recv");
	    exit(1);
	}

	buf[numbytes] = '\0';

	printf("router: received '%s'\n",buf);

	close(sockfd);

	return 0;
	
}

