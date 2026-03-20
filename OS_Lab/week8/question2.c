#include <stdio.h>
#include <stdbool.h>

int main() {
    int n;
    printf("Enter number of processes : ");
    scanf("%d", &n);
    int allocation[n][3];
    int request[n][3];
    bool finish[n];

    for(int i=0; i<n; i++){
        printf("Enter allocation for process %d : ", i+1);
        scanf("%d %d %d", &allocation[i][0], &allocation[i][1], &allocation[i][2]);
        printf("Enter request for process %d : ", i+1);
        scanf("%d %d %d", &request[i][0], &request[i][1], &request[i][2]);
        finish[i] = false;
    }

    int available[3];
    printf("Enter available resources : ");
    scanf("%d %d %d", &available[0], &available[1], &available[2]);

    int work[3];
    for(int i=0; i<3; i++){
        work[i] = available[i];
    }

    int completed=0;
    int index=0;
    int iteration=0;
    bool progress=false;

    while(completed != n){
        if(!finish[index]){
            bool can_finish=true;
            for(int i=0; i<3; i++){
                if(request[index][i] > work[i]){
                    can_finish=false;
                    break;
                }
            }
            if(can_finish){
                completed++;
                finish[index] = true;
                progress = true;
                for(int i=0; i<3; i++){
                    work[i] += allocation[index][i];
                }
                printf("\nProcess P%d completed, work updated: A:%d B:%d C:%d\n",
                       index, work[0], work[1], work[2]);
            }
        }
        index = (index + 1) % n;
        if(index == 0){
            iteration++;
            if(!progress){
                printf("\nDeadlock detected! The following processes are deadlocked:\n");
                for(int i=0; i<n; i++){
                    if(!finish[i]){
                        printf("P%d ", i);
                    }
                }
                break;
            } else {
                progress = false;
            }
        }
    }
    if(completed == n){
        printf("\nSystem is safe state.\n");
    }
    return 0;
}