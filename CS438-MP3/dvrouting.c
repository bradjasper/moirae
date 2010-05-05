/**
 * dvrouting.c
 *
 * Distance Vector Routing
 */

 #include "mp3.h"
 
 #define MAXDATASIZE 1000
 
 int seqNum = 0;
 
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

	memset(&hints, 0, sizeof hints);
	hints.ai_family = AF_UNSPEC;
	hints.ai_socktype = SOCK_DGRAM;

	int i = 0;
	for (i = 0; i < (table->numNeighbors); i++) {

	memset(tempPort, 0, sizeof(tempPort));
	sprintf(tempPort, "%d", connectTable->ports[i]);

	if ((rv = getaddrinfo(hostname, tempPort, &hints, &servinfo)) != 0) {
		fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(rv));
		return;
	}

	// loop through all the results and make a socket
	for(p = servinfo; p != NULL; p = p->ai_next) {
		if ((sockfd = socket(p->ai_family, p->ai_socktype,
				p->ai_protocol)) == -1) {
			perror("talker: socket");
			continue;
		}
		break;
	}

	if (p == NULL) {
		fprintf(stderr, "talker: failed to bind socket\n");
		return;
	}

	if ((numbytes = sendto(sockfd, packet, sizeof(packet), 0,
			 p->ai_addr, p->ai_addrlen)) == -1) {
		perror("talker: sendto");
		exit(1);
	}

	freeaddrinfo(servinfo);

	printf("talker: sent %d bytes to %d\n", numbytes, connectTable->ports[i]);
	close(sockfd);
	}
 }
 
 
 //**************************************************************
 void dvRouting(struct node * connectTable)
 {
	char hostname[32];
	int len = 32;
	
	if(gethostname(hostname, len) != 0) {
		perror("router: gethostname error\n");
		return;
	}
 
	dvRoutingTable * table;
	table = initDVroutingTable(connectTable);

	updateExchange(table, connectTable, hostname);

	printRoutingTable(table);

 }
 
 
