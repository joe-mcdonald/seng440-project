#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#define ORDER 3
#define SHIFT_AMOUNT 8
#define SCALE (1 << SHIFT_AMOUNT)

int test_matrix[ORDER][ORDER] = {
    {3, 2, -4},
    {2, 3, 3},
    {5, -3, 1}
};

int augmented_matrix[ORDER][2 * ORDER];

void print_matrix_float() {
    printf("\nInverted test_matrix (fixed-point, shown as float):\n");
    for (int i = 0; i < ORDER; i++) {
        for (int j = ORDER; j < 2 * ORDER; j++) {
            printf("%7.4f ", (float)augmented_matrix[i][j] / SCALE);
        }
        printf("\n");
    }
}

void augment_matrix() {
    for (int i = 0; i < ORDER; i++) {
        for (int j = 0; j < 2 * ORDER; j++) {
            if (j < ORDER)
                augmented_matrix[i][j] = test_matrix[i][j] << SHIFT_AMOUNT;  // shift input
            else
                augmented_matrix[i][j] = (j - ORDER == i) ? SCALE : 0; // identity test_matrix in fixed-point
        }
    }
}

void swap_rows(int row1, int row2) {
    for (int j = 0; j < 2 * ORDER; j++) {
        int temp = augmented_matrix[row1][j];
        augmented_matrix[row1][j] = augmented_matrix[row2][j];
        augmented_matrix[row2][j] = temp;
    }
}

int find_pivot_row(int column) {
    int pivot_row = column;
    int max_val = abs(augmented_matrix[column][column]);
    for (int i = column + 1; i < ORDER; i++) {
        if (abs(augmented_matrix[i][column]) > max_val) {
            pivot_row = i;
            max_val = abs(augmented_matrix[i][column]);
        }
    }
    return pivot_row;
}

void normalize_row(int row, int pivot_val) {
    for (int j = 0; j < 2 * ORDER; j++) {
        augmented_matrix[row][j] = (augmented_matrix[row][j] << SHIFT_AMOUNT) / pivot_val;
    }
}

void eliminate_other_rows(int pivot_row, int pivot_col) {
    for (int i = 0; i < ORDER; i++) {
        if (i == pivot_row) continue;
        int factor = augmented_matrix[i][pivot_col];
        for (int j = 0; j < 2 * ORDER; j++) {
            augmented_matrix[i][j] -= (factor * augmented_matrix[pivot_row][j]) >> SHIFT_AMOUNT;
        }
    }
}



void gauss_jordan_fixed_point() {
    for (int col = 0; col < ORDER; col++) {
        // Pivot: find row with max absolute value in current column
        int pivot_row = find_pivot_row(col);
        if (pivot_row != col) {
            swap_rows(pivot_row, col);
        }

        int pivot_val = augmented_matrix[col][col];
        normalize_row(col, pivot_val);
        eliminate_other_rows(col, col);
    }
}

int main() {
    printf("Original test_matrix:\n");
    for (int i = 0; i < ORDER; i++) {
        for (int j = 0; j < ORDER; j++) {
            printf("%d ", test_matrix[i][j]);
        }
        printf("\n");
    }

    augment_matrix();
    gauss_jordan_fixed_point();
    print_matrix_float();

    return 0;
}
