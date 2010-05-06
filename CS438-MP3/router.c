/** 
 * router.c
 *
 * Part of code as copied from Beej's tutorial example
 */

#include "mp3.h"

#define PORT "3577" // the port client will be connecting to 
#define MAXDATASIZE 1000 // max number of bytes we can get at once 
 
 
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



int executeRouter(char * ptcl)
{
	int sockfd, numbytes;  
	char buf[MAXDATASIZE];
	struct addrinfo hints, *servinfo, *p;
	int rv;
	char s[INET6_ADDRSTRLEN];
	int yes = 1;

	memset(&hints, 0, sizeof hints);
	hints.ai_family = AF_UNSPEC;
	hints.ai_socktype = SOCK_STREAM;
	
	char * hostname;
	int len;
	int protocol = 0;
	sscanf(ptcl, "%d", &protocol);
	
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
		
		if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &yes,
				sizeof(int)) == -1) {
			perror("manager: setsockopt");
			exit(1);
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
	//printf("router: connecting to %s\n", s);

	freeaddrinfo(servinfo); // all done with this structure
	
	char port[4];
	sprintf(port, "%d", getpid()%4096);
	
	//send port number to manager process
	if (send(sockfd, port, sizeof(port), 0) == -1) {
		perror("router: send");
		exit(1);
	}
	
	//receive ID and connections table assigned to the node
	if ((numbytes = recv(sockfd, buf, MAXDATASIZE-1, 0)) == -1) {
	    perror("router: recv");
	    exit(1);
	}

	struct node * connectTable;
	connectTable = (struct node *) buf;
	printf("router: received '%d'\n", connectTable->node_num);
	print_node(connectTable);
	
	//execute protocol chosen by user
	if(!strncmp(ptcl, "1", 1)) {
		lsRouting(connectTable);
	}
	else if (!strncmp(ptcl, "2", 1)) {
		dvRouting(connectTable);
	}
	else {
		printf("Abort: specified number doesn't correspond to any protocol execution (1 for link state, 2 for distance vector). Please try again later\n");
	}
	

	close(sockfd);
	exit(0);

	return 0;
	
}

