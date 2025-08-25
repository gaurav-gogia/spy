#define _GNU_SOURCE
#include <fcntl.h>
#include <unistd.h>

int main()
{
    int in = open("in.txt", O_RDONLY);
    int out = open("out.txt", O_CREAT | O_WRONLY | O_TRUNC, 0644);

    int pipefd[2];
    pipe(pipefd);

    splice(in, NULL, pipefd[1], NULL, 1024, 0);
    splice(pipefd[0], NULL, out, NULL, 1024, 0);

    close(in);
    close(out);
    close(pipefd[0]);
    close(pipefd[1]);
}
