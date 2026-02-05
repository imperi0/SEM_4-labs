#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>

int main() {
    pid_t pid;

    pid = fork();

    if (pid == 0) {
        printf("Child process\n");
		printf("Child PID : %d\n", getpid());
		exit(0);
    } else {
        printf("Parent sleeping\n");
		printf("Parent PID : %d\n", getpid());
        sleep(10);
        printf("Parent exiting\n");
    }

    return 0;
}



// Zombie process is a process in which the child exited but the parent didnt collect the exit status of the child 
