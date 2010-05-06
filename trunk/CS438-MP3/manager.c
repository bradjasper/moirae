/** 
 * manager.c
 *
 * Contains the "main" function for mp3 program
 * Calls on parser.c to retrieve the number of nodes and network layout info
 * Creates a new process for each router on the network and calls on router.c
 * to execute the router functionality
 *
 */

#include "mp3.h"

#define PORT "3577"  // the port users will be connecting to

#define BACKLOG 10	 // how many pending connections queue will hold
#define MAXDATASIZE 100


int main(int argc, char *argv[])
{
	//check for correct number of arguments received from command line
	//there should be 4 arguments
	if (argc != 5) {
		fprintf(stderr,"usage: <protocol> <topology file> <source file> <update file>\n");
		exit(1);
	}
	
	//parse the network structure information from the file
	struct node * topology = parse(argv[2]);
	int numNodes = (topology[0]).arr_length;
	
	
	int sockfd, new_fd;  // listen on sock_fd, new connection on new_fd
	struct addrinfo hints, *servinfo, *p;
	struct sockaddr_storage their_addr; // connector's address information
	socklen_t sin_size;
	struct sigaction sa;
	int yes = 1;
	char s[INET6_ADDRSTRLEN];
	int rv;
	int numbytes;
	char buf[MAXDATASIZE];

	memset(&hints, 0, sizeof hints);
	hints.ai_family = AF_UNSPEC;
	hints.ai_socktype = SOCK_STREAM;
	hints.ai_flags = AI_PASSIVE;

	if ((rv = getaddrinfo(NULL, PORT, &hints, &servinfo)) != 0) {
		fprintf(stderr, "manager: getaddrinfo error: %s\n", gai_strerror(rv));
		return 1;
	}	
	
	// loop through all the results and bind to the first we can
	for(p = servinfo; p != NULL; p = p->ai_next) {
		if ((sockfd = socket(p->ai_family, p->ai_socktype,
				p->ai_protocol)) == -1) {
			perror("manager: socket");
			continue;
		}
	
		if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &yes,
				sizeof(int)) == -1) {
			perror("manager: setsockopt");
			exit(1);
		}

		if (bind(sockfd, p->ai_addr, p->ai_addrlen) == -1) {
			close(sockfd);
			perror("manager: bind");
			continue;
		}
		break;
	}

	if (p == NULL)  {
		fprintf(stderr, "manager: failed to bind\n");
		return 2;
	}

	freeaddrinfo(servinfo); // all done with this structure

	if (listen(sockfd, BACKLOG) == -1) {
		perror("manager: listen");
		exit(1);
	}

	sa.sa_handler = sigchld_handler; // reap all dead processes
	sigemptyset(&sa.sa_mask);
	sa.sa_flags = SA_RESTART;
	if (sigaction(SIGCHLD, &sa, NULL) == -1) {
		perror("manager: sigaction");
		exit(1);
	}

	printf("manager: waiting for connections...\n");

	//spawn a new process for each router
	int i = 0;
	for(i = 0; i < numNodes; i++) {
		if (!fork()) 
			{ // this is the child router process
				executeRouter(argv[1]);
			}
	}

	//TODO: what does this do?
	int sockArray[numNodes];
	for (i = 0; i < numNodes; i++){
		sin_size = sizeof their_addr;
		new_fd = accept(sockfd, (struct sockaddr *)&their_addr, &sin_size);
		if (new_fd == -1) {
			perror("manager: accept");
			continue;
		}
		else {
			sockArray[i] = new_fd;
		}

		inet_ntop(their_addr.ss_family,
			get_in_addr((struct sockaddr *)&their_addr),
			s, sizeof s);
		//printf("manager: got connection from %s\n", s);

		if ((numbytes = recv(new_fd, buf, MAXDATASIZE-1, 0)) == -1) {
			perror("router: recv");
			exit(1);
		}
		buf[numbytes] = '\0';
		//assignPorts(topology, i, atoi(buf));
	}
	
	
	for (i = 0; i < numNodes; i++){
		new_fd = sockArray[i];
		if (send(new_fd, (&topology[i]), sizeof(node), 0) == -1)
			perror("manager: send");

		close(new_fd); 
	}
	
	return 0;
}


