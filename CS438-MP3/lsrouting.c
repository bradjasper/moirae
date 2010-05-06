/**
 * lsrouting.c
 *
 * Link State Routing
 */

#include "mp3.h"

#define MAXBUFLEN 1024

/**
 *  PARAM:  
 * RETURN:  
 *   FUNC:	
 */
lsRoutingTable * initLsRoutingTable(lsp * packet)
{
	lsRoutingTable *lsrt = (lsRoutingTable*)malloc(sizeof(lsRoutingTable));
	return lsrt;
}

/**
 *  PARAM:  maker - source node to init to
 *			sequence - number of hops to init to
 *			lifetime - time to live to init to
 * RETURN:  lsp *
 *   FUNC:	initializes an lsp
 */
lsp * initLsp(struct node * maker, int sequence, int lifetime)
{
	int num_neighbors = maker->arr_length;
	int *neighbors = maker->destin;
	int *costs = maker->costs;
	int *ports = maker->ports;

	lsp * packet = (lsp*)malloc(sizeof(lsp) + num_neighbors * sizeof(vector));

	packet->creator_id = maker->node_num;

	packet->neighbors = (vector*)malloc(num_neighbors * sizeof(vector));
	int i;
	for (i=0; i<num_neighbors; i++)
	{
		vector *vec = initVector(neighbors[i], costs[i], ports[i]);
		packet->neighbors[i] = *vec;
	}

	packet->seq_num = sequence;
	packet->ttl = lifetime;

	return packet;
}

/**
 *  PARAM:  
 * RETURN:  
 *   FUNC:	
 */
vector * initVector(int nearby, int price)
{
	vector * vec = (vector*)malloc(sizeof(vector));

	vec->neighbor = nearby;
	vec->cost = price;

	return vec;
}

/**
 *  PARAM:  
 * RETURN:  
 *   FUNC:	
 */
void freeLsp(lsp * packet)
{
	vector *neighbors = packet->neighbors;
	int vec_len = neighbors[0];

	int i;
	for (i=1; i<vec_len; i++)
	{
		free(neighbors[i]);
		neighbors[i] = NULL;
	}
	
	free(neighbors);
	neighbors = NULL;	
}

<<<<<<< .mine
/**
 *  PARAM:  
 * RETURN:  
 *   FUNC:	
 */
void freeLsRoutingTable(lsRoutingTable * lsrt)
{
	int num_packs = lsrt->num_packets;
	lsp * packets = lsrt->known_packets;
	
	int i;
	for (i=0; i<num_packs; i++)
		freeLsp(&packets[i]);
	
	free(lsrt);
}

/**
 *  PARAM:  
 * RETURN:  
 *   FUNC:	
 */
void lsRouting(struct node * a_node)
{
	char hostname[32];
	int len = 32;

	if (gethostname(hostname, len) != 0)
	{
		fprintf(stderr, "lsrouting: gethostname error\n");
		return;
	}
	
	lsp * myLsp = initLsp(a_node, -1, -1);
	lsRoutingTable * myLsrt = initLsRoutingTable(myLsp);
	print_ls_table(myLsrt);

	vector *neighbors = myLsp->neighbors;
	int num_neighbors = myLsp->num_neighbors;
	int i;
	for (i=0; i<num_neighbors; i++)
	{
		lsSend(myLsp, neighbors[i].port);
	}
}

/**
 *  PARAM:  
 * RETURN:  
 *   FUNC:	code based on Beej's code
 */
void lsSend(lsp * packet, int port_num)
{
	char hostname[32];
	int len = 32;
	
	if(gethostname(hostname, len) != 0) {
		perror("router: gethostname error\n");
		return;
	}
	
	int sockfd;
	struct addrinfo hints, *servinfo, *p;
	int rv;
	int numbytes;
	
	memset(&hints, 0, sizeof hints);
	hints.ai_family = AF_UNSPEC;
	hints.ai_socktype = SOCK_DGRAM;

	char p_num[10];
	sprintf(p_num, "%d", port_num);
	if ((rv = getaddrinfo(hostname, p_num, &hints, &servinfo)) != 0) {
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

    printf("talker: sent %d bytes to %s\n", numbytes, p_num);
    close(sockfd);
}

/**
 *  PARAM:  
 * RETURN:  
 *   FUNC:	code based on Beej's code
 */
void lsReceive(int port) 
{
	int sockfd;
	struct addrinfo hints, *servinfo, *p;
	int rv;
	int numbytes;
	struct sockaddr_storage their_addr;
	char buf[MAXBUFLEN];
	size_t addr_len;
	char s[INET6_ADDRSTRLEN];
	
	memset(&hints, 0, sizeof hints);
	hints.ai_family = AF_UNSPEC; // set to AF_INET to force IPv4
	hints.ai_socktype = SOCK_DGRAM;
	hints.ai_flags = AI_PASSIVE; // use my IP

	char p_num[10];
	sprintf(p_num, "%d", port);
	if ((rv = getaddrinfo(NULL, p_num, &hints, &servinfo)) != 0) {
		fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(rv));
		return;
	}
	
	// loop through all the results and bind to the first we can
    for(p = servinfo; p != NULL; p = p->ai_next) {
		if ((sockfd = socket(p->ai_family, p->ai_socktype,
			p->ai_protocol)) == -1) {
			perror("listener: socket");
			continue;
		}
		
		if (bind(sockfd, p->ai_addr, p->ai_addrlen) == -1) {
			close(sockfd);
			perror("listener: bind");
			continue;
		}
		
		break;
	}

	if (p == NULL) {
		fprintf(stderr, "listener: failed to bind socket\n");
		return;
	}
	
	freeaddrinfo(servinfo);
	
	printf("listener: waiting to recvfrom...\n");
	
	addr_len = sizeof their_addr;
	
	if ((numbytes = recvfrom(sockfd, buf, MAXBUFLEN-1 , 0,
		(struct sockaddr *)&their_addr, &addr_len)) == -1) {
		perror("recvfrom");
		exit(1);
	}
	
	printf("listener: got packet from %s\n",
	inet_ntop(their_addr.ss_family,
		get_in_addr((struct sockaddr *)&their_addr),
		s, sizeof s));
	printf("listener: packet is %d bytes long\n", numbytes);
	buf[numbytes] = '\0';
	printf("listener: packet contains \"%s\"\n", buf);
	
	close(sockfd);
}

/**
 *  PARAM:  
 * RETURN:  
 *   FUNC:	
 */
void print_ls_table(lsRoutingTable * lsrt)
{
	printf("*******************************\n");
	printf("Table for node: %d\n", lsrt->source_id);
	printf("destination\tneighbor\tcost\n");
	
	int i,j;
	for (i=0; i<lsrt->num_packets; i++)
	{
		lsp * cur_lsp = &(lsrt->known_packets[i]);
		
		int destin = cur_lsp->creator_id;

		int num_neighbors = cur_lsp->num_neighbors;
		vector * neighbors = cur_lsp->neighbors;
		for (j=0; j<num_neighbors; j++)
		{
			vector * vec = &neighbors[j];
			int neighbor = vec->neighbor;
			int cost = vec->cost;
			printf("%d\t%d\t%d\n", destin, neighbor, cost);
		}
	}
}

=======
>>>>>>> .r105
