/**
 * lsrouting.c
 *
 * Link State Routing
 */

 #include "mp3.h"

/**
 *  PARAM:  maker - source node to init to
 *			sequence - number of hops to init to
 *			lifetime - time to live to init to
 * RETURN:  lsp *
 *   FUNC:	initializes an lsp
 */
lsp * initLsp(struct node * maker, int sequence, int lifetime)
{
	int num_neighbors = maker->curr_index;
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
void lsRouting(struct node * a_node)
{
	char * hostname;
	int len;

	if (gethostname(hostname, len) != 0)
	{
		fprintf(stderr, "lsrouting: gethostname error\n");
		return;
	}


}



