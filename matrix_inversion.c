#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>

// #define ORDER 3
#define ORDER 16
#define SHIFT_AMOUNT 8
#define SCALE (1 << SHIFT_AMOUNT)

// int test_matrix[ORDER][ORDER] = {
//     {3, 2, -4},
//     {2, 3, 3},
//     {5, -3, 1}
// };

// int test_matrix[ORDER][ORDER] = {
//     {2, 3, 4, -2},
//     {-1, 2, 5, 3},
//     {3, 3, -1, 2},
//     {1, 2, 3, 4}
// };

int test_matrix[ORDER][ORDER] = {
    {16, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 1},
    {1, 15, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 2},
    {2, 1, 14, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 3},
    {3, 2, 1, 13, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 4},
    {4, 3, 2, 1, 12, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 5},
    {5, 4, 3, 2, 1, 11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 6},
    {6, 5, 4, 3, 2, 1, 10, 2, 3, 4, 5, 6, 7, 8, 9, 7},
    {7, 6, 5, 4, 3, 2, 1, 9, 2, 3, 4, 5, 6, 7, 8, 8},
    {8, 7, 6, 5, 4, 3, 2, 1, 8, 2, 3, 4, 5, 6, 7, 9},
    {9, 8, 7, 6, 5, 4, 3, 2, 1, 7, 2, 3, 4, 5, 6, 10},
    {10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 6, 2, 3, 4, 5, 11},
    {11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 5, 2, 3, 4, 12},
    {12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 4, 2, 3, 13},
    {13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 3, 2, 14},
    {14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 2, 15},
    {15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 16}
};


// Stored in fixed-point format to avoid floating-point arithmetic
// Each element is multiplied by 2^SHIFT_AMOUNT
// The augmented matrix will have the original matrix on the left and the identity matrix on the right
int augmented_matrix[ORDER][2 * ORDER];






// ---- Output Helper ---- //
void print_matrix_float() {
    printf("\nInverted test_matrix (fixed-point, shown as float):\n");
    for (int row = 0; row < ORDER; row++) {
        for (int column = ORDER; column < 2 * ORDER; column++) {
            // Convert fixed-point to float for display
            printf("%7.4f ", (float)augmented_matrix[row][column] / SCALE);
        }
        printf("\n");
    }
}

// ---- Step 1: Initialize the augmented matrix ---- //
void augment_matrix() {
    // Uses well-structured nested loops. Row-major order is maintained, which is good for cache performance.
    for (int row = 0; row < ORDER; row++) {
        for (int column = 0; column < 2 * ORDER; column++) {
            if (column < ORDER)
                augmented_matrix[row][column] = test_matrix[row][column] << SHIFT_AMOUNT;  // shift input
            else
                augmented_matrix[row][column] = (column - ORDER == row) ? SCALE : 0; // identity test_matrix in fixed-point
        }
    }
}

// ---- Step 2: Row swapping for pivoting ---- //
void swap_rows(int row1, int row2) {
    // could improve this via loop unrolling or register reuse.
    for (int column = 0; column < 2 * ORDER; column++) {
        int temp = augmented_matrix[row1][column];
        augmented_matrix[row1][column] = augmented_matrix[row2][column];
        augmented_matrix[row2][column] = temp;
    }
}

// ---- Step 3: Find pivot row using max(abs()) ---- //
int find_pivot_row(int column) {
    // might want to use predication to avoid branching (if supported). Could also use SIMD for parallel max search.
    
    // This function finds the row with the maximum absolute value in the current column.
    // It returns the index of that row.
    int pivot_row = column;
    int max_val = abs(augmented_matrix[column][column]);
    for (int row = column + 1; row < ORDER; row++) {
        if (abs(augmented_matrix[row][column]) > max_val) {
            pivot_row = row;
            max_val = abs(augmented_matrix[row][column]);
        }
    }
    return pivot_row;
}

// ---- Step 4: Normalize the pivot row ---- //
void normalize_row(int row, int pivot_val) {
    // Could use software pipelining. could be restructured to prefetch next element while current one is computing.
    for (int column = 0; column < 2 * ORDER; column++) {
        // shifing vs multiplying: shifting is done because its faster in fixed-point arithmetic.
        augmented_matrix[row][column] = (augmented_matrix[row][column] << SHIFT_AMOUNT) / pivot_val;
    }
}

// ---- Step 5: Eliminate other rows using the pivot row ---- //
// This function eliminates the values in the current column for all other rows using the pivot row.
// It subtracts the appropriate multiple of the pivot row from each other row.
void eliminate_other_rows(int pivot_row, int pivot_col) {
    // access the rows linearly, which is good for avoiding cache misses.
    for (int row = 0; row < ORDER; row++) {
        if (row == pivot_row) continue;
        int factor = augmented_matrix[row][pivot_col];
        for (int column = 0; column < 2 * ORDER; column++) {
            // this for loop performs the same operation across a row - ideal for SIMD vectorization.
            augmented_matrix[row][column] -= (factor * augmented_matrix[pivot_row][column]) >> SHIFT_AMOUNT;
        }
    }
}

void gauss_jordan_fixed_point() {
    for (int column = 0; column < ORDER; column++) {
        // Pivot: find row with max absolute value in current column
        int pivot_row = find_pivot_row(column);
        if (pivot_row != column) {
            swap_rows(pivot_row, column);
        }

        // breaking it up into helper functions for modularity and readability. could also support pipelining analysis and per-function optimization.
        
        // Get the pivot value for normalization
        int pivot_val = augmented_matrix[column][column];
        // Normalize the pivot row
        normalize_row(column, pivot_val);
        // Eliminate other rows using the pivot row
        eliminate_other_rows(column, column);
    }
}

int estimate_condition_number(int matrix[ORDER][ORDER]) {
    int condition_number = 0;
    for (int row = 0; row < ORDER; row++) {
        int row_sum = 0;
        for (int column = 0; column < ORDER; column++) {
            if (matrix[row][column] < 0) {
                row_sum += -1 * matrix[row][column];
            } else {
                row_sum += matrix[row][column];
            }
        }
        if (row_sum > condition_number) {
            condition_number = row_sum;
        }
    }
    // The condition number is the product of the norm and the inverse of the norm.
    return condition_number;
}

int main() {
    // Print the original matrix for reference
    printf("Original test_matrix:\n");

    float cond_estimate = estimate_condition_number(test_matrix);
    printf("\nEstimated (pre-execution) condition number (∞-norm): %.4f\n", cond_estimate);


    // use clean loops, avoid excess memory copies.
    for (int row = 0; row < ORDER; row++) {
        for (int column = 0; column < ORDER; column++) {
            printf("%d ", test_matrix[row][column]);
        }
        printf("\n");
    }

    clock_t start_time = clock();

    augment_matrix();
    gauss_jordan_fixed_point();

    clock_t end_time = clock();
    double time_spent = ((double)(end_time - start_time)) / CLOCKS_PER_SEC;
    print_matrix_float();

    printf("\nGauss-Jordan elimination time: %.6f seconds\n", time_spent);


    return 0;
}
