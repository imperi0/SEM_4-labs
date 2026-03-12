#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

sem_t wrt;
sem_t mutex;
int readcount = 0;

void *reader(void *arg)
{
    sem_wait(&mutex);
    readcount++;
    if (readcount == 1)
        sem_wait(&wrt);
    sem_post(&mutex);

    printf("Reader is reading\n");
    sleep(1);

    sem_wait(&mutex);
    readcount--;
    if (readcount == 0)
        sem_post(&wrt);
    sem_post(&mutex);
}

void *writer(void *arg)
{
    sem_wait(&wrt);

    printf("Writer is writing\n");
    sleep(2);

    sem_post(&wrt);
}

int main()
{
    pthread_t r1, r2, r3, r4, w1, w2, w3;

    sem_init(&mutex, 0, 1);
    sem_init(&wrt, 0, 1);

    pthread_create(&r1, NULL, reader, NULL);
    pthread_create(&r2, NULL, reader, NULL);
    pthread_create(&r3, NULL, reader, NULL);
    pthread_create(&r4, NULL, reader, NULL);

    pthread_create(&w1, NULL, writer, NULL);
    pthread_create(&w2, NULL, writer, NULL);
    pthread_create(&w3, NULL, writer, NULL);

    pthread_join(r1, NULL);
    pthread_join(r2, NULL);
    pthread_join(r3, NULL);
    pthread_join(r4, NULL);

    pthread_join(w1, NULL);
    pthread_join(w2, NULL);
    pthread_join(w3, NULL);

    sem_destroy(&mutex);
    sem_destroy(&wrt);

    return 0;
}