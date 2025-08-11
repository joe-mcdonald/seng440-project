	.cpu cortex-a15
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
	.file	"matrix_inversion_neon.c"
	.text
	.align	2
	.global	print_matrix_float
	.arch armv7ve
	.syntax unified
	.arm
	.fpu neon
	.type	print_matrix_float, %function
print_matrix_float:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	strd	r4, [sp, #-24]!
	movw	r0, #:lower16:.LC0
	strd	r6, [sp, #8]
	ldr	r6, .L8+4
	movw	r7, #:lower16:.LC1
	str	r8, [sp, #16]
	movt	r0, #:upper16:.LC0
	movt	r7, #:upper16:.LC1
	str	lr, [sp, #20]
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
	ldrd	r4, [sp]
	ldrd	r6, [sp, #8]
	ldr	r8, [sp, #16]
	add	sp, sp, #20
	ldr	pc, [sp], #4
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
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	strd	r4, [sp, #-16]!
	movw	r5, #:lower16:augmented_matrix
	movw	r2, #:lower16:.LANCHOR0
	movt	r5, #:upper16:augmented_matrix
	mov	r1, #0
	str	r6, [sp, #8]
	mov	r3, r5
	movt	r2, #:upper16:.LANCHOR0
	str	lr, [sp, #12]
	mov	r0, r1
	sub	sp, sp, #16
	mov	r6, #256
.L11:
	ldm	r2, {r4, lr}
	cmp	r1, #0
	ldr	ip, [r2, #8]
	stm	sp, {r4, lr}
	str	ip, [sp, #8]
	str	r0, [sp, #12]
	vld1.32	{d16-d17}, [sp:64]
	vshl.i32	q8, q8, #8
	vst1.32	{d16-d17}, [r3]
	beq	.L20
	cmp	r1, #1
	str	r0, [r3, #12]
	beq	.L12
	mov	r2, #256
	str	r0, [r3, #16]
	str	r2, [r5, #68]
	add	sp, sp, #16
	@ sp needed
	ldrd	r4, [sp]
	ldr	r6, [sp, #8]
	add	sp, sp, #12
	ldr	pc, [sp], #4
.L20:
	add	r2, r2, #12
	add	r3, r3, #24
	str	r6, [r3, #-12]
	str	r1, [r3, #-8]
	str	r1, [r3, #-4]
	mov	r1, #1
	b	.L11
.L12:
	add	r2, r2, #12
	mov	r1, #2
	str	r6, [r3, #16]
	add	r3, r3, #24
	str	r0, [r3, #-4]
	b	.L11
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
.L22:
	ldr	r2, [r3, #4]!
	ldr	r0, [r1, #4]!
	cmp	r3, ip
	str	r0, [r3]
	str	r2, [r1]
	bne	.L22
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
	bgt	.L24
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
.L24:
	bx	lr
	.size	find_pivot_row, .-find_pivot_row
	.align	2
	.global	normalize_row
	.syntax unified
	.arm
	.fpu neon
	.type	normalize_row, %function
normalize_row:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	add	r0, r0, r0, lsl #1
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	lsl	r3, r0, #3
	add	r0, r2, #16
	sub	sp, sp, #24
	add	r0, r3, r0
	add	r3, r3, r2
	add	ip, sp, #24
	mov	r2, sp
	vld1.32	{d18-d19}, [r0]
	sub	r0, r3, #4
	vld1.32	{d16-d17}, [r3]
	add	r3, sp, #16
	vshl.i32	q9, q9, #8
	vshl.i32	q8, q8, #8
	vst1.32	{d18-d19}, [r3:64]
	vst1.32	{d16-d17}, [sp:64]
.L31:
	ldr	r3, [r2], #4
	sdiv	r3, r3, r1
	cmp	r2, ip
	str	r3, [r0, #4]!
	bne	.L31
	add	sp, sp, #24
	@ sp needed
	bx	lr
	.size	normalize_row, .-normalize_row
	.align	2
	.global	eliminate_other_rows
	.syntax unified
	.arm
	.fpu neon
	.type	eliminate_other_rows, %function
eliminate_other_rows:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	strd	r4, [sp, #-16]!
	lsl	r5, r0, #1
	str	r6, [sp, #8]
	add	r2, r5, r0
	str	lr, [sp, #12]
	movw	lr, #:lower16:augmented_matrix
	lsl	r2, r2, #3
	sub	sp, sp, #24
	movt	lr, #:upper16:augmented_matrix
	sub	r2, r2, #4
	mov	r3, sp
	add	r4, sp, #24
	add	r2, lr, r2
.L35:
	ldr	ip, [r2, #4]!
	str	ip, [r3], #4
	cmp	r4, r3
	bne	.L35
	add	r5, r5, r0
	movw	r3, #:lower16:augmented_matrix
	add	lr, lr, r5, lsl #3
	movt	r3, #:upper16:augmented_matrix
	mov	r2, #0
.L37:
	cmp	r0, r2
	add	r2, r2, #1
	beq	.L36
	ldr	r5, [r3, r1, lsl #2]
	vld1.32	{d16-d17}, [sp:64]
	vld1.32	{d18-d19}, [r3]
	ldr	r4, [r3, #16]
	vmov.32	d7[0], r5
	ldr	ip, [r3, #20]
	vmul.i32	q8, q8, d7[0]
	vshr.s32	q8, q8, #8
	vsub.i32	q8, q9, q8
	vst1.32	{d16-d17}, [r3]
	ldr	r6, [lr, #16]
	mul	r6, r6, r5
	sub	r4, r4, r6, asr #8
	str	r4, [r3, #16]
	ldr	r4, [lr, #20]
	mul	r4, r4, r5
	sub	ip, ip, r4, asr #8
	str	ip, [r3, #20]
.L36:
	cmp	r2, #3
	add	r3, r3, #24
	bne	.L37
	add	sp, sp, #24
	@ sp needed
	ldrd	r4, [sp]
	ldr	r6, [sp, #8]
	add	sp, sp, #12
	ldr	pc, [sp], #4
	.size	eliminate_other_rows, .-eliminate_other_rows
	.align	2
	.global	gauss_jordan_fixed_point
	.syntax unified
	.arm
	.fpu neon
	.type	gauss_jordan_fixed_point, %function
gauss_jordan_fixed_point:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	strd	r4, [sp, #-28]!
	movw	r4, #:lower16:augmented_matrix
	mov	r1, #0
	movt	r4, #:upper16:augmented_matrix
	strd	r6, [sp, #8]
	mov	r5, r4
	sub	r4, r4, #4
	strd	r8, [sp, #16]
	add	r6, r5, #20
	mov	r8, r5
	str	lr, [sp, #24]
	sub	sp, sp, #28
.L47:
	add	r7, r1, #1
	ldr	ip, [r8]
	cmp	r7, #3
	beq	.L42
	eor	lr, ip, ip, asr #31
	mov	r9, r8
	mov	r2, r1
	sub	lr, lr, ip, asr #31
	mov	r0, r7
.L44:
	ldr	r3, [r9, #24]!
	cmp	r3, #0
	rsblt	r3, r3, #0
	cmp	r3, lr
	movgt	r2, r0
	movgt	lr, r3
	cmp	r0, #2
	mov	r0, #2
	bne	.L44
	cmp	r2, r1
	beq	.L42
	add	r3, r2, r2, lsl #1
	mov	r0, r4
	lsl	r3, r3, #3
	sub	r2, r3, #4
	add	r3, r6, r3
	add	r2, r5, r2
.L45:
	ldr	ip, [r2, #4]!
	ldr	lr, [r0, #4]!
	cmp	r2, r3
	str	lr, [r2]
	str	ip, [r0]
	bne	.L45
	ldr	ip, [r8]
.L42:
	add	r0, r4, #4
	add	r3, r4, #20
	mov	r2, sp
	add	lr, sp, #24
	vld1.32	{d18-d19}, [r0]
	mov	r0, r4
	vld1.32	{d16-d17}, [r3]
	add	r3, sp, #16
	vshl.i32	q9, q9, #8
	vshl.i32	q8, q8, #8
	vst1.32	{d18-d19}, [sp:64]
	vst1.32	{d16-d17}, [r3:64]
.L46:
	ldr	r3, [r2], #4
	sdiv	r3, r3, ip
	cmp	r2, lr
	str	r3, [r0, #4]!
	bne	.L46
	mov	r0, r1
	add	r8, r8, #28
	bl	eliminate_other_rows
	cmp	r7, #3
	add	r4, r4, #24
	mov	r1, r7
	bne	.L47
	add	sp, sp, #28
	@ sp needed
	ldrd	r4, [sp]
	ldrd	r6, [sp, #8]
	ldrd	r8, [sp, #16]
	add	sp, sp, #24
	ldr	pc, [sp], #4
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
	add	ip, r0, #8
	add	r0, r0, #44
	str	lr, [sp, #-4]!
	mov	lr, #0
.L57:
	sub	r3, ip, #12
	mov	r1, #0
.L60:
	ldr	r2, [r3, #4]!
	cmp	r2, #0
	sublt	r1, r1, r2
	addge	r1, r1, r2
	cmp	r3, ip
	bne	.L60
	cmp	lr, r1
	add	ip, r3, #12
	movlt	lr, r1
	cmp	ip, r0
	bne	.L57
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
	movw	r0, #:lower16:.LC2
	strd	r4, [sp, #-16]!
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	movt	r0, #:upper16:.LC2
	str	r6, [sp, #8]
	str	lr, [sp, #12]
	bl	puts
	add	r0, r4, #8
	add	lr, r4, #44
	mov	ip, #0
.L65:
	sub	r3, r0, #12
	mov	r1, #0
.L68:
	ldr	r2, [r3, #4]!
	cmp	r2, #0
	sublt	r1, r1, r2
	addge	r1, r1, r2
	cmp	r3, r0
	bne	.L68
	cmp	ip, r1
	add	r0, r3, #12
	movlt	ip, r1
	cmp	r0, lr
	bne	.L65
	vmov	s15, ip	@ int
	movw	r0, #:lower16:.LC3
	movw	r5, #:lower16:.LC4
	movt	r0, #:upper16:.LC3
	ldr	r6, .L74+8
	movt	r5, #:upper16:.LC4
	vcvt.f32.s32	s15, s15
	vcvt.f64.f32	d16, s15
	vmov	r2, r3, d16
	bl	printf
.L70:
	mov	r0, r5
	ldr	r1, [r4]
	add	r4, r4, #12
	bl	printf
	mov	r0, r5
	ldr	r1, [r4, #-8]
	bl	printf
	mov	r0, r5
	ldr	r1, [r4, #-4]
	bl	printf
	mov	r0, #10
	bl	putchar
	cmp	r4, r6
	bne	.L70
	bl	clock
	mov	r5, r0
	bl	augment_matrix
	bl	gauss_jordan_fixed_point
	bl	clock
	mov	r4, r0
	sub	r4, r4, r5
	bl	print_matrix_float
	vmov	s15, r4	@ int
	vldr.64	d17, .L74
	movw	r0, #:lower16:.LC5
	movt	r0, #:upper16:.LC5
	vcvt.f64.s32	d16, s15
	vdiv.f64	d16, d16, d17
	vmov	r2, r3, d16
	bl	printf
	ldrd	r4, [sp]
	mov	r0, #0
	ldr	r6, [sp, #8]
	add	sp, sp, #12
	ldr	pc, [sp], #4
.L75:
	.align	3
.L74:
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
