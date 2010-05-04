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


// lsrouting.c
typedef struct {
	int neighor;
	int cost;
} vector;

typedef struct {
	int creator_id;
	vector * neighbors;
	int seq_num;
	int ttl;
} lsp;

lsp * initLsp(int maker, int sequence, int lifetime);
vector * initVector(int nearby, int price);

void freeLsp(lsp * packet);


//dvrouting.c
typedef struct {
	int numNodes;
	int numNeighbors;
	int * nextHop;
	int * linkCost;
} dvRoutingTable; //routing table at each node

typedef struct {
	int source;
	int dest;
	int seq_num;
	int ttl;
	int * path;	//path traversed
	char * data;
} dv; //packet format



// parser.c
int get_num_lines(FILE * file);

struct node *parse(char * file);


// node.c
struct node {
	int node_num;	//node ID
	int arr_length;	//number of nodes on the network
    int curr_index;	//number of neighbors 
	int *destin;	//list of neighbors
    int *costs;		//list of link costs
    int *ports;		//list of port number for each neighbor
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
