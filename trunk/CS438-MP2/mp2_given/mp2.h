/*									tab:8
 *
 * mp2.h - header file for read refragmentation and logging
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
 * Creation Date:   Mon Sep  3 16:32:49 2001
 * Filename:	    mp2.h
 * History:
 *	SL	1	Mon Sep  3 16:32:49 2001
 *		First written.
 */

#if !defined(MP2_H)
#define MP2_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <sys/types.h>

ssize_t mp2_read (int fildes, void* buf, size_t nbyte);
ssize_t mp2_sendto (int sockfd, void *buff, size_t nbytes, int flags, const struct sockaddr *to, socklen_t addrlen);

#ifdef  __cplusplus
}
#endif

#endif /* MP2_H */
