CC = gcc
CCOPTS = -Wall
LIBS = -lpthread

all: mp2server mp2client

mp2server: mp2server.c
	$(CC) $(CCOPTS) -g -o $@ $< $(LIBS)

mp2client: mp2client.c mp2frame.h
	$(CC) $(CCOPTS) -g -o $@ $< $(LIBS)

clean:
	rm -rf mp2server mp2client
