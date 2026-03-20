#include <stdio.h>
#include <stdbool.h>

struct resources {
    int a,b,c;
};

typedef struct resources resource;

bool saftyAlgorithm(int n, int allocation[n][3], int need[n][3], int available[3]){
    int work[3];
    int completed=0;
    bool finish[n];
    for(int i=0; i<3; i++){
        work[i]=available[i];
    }
    for(int i=0; i<n; i++){
        finish[i]=false;
    }
    int index=0;
    int cmplt=false;
    int iteration=0;
    while(completed!=n){
        if(!finish[index]){
            bool flag=true;
            for(int i=0; i<3; i++){
                if(work[i]<need[index][i]){
                    flag=false;
                    break;
                }
            }
            if(flag){
                completed++;
                finish[index]=true;
                cmplt=true;
                for(int i=0; i<3; i++){
                    work[i]+=allocation[index][i];
                }
                printf("\nProcess P%d completed and added resources to work\n",index);
                printf("Available resources : A:%d\tB:%d\tC:%d", work[0],work[1],work[2]);
            }
        }
        index=(index+1)%n;
        if(index==0){
            iteration++;
            if(!cmplt){
                printf("System is not in safe state....");
                return false;
            } else {
                cmplt=false;
            }
        }
    }
    printf("\n");
    return true;
}

int main(){
    
    int n;
    printf("Enter number of processes : ");
    scanf("%d", &n);
    int allocation[n][3];
    int max[n][3];
    int need[n][3];
    
    for(int i=0; i<n; i++){
        printf("Enter allocation for process %d : ",i+1);        
        scanf("%d %d %d", &allocation[i][0],&allocation[i][1],&allocation[i][2]);
        printf("Enter max : ");
        scanf("%d %d %d", &max[i][0],&max[i][1],&max[i][2]);
        for(int j=0; j<n; j++){
            need[i][j]=max[i][j]-allocation[i][j];
        }
    }
    
    int total[3];
    printf("Enter total available resources : ");
    scanf("%d %d %d", &total[0], &total[1], &total[2]);
    
    int available[3];
    for(int i=0; i<3; i++){
        available[i]=total[i];
    }
    for(int i=0; i<n; i++){
        for(int j=0; j<3; j++){
            available[j]-=allocation[i][j];
        }
    }
    printf("Available :\nA : %d\tB : %d\tC : %d\n",available[0],available[1],available[2]);
    printf("---------NEED---------\n");
    for(int i=0; i<n; i++){
        printf("%d\t%d\t%d\n",need[i][0],need[i][1],need[i][2]);
    }
    saftyAlgorithm(n, allocation, need, available);
    printf("Enter request index : ");
}