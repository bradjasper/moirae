/** 
 * manager.c
 *
 * The Manager takes in three file names as arguments. It then handles 
 * the madness.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

#include "parser.c"

int main(int argc, char *argv[])
{
	// check number of arguments
	if ( (argc < 3) || (argc > 3) )
	{
		fprintf(stderr, "usage: manager <file1.txt> <file2.txt> <file3.txt>");
		exit(1);
	}

	// parse file 1, read network topology description

	// fork each router, send connectivity information

	return 0;

}
