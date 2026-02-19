// consumer

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include "shm_com2.h"


int main(int argc, char const *argv[])
{
    int running = 1;
    void *shared_memory = NULL;
    struct shared_use_st *shared_stuff;
    int shmid;
    shmid = shmget((key_t)1234, sizeof(struct shared_use_st), 0666 | IPC_CREAT);
    if(shmid==-1){
        perror("In shmget");
        exit(EXIT_FAILURE);
    }
    shared_memory = shmat(shmid, NULL, 0);
    if (shared_memory == (void *)-1) {
        perror("shmat");
        exit(EXIT_FAILURE);
    }
    printf("Consumer: memory attached at %p\n", shared_memory);
    shared_stuff = (struct shared_use_st *)shared_memory;
    while (running) {
        if (shared_stuff->written_by_you == 1) {
            printf("Consumer read: %s", shared_stuff->some_text);
            shared_stuff->written_by_you = 0;
            if (strncmp(shared_stuff->some_text, "end", 3) == 0)
                running = 0;
        }
        usleep(50000);
    }
    if (shmdt(shared_memory) == -1)
        perror("shmdt");
    if (shmctl(shmid, IPC_RMID, 0) == -1)
        perror("shmctl");

    return 0;
}
