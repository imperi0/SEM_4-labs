#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main() {
    pid_t pid;

    pid = fork();

    if (pid == 0) {
        printf("Child exiting\n");
        exit(0);
    } else {
        printf("Parent sleeping\n");
        sleep(20);
        printf("Parent exiting\n");
    }

    return 0;
}



// Zombie process is a process in which the child exited but the parent didnt collect the exit status of the child 

