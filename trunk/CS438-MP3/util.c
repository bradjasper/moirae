#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

/**
 *  PARAM: 	file - FILE * to the file being read
 * RETURN: 	char * of the first line of file
 *   FUNC:	Given the first input file, gets and returns
 *			the number of nodes for it.
 */
char * get_num_nodes(FILE * file)
{
	char *line = NULL;
 	fscanf(file, "%s", &line);

	return line;
}

/**
 *  PARAM:	arr - array of ints
 *			toFind - int to find in arr
 * RETURN:  if found, index of toFind in arr; else -1
 *   FUNC:  Checks if toFind exists in arr. If it does,
 *			return the index. Otherwise, -1.
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
 *  PARAM: arr - array of ints
 * RETURN: length of the array
 *   FUNC: Assuming arrays have their length at index 0,
 *			return the length of the array.
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

/**
 *  PARAM:
 * RETURN:
 *   FUNC:
 */
void print_int_array(int * arr)
{
	int len = arr[0];
	int i;
	for (i=0; i<len; i++)
	{
		printf("%d,\n", arr[i]);
	}
}

