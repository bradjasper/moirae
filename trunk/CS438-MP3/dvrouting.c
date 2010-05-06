/**
 * dvrouting.c
 *
 * Distance Vector Routing
 * 
 * The file contains functions for executing distance vector routing.
 * The routing intializes routing table, established UDP connections
 * with other routers on the network and exchange network updates
 * between each other until all nodes have the most up-to-date info.
 *
 * The distance vector implementation is not finished.
 */

 #include "mp3.h"
 
 #define MAXDATASIZE 1000
 #define MAXBUFLEN 100
 
 int seqNum = 0;
 
 //**************************************************************
 //prints out the information contained in DV routing table:
 //current node ID,
 //number of nodes on the network,
 //number of neighbors,
 //next hops to the destination,
 //link costs to reach the destination
 //**************************************************************
 void printRoutingTable(dvRoutingTable * table)
 {
	printf("**************************\n");

	printf("nodeID\tnumNodes\tnumNeighbors\tnextHop\tlinkCost\n");

	int i;
	for(i=0; i < table->numNodes; i++)
	{
			printf("%d\t%d\t%d\t%d\t%d\n", table->nodeID, table->numNodes, table->numNeighbors, table->nextHop[i], table->linkCost[i]);
	}
 }

 //**************************************************************
 //initializes routing table
 //sets unknown values to -1
 //**************************************************************
 dvRoutingTable * initDVroutingTable(struct node * connectTable)
 {
	dvRoutingTable * table = (dvRoutingTable *) malloc((connectTable->curr_index) * sizeof(dvRoutingTable));
	
	table->nodeID = connectTable->node_num;
	table->numNodes = connectTable->arr_length;
	table->numNeighbors = connectTable->curr_index;
	
	table->nextHop = malloc((connectTable->arr_length) * sizeof(int));
	table->linkCost = malloc((connectTable->arr_length) * sizeof(int));
	
	int j = 0;
	for(j = 0; j < (connectTable->arr_length); j++)
	{
		table->nextHop[j] = -1;
		table->linkCost[j] = -1;
	}
	
	table->nextHop[connectTable->node_num] = connectTable->node_num;
	table->linkCost[connectTable->node_num] = 0;
	
	return table;
 }
 
 //**************************************************************
 //initializes distance vector packet based on the type of message
 //type 1 is an network routing table update message that contains
 //another node routing table that is to be used to update current
 //node routing table
 //type 2 is a data message
 //***************************************************************
 dv * initDVpacket(struct node * connectTable, dvRoutingTable * table, int type, int des, int seq)
 {
	dv * packet = malloc(sizeof(dv));
	
	packet->type = type;
	packet->source = connectTable->node_num;
	packet->dest = des;
	packet->seq_num = seq;
	packet->ttl = connectTable->arr_length;
	
	packet->path = malloc((packet->ttl) * sizeof(int));
	if(type == 1) {
		packet->data = malloc((sizeof(table)));
		packet->data = table;
	}
	else {
		packet->data = malloc(MAXDATASIZE *(sizeof(char)));
		packet->data = "Data message";
	}
	
	return packet;
 }
 
 //**************************************************************
 //establishes connections between routers
 //creates sockets and sends update messages
 //**************************************************************
 void updateExchange(dvRoutingTable * table, struct node * connectTable, char * hostname)
 {
	//initialize the update packet
	dv * packet;
	packet = initDVpacket(connectTable, table, 1, -1, seqNum);
	seqNum++;
	
	//send out updates to all neighbors
	int sockfd;
	struct addrinfo hints, *servinfo, *p;
	int rv;
	int numbytes;
	char tempPort[6];
	int yes = 1;

	memset(&hints, 0, sizeof hints);
	hints.ai_family = AF_UNSPEC;
	hints.ai_socktype = SOCK_DGRAM;

	int i = 0;
	for (i = 0; i < (table->numNeighbors); i++) {
		memset(tempPort, 0, sizeof(tempPort));
		sprintf(tempPort, "%d", connectTable->ports[i]);

		if ((rv = getaddrinfo(hostname, tempPort, &hints, &servinfo)) != 0) {
			fprintf(stderr, "router: getaddrinfo: %s\n", gai_strerror(rv));
			return;
		}

		// loop through all the results and make a socket
		for(p = servinfo; p != NULL; p = p->ai_next) {
			if ((sockfd = socket(p->ai_family, p->ai_socktype,
					p->ai_protocol)) == -1) {
				perror("router: UDP socket");
				continue;
			}
			
			if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(int)) == -1) {
				perror("manager: setsockopt");
				exit(1);
			}
		
			break;
		}

		if (p == NULL) {
			fprintf(stderr, "router: failed to bind UDP socket\n");
			return;
		}

		if ((numbytes = sendto(sockfd, packet, sizeof(packet), 0,
				 p->ai_addr, p->ai_addrlen)) == -1) {
			perror("router: UDP sendto");
			exit(1);
		}

		freeaddrinfo(servinfo);

		//printf("router: sent %d bytes to %s\n", numbytes, tempPort);

		close(sockfd);
	}
	
	//exit(0);
 }
 
 
 //**************************************************************
 //creates listening socket and receives update messages
 //**************************************************************
 void receiveUpdate(dvRoutingTable * table, struct node * connectTable, char * hostname)
 {
	char tempPort[6];
	memset(tempPort, 0, sizeof(tempPort));
	sprintf(tempPort, "%d", connectTable->ports[0]);
	
	int sockfd;
	struct addrinfo hints, *servinfo, *p;
	int rv;
	int numbytes;
	struct sockaddr_storage their_addr;
	char buf[MAXBUFLEN];
	size_t addr_len;
	//char s[INET6_ADDRSTRLEN];
	int yes = 1;

	memset(&hints, 0, sizeof hints);
	hints.ai_family = AF_UNSPEC; // set to AF_INET to force IPv4
	hints.ai_socktype = SOCK_DGRAM;
	hints.ai_flags = AI_PASSIVE; // use my IP

	if ((rv = getaddrinfo(hostname, tempPort, &hints, &servinfo)) != 0) {
		fprintf(stderr, "receiveUpdate: getaddrinfo: %s\n", gai_strerror(rv));
		return;
	}
	
	
	// loop through all the results and bind to the first we can
	for(p = servinfo; p != NULL; p = p->ai_next) {
		if ((sockfd = socket(p->ai_family, p->ai_socktype,
				p->ai_protocol)) == -1) {
			perror("receiveUpdate: socket");
			continue;
		}
		
		if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &yes,
				sizeof(int)) == -1) {
			perror("manager: setsockopt");
			exit(1);
		}

		if (bind(sockfd, p->ai_addr, p->ai_addrlen) == -1) {
			close(sockfd);
			perror("receiveUpdate: bind");
			continue;
		}

		break;
	}

	if (p == NULL) {
		fprintf(stderr, "receiveUpdate: failed to bind socket\n");
		return;
	}
	
	freeaddrinfo(servinfo);
	addr_len = sizeof their_addr;
	
	//while(1){
		if ((numbytes = recvfrom(sockfd, buf, MAXBUFLEN-1 , 0,
			(struct sockaddr *)&their_addr, &addr_len)) == -1) {
			perror("receiveUpdate: recvfrom");
			exit(1);
		}
		
		//dvRoutingTable * routingTable = (dvRoutingTable *) buf;
		//printf("receiveUpdate: %d\t%d\t%d\n", routingTable->nodeID, routingTable->numNodes, routingTable->numNeighbors);
		
	//}

	close(sockfd);
	exit(0);
 }
 
 
 //**************************************************************
 //main distance vector execution function that calls other routines
 //**************************************************************
 void dvRouting(struct node * connectTable)
 {
	char * hostname;
	int len;
	
	if(gethostname(hostname, len) != 0) {
		fprintf(stderr, "router: gethostname error\n");
		return;
	}
 
	dvRoutingTable * table;
	table = initDVroutingTable(connectTable);

	if(!fork()){	//needs to be threads
		receiveUpdate(table, connectTable, hostname);
	}
	
	updateExchange(table, connectTable, hostname);

	printRoutingTable(table);

 }

  
