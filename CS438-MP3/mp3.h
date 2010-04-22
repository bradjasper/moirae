/**
 * mp3.h
 * 
 * List of functions for all .c files
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/wait.h>
#include <signal.h>

// parser.c
int get_num_lines(FILE * file);

struct node *parse(char * file);

// node.c
struct node {
	int node_num;
	int arr_length;
    int curr_index;
	int *destin;
    int *costs;
    int *ports;
} node;

struct node *initNode(int node, int arr_l, int cur_i,
						int dest, int cost);

void addNode(struct node * topology, int src, int dest, int cost);

void assignPorts(struct node * topology, int src, int port);

void print_node(struct node * n);

// router.c
void sigchld_handler(int s);

void *get_in_addr(struct sockaddr *sa);

int executeRouter();
