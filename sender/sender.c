#include <fcntl.h>
#include <sys/sendfile.h>
#include <unistd.h>

int main()
{
  int in = open("in.txt", O_RDONLY);
  int out = open("out.txt", O_CREAT | O_WRONLY | O_TRUNC, 0644);
  off_t offset = 0;
  sendfile(out, in, &offset, 1024);
  close(in);
  close(out);
}
