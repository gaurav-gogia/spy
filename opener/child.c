#include <unistd.h>
#include <fcntl.h>
#include <sys/sendfile.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
    int in_fd = (argc > 1) ? atoi(argv[1]) : 3;

    int out = open("out.txt", O_CREAT | O_WRONLY | O_TRUNC, 0644);
    off_t offset = 0;
    sendfile(out, in_fd, &offset, 1024);
    close(out);
}
