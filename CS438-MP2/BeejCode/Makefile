TARGETS=client server listener talker

CC=gcc
CCOPTS=-Wall

.PHONY: all clean

all: $(TARGETS)

clean:
	rm -f $(TARGETS)

%: %.c 
	$(CC) $(CCOPTS) -o $@ $<

