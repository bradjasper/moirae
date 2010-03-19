/*									tab:8
 *
 * mp2.c - source code for read refragmentation and logging
 *
 * "Copyright (c) 2001 by Steven S. Lumetta."
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement is
 * hereby granted, provided that the above copyright notice and the following
 * two paragraphs appear in all copies of this software.
 * 
 * IN NO EVENT SHALL THE AUTHOR OR THE UNIVERSITY OF ILLINOIS BE LIABLE TO 
 * ANY PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL 
 * DAMAGES ARISING OUT  OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, 
 * EVEN IF THE AUTHOR AND/OR THE UNIVERSITY OF ILLINOIS HAS BEEN ADVISED 
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * THE AUTHOR AND THE UNIVERSITY OF ILLINOIS SPECIFICALLY DISCLAIM ANY 
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE 
 * PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND NEITHER THE AUTHOR NOR
 * THE UNIVERSITY OF ILLINOIS HAS NO OBLIGATION TO PROVIDE MAINTENANCE, 
 * SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS."
 *
 * Author:	    Steve Lumetta
 * Version:	    1
 * Creation Date:   Mon Sep  3 16:31:22 2001
 * Filename:	    mp2.c
 * History:
 *	SL	1	Mon Sep  3 16:31:22 2001
 *		First written.
 *	Feb 5 2009	by kung
 *	* read 	"mp2param" for 3 parameters
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stropts.h>
//#include <sys/conf.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#include "mp2.h"


#define BUF_SIZE     20000         /* limit on buffered data */
#define DEFAULT_SEED 0x18245189    /* default random seed    */
#define SEED_FILE    "mp2param"        /* random seed file name  */
#define RESULTS_FILE "mp2_results" /* file name for results  */

// add by Luchuan Kung
// by default channel is perfect
int gl_drop = 0;
int gl_garble = 0;

static void init_mp2_seed ();
static void record_results (int bytes);

//added by Farhana Ashraf
ssize_t mp2_sendto (int sockfd, void *buff, size_t nbytes, int flags, const struct sockaddr *to, socklen_t addrlen)
{
	static int first_time = 1;
	char charBuff[nbytes + 1];
	memcpy(charBuff, buff, nbytes);
	int percentage = (random() % 100) + 1;

	if( first_time) {
		init_mp2_seed();
		first_time = 0;
	}

	/*Input argument checking to help debugging*/	
	if(sockfd < 0)
	{
		fprintf(stderr, "Socket descriptor %d passed to mp2_sendto\n", sockfd);
		exit(3);
	}
	if(buff == NULL)
	{
		fprintf(stderr, "Null buffer passed to mp2_sendto.\n");
		exit(3);
	}
	if(nbytes < 0)
	{
		fprintf(stderr, "Negative bytes %d requested to mp2_sendto.\n", nbytes);
		exit(3);
	}
	if(nbytes == 0)
	{
		fprintf(stderr, "Warning: Zero bytes requested to mp2_sendto.\n");
		return 0;
	}
	
	if (percentage <= gl_drop) // drop message
	{
		//do nothing
		printf("message dropped.\n");
		return 0;
	}
	else if (percentage <= gl_garble)	//garble a random byte of the buff
	{
		printf("message garbled\n");
		//choose a single byte to garble
		int tochg = random() % nbytes;
		unsigned char randbyte = (unsigned char)(random() & 0xff);
		charBuff[tochg] = charBuff[tochg] ^ randbyte; 
	}
	return sendto (sockfd, &charBuff, nbytes, 0, to, addrlen);
}

ssize_t 
mp2_read (int fildes, void* buf, size_t nbyte)
{
    static int first_call = 1, buf_cnt = 0, mp2_fd = -1;
    static unsigned char local_buf[BUF_SIZE];
    int n_read, avail, amt;

    /* Input argument checking, to help with debugging. */
    if (fildes < 0) {
	fprintf (stderr, "File descriptor %d passed to mp2_read.\n",
		 fildes);
	exit (3);
    }
    if (buf == NULL) {
	fputs ("Null buffer passed to mp2_read.\n", stderr); 
	exit (3);
    }
    if (nbyte < 0) {
	fprintf (stderr, "Negative bytes (%d) requested from mp2_read.\n",
		 nbyte);
	exit (3);
    }
    if (nbyte == 0) {
	fputs ("Warning: Zero bytes requested from mp2_read.\n", stderr);
	return 0;
    }

    if (first_call) {
	/* Record file descriptor. */
	mp2_fd = fildes;
	/* Initialize random seed. */
	init_mp2_seed ();
	first_call = 0;
    } else if (fildes != mp2_fd) {
	fputs ("mp2_read called on more than one descriptor!\n", stderr);
	fprintf (stderr, "   (first on %d, last on %d)\n", mp2_fd,
		 fildes);
	exit (3);
    }

    /* Loop until we're ready to return some data. */
    while (1) { 

	/* Check for available bytes. */
        if (ioctl (fildes, I_NREAD, &avail) == -1) {
	    perror ("ioctl to read available bytes");
	    exit (3);
	}

	/* Wait for more data to arrive.  We can only wait forever 
	   (as might occur with read) if the local buffer is empty, as 
	   we might otherwise break external synchronization strategies.
	   We thus only call read if the local buffer is empty or data
	   are available. */
	if (buf_cnt == 0 || avail > 0) {

	    /* Read data. */
	    if ((n_read = read (fildes, local_buf + buf_cnt, 
				BUF_SIZE - buf_cnt)) < 0) {
		/* error condition--just return it */
		return n_read;
	    }

	    /* If buffer started out empty, but we received something from
	       read, wait a while for more data. */
	    if (buf_cnt == 0 && n_read > 0) {
		buf_cnt += n_read;
		usleep (500);//normally 500000  
		continue;
	    }

	    buf_cnt += n_read;
        }

	break;
    }

    /* Time to return some data.  The buffer can only be empty if
       it started out empty and read returned 0, in which case (and
       only in which case) we should now return 0, indicating that
       the other side has closed the TCP connection. */
    if (buf_cnt == 0) {
	record_results (0);
	return 0;
    }

    /* Pick uniform random amount from smaller of available and requested 
       sizes, record the amount returned, and copy the data into the buffer 
       provided. */
    amt = (random () % (buf_cnt < nbyte ? buf_cnt : nbyte)) + 1;
    record_results (amt);
    memcpy (buf, local_buf, amt);

    /* Move remaining data forward in the buffer (a cyclic buffer would 
       be more efficient).  Need to be safe about copying order, so use 
       memmove rather than memcpy. */
    memmove (local_buf, local_buf + amt, buf_cnt - amt);
    buf_cnt -= amt;

    return amt;
}


static void
init_mp2_seed (void)
{
    unsigned int seed = DEFAULT_SEED;
    FILE* seed_file;
    int result;

    /* Read random seed (or use default). */
    if ((seed_file = fopen (SEED_FILE, "r")) != NULL) {
	if ((result = fscanf (seed_file, "%u %d %d", &seed, &gl_drop, &gl_garble)) == -1)
	    perror ("warning: bad mp2param file");
	else if (result == 0)
	    fputs ("warning: empty mp2param file", stderr);
	printf("mp2_read: setting seed=%u drop=%d%% garble=%d%%\n", seed, gl_drop, gl_garble); 
	fclose (seed_file);
    }
    else {
    	perror("warning: parameter file mp2param is not found!");
    }

    /* Initialize pseudo-random number generator. */
    srandom (seed);
}


static void
record_results (int bytes)
{
    static int n_calls = 0; /* number of calls to mp2_read */
    static int n_bytes = 0; /* number of bytes returned    */
    FILE* results;

    n_calls++;
    n_bytes += bytes;

    if ((results = fopen (RESULTS_FILE, "w")) == NULL) {
	perror ("fopen results file");
	exit (3);
    }
    fprintf (results, "%d bytes returned to %d calls.\n", n_bytes, n_calls);
    if (fclose (results) == EOF) {
	perror ("fclose results file");
	exit (3);
    }
}
