/////////////////////////////////////////////////////////////////////

General

/////////////////////////////////////////////////////////////////////

March 19, 2010
CS438 - MP2

Nadia Tkach - ntkach2
Joseph Subida - jsubida2

mp2server:
mp2server waits for incoming connections. Upon receiving a connection,
the server sends the file via frames. See the design document for 
the header format.

mp2client:
mp2client establishes a connection with the host. It sends a message
to the server, stating that it is beginning. The client then waits
to receive data from the server. 

/////////////////////////////////////////////////////////////////////

Zip Contents

/////////////////////////////////////////////////////////////////////

* README.txt
* PARTNERS
* Makefile
* mp2.c
* mp2.h
* mp2param
* mp2client.c
* mp2server.c

/////////////////////////////////////////////////////////////////////

Running the Program

/////////////////////////////////////////////////////////////////////

1. Compile using "make"
2. Start the server: "./mp2server <filename>"
3. Start the client: "./mp2client <host>"
