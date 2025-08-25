#define _GNU_SOURCE
#include <fcntl.h>
#include <unistd.h>

int main()
{
    int in = open("in.txt", O_RDONLY);
    int out = open("out.txt", O_CREAT | O_WRONLY | O_TRUNC, 0644);
    long off_in = 0, off_out = 0;
    copy_file_range(in, &off_in, out, &off_out, 1024, 0);
    close(in);
    close(out);
}
