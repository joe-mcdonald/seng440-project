	.arch armv7-a
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"matrix_inversion.c"
	.text
	.align	2
	.global	print_matrix_float
	.arch armv7-a
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	print_matrix_float, %function
print_matrix_float:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movw	r0, #:lower16:.LC0
	push	{r4, r5, r6, r7, r8, lr}
	movt	r0, #:upper16:.LC0
	vpush.64	{d8}
	movw	r6, #:lower16:.LC1
	bl	puts
	vldr.32	s16, .L8
	ldr	r5, .L8+4
	movt	r6, #:upper16:.LC1
	add	r7, r5, #2048
.L2:
	sub	r4, r5, #64
.L3:
	ldr	r3, [r4, #4]!
	mov	r0, r6
	vmov	s15, r3	@ int
	vcvt.f32.s32	s15, s15
	vmul.f32	s15, s15, s16
	vcvt.f64.f32	d7, s15
	vmov	r2, r3, d7
	bl	printf
	cmp	r4, r5
	bne	.L3
	add	r5, r4, #128
	mov	r0, #10
	bl	putchar
	cmp	r5, r7
	bne	.L2
	vldm	sp!, {d8}
	pop	{r4, r5, r6, r7, r8, pc}
.L9:
	.align	2
.L8:
	.word	998244352
	.word	augmented_matrix+124
	.size	print_matrix_float, .-print_matrix_float
	.align	2
	.global	augment_matrix
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	augment_matrix, %function
augment_matrix:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movw	r1, #:lower16:augmented_matrix
	movw	r0, #:lower16:.LANCHOR0
	mov	ip, #0
	movt	r1, #:upper16:augmented_matrix
	str	lr, [sp, #-4]!
	movt	r0, #:upper16:.LANCHOR0
	add	lr, r1, #2048
.L11:
	mov	r3, #0
	b	.L16
.L19:
	ldr	r2, [r0, r3, lsl #2]
	lsl	r2, r2, #8
	str	r2, [r1, r3, lsl #2]
.L13:
	add	r3, r3, #1
.L16:
	cmp	r3, #15
	sub	r2, r3, #16
	bls	.L19
	cmp	ip, r2
	moveq	r2, #256
	movne	r2, #0
	cmp	r3, #31
	str	r2, [r1, r3, lsl #2]
	bne	.L13
	add	r1, r1, #128
	cmp	r1, lr
	add	ip, ip, #1
	add	r0, r0, #64
	bne	.L11
	ldr	pc, [sp], #4
	.size	augment_matrix, .-augment_matrix
	.align	2
	.global	swap_rows
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	swap_rows, %function
swap_rows:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movw	r2, #:lower16:augmented_matrix
	lsl	r0, r0, #7
	movt	r2, #:upper16:augmented_matrix
	add	r1, r2, r1, lsl #7
	add	ip, r2, #124
	sub	r3, r0, #4
	sub	r1, r1, #4
	add	ip, ip, r0
	add	r3, r3, r2
.L21:
	ldr	r2, [r3, #4]!
	ldr	r0, [r1, #4]!
	cmp	r3, ip
	str	r0, [r3]
	str	r2, [r1]
	bne	.L21
	bx	lr
	.size	swap_rows, .-swap_rows
	.align	2
	.global	find_pivot_row
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	find_pivot_row, %function
find_pivot_row:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movw	r2, #:lower16:augmented_matrix
	add	r3, r0, r0, lsl #5
	movt	r2, #:upper16:augmented_matrix
	ldr	r1, [r2, r3, lsl #2]
	add	r3, r0, #1
	cmp	r1, #0
	rsblt	r1, r1, #0
	cmp	r3, #15
	mov	ip, r0
	bgt	.L24
	add	r0, r2, r0, lsl #2
.L27:
	ldr	r2, [r0, r3, lsl #7]
	cmp	r2, #0
	rsblt	r2, r2, #0
	cmp	r2, r1
	movgt	ip, r3
	add	r3, r3, #1
	movgt	r1, r2
	cmp	r3, #16
	bne	.L27
.L24:
	mov	r0, ip
	bx	lr
	.size	find_pivot_row, .-find_pivot_row
	.global	__aeabi_idiv
	.align	2
	.global	normalize_row
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	normalize_row, %function
normalize_row:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movw	r3, #:lower16:augmented_matrix
	push	{r4, r5, r6, lr}
	mov	r6, r1
	lsl	r0, r0, #7
	movt	r3, #:upper16:augmented_matrix
	add	r5, r3, #124
	sub	r4, r0, #4
	add	r5, r5, r0
	add	r4, r4, r3
.L31:
	ldr	r0, [r4, #4]!
	mov	r1, r6
	lsl	r0, r0, #8
	bl	__aeabi_idiv
	cmp	r4, r5
	str	r0, [r4]
	bne	.L31
	pop	{r4, r5, r6, pc}
	.size	normalize_row, .-normalize_row
	.align	2
	.global	eliminate_other_rows
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	eliminate_other_rows, %function
eliminate_other_rows:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	movw	r4, #:lower16:augmented_matrix
	mov	r6, #0
	movt	r4, #:upper16:augmented_matrix
	add	r7, r4, r0, lsl #7
	add	r1, r4, r1, lsl #2
	sub	r7, r7, #4
	add	r4, r4, #124
.L38:
	cmp	r0, r6
	beq	.L36
	mov	lr, r7
	ldr	r5, [r1, r6, lsl #7]
	sub	r3, r4, #128
.L37:
	ldr	ip, [lr, #4]!
	ldr	r2, [r3, #4]!
	mul	ip, ip, r5
	cmp	r3, r4
	sub	r2, r2, ip, asr #8
	str	r2, [r3]
	bne	.L37
.L36:
	add	r6, r6, #1
	cmp	r6, #16
	add	r4, r4, #128
	bne	.L38
	pop	{r4, r5, r6, r7, pc}
	.size	eliminate_other_rows, .-eliminate_other_rows
	.align	2
	.global	gauss_jordan_fixed_point
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	gauss_jordan_fixed_point, %function
gauss_jordan_fixed_point:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	movw	r8, #:lower16:augmented_matrix
	mov	r6, #0
	movt	r8, #:upper16:augmented_matrix
	mov	r5, r8
	mov	r1, r6
	add	r4, r8, #124
	sub	r7, r8, #4
.L54:
	ldr	fp, [r8]
	add	r9, r1, #1
	eor	r0, fp, fp, asr #31
	cmp	r9, #16
	sub	r0, r0, fp, asr #31
	beq	.L44
	mov	r3, r9
.L46:
	ldr	r2, [r5, r3, lsl #7]
	cmp	r2, #0
	rsblt	r2, r2, #0
	cmp	r2, r0
	movgt	r1, r3
	add	r3, r3, #1
	movgt	r0, r2
	cmp	r3, #16
	bne	.L46
	cmp	r1, r6
	bne	.L67
.L44:
	mov	r10, r7
.L48:
	ldr	r0, [r10, #4]!
	mov	r1, fp
	lsl	r0, r0, #8
	bl	__aeabi_idiv
	cmp	r10, r4
	str	r0, [r10]
	bne	.L48
	mov	r10, #0
	ldr	ip, .L68
.L50:
	cmp	r10, r6
	beq	.L53
	mov	r0, r7
	ldr	lr, [r5, r10, lsl #7]
	sub	r3, ip, #128
.L52:
	ldr	r1, [r0, #4]!
	ldr	r2, [r3, #4]!
	mul	r1, r1, lr
	cmp	r3, ip
	sub	r2, r2, r1, asr #8
	str	r2, [r3]
	bne	.L52
.L53:
	add	r10, r10, #1
	cmp	r10, #16
	add	ip, ip, #128
	bne	.L50
	cmp	r9, #16
	add	r6, r6, #1
	add	r8, r8, #132
	add	r7, r7, #128
	add	r5, r5, #4
	add	r4, r4, #128
	mov	r1, r9
	bne	.L54
	pop	{r3, r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L67:
	movw	r0, #:lower16:augmented_matrix
	mov	r2, r7
	lsl	r1, r1, #7
	sub	r3, r1, #4
	movt	r0, #:upper16:augmented_matrix
	add	r3, r0, r3
	add	r0, r0, #124
	add	r1, r1, r0
.L47:
	ldr	r0, [r3, #4]!
	ldr	ip, [r2, #4]!
	cmp	r3, r1
	str	ip, [r3]
	str	r0, [r2]
	bne	.L47
	ldr	fp, [r8]
	b	.L44
.L69:
	.align	2
.L68:
	.word	augmented_matrix+124
	.size	gauss_jordan_fixed_point, .-gauss_jordan_fixed_point
	.align	2
	.global	estimate_condition_number
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	estimate_condition_number, %function
estimate_condition_number:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	add	ip, r0, #60
	add	lr, r0, #1072
	mov	r0, #0
	add	lr, lr, #12
.L71:
	mov	r1, #0
	sub	r3, ip, #64
.L74:
	ldr	r2, [r3, #4]!
	cmp	r2, #0
	sublt	r1, r1, r2
	addge	r1, r1, r2
	cmp	r3, ip
	bne	.L74
	cmp	r0, r1
	add	ip, r3, #64
	movlt	r0, r1
	cmp	ip, lr
	bne	.L71
	ldr	pc, [sp], #4
	.size	estimate_condition_number, .-estimate_condition_number
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movw	r0, #:lower16:.LC2
	push	{r4, r5, r6, r7, r8, lr}
	movw	r5, #:lower16:.LANCHOR0
	movt	r0, #:upper16:.LC2
	bl	puts
	mov	ip, #0
	movt	r5, #:upper16:.LANCHOR0
	add	r0, r5, #60
	add	lr, r0, #1024
.L79:
	mov	r1, #0
	sub	r3, r0, #64
.L82:
	ldr	r2, [r3, #4]!
	cmp	r2, #0
	sublt	r1, r1, r2
	addge	r1, r1, r2
	cmp	r3, r0
	bne	.L82
	cmp	ip, r1
	add	r0, r3, #64
	movlt	ip, r1
	cmp	r0, lr
	bne	.L79
	vmov	s15, ip	@ int
	vcvt.f32.s32	s15, s15
	movw	r0, #:lower16:.LC3
	vcvt.f64.f32	d7, s15
	movw	r7, #:lower16:.LC4
	vmov	r2, r3, d7
	movt	r0, #:upper16:.LC3
	bl	printf
	ldr	r6, .L98+8
	movt	r7, #:upper16:.LC4
	add	r8, r6, #1024
.L84:
	sub	r4, r6, #64
.L85:
	ldr	r1, [r4], #4
	mov	r0, r7
	bl	printf
	cmp	r4, r6
	bne	.L85
	add	r6, r4, #64
	mov	r0, #10
	bl	putchar
	cmp	r6, r8
	bne	.L84
	bl	clock
	movw	r1, #:lower16:augmented_matrix
	mov	r6, r0
	mov	r0, #0
	movt	r1, #:upper16:augmented_matrix
	add	ip, r1, #2048
.L87:
	mov	r3, #0
	b	.L92
.L97:
	ldr	r2, [r5, r3, lsl #2]
	lsl	r2, r2, #8
	str	r2, [r1, r3, lsl #2]
.L89:
	add	r3, r3, #1
.L92:
	cmp	r3, #15
	sub	r2, r3, #16
	bls	.L97
	cmp	r2, r0
	moveq	r2, #256
	movne	r2, #0
	cmp	r3, #31
	str	r2, [r1, r3, lsl #2]
	bne	.L89
	add	r1, r1, #128
	cmp	r1, ip
	add	r0, r0, #1
	add	r5, r5, #64
	bne	.L87
	bl	gauss_jordan_fixed_point
	bl	clock
	mov	r4, r0
	sub	r4, r4, r6
	bl	print_matrix_float
	vmov	s15, r4	@ int
	vldr.64	d6, .L98
	vcvt.f64.s32	d7, s15
	movw	r0, #:lower16:.LC5
	vdiv.f64	d7, d7, d6
	movt	r0, #:upper16:.LC5
	vmov	r2, r3, d7
	bl	printf
	mov	r0, #0
	pop	{r4, r5, r6, r7, r8, pc}
.L99:
	.align	3
.L98:
	.word	0
	.word	1093567616
	.word	.LANCHOR0+64
	.size	main, .-main
	.comm	augmented_matrix,2048,4
	.global	test_matrix
	.data
	.align	2
	.set	.LANCHOR0,. + 0
	.type	test_matrix, %object
	.size	test_matrix, 1024
test_matrix:
	.word	16
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	7
	.word	8
	.word	9
	.word	10
	.word	11
	.word	12
	.word	13
	.word	14
	.word	15
	.word	1
	.word	1
	.word	15
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	7
	.word	8
	.word	9
	.word	10
	.word	11
	.word	12
	.word	13
	.word	14
	.word	2
	.word	2
	.word	1
	.word	14
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	7
	.word	8
	.word	9
	.word	10
	.word	11
	.word	12
	.word	13
	.word	3
	.word	3
	.word	2
	.word	1
	.word	13
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	7
	.word	8
	.word	9
	.word	10
	.word	11
	.word	12
	.word	4
	.word	4
	.word	3
	.word	2
	.word	1
	.word	12
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	7
	.word	8
	.word	9
	.word	10
	.word	11
	.word	5
	.word	5
	.word	4
	.word	3
	.word	2
	.word	1
	.word	11
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	7
	.word	8
	.word	9
	.word	10
	.word	6
	.word	6
	.word	5
	.word	4
	.word	3
	.word	2
	.word	1
	.word	10
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	7
	.word	8
	.word	9
	.word	7
	.word	7
	.word	6
	.word	5
	.word	4
	.word	3
	.word	2
	.word	1
	.word	9
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	7
	.word	8
	.word	8
	.word	8
	.word	7
	.word	6
	.word	5
	.word	4
	.word	3
	.word	2
	.word	1
	.word	8
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	7
	.word	9
	.word	9
	.word	8
	.word	7
	.word	6
	.word	5
	.word	4
	.word	3
	.word	2
	.word	1
	.word	7
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	10
	.word	10
	.word	9
	.word	8
	.word	7
	.word	6
	.word	5
	.word	4
	.word	3
	.word	2
	.word	1
	.word	6
	.word	2
	.word	3
	.word	4
	.word	5
	.word	11
	.word	11
	.word	10
	.word	9
	.word	8
	.word	7
	.word	6
	.word	5
	.word	4
	.word	3
	.word	2
	.word	1
	.word	5
	.word	2
	.word	3
	.word	4
	.word	12
	.word	12
	.word	11
	.word	10
	.word	9
	.word	8
	.word	7
	.word	6
	.word	5
	.word	4
	.word	3
	.word	2
	.word	1
	.word	4
	.word	2
	.word	3
	.word	13
	.word	13
	.word	12
	.word	11
	.word	10
	.word	9
	.word	8
	.word	7
	.word	6
	.word	5
	.word	4
	.word	3
	.word	2
	.word	1
	.word	3
	.word	2
	.word	14
	.word	14
	.word	13
	.word	12
	.word	11
	.word	10
	.word	9
	.word	8
	.word	7
	.word	6
	.word	5
	.word	4
	.word	3
	.word	2
	.word	1
	.word	2
	.word	15
	.word	15
	.word	14
	.word	13
	.word	12
	.word	11
	.word	10
	.word	9
	.word	8
	.word	7
	.word	6
	.word	5
	.word	4
	.word	3
	.word	2
	.word	1
	.word	16
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"\012Inverted test_matrix (fixed-point, shown as flo"
	.ascii	"at):\000"
	.space	3
.LC1:
	.ascii	"%7.4f \000"
	.space	1
.LC2:
	.ascii	"Original test_matrix:\000"
	.space	2
.LC3:
	.ascii	"\012Estimated (pre-execution) condition number (\342"
	.ascii	"\210\236-norm): %.4f\012\000"
	.space	2
.LC4:
	.ascii	"%d \000"
.LC5:
	.ascii	"\012Gauss-Jordan elimination time: %.6f seconds\012"
	.ascii	"\000"
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
