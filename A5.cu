#include <stdio.h>
#include <time.h>

// CUDA kernel to initialize the array in parallel
__global__ void initializingArray(double *a, int n) {
    int i = blockIdx.x * blockDim.x + threadIdx.x; // Calculating dim i 
    if (i < n) {
        a[i] = (double)i / n;
    }
}

int main() {

    const int n = 10000000; // 10 million integer count
    double *d_a; // Device array
    double *a = (double*)malloc(n * sizeof(double)); // Host array dynamic allocation
    int block_size = 256; // Number of threads per block
    int num_blocks = (n + block_size - 1) / block_size; // Number of blocks

    // Record the starting time
    clock_t start_time = clock();

    // Allocating memory for the device array
    cudaMalloc((void**)&d_a, n * sizeof(double));

    // Launching the CUDA kernel
    initializeArray<<<num_blocks, block_size>>>(d_a, n);

    // Copy the initialized array from the device to the host
    cudaMemcpy(a, d_a, n * sizeof(double), cudaMemcpyDeviceToHost);

    // Recording the ending time
    clock_t end_time = clock();

    // Calculating the elapsed time in seconds
    double elapsed_time = (double)(end_time - start_time) / CLOCKS_PER_SEC;

    // Printing the first 5 elements
    for (int i = 0; i < 5; i++) {
        printf("a[%d]: %.7f\n", i, a[i]);
    }

    // Printing the last 5 elements
    for (int i = n - 5; i < n; i++) {
        printf("a[%d]: %.7f\n", i, a[i]);
    }

    // Printing the elapsed time
    printf("Time taken: %.5f seconds\n", elapsed_time);

    // Freeing memory
    free(a);
    cudaFree(d_a);

    return elapsed_time;
}
