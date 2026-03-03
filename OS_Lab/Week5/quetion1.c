#include <stdio.h>
#include <limits.h>
#include <stdbool.h>

#define QUANTUM 10

void calculate_and_print(int n, int at[], int bt[], int ct[]) {
    int wt[n], tat[n];
    float avg_wt = 0, avg_tat = 0;

    printf("\nProcess\tAT\tBT\tCT\tTAT\tWT\n");

    for(int i = 0; i < n; i++) {
        tat[i] = ct[i] - at[i];
        wt[i] = tat[i] - bt[i];

        avg_wt += wt[i];
        avg_tat += tat[i];

        printf("P%d\t%d\t%d\t%d\t%d\t%d\n",
               i+1, at[i], bt[i], ct[i], tat[i], wt[i]);
    }

    printf("\nAverage W Time = %.2f", avg_wt/n);
    printf("\nAverage TA Time = %.2f\n", avg_tat/n);
}

void fcfs(int n, int at[], int bt[]) {

    int ct[n];
    int current_time = 0;

    printf("\nGantt Chart: | ");

    for(int i = 0; i < n; i++) {
        if(current_time < at[i])
            current_time = at[i];

        current_time += bt[i];
        ct[i] = current_time;

        printf("P%d | %d | ", i+1, current_time);
    }

    printf("\n");
    calculate_and_print(n, at, bt, ct);
}

void srtf(int n, int at[], int bt[]) {

    int rt[n], ct[n];
    int completed = 0, current_time = 0;
    int prev = -1;   

    for(int i = 0; i < n; i++)
        rt[i] = bt[i];

    printf("\nGantt Chart: | ");

    while(completed < n) {

        int shortest = -1;
        int min_rt = INT_MAX;

        for(int i = 0; i < n; i++) {
            if(at[i] <= current_time && rt[i] > 0 && rt[i] < min_rt) {
                min_rt = rt[i];
                shortest = i;
            }
        }

        if(shortest == -1) {
            current_time++;
            continue;
        }

        if(prev != shortest) {
            if(prev != -1)
                printf("%d | ", current_time);
            printf("P%d | ", shortest+1);
            prev = shortest;
        }

        rt[shortest]--;
        current_time++;

        if(rt[shortest] == 0) {
            ct[shortest] = current_time;
            completed++;
        }
    }

    printf("%d |\n", current_time);

    calculate_and_print(n, at, bt, ct);
}

void round_robin(int n, int at[], int bt[]) {

    int rt[n], ct[n];
    int current_time = 0, completed = 0;

    for(int i = 0; i < n; i++)
        rt[i] = bt[i];

    printf("\nGantt Chart: | ");

    while(completed < n) {
        for(int i = 0; i < n; i++) {
            if(rt[i] > 0 && at[i] <= current_time) {

                printf("P%d | ", i+1);

                if(rt[i] > QUANTUM) {
                    current_time += QUANTUM;
                    rt[i] -= QUANTUM;
                } else {
                    current_time += rt[i];
                    rt[i] = 0;
                    ct[i] = current_time;
                    completed++;
                }
            }
        }
    }

    printf("%d |\n", current_time);
    calculate_and_print(n, at, bt, ct);
}

void priority_np(int n, int at[], int bt[], int pr[]) {

    int completed = 0, current_time = 0;
    int ct[n], done[n];

    for(int i = 0; i < n; i++)
        done[i] = 0;

    printf("\nGantt Chart: | ");

    while(completed < n) {

        int highest = -1;
        int max_pr = -1;

        for(int i = 0; i < n; i++) {
            if(at[i] <= current_time && !done[i] && pr[i] > max_pr) {
                max_pr = pr[i];
                highest = i;
            }
        }

        if(highest == -1) {
            current_time++;
            continue;
        }

        printf("P%d | ", highest+1);

        current_time += bt[highest];
        ct[highest] = current_time;
        done[highest] = 1;
        completed++;
    }

    printf("%d |\n", current_time);
    calculate_and_print(n, at, bt, ct);
}

int main() {

    int n, choice;
    scanf("%d", &n);

    int at[n], bt[n], pr[n];

    for(int i = 0; i < n; i++) {
        printf("Enter AT BT Priority for P%d: ", i+1);
        scanf("%d %d %d", &at[i], &bt[i], &pr[i]);
    }

    while(true){
        printf("\n1.FCFS\n2.SRTF\n3.Round Robin\n4.Non-Preemptive Priority\n");
        printf("Enter choice: ");
        scanf("%d", &choice);
        switch(choice) {
        case 1: fcfs(n, at, bt); break;
        case 2: srtf(n, at, bt); break;
        case 3: round_robin(n, at, bt); break;
        case 4: priority_np(n, at, bt, pr); break;
        case 5: 
        {
            printf("EXIT\n");
            return 0;
        }
        }
    }

    return 0;
}