CC = gcc
CCOPTS = -Wall
LIBS = -lpthread 

all: manager

manager: manager.c 
	$(CC) $(CCOPTS) -g -o $@ $< parser.c node.c router.c dvrouting.c lsrouting.c $(LIBS)


clean:
	rm -rf manager
