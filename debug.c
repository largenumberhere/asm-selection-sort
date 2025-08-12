#include <stddef.h>

extern void sort_ascending2 (size_t length, int array[length]);
static void print_array (size_t length, const int array[length]);

void sort_ascending(size_t length, int array[length]) {
    
    for (int i = 0; i < length; i++) {
        printf("%i, ", array[i]);
    }
    printf("\n");
    sort_ascending2(length, array);

    for (int i = 0; i < length; i++) {
        printf("%i, ", array[i]);
    }
    printf("\n\n");
    
    
}

int main() {
    int tmp[10] = {1,0,3,4,5,6,7,8,9,2};
    sort_ascending(sizeof(tmp)/ sizeof(tmp[0]), tmp);



}