#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

/**
 *  PARAM:
 * RETURN:
 *   FUNC:
 */
char * get_num_nodes(FILE * file)
{
	char *line = NULL;
 	fscanf(file, "%s", &line);

	return line;
}

/**
 *  PARAM:
 * RETURN:
 *   FUNC:
 */
int index_of_int(int * arr, int toFind) 
{
	int len = length(arr);
	int i;
	for (i=1; i<len; i++)
	{
		if (arr[i] == toFind)
			return i;
	}

	return -1;
}

/**
 *  PARAM:
 * RETURN:
 *   FUNC:
 */
int length(int * arr)
{
	int len = arr[0];
	return len;
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
	fscanf(file, "%s", &num);

	while (!feof(file))
	{
		fscanf(file, "%s", &num);
		fscanf(file, "%s", &num);
		fscanf(file, "%s", &num);
		num_lines++;
	}
	rewind(file);
	return num_lines;
}
