	.cpu cortex-a9
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
	.fpu neon
	.type	print_matrix_float, %function
print_matrix_float:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	movw	r7, #:lower16:.LC1
	ldr	r6, .L8+4
	movw	r0, #:lower16:.LC0
	movt	r7, #:upper16:.LC1
	movt	r0, #:upper16:.LC0
	vpush.64	{d8}
	vldr.32	s16, .L8
	add	r8, r6, #72
	bl	puts
.L2:
	mov	r5, r6
	mov	r4, #3
.L3:
	vldmia.32	r5!, {s15}	@ int
	add	r4, r4, #1
	mov	r0, r7
	vcvt.f32.s32	s15, s15
	vmul.f32	s15, s15, s16
	vcvt.f64.f32	d16, s15
	vmov	r2, r3, d16
	bl	printf
	cmp	r4, #6
	bne	.L3
	add	r6, r6, #24
	mov	r0, #10
	bl	putchar
	cmp	r6, r8
	bne	.L2
	vldm	sp!, {d8}
	pop	{r4, r5, r6, r7, r8, pc}
.L9:
	.align	2
.L8:
	.word	998244352
	.word	augmented_matrix+12
	.size	print_matrix_float, .-print_matrix_float
	.align	2
	.global	augment_matrix
	.syntax unified
	.arm
	.fpu neon
	.type	augment_matrix, %function
augment_matrix:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	movw	ip, #:lower16:.LANCHOR0
	movw	lr, #:lower16:augmented_matrix
	movt	ip, #:upper16:.LANCHOR0
	movt	lr, #:upper16:augmented_matrix
	mov	r0, #0
.L11:
	mov	r2, lr
	mov	r3, #0
	b	.L16
.L19:
	ldr	r1, [ip, r3, lsl #2]
	lsl	r1, r1, #8
	str	r1, [r2]
.L13:
	add	r3, r3, #1
	add	r2, r2, #4
.L16:
	cmp	r3, #2
	sub	r1, r3, #3
	bls	.L19
	cmp	r0, r1
	moveq	r1, #256
	movne	r1, #0
	cmp	r3, #5
	str	r1, [r2]
	bne	.L13
	add	r0, r0, #1
	add	lr, lr, #24
	cmp	r0, #3
	add	ip, ip, #12
	bne	.L11
	ldr	pc, [sp], #4
	.size	augment_matrix, .-augment_matrix
	.align	2
	.global	swap_rows
	.syntax unified
	.arm
	.fpu neon
	.type	swap_rows, %function
swap_rows:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	add	r0, r0, r0, lsl #1
	add	r1, r1, r1, lsl #1
	movw	r2, #:lower16:augmented_matrix
	lsl	r0, r0, #3
	movt	r2, #:upper16:augmented_matrix
	add	r1, r2, r1, lsl #3
	sub	r3, r0, #4
	add	ip, r2, #20
	add	r3, r3, r2
	add	ip, ip, r0
	sub	r1, r1, #4
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
	.fpu neon
	.type	find_pivot_row, %function
find_pivot_row:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	add	r2, r0, #1
	cmp	r2, #2
	bxgt	lr
	rsb	r3, r0, r0, lsl #3
	movw	ip, #:lower16:augmented_matrix
	movt	ip, #:upper16:augmented_matrix
	lsl	r3, r3, #2
	ldr	r1, [ip, r3]
	add	ip, ip, r3
	cmp	r1, #0
	rsblt	r1, r1, #0
.L27:
	ldr	r3, [ip, #24]!
	cmp	r3, #0
	rsblt	r3, r3, #0
	cmp	r3, r1
	movgt	r0, r2
	add	r2, r2, #1
	movgt	r1, r3
	cmp	r2, #3
	bne	.L27
	bx	lr
	.size	find_pivot_row, .-find_pivot_row
	.global	__aeabi_idiv
	.align	2
	.global	normalize_row
	.syntax unified
	.arm
	.fpu neon
	.type	normalize_row, %function
normalize_row:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	add	r0, r0, r0, lsl #1
	movw	r3, #:lower16:augmented_matrix
	movt	r3, #:upper16:augmented_matrix
	lsl	r0, r0, #3
	push	{r4, r5, r6, lr}
	add	r5, r3, #20
	sub	r4, r0, #4
	mov	r6, r1
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
	.fpu neon
	.type	eliminate_other_rows, %function
eliminate_other_rows:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	movw	r3, #:lower16:augmented_matrix
	add	r7, r0, r0, lsl #1
	movt	r3, #:upper16:augmented_matrix
	lsl	r1, r1, #2
	add	r4, r3, #20
	add	r3, r3, r7, lsl #3
	mov	r5, #0
	sub	r1, r1, #20
	sub	r7, r3, #4
.L38:
	cmp	r0, r5
	beq	.L36
	ldr	r6, [r1, r4]
	sub	r3, r4, #24
	mov	lr, r7
.L37:
	ldr	ip, [lr, #4]!
	ldr	r2, [r3, #4]!
	mul	ip, ip, r6
	cmp	r3, r4
	sub	r2, r2, ip, asr #8
	str	r2, [r3]
	bne	.L37
.L36:
	add	r5, r5, #1
	add	r4, r4, #24
	cmp	r5, #3
	bne	.L38
	pop	{r4, r5, r6, r7, pc}
	.size	eliminate_other_rows, .-eliminate_other_rows
	.align	2
	.global	gauss_jordan_fixed_point
	.syntax unified
	.arm
	.fpu neon
	.type	gauss_jordan_fixed_point, %function
gauss_jordan_fixed_point:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	movw	r3, #:lower16:augmented_matrix
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	movt	r3, #:upper16:augmented_matrix
	mov	r5, #0
	mov	r2, r5
	mov	r8, r3
	add	r4, r3, #20
	sub	r6, r3, #4
	mvn	r9, #19
	sub	sp, sp, #12
	str	r3, [sp, #4]
.L54:
	ldr	fp, [r8]
	add	r7, r2, #1
	cmp	r7, #3
	eor	r1, fp, fp, asr #31
	sub	r1, r1, fp, asr #31
	beq	.L44
	mov	ip, r8
	mov	r0, r7
.L46:
	ldr	r3, [ip, #24]!
	cmp	r3, #0
	rsblt	r3, r3, #0
	cmp	r3, r1
	movgt	r2, r0
	movgt	r1, r3
	cmp	r0, #2
	mov	r0, #2
	bne	.L46
	cmp	r2, r5
	beq	.L44
	add	r3, r2, r2, lsl #1
	ldr	r0, .L66
	mov	r1, r6
	lsl	r3, r3, #3
	sub	r2, r3, #4
	add	r3, r3, r0
	ldr	r0, [sp, #4]
	add	r2, r0, r2
.L47:
	ldr	r0, [r2, #4]!
	ldr	ip, [r1, #4]!
	cmp	r2, r3
	str	ip, [r2]
	str	r0, [r1]
	bne	.L47
	ldr	fp, [r8]
.L44:
	mov	r10, r6
.L48:
	ldr	r0, [r10, #4]!
	mov	r1, fp
	lsl	r0, r0, #8
	bl	__aeabi_idiv
	cmp	r10, r4
	str	r0, [r10]
	bne	.L48
	ldr	r0, .L66
	mov	ip, #0
.L50:
	cmp	ip, r5
	beq	.L53
	ldr	r10, [r9, r0]
	sub	r3, r0, #24
	mov	lr, r6
.L52:
	ldr	r1, [lr, #4]!
	ldr	r2, [r3, #4]!
	mul	r1, r1, r10
	cmp	r3, r0
	sub	r2, r2, r1, asr #8
	str	r2, [r3]
	bne	.L52
.L53:
	add	ip, ip, #1
	add	r0, r0, #24
	cmp	ip, #3
	bne	.L50
	cmp	r7, #3
	add	r5, r5, #1
	add	r8, r8, #28
	add	r6, r6, #24
	add	r9, r9, #4
	add	r4, r4, #24
	mov	r2, r7
	bne	.L54
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L67:
	.align	2
.L66:
	.word	augmented_matrix+20
	.size	gauss_jordan_fixed_point, .-gauss_jordan_fixed_point
	.align	2
	.global	estimate_condition_number
	.syntax unified
	.arm
	.fpu neon
	.type	estimate_condition_number, %function
estimate_condition_number:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	add	ip, r0, #8
	mov	lr, #0
	add	r0, r0, #44
.L69:
	sub	r3, ip, #12
	mov	r1, #0
.L72:
	ldr	r2, [r3, #4]!
	cmp	r2, #0
	sublt	r1, r1, r2
	addge	r1, r1, r2
	cmp	r3, ip
	bne	.L72
	cmp	lr, r1
	add	ip, r3, #12
	movlt	lr, r1
	cmp	ip, r0
	bne	.L69
	mov	r0, lr
	ldr	pc, [sp], #4
	.size	estimate_condition_number, .-estimate_condition_number
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu neon
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	movw	r0, #:lower16:.LC2
	movw	r4, #:lower16:.LANCHOR0
	movt	r0, #:upper16:.LC2
	movt	r4, #:upper16:.LANCHOR0
	bl	puts
	add	r0, r4, #8
	add	lr, r4, #44
	mov	ip, #0
.L77:
	sub	r3, r0, #12
	mov	r1, #0
.L80:
	ldr	r2, [r3, #4]!
	cmp	r2, #0
	sublt	r1, r1, r2
	addge	r1, r1, r2
	cmp	r3, r0
	bne	.L80
	cmp	ip, r1
	add	r0, r3, #12
	movlt	ip, r1
	cmp	r0, lr
	bne	.L77
	vmov	s15, ip	@ int
	movw	r0, #:lower16:.LC3
	ldr	r7, .L94+8
	movw	r6, #:lower16:.LC4
	vcvt.f32.s32	s15, s15
	movt	r0, #:upper16:.LC3
	movt	r6, #:upper16:.LC4
	sub	r5, r7, #36
	vcvt.f64.f32	d16, s15
	vmov	r2, r3, d16
	bl	printf
.L82:
	ldr	r1, [r5]
	mov	r0, r6
	bl	printf
	ldr	r1, [r5, #4]
	mov	r0, r6
	bl	printf
	ldr	r1, [r5, #8]
	mov	r0, r6
	bl	printf
	add	r5, r5, #12
	mov	r0, #10
	bl	putchar
	cmp	r5, r7
	bne	.L82
	bl	clock
	movw	ip, #:lower16:augmented_matrix
	mov	r5, r0
	movt	ip, #:upper16:augmented_matrix
	mov	r0, #0
.L83:
	mov	r2, ip
	mov	r3, #0
	b	.L88
.L93:
	ldr	r1, [r4, r3, lsl #2]
	lsl	r1, r1, #8
	str	r1, [r2]
.L85:
	add	r3, r3, #1
	add	r2, r2, #4
.L88:
	cmp	r3, #2
	sub	r1, r3, #3
	bls	.L93
	cmp	r1, r0
	moveq	r1, #256
	movne	r1, #0
	cmp	r3, #5
	str	r1, [r2]
	bne	.L85
	add	r0, r0, #1
	add	ip, ip, #24
	cmp	r0, #3
	add	r4, r4, #12
	bne	.L83
	bl	gauss_jordan_fixed_point
	bl	clock
	mov	r4, r0
	sub	r4, r4, r5
	bl	print_matrix_float
	vmov	s15, r4	@ int
	movw	r0, #:lower16:.LC5
	vldr.64	d17, .L94
	movt	r0, #:upper16:.LC5
	vcvt.f64.s32	d16, s15
	vdiv.f64	d16, d16, d17
	vmov	r2, r3, d16
	bl	printf
	mov	r0, #0
	pop	{r4, r5, r6, r7, r8, pc}
.L95:
	.align	3
.L94:
	.word	0
	.word	1093567616
	.word	.LANCHOR0+36
	.size	main, .-main
	.comm	augmented_matrix,72,4
	.global	test_matrix
	.data
	.align	2
	.set	.LANCHOR0,. + 0
	.type	test_matrix, %object
	.size	test_matrix, 36
test_matrix:
	.word	3
	.word	2
	.word	-4
	.word	2
	.word	3
	.word	3
	.word	5
	.word	-3
	.word	1
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
