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
	movw	r7, #:lower16:.LC1
	bl	puts
	vldr.32	s16, .L8
	ldr	r6, .L8+4
	movt	r7, #:upper16:.LC1
	add	r8, r6, #72
.L2:
	mov	r5, r6
	mov	r4, #3
.L3:
	vldmia.32	r5!, {s15}	@ int
	vcvt.f32.s32	s15, s15
	vmul.f32	s15, s15, s16
	vcvt.f64.f32	d7, s15
	add	r4, r4, #1
	mov	r0, r7
	vmov	r2, r3, d7
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
	.fpu vfpv3-d16
	.type	augment_matrix, %function
augment_matrix:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	movw	ip, #:lower16:.LANCHOR0
	movw	lr, #:lower16:augmented_matrix
	mov	r0, #0
	movt	lr, #:upper16:augmented_matrix
	movt	ip, #:upper16:.LANCHOR0
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
	cmp	r0, #3
	add	lr, lr, #24
	add	ip, ip, #12
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
	movw	r3, #:lower16:augmented_matrix
	add	r0, r0, r0, lsl #1
	movt	r3, #:upper16:augmented_matrix
	lsl	r0, r0, #3
	add	r1, r1, r1, lsl #1
	add	ip, r3, #24
	add	ip, ip, r0
	add	r1, r3, r1, lsl #3
	add	r0, r0, r3
.L21:
	ldr	r2, [r1]
	ldr	r3, [r0]
	str	r2, [r0], #4
	cmp	r0, ip
	str	r3, [r1], #4
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
	add	r2, r0, #1
	cmp	r2, #2
	bxgt	lr
	movw	ip, #:lower16:augmented_matrix
	rsb	r3, r0, r0, lsl #3
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
	.fpu vfpv3-d16
	.type	normalize_row, %function
normalize_row:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movw	r3, #:lower16:augmented_matrix
	push	{r4, r5, r6, lr}
	mov	r6, r1
	movt	r3, #:upper16:augmented_matrix
	add	r0, r0, r0, lsl #1
	lsl	r4, r0, #3
	add	r5, r3, #24
	add	r5, r5, r4
	add	r4, r4, r3
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
	movw	lr, #:lower16:augmented_matrix
	mov	r5, #0
	movt	lr, #:upper16:augmented_matrix
	lsl	r1, r1, #2
	add	r7, r0, r0, lsl #1
	add	r7, lr, r7, lsl #3
	sub	r1, r1, #24
	add	lr, lr, #24
.L38:
	cmp	r0, r5
	beq	.L36
	mov	r4, r7
	ldr	r6, [r1, lr]
	sub	r3, lr, #24
.L37:
	ldr	ip, [r4], #4
	ldr	r2, [r3]
	mul	ip, r6, ip
	sub	r2, r2, ip, asr #8
	str	r2, [r3], #4
	cmp	r3, lr
	bne	.L37
.L36:
	add	r5, r5, #1
	cmp	r5, #3
	add	lr, lr, #24
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
	movw	r7, #:lower16:augmented_matrix
	mov	r6, #0
	movt	r7, #:upper16:augmented_matrix
	mov	r8, r7
	mov	r2, r6
	mvn	r10, #23
	add	r5, r7, #24
.L54:
	ldr	fp, [r7]
	add	r4, r2, #1
	eor	r1, fp, fp, asr #31
	cmp	r4, #3
	sub	r1, r1, fp, asr #31
	beq	.L44
	mov	ip, r7
	mov	r0, r4
.L46:
	ldr	r3, [ip, #24]!
	cmp	r3, #0
	rsblt	r3, r3, #0
	cmp	r3, r1
	movgt	r1, r3
	movgt	r2, r0
	cmp	r0, #2
	movne	r0, #2
	bne	.L46
.L67:
	cmp	r2, r6
	beq	.L44
	add	r3, r2, r2, lsl #1
	movw	r2, #:lower16:augmented_matrix
	mov	r1, r8
	ldr	r0, .L68
	lsl	r3, r3, #3
	movt	r2, #:upper16:augmented_matrix
	add	r2, r2, r3
	add	r3, r3, r0
.L47:
	ldr	ip, [r1]
	ldr	r0, [r2]
	str	ip, [r2], #4
	cmp	r2, r3
	str	r0, [r1], #4
	bne	.L47
	ldr	fp, [r7]
.L44:
	mov	r9, r8
.L48:
	ldr	r0, [r9]
	mov	r1, fp
	lsl	r0, r0, #8
	bl	__aeabi_idiv
	str	r0, [r9], #4
	cmp	r9, r5
	bne	.L48
	mov	lr, #0
	ldr	ip, .L68
.L50:
	cmp	lr, r6
	beq	.L53
	mov	r0, r8
	ldr	r9, [r10, ip]
	sub	r3, ip, #24
.L52:
	ldr	r1, [r0], #4
	ldr	r2, [r3]
	mul	r1, r1, r9
	sub	r2, r2, r1, asr #8
	str	r2, [r3], #4
	cmp	r3, ip
	bne	.L52
.L53:
	add	lr, lr, #1
	cmp	lr, #3
	add	ip, ip, #24
	bne	.L50
	cmp	r4, #3
	add	r6, r6, #1
	add	r7, r7, #28
	add	r8, r8, #24
	add	r10, r10, #4
	add	r5, r5, #24
	mov	r2, r4
	bne	.L54
	pop	{r3, r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L69:
	.align	2
.L68:
	.word	augmented_matrix+24
	.size	gauss_jordan_fixed_point, .-gauss_jordan_fixed_point
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
	push	{r4, r5, r6, r7, r8, lr}
	movw	r0, #:lower16:.LC2
	movw	r4, #:lower16:.LANCHOR0
	movw	r6, #:lower16:.LC3
	movt	r4, #:upper16:.LANCHOR0
	movt	r0, #:upper16:.LC2
	bl	puts
	mov	r5, r4
	add	r7, r4, #36
	movt	r6, #:upper16:.LC3
.L71:
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
	bne	.L71
	movw	ip, #:lower16:augmented_matrix
	mov	r0, #0
	movt	ip, #:upper16:augmented_matrix
.L72:
	mov	r2, ip
	mov	r3, #0
	b	.L78
.L83:
	ldr	r1, [r4, r3, lsl #2]
	lsl	r1, r1, #8
	str	r1, [r2]
.L75:
	add	r3, r3, #1
	add	r2, r2, #4
.L78:
	cmp	r3, #2
	sub	r1, r3, #3
	bls	.L83
	cmp	r1, r0
	moveq	r1, #256
	movne	r1, #0
	cmp	r3, #5
	str	r1, [r2]
	bne	.L75
	add	r0, r0, #1
	cmp	r0, #3
	add	ip, ip, #24
	add	r4, r4, #12
	bne	.L72
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
