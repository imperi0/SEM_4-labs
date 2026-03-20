#include <stdio.h>
#include <stdbool.h>

// struct resources {
//     int a, b, c;
// };

// typedef struct resources resource;

bool saftyAlgorithm(int n, int allocation[n][3], int need[n][3], int available[3], bool request) {

    if(request) {
        int reqIndex;
        printf("Enter request index : ");
        scanf("%d", &reqIndex);
        
        int req[3];
        printf("Enter request for process P%d: ", reqIndex);
        scanf("%d %d %d", &req[0], &req[1], &req[2]);

        for(int i = 0; i < 3; i++) {
            if(req[i] > need[reqIndex][i]) {
                printf("Request exceeds need for process P%d\n", reqIndex);
                return false;
            }
            if(req[i] > available[i]) {
                printf("Request exceeds available resources\n");
                return false;
            }
        }

        for(int i = 0; i < 3; i++) {
            available[i] -= req[i];
            allocation[reqIndex][i] += req[i];
            need[reqIndex][i] -= req[i];
        }
    }

    int work[3];
    for(int i = 0; i < 3; i++) {
        work[i] = available[i];
    }

    bool finish[n];
    for(int i = 0; i < n; i++) {
        finish[i] = false;
    }

    int completed = 0;
    int iteration = 0;
    bool cmplt = false;

    while(completed < n) {
        bool progressMade = false;
        for(int i = 0; i < n; i++) {
            if(!finish[i]) {
                bool canComplete = true;
                for(int j = 0; j < 3; j++) {
                    if(work[j] < need[i][j]) {
                        canComplete = false;
                        break;
                    }
                }

                if(canComplete) {
                    completed++;
                    finish[i] = true;
                    progressMade = true;

                    for(int j = 0; j < 3; j++) {
                        work[j] += allocation[i][j];
                    }

                    printf("\nProcess P%d completed and added resources to work\n", i);
                    printf("Available resources: A:%d B:%d C:%d\n", work[0], work[1], work[2]);
                }
            }
        }

        if(!progressMade) {
            printf("System is not in a safe state.\n");
            return false;
        }
    }

    return true;
}

int main() {

    int n;
    printf("Enter number of processes: ");
    scanf("%d", &n);
    int allocation[n][3];
    int max[n][3];
    int need[n][3];

    for(int i = 0; i < n; i++) {
        printf("Enter allocation for process P%d: ", i);
        scanf("%d %d %d", &allocation[i][0], &allocation[i][1], &allocation[i][2]);
        printf("Enter max resources for process P%d: ", i);
        scanf("%d %d %d", &max[i][0], &max[i][1], &max[i][2]);
        for(int j = 0; j < 3; j++) {
            need[i][j] = max[i][j] - allocation[i][j];
        }
    }

    int total[3];
    printf("Enter total available resources: ");
    scanf("%d %d %d", &total[0], &total[1], &total[2]);

    int available[3];
    for(int i = 0; i < 3; i++) {
        available[i] = total[i];
    }
    for(int i = 0; i < n; i++) {
        for(int j = 0; j < 3; j++) {
            available[j] -= allocation[i][j];
        }
    }

    printf("Available resources:\nA: %d\tB: %d\tC: %d\n", available[0], available[1], available[2]);

    printf("---------NEED Matrix---------\n");
    for(int i = 0; i < n; i++) {
        printf("%d\t%d\t%d\n", need[i][0], need[i][1], need[i][2]);
    }

    if(saftyAlgorithm(n, allocation, need, available, false)) {
        printf("System is in a safe state.\n");
    }

    int reqNum;
    printf("Enter the number of requests: ");
    scanf("%d", &reqNum);

    for(int i = 0; i < reqNum; i++) {
        if(!saftyAlgorithm(n, allocation, need, available, true)) {
            printf("Request not granted\n");
        } else {
            printf("Request can be granted\n");
        }
    }

    return 0;
}