#include <stdio.h>
#include <stdlib.h>

int head;
int lim = 199;

void sort(int arr[], int n) {
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}

void fcfs(int arr[], int n) {
    int prev = head;
    int total = 0;
    for (int i = 0; i < n; i++) {
        total += abs(prev - arr[i]);
        prev = arr[i];
    }
    printf("Total cylinders used : %d\n", total);
}

void sstf(int arr[], int n) {
    int prev = head;
    int total = 0;
    int c = 0;
    int checked[n];
    for (int i = 0; i < n; i++) checked[i] = 0;

    while (c != n) {
        int next = -1;
        for (int i = 0; i < n; i++) {
            if (checked[i] == 0) {
                if (next == -1 || abs(arr[i] - prev) < abs(arr[next] - prev)) {
                    next = i;
                }
            }
        }
        total += abs(prev - arr[next]);
        prev = arr[next];
        checked[next] = 1;
        c++;
    }
    printf("Total cylinders used : %d\n", total);
}

void scan(int arr[], int n) {
    int prev = head;
    int total = 0;
    int copy[n];
    for (int i = 0; i < n; i++) copy[i] = arr[i];
    sort(copy, n);

    int f = -1;
    for (int i = 0; i < n; i++) {
        if (copy[i] >= head) {
            f = i;
            break;
        }
    }

    // According to your logic: Move Left to 0 first, then reverse Right
    int start_left = (f == -1) ? n - 1 : f - 1;
    for (int i = start_left; i >= 0; i--) {
        total += abs(prev - copy[i]);
        prev = copy[i];
    }
    
    total += abs(prev - 0);
    prev = 0;

    int start_right = (f == -1) ? n : f;
    for (int i = start_right; i < n; i++) {
        total += abs(prev - copy[i]);
        prev = copy[i];
    }
    printf("Total cylinders used : %d\n", total);
}

void cscan(int arr[], int n) {
    int prev = head;
    int total = 0;
    int copy[n];
    for (int i = 0; i < n; i++) copy[i] = arr[i];
    sort(copy, n);

    int f = -1;
    for (int i = 0; i < n; i++) {
        if (copy[i] >= head) {
            f = i;
            break;
        }
    }

    // According to your logic: Service Right to end, jump to 0, service remaining
    if (f != -1) {
        for (int i = f; i < n; i++) {
            total += abs(prev - copy[i]);
            prev = copy[i];
        }
    }

    total += abs(lim - prev); // Move to end of disk
    // Jump to 0 is not added to THM based on your provided tracks calculation
    prev = 0; 

    int end_limit = (f == -1) ? n : f;
    for (int i = 0; i < end_limit; i++) {
        total += abs(prev - copy[i]);
        prev = copy[i];
    }
    printf("Total cylinders used : %d\n", total);
}

int main() {
    int n;
    printf("Enter head position: ");
    scanf("%d", &head);
    printf("Enter number of requests`: ");
    scanf("%d", &n);
    int arr[n];
    printf("Enter requests: ");
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }

    printf("\n-----------FCFS-----------\n");
    fcfs(arr, n);
    printf("\n-----------SSTF-----------\n");
    sstf(arr, n);
    printf("\n-----------SCAN-----------\n");
    scan(arr, n);
    printf("\n----------C-SCAN----------\n");
    cscan(arr, n);

    return 0;
}