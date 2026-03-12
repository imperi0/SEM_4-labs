#include<stdio.h>
#include<pthread.h>
#include<semaphore.h>
#include<unistd.h>
#define SIZE 15
int buf[SIZE];int f=-1,r=-1;
sem_t mutex,full,empty,total;

void*produce(void*arg){
    for(int i=0;i<15 ;i++){
        sem_wait(&total);
        sem_wait(&empty);
        sem_wait(&mutex);
        r=(r+1)%SIZE;
        buf[r]=i;
        printf("Produced:%d\n",i);
        sem_post(&mutex);
        sem_post(&full);
        sleep(1);
        }
    return NULL;
}

void*consume(void*arg){
    for(int i=0;i<15;i++){
        sleep(3);
        sem_wait(&full);
        sem_wait(&mutex);
        f=(f+1)%SIZE;
        int item=buf[f];
        printf("Consumed:%d\n",item);
        sem_post(&mutex);
        sem_post(&empty);
        sem_post(&total);
        sleep(1);
        }
    return NULL;
}

int main(void){
    pthread_t t1,t2;
    sem_init(&mutex,0,1);
    sem_init(&full,0,0);
    sem_init(&empty,0,SIZE);
    sem_init(&total,0,10);
    pthread_create(&t1,NULL,produce,NULL);
    pthread_create(&t2,NULL,consume,NULL);
    pthread_join(t1,NULL);
    pthread_join(t2,NULL);
    sem_destroy(&mutex);
    sem_destroy(&full);
    sem_destroy(&empty);
    sem_destroy(&total);
    return 0;
}