/**
 * dvrouting.c
 *
 * Distance Vector Routing
 */

 #include "mp3.h"

 
 dvRoutingTable * initDVroutingTable(node * connectTable)
 {
	dvRoutingTable * table = (dvRoutingTable *) malloc(sizeof(dvRoutingTable));
	
	table->numNodes = connectTable->arr_length;
	table->numNeighbors = connectTable->curr_index;
	
	return table;
 }
 
 
 dv initDVpacket(node * connectTable, int des, int seq, int t)
 {
	dv packet = malloc(sizeof(dv));
	
	packet.source = connectTable->node_num;
	packet.dest = des;
	packet.seq_num = seq;
	packet.ttl = t;
	
	return packet;
 }
 
 
 void dvRouting(node * connectTable)
 {
 
 }
 
 