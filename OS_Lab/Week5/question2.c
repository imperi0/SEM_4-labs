#include <stdio.h>

#define Q1 4
#define Q2 8

int main() {

    int n;
    printf("Enter number of processes: ");
    scanf("%d", &n);

    int bt[n], rt[n], ct[n];
    
    for(int i = 0; i < n; i++) {
        printf("Enter burst time for P%d: ", i+1);
        scanf("%d", &bt[i]);
        rt[i] = bt[i];
    }

    int time = 0;

    printf("\nGantt Chart: | ");

    for(int i = 0; i < n; i++) {
        if(rt[i] > 0) {
            printf("P%d | ", i+1);

            if(rt[i] > Q1) {
                time += Q1;
                rt[i] -= Q1;
            } else {
                time += rt[i];
                rt[i] = 0;
                ct[i] = time;
            }
        }
    }

    for(int i = 0; i < n; i++) {
        if(rt[i] > 0) {
            printf("P%d | ", i+1);

            if(rt[i] > Q2) {
                time += Q2;
                rt[i] -= Q2;
            } else {
                time += rt[i];
                rt[i] = 0;
                ct[i] = time;
            }
        }
    }

    // -------- Third Queue (FCFS) --------
    for(int i = 0; i < n; i++) {
        if(rt[i] > 0) {
            printf("P%d | ", i+1);

            time += rt[i];
            rt[i] = 0;
            ct[i] = time;
        }
    }

    printf("%d |\n", time);

    float avg_wt = 0, avg_tat = 0;
    printf("\nProcess\tBT\tCT\tTAT\tWT\n");

    for(int i = 0; i < n; i++) {
        int tat = ct[i];
        int wt = tat - bt[i];

        avg_wt += wt;
        avg_tat += tat;

        printf("P%d\t%d\t%d\t%d\t%d\n", i+1, bt[i], ct[i], tat, wt);
    }

    printf("\nAverage Waiting Time = %.2f", avg_wt/n);
    printf("\nAverage Turnaround Time = %.2f\n", avg_tat/n);

    return 0;
}