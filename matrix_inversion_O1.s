	.arch armv7-a
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 1
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
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	vpush.64	{d8}
	movw	r0, #:lower16:.LC0
	movt	r0, #:upper16:.LC0
	bl	puts
	ldr	r6, .L8+4
	add	r9, r6, #72
	vldr.32	s16, .L8
	movw	r7, #:lower16:.LC1
	movt	r7, #:upper16:.LC1
	mov	r8, #10
	b	.L2
.L7:
	mov	r0, r8
	bl	putchar
	add	r6, r6, #24
	cmp	r6, r9
	beq	.L1
.L2:
	mov	r5, r6
	mov	r4, #3
.L3:
	vldmia.32	r5!, {s15}	@ int
	vcvt.f32.s32	s15, s15
	vmul.f32	s15, s15, s16
	vcvt.f64.f32	d7, s15
	vmov	r2, r3, d7
	mov	r0, r7
	bl	printf
	add	r4, r4, #1
	cmp	r4, #6
	bne	.L3
	b	.L7
.L1:
	vldm	sp!, {d8}
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
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
	.fpu vfpv3-d16
	.type	augment_matrix, %function
augment_matrix:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	movw	lr, #:lower16:augmented_matrix
	movt	lr, #:upper16:augmented_matrix
	movw	ip, #:lower16:.LANCHOR0
	movt	ip, #:upper16:.LANCHOR0
	mov	r0, #0
	b	.L11
.L12:
	sub	r1, r3, #3
	cmp	r0, r1
	moveq	r1, #256
	movne	r1, #0
	str	r1, [r2]
	add	r1, r3, #1
	cmp	r1, #5
	bgt	.L19
.L13:
	add	r3, r3, #1
	add	r2, r2, #4
.L16:
	cmp	r3, #2
	bgt	.L12
	ldr	r1, [ip, r3, lsl #2]
	lsl	r1, r1, #8
	str	r1, [r2]
	b	.L13
.L19:
	add	r0, r0, #1
	add	lr, lr, #24
	add	ip, ip, #12
	cmp	r0, #3
	ldreq	pc, [sp], #4
.L11:
	mov	r2, lr
	mov	r3, #0
	b	.L16
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
	add	r0, r0, r0, lsl #1
	lsl	r0, r0, #3
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	add	r3, r0, r2
	add	r1, r1, r1, lsl #1
	add	r1, r2, r1, lsl #3
	add	r2, r2, #24
	add	r0, r2, r0
.L21:
	ldr	r2, [r3]
	ldr	ip, [r1]
	str	ip, [r3], #4
	str	r2, [r1], #4
	cmp	r3, r0
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
	add	r1, r0, #1
	cmp	r1, #2
	bxgt	lr
	movw	ip, #:lower16:augmented_matrix
	movt	ip, #:upper16:augmented_matrix
	rsb	r3, r0, r0, lsl #3
	lsl	r3, r3, #2
	ldr	r2, [ip, r3]
	cmp	r2, #0
	rsblt	r2, r2, #0
	add	ip, ip, r3
.L27:
	ldr	r3, [ip, #24]!
	cmp	r3, #0
	rsblt	r3, r3, #0
	cmp	r3, r2
	movgt	r0, r1
	cmp	r3, r2
	movge	r2, r3
	add	r1, r1, #1
	cmp	r1, #3
	bne	.L27
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
	push	{r4, r5, r6, lr}
	mov	r6, r1
	add	r0, r0, r0, lsl #1
	lsl	r5, r0, #3
	movw	r3, #:lower16:augmented_matrix
	movt	r3, #:upper16:augmented_matrix
	add	r4, r5, r3
	add	r3, r3, #24
	add	r5, r3, r5
.L31:
	ldr	r0, [r4]
	mov	r1, r6
	lsl	r0, r0, #8
	bl	__aeabi_idiv
	str	r0, [r4], #4
	cmp	r4, r5
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
	movw	r3, #:lower16:augmented_matrix
	movt	r3, #:upper16:augmented_matrix
	add	r4, r3, #24
	lsl	r1, r1, #2
	sub	r1, r1, #24
	add	r7, r0, r0, lsl #1
	add	r7, r3, r7, lsl #3
	mov	r5, #0
	b	.L38
.L36:
	add	r5, r5, #1
	add	r4, r4, #24
	cmp	r5, #3
	popeq	{r4, r5, r6, r7, pc}
.L38:
	cmp	r0, r5
	beq	.L36
	ldr	r6, [r1, r4]
	sub	r3, r4, #24
	mov	lr, r7
.L37:
	ldr	r2, [r3]
	ldr	ip, [lr], #4
	mul	ip, r6, ip
	sub	r2, r2, ip, asr #8
	str	r2, [r3], #4
	cmp	r3, r4
	bne	.L37
	b	.L36
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
	push	{r4, r5, r6, lr}
	movw	r5, #:lower16:augmented_matrix
	movt	r5, #:upper16:augmented_matrix
	mov	r4, #0
	b	.L45
.L49:
	mov	r1, r4
	bl	swap_rows
.L44:
	ldr	r1, [r5], #28
	mov	r0, r4
	bl	normalize_row
	mov	r1, r4
	mov	r0, r4
	bl	eliminate_other_rows
	add	r4, r4, #1
	cmp	r4, #3
	popeq	{r4, r5, r6, pc}
.L45:
	mov	r0, r4
	bl	find_pivot_row
	cmp	r0, r4
	beq	.L44
	b	.L49
	.size	gauss_jordan_fixed_point, .-gauss_jordan_fixed_point
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	movw	r0, #:lower16:.LC2
	movt	r0, #:upper16:.LC2
	bl	puts
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	add	r7, r4, #36
	movw	r5, #:lower16:.LC3
	movt	r5, #:upper16:.LC3
	mov	r6, #10
.L51:
	ldr	r1, [r4]
	mov	r0, r5
	bl	printf
	ldr	r1, [r4, #4]
	mov	r0, r5
	bl	printf
	ldr	r1, [r4, #8]
	mov	r0, r5
	bl	printf
	mov	r0, r6
	bl	putchar
	add	r4, r4, #12
	cmp	r4, r7
	bne	.L51
	bl	augment_matrix
	bl	gauss_jordan_fixed_point
	bl	print_matrix_float
	mov	r0, #0
	pop	{r4, r5, r6, r7, r8, pc}
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
	.ascii	"%d \000"
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
