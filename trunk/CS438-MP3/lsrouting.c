/**
 * lsrouting.c
 *
 * Link State Routing
 */

 #include "mp3.h"


/**
 *  PARAM:  packet - lsp for source node
 * RETURN:  lsRoutingTable *
 *   FUNC:	initializes an lsRoutingTable
 */
lsRoutingTable * initLsRoutingTable(lsp * packet)
{
	lsRoutingTable *lsRT = (lsRoutingTable*)malloc(sizeof(lsRoutingTable) + sizeof(lsp));

	lsRT->source_id = packet->creator_id;
	lsRT->num_packets = 1;
	lsRT->known_packets = (lsp*)malloc(sizeof(lsp));
	lsRT->known_packets[0] = *packet;

	return lsRT;
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
vector * initVector(int nearby, int price, int port_num)
{
	vector * vec = (vector*)malloc(sizeof(vector));

	vec->neighbor = nearby;
	vec->cost = price;
	vec->port = port_num;

	return vec;
}

/**
 *  PARAM:  
 * RETURN:  
 *   FUNC:	
 */
void freeLsp(lsp * packet)
{
	int vec_len = packet->num_neighbors;
	vector *neighbors = packet->neighbors;

	int i;
	for (i=0; i<vec_len; i++)
	{
		free(&neighbors[i]);
	}
	
	free(neighbors);
	neighbors = NULL;	
}

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

