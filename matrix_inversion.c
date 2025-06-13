#include <stdio.h>
#include <stdint.h>

#define FLOAT_TO_Q15(x) ((int16_t)((x) * 32768.0f))
#define Q15_TO_FLOAT(x) ((float)(x) / 32768.0f)
#define Q15_MUL(a, b) ((int16_t)(((int32_t)(a) * (int32_t)(b)) >> 15))

int invert_2x2_q15(const int16_t m[2][2], int16_t out[2][2]) {
    int32_t det = (int32_t)m[0][0] * m[1][1] - (int32_t)m[0][1] * m[1][0];
    
    if (det == 0) return -1;

    int32_t det_q15 = (det << 15) / det;

    out[0][0] = (int16_t)(((int32_t)m[1][1] << 15) / det);
    out[0][1] = (int16_t)((-(int32_t)m[0][1] << 15) / det);
    out[1][0] = (int16_t)((-(int32_t)m[1][0] << 15) / det);
    out[1][1] = (int16_t)(((int32_t)m[0][0] << 15) / det);

    return 0;
}

int main() {
    int16_t mat[2][2] = {
        {FLOAT_TO_Q15(0.5), FLOAT_TO_Q15(0.25)},
        {FLOAT_TO_Q15(0.75), FLOAT_TO_Q15(1.0)}
    };

    int16_t inv[2][2];
    if (invert_2x2_q15(mat, inv) == 0) {
        printf("Inverse matrix (Q15):\n");
        printf("[%f %f]\n", Q15_TO_FLOAT(inv[0][0]), Q15_TO_FLOAT(inv[0][1]));
        printf("[%f %f]\n", Q15_TO_FLOAT(inv[1][0]), Q15_TO_FLOAT(inv[1][1]));
    } else {
        printf("Matrix not invertable.\n");
    }

    return 0;
}