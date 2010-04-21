CC = gcc
CCOPTS = -Wall
LIBS = -lpthread

all: manager

manager: manager.c parser.c node.c router.c
	$(CC) $(CCOPTS) -g -o $@ $< $(LIBS)


clean:
	rm -rf manager
