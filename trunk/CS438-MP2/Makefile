CC = gcc
CCOPTS = -Wall
LIBS = -lpthread

all: mp2server mp2client mp2frame

mp2server: mp2server.c
	$(CC) -c -D __REENTRANT mp2server.c
	$(CC) $(CCOPTS) -o $@ $< $(LIBS)

mp2client: mp2client.c mp2frame.c
	$(CC) -c -D __REENTRANT mp2client.c
	$(CC) $(CCOPTS) -o $@ $< $(LIBS)

mp2frame: mp2frame.c mp2frame.h
	$(CC) -c -D __REENTRANT mp2frame.c
	$(CC) $(CCOPTS) -o $@ $< $(LIBS)

clean:
	rm -rf mp2server mp2client mp2frame
