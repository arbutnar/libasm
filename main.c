#include "src/libasm.h"
#include <fcntl.h>
#include <string.h>

int main()
{
	int		fd;
	char	*buf;
	size_t	count;

	if ((fd = open("utils/util.txt", O_RDWR)) == -1)
		return (1);
	buf = "Testing assembly ft_write function.\n";
	count = strlen(buf);		// this will be ft_strlen

	ft_write(fd, buf, count);
	return (0);
}

// i want the test to be more interactive
// by running test it will prompt user to decide wat 