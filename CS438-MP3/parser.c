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

#include "node.c"



/**
 *  PARAM: 	file - FILE * to the file being read
 * RETURN: 	char * of the first line of file
 *   FUNC:	Given the first input file, gets and returns
 *			the number of nodes for it.
 */
char * get_num_nodes(FILE * file)
{
	char *line = NULL;
 	fscanf(file, "%s", line);

	return line;
}



/**
 *  PARAM:
 * RETURN:
 *   FUNC:
 */
int get_num_lines(FILE * file)
{
	rewind(file);
	int num_lines = 1;
	char *num = NULL;
	fscanf(file, "%s", num);

	while (!feof(file))
	{
		fscanf(file, "%s", num);
		fscanf(file, "%s", num);
		fscanf(file, "%s", num);
		num_lines++;
	}
	rewind(file);
	return num_lines;
}


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
	struct node *topology = malloc((num_nodes) * sizeof(struct node));
	int j;
	for(j=0; j<(num_nodes); j++)
	{
		struct node * n = initNode(j, num_lines, 0, 0, 0);
		topology[j] = *n;
	}

	char *c_src = NULL;
	char *c_dest = NULL;
	char *c_cost = NULL;
	int src, dest, cost;
	while (!feof(fp))
	{
		fscanf(fp, "%s", c_src);
		fscanf(fp, "%s", c_dest);
		fscanf(fp, "%s", c_cost);

		src = atoi((char*)&c_src);
		dest = atoi((char*)&c_dest);
		cost = atoi((char*)&c_cost);

		addNode(topology, src, dest, cost);
		addNode(topology, dest, src, cost);
	}

	return topology;
}
