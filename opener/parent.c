#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
int main()
{
  int fd = open("in.txt", O_RDONLY);
  int flags = fcntl(fd, F_GETFD);
  fcntl(fd, F_SETFD, flags & ~FD_CLOEXEC); // inherit across exec
  execl("./child", "./child", NULL);
}
