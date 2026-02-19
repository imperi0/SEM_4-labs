#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

#include <string.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/wait.h>
#include "shm_com.h"

int main()
{
    void *shared_memory = NULL;
    struct shared_use_st *shared_stuff;
    int shmid;
    pid_t pid;

    shmid = shmget((key_t)1234, sizeof(struct shared_use_st), 0666 | IPC_CREAT);
    if (shmid == -1) {
        perror("shmget");
        exit(EXIT_FAILURE);
    }

    shared_memory = shmat(shmid, NULL, 0);
    if (shared_memory == (void *)-1) {
        perror("shmat");
        exit(EXIT_FAILURE);
    }

    shared_stuff = (struct shared_use_st *)shared_memory;
    shared_stuff->written_by_you = 0;

    pid = fork();

    if (pid < 0) {
        perror("fork");
        exit(EXIT_FAILURE);
    } 
    
    if (pid > 0) {
        char input;
        printf("Parent: Enter alphabet: ");
        scanf(" %c", &input);

        shared_stuff->alphabet = input;
        shared_stuff->written_by_you = 1;

        while (shared_stuff->written_by_you == 1) {
            usleep(100);
        }
        printf("Parent: Child replied with: %c\n", shared_stuff->alphabet);
        wait(NULL);
        if (shmdt(shared_memory) == -1) {
            perror("In shmdt");
        }
        if (shmctl(shmid, IPC_RMID, 0) == -1) {
            perror("iN shmctl");
        }
    } 
    else {
        while (shared_stuff->written_by_you == 0) {
            usleep(100);
        }

        shared_stuff->alphabet = shared_stuff->alphabet + 1;
        shared_stuff->written_by_you = 0;

        if (shmdt(shared_memory) == -1) {
            perror("shmdt");
            exit(EXIT_FAILURE);
        }
        exit(EXIT_SUCCESS);
    }

    return 0;
}