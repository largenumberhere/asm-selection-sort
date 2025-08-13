#include <stdio.h>
#include <string.h>
#include <criterion/criterion.h>

extern void sort_ascending (size_t length, int array[length]);
static void print_array (size_t length, const int array[length]);

void swap(int* buffer, int offset1, int offet2) {
    char tmp1 = buffer[offset1];
    char tmp2 = buffer[offet2];

    buffer[offet2] = tmp1;
    buffer[offset1] = tmp2;
}

void do_test (size_t length, int array[length], const int expected[length])
{
  size_t nb_bytes = length * sizeof *expected;
  sort_ascending(length, array);

  if (memcmp(array, expected, nb_bytes)) {
    puts("expected:");
    print_array(length, expected);
    puts("but got:");
    print_array(length, array);
  }
  cr_assert_arr_eq(array, expected, nb_bytes, "the array is not sorted correctly");
}

static void print_array (size_t length, const int array[length])
{
  if (length == 0) {
    printf("{}\n");
    return;
  }
  printf("{");
  
  for (size_t i = 0; i < length - 1; i++)
    printf("%d, ", array[i]);
  printf("%d}\n", array[length - 1]);
}



#include <limits.h>
#include <stddef.h>
#include <criterion/criterion.h>

extern void do_test (size_t length, int array[length], const int expected[length]);

#define ARR_LEN(array) (sizeof(array) / sizeof *(array))

#define sample_test(array, expected) do_test(ARR_LEN(array), array, expected)

Test(tests_suite, sample_tests)
{
  sample_test(
	  		((int[]){1, 2, 3, 10, 5}),
	  ((const int[]){1, 2, 3, 5, 10})
 	);
  sample_test(
	  		((int[]){-8, 22, 3, 16, -30}),
	  ((const int[]){-30, -8, 3, 16, 22})
  );
  sample_test(
	  		((int[]){666}),
	  ((const int[]){666})
  );
  sample_test(
	  		((int[]){INT_MAX, 0}), 
	  ((const int[]){0, INT_MAX})
  );
  sample_test(
	  		((int[]){5, 5, 0, 0, 4, -6}),
	  ((const int[]){-6, 0, 0, 4, 5, 5})
  );
  sample_test(
	  		((int[]){INT_MIN, INT_MAX, 0, 1 << 15}),
	  ((const int[]){INT_MIN, 0, 1 << 15, INT_MAX})
  );
  sample_test(
	  		((int[]){INT_MIN + 1, INT_MIN, INT_MAX, INT_MAX - 1, 0, 1 << 15, (1 << 15) - 1}),
	  ((const int[]){INT_MIN, INT_MIN + 1, 0, (1 << 15) - 1, 1 << 15, INT_MAX - 1, INT_MAX})
  );
  sample_test(
	  		((int[]){-(1 << 20), (1 << 20), INT_MIN, INT_MAX, 0}),
	  ((const int[]){INT_MIN, -(1 << 20), 0, (1 << 20), INT_MAX})
  );
}

Test(tests_suite, empty_array)
{
	do_test(0, NULL, NULL);
}

