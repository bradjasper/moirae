/**
 * lsrouting.c
 *
 * Link State Routing
 */

 #include "mp3.h"

/**
 *  PARAM:  
 * RETURN:  
 *   FUNC:	
 */
lsp * initLsp(int maker, int sequence, int lifetime)
{
	lsp * packet = (lsp*)malloc(sizeof(lsp));

	packet->creater_id = maker;
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

