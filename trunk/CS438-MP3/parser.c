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

struct node *parse(char * file)
{
	// open file for reading
	FILE * fp = fopen(file, "r");
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
	struct node *topology = malloc((num_nodes+1) * sizeof(struct node));
	int j;
	for(j=0; j<(num_nodes+1); j++)
	{
		struct node * n = initNode(-1, 0, 0, 0, 0);
		topology[j] = *n;
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

		ind_of_int = index_of_int(knownNodes, src); 
		if (ind_of_int != -1)
		{
			struct node *n = &topology[ind_of_int];
			
			if (!existsInDestin(n, dest))
			{
				n->destin[n->curr_index] = dest;
				n->costs[n->curr_index] = cost;
				n->curr_index++;
			}
		}
		else
		{
			knownNodes[index] = src;

			struct node *n = initNode(src, num_lines, 1, dest, cost);
			topology[index] = *n;

			index++;
		}
		//printf("%d %d %d\n", src, dest, cost);
	}

	return topology;
}

// temporary main to test parser
int main(int argc, char *argv[])
{
	struct node * n = parse(argv[1]);

	int j;
	for(j=0; j<(10); j++)
	{
		print_node(&n[j]);
	}


	return 0;
}
/*
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
		struct node * n = initNode(-1, 0, 0, 0, 0);
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

		ind_of_int = index_of_int(knownNodes, src); 
		if (ind_of_int != -1)
		{
			struct node *n = topology[ind_of_int];
			n->destin[n->curr_index] = dest;
			n->costs[n->curr_index] = cost;
			n->curr_index++;
		}
		else
		{
			knownNodes[index] = src;

			struct node *n = initNode(src, num_lines, 1, dest, cost);
			topology[index] = n;

			index++;
		}
		//printf("%d %d %d\n", src, dest, cost);
	}

	for(j=0; j<(num_nodes); j++)
	{
		print_node(topology[j]);
	}

	return 0;
}
*/

