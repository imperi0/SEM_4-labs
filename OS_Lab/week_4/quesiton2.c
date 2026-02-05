#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    pid_t pid;

    pid = fork();

    if (pid == 0) {
        execl("./out1", "ouput1", NULL);
    } else if (pid > 0) {
        wait(NULL);
        printf("Parent process finished\n");
    } else {
        printf("Fork failed\n");
    }

    return 0;
}

