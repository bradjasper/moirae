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

// node.c
struct node {
	int node_num;	//node ID
	int arr_length;	//number of nodes on the network
	int curr_index;	//number of neighbors 
	int *destin;	//list of neighbors
	int *costs;	//list of link costs
	int *ports;	//list of port number for each neighbor
} node;

struct node *initNode(int node, int arr_l, int cur_i,
						int dest, int cost);

void addNode(struct node * topology, int src, int dest, int cost);

void assignPorts(struct node * topology, int src, int port);

void print_node(struct node * n);

// lsrouting.c
typedef struct {
	int neighor;
	int cost;
} vector;

typedef struct {
	int creator_id;		// source node id
	vector * neighbors;	// array of vectors for neighbors
	int num_neighbors;	// array length
	int seq_num;		// number of hops for this packet
	int ttl;		// packet's time to live
} lsp;

typedef struct {
        int source_id;
        int num_packets;
        lsp * known_packets;
} lsRoutingTable; 

lsRoutingTable initLsRoutingTable(lsp * packet);
lsp * initLsp(int maker, int sequence, int lifetime);
vector * initVector(int nearby, int price);

void freeLsp(lsp * packet);

void lsSend(lsp * packet, int port);
void lsReceive(int port);

void print_ls_table(lsRoutingTable * lsrt);

// parser.c
int get_num_lines(FILE * file);

struct node *parse(char * file);

// router.c
void sigchld_handler(int s);

void *get_in_addr(struct sockaddr *sa);

int executeRouter();


//dvrouting.c
typedef struct {
	int nodeID;
	int numNodes;
	int numNeighbors;
	int * nextHop;
	int * linkCost;
} dvRoutingTable; //routing table at each node

typedef struct {
	int type;		//type of message: 1 for network update, 2 for data
	int source;
	int dest;		//-1 for network update, nodeID for data packet destination
	int seq_num;
	int ttl;
	int * path;		//path traversed
	void * data;	//dvRoutingTable* for network update, char* for data
} dv; //packet format

void printRoutingTable(dvRoutingTable * table);

dvRoutingTable * initDVroutingTable(struct node * connectTable);

dv * initDVpacket(struct node * connectTable, dvRoutingTable * table, int type, int des, int seq);

void updateExchange(dvRoutingTable * table, struct node * connectTable, char * hostname);

void dvRouting(struct node * connectTable);

