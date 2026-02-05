#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

void *fib(void *params) {
    int n = *(int *)params;

    int *arr = malloc(n * sizeof(int));
    int f = 0, s = 1;

    for (int i = 0; i < n; i++) {
        if (i <= 1)
            arr[i] = i;
        else {
            arr[i] = f + s;
            f = s;
            s = arr[i];
        }
    }

    return arr;
}

int main() {
    pthread_t fibThread;
    int n;

    printf("Enter n: ");
    scanf("%d", &n);

    int *arr;

    pthread_create(&fibThread, NULL, fib, &n);
    pthread_join(fibThread, (void **)&arr);

    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }

	printf("\n");
    free(arr);
    return 0;
}

