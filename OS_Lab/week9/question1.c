#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

void fifoReplacement(int n, int m, int pages[]){
    // int frames[m];
    int *frames = (int *)malloc(m * sizeof(int));
    for(int i=0; i<m; i++){
        frames[i]=-1;
    }
    int in=0, out=0;
    int missed=0;
    for(int i=0; i<n; i++) {
        bool miss=true;   
        for(int j=0; j<m; j++){
            if(frames[j]==pages[i]){
                miss = false;
                break;
            }
        }
        if(miss){
            missed++;
            frames[in]=pages[i];
            in=(in+1)%m;
        } 
        printf("After inserting %d: ", pages[i]);
        for (int j = 0; j < m; j++){
            printf("%d ", frames[j]);
        }
        printf("\n");
    }
    free(frames);
    int hitRatio = (float)(n-missed)/n; // NOTE this : ELse it gives 0 
    printf("Missed : %d\nHits : %d\nHit Ratio : %d\n", missed, n-missed, hitRatio);
}

void optimalReplacement(int n, int m, int pages[]) {
    int *frames = (int *)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        frames[i] = -1;
    }

    int missed = 0;

    for (int i = 0; i < n; i++) {
        bool hit = false;
        for (int j = 0; j < m; j++) {
            if (frames[j] == pages[i]) {
                hit = true;
                break;
            }
        }

        if (!hit) {
            missed++;
            int replaceIdx = -1;

            for (int j = 0; j < m; j++) {
                if (frames[j] == -1) {
                    replaceIdx = j;
                    break;
                }
            }

            if (replaceIdx == -1) {
                int farthest = i + 1;
                replaceIdx = 0; 

                for (int j = 0; j < m; j++) {
                    int k;
                    for (k = i + 1; k < n; k++) {
                        if (frames[j] == pages[k]) {
                            if (k > farthest) {
                                farthest = k;
                                replaceIdx = j;
                            }
                            break;
                        }
                    }

                    if (k == n) {
                        replaceIdx = j;
                        break;
                    }
                }
            }

            frames[replaceIdx] = pages[i];
        }

        printf("After inserting %d: ", pages[i]);
        for (int j = 0; j < m; j++) {
            if (frames[j] == -1) printf("- ");
            else printf("%d ", frames[j]);
        }
        printf("\n");
    }

    float hitRatio = (float)(n - missed) / n;
    printf("\nMissed: %d\nHits: %d\nHit Ratio: %.2f\n", missed, n - missed, hitRatio);
    free(frames);
}

int main() {
    int n;
    printf("Enter n : ");
    scanf("%d", &n);
    int pages[n];
    for(int i=0; i<n; i++) { 
        scanf("%d", &pages[i]);
    }
    int m;
    printf("Enter frame size : ");
    scanf("%d", &m);
    printf("FIFO :\n");
    fifoReplacement(n, m, pages);
    printf("Optimal :\n");
    optimalReplacement(n, m, pages);
}