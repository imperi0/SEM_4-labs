#include <stdio.h>
#include <pthread.h>
#include <time.h>

int a1[100], a2[100], n;

void *bubble(void *arg) {
    time_t s=time(NULL);
    for (int i = 0; i < n - 1; i++)
        for (int j = 0; j < n - i - 1; j++)
            if (a1[j] > a1[j + 1]) {
                int t = a1[j];
                a1[j] = a1[j + 1];
                a1[j + 1] = t;
            }
    time_t e=time(NULL);
    printf("Bubble Sort Time: %lf\n", (double)(e - s) );
    pthread_exit(NULL);
}

void *selection(void *arg) {
    time_t s=time(NULL);
    for (int i = 0; i < n - 1; i++) {
        int min = i;
        for (int j = i + 1; j < n; j++)
            if (a2[j] < a2[min])
                min = j;
        int t = a2[i];
        a2[i] = a2[min];
        a2[min] = t;
    }
    time_t e=time(NULL);
    printf("Selection Sort Time Taken: %lf\n", (double)(e - s)  );
    pthread_exit(NULL);
}

int main() {
    printf("Enter number of elements: ");
    scanf("%d", &n);

    printf("Enter elements:\n");
    for (int i = 0; i < n; i++) {
        scanf("%d", &a1[i]);
        a2[i] = a1[i];
    }

    pthread_t t1, t2;

    pthread_create(&t1, NULL, bubble, NULL);
    pthread_create(&t2, NULL, selection, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    printf("Sorted Array:\n");
    for (int i = 0; i < n; i++)
        printf("%d ", a1[i]);
    printf("\n");

    return 0;
}

