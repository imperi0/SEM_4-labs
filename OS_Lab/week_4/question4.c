#include<stdio.h>
#include<pthread.h>
#include<time.h>

int arr[100];
int arr2[100];
int arr3[100];

void *bubble(void *parameter){
	int n = *(int *)parameter;
	clock_t before = clock();
	for(int i=0;i<n-1;i++){
		for(int j=0;j<n-i-1;j++){
			if(arr[j]>arr[j+1]){
				int temp = arr[j+1];
				arr[j+1] = arr[j];
				arr[j] = temp;
			}
		}
	}
	clock_t after = clock();
	printf("Bubble sort\nStart time : %f\n", (float)before/CLOCKS_PER_SEC);	
	printf("End time : %f\n", (float)after/CLOCKS_PER_SEC);
	printf("Total time : %f\n",(double)(after-before)/CLOCKS_PER_SEC);
	return NULL;
}

void *selection(void *parameter){
	int n = *(int *)parameter;
	clock_t before = clock();
	for(int i=0;i<n;i++){
		int min = i;
		for(int j=i+1;j<n;j++){
			if(arr2[min]>arr2[j]){
				min = j;
			}
		}
		if(min!=i){
			int temp = arr2[i];
			arr2[i] = arr2[min];
			arr2[min] = temp;
		}
	}
	clock_t after = clock();
	printf("Selection sort\nStart time : %f\n", (float)before/CLOCKS_PER_SEC);	
	printf("End time : %f\n", (float)after/CLOCKS_PER_SEC);
	printf("Total time : %f\n",(double)(after-before)/CLOCKS_PER_SEC);
	return NULL;
}

void *insertion(void *parameter){
	int n = *(int *)parameter;
	clock_t before = clock();
	for(int i=1;i<n;i++){
		int key = arr3[i];
		int j = i-1;
		while(j>=0 && arr3[j]>key){
			arr3[j+1] = arr3[j];
			j--;
		}
		arr3[j+1] = key;
	}
	clock_t after = clock();
	printf("Insertion sort\nStart time : %f\n", (float)before/CLOCKS_PER_SEC);	
	printf("End time : %f\n", (float)after/CLOCKS_PER_SEC);
	printf("Total time : %f\n",(double)(after-before)/CLOCKS_PER_SEC);
	return NULL;
}

int main(){
	int n;
	printf("Enter n value : ");
	scanf("%d",&n);

	for(int i=0;i<n;i++){
		scanf("%d",&arr[i]);
		arr2[i] = arr[i];
		arr3[i] = arr[i];
	}

	pthread_t bubbleThread;
	pthread_create(&bubbleThread, NULL, bubble, &n);
	pthread_join(bubbleThread, NULL);

	pthread_t selectionThread;
	pthread_create(&selectionThread, NULL, selection, &n);
	pthread_join(selectionThread, NULL);

	pthread_t insertionThread;
	pthread_create(&insertionThread, NULL, insertion, &n);
	pthread_join(insertionThread, NULL);

	for(int i=0;i<n;i++){
		printf("%d ",arr[i]);
	}
	printf("\n");
	for(int i=0;i<n;i++){
		printf("%d ",arr2[i]);
	}
	printf("\n");
	for(int i=0;i<n;i++){
		printf("%d ",arr3[i]);
	}
    printf("\n");
}