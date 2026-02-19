// Producer
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include "shm_com2.h"
int main(void)
{
    int running = 1;
    void *shared_memory = NULL;
    struct shared_use_st *shared_stuff;
    char buffer[BUFSIZ];
    int shmid;
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
    printf("Producer: memory attached at %p\n", shared_memory);
    shared_stuff = (struct shared_use_st *)shared_memory;
    while (running) {
        while (shared_stuff->written_by_you == 1) {
            sleep(1);
            printf("Producer waiting for consumer…\n");
        }
        printf("Enter some text: ");
        fgets(buffer, BUFSIZ, stdin);
        strncpy(shared_stuff->some_text, buffer, TEXT_SZ);
        shared_stuff->written_by_you = 1;
        if (strncmp(buffer, "end", 3) == 0)
            running = 0;
    }
    if (shmdt(shared_memory) == -1)
    perror("shmdt");
    return 0;
}