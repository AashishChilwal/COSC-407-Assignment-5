#include <stdio.h>
#include <time.h>
const int n = 10000000; // initializing the size

int main() {
    double a[n]; // Initializing the array

    // Record the starting time
    clock_t start_time = clock();

    
    // For loop to create the value of each array element

    for (int i = 0; i < n; i++) {
        a[i] = (double)i / n;
    }


    // Record the ending time
    clock_t end_time = clock();

    // Calculate the elapsed time in seconds
    double elapsed_time = (double)(end_time - start_time) / CLOCKS_PER_SEC;

    // Printing the first 5 elements
    for (int i = 0; i < 5; i++) {
        printf("a[%d]: %.7f\n", i, a[i]);
    }
        printf("...\n");
    // Printing the last 5 elements
    for (int i = n - 5; i < n; i++) {
        printf("a[%d]: %.7f\n", i, a[i]);
    }

    // Print the elapsed time
    printf("Time elapsed: %.5f seconds\n", elapsed_time);
    return 0;
}
