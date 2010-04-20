/**
 * parser.c
 *
 * Contains functions necessary in parsing the arguments into manager.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

#include "util.c"
#include "node.c"

/**
 *  PARAM:
 * RETURN:
 *   FUNC:
 */
void create_node(struct node *topology, int line_nums, int index,
					int src_node, int dest_node, int cost) 
{
	struct node n;
	
	n.node_num = src_node;

	n.arr_length = line_nums;

	n.curr_index = 1;

	n.destin = malloc(line_nums * sizeof(int));
	n.destin[0] = dest_node;
	
	n.costs = malloc(line_nums * sizeof(int));
	n.costs[0] = cost;

	topology[index] = n;
}

// temporary main to test parser
int main(int argc, char *argv[])
{
	if (argc != 2)
	{
		fprintf(stderr, "usage: parser <filename.txt>\n");
		exit(1);
	}

	// open file for reading
	FILE * fp = fopen(argv[1], "r");
	if (fp == NULL)
	{
		printf("parser: file open error\n");
		exit(1);
	}

	// get number of lines
	int num_lines = get_num_lines(fp);

	// get number of nodes
	char *c_num_nodes = get_num_nodes(fp);	
	int num_nodes = atoi((char*)&c_num_nodes);
	
	// for each node, make a node struct
	struct node * topology[num_nodes+1];
	int j;
	for(j=0; j<(num_nodes+1); j++)
	{
		struct node * n;
		n->node_num = -1;
		n->arr_length = -1;
		n->curr_index = -1;
		n->destin = NULL;
		n->costs = NULL;
		topology[j] = n;
	}

	int * knownNodes = malloc((num_nodes+1) * sizeof(int));
	for(j=0; j<num_nodes+1; j++)
		knownNodes[j] = -1;
	knownNodes[0] = num_nodes;
	
	char *c_src = NULL;
	char *c_dest = NULL;
	char *c_cost = NULL;
	int src, dest, cost;
	int index = 1;
	int ind_of_int = -1;
	while (!feof(fp))
	{
		fscanf(fp, "%s", &c_src);
		fscanf(fp, "%s", &c_dest);
		fscanf(fp, "%s", &c_cost);

		src = atoi((char*)&c_src);
		dest = atoi((char*)&c_dest);
		cost = atoi((char*)&c_cost);

		if (ind_of_int = index_of_int(knownNodes, src) != -1)
		{
			struct node *n = topology[ind_of_int];
			n->destin[n->curr_index] = dest;
			n->costs[n->curr_index] = cost;
			n->curr_index++;
		}
		else
		{
			knownNodes[index] = src;

			struct node *n = initNode(src, num_lines, index, dest, cost);

			printf("NEW NODE!!!!!!!!!!!!!!\n");
			print_node(n);
			topology[index] = n;

			printf("%d\n", knownNodes[index]);
			index++;
		}
		//printf("%d %d %d\n", src, dest, cost);
	}

	for(j=1; j<(num_nodes); j++)
	{
		print_node(topology[j]);
	}

	return 1;
}

