#include <limits.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>

int dup2 ( int oldd, int newd )
{
	int fdbuf[ _POSIX_OPEN_MAX ];
	int i,
	    fd,
	    tmp;

	i = 0;

	/* ignore the error on the close() */
	tmp = errno;

	( void ) close( newd );

	errno = tmp;

	// "Loop dup-ing till get fd we want"
	while ( ( fd = dup( oldd ) ) != newd )
	{
		if ( fd == - 1 )
		{
			break;
		}

		fdbuf[ i++ ] = fd;
	}

	tmp = errno;

	// "Close all the fds we opened"
	while ( --i >= 0 )
	{
		close( fdbuf[ i ] );
	}

	errno = tmp;

	// "Return the fd we wanted"
	return - ( fd == -1 );
}
