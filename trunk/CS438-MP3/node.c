/**
 * node.c
 *
 * Variables and functions representing a node
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

struct node {
	int node_num;
	int arr_length;
    int curr_index;
	int *destin;
    int *costs;
    int *ports;
} node;

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
	
	int j;
	for(j=0; j<arr_l; j++)
	{
		n->destin[j] = -1;
		n->costs[j] = -1;
	}

	n->costs[0] = cost;
	n->destin[0] = dest;	
	
	return n;

}

/**
 *	 PARAM:	n - pointer to a node struct
 * 			dest - int to find in n
 *	RETURN: int - 1 if dest exists in n->destin;
 *			else 0
 * 	  FUNC: Determines if dest exists in the destin
 *			array of n
 */
int existsInDestin(struct node *n, int dest)
{
	int *destins = n->destin;
	int len = n->arr_length;
	int i;
	for (i=0; i<len; i++)
	{
		if (destins[i] == dest)
			return 1;
	}
	return 0;
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
	printf("Destination Node, Cost\n");

	int i;
	for(i=0; i<n->arr_length; i++)
	{
		printf("%d, %d\n", n->destin[i], n->costs[i]);
	}

}

