#include <stddef.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

extern void sort_ascending (size_t length, int array[length]);
static void print_array (size_t length, const int array[length]);


int main() {
    int tmp[10] = {-1,0,-3,4,5,6,7,8,9,2};
    sort_ascending(sizeof(tmp)/ sizeof(tmp[0]), tmp);
    for (int i = 0; i < sizeof(tmp)/sizeof(tmp[0]); i++) {
        printf("%i, ", tmp[i]);
    }
    printf("\n");


}