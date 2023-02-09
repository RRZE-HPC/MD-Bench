	.text
	.file	"force_lj.c"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3                               # -- Begin function computeForceLJ_ref
.LCPI0_0:
	.quad	0x4048000000000000              #  48
.LCPI0_1:
	.quad	0x3ff0000000000000              #  1
.LCPI0_2:
	.quad	0xbfe0000000000000              #  -0.5
.LCPI0_3:
	.quad	0x3fe0000000000000              #  0.5
	.text
	.globl	computeForceLJ_ref
	.p2align	4, 0x90
	.type	computeForceLJ_ref,@function
computeForceLJ_ref:                     # 
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$152, %rsp
	.cfi_def_cfa_offset 208
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%rsi, %r14
	movq	%rdi, %r12
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	144(%r12), %xmm0                # xmm0 = mem[0],zero
	vmovsd	%xmm0, 8(%rsp)                  # 8-byte Spill
	vmovsd	40(%r12), %xmm0                 # xmm0 = mem[0],zero
	vmovsd	%xmm0, (%rsp)                   # 8-byte Spill
	vmovsd	56(%r12), %xmm1                 # xmm1 = mem[0],zero
	movl	20(%r14), %r11d
	testl	%r11d, %r11d
	jle	.LBB0_5
# %bb.1:
	movq	176(%r14), %r9
	movq	192(%r14), %r10
	decq	%r11
	leaq	128(%r9), %r8
	xorl	%edi, %edi
	vxorpd	%xmm0, %xmm0, %xmm0
	jmp	.LBB0_2
	.p2align	5, 0x90
.LBB0_79:                               #   in Loop: Header=BB0_2 Depth=1
	cmpq	%r11, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB0_5
.LBB0_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_74 Depth 2
                                        #     Child Loop BB0_78 Depth 2
	imulq	$56, %rdi, %rax
	movl	(%r10,%rax), %esi
	testl	%esi, %esi
	jle	.LBB0_79
# %bb.3:                                #   in Loop: Header=BB0_2 Depth=1
	leal	(,%rdi,4), %ebx
	movl	%ebx, %eax
	andl	$2147483640, %eax               # imm = 0x7FFFFFF8
	leal	(%rax,%rax,2), %eax
	andl	$4, %ebx
	orl	%eax, %ebx
	cmpl	$7, %esi
	ja	.LBB0_73
# %bb.4:                                #   in Loop: Header=BB0_2 Depth=1
	movl	%esi, %ebp
	andl	$-8, %ebp
	cmpq	%rsi, %rbp
	jae	.LBB0_79
	jmp	.LBB0_77
	.p2align	5, 0x90
.LBB0_73:                               #   in Loop: Header=BB0_2 Depth=1
	leaq	(,%rsi,8), %rbp
	andq	$-64, %rbp
	movl	%ebx, %ecx
	leaq	(%r9,%rcx,8), %rdx
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB0_74:                               #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%zmm0, (%rdx,%rax)
	addq	$64, %rax
	cmpq	%rax, %rbp
	jne	.LBB0_74
# %bb.75:                               #   in Loop: Header=BB0_2 Depth=1
	movl	%esi, %ebp
	andl	$-8, %ebp
	addq	%rbp, %rcx
	vmovupd	%zmm0, (%r9,%rcx,8)
	vmovupd	%zmm0, 64(%r9,%rcx,8)
	cmpq	%rsi, %rbp
	jae	.LBB0_79
.LBB0_77:                               #   in Loop: Header=BB0_2 Depth=1
	movl	%ebx, %eax
	leaq	(%r8,%rax,8), %rcx
	.p2align	4, 0x90
.LBB0_78:                               #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, -128(%rcx,%rbp,8)
	movq	$0, -64(%rcx,%rbp,8)
	movq	$0, (%rcx,%rbp,8)
	incq	%rbp
	cmpq	%rbp, %rsi
	jne	.LBB0_78
	jmp	.LBB0_79
	.p2align	5, 0x90
.LBB0_5:
	vmovsd	%xmm1, 48(%rsp)                 # 8-byte Spill
	xorl	%eax, %eax
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 56(%rsp)                 # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	movl	20(%r14), %esi
	testl	%esi, %esi
	jle	.LBB0_17
# %bb.6:
	vmovsd	8(%rsp), %xmm0                  # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm13
	movq	16(%rsp), %rax                  # 8-byte Reload
	leaq	32(%rax), %r15
	vmovsd	(%rsp), %xmm0                   # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	.LCPI0_0(%rip), %xmm0, %xmm12
	leaq	24(%rax), %rdx
	movq	160(%r14), %rdi
	movq	176(%r14), %rbp
	movq	24(%rsp), %rcx                  # 8-byte Reload
	movq	8(%rcx), %rbx
	movq	%rbx, 72(%rsp)                  # 8-byte Spill
	movq	24(%rcx), %rbx
	movq	%rbx, 96(%rsp)                  # 8-byte Spill
	movslq	16(%rcx), %rcx
	movq	%rcx, 64(%rsp)                  # 8-byte Spill
	vmovdqu	8(%rax), %xmm9
	leal	-1(%rsi), %ecx
	addq	(%rax), %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	movq	%rbp, 80(%rsp)                  # 8-byte Spill
	leaq	128(%rbp), %rax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%rdi, 32(%rsp)                  # 8-byte Spill
	leaq	128(%rdi), %rax
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	xorl	%edi, %edi
	vmovsd	.LCPI0_1(%rip), %xmm10          # xmm10 = mem[0],zero
	vmovsd	.LCPI0_2(%rip), %xmm11          # xmm11 = mem[0],zero
	vmovsd	.LCPI0_3(%rip), %xmm8           # xmm8 = mem[0],zero
	vmovsd	48(%rsp), %xmm20                # 8-byte Reload
                                        # xmm20 = mem[0],zero
	movq	%rsi, 88(%rsp)                  # 8-byte Spill
	jmp	.LBB0_7
	.p2align	5, 0x90
.LBB0_19:                               #   in Loop: Header=BB0_7 Depth=1
	movq	88(%rsp), %rsi                  # 8-byte Reload
	movq	112(%rsp), %rdi                 # 8-byte Reload
	movq	104(%rsp), %rbp                 # 8-byte Reload
.LBB0_20:                               #   in Loop: Header=BB0_7 Depth=1
	vcvtsi2sd	%ebp, %xmm21, %xmm0
	vmulsd	%xmm0, %xmm8, %xmm0
	vcvttsd2si	%xmm0, %rax
	vmovq	%rax, %xmm0
	vmovq	%rcx, %xmm1
	vpunpcklqdq	%xmm0, %xmm1, %xmm0     # xmm0 = xmm1[0],xmm0[0]
	vpaddq	%xmm0, %xmm9, %xmm9
	incq	%rdi
	cmpq	%rsi, %rdi
	je	.LBB0_16
.LBB0_7:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_9 Depth 2
                                        #       Child Loop BB0_10 Depth 3
                                        #         Child Loop BB0_12 Depth 4
	movq	96(%rsp), %rax                  # 8-byte Reload
	movslq	(%rax,%rdi,4), %rbp
	movq	%rbp, %rcx
	testq	%rbp, %rbp
	jle	.LBB0_20
# %bb.8:                                #   in Loop: Header=BB0_7 Depth=1
	movl	%edi, %r13d
	shrl	%r13d
	leal	(,%r13,8), %eax
	leal	(%rax,%rax,2), %eax
	leal	(,%rdi,4), %ecx
	andl	$4, %ecx
	orl	%ecx, %eax
	movq	32(%rsp), %rsi                  # 8-byte Reload
	leaq	(%rsi,%rax,8), %r8
	movq	80(%rsp), %rsi                  # 8-byte Reload
	leaq	(%rsi,%rax,8), %r11
	movq	%rdi, 112(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	imulq	64(%rsp), %rax                  # 8-byte Folded Reload
	movq	72(%rsp), %rsi                  # 8-byte Reload
	leaq	(%rsi,%rax,4), %rax
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movq	24(%rsp), %rax                  # 8-byte Reload
	movl	32(%rax), %eax
	movl	%eax, (%rsp)                    # 4-byte Spill
	movl	%ecx, %r12d
	movq	%rbp, 104(%rsp)                 # 8-byte Spill
	movl	%ebp, %ecx
	xorl	%esi, %esi
	movq	%rcx, 144(%rsp)                 # 8-byte Spill
	jmp	.LBB0_9
	.p2align	5, 0x90
.LBB0_18:                               #   in Loop: Header=BB0_9 Depth=2
	movq	8(%rsp), %rsi                   # 8-byte Reload
	incq	%rsi
	movq	144(%rsp), %rcx                 # 8-byte Reload
	cmpq	%rcx, %rsi
	je	.LBB0_19
.LBB0_9:                                #   Parent Loop BB0_7 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_10 Depth 3
                                        #         Child Loop BB0_12 Depth 4
	movq	136(%rsp), %rax                 # 8-byte Reload
	movq	%rsi, 8(%rsp)                   # 8-byte Spill
	movslq	(%rax,%rsi,4), %r10
	movq	%r10, %rax
	shlq	$6, %rax
	leaq	(%rax,%rax,2), %rdi
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	%rdi, %rax
	movq	128(%rsp), %rcx                 # 8-byte Reload
	leaq	(%rcx,%rdi), %rsi
	addq	120(%rsp), %rdi                 # 8-byte Folded Reload
	xorl	%r9d, %r9d
	xorl	%r14d, %r14d
	jmp	.LBB0_10
	.p2align	5, 0x90
.LBB0_67:                               #   in Loop: Header=BB0_10 Depth=3
	vdivsd	%xmm3, %xmm10, %xmm3
	vmulsd	%xmm20, %xmm3, %xmm14
	vmulsd	%xmm3, %xmm3, %xmm4
	vmulsd	%xmm4, %xmm14, %xmm4
	vaddsd	%xmm4, %xmm11, %xmm14
	vmulsd	%xmm3, %xmm12, %xmm3
	vmulsd	%xmm4, %xmm14, %xmm4
	vmulsd	%xmm3, %xmm4, %xmm3
	vfmadd231sd	%xmm2, %xmm3, %xmm7     # xmm7 = (xmm3 * xmm2) + xmm7
	vfmadd231sd	%xmm1, %xmm3, %xmm5     # xmm5 = (xmm3 * xmm1) + xmm5
	vfmadd231sd	%xmm0, %xmm3, %xmm19    # xmm19 = (xmm3 * xmm0) + xmm19
	movl	$1, %r14d
	movq	%rdx, %rbx
.LBB0_68:                               #   in Loop: Header=BB0_10 Depth=3
	incq	(%rbx)
	.p2align	4, 0x90
.LBB0_69:                               #   in Loop: Header=BB0_10 Depth=3
	xorl	%ecx, %ecx
	testl	%r14d, %r14d
	sete	%cl
	movq	16(%rsp), %rbx                  # 8-byte Reload
	incq	40(%rbx,%rcx,8)
	vaddsd	(%r11,%r9,8), %xmm7, %xmm0
	vmovsd	%xmm0, (%r11,%r9,8)
	vaddsd	64(%r11,%r9,8), %xmm5, %xmm0
	vmovsd	%xmm0, 64(%r11,%r9,8)
	vaddsd	128(%r11,%r9,8), %xmm19, %xmm0
	vmovsd	%xmm0, 128(%r11,%r9,8)
	incq	%r9
	cmpq	$4, %r9
	je	.LBB0_18
.LBB0_10:                               #   Parent Loop BB0_7 Depth=1
                                        #     Parent Loop BB0_9 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_12 Depth 4
	vmovsd	(%r8,%r9,8), %xmm14             # xmm14 = mem[0],zero
	leaq	(%r9,%r12), %rbp
	vmovsd	64(%r8,%r9,8), %xmm16           # xmm16 = mem[0],zero
	vmovsd	128(%r8,%r9,8), %xmm18          # xmm18 = mem[0],zero
	cmpl	$0, (%rsp)                      # 4-byte Folded Reload
	je	.LBB0_21
# %bb.11:                               #   in Loop: Header=BB0_10 Depth=3
	vxorpd	%xmm7, %xmm7, %xmm7
	xorl	%ebx, %ebx
	vxorpd	%xmm5, %xmm5, %xmm5
	vxorpd	%xmm19, %xmm19, %xmm19
	jmp	.LBB0_12
	.p2align	5, 0x90
.LBB0_70:                               #   in Loop: Header=BB0_12 Depth=4
	vdivsd	%xmm3, %xmm10, %xmm3
	vmulsd	%xmm20, %xmm3, %xmm4
	vmulsd	%xmm3, %xmm3, %xmm6
	vmulsd	%xmm4, %xmm6, %xmm4
	vaddsd	%xmm4, %xmm11, %xmm6
	vmulsd	%xmm3, %xmm12, %xmm3
	vmulsd	%xmm4, %xmm6, %xmm4
	vmovsd	-64(%rsi,%rbx,8), %xmm6         # xmm6 = mem[0],zero
	vmulsd	%xmm3, %xmm4, %xmm3
	vmovsd	-128(%rsi,%rbx,8), %xmm4        # xmm4 = mem[0],zero
	vfnmadd231sd	%xmm3, %xmm2, %xmm4     # xmm4 = -(xmm2 * xmm3) + xmm4
	vmovsd	%xmm4, -128(%rsi,%rbx,8)
	vfnmadd231sd	%xmm3, %xmm0, %xmm6     # xmm6 = -(xmm0 * xmm3) + xmm6
	vmovsd	%xmm6, -64(%rsi,%rbx,8)
	vmovsd	(%rsi,%rbx,8), %xmm4            # xmm4 = mem[0],zero
	vfnmadd231sd	%xmm3, %xmm1, %xmm4     # xmm4 = -(xmm1 * xmm3) + xmm4
	vmovsd	%xmm4, (%rsi,%rbx,8)
	vfmadd231sd	%xmm2, %xmm3, %xmm7     # xmm7 = (xmm3 * xmm2) + xmm7
	vfmadd231sd	%xmm0, %xmm3, %xmm5     # xmm5 = (xmm3 * xmm0) + xmm5
	vfmadd231sd	%xmm3, %xmm1, %xmm19    # xmm19 = (xmm1 * xmm3) + xmm19
	movl	$1, %r14d
	movq	%rdx, %rcx
.LBB0_71:                               #   in Loop: Header=BB0_12 Depth=4
	incq	(%rcx)
.LBB0_72:                               #   in Loop: Header=BB0_12 Depth=4
	incq	%rbx
	cmpq	$8, %rbx
	je	.LBB0_69
.LBB0_12:                               #   Parent Loop BB0_7 Depth=1
                                        #     Parent Loop BB0_9 Depth=2
                                        #       Parent Loop BB0_10 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	cmpl	%r10d, %r13d
	jne	.LBB0_14
# %bb.13:                               #   in Loop: Header=BB0_12 Depth=4
	cmpq	%rbx, %rbp
	jae	.LBB0_72
.LBB0_14:                               #   in Loop: Header=BB0_12 Depth=4
	vsubsd	-128(%rdi,%rbx,8), %xmm14, %xmm2
	vsubsd	-64(%rdi,%rbx,8), %xmm16, %xmm0
	vsubsd	(%rdi,%rbx,8), %xmm18, %xmm1
	vmulsd	%xmm2, %xmm2, %xmm3
	vfmadd231sd	%xmm0, %xmm0, %xmm3     # xmm3 = (xmm0 * xmm0) + xmm3
	vfmadd231sd	%xmm1, %xmm1, %xmm3     # xmm3 = (xmm1 * xmm1) + xmm3
	vucomisd	%xmm13, %xmm3
	jb	.LBB0_70
# %bb.15:                               #   in Loop: Header=BB0_12 Depth=4
	movq	%r15, %rcx
	jmp	.LBB0_71
	.p2align	5, 0x90
.LBB0_21:                               #   in Loop: Header=BB0_10 Depth=3
	cmpl	%r10d, %r13d
	jne	.LBB0_24
# %bb.22:                               #   in Loop: Header=BB0_10 Depth=3
	vxorpd	%xmm19, %xmm19, %xmm19
	testq	%rbp, %rbp
	jne	.LBB0_24
# %bb.23:                               #   in Loop: Header=BB0_10 Depth=3
	vxorpd	%xmm5, %xmm5, %xmm5
	vxorpd	%xmm7, %xmm7, %xmm7
	cmpl	%r10d, %r13d
	je	.LBB0_28
	jmp	.LBB0_29
	.p2align	5, 0x90
.LBB0_24:                               #   in Loop: Header=BB0_10 Depth=3
	vsubsd	(%rax), %xmm14, %xmm15
	vsubsd	64(%rax), %xmm16, %xmm1
	vsubsd	128(%rax), %xmm18, %xmm2
	vmulsd	%xmm15, %xmm15, %xmm0
	vfmadd231sd	%xmm1, %xmm1, %xmm0     # xmm0 = (xmm1 * xmm1) + xmm0
	vfmadd231sd	%xmm2, %xmm2, %xmm0     # xmm0 = (xmm2 * xmm2) + xmm0
	vxorpd	%xmm19, %xmm19, %xmm19
	vucomisd	%xmm13, %xmm0
	movq	%r15, %rbx
	vxorpd	%xmm5, %xmm5, %xmm5
	vxorpd	%xmm7, %xmm7, %xmm7
	jae	.LBB0_26
# %bb.25:                               #   in Loop: Header=BB0_10 Depth=3
	vdivsd	%xmm0, %xmm10, %xmm0
	vmulsd	%xmm20, %xmm0, %xmm3
	vmulsd	%xmm0, %xmm0, %xmm5
	vmulsd	%xmm3, %xmm5, %xmm3
	vaddsd	%xmm3, %xmm11, %xmm5
	vmulsd	%xmm0, %xmm12, %xmm0
	vmulsd	%xmm3, %xmm5, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vmulsd	%xmm0, %xmm15, %xmm7
	vmulsd	%xmm1, %xmm0, %xmm5
	vmulsd	%xmm2, %xmm0, %xmm19
	movl	$1, %r14d
	movq	%rdx, %rbx
.LBB0_26:                               #   in Loop: Header=BB0_10 Depth=3
	incq	(%rbx)
	cmpl	%r10d, %r13d
	jne	.LBB0_29
.LBB0_28:                               #   in Loop: Header=BB0_10 Depth=3
	cmpq	$1, %rbp
	je	.LBB0_33
.LBB0_29:                               #   in Loop: Header=BB0_10 Depth=3
	vsubsd	8(%rax), %xmm14, %xmm2
	vsubsd	72(%rax), %xmm16, %xmm1
	vsubsd	136(%rax), %xmm18, %xmm15
	vmulsd	%xmm2, %xmm2, %xmm0
	vfmadd231sd	%xmm1, %xmm1, %xmm0     # xmm0 = (xmm1 * xmm1) + xmm0
	vfmadd231sd	%xmm15, %xmm15, %xmm0   # xmm0 = (xmm15 * xmm15) + xmm0
	vucomisd	%xmm13, %xmm0
	jae	.LBB0_30
# %bb.31:                               #   in Loop: Header=BB0_10 Depth=3
	vdivsd	%xmm0, %xmm10, %xmm0
	vmulsd	%xmm20, %xmm0, %xmm17
	vmulsd	%xmm0, %xmm0, %xmm3
	vmulsd	%xmm17, %xmm3, %xmm3
	vaddsd	%xmm11, %xmm3, %xmm17
	vmulsd	%xmm0, %xmm12, %xmm0
	vmulsd	%xmm3, %xmm17, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vfmadd231sd	%xmm2, %xmm0, %xmm7     # xmm7 = (xmm0 * xmm2) + xmm7
	vfmadd231sd	%xmm1, %xmm0, %xmm5     # xmm5 = (xmm0 * xmm1) + xmm5
	vfmadd231sd	%xmm15, %xmm0, %xmm19   # xmm19 = (xmm0 * xmm15) + xmm19
	movl	$1, %r14d
	movq	%rdx, %rbx
	jmp	.LBB0_32
	.p2align	5, 0x90
.LBB0_30:                               #   in Loop: Header=BB0_10 Depth=3
	movq	%r15, %rbx
.LBB0_32:                               #   in Loop: Header=BB0_10 Depth=3
	incq	(%rbx)
.LBB0_33:                               #   in Loop: Header=BB0_10 Depth=3
	cmpl	%r10d, %r13d
	jne	.LBB0_35
# %bb.34:                               #   in Loop: Header=BB0_10 Depth=3
	cmpq	$2, %rbp
	je	.LBB0_39
.LBB0_35:                               #   in Loop: Header=BB0_10 Depth=3
	vsubsd	16(%rax), %xmm14, %xmm2
	vsubsd	80(%rax), %xmm16, %xmm1
	vsubsd	144(%rax), %xmm18, %xmm15
	vmulsd	%xmm2, %xmm2, %xmm0
	vfmadd231sd	%xmm1, %xmm1, %xmm0     # xmm0 = (xmm1 * xmm1) + xmm0
	vfmadd231sd	%xmm15, %xmm15, %xmm0   # xmm0 = (xmm15 * xmm15) + xmm0
	vucomisd	%xmm13, %xmm0
	jae	.LBB0_36
# %bb.37:                               #   in Loop: Header=BB0_10 Depth=3
	vdivsd	%xmm0, %xmm10, %xmm0
	vmulsd	%xmm20, %xmm0, %xmm17
	vmulsd	%xmm0, %xmm0, %xmm3
	vmulsd	%xmm17, %xmm3, %xmm3
	vaddsd	%xmm11, %xmm3, %xmm17
	vmulsd	%xmm0, %xmm12, %xmm0
	vmulsd	%xmm3, %xmm17, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vfmadd231sd	%xmm2, %xmm0, %xmm7     # xmm7 = (xmm0 * xmm2) + xmm7
	vfmadd231sd	%xmm1, %xmm0, %xmm5     # xmm5 = (xmm0 * xmm1) + xmm5
	vfmadd231sd	%xmm15, %xmm0, %xmm19   # xmm19 = (xmm0 * xmm15) + xmm19
	movl	$1, %r14d
	movq	%rdx, %rbx
	jmp	.LBB0_38
	.p2align	5, 0x90
.LBB0_36:                               #   in Loop: Header=BB0_10 Depth=3
	movq	%r15, %rbx
.LBB0_38:                               #   in Loop: Header=BB0_10 Depth=3
	incq	(%rbx)
.LBB0_39:                               #   in Loop: Header=BB0_10 Depth=3
	cmpl	%r10d, %r13d
	jne	.LBB0_41
# %bb.40:                               #   in Loop: Header=BB0_10 Depth=3
	cmpq	$3, %rbp
	je	.LBB0_45
.LBB0_41:                               #   in Loop: Header=BB0_10 Depth=3
	vsubsd	24(%rax), %xmm14, %xmm2
	vsubsd	88(%rax), %xmm16, %xmm1
	vsubsd	152(%rax), %xmm18, %xmm15
	vmulsd	%xmm2, %xmm2, %xmm0
	vfmadd231sd	%xmm1, %xmm1, %xmm0     # xmm0 = (xmm1 * xmm1) + xmm0
	vfmadd231sd	%xmm15, %xmm15, %xmm0   # xmm0 = (xmm15 * xmm15) + xmm0
	vucomisd	%xmm13, %xmm0
	jae	.LBB0_42
# %bb.43:                               #   in Loop: Header=BB0_10 Depth=3
	vdivsd	%xmm0, %xmm10, %xmm0
	vmulsd	%xmm20, %xmm0, %xmm17
	vmulsd	%xmm0, %xmm0, %xmm3
	vmulsd	%xmm17, %xmm3, %xmm3
	vaddsd	%xmm11, %xmm3, %xmm17
	vmulsd	%xmm0, %xmm12, %xmm0
	vmulsd	%xmm3, %xmm17, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vfmadd231sd	%xmm2, %xmm0, %xmm7     # xmm7 = (xmm0 * xmm2) + xmm7
	vfmadd231sd	%xmm1, %xmm0, %xmm5     # xmm5 = (xmm0 * xmm1) + xmm5
	vfmadd231sd	%xmm15, %xmm0, %xmm19   # xmm19 = (xmm0 * xmm15) + xmm19
	movl	$1, %r14d
	movq	%rdx, %rbx
	jmp	.LBB0_44
	.p2align	5, 0x90
.LBB0_42:                               #   in Loop: Header=BB0_10 Depth=3
	movq	%r15, %rbx
.LBB0_44:                               #   in Loop: Header=BB0_10 Depth=3
	incq	(%rbx)
.LBB0_45:                               #   in Loop: Header=BB0_10 Depth=3
	cmpl	%r10d, %r13d
	jne	.LBB0_47
# %bb.46:                               #   in Loop: Header=BB0_10 Depth=3
	cmpq	$4, %rbp
	je	.LBB0_51
.LBB0_47:                               #   in Loop: Header=BB0_10 Depth=3
	vsubsd	32(%rax), %xmm14, %xmm2
	vsubsd	96(%rax), %xmm16, %xmm1
	vsubsd	160(%rax), %xmm18, %xmm15
	vmulsd	%xmm2, %xmm2, %xmm0
	vfmadd231sd	%xmm1, %xmm1, %xmm0     # xmm0 = (xmm1 * xmm1) + xmm0
	vfmadd231sd	%xmm15, %xmm15, %xmm0   # xmm0 = (xmm15 * xmm15) + xmm0
	vucomisd	%xmm13, %xmm0
	jae	.LBB0_48
# %bb.49:                               #   in Loop: Header=BB0_10 Depth=3
	vdivsd	%xmm0, %xmm10, %xmm0
	vmulsd	%xmm20, %xmm0, %xmm17
	vmulsd	%xmm0, %xmm0, %xmm3
	vmulsd	%xmm17, %xmm3, %xmm3
	vaddsd	%xmm11, %xmm3, %xmm17
	vmulsd	%xmm0, %xmm12, %xmm0
	vmulsd	%xmm3, %xmm17, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vfmadd231sd	%xmm2, %xmm0, %xmm7     # xmm7 = (xmm0 * xmm2) + xmm7
	vfmadd231sd	%xmm1, %xmm0, %xmm5     # xmm5 = (xmm0 * xmm1) + xmm5
	vfmadd231sd	%xmm15, %xmm0, %xmm19   # xmm19 = (xmm0 * xmm15) + xmm19
	movl	$1, %r14d
	movq	%rdx, %rbx
	jmp	.LBB0_50
	.p2align	5, 0x90
.LBB0_48:                               #   in Loop: Header=BB0_10 Depth=3
	movq	%r15, %rbx
.LBB0_50:                               #   in Loop: Header=BB0_10 Depth=3
	incq	(%rbx)
.LBB0_51:                               #   in Loop: Header=BB0_10 Depth=3
	cmpl	%r10d, %r13d
	jne	.LBB0_53
# %bb.52:                               #   in Loop: Header=BB0_10 Depth=3
	cmpq	$5, %rbp
	je	.LBB0_57
.LBB0_53:                               #   in Loop: Header=BB0_10 Depth=3
	vsubsd	40(%rax), %xmm14, %xmm2
	vsubsd	104(%rax), %xmm16, %xmm1
	vsubsd	168(%rax), %xmm18, %xmm15
	vmulsd	%xmm2, %xmm2, %xmm0
	vfmadd231sd	%xmm1, %xmm1, %xmm0     # xmm0 = (xmm1 * xmm1) + xmm0
	vfmadd231sd	%xmm15, %xmm15, %xmm0   # xmm0 = (xmm15 * xmm15) + xmm0
	vucomisd	%xmm13, %xmm0
	jae	.LBB0_54
# %bb.55:                               #   in Loop: Header=BB0_10 Depth=3
	vdivsd	%xmm0, %xmm10, %xmm0
	vmulsd	%xmm20, %xmm0, %xmm17
	vmulsd	%xmm0, %xmm0, %xmm3
	vmulsd	%xmm17, %xmm3, %xmm3
	vaddsd	%xmm11, %xmm3, %xmm17
	vmulsd	%xmm0, %xmm12, %xmm0
	vmulsd	%xmm3, %xmm17, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vfmadd231sd	%xmm2, %xmm0, %xmm7     # xmm7 = (xmm0 * xmm2) + xmm7
	vfmadd231sd	%xmm1, %xmm0, %xmm5     # xmm5 = (xmm0 * xmm1) + xmm5
	vfmadd231sd	%xmm15, %xmm0, %xmm19   # xmm19 = (xmm0 * xmm15) + xmm19
	movl	$1, %r14d
	movq	%rdx, %rbx
	jmp	.LBB0_56
	.p2align	5, 0x90
.LBB0_54:                               #   in Loop: Header=BB0_10 Depth=3
	movq	%r15, %rbx
.LBB0_56:                               #   in Loop: Header=BB0_10 Depth=3
	incq	(%rbx)
.LBB0_57:                               #   in Loop: Header=BB0_10 Depth=3
	cmpl	%r10d, %r13d
	jne	.LBB0_59
# %bb.58:                               #   in Loop: Header=BB0_10 Depth=3
	cmpq	$6, %rbp
	je	.LBB0_63
.LBB0_59:                               #   in Loop: Header=BB0_10 Depth=3
	vsubsd	48(%rax), %xmm14, %xmm2
	vsubsd	112(%rax), %xmm16, %xmm1
	vsubsd	176(%rax), %xmm18, %xmm15
	vmulsd	%xmm2, %xmm2, %xmm0
	vfmadd231sd	%xmm1, %xmm1, %xmm0     # xmm0 = (xmm1 * xmm1) + xmm0
	vfmadd231sd	%xmm15, %xmm15, %xmm0   # xmm0 = (xmm15 * xmm15) + xmm0
	vucomisd	%xmm13, %xmm0
	jae	.LBB0_60
# %bb.61:                               #   in Loop: Header=BB0_10 Depth=3
	vdivsd	%xmm0, %xmm10, %xmm0
	vmulsd	%xmm20, %xmm0, %xmm17
	vmulsd	%xmm0, %xmm0, %xmm3
	vmulsd	%xmm17, %xmm3, %xmm3
	vaddsd	%xmm11, %xmm3, %xmm17
	vmulsd	%xmm0, %xmm12, %xmm0
	vmulsd	%xmm3, %xmm17, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vfmadd231sd	%xmm2, %xmm0, %xmm7     # xmm7 = (xmm0 * xmm2) + xmm7
	vfmadd231sd	%xmm1, %xmm0, %xmm5     # xmm5 = (xmm0 * xmm1) + xmm5
	vfmadd231sd	%xmm15, %xmm0, %xmm19   # xmm19 = (xmm0 * xmm15) + xmm19
	movl	$1, %r14d
	movq	%rdx, %rbx
	jmp	.LBB0_62
	.p2align	5, 0x90
.LBB0_60:                               #   in Loop: Header=BB0_10 Depth=3
	movq	%r15, %rbx
.LBB0_62:                               #   in Loop: Header=BB0_10 Depth=3
	incq	(%rbx)
.LBB0_63:                               #   in Loop: Header=BB0_10 Depth=3
	cmpl	%r10d, %r13d
	jne	.LBB0_65
# %bb.64:                               #   in Loop: Header=BB0_10 Depth=3
	cmpq	$7, %rbp
	je	.LBB0_69
.LBB0_65:                               #   in Loop: Header=BB0_10 Depth=3
	vsubsd	56(%rax), %xmm14, %xmm2
	vsubsd	120(%rax), %xmm16, %xmm1
	vsubsd	184(%rax), %xmm18, %xmm0
	vmulsd	%xmm2, %xmm2, %xmm3
	vfmadd231sd	%xmm1, %xmm1, %xmm3     # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231sd	%xmm0, %xmm0, %xmm3     # xmm3 = (xmm0 * xmm0) + xmm3
	vucomisd	%xmm13, %xmm3
	jb	.LBB0_67
# %bb.66:                               #   in Loop: Header=BB0_10 Depth=3
	movq	%r15, %rbx
	jmp	.LBB0_68
	.p2align	5, 0x90
.LBB0_16:
	movq	40(%rsp), %rcx                  # 8-byte Reload
	incq	%rcx
	movq	16(%rsp), %rax                  # 8-byte Reload
	movq	%rcx, (%rax)
	vmovdqu	%xmm9, 8(%rax)
.LBB0_17:
	movl	$.L.str.1, %edi
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, (%rsp)                   # 8-byte Spill
	movl	$.L.str.2, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	(%rsp), %xmm0                   # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vsubsd	56(%rsp), %xmm0, %xmm0          # 8-byte Folded Reload
	addq	$152, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	computeForceLJ_ref, .Lfunc_end0-computeForceLJ_ref
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3                               # -- Begin function computeForceLJ_2xnn_half
.LCPI1_0:
	.quad	0xbfe0000000000000              #  -0.5
.LCPI1_1:
	.quad	0x4048000000000000              #  48
.LCPI1_4:
	.quad	0x3fe0000000000000              #  0.5
	.section	.rodata,"a",@progbits
	.p2align	6
.LCPI1_2:
	.quad	2                               # 0x2
	.quad	3                               # 0x3
	.quad	8                               # 0x8
	.quad	9                               # 0x9
	.quad	6                               # 0x6
	.quad	7                               # 0x7
	.quad	12                              # 0xc
	.quad	13                              # 0xd
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI1_3:
	.quad	1                               # 0x1
	.zero	8
	.text
	.globl	computeForceLJ_2xnn_half
	.p2align	4, 0x90
	.type	computeForceLJ_2xnn_half,@function
computeForceLJ_2xnn_half:               # 
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$200, %rsp
	.cfi_def_cfa_offset 256
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	movq	%rdx, %r14
	movq	%rsi, %rbx
	movq	%rdi, %r12
	movl	$.L.str.3, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	144(%r12), %xmm0                # xmm0 = mem[0],zero
	vmovsd	%xmm0, (%rsp)                   # 8-byte Spill
	vbroadcastsd	56(%r12), %zmm1
	vbroadcastsd	40(%r12), %zmm0
	vmovupd	%zmm0, 64(%rsp)                 # 64-byte Spill
	movq	%rbx, %r15
	movl	20(%rbx), %r11d
	testl	%r11d, %r11d
	jle	.LBB1_5
# %bb.1:
	movq	176(%r15), %r9
	movq	192(%r15), %r10
	decq	%r11
	leaq	128(%r9), %r8
	xorl	%edi, %edi
	vxorpd	%xmm0, %xmm0, %xmm0
	jmp	.LBB1_2
	.p2align	5, 0x90
.LBB1_21:                               #   in Loop: Header=BB1_2 Depth=1
	cmpq	%r11, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB1_5
.LBB1_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_16 Depth 2
                                        #     Child Loop BB1_20 Depth 2
	imulq	$56, %rdi, %rax
	movl	(%r10,%rax), %esi
	testl	%esi, %esi
	jle	.LBB1_21
# %bb.3:                                #   in Loop: Header=BB1_2 Depth=1
	leal	(,%rdi,4), %ebx
	movl	%ebx, %eax
	andl	$2147483640, %eax               # imm = 0x7FFFFFF8
	leal	(%rax,%rax,2), %eax
	andl	$4, %ebx
	orl	%eax, %ebx
	cmpl	$7, %esi
	ja	.LBB1_15
# %bb.4:                                #   in Loop: Header=BB1_2 Depth=1
	movl	%esi, %ebp
	andl	$-8, %ebp
	cmpq	%rsi, %rbp
	jae	.LBB1_21
	jmp	.LBB1_19
	.p2align	5, 0x90
.LBB1_15:                               #   in Loop: Header=BB1_2 Depth=1
	leaq	(,%rsi,8), %rbp
	andq	$-64, %rbp
	movl	%ebx, %ecx
	leaq	(%r9,%rcx,8), %rdx
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB1_16:                               #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%zmm0, (%rdx,%rax)
	addq	$64, %rax
	cmpq	%rax, %rbp
	jne	.LBB1_16
# %bb.17:                               #   in Loop: Header=BB1_2 Depth=1
	movl	%esi, %ebp
	andl	$-8, %ebp
	addq	%rbp, %rcx
	vmovupd	%zmm0, (%r9,%rcx,8)
	vmovupd	%zmm0, 64(%r9,%rcx,8)
	cmpq	%rsi, %rbp
	jae	.LBB1_21
.LBB1_19:                               #   in Loop: Header=BB1_2 Depth=1
	movl	%ebx, %eax
	leaq	(%r8,%rax,8), %rcx
	.p2align	4, 0x90
.LBB1_20:                               #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, -128(%rcx,%rbp,8)
	movq	$0, -64(%rcx,%rbp,8)
	movq	$0, (%rcx,%rbp,8)
	incq	%rbp
	cmpq	%rbp, %rsi
	jne	.LBB1_20
	jmp	.LBB1_21
	.p2align	5, 0x90
.LBB1_5:
	xorl	%r13d, %r13d
	xorl	%eax, %eax
	vmovupd	%zmm1, 128(%rsp)                # 64-byte Spill
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 16(%rsp)                 # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	vmovupd	128(%rsp), %zmm31               # 64-byte Reload
	cmpl	$0, 20(%r15)
	jle	.LBB1_10
# %bb.6:
	vmovsd	(%rsp), %xmm0                   # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm0
	vbroadcastsd	%xmm0, %zmm0
	vbroadcastsd	.LCPI1_0(%rip), %zmm1   # zmm1 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vbroadcastsd	.LCPI1_1(%rip), %zmm2   # zmm2 = [4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1]
	movb	$-52, %al
	kmovb	%eax, %k1
	vmovupd	.LCPI1_2(%rip), %zmm3           # zmm3 = [2,3,8,9,6,7,12,13]
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI1_4(%rip), %xmm5           # xmm5 = mem[0],zero
	movq	%r14, 24(%rsp)                  # 8-byte Spill
	movq	%r15, 8(%rsp)                   # 8-byte Spill
	movl	$248, %ebp
	jmp	.LBB1_7
	.p2align	5, 0x90
.LBB1_13:                               #   in Loop: Header=BB1_7 Depth=1
	movq	24(%rsp), %r14                  # 8-byte Reload
	movq	8(%rsp), %r15                   # 8-byte Reload
	movq	(%rsp), %rcx                    # 8-byte Reload
	movq	56(%rsp), %rdx                  # 8-byte Reload
	movq	48(%rsp), %r8                   # 8-byte Reload
	movq	40(%rsp), %rax                  # 8-byte Reload
.LBB1_9:                                #   in Loop: Header=BB1_7 Depth=1
	vblendmpd	%zmm15, %zmm13, %zmm8 {%k1}
	vpermt2pd	%zmm15, %zmm3, %zmm13
	vaddpd	%zmm13, %zmm8, %zmm8
	vpermilpd	$85, %zmm8, %zmm11      # zmm11 = zmm8[1,0,3,2,5,4,7,6]
	vaddpd	%zmm11, %zmm8, %zmm8
	vextractf64x4	$1, %zmm8, %ymm11
	vblendpd	$10, %ymm11, %ymm8, %ymm8       # ymm8 = ymm8[0],ymm11[1],ymm8[2],ymm11[3]
	vaddpd	(%r8,%rcx,8), %ymm8, %ymm8
	vmovupd	%ymm8, (%r8,%rcx,8)             # AlignMOV convert to UnAlignMOV 
	vblendmpd	%zmm10, %zmm9, %zmm8 {%k1}
	vpermt2pd	%zmm10, %zmm3, %zmm9
	vaddpd	%zmm9, %zmm8, %zmm8
	vpermilpd	$85, %zmm8, %zmm9       # zmm9 = zmm8[1,0,3,2,5,4,7,6]
	vaddpd	%zmm9, %zmm8, %zmm8
	vextractf64x4	$1, %zmm8, %ymm9
	vblendpd	$10, %ymm9, %ymm8, %ymm8        # ymm8 = ymm8[0],ymm9[1],ymm8[2],ymm9[3]
	vaddpd	64(%r8,%rcx,8), %ymm8, %ymm8
	vmovupd	%ymm8, 64(%r8,%rcx,8)           # AlignMOV convert to UnAlignMOV 
	vblendmpd	%zmm6, %zmm7, %zmm8 {%k1}
	vpermt2pd	%zmm6, %zmm3, %zmm7
	vaddpd	%zmm7, %zmm8, %zmm6
	vpermilpd	$85, %zmm6, %zmm7       # zmm7 = zmm6[1,0,3,2,5,4,7,6]
	vaddpd	%zmm7, %zmm6, %zmm6
	vextractf64x4	$1, %zmm6, %ymm7
	vblendpd	$10, %ymm7, %ymm6, %ymm6        # ymm6 = ymm6[0],ymm7[1],ymm6[2],ymm7[3]
	vaddpd	128(%r8,%rcx,8), %ymm6, %ymm6
	vmovupd	%ymm6, 128(%r8,%rcx,8)          # AlignMOV convert to UnAlignMOV 
	vmovdqu	.LCPI1_3(%rip), %xmm4           # xmm4 = <1,u>
                                        # AlignMOV convert to UnAlignMOV 
	vpinsrq	$1, %rax, %xmm4, %xmm6
	movq	32(%rsp), %rcx                  # 8-byte Reload
	vpaddq	(%rcx), %xmm6, %xmm6
	vmovdqu	%xmm6, (%rcx)
	vcvtsi2sd	%edx, %xmm12, %xmm6
	vmulsd	%xmm5, %xmm6, %xmm6
	vcvttsd2si	%xmm6, %rax
	addq	%rax, 16(%rcx)
	incq	%r13
	movslq	20(%r15), %rax
	cmpq	%rax, %r13
	jge	.LBB1_10
.LBB1_7:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_12 Depth 2
	leal	(,%r13,4), %ecx
	movl	%ecx, %eax
	andl	$2147483640, %eax               # imm = 0x7FFFFFF8
	leal	(%rax,%rax,2), %eax
	andl	$4, %ecx
	orl	%eax, %ecx
	movq	176(%r15), %r8
	movq	24(%r14), %rax
	movslq	(%rax,%r13,4), %rdx
	testq	%rdx, %rdx
	jle	.LBB1_8
# %bb.11:                               #   in Loop: Header=BB1_7 Depth=1
	movq	160(%r15), %r15
	vbroadcastsd	(%r15,%rcx,8), %ymm6
	movq	8(%r14), %rax
	vbroadcastsd	8(%r15,%rcx,8), %ymm7
	vinsertf64x4	$1, %ymm7, %zmm6, %zmm8
	vbroadcastsd	16(%r15,%rcx,8), %ymm6
	vbroadcastsd	24(%r15,%rcx,8), %ymm7
	vbroadcastsd	64(%r15,%rcx,8), %ymm9
	vbroadcastsd	72(%r15,%rcx,8), %ymm10
	vinsertf64x4	$1, %ymm7, %zmm6, %zmm11
	vinsertf64x4	$1, %ymm10, %zmm9, %zmm12
	vbroadcastsd	80(%r15,%rcx,8), %ymm6
	vbroadcastsd	88(%r15,%rcx,8), %ymm7
	vinsertf64x4	$1, %ymm7, %zmm6, %zmm14
	vbroadcastsd	128(%r15,%rcx,8), %ymm6
	vbroadcastsd	136(%r15,%rcx,8), %ymm7
	vinsertf64x4	$1, %ymm7, %zmm6, %zmm16
	vbroadcastsd	144(%r15,%rcx,8), %ymm6
	movq	%rcx, (%rsp)                    # 8-byte Spill
	vbroadcastsd	152(%r15,%rcx,8), %ymm7
	vinsertf64x4	$1, %ymm7, %zmm6, %zmm17
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movl	%edx, %edx
	movl	16(%r14), %ecx
	imull	%r13d, %ecx
	movslq	%ecx, %rcx
	leaq	(%rax,%rcx,4), %r11
	movq	%rdx, 40(%rsp)                  # 8-byte Spill
	leaq	-1(%rdx), %r12
	vxorpd	%xmm13, %xmm13, %xmm13
	movq	%r8, 48(%rsp)                   # 8-byte Spill
	xorl	%r9d, %r9d
	vxorpd	%xmm9, %xmm9, %xmm9
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm15, %xmm15, %xmm15
	vxorpd	%xmm10, %xmm10, %xmm10
	vxorpd	%xmm6, %xmm6, %xmm6
	vmovupd	64(%rsp), %zmm4                 # 64-byte Reload
	.p2align	4, 0x90
.LBB1_12:                               #   Parent Loop BB1_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%r11,%r9,4), %rdx
	leal	(%rdx,%rdx), %r10d
	movq	%rdx, %rsi
	shlq	$6, %rsi
	leaq	(%rsi,%rsi,2), %r14
	vbroadcastf64x4	(%r15,%r14), %zmm18     # zmm18 = mem[0,1,2,3,0,1,2,3]
	vbroadcastf64x4	64(%r15,%r14), %zmm19   # zmm19 = mem[0,1,2,3,0,1,2,3]
	vbroadcastf64x4	128(%r15,%r14), %zmm20  # zmm20 = mem[0,1,2,3,0,1,2,3]
	addl	%edx, %edx
	incl	%edx
	cmpq	%rdx, %r13
	sete	%dl
	movl	$0, %edi
	movl	$225, %eax
	cmovel	%eax, %edi
	movl	$0, %esi
	movl	$129, %eax
	cmovel	%eax, %esi
	xorl	%eax, %eax
	cmpq	%r10, %r13
	setne	%al
	sete	%bl
	notb	%bl
	movl	$255, %ecx
	cmovel	%ebp, %ecx
	addb	%dil, %bl
	addb	%cl, %sil
	leal	(%rax,%rax,2), %ecx
	addl	$12, %ecx
	addb	%dl, %cl
	subb	%al, %dl
	shlb	$4, %cl
	orb	%bl, %cl
	kmovd	%ecx, %k2
	shlb	$4, %dl
	orb	%sil, %dl
	kmovd	%edx, %k3
	vsubpd	%zmm18, %zmm8, %zmm21
	vsubpd	%zmm19, %zmm12, %zmm22
	vsubpd	%zmm20, %zmm16, %zmm23
	vsubpd	%zmm18, %zmm11, %zmm18
	vsubpd	%zmm19, %zmm14, %zmm19
	vsubpd	%zmm20, %zmm17, %zmm20
	vmulpd	%zmm23, %zmm23, %zmm24
	vfmadd231pd	%zmm22, %zmm22, %zmm24  # zmm24 = (zmm22 * zmm22) + zmm24
	vfmadd231pd	%zmm21, %zmm21, %zmm24  # zmm24 = (zmm21 * zmm21) + zmm24
	vmulpd	%zmm20, %zmm20, %zmm25
	vrcp14pd	%zmm24, %zmm26
	vfmadd231pd	%zmm19, %zmm19, %zmm25  # zmm25 = (zmm19 * zmm19) + zmm25
	vfmadd231pd	%zmm18, %zmm18, %zmm25  # zmm25 = (zmm18 * zmm18) + zmm25
	vrcp14pd	%zmm25, %zmm27
	vmulpd	%zmm26, %zmm31, %zmm28
	vmulpd	%zmm28, %zmm26, %zmm28
	vmulpd	%zmm28, %zmm26, %zmm28
	vmulpd	%zmm27, %zmm31, %zmm29
	vmulpd	%zmm29, %zmm27, %zmm29
	vmulpd	%zmm29, %zmm27, %zmm29
	vaddpd	%zmm1, %zmm28, %zmm30
	vmulpd	%zmm26, %zmm4, %zmm26
	vmulpd	%zmm30, %zmm26, %zmm26
	vmulpd	%zmm26, %zmm28, %zmm26
	vmulpd	%zmm2, %zmm26, %zmm26
	vaddpd	%zmm1, %zmm29, %zmm28
	vmulpd	%zmm27, %zmm4, %zmm27
	vmulpd	%zmm28, %zmm27, %zmm27
	vmulpd	%zmm27, %zmm29, %zmm27
	vmulpd	%zmm2, %zmm27, %zmm27
	vcmpltpd	%zmm0, %zmm24, %k2 {%k2}
	vmulpd	%zmm26, %zmm21, %zmm21 {%k2} {z}
	vmulpd	%zmm26, %zmm22, %zmm22 {%k2} {z}
	vmulpd	%zmm26, %zmm23, %zmm23 {%k2} {z}
	vcmpltpd	%zmm0, %zmm25, %k2 {%k3}
	vmulpd	%zmm27, %zmm18, %zmm18 {%k2} {z}
	vmulpd	%zmm27, %zmm19, %zmm19 {%k2} {z}
	vmulpd	%zmm27, %zmm20, %zmm20 {%k2} {z}
	vaddpd	%zmm21, %zmm18, %zmm24
	vaddpd	%zmm22, %zmm19, %zmm25
	vextractf64x4	$1, %zmm24, %ymm26
	vaddpd	%ymm26, %ymm24, %ymm24
	vmovupd	(%r8,%r14), %ymm26              # AlignMOV convert to UnAlignMOV 
	vsubpd	%ymm24, %ymm26, %ymm24
	vmovupd	64(%r8,%r14), %ymm26            # AlignMOV convert to UnAlignMOV 
	vmovupd	128(%r8,%r14), %ymm27           # AlignMOV convert to UnAlignMOV 
	vmovupd	%ymm24, (%r8,%r14)              # AlignMOV convert to UnAlignMOV 
	vaddpd	%zmm23, %zmm20, %zmm24
	vextractf64x4	$1, %zmm25, %ymm28
	vaddpd	%ymm28, %ymm25, %ymm25
	vsubpd	%ymm25, %ymm26, %ymm25
	vmovupd	%ymm25, 64(%r8,%r14)            # AlignMOV convert to UnAlignMOV 
	vextractf64x4	$1, %zmm24, %ymm25
	vaddpd	%ymm25, %ymm24, %ymm24
	vsubpd	%ymm24, %ymm27, %ymm24
	vmovupd	%ymm24, 128(%r8,%r14)           # AlignMOV convert to UnAlignMOV 
	vaddpd	%zmm21, %zmm13, %zmm13
	vaddpd	%zmm22, %zmm9, %zmm9
	vaddpd	%zmm23, %zmm7, %zmm7
	vaddpd	%zmm18, %zmm15, %zmm15
	vaddpd	%zmm19, %zmm10, %zmm10
	vaddpd	%zmm20, %zmm6, %zmm6
	cmpq	%r9, %r12
	je	.LBB1_13
# %bb.14:                               #   in Loop: Header=BB1_12 Depth=2
	movq	8(%rsp), %rax                   # 8-byte Reload
	movq	160(%rax), %r15
	movq	176(%rax), %r8
	incq	%r9
	jmp	.LBB1_12
	.p2align	5, 0x90
.LBB1_8:                                #   in Loop: Header=BB1_7 Depth=1
	vxorpd	%xmm6, %xmm6, %xmm6
	movq	%rdx, %rax
	vxorpd	%xmm10, %xmm10, %xmm10
	vxorpd	%xmm15, %xmm15, %xmm15
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm9, %xmm9, %xmm9
	vxorpd	%xmm13, %xmm13, %xmm13
	jmp	.LBB1_9
	.p2align	5, 0x90
.LBB1_10:
	movl	$.L.str.1, %edi
	vzeroupper
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, 64(%rsp)                 # 8-byte Spill
	movl	$.L.str.4, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	64(%rsp), %xmm0                 # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vsubsd	16(%rsp), %xmm0, %xmm0          # 8-byte Folded Reload
	addq	$200, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	computeForceLJ_2xnn_half, .Lfunc_end1-computeForceLJ_2xnn_half
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3                               # -- Begin function computeForceLJ_2xnn_full
.LCPI2_0:
	.quad	0xbfe0000000000000              #  -0.5
.LCPI2_1:
	.quad	0x4048000000000000              #  48
	.section	.rodata,"a",@progbits
	.p2align	6
.LCPI2_2:
	.quad	2                               # 0x2
	.quad	3                               # 0x3
	.quad	8                               # 0x8
	.quad	9                               # 0x9
	.quad	6                               # 0x6
	.quad	7                               # 0x7
	.quad	12                              # 0xc
	.quad	13                              # 0xd
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI2_3:
	.quad	1                               # 0x1
	.zero	8
	.text
	.globl	computeForceLJ_2xnn_full
	.p2align	4, 0x90
	.type	computeForceLJ_2xnn_full,@function
computeForceLJ_2xnn_full:               # 
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r13
	.cfi_def_cfa_offset 32
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	subq	$144, %rsp
	.cfi_def_cfa_offset 192
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rcx, %r13
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %r12
	movl	$.L.str.3, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	144(%r12), %xmm0                # xmm0 = mem[0],zero
	vmovsd	%xmm0, (%rsp)                   # 8-byte Spill
	vbroadcastsd	56(%r12), %zmm1
	vbroadcastsd	40(%r12), %zmm2
	movl	20(%r15), %r11d
	testl	%r11d, %r11d
	jle	.LBB2_5
# %bb.1:
	movq	176(%r15), %r9
	movq	192(%r15), %r10
	decq	%r11
	leaq	128(%r9), %r8
	xorl	%edi, %edi
	vxorpd	%xmm0, %xmm0, %xmm0
	jmp	.LBB2_2
	.p2align	5, 0x90
.LBB2_19:                               #   in Loop: Header=BB2_2 Depth=1
	cmpq	%r11, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB2_5
.LBB2_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_14 Depth 2
                                        #     Child Loop BB2_18 Depth 2
	imulq	$56, %rdi, %rax
	movl	(%r10,%rax), %ecx
	testl	%ecx, %ecx
	jle	.LBB2_19
# %bb.3:                                #   in Loop: Header=BB2_2 Depth=1
	leal	(,%rdi,4), %esi
	movl	%esi, %eax
	andl	$2147483640, %eax               # imm = 0x7FFFFFF8
	leal	(%rax,%rax,2), %eax
	andl	$4, %esi
	orl	%eax, %esi
	cmpl	$7, %ecx
	ja	.LBB2_13
# %bb.4:                                #   in Loop: Header=BB2_2 Depth=1
	movl	%ecx, %ebx
	andl	$-8, %ebx
	cmpq	%rcx, %rbx
	jae	.LBB2_19
	jmp	.LBB2_17
	.p2align	5, 0x90
.LBB2_13:                               #   in Loop: Header=BB2_2 Depth=1
	leaq	(,%rcx,8), %rbx
	andq	$-64, %rbx
	movl	%esi, %r12d
	leaq	(%r9,%r12,8), %rax
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB2_14:                               #   Parent Loop BB2_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%zmm0, (%rax,%rdx)
	addq	$64, %rdx
	cmpq	%rdx, %rbx
	jne	.LBB2_14
# %bb.15:                               #   in Loop: Header=BB2_2 Depth=1
	movl	%ecx, %ebx
	andl	$-8, %ebx
	addq	%rbx, %r12
	vmovupd	%zmm0, (%r9,%r12,8)
	vmovupd	%zmm0, 64(%r9,%r12,8)
	cmpq	%rcx, %rbx
	jae	.LBB2_19
.LBB2_17:                               #   in Loop: Header=BB2_2 Depth=1
	movl	%esi, %eax
	leaq	(%r8,%rax,8), %rdx
	.p2align	4, 0x90
.LBB2_18:                               #   Parent Loop BB2_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, -128(%rdx,%rbx,8)
	movq	$0, -64(%rdx,%rbx,8)
	movq	$0, (%rdx,%rbx,8)
	incq	%rbx
	cmpq	%rbx, %rcx
	jne	.LBB2_18
	jmp	.LBB2_19
	.p2align	5, 0x90
.LBB2_5:
	xorl	%r12d, %r12d
	xorl	%eax, %eax
	vmovupd	%zmm1, 16(%rsp)                 # 64-byte Spill
	vmovupd	%zmm2, 80(%rsp)                 # 64-byte Spill
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 8(%rsp)                  # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	vmovupd	80(%rsp), %zmm28                # 64-byte Reload
	vmovupd	16(%rsp), %zmm27                # 64-byte Reload
	cmpl	$0, 20(%r15)
	jle	.LBB2_10
# %bb.6:
	vmovsd	(%rsp), %xmm0                   # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm0
	vbroadcastsd	%xmm0, %zmm0
	movl	$48, %r8d
	vbroadcastsd	.LCPI2_0(%rip), %zmm1   # zmm1 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vbroadcastsd	.LCPI2_1(%rip), %zmm2   # zmm2 = [4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1]
	movb	$-52, %al
	kmovb	%eax, %k1
	vmovupd	.LCPI2_2(%rip), %zmm3           # zmm3 = [2,3,8,9,6,7,12,13]
                                        # AlignMOV convert to UnAlignMOV 
	vmovdqu	.LCPI2_3(%rip), %xmm4           # xmm4 = <1,u>
                                        # AlignMOV convert to UnAlignMOV 
	jmp	.LBB2_7
	.p2align	5, 0x90
.LBB2_8:                                #   in Loop: Header=BB2_7 Depth=1
	vxorpd	%xmm5, %xmm5, %xmm5
	vxorpd	%xmm8, %xmm8, %xmm8
	vxorpd	%xmm13, %xmm13, %xmm13
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm11, %xmm11, %xmm11
.LBB2_9:                                #   in Loop: Header=BB2_7 Depth=1
	movq	176(%r15), %rax
	vblendmpd	%zmm13, %zmm11, %zmm9 {%k1}
	vpermt2pd	%zmm13, %zmm3, %zmm11
	vaddpd	%zmm11, %zmm9, %zmm9
	vpermilpd	$85, %zmm9, %zmm10      # zmm10 = zmm9[1,0,3,2,5,4,7,6]
	vaddpd	%zmm10, %zmm9, %zmm9
	vextractf64x4	$1, %zmm9, %ymm10
	vblendpd	$10, %ymm10, %ymm9, %ymm9       # ymm9 = ymm9[0],ymm10[1],ymm9[2],ymm10[3]
	vaddpd	(%rax,%r9,8), %ymm9, %ymm9
	vmovupd	%ymm9, (%rax,%r9,8)             # AlignMOV convert to UnAlignMOV 
	vblendmpd	%zmm8, %zmm7, %zmm9 {%k1}
	vpermt2pd	%zmm8, %zmm3, %zmm7
	vaddpd	%zmm7, %zmm9, %zmm7
	vpermilpd	$85, %zmm7, %zmm8       # zmm8 = zmm7[1,0,3,2,5,4,7,6]
	vaddpd	%zmm8, %zmm7, %zmm7
	vextractf64x4	$1, %zmm7, %ymm8
	vblendpd	$10, %ymm8, %ymm7, %ymm7        # ymm7 = ymm7[0],ymm8[1],ymm7[2],ymm8[3]
	vaddpd	64(%rax,%r9,8), %ymm7, %ymm7
	vmovupd	%ymm7, 64(%rax,%r9,8)           # AlignMOV convert to UnAlignMOV 
	vblendmpd	%zmm5, %zmm6, %zmm7 {%k1}
	vpermt2pd	%zmm5, %zmm3, %zmm6
	vaddpd	%zmm6, %zmm7, %zmm5
	vpermilpd	$85, %zmm5, %zmm6       # zmm6 = zmm5[1,0,3,2,5,4,7,6]
	vaddpd	%zmm6, %zmm5, %zmm5
	vextractf64x4	$1, %zmm5, %ymm6
	vblendpd	$10, %ymm6, %ymm5, %ymm5        # ymm5 = ymm5[0],ymm6[1],ymm5[2],ymm6[3]
	vaddpd	128(%rax,%r9,8), %ymm5, %ymm5
	vmovupd	%ymm5, 128(%rax,%r9,8)          # AlignMOV convert to UnAlignMOV 
	vpinsrq	$1, %r10, %xmm4, %xmm5
	vpaddq	(%r13), %xmm5, %xmm5
	vmovdqu	%xmm5, (%r13)
	addq	%r10, 16(%r13)
	incq	%r12
	movslq	20(%r15), %rax
	cmpq	%rax, %r12
	jge	.LBB2_10
.LBB2_7:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_12 Depth 2
	leal	(,%r12,4), %r9d
	movl	%r9d, %eax
	andl	$2147483640, %eax               # imm = 0x7FFFFFF8
	leal	(%rax,%rax,2), %eax
	andl	$4, %r9d
	orl	%eax, %r9d
	movq	24(%r14), %rax
	movslq	(%rax,%r12,4), %r10
	testq	%r10, %r10
	jle	.LBB2_8
# %bb.11:                               #   in Loop: Header=BB2_7 Depth=1
	movq	160(%r15), %rsi
	movq	8(%r14), %rax
	vbroadcastsd	(%rsi,%r9,8), %ymm5
	vbroadcastsd	8(%rsi,%r9,8), %ymm6
	vbroadcastsd	16(%rsi,%r9,8), %ymm7
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm9
	vbroadcastsd	24(%rsi,%r9,8), %ymm5
	vinsertf64x4	$1, %ymm5, %zmm7, %zmm10
	vbroadcastsd	64(%rsi,%r9,8), %ymm5
	vbroadcastsd	72(%rsi,%r9,8), %ymm6
	vbroadcastsd	80(%rsi,%r9,8), %ymm7
	vbroadcastsd	88(%rsi,%r9,8), %ymm8
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm12
	vinsertf64x4	$1, %ymm8, %zmm7, %zmm14
	vbroadcastsd	128(%rsi,%r9,8), %ymm5
	vbroadcastsd	136(%rsi,%r9,8), %ymm6
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm15
	vbroadcastsd	144(%rsi,%r9,8), %ymm5
	vbroadcastsd	152(%rsi,%r9,8), %ymm6
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm16
	movl	%r10d, %r10d
	movl	16(%r14), %ecx
	imull	%r12d, %ecx
	movslq	%ecx, %rcx
	leaq	(%rax,%rcx,4), %rdi
	vxorpd	%xmm11, %xmm11, %xmm11
	xorl	%eax, %eax
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm13, %xmm13, %xmm13
	vxorpd	%xmm8, %xmm8, %xmm8
	vxorpd	%xmm5, %xmm5, %xmm5
	.p2align	4, 0x90
.LBB2_12:                               #   Parent Loop BB2_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%rdi,%rax,4), %rcx
	leaq	(%rcx,%rcx,2), %rdx
	shlq	$6, %rdx
	vbroadcastf64x4	64(%rsi,%rdx), %zmm21   # zmm21 = mem[0,1,2,3,0,1,2,3]
	vbroadcastf64x4	128(%rsi,%rdx), %zmm22  # zmm22 = mem[0,1,2,3,0,1,2,3]
	vbroadcastf64x4	(%rsi,%rdx), %zmm20     # zmm20 = mem[0,1,2,3,0,1,2,3]
	vsubpd	%zmm20, %zmm9, %zmm19
	vsubpd	%zmm21, %zmm12, %zmm17
	vsubpd	%zmm22, %zmm15, %zmm18
	vmulpd	%zmm18, %zmm18, %zmm23
	vfmadd231pd	%zmm17, %zmm17, %zmm23  # zmm23 = (zmm17 * zmm17) + zmm23
	vfmadd231pd	%zmm19, %zmm19, %zmm23  # zmm23 = (zmm19 * zmm19) + zmm23
	vrcp14pd	%zmm23, %zmm24
	vmulpd	%zmm24, %zmm27, %zmm25
	vmulpd	%zmm25, %zmm24, %zmm25
	vmulpd	%zmm25, %zmm24, %zmm25
	vaddpd	%zmm1, %zmm25, %zmm26
	vmulpd	%zmm24, %zmm28, %zmm24
	vmulpd	%zmm26, %zmm24, %zmm24
	vmulpd	%zmm24, %zmm25, %zmm24
	vsubpd	%zmm21, %zmm14, %zmm21
	vsubpd	%zmm22, %zmm16, %zmm22
	leal	(%rcx,%rcx), %edx
	cmpq	%rdx, %r12
	setne	%dl
	leal	1(%rcx,%rcx), %ecx
	sete	%bl
	cmpq	%rcx, %r12
	movl	$0, %ecx
	cmovel	%r8d, %ecx
	notb	%bl
	addb	%cl, %bl
	movl	%edx, %ecx
	vsubpd	%zmm20, %zmm10, %zmm20
	shlb	$5, %cl
	orb	%bl, %cl
	orb	$-48, %cl
	kmovd	%ecx, %k2
	vcmpltpd	%zmm0, %zmm23, %k2 {%k2}
	vmulpd	%zmm22, %zmm22, %zmm23
	vfmadd231pd	%zmm21, %zmm21, %zmm23  # zmm23 = (zmm21 * zmm21) + zmm23
	vfmadd231pd	%zmm20, %zmm20, %zmm23  # zmm23 = (zmm20 * zmm20) + zmm23
	vmulpd	%zmm2, %zmm24, %zmm24
	vfmadd231pd	%zmm24, %zmm19, %zmm11 {%k2} # zmm11 {%k2} = (zmm19 * zmm24) + zmm11
	vrcp14pd	%zmm23, %zmm19
	vfmadd231pd	%zmm24, %zmm17, %zmm7 {%k2} # zmm7 {%k2} = (zmm17 * zmm24) + zmm7
	vfmadd231pd	%zmm24, %zmm18, %zmm6 {%k2} # zmm6 {%k2} = (zmm18 * zmm24) + zmm6
	vmulpd	%zmm19, %zmm27, %zmm17
	vmulpd	%zmm17, %zmm19, %zmm17
	vmulpd	%zmm17, %zmm19, %zmm17
	vaddpd	%zmm1, %zmm17, %zmm18
	vmulpd	%zmm19, %zmm28, %zmm19
	vmulpd	%zmm18, %zmm19, %zmm18
	vmulpd	%zmm18, %zmm17, %zmm17
	shlb	$2, %dl
	orb	$-5, %dl
	kmovd	%edx, %k2
	vcmpltpd	%zmm0, %zmm23, %k2 {%k2}
	vmulpd	%zmm2, %zmm17, %zmm17
	vfmadd231pd	%zmm17, %zmm20, %zmm13 {%k2} # zmm13 {%k2} = (zmm20 * zmm17) + zmm13
	vfmadd231pd	%zmm17, %zmm21, %zmm8 {%k2} # zmm8 {%k2} = (zmm21 * zmm17) + zmm8
	vfmadd231pd	%zmm17, %zmm22, %zmm5 {%k2} # zmm5 {%k2} = (zmm22 * zmm17) + zmm5
	incq	%rax
	cmpq	%rax, %r10
	jne	.LBB2_12
	jmp	.LBB2_9
	.p2align	5, 0x90
.LBB2_10:
	movl	$.L.str.1, %edi
	vzeroupper
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, 16(%rsp)                 # 8-byte Spill
	movl	$.L.str.4, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	16(%rsp), %xmm0                 # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vsubsd	8(%rsp), %xmm0, %xmm0           # 8-byte Folded Reload
	addq	$144, %rsp
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	computeForceLJ_2xnn_full, .Lfunc_end2-computeForceLJ_2xnn_full
	.cfi_endproc
                                        # -- End function
	.globl	computeForceLJ_2xnn             # -- Begin function computeForceLJ_2xnn
	.p2align	4, 0x90
	.type	computeForceLJ_2xnn,@function
computeForceLJ_2xnn:                    # 
	.cfi_startproc
# %bb.0:
	cmpl	$0, 32(%rdx)
	je	.LBB3_2
# %bb.1:
	jmp	computeForceLJ_2xnn_half        # TAILCALL
	.p2align	5, 0x90
.LBB3_2:
	jmp	computeForceLJ_2xnn_full        # TAILCALL
.Lfunc_end3:
	.size	computeForceLJ_2xnn, .Lfunc_end3-computeForceLJ_2xnn
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3                               # -- Begin function computeForceLJ_4xn_half
.LCPI4_0:
	.quad	0xbfe0000000000000              #  -0.5
.LCPI4_1:
	.quad	0x4048000000000000              #  48
.LCPI4_3:
	.quad	0x3fe0000000000000              #  0.5
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI4_2:
	.quad	1                               # 0x1
	.zero	8
	.text
	.globl	computeForceLJ_4xn_half
	.p2align	4, 0x90
	.type	computeForceLJ_4xn_half,@function
computeForceLJ_4xn_half:                # 
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$1352, %rsp                     # imm = 0x548
	.cfi_def_cfa_offset 1408
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	movq	%rdx, %r14
	movq	%rsi, %rbx
	movq	%rdi, %r12
	movl	$.L.str.5, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	144(%r12), %xmm0                # xmm0 = mem[0],zero
	vmovsd	%xmm0, 64(%rsp)                 # 8-byte Spill
	vbroadcastsd	56(%r12), %zmm0
	vmovups	%zmm0, 512(%rsp)                # 64-byte Spill
	vbroadcastsd	40(%r12), %zmm0
	vmovupd	%zmm0, 448(%rsp)                # 64-byte Spill
	movq	%rbx, %r15
	movl	20(%rbx), %r11d
	testl	%r11d, %r11d
	jle	.LBB4_5
# %bb.1:
	movq	176(%r15), %r9
	movq	192(%r15), %r10
	decq	%r11
	leaq	128(%r9), %r8
	xorl	%edi, %edi
	vxorpd	%xmm0, %xmm0, %xmm0
	jmp	.LBB4_2
	.p2align	5, 0x90
.LBB4_21:                               #   in Loop: Header=BB4_2 Depth=1
	cmpq	%r11, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB4_5
.LBB4_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_16 Depth 2
                                        #     Child Loop BB4_20 Depth 2
	imulq	$56, %rdi, %rax
	movl	(%r10,%rax), %esi
	testl	%esi, %esi
	jle	.LBB4_21
# %bb.3:                                #   in Loop: Header=BB4_2 Depth=1
	leal	(,%rdi,4), %ebx
	movl	%ebx, %eax
	andl	$2147483640, %eax               # imm = 0x7FFFFFF8
	leal	(%rax,%rax,2), %eax
	andl	$4, %ebx
	orl	%eax, %ebx
	cmpl	$7, %esi
	ja	.LBB4_15
# %bb.4:                                #   in Loop: Header=BB4_2 Depth=1
	movl	%esi, %ebp
	andl	$-8, %ebp
	cmpq	%rsi, %rbp
	jae	.LBB4_21
	jmp	.LBB4_19
	.p2align	5, 0x90
.LBB4_15:                               #   in Loop: Header=BB4_2 Depth=1
	leaq	(,%rsi,8), %rbp
	andq	$-64, %rbp
	movl	%ebx, %ecx
	leaq	(%r9,%rcx,8), %rdx
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB4_16:                               #   Parent Loop BB4_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%zmm0, (%rdx,%rax)
	addq	$64, %rax
	cmpq	%rax, %rbp
	jne	.LBB4_16
# %bb.17:                               #   in Loop: Header=BB4_2 Depth=1
	movl	%esi, %ebp
	andl	$-8, %ebp
	addq	%rbp, %rcx
	vmovupd	%zmm0, (%r9,%rcx,8)
	vmovupd	%zmm0, 64(%r9,%rcx,8)
	cmpq	%rsi, %rbp
	jae	.LBB4_21
.LBB4_19:                               #   in Loop: Header=BB4_2 Depth=1
	movl	%ebx, %eax
	leaq	(%r8,%rax,8), %rcx
	.p2align	4, 0x90
.LBB4_20:                               #   Parent Loop BB4_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, -128(%rcx,%rbp,8)
	movq	$0, -64(%rcx,%rbp,8)
	movq	$0, (%rcx,%rbp,8)
	incq	%rbp
	cmpq	%rbp, %rsi
	jne	.LBB4_20
	jmp	.LBB4_21
	.p2align	5, 0x90
.LBB4_5:
	xorl	%r13d, %r13d
	xorl	%eax, %eax
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 8(%rsp)                  # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	cmpl	$0, 20(%r15)
	jle	.LBB4_10
# %bb.6:
	vmovsd	64(%rsp), %xmm0                 # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm0
	vbroadcastsd	%xmm0, %zmm0
	vmovupd	%zmm0, 384(%rsp)                # 64-byte Spill
	movq	%r14, 16(%rsp)                  # 8-byte Spill
	movq	%r15, (%rsp)                    # 8-byte Spill
	vmovupd	512(%rsp), %zmm29               # 64-byte Reload
	vbroadcastsd	.LCPI4_0(%rip), %zmm31  # zmm31 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vmovupd	448(%rsp), %zmm30               # 64-byte Reload
	jmp	.LBB4_7
	.p2align	5, 0x90
.LBB4_13:                               #   in Loop: Header=BB4_7 Depth=1
	movq	16(%rsp), %r14                  # 8-byte Reload
	movq	(%rsp), %r15                    # 8-byte Reload
	movq	56(%rsp), %rax                  # 8-byte Reload
	movq	48(%rsp), %rdx                  # 8-byte Reload
	movq	40(%rsp), %r10                  # 8-byte Reload
	movq	32(%rsp), %rcx                  # 8-byte Reload
.LBB4_9:                                #   in Loop: Header=BB4_7 Depth=1
	vshufpd	$85, %zmm16, %zmm13, %zmm3      # zmm3 = zmm13[1],zmm16[0],zmm13[3],zmm16[2],zmm13[5],zmm16[4],zmm13[7],zmm16[6]
	vshufpd	$170, %zmm16, %zmm13, %zmm4     # zmm4 = zmm13[0],zmm16[1],zmm13[2],zmm16[3],zmm13[4],zmm16[5],zmm13[6],zmm16[7]
	vaddpd	%zmm3, %zmm4, %zmm3
	vshufpd	$85, %zmm15, %zmm14, %zmm4      # zmm4 = zmm14[1],zmm15[0],zmm14[3],zmm15[2],zmm14[5],zmm15[4],zmm14[7],zmm15[6]
	vshufpd	$170, %zmm15, %zmm14, %zmm13    # zmm13 = zmm14[0],zmm15[1],zmm14[2],zmm15[3],zmm14[4],zmm15[5],zmm14[6],zmm15[7]
	vaddpd	%zmm4, %zmm13, %zmm4
	vshuff64x2	$78, %zmm4, %zmm3, %zmm13 # zmm13 = zmm3[4,5,6,7],zmm4[0,1,2,3]
	vshuff64x2	$228, %zmm4, %zmm3, %zmm3 # zmm3 = zmm3[0,1,2,3],zmm4[4,5,6,7]
	vaddpd	%zmm13, %zmm3, %zmm3
	vpermpd	$78, %zmm3, %zmm4               # zmm4 = zmm3[2,3,0,1,6,7,4,5]
	vaddpd	%zmm4, %zmm3, %zmm3
	vextractf64x4	$1, %zmm3, %ymm4
	vblendpd	$12, %ymm4, %ymm3, %ymm3        # ymm3 = ymm3[0,1],ymm4[2,3]
	vaddpd	(%r10,%rax,8), %ymm3, %ymm3
	vmovupd	%ymm3, (%r10,%rax,8)            # AlignMOV convert to UnAlignMOV 
	vshufpd	$85, %zmm12, %zmm11, %zmm3      # zmm3 = zmm11[1],zmm12[0],zmm11[3],zmm12[2],zmm11[5],zmm12[4],zmm11[7],zmm12[6]
	vshufpd	$170, %zmm12, %zmm11, %zmm4     # zmm4 = zmm11[0],zmm12[1],zmm11[2],zmm12[3],zmm11[4],zmm12[5],zmm11[6],zmm12[7]
	vaddpd	%zmm3, %zmm4, %zmm3
	vshufpd	$85, %zmm9, %zmm23, %zmm4       # zmm4 = zmm23[1],zmm9[0],zmm23[3],zmm9[2],zmm23[5],zmm9[4],zmm23[7],zmm9[6]
	vshufpd	$170, %zmm9, %zmm23, %zmm9      # zmm9 = zmm23[0],zmm9[1],zmm23[2],zmm9[3],zmm23[4],zmm9[5],zmm23[6],zmm9[7]
	vaddpd	%zmm4, %zmm9, %zmm4
	vshuff64x2	$78, %zmm4, %zmm3, %zmm9 # zmm9 = zmm3[4,5,6,7],zmm4[0,1,2,3]
	vshuff64x2	$228, %zmm4, %zmm3, %zmm3 # zmm3 = zmm3[0,1,2,3],zmm4[4,5,6,7]
	vaddpd	%zmm9, %zmm3, %zmm3
	vpermpd	$78, %zmm3, %zmm4               # zmm4 = zmm3[2,3,0,1,6,7,4,5]
	vaddpd	%zmm4, %zmm3, %zmm3
	vextractf64x4	$1, %zmm3, %ymm4
	vblendpd	$12, %ymm4, %ymm3, %ymm3        # ymm3 = ymm3[0,1],ymm4[2,3]
	vaddpd	64(%r10,%rax,8), %ymm3, %ymm3
	vmovupd	%ymm3, 64(%r10,%rax,8)          # AlignMOV convert to UnAlignMOV 
	vshufpd	$85, %zmm8, %zmm7, %zmm3        # zmm3 = zmm7[1],zmm8[0],zmm7[3],zmm8[2],zmm7[5],zmm8[4],zmm7[7],zmm8[6]
	vshufpd	$170, %zmm8, %zmm7, %zmm4       # zmm4 = zmm7[0],zmm8[1],zmm7[2],zmm8[3],zmm7[4],zmm8[5],zmm7[6],zmm8[7]
	vaddpd	%zmm3, %zmm4, %zmm3
	vshufpd	$85, %zmm5, %zmm6, %zmm4        # zmm4 = zmm6[1],zmm5[0],zmm6[3],zmm5[2],zmm6[5],zmm5[4],zmm6[7],zmm5[6]
	vshufpd	$170, %zmm5, %zmm6, %zmm5       # zmm5 = zmm6[0],zmm5[1],zmm6[2],zmm5[3],zmm6[4],zmm5[5],zmm6[6],zmm5[7]
	vaddpd	%zmm4, %zmm5, %zmm4
	vshuff64x2	$78, %zmm4, %zmm3, %zmm5 # zmm5 = zmm3[4,5,6,7],zmm4[0,1,2,3]
	vshuff64x2	$228, %zmm4, %zmm3, %zmm3 # zmm3 = zmm3[0,1,2,3],zmm4[4,5,6,7]
	vaddpd	%zmm5, %zmm3, %zmm3
	vpermpd	$78, %zmm3, %zmm4               # zmm4 = zmm3[2,3,0,1,6,7,4,5]
	vaddpd	%zmm4, %zmm3, %zmm3
	vextractf64x4	$1, %zmm3, %ymm4
	vblendpd	$12, %ymm4, %ymm3, %ymm3        # ymm3 = ymm3[0,1],ymm4[2,3]
	vaddpd	128(%r10,%rax,8), %ymm3, %ymm3
	vmovupd	%ymm3, 128(%r10,%rax,8)         # AlignMOV convert to UnAlignMOV 
	vmovdqu	.LCPI4_2(%rip), %xmm0           # xmm0 = <1,u>
                                        # AlignMOV convert to UnAlignMOV 
	vpinsrq	$1, %rcx, %xmm0, %xmm3
	movq	24(%rsp), %rcx                  # 8-byte Reload
	vpaddq	(%rcx), %xmm3, %xmm3
	vmovdqu	%xmm3, (%rcx)
	vcvtsi2sd	%edx, %xmm10, %xmm3
	vmulsd	.LCPI4_3(%rip), %xmm3, %xmm3
	vcvttsd2si	%xmm3, %rax
	addq	%rax, 16(%rcx)
	incq	%r13
	movslq	20(%r15), %rax
	cmpq	%rax, %r13
	jge	.LBB4_10
.LBB4_7:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_12 Depth 2
	leal	(,%r13,4), %eax
	movl	%eax, %ecx
	andl	$2147483640, %ecx               # imm = 0x7FFFFFF8
	leal	(%rcx,%rcx,2), %ecx
	andl	$4, %eax
	orl	%ecx, %eax
	movq	176(%r15), %r10
	movq	24(%r14), %rcx
	movslq	(%rcx,%r13,4), %rdx
	testq	%rdx, %rdx
	jle	.LBB4_8
# %bb.11:                               #   in Loop: Header=BB4_7 Depth=1
	movq	160(%r15), %r15
	vbroadcastsd	(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 1280(%rsp)               # 64-byte Spill
	vbroadcastsd	8(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 1216(%rsp)               # 64-byte Spill
	vbroadcastsd	16(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 1152(%rsp)               # 64-byte Spill
	vbroadcastsd	24(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 1088(%rsp)               # 64-byte Spill
	vbroadcastsd	64(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 1024(%rsp)               # 64-byte Spill
	vbroadcastsd	72(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 960(%rsp)                # 64-byte Spill
	vbroadcastsd	80(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 896(%rsp)                # 64-byte Spill
	vbroadcastsd	88(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 832(%rsp)                # 64-byte Spill
	vbroadcastsd	128(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 768(%rsp)                # 64-byte Spill
	vbroadcastsd	136(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 704(%rsp)                # 64-byte Spill
	movq	8(%r14), %rcx
	vbroadcastsd	144(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 640(%rsp)                # 64-byte Spill
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	vbroadcastsd	152(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 576(%rsp)                # 64-byte Spill
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movl	%edx, %eax
	movl	16(%r14), %ebp
	imull	%r13d, %ebp
	movslq	%ebp, %rbp
	leaq	(%rcx,%rbp,4), %r8
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	leaq	-1(%rax), %r12
	vxorpd	%xmm13, %xmm13, %xmm13
	movq	%r10, 40(%rsp)                  # 8-byte Spill
	xorl	%r14d, %r14d
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%zmm0, 256(%rsp)                # 64-byte Spill
	vxorpd	%xmm16, %xmm16, %xmm16
	vxorpd	%xmm12, %xmm12, %xmm12
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%zmm0, 192(%rsp)                # 64-byte Spill
	vxorpd	%xmm14, %xmm14, %xmm14
	vxorpd	%xmm23, %xmm23, %xmm23
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%zmm0, 320(%rsp)                # 64-byte Spill
	vxorpd	%xmm15, %xmm15, %xmm15
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%zmm0, 128(%rsp)                # 64-byte Spill
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%zmm0, 64(%rsp)                 # 64-byte Spill
	movl	$129, %ecx
	.p2align	4, 0x90
.LBB4_12:                               #   Parent Loop BB4_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%r8,%r14,4), %r9
	movq	%r9, %rdx
	shlq	$6, %rdx
	leaq	(%rdx,%rdx,2), %r11
	vmovupd	(%r15,%r11), %zmm17             # AlignMOV convert to UnAlignMOV 
	vmovupd	64(%r15,%r11), %zmm24           # AlignMOV convert to UnAlignMOV 
	vmovupd	128(%r15,%r11), %zmm25          # AlignMOV convert to UnAlignMOV 
	vmovupd	1280(%rsp), %zmm0               # 64-byte Reload
	vsubpd	%zmm17, %zmm0, %zmm20
	vmovupd	1024(%rsp), %zmm0               # 64-byte Reload
	vsubpd	%zmm24, %zmm0, %zmm22
	vmovupd	768(%rsp), %zmm0                # 64-byte Reload
	vsubpd	%zmm25, %zmm0, %zmm18
	vmovupd	1216(%rsp), %zmm0               # 64-byte Reload
	vsubpd	%zmm17, %zmm0, %zmm4
	vmovupd	960(%rsp), %zmm0                # 64-byte Reload
	vsubpd	%zmm24, %zmm0, %zmm10
	vmovupd	704(%rsp), %zmm0                # 64-byte Reload
	vsubpd	%zmm25, %zmm0, %zmm21
	vmovupd	1152(%rsp), %zmm0               # 64-byte Reload
	vsubpd	%zmm17, %zmm0, %zmm1
	vmovupd	896(%rsp), %zmm0                # 64-byte Reload
	vsubpd	%zmm24, %zmm0, %zmm8
	vmovupd	640(%rsp), %zmm0                # 64-byte Reload
	vsubpd	%zmm25, %zmm0, %zmm19
	vmovupd	1088(%rsp), %zmm0               # 64-byte Reload
	vsubpd	%zmm17, %zmm0, %zmm7
	vmovupd	832(%rsp), %zmm0                # 64-byte Reload
	vsubpd	%zmm24, %zmm0, %zmm9
	vmovupd	576(%rsp), %zmm0                # 64-byte Reload
	vsubpd	%zmm25, %zmm0, %zmm17
	vmulpd	%zmm18, %zmm18, %zmm24
	vfmadd231pd	%zmm22, %zmm22, %zmm24  # zmm24 = (zmm22 * zmm22) + zmm24
	vfmadd231pd	%zmm20, %zmm20, %zmm24  # zmm24 = (zmm20 * zmm20) + zmm24
	vmulpd	%zmm21, %zmm21, %zmm25
	vfmadd231pd	%zmm10, %zmm10, %zmm25  # zmm25 = (zmm10 * zmm10) + zmm25
	vfmadd231pd	%zmm4, %zmm4, %zmm25    # zmm25 = (zmm4 * zmm4) + zmm25
	vmovapd	%zmm4, %zmm3
	vmulpd	%zmm19, %zmm19, %zmm26
	vfmadd231pd	%zmm8, %zmm8, %zmm26    # zmm26 = (zmm8 * zmm8) + zmm26
	vfmadd231pd	%zmm1, %zmm1, %zmm26    # zmm26 = (zmm1 * zmm1) + zmm26
	vmovapd	%zmm1, %zmm4
	vmulpd	%zmm17, %zmm17, %zmm27
	vrcp14pd	%zmm24, %zmm28
	vrcp14pd	%zmm25, %zmm1
	vrcp14pd	%zmm26, %zmm2
	vfmadd231pd	%zmm9, %zmm9, %zmm27    # zmm27 = (zmm9 * zmm9) + zmm27
	vfmadd231pd	%zmm7, %zmm7, %zmm27    # zmm27 = (zmm7 * zmm7) + zmm27
	vrcp14pd	%zmm27, %zmm0
	vmulpd	%zmm28, %zmm29, %zmm5
	vmulpd	%zmm5, %zmm28, %zmm5
	vmulpd	%zmm5, %zmm28, %zmm5
	vaddpd	%zmm31, %zmm5, %zmm6
	vmulpd	%zmm28, %zmm30, %zmm28
	vmulpd	%zmm6, %zmm28, %zmm6
	vmulpd	%zmm1, %zmm29, %zmm28
	vmulpd	%zmm28, %zmm1, %zmm28
	vmulpd	%zmm28, %zmm1, %zmm28
	vmulpd	%zmm6, %zmm5, %zmm5
	vaddpd	%zmm31, %zmm28, %zmm6
	vmulpd	%zmm1, %zmm30, %zmm1
	vmulpd	%zmm6, %zmm1, %zmm1
	vmulpd	%zmm2, %zmm29, %zmm6
	vmulpd	%zmm6, %zmm2, %zmm6
	vmulpd	%zmm6, %zmm2, %zmm6
	vmulpd	%zmm1, %zmm28, %zmm1
	vaddpd	%zmm31, %zmm6, %zmm28
	vmulpd	%zmm2, %zmm30, %zmm2
	vmulpd	%zmm28, %zmm2, %zmm2
	vmulpd	%zmm0, %zmm29, %zmm28
	vmulpd	%zmm28, %zmm0, %zmm28
	vmulpd	%zmm28, %zmm0, %zmm28
	vmulpd	%zmm2, %zmm6, %zmm2
	vaddpd	%zmm31, %zmm28, %zmm6
	vmulpd	%zmm0, %zmm30, %zmm0
	vmulpd	%zmm6, %zmm0, %zmm0
	vmulpd	%zmm0, %zmm28, %zmm0
	leal	(%r9,%r9), %edx
	leal	(%r9,%r9), %esi
	incl	%esi
	xorl	%edi, %edi
	cmpq	%rdx, %r13
	sete	%al
	setne	%dil
	movl	$255, %r15d
	movl	$248, %edx
	cmovel	%edx, %r15d
	movl	$255, %ebp
	movl	$240, %edx
	cmovel	%edx, %ebp
	cmpq	%rsi, %r13
	sete	%r9b
	movl	$0, %esi
	movl	$225, %edx
	cmovel	%edx, %esi
	notb	%al
	movl	$0, %ebx
	movl	$193, %edx
	cmovel	%edx, %ebx
	movl	$0, %edx
	cmovel	%ecx, %edx
	addb	%sil, %al
	kmovd	%eax, %k1
	vmovupd	384(%rsp), %zmm28               # 64-byte Reload
	vcmpltpd	%zmm28, %zmm24, %k1 {%k1}
	vbroadcastsd	.LCPI4_1(%rip), %zmm24  # zmm24 = [4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1]
	vmulpd	%zmm24, %zmm5, %zmm5
	vmulpd	%zmm5, %zmm20, %zmm6 {%k1} {z}
	vmulpd	%zmm5, %zmm22, %zmm20 {%k1} {z}
	vmulpd	%zmm5, %zmm18, %zmm5 {%k1} {z}
	leal	(%rdi,%rdi,2), %eax
	addl	$252, %eax
	addb	%al, %bl
	kmovd	%ebx, %k1
	vcmpltpd	%zmm28, %zmm25, %k1 {%k1}
	vmulpd	%zmm24, %zmm1, %zmm1
	vmulpd	%zmm1, %zmm3, %zmm3 {%k1} {z}
	vmulpd	%zmm1, %zmm10, %zmm18 {%k1} {z}
	vmulpd	%zmm1, %zmm21, %zmm1 {%k1} {z}
	addb	%r15b, %dl
	kmovd	%edx, %k1
	vcmpltpd	%zmm28, %zmm26, %k1 {%k1}
	vmulpd	%zmm24, %zmm2, %zmm2
	vmulpd	%zmm2, %zmm4, %zmm21 {%k1} {z}
	vmulpd	%zmm2, %zmm8, %zmm4 {%k1} {z}
	vmulpd	%zmm2, %zmm19, %zmm2 {%k1} {z}
	addb	%r9b, %bpl
	kmovd	%ebp, %k1
	vcmpltpd	%zmm28, %zmm27, %k1 {%k1}
	vmulpd	%zmm24, %zmm0, %zmm0
	vmulpd	%zmm0, %zmm7, %zmm19 {%k1} {z}
	vmulpd	%zmm0, %zmm9, %zmm22 {%k1} {z}
	vmulpd	%zmm0, %zmm17, %zmm0 {%k1} {z}
	vaddpd	%zmm6, %zmm13, %zmm13
	vaddpd	%zmm3, %zmm16, %zmm16
	vaddpd	%zmm21, %zmm14, %zmm14
	vaddpd	%zmm19, %zmm15, %zmm15
	vaddpd	%zmm3, %zmm6, %zmm3
	vaddpd	%zmm19, %zmm21, %zmm6
	vaddpd	%zmm6, %zmm3, %zmm3
	vmovupd	(%r10,%r11), %zmm6              # AlignMOV convert to UnAlignMOV 
	vmovupd	64(%r10,%r11), %zmm17           # AlignMOV convert to UnAlignMOV 
	vmovupd	128(%r10,%r11), %zmm19          # AlignMOV convert to UnAlignMOV 
	vsubpd	%zmm3, %zmm6, %zmm3
	vmovupd	%zmm3, (%r10,%r11)              # AlignMOV convert to UnAlignMOV 
	vaddpd	%zmm20, %zmm11, %zmm11
	vaddpd	%zmm18, %zmm12, %zmm12
	vaddpd	%zmm18, %zmm20, %zmm3
	vaddpd	%zmm4, %zmm23, %zmm23
	vaddpd	%zmm22, %zmm4, %zmm4
	vaddpd	%zmm4, %zmm3, %zmm3
	vsubpd	%zmm3, %zmm17, %zmm3
	vmovupd	%zmm3, 64(%r10,%r11)            # AlignMOV convert to UnAlignMOV 
	vmovupd	128(%rsp), %zmm9                # 64-byte Reload
	vaddpd	%zmm22, %zmm9, %zmm9
	vmovupd	256(%rsp), %zmm7                # 64-byte Reload
	vaddpd	%zmm5, %zmm7, %zmm7
	vmovupd	192(%rsp), %zmm8                # 64-byte Reload
	vaddpd	%zmm1, %zmm8, %zmm8
	vaddpd	%zmm1, %zmm5, %zmm1
	vmovupd	320(%rsp), %zmm6                # 64-byte Reload
	vaddpd	%zmm2, %zmm6, %zmm6
	vmovupd	64(%rsp), %zmm5                 # 64-byte Reload
	vaddpd	%zmm0, %zmm5, %zmm5
	vaddpd	%zmm0, %zmm2, %zmm0
	vaddpd	%zmm0, %zmm1, %zmm0
	vsubpd	%zmm0, %zmm19, %zmm0
	vmovupd	%zmm0, 128(%r10,%r11)           # AlignMOV convert to UnAlignMOV 
	cmpq	%r14, %r12
	je	.LBB4_13
# %bb.14:                               #   in Loop: Header=BB4_12 Depth=2
	vmovupd	%zmm9, 128(%rsp)                # 64-byte Spill
	vmovupd	%zmm8, 192(%rsp)                # 64-byte Spill
	vmovupd	%zmm7, 256(%rsp)                # 64-byte Spill
	vmovupd	%zmm6, 320(%rsp)                # 64-byte Spill
	vmovupd	%zmm5, 64(%rsp)                 # 64-byte Spill
	movq	(%rsp), %rax                    # 8-byte Reload
	movq	160(%rax), %r15
	movq	176(%rax), %r10
	incq	%r14
	jmp	.LBB4_12
	.p2align	5, 0x90
.LBB4_8:                                #   in Loop: Header=BB4_7 Depth=1
	vxorpd	%xmm5, %xmm5, %xmm5
	movq	%rdx, %rcx
	vxorpd	%xmm9, %xmm9, %xmm9
	vxorpd	%xmm15, %xmm15, %xmm15
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm23, %xmm23, %xmm23
	vxorpd	%xmm14, %xmm14, %xmm14
	vxorpd	%xmm8, %xmm8, %xmm8
	vxorpd	%xmm12, %xmm12, %xmm12
	vxorpd	%xmm16, %xmm16, %xmm16
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorpd	%xmm13, %xmm13, %xmm13
	jmp	.LBB4_9
	.p2align	5, 0x90
.LBB4_10:
	movl	$.L.str.1, %edi
	vzeroupper
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, 64(%rsp)                 # 8-byte Spill
	movl	$.L.str.6, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	64(%rsp), %xmm0                 # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vsubsd	8(%rsp), %xmm0, %xmm0           # 8-byte Folded Reload
	addq	$1352, %rsp                     # imm = 0x548
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end4:
	.size	computeForceLJ_4xn_half, .Lfunc_end4-computeForceLJ_4xn_half
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3                               # -- Begin function computeForceLJ_4xn_full
.LCPI5_0:
	.quad	0xbfe0000000000000              #  -0.5
.LCPI5_1:
	.quad	0x4048000000000000              #  48
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI5_2:
	.quad	1                               # 0x1
	.zero	8
	.text
	.globl	computeForceLJ_4xn_full
	.p2align	4, 0x90
	.type	computeForceLJ_4xn_full,@function
computeForceLJ_4xn_full:                # 
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$600, %rsp                      # imm = 0x258
	.cfi_def_cfa_offset 656
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rcx, %r13
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %r12
	movl	$.L.str.5, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	144(%r12), %xmm0                # xmm0 = mem[0],zero
	vmovsd	%xmm0, 16(%rsp)                 # 8-byte Spill
	vbroadcastsd	56(%r12), %zmm1
	vbroadcastsd	40(%r12), %zmm2
	movl	20(%r15), %r11d
	testl	%r11d, %r11d
	jle	.LBB5_5
# %bb.1:
	movq	176(%r15), %r9
	movq	192(%r15), %r10
	decq	%r11
	leaq	128(%r9), %r8
	xorl	%edi, %edi
	vxorpd	%xmm0, %xmm0, %xmm0
	jmp	.LBB5_2
	.p2align	5, 0x90
.LBB5_19:                               #   in Loop: Header=BB5_2 Depth=1
	cmpq	%r11, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB5_5
.LBB5_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_14 Depth 2
                                        #     Child Loop BB5_18 Depth 2
	imulq	$56, %rdi, %rax
	movl	(%r10,%rax), %ecx
	testl	%ecx, %ecx
	jle	.LBB5_19
# %bb.3:                                #   in Loop: Header=BB5_2 Depth=1
	leal	(,%rdi,4), %esi
	movl	%esi, %eax
	andl	$2147483640, %eax               # imm = 0x7FFFFFF8
	leal	(%rax,%rax,2), %eax
	andl	$4, %esi
	orl	%eax, %esi
	cmpl	$7, %ecx
	ja	.LBB5_13
# %bb.4:                                #   in Loop: Header=BB5_2 Depth=1
	movl	%ecx, %ebx
	andl	$-8, %ebx
	cmpq	%rcx, %rbx
	jae	.LBB5_19
	jmp	.LBB5_17
	.p2align	5, 0x90
.LBB5_13:                               #   in Loop: Header=BB5_2 Depth=1
	leaq	(,%rcx,8), %rbx
	andq	$-64, %rbx
	movl	%esi, %r12d
	leaq	(%r9,%r12,8), %rax
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB5_14:                               #   Parent Loop BB5_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%zmm0, (%rax,%rdx)
	addq	$64, %rdx
	cmpq	%rdx, %rbx
	jne	.LBB5_14
# %bb.15:                               #   in Loop: Header=BB5_2 Depth=1
	movl	%ecx, %ebx
	andl	$-8, %ebx
	addq	%rbx, %r12
	vmovupd	%zmm0, (%r9,%r12,8)
	vmovupd	%zmm0, 64(%r9,%r12,8)
	cmpq	%rcx, %rbx
	jae	.LBB5_19
.LBB5_17:                               #   in Loop: Header=BB5_2 Depth=1
	movl	%esi, %eax
	leaq	(%r8,%rax,8), %rdx
	.p2align	4, 0x90
.LBB5_18:                               #   Parent Loop BB5_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, -128(%rdx,%rbx,8)
	movq	$0, -64(%rdx,%rbx,8)
	movq	$0, (%rdx,%rbx,8)
	incq	%rbx
	cmpq	%rbx, %rcx
	jne	.LBB5_18
	jmp	.LBB5_19
	.p2align	5, 0x90
.LBB5_5:
	vmovupd	%zmm2, 80(%rsp)                 # 64-byte Spill
	vmovupd	%zmm1, 144(%rsp)                # 64-byte Spill
	xorl	%eax, %eax
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 8(%rsp)                  # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	cmpl	$0, 20(%r15)
	jle	.LBB5_10
# %bb.6:
	vmovsd	16(%rsp), %xmm0                 # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm0
	vbroadcastsd	%xmm0, %zmm0
	xorl	%r11d, %r11d
	vbroadcastsd	.LCPI5_0(%rip), %zmm1   # zmm1 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vbroadcastsd	.LCPI5_1(%rip), %zmm2   # zmm2 = [4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1]
	vmovupd	144(%rsp), %zmm21               # 64-byte Reload
	vmovupd	80(%rsp), %zmm22                # 64-byte Reload
	jmp	.LBB5_7
	.p2align	5, 0x90
.LBB5_8:                                #   in Loop: Header=BB5_7 Depth=1
	vxorpd	%xmm4, %xmm4, %xmm4
	vxorpd	%xmm8, %xmm8, %xmm8
	vxorpd	%xmm12, %xmm12, %xmm12
	vxorpd	%xmm5, %xmm5, %xmm5
	vxorpd	%xmm9, %xmm9, %xmm9
	vxorpd	%xmm13, %xmm13, %xmm13
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm10, %xmm10, %xmm10
	vxorpd	%xmm15, %xmm15, %xmm15
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorpd	%xmm14, %xmm14, %xmm14
.LBB5_9:                                #   in Loop: Header=BB5_7 Depth=1
	movq	176(%r15), %rcx
	vshufpd	$85, %zmm15, %zmm14, %zmm3      # zmm3 = zmm14[1],zmm15[0],zmm14[3],zmm15[2],zmm14[5],zmm15[4],zmm14[7],zmm15[6]
	vshufpd	$170, %zmm15, %zmm14, %zmm14    # zmm14 = zmm14[0],zmm15[1],zmm14[2],zmm15[3],zmm14[4],zmm15[5],zmm14[6],zmm15[7]
	vaddpd	%zmm3, %zmm14, %zmm3
	vshufpd	$85, %zmm12, %zmm13, %zmm14     # zmm14 = zmm13[1],zmm12[0],zmm13[3],zmm12[2],zmm13[5],zmm12[4],zmm13[7],zmm12[6]
	vshufpd	$170, %zmm12, %zmm13, %zmm12    # zmm12 = zmm13[0],zmm12[1],zmm13[2],zmm12[3],zmm13[4],zmm12[5],zmm13[6],zmm12[7]
	vaddpd	%zmm14, %zmm12, %zmm12
	vshuff64x2	$78, %zmm12, %zmm3, %zmm13 # zmm13 = zmm3[4,5,6,7],zmm12[0,1,2,3]
	vshuff64x2	$228, %zmm12, %zmm3, %zmm3 # zmm3 = zmm3[0,1,2,3],zmm12[4,5,6,7]
	vaddpd	%zmm13, %zmm3, %zmm3
	vpermpd	$78, %zmm3, %zmm12              # zmm12 = zmm3[2,3,0,1,6,7,4,5]
	vaddpd	%zmm12, %zmm3, %zmm3
	vextractf64x4	$1, %zmm3, %ymm12
	vblendpd	$12, %ymm12, %ymm3, %ymm3       # ymm3 = ymm3[0,1],ymm12[2,3]
	vaddpd	(%rcx,%r8,8), %ymm3, %ymm3
	vmovupd	%ymm3, (%rcx,%r8,8)             # AlignMOV convert to UnAlignMOV 
	vshufpd	$85, %zmm10, %zmm11, %zmm3      # zmm3 = zmm11[1],zmm10[0],zmm11[3],zmm10[2],zmm11[5],zmm10[4],zmm11[7],zmm10[6]
	vshufpd	$170, %zmm10, %zmm11, %zmm10    # zmm10 = zmm11[0],zmm10[1],zmm11[2],zmm10[3],zmm11[4],zmm10[5],zmm11[6],zmm10[7]
	vaddpd	%zmm3, %zmm10, %zmm3
	vshufpd	$85, %zmm8, %zmm9, %zmm10       # zmm10 = zmm9[1],zmm8[0],zmm9[3],zmm8[2],zmm9[5],zmm8[4],zmm9[7],zmm8[6]
	vshufpd	$170, %zmm8, %zmm9, %zmm8       # zmm8 = zmm9[0],zmm8[1],zmm9[2],zmm8[3],zmm9[4],zmm8[5],zmm9[6],zmm8[7]
	vaddpd	%zmm10, %zmm8, %zmm8
	vshuff64x2	$78, %zmm8, %zmm3, %zmm9 # zmm9 = zmm3[4,5,6,7],zmm8[0,1,2,3]
	vshuff64x2	$228, %zmm8, %zmm3, %zmm3 # zmm3 = zmm3[0,1,2,3],zmm8[4,5,6,7]
	vaddpd	%zmm9, %zmm3, %zmm3
	vpermpd	$78, %zmm3, %zmm8               # zmm8 = zmm3[2,3,0,1,6,7,4,5]
	vaddpd	%zmm8, %zmm3, %zmm3
	vextractf64x4	$1, %zmm3, %ymm8
	vblendpd	$12, %ymm8, %ymm3, %ymm3        # ymm3 = ymm3[0,1],ymm8[2,3]
	vaddpd	64(%rcx,%r8,8), %ymm3, %ymm3
	vmovupd	%ymm3, 64(%rcx,%r8,8)           # AlignMOV convert to UnAlignMOV 
	vshufpd	$85, %zmm6, %zmm7, %zmm3        # zmm3 = zmm7[1],zmm6[0],zmm7[3],zmm6[2],zmm7[5],zmm6[4],zmm7[7],zmm6[6]
	vshufpd	$170, %zmm6, %zmm7, %zmm6       # zmm6 = zmm7[0],zmm6[1],zmm7[2],zmm6[3],zmm7[4],zmm6[5],zmm7[6],zmm6[7]
	vaddpd	%zmm3, %zmm6, %zmm3
	vshufpd	$85, %zmm4, %zmm5, %zmm6        # zmm6 = zmm5[1],zmm4[0],zmm5[3],zmm4[2],zmm5[5],zmm4[4],zmm5[7],zmm4[6]
	vshufpd	$170, %zmm4, %zmm5, %zmm4       # zmm4 = zmm5[0],zmm4[1],zmm5[2],zmm4[3],zmm5[4],zmm4[5],zmm5[6],zmm4[7]
	vaddpd	%zmm6, %zmm4, %zmm4
	vshuff64x2	$78, %zmm4, %zmm3, %zmm5 # zmm5 = zmm3[4,5,6,7],zmm4[0,1,2,3]
	vshuff64x2	$228, %zmm4, %zmm3, %zmm3 # zmm3 = zmm3[0,1,2,3],zmm4[4,5,6,7]
	vaddpd	%zmm5, %zmm3, %zmm3
	vpermpd	$78, %zmm3, %zmm4               # zmm4 = zmm3[2,3,0,1,6,7,4,5]
	vaddpd	%zmm4, %zmm3, %zmm3
	vextractf64x4	$1, %zmm3, %ymm4
	vblendpd	$12, %ymm4, %ymm3, %ymm3        # ymm3 = ymm3[0,1],ymm4[2,3]
	vaddpd	128(%rcx,%r8,8), %ymm3, %ymm3
	vmovupd	%ymm3, 128(%rcx,%r8,8)          # AlignMOV convert to UnAlignMOV 
	vmovdqu	.LCPI5_2(%rip), %xmm3           # xmm3 = <1,u>
                                        # AlignMOV convert to UnAlignMOV 
	vpinsrq	$1, %r9, %xmm3, %xmm3
	vpaddq	(%r13), %xmm3, %xmm3
	vmovdqu	%xmm3, (%r13)
	addq	%r9, 16(%r13)
	incq	%r11
	movslq	20(%r15), %rcx
	cmpq	%rcx, %r11
	jge	.LBB5_10
.LBB5_7:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_12 Depth 2
	leal	(,%r11,4), %r8d
	movl	%r8d, %ecx
	andl	$2147483640, %ecx               # imm = 0x7FFFFFF8
	leal	(%rcx,%rcx,2), %ecx
	andl	$4, %r8d
	orl	%ecx, %r8d
	movq	24(%r14), %rcx
	movslq	(%rcx,%r11,4), %r9
	testq	%r9, %r9
	jle	.LBB5_8
# %bb.11:                               #   in Loop: Header=BB5_7 Depth=1
	movq	160(%r15), %rsi
	movq	8(%r14), %rcx
	vbroadcastsd	(%rsi,%r8,8), %zmm3
	vmovups	%zmm3, 16(%rsp)                 # 64-byte Spill
	vbroadcastsd	8(%rsi,%r8,8), %zmm3
	vmovups	%zmm3, 528(%rsp)                # 64-byte Spill
	vbroadcastsd	16(%rsi,%r8,8), %zmm3
	vmovups	%zmm3, 464(%rsp)                # 64-byte Spill
	vbroadcastsd	24(%rsi,%r8,8), %zmm3
	vmovups	%zmm3, 400(%rsp)                # 64-byte Spill
	vbroadcastsd	64(%rsi,%r8,8), %zmm3
	vmovups	%zmm3, 336(%rsp)                # 64-byte Spill
	vbroadcastsd	72(%rsi,%r8,8), %zmm3
	vmovups	%zmm3, 272(%rsp)                # 64-byte Spill
	vbroadcastsd	80(%rsi,%r8,8), %zmm3
	vmovups	%zmm3, 208(%rsp)                # 64-byte Spill
	vbroadcastsd	88(%rsi,%r8,8), %zmm23
	vbroadcastsd	128(%rsi,%r8,8), %zmm24
	vbroadcastsd	136(%rsi,%r8,8), %zmm25
	vbroadcastsd	144(%rsi,%r8,8), %zmm26
	vbroadcastsd	152(%rsi,%r8,8), %zmm27
	movl	%r9d, %r9d
	movl	16(%r14), %edx
	imull	%r11d, %edx
	movslq	%edx, %rdx
	leaq	(%rcx,%rdx,4), %r10
	vxorpd	%xmm14, %xmm14, %xmm14
	xorl	%ebx, %ebx
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm15, %xmm15, %xmm15
	vxorpd	%xmm10, %xmm10, %xmm10
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm13, %xmm13, %xmm13
	vxorpd	%xmm9, %xmm9, %xmm9
	vxorpd	%xmm5, %xmm5, %xmm5
	vxorpd	%xmm12, %xmm12, %xmm12
	vxorpd	%xmm8, %xmm8, %xmm8
	vxorpd	%xmm4, %xmm4, %xmm4
	.p2align	4, 0x90
movl      $111, %ebx # OSACA START MARKER
.byte     100        # OSACA START MARKER
.byte     103        # OSACA START MARKER
.byte     144        # OSACA START MARKER
# LLVM-MCA-BEGIN
# pointer_increment=256 da67166e5736661e6b03ea29ee7bfd67
.LBB5_12:                               #   Parent Loop BB5_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%r10,%rbx,4), %rcx
	leaq	(%rcx,%rcx,2), %rdx
	shlq	$6, %rdx
	vmovupd	(%rsi,%rdx), %zmm28             # AlignMOV convert to UnAlignMOV 
	vmovupd	64(%rsi,%rdx), %zmm29           # AlignMOV convert to UnAlignMOV 
	vmovupd	128(%rsi,%rdx), %zmm30          # AlignMOV convert to UnAlignMOV 
	vmovupd	16(%rsp), %zmm3                 # 64-byte Reload
	vsubpd	%zmm28, %zmm3, %zmm3
	vsubpd	%zmm30, %zmm24, %zmm31
	vmovupd	336(%rsp), %zmm16               # 64-byte Reload
	vsubpd	%zmm29, %zmm16, %zmm16
	vmulpd	%zmm31, %zmm31, %zmm17
	vfmadd231pd	%zmm16, %zmm16, %zmm17  # zmm17 = (zmm16 * zmm16) + zmm17
	vfmadd231pd	%zmm3, %zmm3, %zmm17    # zmm17 = (zmm3 * zmm3) + zmm17
	vrcp14pd	%zmm17, %zmm18
	vmulpd	%zmm18, %zmm21, %zmm19
	vmulpd	%zmm19, %zmm18, %zmm19
	vmulpd	%zmm19, %zmm18, %zmm19
	vaddpd	%zmm1, %zmm19, %zmm20
	vmulpd	%zmm18, %zmm22, %zmm18
	vmulpd	%zmm20, %zmm18, %zmm18
	vsubpd	%zmm30, %zmm25, %zmm20
	leal	(%rcx,%rcx), %edx
	cmpq	%rdx, %r11
	setne	%dl
	sete	%al
	addl	%ecx, %ecx
	incl	%ecx
	cmpq	%rcx, %r11
	sete	%cl
	vmulpd	%zmm18, %zmm19, %zmm18
	vmovupd	528(%rsp), %zmm19               # 64-byte Reload
	vsubpd	%zmm28, %zmm19, %zmm19
	setne	%dil
	movl	%edi, %ebp
	shlb	$4, %bpl
	subb	%al, %bpl
	addb	$-17, %bpl
	kmovd	%ebp, %k1
	vcmpltpd	%zmm0, %zmm17, %k1 {%k1}
	vmovupd	272(%rsp), %zmm17               # 64-byte Reload
	vsubpd	%zmm29, %zmm17, %zmm17
	leal	(%rdx,%rdx), %eax
	movl	%edi, %ebp
	vmulpd	%zmm2, %zmm18, %zmm18
	vfmadd231pd	%zmm18, %zmm3, %zmm14 {%k1} # zmm14 {%k1} = (zmm3 * zmm18) + zmm14
	vmulpd	%zmm20, %zmm20, %zmm3
	vfmadd231pd	%zmm17, %zmm17, %zmm3   # zmm3 = (zmm17 * zmm17) + zmm3
	vfmadd231pd	%zmm19, %zmm19, %zmm3   # zmm3 = (zmm19 * zmm19) + zmm3
	vfmadd231pd	%zmm18, %zmm16, %zmm11 {%k1} # zmm11 {%k1} = (zmm16 * zmm18) + zmm11
	vrcp14pd	%zmm3, %zmm16
	vfmadd231pd	%zmm18, %zmm31, %zmm7 {%k1} # zmm7 {%k1} = (zmm31 * zmm18) + zmm7
	vmulpd	%zmm16, %zmm21, %zmm18
	vmulpd	%zmm18, %zmm16, %zmm18
	vmulpd	%zmm18, %zmm16, %zmm18
	vaddpd	%zmm1, %zmm18, %zmm31
	vmulpd	%zmm16, %zmm22, %zmm16
	vmulpd	%zmm31, %zmm16, %zmm16
	vmovupd	464(%rsp), %zmm31               # 64-byte Reload
	vsubpd	%zmm28, %zmm31, %zmm31
	shlb	$5, %bpl
	orb	%al, %bpl
	orb	$-35, %bpl
	kmovd	%ebp, %k1
	vcmpltpd	%zmm0, %zmm3, %k1 {%k1}
	vmovupd	208(%rsp), %zmm3                # 64-byte Reload
	vsubpd	%zmm29, %zmm3, %zmm3
	vmulpd	%zmm16, %zmm18, %zmm16
	vsubpd	%zmm30, %zmm26, %zmm18
	vmulpd	%zmm2, %zmm16, %zmm16
	vfmadd231pd	%zmm16, %zmm19, %zmm15 {%k1} # zmm15 {%k1} = (zmm19 * zmm16) + zmm15
	vmulpd	%zmm18, %zmm18, %zmm19
	vfmadd231pd	%zmm3, %zmm3, %zmm19    # zmm19 = (zmm3 * zmm3) + zmm19
	vfmadd231pd	%zmm31, %zmm31, %zmm19  # zmm19 = (zmm31 * zmm31) + zmm19
	vfmadd231pd	%zmm16, %zmm17, %zmm10 {%k1} # zmm10 {%k1} = (zmm17 * zmm16) + zmm10
	vrcp14pd	%zmm19, %zmm17
	vfmadd231pd	%zmm16, %zmm20, %zmm6 {%k1} # zmm6 {%k1} = (zmm20 * zmm16) + zmm6
	vmulpd	%zmm17, %zmm21, %zmm16
	vmulpd	%zmm16, %zmm17, %zmm16
	vmulpd	%zmm16, %zmm17, %zmm16
	vaddpd	%zmm1, %zmm16, %zmm20
	vmulpd	%zmm17, %zmm22, %zmm17
	vmulpd	%zmm20, %zmm17, %zmm17
	vmulpd	%zmm17, %zmm16, %zmm16
	leal	(,%rdx,4), %eax
	shlb	$6, %dil
	orb	%al, %dil
	orb	$-69, %dil
	kmovd	%edi, %k1
	vcmpltpd	%zmm0, %zmm19, %k1 {%k1}
	vmovupd	400(%rsp), %zmm17               # 64-byte Reload
	vsubpd	%zmm28, %zmm17, %zmm17
	vsubpd	%zmm29, %zmm23, %zmm19
	vsubpd	%zmm30, %zmm27, %zmm20
	vmulpd	%zmm2, %zmm16, %zmm16
	vfmadd231pd	%zmm16, %zmm31, %zmm13 {%k1} # zmm13 {%k1} = (zmm31 * zmm16) + zmm13
	vmulpd	%zmm20, %zmm20, %zmm28
	vfmadd231pd	%zmm19, %zmm19, %zmm28  # zmm28 = (zmm19 * zmm19) + zmm28
	vfmadd231pd	%zmm17, %zmm17, %zmm28  # zmm28 = (zmm17 * zmm17) + zmm28
	vfmadd231pd	%zmm16, %zmm3, %zmm9 {%k1} # zmm9 {%k1} = (zmm3 * zmm16) + zmm9
	vrcp14pd	%zmm28, %zmm3
	vfmadd231pd	%zmm16, %zmm18, %zmm5 {%k1} # zmm5 {%k1} = (zmm18 * zmm16) + zmm5
	vmulpd	%zmm3, %zmm21, %zmm16
	vmulpd	%zmm16, %zmm3, %zmm16
	vmulpd	%zmm16, %zmm3, %zmm16
	vaddpd	%zmm1, %zmm16, %zmm18
	vmulpd	%zmm3, %zmm22, %zmm3
	vmulpd	%zmm18, %zmm3, %zmm3
	vmulpd	%zmm3, %zmm16, %zmm3
	shlb	$3, %dl
	shlb	$7, %cl
	orb	%dl, %cl
	addb	$-9, %cl
	kmovd	%ecx, %k1
	vcmpltpd	%zmm0, %zmm28, %k1 {%k1}
	vmulpd	%zmm2, %zmm3, %zmm3
	vfmadd231pd	%zmm3, %zmm17, %zmm12 {%k1} # zmm12 {%k1} = (zmm17 * zmm3) + zmm12
	vfmadd231pd	%zmm3, %zmm19, %zmm8 {%k1} # zmm8 {%k1} = (zmm19 * zmm3) + zmm8
	vfmadd231pd	%zmm3, %zmm20, %zmm4 {%k1} # zmm4 {%k1} = (zmm20 * zmm3) + zmm4
	incq	%rbx
	cmpq	%rbx, %r9
	jne	.LBB5_12
# LLVM-MCA-END
movl      $222, %ebx # OSACA END MARKER
.byte     100        # OSACA END MARKER
.byte     103        # OSACA END MARKER
.byte     144        # OSACA END MARKER
	jmp	.LBB5_9
	.p2align	5, 0x90
.LBB5_10:
	movl	$.L.str.1, %edi
	vzeroupper
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, 16(%rsp)                 # 8-byte Spill
	movl	$.L.str.6, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	16(%rsp), %xmm0                 # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vsubsd	8(%rsp), %xmm0, %xmm0           # 8-byte Folded Reload
	addq	$600, %rsp                      # imm = 0x258
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end5:
	.size	computeForceLJ_4xn_full, .Lfunc_end5-computeForceLJ_4xn_full
	.cfi_endproc
                                        # -- End function
	.globl	computeForceLJ_4xn              # -- Begin function computeForceLJ_4xn
	.p2align	4, 0x90
	.type	computeForceLJ_4xn,@function
computeForceLJ_4xn:                     # 
	.cfi_startproc
# %bb.0:
	cmpl	$0, 32(%rdx)
	je	.LBB6_2
# %bb.1:
	jmp	computeForceLJ_4xn_half         # TAILCALL
	.p2align	5, 0x90
.LBB6_2:
	jmp	computeForceLJ_4xn_full         # TAILCALL
.Lfunc_end6:
	.size	computeForceLJ_4xn, .Lfunc_end6-computeForceLJ_4xn
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # 
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"computeForceLJ begin\n"
	.size	.L.str, 22
	.type	.L.str.1,@object                # 
.L.str.1:
	.asciz	"force"
	.size	.L.str.1, 6
	.type	.L.str.2,@object                # 
.L.str.2:
	.asciz	"computeForceLJ end\n"
	.size	.L.str.2, 20
	.type	.L.str.3,@object                # 
.L.str.3:
	.asciz	"computeForceLJ_2xnn begin\n"
	.size	.L.str.3, 27
	.type	.L.str.4,@object                # 
.L.str.4:
	.asciz	"computeForceLJ_2xnn end\n"
	.size	.L.str.4, 25
	.type	.L.str.5,@object                # 
.L.str.5:
	.asciz	"computeForceLJ_4xn begin\n"
	.size	.L.str.5, 26
	.type	.L.str.6,@object                # 
.L.str.6:
	.asciz	"computeForceLJ_4xn end\n"
	.size	.L.str.6, 24
	.ident	"Intel(R) oneAPI DPC++/C++ Compiler 2022.1.0 (2022.1.0.20220316)"
	.section	".note.GNU-stack","",@progbits
