	.arch armv7-a
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"matrix_inversion.c"
	.text
	.global	test_matrix
	.data
	.align	2
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
	.comm	augmented_matrix,72,4
	.section	.rodata
	.align	2
.LC0:
	.ascii	"\012Inverted test_matrix (fixed-point, shown as flo"
	.ascii	"at):\000"
	.align	2
.LC1:
	.ascii	"%7.4f \000"
	.text
	.align	2
	.global	print_matrix_float
	.arch armv7-a
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	print_matrix_float, %function
print_matrix_float:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	movw	r0, #:lower16:.LC0
	movt	r0, #:upper16:.LC0
	bl	puts
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L2
.L5:
	mov	r3, #3
	str	r3, [fp, #-12]
	b	.L3
.L4:
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	ldr	r1, [fp, #-8]
	mov	r3, r1
	lsl	r3, r3, #1
	add	r3, r3, r1
	lsl	r3, r3, #1
	ldr	r1, [fp, #-12]
	add	r3, r3, r1
	ldr	r3, [r2, r3, lsl #2]
	vmov	s15, r3	@ int
	vcvt.f32.s32	s14, s15
	vldr.32	s13, .L6
	vdiv.f32	s15, s14, s13
	vcvt.f64.f32	d7, s15
	vmov	r2, r3, d7
	movw	r0, #:lower16:.LC1
	movt	r0, #:upper16:.LC1
	bl	printf
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L3:
	ldr	r3, [fp, #-12]
	cmp	r3, #5
	ble	.L4
	mov	r0, #10
	bl	putchar
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L2:
	ldr	r3, [fp, #-8]
	cmp	r3, #2
	ble	.L5
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L7:
	.align	2
.L6:
	.word	1132462080
	.size	print_matrix_float, .-print_matrix_float
	.align	2
	.global	augment_matrix
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	augment_matrix, %function
augment_matrix:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L9
.L16:
	mov	r3, #0
	str	r3, [fp, #-12]
	b	.L10
.L15:
	ldr	r3, [fp, #-12]
	cmp	r3, #2
	bgt	.L11
	movw	r2, #:lower16:test_matrix
	movt	r2, #:upper16:test_matrix
	ldr	r1, [fp, #-8]
	mov	r3, r1
	lsl	r3, r3, #1
	add	r3, r3, r1
	ldr	r1, [fp, #-12]
	add	r3, r3, r1
	ldr	r3, [r2, r3, lsl #2]
	lsl	r0, r3, #8
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	ldr	r1, [fp, #-8]
	mov	r3, r1
	lsl	r3, r3, #1
	add	r3, r3, r1
	lsl	r3, r3, #1
	ldr	r1, [fp, #-12]
	add	r3, r3, r1
	str	r0, [r2, r3, lsl #2]
	b	.L12
.L11:
	ldr	r3, [fp, #-12]
	sub	r3, r3, #3
	ldr	r2, [fp, #-8]
	cmp	r2, r3
	bne	.L13
	mov	r0, #256
	b	.L14
.L13:
	mov	r0, #0
.L14:
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	ldr	r1, [fp, #-8]
	mov	r3, r1
	lsl	r3, r3, #1
	add	r3, r3, r1
	lsl	r3, r3, #1
	ldr	r1, [fp, #-12]
	add	r3, r3, r1
	str	r0, [r2, r3, lsl #2]
.L12:
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L10:
	ldr	r3, [fp, #-12]
	cmp	r3, #5
	ble	.L15
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L9:
	ldr	r3, [fp, #-8]
	cmp	r3, #2
	ble	.L16
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	augment_matrix, .-augment_matrix
	.align	2
	.global	swap_rows
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	swap_rows, %function
swap_rows:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L18
.L19:
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	ldr	r1, [fp, #-16]
	mov	r3, r1
	lsl	r3, r3, #1
	add	r3, r3, r1
	lsl	r3, r3, #1
	ldr	r1, [fp, #-8]
	add	r3, r3, r1
	ldr	r3, [r2, r3, lsl #2]
	str	r3, [fp, #-12]
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	ldr	r1, [fp, #-20]
	mov	r3, r1
	lsl	r3, r3, #1
	add	r3, r3, r1
	lsl	r3, r3, #1
	ldr	r1, [fp, #-8]
	add	r3, r3, r1
	ldr	r0, [r2, r3, lsl #2]
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	ldr	r1, [fp, #-16]
	mov	r3, r1
	lsl	r3, r3, #1
	add	r3, r3, r1
	lsl	r3, r3, #1
	ldr	r1, [fp, #-8]
	add	r3, r3, r1
	str	r0, [r2, r3, lsl #2]
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	ldr	r1, [fp, #-20]
	mov	r3, r1
	lsl	r3, r3, #1
	add	r3, r3, r1
	lsl	r3, r3, #1
	ldr	r1, [fp, #-8]
	add	r3, r3, r1
	ldr	r1, [fp, #-12]
	str	r1, [r2, r3, lsl #2]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L18:
	ldr	r3, [fp, #-8]
	cmp	r3, #5
	ble	.L19
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	swap_rows, .-swap_rows
	.align	2
	.global	find_pivot_row
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	find_pivot_row, %function
find_pivot_row:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #28
	str	r0, [fp, #-24]
	ldr	r3, [fp, #-24]
	str	r3, [fp, #-8]
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	ldr	r1, [fp, #-24]
	mov	r3, r1
	lsl	r3, r3, #3
	sub	r3, r3, r1
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r3, [r3]
	cmp	r3, #0
	rsblt	r3, r3, #0
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-16]
	b	.L21
.L23:
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	ldr	r1, [fp, #-16]
	mov	r3, r1
	lsl	r3, r3, #1
	add	r3, r3, r1
	lsl	r3, r3, #1
	ldr	r1, [fp, #-24]
	add	r3, r3, r1
	ldr	r3, [r2, r3, lsl #2]
	cmp	r3, #0
	rsblt	r3, r3, #0
	ldr	r2, [fp, #-12]
	cmp	r2, r3
	bge	.L22
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-8]
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	ldr	r1, [fp, #-16]
	mov	r3, r1
	lsl	r3, r3, #1
	add	r3, r3, r1
	lsl	r3, r3, #1
	ldr	r1, [fp, #-24]
	add	r3, r3, r1
	ldr	r3, [r2, r3, lsl #2]
	cmp	r3, #0
	rsblt	r3, r3, #0
	str	r3, [fp, #-12]
.L22:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L21:
	ldr	r3, [fp, #-16]
	cmp	r3, #2
	ble	.L23
	ldr	r3, [fp, #-8]
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
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
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L26
.L27:
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	ldr	r1, [fp, #-16]
	mov	r3, r1
	lsl	r3, r3, #1
	add	r3, r3, r1
	lsl	r3, r3, #1
	ldr	r1, [fp, #-8]
	add	r3, r3, r1
	ldr	r3, [r2, r3, lsl #2]
	lsl	r3, r3, #8
	ldr	r1, [fp, #-20]
	mov	r0, r3
	bl	__aeabi_idiv
	mov	r3, r0
	mov	r0, r3
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	ldr	r1, [fp, #-16]
	mov	r3, r1
	lsl	r3, r3, #1
	add	r3, r3, r1
	lsl	r3, r3, #1
	ldr	r1, [fp, #-8]
	add	r3, r3, r1
	str	r0, [r2, r3, lsl #2]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L26:
	ldr	r3, [fp, #-8]
	cmp	r3, #5
	ble	.L27
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	normalize_row, .-normalize_row
	.align	2
	.global	eliminate_other_rows
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	eliminate_other_rows, %function
eliminate_other_rows:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #28
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L29
.L34:
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	beq	.L35
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	ldr	r1, [fp, #-8]
	mov	r3, r1
	lsl	r3, r3, #1
	add	r3, r3, r1
	lsl	r3, r3, #1
	ldr	r1, [fp, #-28]
	add	r3, r3, r1
	ldr	r3, [r2, r3, lsl #2]
	str	r3, [fp, #-16]
	mov	r3, #0
	str	r3, [fp, #-12]
	b	.L32
.L33:
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	ldr	r1, [fp, #-8]
	mov	r3, r1
	lsl	r3, r3, #1
	add	r3, r3, r1
	lsl	r3, r3, #1
	ldr	r1, [fp, #-12]
	add	r3, r3, r1
	ldr	r0, [r2, r3, lsl #2]
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	ldr	r1, [fp, #-24]
	mov	r3, r1
	lsl	r3, r3, #1
	add	r3, r3, r1
	lsl	r3, r3, #1
	ldr	r1, [fp, #-12]
	add	r3, r3, r1
	ldr	r3, [r2, r3, lsl #2]
	ldr	r2, [fp, #-16]
	mul	r3, r2, r3
	asr	r3, r3, #8
	sub	r0, r0, r3
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	ldr	r1, [fp, #-8]
	mov	r3, r1
	lsl	r3, r3, #1
	add	r3, r3, r1
	lsl	r3, r3, #1
	ldr	r1, [fp, #-12]
	add	r3, r3, r1
	str	r0, [r2, r3, lsl #2]
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L32:
	ldr	r3, [fp, #-12]
	cmp	r3, #5
	ble	.L33
	b	.L31
.L35:
	nop
.L31:
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L29:
	ldr	r3, [fp, #-8]
	cmp	r3, #2
	ble	.L34
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	eliminate_other_rows, .-eliminate_other_rows
	.align	2
	.global	gauss_jordan_fixed_point
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	gauss_jordan_fixed_point, %function
gauss_jordan_fixed_point:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L37
.L39:
	ldr	r0, [fp, #-8]
	bl	find_pivot_row
	str	r0, [fp, #-12]
	ldr	r2, [fp, #-12]
	ldr	r3, [fp, #-8]
	cmp	r2, r3
	beq	.L38
	ldr	r1, [fp, #-8]
	ldr	r0, [fp, #-12]
	bl	swap_rows
.L38:
	movw	r2, #:lower16:augmented_matrix
	movt	r2, #:upper16:augmented_matrix
	ldr	r1, [fp, #-8]
	mov	r3, r1
	lsl	r3, r3, #3
	sub	r3, r3, r1
	lsl	r3, r3, #2
	add	r3, r2, r3
	ldr	r3, [r3]
	str	r3, [fp, #-16]
	ldr	r1, [fp, #-16]
	ldr	r0, [fp, #-8]
	bl	normalize_row
	ldr	r1, [fp, #-8]
	ldr	r0, [fp, #-8]
	bl	eliminate_other_rows
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L37:
	ldr	r3, [fp, #-8]
	cmp	r3, #2
	ble	.L39
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	gauss_jordan_fixed_point, .-gauss_jordan_fixed_point
	.section	.rodata
	.align	2
.LC2:
	.ascii	"Original test_matrix:\000"
	.align	2
.LC3:
	.ascii	"%d \000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	movw	r0, #:lower16:.LC2
	movt	r0, #:upper16:.LC2
	bl	puts
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L41
.L44:
	mov	r3, #0
	str	r3, [fp, #-12]
	b	.L42
.L43:
	movw	r2, #:lower16:test_matrix
	movt	r2, #:upper16:test_matrix
	ldr	r1, [fp, #-8]
	mov	r3, r1
	lsl	r3, r3, #1
	add	r3, r3, r1
	ldr	r1, [fp, #-12]
	add	r3, r3, r1
	ldr	r3, [r2, r3, lsl #2]
	mov	r1, r3
	movw	r0, #:lower16:.LC3
	movt	r0, #:upper16:.LC3
	bl	printf
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L42:
	ldr	r3, [fp, #-12]
	cmp	r3, #2
	ble	.L43
	mov	r0, #10
	bl	putchar
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L41:
	ldr	r3, [fp, #-8]
	cmp	r3, #2
	ble	.L44
	bl	augment_matrix
	bl	gauss_jordan_fixed_point
	bl	print_matrix_float
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	main, .-main
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
