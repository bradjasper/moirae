CC = gcc
CCOPTS = -Wall
LIBS = -lpthread

all: manager parser

manager: manager.c parser.c
	$(CC) $(CCOPTS) -g -o $@ $< $(LIBS)

parser: parser.c
	$(CC) $(CCOPTS) -g -o $@ $< $(LIBS)

clean:
	rm -rf manager parser
