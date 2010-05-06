/**
 * node.c
 *
 * Variables and functions representing a node
 */

#include "mp3.h"

/**
 *  PARAM: 	node - id of the source node to create
 *			arr_l - length of the destin and costs arrays
 *			cur_i - index of the destin and costs arrays
 *			dest - id of the destination node
 *			cost - cost from source to destin
 * RETURN:  node *
 *   FUNC:  initializes a node struct to the given params
 */
struct node *initNode(int node, int arr_l, int cur_i,
						int dest, int cost)
{

	struct node *n = malloc(sizeof(node) + (2 * (arr_l * sizeof(int))));

	n->node_num = node;
	n->arr_length = arr_l;
	n->curr_index = cur_i;
	
	n->destin = malloc(arr_l * sizeof(int));
	n->destin[0] = dest;	
	
	n->costs = malloc(arr_l * sizeof(int));
	n->costs[0] = cost;
	
	n->ports = malloc(arr_l * 6 * sizeof(int));
	
	int j;
	for(j=0; j<arr_l; j++)
	{
		n->destin[j] = -1;
		n->costs[j] = -1;
		n->ports[j] = -1;
	}

	n->costs[0] = cost;
	n->destin[0] = dest;	
	
	return n;

}

/**
 *  PARAM:  
 * RETURN:  
 *   FUNC:	
 */
void addNode(struct node * topology, int src, int dest, int cost)
{
	int item = (topology[src]).curr_index;
	(topology[src]).destin[item] = dest;	
	(topology[src]).costs[item] = cost;
	(topology[src]).curr_index ++;
}

/**
 *  PARAM:  
 * RETURN:  
 *   FUNC:	
 */
void assignPorts(struct node * topology, int src, int port)
{
	int len = (topology[0]).arr_length;
	topology[src].port = port;
	int i, k;
	int num = 0;
	for(i = 0; i < len; i++){
		num =(topology[i]).curr_index;
		for(k = 0; k < num; k++) {
			if((topology[i]).destin[k] == src)
				(topology[i]).ports[k] = port;
		}
	}
}


/**
 *  PARAM:  *n - pointer to a node
 * RETURN:  nothing
 *   FUNC:	prints the node to stdout
 */
void print_node(struct node * n)
{
	printf("**************************\n");
	if (n->node_num == -1)
	{
		printf("***EMPTY NODE***\n");
		return;
	}

	printf("Node: %d\n", n->node_num);
	printf("Src\tDest\tCost\tPort\n");

	int i;
	for(i=0; i < n->arr_length; i++)
	{
		if((n->destin[i] != -1) && (n->costs[i] != -1)) {
			printf("%d\t%d\t%d\t%d\n", n->node_num, n->destin[i], n->costs[i], n->ports[i]);
		}
	}

}
