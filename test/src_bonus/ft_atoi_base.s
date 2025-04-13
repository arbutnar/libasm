	.file	"ft_atoi_base.c"
	.text
	.section	.rodata
.LC0:
	.string	"0123456789abcdef"
.LC1:
	.string	"0123456789ABCDEF"
	.text
	.globl	in_base
	.type	in_base, @function
in_base:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, %eax
	movl	%esi, -40(%rbp)
	movb	%al, -36(%rbp)
	leaq	.LC0(%rip), %rax
	movq	%rax, -16(%rbp)
	leaq	.LC1(%rip), %rax
	movq	%rax, -8(%rbp)
	movl	$0, -20(%rbp)
	jmp	.L2
.L6:
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	-16(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	%al, -36(%rbp)
	je	.L3
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	%al, -36(%rbp)
	jne	.L4
.L3:
	movl	$1, %eax
	jmp	.L5
.L4:
	addl	$1, -20(%rbp)
.L2:
	movl	-20(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jl	.L6
	movl	$0, %eax
.L5:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	in_base, .-in_base
	.section	.rodata
.LC2:
	.string	"%d\n"
	.text
	.globl	ft_atoi_base
	.type	ft_atoi_base, @function
ft_atoi_base:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	$1, -8(%rbp)
	movl	$0, -4(%rbp)
	cmpl	$1, -28(%rbp)
	jle	.L8
	cmpl	$16, -28(%rbp)
	jle	.L9
.L8:
	movl	$0, %eax
	jmp	.L10
.L9:
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$45, %al
	jne	.L12
	movl	$-1, -8(%rbp)
	addq	$1, -24(%rbp)
	jmp	.L12
.L13:
	addq	$1, -24(%rbp)
.L12:
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$43, %al
	je	.L13
	jmp	.L14
.L21:
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$9, %al
	je	.L22
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$10, %al
	je	.L22
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$11, %al
	je	.L22
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$12, %al
	je	.L22
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$13, %al
	je	.L22
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	je	.L22
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	-28(%rbp), %edx
	movl	%edx, %esi
	movl	%eax, %edi
	call	in_base
	testl	%eax, %eax
	jne	.L18
	movl	$0, %eax
	jmp	.L10
.L18:
	movl	-4(%rbp), %eax
	imull	-28(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$47, %al
	jle	.L19
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$57, %al
	jg	.L19
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	subl	$48, %eax
	addl	%eax, -4(%rbp)
	jmp	.L17
.L19:
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$64, %al
	jle	.L20
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$70, %al
	jg	.L20
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	subl	$55, %eax
	addl	%eax, -4(%rbp)
	jmp	.L17
.L20:
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$96, %al
	jle	.L17
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$102, %al
	jg	.L17
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	subl	$87, %eax
	addl	%eax, -4(%rbp)
	jmp	.L17
.L22:
	nop
.L17:
	addq	$1, -24(%rbp)
.L14:
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L21
	movl	-4(%rbp), %eax
	imull	-8(%rbp), %eax
.L10:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	ft_atoi_base, .-ft_atoi_base
	.section	.rodata
.LC3:
	.string	"2247"
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$8, %esi
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	ft_atoi_base
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
