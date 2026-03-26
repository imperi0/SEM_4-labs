#include <stdio.h>

int main() {
    const int pageSize = 32;     
    const int totalPages = 8;    
    const int totalMemory = pageSize * totalPages;

    int la;

    printf("Enter logical address: ");
    scanf("%d", &la);

    if (la < 0 || la >= totalMemory) {
        printf("Logical address out of range!\n");
        return 1;
    }

    int pageNum = la / pageSize;
    int offset = la % pageSize;

    printf("Logical Address: %d\n", la);
    printf("Page Number: %d\n", pageNum);
    printf("Page Offset: %d\n", offset);

    return 0;
}