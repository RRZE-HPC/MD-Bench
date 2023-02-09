	.text
	.file	"force_lj.c"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3                               # -- Begin function computeForceLJ_ref
.LCPI0_0:
	.quad	0x4048000000000000              #  48
.LCPI0_2:
	.quad	0xbfe0000000000000              #  -0.5
.LCPI0_3:
	.quad	0x3fe0000000000000              #  0.5
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2
.LCPI0_1:
	.long	0x3f800000                      #  1
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
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	movq	%rsi, %r14
	movq	%rdi, %r12
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovss	108(%r12), %xmm0                # xmm0 = mem[0],zero,zero,zero
	vmovss	%xmm0, 8(%rsp)                  # 4-byte Spill
	vmovss	40(%r12), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	vmovss	%xmm0, (%rsp)                   # 4-byte Spill
	vmovss	48(%r12), %xmm2                 # xmm2 = mem[0],zero,zero,zero
	movl	20(%r14), %r11d
	testl	%r11d, %r11d
	jle	.LBB0_5
# %bb.1:
	movq	176(%r14), %r9
	movq	192(%r14), %r10
	decq	%r11
	leaq	64(%r9), %r8
	xorl	%edi, %edi
	vxorps	%xmm0, %xmm0, %xmm0
	vxorps	%xmm1, %xmm1, %xmm1
	jmp	.LBB0_2
	.p2align	5, 0x90
.LBB0_79:                               #   in Loop: Header=BB0_2 Depth=1
	cmpq	%r11, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB0_5
.LBB0_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_74 Depth 2
                                        #     Child Loop BB0_78 Depth 2
	leaq	(%rdi,%rdi,8), %rax
	leaq	(%rax,%rax,2), %rax
	addq	%rdi, %rax
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
	leaq	(,%rsi,4), %rbp
	andq	$-32, %rbp
	movl	%ebx, %ecx
	leaq	(%r9,%rcx,4), %rdx
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB0_74:                               #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovups	%ymm0, (%rdx,%rax)
	addq	$32, %rax
	cmpq	%rax, %rbp
	jne	.LBB0_74
# %bb.75:                               #   in Loop: Header=BB0_2 Depth=1
	movl	%esi, %ebp
	andl	$-8, %ebp
	addq	%rbp, %rcx
	vmovups	%zmm1, (%r9,%rcx,4)
	cmpq	%rsi, %rbp
	jae	.LBB0_79
.LBB0_77:                               #   in Loop: Header=BB0_2 Depth=1
	movl	%ebx, %eax
	leaq	(%r8,%rax,4), %rcx
	.p2align	4, 0x90
.LBB0_78:                               #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$0, -64(%rcx,%rbp,4)
	movl	$0, -32(%rcx,%rbp,4)
	movl	$0, (%rcx,%rbp,4)
	incq	%rbp
	cmpq	%rbp, %rsi
	jne	.LBB0_78
	jmp	.LBB0_79
	.p2align	5, 0x90
.LBB0_5:
	vmovss	%xmm2, 28(%rsp)                 # 4-byte Spill
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
	vmovss	8(%rsp), %xmm0                  # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	vmulss	%xmm0, %xmm0, %xmm13
	movq	16(%rsp), %rax                  # 8-byte Reload
	leaq	32(%rax), %r15
	vmovss	(%rsp), %xmm0                   # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vmulsd	.LCPI0_0(%rip), %xmm0, %xmm12
	leaq	24(%rax), %rdx
	movq	160(%r14), %rdi
	movq	176(%r14), %rbp
	movq	32(%rsp), %rcx                  # 8-byte Reload
	movq	8(%rcx), %rbx
	movq	%rbx, 72(%rsp)                  # 8-byte Spill
	movq	24(%rcx), %rbx
	movq	%rbx, 96(%rsp)                  # 8-byte Spill
	movslq	16(%rcx), %rcx
	movq	%rcx, 64(%rsp)                  # 8-byte Spill
	vmovdqu	8(%rax), %xmm9
	leal	-1(%rsi), %ecx
	addq	(%rax), %rcx
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	movq	%rbp, 80(%rsp)                  # 8-byte Spill
	leaq	64(%rbp), %rax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	%rdi, 40(%rsp)                  # 8-byte Spill
	leaq	64(%rdi), %rax
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	xorl	%edi, %edi
	vmovss	.LCPI0_1(%rip), %xmm10          # xmm10 = mem[0],zero,zero,zero
	vmovsd	.LCPI0_2(%rip), %xmm11          # xmm11 = mem[0],zero
	vmovsd	.LCPI0_3(%rip), %xmm8           # xmm8 = mem[0],zero
	vmovss	28(%rsp), %xmm20                # 4-byte Reload
                                        # xmm20 = mem[0],zero,zero,zero
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
	movq	40(%rsp), %rsi                  # 8-byte Reload
	leaq	(%rsi,%rax,4), %r8
	movq	80(%rsp), %rsi                  # 8-byte Reload
	leaq	(%rsi,%rax,4), %r11
	movq	%rdi, 112(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	imulq	64(%rsp), %rax                  # 8-byte Folded Reload
	movq	72(%rsp), %rsi                  # 8-byte Reload
	leaq	(%rsi,%rax,4), %rax
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movq	32(%rsp), %rax                  # 8-byte Reload
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
	shlq	$5, %rax
	leaq	(%rax,%rax,2), %rdi
	movq	40(%rsp), %rax                  # 8-byte Reload
	addq	%rdi, %rax
	movq	128(%rsp), %rcx                 # 8-byte Reload
	leaq	(%rcx,%rdi), %rsi
	addq	120(%rsp), %rdi                 # 8-byte Folded Reload
	xorl	%r9d, %r9d
	xorl	%r14d, %r14d
	jmp	.LBB0_10
	.p2align	5, 0x90
.LBB0_67:                               #   in Loop: Header=BB0_10 Depth=3
	vdivss	%xmm3, %xmm10, %xmm3
	vmulss	%xmm20, %xmm3, %xmm14
	vmulss	%xmm3, %xmm3, %xmm4
	vmulss	%xmm4, %xmm14, %xmm4
	vcvtss2sd	%xmm4, %xmm4, %xmm4
	vaddsd	%xmm4, %xmm11, %xmm14
	vcvtss2sd	%xmm3, %xmm3, %xmm3
	vmulsd	%xmm3, %xmm12, %xmm3
	vmulsd	%xmm4, %xmm14, %xmm4
	vmulsd	%xmm3, %xmm4, %xmm3
	vcvtsd2ss	%xmm3, %xmm3, %xmm3
	vfmadd231ss	%xmm2, %xmm3, %xmm7     # xmm7 = (xmm3 * xmm2) + xmm7
	vfmadd231ss	%xmm1, %xmm3, %xmm5     # xmm5 = (xmm3 * xmm1) + xmm5
	vfmadd231ss	%xmm0, %xmm3, %xmm19    # xmm19 = (xmm3 * xmm0) + xmm19
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
	vaddss	(%r11,%r9,4), %xmm7, %xmm0
	vmovss	%xmm0, (%r11,%r9,4)
	vaddss	32(%r11,%r9,4), %xmm5, %xmm0
	vmovss	%xmm0, 32(%r11,%r9,4)
	vaddss	64(%r11,%r9,4), %xmm19, %xmm0
	vmovss	%xmm0, 64(%r11,%r9,4)
	incq	%r9
	cmpq	$4, %r9
	je	.LBB0_18
.LBB0_10:                               #   Parent Loop BB0_7 Depth=1
                                        #     Parent Loop BB0_9 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_12 Depth 4
	vmovss	(%r8,%r9,4), %xmm14             # xmm14 = mem[0],zero,zero,zero
	leaq	(%r9,%r12), %rbp
	vmovss	32(%r8,%r9,4), %xmm16           # xmm16 = mem[0],zero,zero,zero
	vmovss	64(%r8,%r9,4), %xmm18           # xmm18 = mem[0],zero,zero,zero
	cmpl	$0, (%rsp)                      # 4-byte Folded Reload
	je	.LBB0_21
# %bb.11:                               #   in Loop: Header=BB0_10 Depth=3
	vxorps	%xmm7, %xmm7, %xmm7
	xorl	%ebx, %ebx
	vxorps	%xmm5, %xmm5, %xmm5
	vxorps	%xmm19, %xmm19, %xmm19
	jmp	.LBB0_12
	.p2align	5, 0x90
.LBB0_70:                               #   in Loop: Header=BB0_12 Depth=4
	vdivss	%xmm3, %xmm10, %xmm3
	vmulss	%xmm20, %xmm3, %xmm4
	vmulss	%xmm3, %xmm3, %xmm6
	vmulss	%xmm4, %xmm6, %xmm4
	vcvtss2sd	%xmm4, %xmm4, %xmm4
	vaddsd	%xmm4, %xmm11, %xmm6
	vcvtss2sd	%xmm3, %xmm3, %xmm3
	vmulsd	%xmm3, %xmm12, %xmm3
	vmulsd	%xmm4, %xmm6, %xmm4
	vmulsd	%xmm3, %xmm4, %xmm3
	vcvtsd2ss	%xmm3, %xmm3, %xmm3
	vmovss	-32(%rsi,%rbx,4), %xmm4         # xmm4 = mem[0],zero,zero,zero
	vmovss	-64(%rsi,%rbx,4), %xmm6         # xmm6 = mem[0],zero,zero,zero
	vfnmadd231ss	%xmm2, %xmm3, %xmm6     # xmm6 = -(xmm3 * xmm2) + xmm6
	vmovss	%xmm6, -64(%rsi,%rbx,4)
	vfnmadd231ss	%xmm0, %xmm3, %xmm4     # xmm4 = -(xmm3 * xmm0) + xmm4
	vmovss	%xmm4, -32(%rsi,%rbx,4)
	vmovss	(%rsi,%rbx,4), %xmm4            # xmm4 = mem[0],zero,zero,zero
	vfnmadd231ss	%xmm1, %xmm3, %xmm4     # xmm4 = -(xmm3 * xmm1) + xmm4
	vmovss	%xmm4, (%rsi,%rbx,4)
	vfmadd231ss	%xmm2, %xmm3, %xmm7     # xmm7 = (xmm3 * xmm2) + xmm7
	vfmadd231ss	%xmm0, %xmm3, %xmm5     # xmm5 = (xmm3 * xmm0) + xmm5
	vfmadd231ss	%xmm1, %xmm3, %xmm19    # xmm19 = (xmm3 * xmm1) + xmm19
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
	vsubss	-64(%rdi,%rbx,4), %xmm14, %xmm2
	vsubss	-32(%rdi,%rbx,4), %xmm16, %xmm0
	vsubss	(%rdi,%rbx,4), %xmm18, %xmm1
	vmulss	%xmm2, %xmm2, %xmm3
	vfmadd231ss	%xmm0, %xmm0, %xmm3     # xmm3 = (xmm0 * xmm0) + xmm3
	vfmadd231ss	%xmm1, %xmm1, %xmm3     # xmm3 = (xmm1 * xmm1) + xmm3
	vucomiss	%xmm13, %xmm3
	jb	.LBB0_70
# %bb.15:                               #   in Loop: Header=BB0_12 Depth=4
	movq	%r15, %rcx
	jmp	.LBB0_71
	.p2align	5, 0x90
.LBB0_21:                               #   in Loop: Header=BB0_10 Depth=3
	cmpl	%r10d, %r13d
	jne	.LBB0_24
# %bb.22:                               #   in Loop: Header=BB0_10 Depth=3
	vxorps	%xmm19, %xmm19, %xmm19
	testq	%rbp, %rbp
	jne	.LBB0_24
# %bb.23:                               #   in Loop: Header=BB0_10 Depth=3
	vxorps	%xmm5, %xmm5, %xmm5
	vxorps	%xmm7, %xmm7, %xmm7
	cmpl	%r10d, %r13d
	je	.LBB0_28
	jmp	.LBB0_29
	.p2align	5, 0x90
.LBB0_24:                               #   in Loop: Header=BB0_10 Depth=3
	vsubss	(%rax), %xmm14, %xmm15
	vsubss	32(%rax), %xmm16, %xmm1
	vsubss	64(%rax), %xmm18, %xmm2
	vmulss	%xmm15, %xmm15, %xmm0
	vfmadd231ss	%xmm1, %xmm1, %xmm0     # xmm0 = (xmm1 * xmm1) + xmm0
	vfmadd231ss	%xmm2, %xmm2, %xmm0     # xmm0 = (xmm2 * xmm2) + xmm0
	vxorps	%xmm19, %xmm19, %xmm19
	vucomiss	%xmm13, %xmm0
	movq	%r15, %rbx
	vxorps	%xmm5, %xmm5, %xmm5
	vxorps	%xmm7, %xmm7, %xmm7
	jae	.LBB0_26
# %bb.25:                               #   in Loop: Header=BB0_10 Depth=3
	vdivss	%xmm0, %xmm10, %xmm0
	vmulss	%xmm20, %xmm0, %xmm3
	vmulss	%xmm0, %xmm0, %xmm5
	vmulss	%xmm3, %xmm5, %xmm3
	vcvtss2sd	%xmm3, %xmm3, %xmm3
	vaddsd	%xmm3, %xmm11, %xmm5
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vmulsd	%xmm0, %xmm12, %xmm0
	vmulsd	%xmm3, %xmm5, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmulss	%xmm0, %xmm15, %xmm7
	vmulss	%xmm0, %xmm1, %xmm5
	vmulss	%xmm0, %xmm2, %xmm19
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
	vsubss	4(%rax), %xmm14, %xmm2
	vsubss	36(%rax), %xmm16, %xmm1
	vsubss	68(%rax), %xmm18, %xmm15
	vmulss	%xmm2, %xmm2, %xmm0
	vfmadd231ss	%xmm1, %xmm1, %xmm0     # xmm0 = (xmm1 * xmm1) + xmm0
	vfmadd231ss	%xmm15, %xmm15, %xmm0   # xmm0 = (xmm15 * xmm15) + xmm0
	vucomiss	%xmm13, %xmm0
	jae	.LBB0_30
# %bb.31:                               #   in Loop: Header=BB0_10 Depth=3
	vdivss	%xmm0, %xmm10, %xmm0
	vmulss	%xmm20, %xmm0, %xmm17
	vmulss	%xmm0, %xmm0, %xmm3
	vmulss	%xmm17, %xmm3, %xmm3
	vcvtss2sd	%xmm3, %xmm3, %xmm3
	vaddsd	%xmm11, %xmm3, %xmm17
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vmulsd	%xmm0, %xmm12, %xmm0
	vmulsd	%xmm3, %xmm17, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vfmadd231ss	%xmm2, %xmm0, %xmm7     # xmm7 = (xmm0 * xmm2) + xmm7
	vfmadd231ss	%xmm1, %xmm0, %xmm5     # xmm5 = (xmm0 * xmm1) + xmm5
	vfmadd231ss	%xmm15, %xmm0, %xmm19   # xmm19 = (xmm0 * xmm15) + xmm19
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
	vsubss	8(%rax), %xmm14, %xmm2
	vsubss	40(%rax), %xmm16, %xmm1
	vsubss	72(%rax), %xmm18, %xmm15
	vmulss	%xmm2, %xmm2, %xmm0
	vfmadd231ss	%xmm1, %xmm1, %xmm0     # xmm0 = (xmm1 * xmm1) + xmm0
	vfmadd231ss	%xmm15, %xmm15, %xmm0   # xmm0 = (xmm15 * xmm15) + xmm0
	vucomiss	%xmm13, %xmm0
	jae	.LBB0_36
# %bb.37:                               #   in Loop: Header=BB0_10 Depth=3
	vdivss	%xmm0, %xmm10, %xmm0
	vmulss	%xmm20, %xmm0, %xmm17
	vmulss	%xmm0, %xmm0, %xmm3
	vmulss	%xmm17, %xmm3, %xmm3
	vcvtss2sd	%xmm3, %xmm3, %xmm3
	vaddsd	%xmm11, %xmm3, %xmm17
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vmulsd	%xmm0, %xmm12, %xmm0
	vmulsd	%xmm3, %xmm17, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vfmadd231ss	%xmm2, %xmm0, %xmm7     # xmm7 = (xmm0 * xmm2) + xmm7
	vfmadd231ss	%xmm1, %xmm0, %xmm5     # xmm5 = (xmm0 * xmm1) + xmm5
	vfmadd231ss	%xmm15, %xmm0, %xmm19   # xmm19 = (xmm0 * xmm15) + xmm19
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
	vsubss	12(%rax), %xmm14, %xmm2
	vsubss	44(%rax), %xmm16, %xmm1
	vsubss	76(%rax), %xmm18, %xmm15
	vmulss	%xmm2, %xmm2, %xmm0
	vfmadd231ss	%xmm1, %xmm1, %xmm0     # xmm0 = (xmm1 * xmm1) + xmm0
	vfmadd231ss	%xmm15, %xmm15, %xmm0   # xmm0 = (xmm15 * xmm15) + xmm0
	vucomiss	%xmm13, %xmm0
	jae	.LBB0_42
# %bb.43:                               #   in Loop: Header=BB0_10 Depth=3
	vdivss	%xmm0, %xmm10, %xmm0
	vmulss	%xmm20, %xmm0, %xmm17
	vmulss	%xmm0, %xmm0, %xmm3
	vmulss	%xmm17, %xmm3, %xmm3
	vcvtss2sd	%xmm3, %xmm3, %xmm3
	vaddsd	%xmm11, %xmm3, %xmm17
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vmulsd	%xmm0, %xmm12, %xmm0
	vmulsd	%xmm3, %xmm17, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vfmadd231ss	%xmm2, %xmm0, %xmm7     # xmm7 = (xmm0 * xmm2) + xmm7
	vfmadd231ss	%xmm1, %xmm0, %xmm5     # xmm5 = (xmm0 * xmm1) + xmm5
	vfmadd231ss	%xmm15, %xmm0, %xmm19   # xmm19 = (xmm0 * xmm15) + xmm19
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
	vsubss	16(%rax), %xmm14, %xmm2
	vsubss	48(%rax), %xmm16, %xmm1
	vsubss	80(%rax), %xmm18, %xmm15
	vmulss	%xmm2, %xmm2, %xmm0
	vfmadd231ss	%xmm1, %xmm1, %xmm0     # xmm0 = (xmm1 * xmm1) + xmm0
	vfmadd231ss	%xmm15, %xmm15, %xmm0   # xmm0 = (xmm15 * xmm15) + xmm0
	vucomiss	%xmm13, %xmm0
	jae	.LBB0_48
# %bb.49:                               #   in Loop: Header=BB0_10 Depth=3
	vdivss	%xmm0, %xmm10, %xmm0
	vmulss	%xmm20, %xmm0, %xmm17
	vmulss	%xmm0, %xmm0, %xmm3
	vmulss	%xmm17, %xmm3, %xmm3
	vcvtss2sd	%xmm3, %xmm3, %xmm3
	vaddsd	%xmm11, %xmm3, %xmm17
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vmulsd	%xmm0, %xmm12, %xmm0
	vmulsd	%xmm3, %xmm17, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vfmadd231ss	%xmm2, %xmm0, %xmm7     # xmm7 = (xmm0 * xmm2) + xmm7
	vfmadd231ss	%xmm1, %xmm0, %xmm5     # xmm5 = (xmm0 * xmm1) + xmm5
	vfmadd231ss	%xmm15, %xmm0, %xmm19   # xmm19 = (xmm0 * xmm15) + xmm19
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
	vsubss	20(%rax), %xmm14, %xmm2
	vsubss	52(%rax), %xmm16, %xmm1
	vsubss	84(%rax), %xmm18, %xmm15
	vmulss	%xmm2, %xmm2, %xmm0
	vfmadd231ss	%xmm1, %xmm1, %xmm0     # xmm0 = (xmm1 * xmm1) + xmm0
	vfmadd231ss	%xmm15, %xmm15, %xmm0   # xmm0 = (xmm15 * xmm15) + xmm0
	vucomiss	%xmm13, %xmm0
	jae	.LBB0_54
# %bb.55:                               #   in Loop: Header=BB0_10 Depth=3
	vdivss	%xmm0, %xmm10, %xmm0
	vmulss	%xmm20, %xmm0, %xmm17
	vmulss	%xmm0, %xmm0, %xmm3
	vmulss	%xmm17, %xmm3, %xmm3
	vcvtss2sd	%xmm3, %xmm3, %xmm3
	vaddsd	%xmm11, %xmm3, %xmm17
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vmulsd	%xmm0, %xmm12, %xmm0
	vmulsd	%xmm3, %xmm17, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vfmadd231ss	%xmm2, %xmm0, %xmm7     # xmm7 = (xmm0 * xmm2) + xmm7
	vfmadd231ss	%xmm1, %xmm0, %xmm5     # xmm5 = (xmm0 * xmm1) + xmm5
	vfmadd231ss	%xmm15, %xmm0, %xmm19   # xmm19 = (xmm0 * xmm15) + xmm19
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
	vsubss	24(%rax), %xmm14, %xmm2
	vsubss	56(%rax), %xmm16, %xmm1
	vsubss	88(%rax), %xmm18, %xmm15
	vmulss	%xmm2, %xmm2, %xmm0
	vfmadd231ss	%xmm1, %xmm1, %xmm0     # xmm0 = (xmm1 * xmm1) + xmm0
	vfmadd231ss	%xmm15, %xmm15, %xmm0   # xmm0 = (xmm15 * xmm15) + xmm0
	vucomiss	%xmm13, %xmm0
	jae	.LBB0_60
# %bb.61:                               #   in Loop: Header=BB0_10 Depth=3
	vdivss	%xmm0, %xmm10, %xmm0
	vmulss	%xmm20, %xmm0, %xmm17
	vmulss	%xmm0, %xmm0, %xmm3
	vmulss	%xmm17, %xmm3, %xmm3
	vcvtss2sd	%xmm3, %xmm3, %xmm3
	vaddsd	%xmm11, %xmm3, %xmm17
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vmulsd	%xmm0, %xmm12, %xmm0
	vmulsd	%xmm3, %xmm17, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vfmadd231ss	%xmm2, %xmm0, %xmm7     # xmm7 = (xmm0 * xmm2) + xmm7
	vfmadd231ss	%xmm1, %xmm0, %xmm5     # xmm5 = (xmm0 * xmm1) + xmm5
	vfmadd231ss	%xmm15, %xmm0, %xmm19   # xmm19 = (xmm0 * xmm15) + xmm19
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
	vsubss	28(%rax), %xmm14, %xmm2
	vsubss	60(%rax), %xmm16, %xmm1
	vsubss	92(%rax), %xmm18, %xmm0
	vmulss	%xmm2, %xmm2, %xmm3
	vfmadd231ss	%xmm1, %xmm1, %xmm3     # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231ss	%xmm0, %xmm0, %xmm3     # xmm3 = (xmm0 * xmm0) + xmm3
	vucomiss	%xmm13, %xmm3
	jb	.LBB0_67
# %bb.66:                               #   in Loop: Header=BB0_10 Depth=3
	movq	%r15, %rbx
	jmp	.LBB0_68
	.p2align	5, 0x90
.LBB0_16:
	movq	48(%rsp), %rcx                  # 8-byte Reload
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
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2                               # -- Begin function computeForceLJ_2xnn_half
.LCPI1_0:
	.long	0xbf000000                      #  -0.5
.LCPI1_1:
	.long	0x42400000                      #  48
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI1_2:
	.quad	1                               # 0x1
	.zero	8
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI1_3:
	.quad	0x3fe0000000000000              #  0.5
.LCPI1_4:
	.quad	0x41cdcd6500000000              #  1.0E+9
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
	subq	$232, %rsp
	.cfi_def_cfa_offset 288
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, %r12
	movq	%rsi, %r15
	movq	%rdi, %rbp
	xorl	%ebx, %ebx
	movl	$.L.str.3, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovss	108(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	vmovss	%xmm0, (%rsp)                   # 4-byte Spill
	vbroadcastss	48(%rbp), %zmm2
	movq	%rbp, 32(%rsp)                  # 8-byte Spill
	vpbroadcastd	40(%rbp), %zmm3
	movl	20(%r15), %r11d
	testl	%r11d, %r11d
	jle	.LBB1_5
# %bb.1:
	movq	176(%r15), %r9
	movq	192(%r15), %r10
	decq	%r11
	leaq	64(%r9), %r8
	xorl	%edi, %edi
	vxorps	%xmm0, %xmm0, %xmm0
	vxorps	%xmm1, %xmm1, %xmm1
	jmp	.LBB1_2
	.p2align	5, 0x90
.LBB1_21:                               #   in Loop: Header=BB1_2 Depth=1
	cmpq	%r11, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB1_5
.LBB1_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_16 Depth 2
                                        #     Child Loop BB1_20 Depth 2
	leaq	(%rdi,%rdi,8), %rax
	leaq	(%rax,%rax,2), %rax
	addq	%rdi, %rax
	movl	(%r10,%rax), %ecx
	testl	%ecx, %ecx
	jle	.LBB1_21
# %bb.3:                                #   in Loop: Header=BB1_2 Depth=1
	leal	(,%rdi,4), %esi
	movl	%esi, %eax
	andl	$2147483640, %eax               # imm = 0x7FFFFFF8
	leal	(%rax,%rax,2), %eax
	andl	$4, %esi
	orl	%eax, %esi
	cmpl	$7, %ecx
	ja	.LBB1_15
# %bb.4:                                #   in Loop: Header=BB1_2 Depth=1
	movl	%ecx, %ebp
	andl	$-8, %ebp
	cmpq	%rcx, %rbp
	jae	.LBB1_21
	jmp	.LBB1_19
	.p2align	5, 0x90
.LBB1_15:                               #   in Loop: Header=BB1_2 Depth=1
	leaq	(,%rcx,4), %rbp
	andq	$-32, %rbp
	movl	%esi, %r14d
	leaq	(%r9,%r14,4), %rax
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB1_16:                               #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovups	%ymm0, (%rax,%rdx)
	addq	$32, %rdx
	cmpq	%rdx, %rbp
	jne	.LBB1_16
# %bb.17:                               #   in Loop: Header=BB1_2 Depth=1
	movl	%ecx, %ebp
	andl	$-8, %ebp
	addq	%rbp, %r14
	vmovups	%zmm1, (%r9,%r14,4)
	cmpq	%rcx, %rbp
	jae	.LBB1_21
.LBB1_19:                               #   in Loop: Header=BB1_2 Depth=1
	movl	%esi, %eax
	leaq	(%r8,%rax,4), %rdx
	.p2align	4, 0x90
.LBB1_20:                               #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$0, -64(%rdx,%rbp,4)
	movl	$0, -32(%rdx,%rbp,4)
	movl	$0, (%rdx,%rbp,4)
	incq	%rbp
	cmpq	%rbp, %rcx
	jne	.LBB1_20
	jmp	.LBB1_21
	.p2align	5, 0x90
.LBB1_5:
	xorl	%eax, %eax
	vmovups	%zmm2, 160(%rsp)                # 64-byte Spill
	vmovdqu64	%zmm3, 96(%rsp)         # 64-byte Spill
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 24(%rsp)                 # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	vmovups	96(%rsp), %zmm31                # 64-byte Reload
	vmovups	160(%rsp), %zmm30               # 64-byte Reload
	cmpl	$0, 20(%r15)
	jle	.LBB1_10
# %bb.6:
	vmovss	(%rsp), %xmm0                   # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	vmulss	%xmm0, %xmm0, %xmm0
	vbroadcastss	%xmm0, %zmm0
	xorl	%r11d, %r11d
	vbroadcastss	.LCPI1_0(%rip), %zmm1   # zmm1 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vbroadcastss	.LCPI1_1(%rip), %zmm2   # zmm2 = [4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1]
	movw	$4369, %cx                      # imm = 0x1111
	kmovw	%ecx, %k1
	vmovdqu	.LCPI1_2(%rip), %xmm3           # xmm3 = <1,u>
                                        # AlignMOV convert to UnAlignMOV 
	vmovsd	.LCPI1_3(%rip), %xmm4           # xmm4 = mem[0],zero
	xorl	%ebx, %ebx
	movq	%r12, 40(%rsp)                  # 8-byte Spill
	movq	%r15, 16(%rsp)                  # 8-byte Spill
	jmp	.LBB1_7
	.p2align	5, 0x90
.LBB1_13:                               #   in Loop: Header=BB1_7 Depth=1
	movl	12(%rsp), %ebx                  # 4-byte Reload
	movq	40(%rsp), %r12                  # 8-byte Reload
	movq	16(%rsp), %r15                  # 8-byte Reload
	movq	80(%rsp), %rax                  # 8-byte Reload
	movq	72(%rsp), %rsi                  # 8-byte Reload
	movq	64(%rsp), %r10                  # 8-byte Reload
	movq	56(%rsp), %rcx                  # 8-byte Reload
.LBB1_9:                                #   in Loop: Header=BB1_7 Depth=1
	vshuff64x2	$136, %zmm14, %zmm12, %zmm7 # zmm7 = zmm12[0,1,4,5],zmm14[0,1,4,5]
	vshuff64x2	$221, %zmm14, %zmm12, %zmm10 # zmm10 = zmm12[2,3,6,7],zmm14[2,3,6,7]
	vaddps	%zmm10, %zmm7, %zmm7
	vpermilpd	$85, %zmm7, %zmm10      # zmm10 = zmm7[1,0,3,2,5,4,7,6]
	vaddps	%zmm10, %zmm7, %zmm7
	vpermilps	$177, %zmm7, %zmm10     # zmm10 = zmm7[1,0,3,2,5,4,7,6,9,8,11,10,13,12,15,14]
	vaddps	%zmm10, %zmm7, %zmm7
	vcompressps	%zmm7, %zmm7 {%k1} {z}
	vaddps	(%r10,%rax,4), %xmm7, %xmm7
	vmovups	%xmm7, (%r10,%rax,4)            # AlignMOV convert to UnAlignMOV 
	vshuff64x2	$136, %zmm9, %zmm8, %zmm7 # zmm7 = zmm8[0,1,4,5],zmm9[0,1,4,5]
	vshuff64x2	$221, %zmm9, %zmm8, %zmm8 # zmm8 = zmm8[2,3,6,7],zmm9[2,3,6,7]
	vaddps	%zmm8, %zmm7, %zmm7
	vpermilpd	$85, %zmm7, %zmm8       # zmm8 = zmm7[1,0,3,2,5,4,7,6]
	vaddps	%zmm8, %zmm7, %zmm7
	vpermilps	$177, %zmm7, %zmm8      # zmm8 = zmm7[1,0,3,2,5,4,7,6,9,8,11,10,13,12,15,14]
	vaddps	%zmm8, %zmm7, %zmm7
	vcompressps	%zmm7, %zmm7 {%k1} {z}
	vaddps	32(%r10,%rax,4), %xmm7, %xmm7
	vmovups	%xmm7, 32(%r10,%rax,4)          # AlignMOV convert to UnAlignMOV 
	vshuff64x2	$136, %zmm5, %zmm6, %zmm7 # zmm7 = zmm6[0,1,4,5],zmm5[0,1,4,5]
	vshuff64x2	$221, %zmm5, %zmm6, %zmm5 # zmm5 = zmm6[2,3,6,7],zmm5[2,3,6,7]
	vaddps	%zmm5, %zmm7, %zmm5
	vpermilpd	$85, %zmm5, %zmm6       # zmm6 = zmm5[1,0,3,2,5,4,7,6]
	vaddps	%zmm6, %zmm5, %zmm5
	vpermilps	$177, %zmm5, %zmm6      # zmm6 = zmm5[1,0,3,2,5,4,7,6,9,8,11,10,13,12,15,14]
	vaddps	%zmm6, %zmm5, %zmm5
	vcompressps	%zmm5, %zmm5 {%k1} {z}
	vaddps	64(%r10,%rax,4), %xmm5, %xmm5
	vmovups	%xmm5, 64(%r10,%rax,4)          # AlignMOV convert to UnAlignMOV 
	vpinsrq	$1, %rcx, %xmm3, %xmm5
	movq	48(%rsp), %rdx                  # 8-byte Reload
	vpaddq	(%rdx), %xmm5, %xmm5
	vmovdqu	%xmm5, (%rdx)
	addl	%esi, %ebx
	vcvtsi2sd	%esi, %xmm11, %xmm5
	vmulsd	%xmm4, %xmm5, %xmm5
	vcvttsd2si	%xmm5, %rcx
	addq	%rcx, 16(%rdx)
	incq	%r11
	movslq	20(%r15), %rcx
	cmpq	%rcx, %r11
	jge	.LBB1_10
.LBB1_7:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_12 Depth 2
	leal	(,%r11,4), %eax
	movl	%eax, %ecx
	andl	$2147483640, %ecx               # imm = 0x7FFFFFF8
	leal	(%rcx,%rcx,2), %ecx
	andl	$4, %eax
	orl	%ecx, %eax
	movq	176(%r15), %r10
	movq	24(%r12), %rcx
	movslq	(%rcx,%r11,4), %rsi
	testq	%rsi, %rsi
	jle	.LBB1_8
# %bb.11:                               #   in Loop: Header=BB1_7 Depth=1
	movl	%ebx, 12(%rsp)                  # 4-byte Spill
	movq	160(%r15), %r15
	vbroadcastss	(%r15,%rax,4), %ymm5
	movq	8(%r12), %rcx
	vbroadcastss	4(%r15,%rax,4), %ymm6
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm7
	vbroadcastss	8(%r15,%rax,4), %ymm5
	vbroadcastss	12(%r15,%rax,4), %ymm6
	vbroadcastss	32(%r15,%rax,4), %ymm8
	vbroadcastss	36(%r15,%rax,4), %ymm9
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm10
	vinsertf64x4	$1, %ymm9, %zmm8, %zmm11
	vbroadcastss	40(%r15,%rax,4), %ymm5
	vbroadcastss	44(%r15,%rax,4), %ymm6
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm13
	vbroadcastss	64(%r15,%rax,4), %ymm5
	vbroadcastss	68(%r15,%rax,4), %ymm6
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm15
	vbroadcastss	72(%r15,%rax,4), %ymm5
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	vbroadcastss	76(%r15,%rax,4), %ymm6
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm16
	movq	%rsi, 72(%rsp)                  # 8-byte Spill
	movl	%esi, %eax
	movl	16(%r12), %edx
	imull	%r11d, %edx
	movslq	%edx, %rdx
	leaq	(%rcx,%rdx,4), %rcx
	movq	%rcx, (%rsp)                    # 8-byte Spill
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	decq	%rax
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	vxorps	%xmm12, %xmm12, %xmm12
	movq	%r10, 64(%rsp)                  # 8-byte Spill
	xorl	%ecx, %ecx
	vxorps	%xmm8, %xmm8, %xmm8
	vxorps	%xmm6, %xmm6, %xmm6
	vxorps	%xmm14, %xmm14, %xmm14
	vxorps	%xmm9, %xmm9, %xmm9
	vxorps	%xmm5, %xmm5, %xmm5
	.p2align	4, 0x90
.LBB1_12:                               #   Parent Loop BB1_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	(%rsp), %rax                    # 8-byte Reload
	movslq	(%rax,%rcx,4), %rdx
	leal	(%rdx,%rdx), %esi
	xorl	%ebx, %ebx
	cmpq	%rsi, %r11
	leal	1(%rdx,%rdx), %edi
	setne	%bl
	leal	(%rbx,%rbx,2), %ebx
	movl	$255, %ebp
	movl	$248, %eax
	cmovel	%eax, %ebp
	orl	$252, %ebx
	leal	-127(%rbp), %r8d
	cmpq	%rdi, %r11
	cmovnel	%ebp, %r8d
	leal	193(%rbx), %r14d
	xorl	%r13d, %r13d
	cmpq	%rdi, %r11
	cmovnel	%ebx, %r14d
	sete	%r13b
	movl	$0, %r9d
	movl	$-31, %eax
	cmovel	%eax, %r9d
	leal	240(%r13), %edi
	addl	$255, %r13d
	xorl	%ebx, %ebx
	cmpq	%rsi, %r11
	cmovel	%edi, %r13d
	sete	%bl
	shlq	$5, %rdx
	leaq	(%rdx,%rdx,2), %r12
	vmovupd	(%r15,%r12), %zmm17
	vbroadcastf64x4	(%r15,%r12), %zmm18     # zmm18 = mem[0,1,2,3,0,1,2,3]
	vbroadcastf64x4	64(%r15,%r12), %zmm19   # zmm19 = mem[0,1,2,3,0,1,2,3]
	subl	%ebx, %r9d
	addl	$255, %r9d
	shll	$8, %r14d
	orl	%r9d, %r14d
	kmovd	%r14d, %k2
	shll	$8, %r13d
	orl	%r8d, %r13d
	kmovd	%r13d, %k3
	vshuff64x2	$238, %zmm17, %zmm17, %zmm17 # zmm17 = zmm17[4,5,6,7,4,5,6,7]
	vsubps	%zmm18, %zmm7, %zmm20
	vsubps	%zmm17, %zmm11, %zmm21
	vsubps	%zmm19, %zmm15, %zmm22
	vsubps	%zmm18, %zmm10, %zmm18
	vsubps	%zmm17, %zmm13, %zmm17
	vsubps	%zmm19, %zmm16, %zmm19
	vmulps	%zmm22, %zmm22, %zmm23
	vfmadd231ps	%zmm21, %zmm21, %zmm23  # zmm23 = (zmm21 * zmm21) + zmm23
	vfmadd231ps	%zmm20, %zmm20, %zmm23  # zmm23 = (zmm20 * zmm20) + zmm23
	vmulps	%zmm19, %zmm19, %zmm24
	vrcp14ps	%zmm23, %zmm25
	vfmadd231ps	%zmm17, %zmm17, %zmm24  # zmm24 = (zmm17 * zmm17) + zmm24
	vfmadd231ps	%zmm18, %zmm18, %zmm24  # zmm24 = (zmm18 * zmm18) + zmm24
	vrcp14ps	%zmm24, %zmm26
	vmulps	%zmm25, %zmm30, %zmm27
	vmulps	%zmm27, %zmm25, %zmm27
	vmulps	%zmm27, %zmm25, %zmm27
	vmulps	%zmm26, %zmm30, %zmm28
	vmulps	%zmm28, %zmm26, %zmm28
	vmulps	%zmm28, %zmm26, %zmm28
	vaddps	%zmm1, %zmm27, %zmm29
	vmulps	%zmm25, %zmm31, %zmm25
	vmulps	%zmm29, %zmm25, %zmm25
	vmulps	%zmm25, %zmm27, %zmm25
	vmulps	%zmm2, %zmm25, %zmm25
	vaddps	%zmm1, %zmm28, %zmm27
	vmulps	%zmm26, %zmm31, %zmm26
	vmulps	%zmm27, %zmm26, %zmm26
	vmulps	%zmm26, %zmm28, %zmm26
	vmulps	%zmm2, %zmm26, %zmm26
	vcmpltps	%zmm0, %zmm23, %k2 {%k2}
	vmulps	%zmm25, %zmm20, %zmm20 {%k2} {z}
	vmulps	%zmm25, %zmm21, %zmm21 {%k2} {z}
	vmulps	%zmm25, %zmm22, %zmm22 {%k2} {z}
	vcmpltps	%zmm0, %zmm24, %k2 {%k3}
	vmulps	%zmm26, %zmm18, %zmm18 {%k2} {z}
	vmulps	%zmm26, %zmm17, %zmm17 {%k2} {z}
	vmulps	%zmm26, %zmm19, %zmm19 {%k2} {z}
	vaddps	%zmm18, %zmm20, %zmm23
	vaddps	%zmm17, %zmm21, %zmm24
	vextractf64x4	$1, %zmm23, %ymm25
	vaddps	%ymm25, %ymm23, %ymm23
	vmovups	(%r10,%r12), %ymm25             # AlignMOV convert to UnAlignMOV 
	vsubps	%ymm23, %ymm25, %ymm23
	vmovups	32(%r10,%r12), %ymm25           # AlignMOV convert to UnAlignMOV 
	vmovups	64(%r10,%r12), %ymm26           # AlignMOV convert to UnAlignMOV 
	vmovups	%ymm23, (%r10,%r12)             # AlignMOV convert to UnAlignMOV 
	vaddps	%zmm19, %zmm22, %zmm23
	vextractf64x4	$1, %zmm24, %ymm27
	vaddps	%ymm27, %ymm24, %ymm24
	vsubps	%ymm24, %ymm25, %ymm24
	vmovups	%ymm24, 32(%r10,%r12)           # AlignMOV convert to UnAlignMOV 
	vextractf64x4	$1, %zmm23, %ymm24
	vaddps	%ymm24, %ymm23, %ymm23
	vsubps	%ymm23, %ymm26, %ymm23
	vmovups	%ymm23, 64(%r10,%r12)           # AlignMOV convert to UnAlignMOV 
	vaddps	%zmm20, %zmm12, %zmm12
	vaddps	%zmm21, %zmm8, %zmm8
	vaddps	%zmm22, %zmm6, %zmm6
	vaddps	%zmm18, %zmm14, %zmm14
	vaddps	%zmm17, %zmm9, %zmm9
	vaddps	%zmm19, %zmm5, %zmm5
	cmpq	%rcx, 88(%rsp)                  # 8-byte Folded Reload
	je	.LBB1_13
# %bb.14:                               #   in Loop: Header=BB1_12 Depth=2
	movq	16(%rsp), %rdx                  # 8-byte Reload
	movq	160(%rdx), %r15
	movq	176(%rdx), %r10
	incq	%rcx
	jmp	.LBB1_12
	.p2align	5, 0x90
.LBB1_8:                                #   in Loop: Header=BB1_7 Depth=1
	vxorps	%xmm5, %xmm5, %xmm5
	movq	%rsi, %rcx
	vxorps	%xmm9, %xmm9, %xmm9
	vxorps	%xmm14, %xmm14, %xmm14
	vxorps	%xmm6, %xmm6, %xmm6
	vxorps	%xmm8, %xmm8, %xmm8
	vxorps	%xmm12, %xmm12, %xmm12
	jmp	.LBB1_9
	.p2align	5, 0x90
.LBB1_10:
	movl	$.L.str.1, %edi
	vzeroupper
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	movq	32(%rsp), %rax                  # 8-byte Reload
	vmovsd	184(%rax), %xmm3                # xmm3 = mem[0],zero
	vsubsd	24(%rsp), %xmm0, %xmm1          # 8-byte Folded Reload
	vmovsd	%xmm1, (%rsp)                   # 8-byte Spill
	vmulsd	.LCPI1_4(%rip), %xmm3, %xmm0
	vmulsd	%xmm1, %xmm0, %xmm0
	vcvtusi2sd	%ebx, %xmm11, %xmm2
	vdivsd	%xmm2, %xmm0, %xmm2
	movl	$.L.str.4, %edi
	movl	%ebx, %esi
	vmovapd	%xmm3, %xmm0
	movb	$3, %al
	callq	printf
	movl	$.L.str.5, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	(%rsp), %xmm0                   # 8-byte Reload
                                        # xmm0 = mem[0],zero
	addq	$232, %rsp
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
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2                               # -- Begin function computeForceLJ_2xnn_full
.LCPI2_0:
	.long	0xbf000000                      #  -0.5
.LCPI2_1:
	.long	0x42400000                      #  48
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI2_2:
	.quad	1                               # 0x1
	.zero	8
	.text
	.globl	computeForceLJ_2xnn_full
	.p2align	4, 0x90
	.type	computeForceLJ_2xnn_full,@function
computeForceLJ_2xnn_full:               # 
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
	subq	$168, %rsp
	.cfi_def_cfa_offset 224
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rcx, %r13
	movq	%rdx, %r14
	movq	%rsi, %rbp
	movq	%rdi, %r12
	movl	$.L.str.3, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovss	108(%r12), %xmm0                # xmm0 = mem[0],zero,zero,zero
	vmovss	%xmm0, 20(%rsp)                 # 4-byte Spill
	vbroadcastss	48(%r12), %zmm2
	vpbroadcastd	40(%r12), %zmm3
	movl	20(%rbp), %r11d
	testl	%r11d, %r11d
	jle	.LBB2_5
# %bb.1:
	movq	176(%rbp), %r9
	movq	192(%rbp), %r10
	decq	%r11
	leaq	64(%r9), %r8
	xorl	%edi, %edi
	vxorps	%xmm0, %xmm0, %xmm0
	vxorps	%xmm1, %xmm1, %xmm1
	jmp	.LBB2_2
	.p2align	5, 0x90
.LBB2_20:                               #   in Loop: Header=BB2_2 Depth=1
	cmpq	%r11, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB2_5
.LBB2_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_15 Depth 2
                                        #     Child Loop BB2_19 Depth 2
	leaq	(%rdi,%rdi,8), %rax
	leaq	(%rax,%rax,2), %rax
	addq	%rdi, %rax
	movl	(%r10,%rax), %ecx
	testl	%ecx, %ecx
	jle	.LBB2_20
# %bb.3:                                #   in Loop: Header=BB2_2 Depth=1
	leal	(,%rdi,4), %esi
	movl	%esi, %eax
	andl	$2147483640, %eax               # imm = 0x7FFFFFF8
	leal	(%rax,%rax,2), %eax
	andl	$4, %esi
	orl	%eax, %esi
	cmpl	$7, %ecx
	ja	.LBB2_14
# %bb.4:                                #   in Loop: Header=BB2_2 Depth=1
	movl	%ecx, %ebx
	andl	$-8, %ebx
	cmpq	%rcx, %rbx
	jae	.LBB2_20
	jmp	.LBB2_18
	.p2align	5, 0x90
.LBB2_14:                               #   in Loop: Header=BB2_2 Depth=1
	leaq	(,%rcx,4), %rbx
	andq	$-32, %rbx
	movl	%esi, %r12d
	leaq	(%r9,%r12,4), %rax
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB2_15:                               #   Parent Loop BB2_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovups	%ymm0, (%rax,%rdx)
	addq	$32, %rdx
	cmpq	%rdx, %rbx
	jne	.LBB2_15
# %bb.16:                               #   in Loop: Header=BB2_2 Depth=1
	movl	%ecx, %ebx
	andl	$-8, %ebx
	addq	%rbx, %r12
	vmovups	%zmm1, (%r9,%r12,4)
	cmpq	%rcx, %rbx
	jae	.LBB2_20
.LBB2_18:                               #   in Loop: Header=BB2_2 Depth=1
	movl	%esi, %eax
	leaq	(%r8,%rax,4), %rdx
	.p2align	4, 0x90
.LBB2_19:                               #   Parent Loop BB2_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$0, -64(%rdx,%rbx,4)
	movl	$0, -32(%rdx,%rbx,4)
	movl	$0, (%rdx,%rbx,4)
	incq	%rbx
	cmpq	%rbx, %rcx
	jne	.LBB2_19
	jmp	.LBB2_20
	.p2align	5, 0x90
.LBB2_5:
	xorl	%r12d, %r12d
	xorl	%eax, %eax
	vmovups	%zmm2, 96(%rsp)                 # 64-byte Spill
	vmovdqu64	%zmm3, 32(%rsp)         # 64-byte Spill
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 24(%rsp)                 # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	vmovups	32(%rsp), %zmm27                # 64-byte Reload
	vmovups	96(%rsp), %zmm26                # 64-byte Reload
	cmpl	$0, 20(%rbp)
	jle	.LBB2_10
# %bb.6:
	vmovss	20(%rsp), %xmm0                 # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	vmulss	%xmm0, %xmm0, %xmm0
	vbroadcastss	%xmm0, %zmm0
	movl	$224, %r8d
	vbroadcastss	.LCPI2_0(%rip), %zmm1   # zmm1 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vbroadcastss	.LCPI2_1(%rip), %zmm2   # zmm2 = [4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1]
	movw	$4369, %ax                      # imm = 0x1111
	kmovw	%eax, %k1
	vmovdqu	.LCPI2_2(%rip), %xmm3           # xmm3 = <1,u>
                                        # AlignMOV convert to UnAlignMOV 
	movq	%rbp, 8(%rsp)                   # 8-byte Spill
	jmp	.LBB2_7
	.p2align	5, 0x90
.LBB2_8:                                #   in Loop: Header=BB2_7 Depth=1
	vxorps	%xmm4, %xmm4, %xmm4
	vxorps	%xmm8, %xmm8, %xmm8
	vxorps	%xmm13, %xmm13, %xmm13
	vxorps	%xmm5, %xmm5, %xmm5
	vxorps	%xmm9, %xmm9, %xmm9
	vxorps	%xmm12, %xmm12, %xmm12
.LBB2_9:                                #   in Loop: Header=BB2_7 Depth=1
	movq	176(%rbp), %rax
	vshuff64x2	$136, %zmm13, %zmm12, %zmm6 # zmm6 = zmm12[0,1,4,5],zmm13[0,1,4,5]
	vshuff64x2	$221, %zmm13, %zmm12, %zmm7 # zmm7 = zmm12[2,3,6,7],zmm13[2,3,6,7]
	vaddps	%zmm7, %zmm6, %zmm6
	vpermilpd	$85, %zmm6, %zmm7       # zmm7 = zmm6[1,0,3,2,5,4,7,6]
	vaddps	%zmm7, %zmm6, %zmm6
	vpermilps	$177, %zmm6, %zmm7      # zmm7 = zmm6[1,0,3,2,5,4,7,6,9,8,11,10,13,12,15,14]
	vaddps	%zmm7, %zmm6, %zmm6
	vcompressps	%zmm6, %zmm6 {%k1} {z}
	vaddps	(%rax,%r9,4), %xmm6, %xmm6
	vmovups	%xmm6, (%rax,%r9,4)             # AlignMOV convert to UnAlignMOV 
	vshuff64x2	$136, %zmm8, %zmm9, %zmm6 # zmm6 = zmm9[0,1,4,5],zmm8[0,1,4,5]
	vshuff64x2	$221, %zmm8, %zmm9, %zmm7 # zmm7 = zmm9[2,3,6,7],zmm8[2,3,6,7]
	vaddps	%zmm7, %zmm6, %zmm6
	vpermilpd	$85, %zmm6, %zmm7       # zmm7 = zmm6[1,0,3,2,5,4,7,6]
	vaddps	%zmm7, %zmm6, %zmm6
	vpermilps	$177, %zmm6, %zmm7      # zmm7 = zmm6[1,0,3,2,5,4,7,6,9,8,11,10,13,12,15,14]
	vaddps	%zmm7, %zmm6, %zmm6
	vcompressps	%zmm6, %zmm6 {%k1} {z}
	vaddps	32(%rax,%r9,4), %xmm6, %xmm6
	vmovups	%xmm6, 32(%rax,%r9,4)           # AlignMOV convert to UnAlignMOV 
	vshuff64x2	$136, %zmm4, %zmm5, %zmm6 # zmm6 = zmm5[0,1,4,5],zmm4[0,1,4,5]
	vshuff64x2	$221, %zmm4, %zmm5, %zmm4 # zmm4 = zmm5[2,3,6,7],zmm4[2,3,6,7]
	vaddps	%zmm4, %zmm6, %zmm4
	vpermilpd	$85, %zmm4, %zmm5       # zmm5 = zmm4[1,0,3,2,5,4,7,6]
	vaddps	%zmm5, %zmm4, %zmm4
	vpermilps	$177, %zmm4, %zmm5      # zmm5 = zmm4[1,0,3,2,5,4,7,6,9,8,11,10,13,12,15,14]
	vaddps	%zmm5, %zmm4, %zmm4
	vcompressps	%zmm4, %zmm4 {%k1} {z}
	vaddps	64(%rax,%r9,4), %xmm4, %xmm4
	vmovups	%xmm4, 64(%rax,%r9,4)           # AlignMOV convert to UnAlignMOV 
	vpinsrq	$1, %r10, %xmm3, %xmm4
	vpaddq	(%r13), %xmm4, %xmm4
	vmovdqu	%xmm4, (%r13)
	addq	%r10, 16(%r13)
	incq	%r12
	movslq	20(%rbp), %rax
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
	movq	160(%rbp), %rsi
	movq	8(%r14), %rax
	vbroadcastss	(%rsi,%r9,4), %ymm4
	vbroadcastss	4(%rsi,%r9,4), %ymm5
	vbroadcastss	8(%rsi,%r9,4), %ymm7
	vinsertf64x4	$1, %ymm5, %zmm4, %zmm6
	vbroadcastss	12(%rsi,%r9,4), %ymm4
	vinsertf64x4	$1, %ymm4, %zmm7, %zmm7
	vbroadcastss	32(%rsi,%r9,4), %ymm4
	vbroadcastss	36(%rsi,%r9,4), %ymm5
	vbroadcastss	40(%rsi,%r9,4), %ymm8
	vbroadcastss	44(%rsi,%r9,4), %ymm9
	vinsertf64x4	$1, %ymm5, %zmm4, %zmm10
	vinsertf64x4	$1, %ymm9, %zmm8, %zmm11
	vbroadcastss	64(%rsi,%r9,4), %ymm4
	vbroadcastss	68(%rsi,%r9,4), %ymm5
	vinsertf64x4	$1, %ymm5, %zmm4, %zmm14
	vbroadcastss	72(%rsi,%r9,4), %ymm4
	vbroadcastss	76(%rsi,%r9,4), %ymm5
	vinsertf64x4	$1, %ymm5, %zmm4, %zmm15
	movl	%r10d, %r10d
	movq	%r14, %r15
	movl	16(%r14), %ecx
	imull	%r12d, %ecx
	movslq	%ecx, %rcx
	leaq	(%rax,%rcx,4), %r11
	vxorps	%xmm12, %xmm12, %xmm12
	xorl	%eax, %eax
	vxorps	%xmm9, %xmm9, %xmm9
	vxorps	%xmm5, %xmm5, %xmm5
	vxorps	%xmm13, %xmm13, %xmm13
	vxorps	%xmm8, %xmm8, %xmm8
	vxorps	%xmm4, %xmm4, %xmm4
	.p2align	4, 0x90
movl      $111, %ebx # OSACA START MARKER
.byte     100        # OSACA START MARKER
.byte     103        # OSACA START MARKER
.byte     144        # OSACA START MARKER
# LLVM-MCA-BEGIN
# pointer_increment=256 a23042eac7d8a1e13e9ff886fc02a80e
.LBB2_12:                               #   Parent Loop BB2_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%r11,%rax,4), %rcx
	leaq	(%rcx,%rcx,2), %rdx
	shlq	$5, %rdx
	vmovupd	(%rsi,%rdx), %zmm16
	vbroadcastf64x4	64(%rsi,%rdx), %zmm20   # zmm20 = mem[0,1,2,3,0,1,2,3]
	vbroadcastf64x4	(%rsi,%rdx), %zmm19     # zmm19 = mem[0,1,2,3,0,1,2,3]
	vshuff64x2	$238, %zmm16, %zmm16, %zmm21 # zmm21 = zmm16[4,5,6,7,4,5,6,7]
	vsubps	%zmm19, %zmm6, %zmm18
	vsubps	%zmm21, %zmm10, %zmm17
	vsubps	%zmm20, %zmm14, %zmm16
	vmulps	%zmm16, %zmm16, %zmm22
	vfmadd231ps	%zmm17, %zmm17, %zmm22  # zmm22 = (zmm17 * zmm17) + zmm22
	vfmadd231ps	%zmm18, %zmm18, %zmm22  # zmm22 = (zmm18 * zmm18) + zmm22
	vrcp14ps	%zmm22, %zmm23
	vmulps	%zmm23, %zmm26, %zmm24
	vmulps	%zmm24, %zmm23, %zmm24
	vmulps	%zmm24, %zmm23, %zmm24
	vaddps	%zmm1, %zmm24, %zmm25
	vmulps	%zmm23, %zmm27, %zmm23
	vmulps	%zmm25, %zmm23, %zmm23
	vmulps	%zmm23, %zmm24, %zmm23
	leal	(%rcx,%rcx), %edx
	xorl	%edi, %edi
	xorl	%ebp, %ebp
	cmpq	%rdx, %r12
	setne	%dil
	leal	1(%rcx,%rcx), %ecx
	sete	%bpl
	xorl	%edx, %edx
	xorl	%ebx, %ebx
	cmpq	%rcx, %r12
	sete	%dl
	movl	$0, %ecx
	setne	%bl
	cmovel	%r8d, %ecx
	movl	%ebx, %r14d
	shll	$4, %r14d
	subl	%ebp, %r14d
	leal	(%rcx,%rdi,2), %ecx
	shll	$8, %ecx
	addl	$239, %r14d
	addl	$-768, %ecx                     # imm = 0xFD00
	orl	%r14d, %ecx
	kmovd	%ecx, %k2
	vcmpltps	%zmm0, %zmm22, %k2 {%k2}
	vsubps	%zmm21, %zmm11, %zmm21
	vsubps	%zmm20, %zmm15, %zmm20
	vsubps	%zmm19, %zmm7, %zmm19
	vmulps	%zmm2, %zmm23, %zmm22
	vfmadd231ps	%zmm22, %zmm18, %zmm12 {%k2} # zmm12 {%k2} = (zmm18 * zmm22) + zmm12
	vmulps	%zmm20, %zmm20, %zmm18
	vfmadd231ps	%zmm21, %zmm21, %zmm18  # zmm18 = (zmm21 * zmm21) + zmm18
	vfmadd231ps	%zmm19, %zmm19, %zmm18  # zmm18 = (zmm19 * zmm19) + zmm18
	vfmadd231ps	%zmm22, %zmm17, %zmm9 {%k2} # zmm9 {%k2} = (zmm17 * zmm22) + zmm9
	vrcp14ps	%zmm18, %zmm17
	vfmadd231ps	%zmm22, %zmm16, %zmm5 {%k2} # zmm5 {%k2} = (zmm16 * zmm22) + zmm5
	vmulps	%zmm17, %zmm26, %zmm16
	vmulps	%zmm16, %zmm17, %zmm16
	vmulps	%zmm16, %zmm17, %zmm16
	vaddps	%zmm1, %zmm16, %zmm22
	vmulps	%zmm17, %zmm27, %zmm17
	vmulps	%zmm22, %zmm17, %zmm17
	vmulps	%zmm17, %zmm16, %zmm16
	shll	$6, %ebx
	leal	(%rbx,%rdi,4), %ecx
	shll	$7, %edx
	leal	(%rdx,%rdi,8), %edx
	shll	$8, %edx
	addl	%edx, %ecx
	addl	$-2117, %ecx                    # imm = 0xF7BB
	kmovd	%ecx, %k2
	vcmpltps	%zmm0, %zmm18, %k2 {%k2}
	vmulps	%zmm2, %zmm16, %zmm16
	vfmadd231ps	%zmm16, %zmm19, %zmm13 {%k2} # zmm13 {%k2} = (zmm19 * zmm16) + zmm13
	vfmadd231ps	%zmm16, %zmm21, %zmm8 {%k2} # zmm8 {%k2} = (zmm21 * zmm16) + zmm8
	vfmadd231ps	%zmm16, %zmm20, %zmm4 {%k2} # zmm4 {%k2} = (zmm20 * zmm16) + zmm4
	incq	%rax
	cmpq	%rax, %r10
	jne	.LBB2_12
# LLVM-MCA-END
movl      $222, %ebx # OSACA END MARKER
.byte     100        # OSACA END MARKER
.byte     103        # OSACA END MARKER
.byte     144        # OSACA END MARKER
# %bb.13:                               #   in Loop: Header=BB2_7 Depth=1
	movq	%r15, %r14
	movq	8(%rsp), %rbp                   # 8-byte Reload
	jmp	.LBB2_9
	.p2align	5, 0x90
.LBB2_10:
	movl	$.L.str.1, %edi
	vzeroupper
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, 8(%rsp)                  # 8-byte Spill
	movl	$.L.str.5, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	8(%rsp), %xmm0                  # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vsubsd	24(%rsp), %xmm0, %xmm0          # 8-byte Folded Reload
	addq	$168, %rsp
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
	.quad	0x41cdcd6500000000              #  1.0E+9
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2
.LCPI4_1:
	.long	0xbf000000                      #  -0.5
.LCPI4_2:
	.long	0x42400000                      #  48
	.text
	.globl	computeForceLJ_4xn_half
	.p2align	4, 0x90
	.type	computeForceLJ_4xn_half,@function
computeForceLJ_4xn_half:                # 
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
	subq	$576, %rsp                      # imm = 0x240
	.cfi_def_cfa_offset 624
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %r12
	movl	$.L.str.6, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovss	108(%r12), %xmm0                # xmm0 = mem[0],zero,zero,zero
	vmovss	%xmm0, 64(%rsp)                 # 4-byte Spill
	vbroadcastss	48(%r12), %zmm0
	vmovups	%zmm0, 512(%rsp)                # 64-byte Spill
	vbroadcastss	40(%r12), %zmm0
	vmovupd	%zmm0, 448(%rsp)                # 64-byte Spill
	movl	20(%r15), %r11d
	testl	%r11d, %r11d
	jle	.LBB4_5
# %bb.1:
	movq	176(%r15), %r9
	movq	192(%r15), %r10
	decq	%r11
	leaq	64(%r9), %r8
	xorl	%edi, %edi
	vxorpd	%xmm0, %xmm0, %xmm0
	vxorps	%xmm1, %xmm1, %xmm1
	jmp	.LBB4_2
	.p2align	5, 0x90
.LBB4_16:                               #   in Loop: Header=BB4_2 Depth=1
	cmpq	%r11, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB4_5
.LBB4_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_11 Depth 2
                                        #     Child Loop BB4_15 Depth 2
	leaq	(%rdi,%rdi,8), %rax
	leaq	(%rax,%rax,2), %rax
	addq	%rdi, %rax
	movl	(%r10,%rax), %ecx
	testl	%ecx, %ecx
	jle	.LBB4_16
# %bb.3:                                #   in Loop: Header=BB4_2 Depth=1
	leal	(,%rdi,4), %esi
	movl	%esi, %eax
	andl	$2147483640, %eax               # imm = 0x7FFFFFF8
	leal	(%rax,%rax,2), %eax
	andl	$4, %esi
	orl	%eax, %esi
	cmpl	$7, %ecx
	ja	.LBB4_10
# %bb.4:                                #   in Loop: Header=BB4_2 Depth=1
	movl	%ecx, %ebx
	andl	$-8, %ebx
	cmpq	%rcx, %rbx
	jae	.LBB4_16
	jmp	.LBB4_14
	.p2align	5, 0x90
.LBB4_10:                               #   in Loop: Header=BB4_2 Depth=1
	leaq	(,%rcx,4), %rbx
	andq	$-32, %rbx
	movl	%esi, %r13d
	leaq	(%r9,%r13,4), %rax
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB4_11:                               #   Parent Loop BB4_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%ymm0, (%rax,%rdx)
	addq	$32, %rdx
	cmpq	%rdx, %rbx
	jne	.LBB4_11
# %bb.12:                               #   in Loop: Header=BB4_2 Depth=1
	movl	%ecx, %ebx
	andl	$-8, %ebx
	addq	%rbx, %r13
	vmovups	%zmm1, (%r9,%r13,4)
	cmpq	%rcx, %rbx
	jae	.LBB4_16
.LBB4_14:                               #   in Loop: Header=BB4_2 Depth=1
	movl	%esi, %eax
	leaq	(%r8,%rax,4), %rdx
	.p2align	4, 0x90
.LBB4_15:                               #   Parent Loop BB4_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$0, -64(%rdx,%rbx,4)
	movl	$0, -32(%rdx,%rbx,4)
	movl	$0, (%rdx,%rbx,4)
	incq	%rbx
	cmpq	%rbx, %rcx
	jne	.LBB4_15
	jmp	.LBB4_16
	.p2align	5, 0x90
.LBB4_5:
	xorl	%eax, %eax
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, (%rsp)                   # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	cmpl	$0, 20(%r15)
	jg	.LBB4_6
# %bb.17:
	movl	$.L.str.1, %edi
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	184(%r12), %xmm3                # xmm3 = mem[0],zero
	vsubsd	(%rsp), %xmm0, %xmm1            # 8-byte Folded Reload
	vmovsd	%xmm1, (%rsp)                   # 8-byte Spill
	vmulsd	.LCPI4_0(%rip), %xmm3, %xmm0
	vmulsd	%xmm1, %xmm0, %xmm0
	vxorpd	%xmm2, %xmm2, %xmm2
	vdivsd	%xmm2, %xmm0, %xmm2
	movl	$.L.str.4, %edi
	xorl	%esi, %esi
	vmovapd	%xmm3, %xmm0
	movb	$3, %al
	callq	printf
	movl	$.L.str.7, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	(%rsp), %xmm0                   # 8-byte Reload
                                        # xmm0 = mem[0],zero
	addq	$576, %rsp                      # imm = 0x240
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
	.p2align	5, 0x90
.LBB4_6:
	.cfi_def_cfa_offset 624
	movq	24(%r14), %rax
	movl	(%rax), %r10d
	testl	%r10d, %r10d
	jle	.LBB4_18
# %bb.7:
	vmovss	64(%rsp), %xmm0                 # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	vmulss	%xmm0, %xmm0, %xmm0
	vbroadcastss	%xmm0, %zmm0
	movq	160(%r15), %rdi
	movq	8(%r14), %r11
	vbroadcastss	(%rdi), %zmm1
	vmovups	%zmm1, (%rsp)                   # 64-byte Spill
	vbroadcastss	4(%rdi), %zmm1
	vmovups	%zmm1, 64(%rsp)                 # 64-byte Spill
	vbroadcastss	8(%rdi), %zmm1
	vmovups	%zmm1, 384(%rsp)                # 64-byte Spill
	vbroadcastss	12(%rdi), %zmm1
	vmovups	%zmm1, 320(%rsp)                # 64-byte Spill
	vbroadcastss	32(%rdi), %zmm1
	vmovups	%zmm1, 256(%rsp)                # 64-byte Spill
	vbroadcastss	36(%rdi), %zmm1
	vmovups	%zmm1, 192(%rsp)                # 64-byte Spill
	vbroadcastss	40(%rdi), %zmm1
	vmovups	%zmm1, 128(%rsp)                # 64-byte Spill
	vbroadcastss	44(%rdi), %zmm8
	vbroadcastss	64(%rdi), %zmm9
	vbroadcastss	68(%rdi), %zmm10
	vbroadcastss	72(%rdi), %zmm11
	vbroadcastss	76(%rdi), %zmm12
	decq	%r10
	xorl	%edx, %edx
	movl	$248, %r8d
	movl	$240, %r9d
	vbroadcastss	.LCPI4_1(%rip), %zmm13  # zmm13 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vbroadcastss	.LCPI4_2(%rip), %zmm14  # zmm14 = [4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1,4.8E+1]
	vmovups	512(%rsp), %zmm6                # 64-byte Reload
	vmovups	448(%rsp), %zmm7                # 64-byte Reload
	.p2align	4, 0x90
.LBB4_8:                                # =>This Inner Loop Header: Depth=1
	movslq	(%r11,%rdx,4), %rax
	movq	%rax, %rsi
	shlq	$5, %rsi
	leaq	(%rsi,%rsi,2), %rbx
	vmovups	(%rdi,%rbx), %zmm15             # AlignMOV convert to UnAlignMOV 
	vmovups	32(%rdi,%rbx), %zmm16           # AlignMOV convert to UnAlignMOV 
	vmovups	64(%rdi,%rbx), %zmm27           # AlignMOV convert to UnAlignMOV 
	vmovups	(%rsp), %zmm1                   # 64-byte Reload
	vsubps	%zmm15, %zmm1, %zmm24
	vmovups	256(%rsp), %zmm1                # 64-byte Reload
	vsubps	%zmm16, %zmm1, %zmm25
	vsubps	%zmm27, %zmm9, %zmm26
	vmovups	64(%rsp), %zmm1                 # 64-byte Reload
	vsubps	%zmm15, %zmm1, %zmm21
	vmovups	192(%rsp), %zmm1                # 64-byte Reload
	vsubps	%zmm16, %zmm1, %zmm22
	vsubps	%zmm27, %zmm10, %zmm23
	vmovups	384(%rsp), %zmm1                # 64-byte Reload
	vsubps	%zmm15, %zmm1, %zmm17
	vmovups	128(%rsp), %zmm1                # 64-byte Reload
	vsubps	%zmm16, %zmm1, %zmm19
	vsubps	%zmm27, %zmm11, %zmm20
	vmovups	320(%rsp), %zmm1                # 64-byte Reload
	vsubps	%zmm15, %zmm1, %zmm18
	vsubps	%zmm16, %zmm8, %zmm16
	vsubps	%zmm27, %zmm12, %zmm15
	vmulps	%zmm26, %zmm26, %zmm27
	vfmadd231ps	%zmm25, %zmm25, %zmm27  # zmm27 = (zmm25 * zmm25) + zmm27
	vfmadd231ps	%zmm24, %zmm24, %zmm27  # zmm27 = (zmm24 * zmm24) + zmm27
	vmulps	%zmm23, %zmm23, %zmm28
	vfmadd231ps	%zmm22, %zmm22, %zmm28  # zmm28 = (zmm22 * zmm22) + zmm28
	vfmadd231ps	%zmm21, %zmm21, %zmm28  # zmm28 = (zmm21 * zmm21) + zmm28
	vmulps	%zmm20, %zmm20, %zmm29
	vfmadd231ps	%zmm19, %zmm19, %zmm29  # zmm29 = (zmm19 * zmm19) + zmm29
	vfmadd231ps	%zmm17, %zmm17, %zmm29  # zmm29 = (zmm17 * zmm17) + zmm29
	vmulps	%zmm15, %zmm15, %zmm30
	vfmadd231ps	%zmm16, %zmm16, %zmm30  # zmm30 = (zmm16 * zmm16) + zmm30
	vrcp14ps	%zmm27, %zmm31
	vrcp14ps	%zmm28, %zmm1
	vrcp14ps	%zmm29, %zmm2
	vfmadd231ps	%zmm18, %zmm18, %zmm30  # zmm30 = (zmm18 * zmm18) + zmm30
	vrcp14ps	%zmm30, %zmm3
	vmulps	%zmm31, %zmm6, %zmm4
	vmulps	%zmm4, %zmm31, %zmm4
	vmulps	%zmm4, %zmm31, %zmm4
	vaddps	%zmm13, %zmm4, %zmm5
	vmulps	%zmm31, %zmm7, %zmm31
	vmulps	%zmm5, %zmm31, %zmm5
	vmulps	%zmm1, %zmm6, %zmm31
	vmulps	%zmm31, %zmm1, %zmm31
	vmulps	%zmm31, %zmm1, %zmm31
	vmulps	%zmm5, %zmm4, %zmm4
	vaddps	%zmm13, %zmm31, %zmm5
	vmulps	%zmm1, %zmm7, %zmm1
	vmulps	%zmm5, %zmm1, %zmm1
	vmulps	%zmm2, %zmm6, %zmm5
	vmulps	%zmm5, %zmm2, %zmm5
	vmulps	%zmm5, %zmm2, %zmm5
	vmulps	%zmm1, %zmm31, %zmm1
	vaddps	%zmm13, %zmm5, %zmm31
	vmulps	%zmm2, %zmm7, %zmm2
	vmulps	%zmm31, %zmm2, %zmm2
	vmulps	%zmm3, %zmm6, %zmm31
	vmulps	%zmm31, %zmm3, %zmm31
	vmulps	%zmm31, %zmm3, %zmm31
	vmulps	%zmm2, %zmm5, %zmm2
	vaddps	%zmm13, %zmm31, %zmm5
	vmulps	%zmm3, %zmm7, %zmm3
	vmulps	%zmm5, %zmm3, %zmm3
	vmulps	%zmm3, %zmm31, %zmm3
	xorl	%esi, %esi
	xorl	%edi, %edi
	testl	$2147483647, %eax               # imm = 0x7FFFFFFF
	sete	%sil
	setne	%dil
	movl	$255, %eax
	cmovel	%r8d, %eax
	movl	$255, %ecx
	cmovel	%r9d, %ecx
	xorl	$255, %esi
	kmovd	%esi, %k1
	vcmpltps	%zmm0, %zmm27, %k1 {%k1}
	vmulps	%zmm14, %zmm4, %zmm4
	vmulps	%zmm4, %zmm24, %zmm5 {%k1} {z}
	vmulps	%zmm4, %zmm25, %zmm24 {%k1} {z}
	vmulps	%zmm4, %zmm26, %zmm4 {%k1} {z}
	leal	(%rdi,%rdi,2), %esi
	orl	$252, %esi
	kmovd	%esi, %k1
	vcmpltps	%zmm0, %zmm28, %k1 {%k1}
	vmulps	%zmm14, %zmm1, %zmm1
	vmulps	%zmm1, %zmm21, %zmm21 {%k1} {z}
	vaddps	%zmm21, %zmm5, %zmm5
	vmulps	%zmm1, %zmm22, %zmm21 {%k1} {z}
	vaddps	%zmm21, %zmm24, %zmm21
	vmulps	%zmm1, %zmm23, %zmm1 {%k1} {z}
	vaddps	%zmm1, %zmm4, %zmm1
	kmovd	%eax, %k1
	vcmpltps	%zmm0, %zmm29, %k1 {%k1}
	vmulps	%zmm14, %zmm2, %zmm2
	vmulps	%zmm2, %zmm17, %zmm4 {%k1} {z}
	vmulps	%zmm2, %zmm19, %zmm17 {%k1} {z}
	vmulps	%zmm2, %zmm20, %zmm2 {%k1} {z}
	kmovd	%ecx, %k1
	vcmpltps	%zmm0, %zmm30, %k1 {%k1}
	vmulps	%zmm14, %zmm3, %zmm3
	vmulps	%zmm3, %zmm18, %zmm18 {%k1} {z}
	vaddps	%zmm18, %zmm4, %zmm4
	vaddps	%zmm4, %zmm5, %zmm4
	vmulps	%zmm3, %zmm16, %zmm5 {%k1} {z}
	vaddps	%zmm5, %zmm17, %zmm5
	vaddps	%zmm5, %zmm21, %zmm5
	vmulps	%zmm3, %zmm15, %zmm3 {%k1} {z}
	movq	176(%r15), %rax
	vaddps	%zmm3, %zmm2, %zmm2
	vmovups	(%rax,%rbx), %zmm3              # AlignMOV convert to UnAlignMOV 
	vsubps	%zmm4, %zmm3, %zmm3
	vmovups	%zmm3, (%rax,%rbx)              # AlignMOV convert to UnAlignMOV 
	vaddps	%zmm2, %zmm1, %zmm1
	vmovups	32(%rax,%rbx), %zmm2            # AlignMOV convert to UnAlignMOV 
	vsubps	%zmm5, %zmm2, %zmm2
	vmovups	%zmm2, 32(%rax,%rbx)            # AlignMOV convert to UnAlignMOV 
	vmovups	64(%rax,%rbx), %zmm2            # AlignMOV convert to UnAlignMOV 
	vsubps	%zmm1, %zmm2, %zmm1
	vmovups	%zmm1, 64(%rax,%rbx)            # AlignMOV convert to UnAlignMOV 
	cmpq	%rdx, %r10
	je	.LBB4_18
# %bb.9:                                #   in Loop: Header=BB4_8 Depth=1
	movq	160(%r15), %rdi
	incq	%rdx
	jmp	.LBB4_8
	.p2align	5, 0x90
.LBB4_18:
	vzeroupper
	callq	simd_incr_reduced_sum
.Lfunc_end4:
	.size	computeForceLJ_4xn_half, .Lfunc_end4-computeForceLJ_4xn_half
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function simd_incr_reduced_sum
	.type	simd_incr_reduced_sum,@function
simd_incr_reduced_sum:                  # 
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	stderr(%rip), %rcx
	movl	$.L.str.8, %edi
	movl	$92, %esi
	movl	$1, %edx
	callq	fwrite@PLT
	movl	$-1, %edi
	callq	exit
.Lfunc_end5:
	.size	simd_incr_reduced_sum, .Lfunc_end5-simd_incr_reduced_sum
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3                               # -- Begin function computeForceLJ_4xn_full
.LCPI6_0:
	.quad	0x41cdcd6500000000              #  1.0E+9
	.text
	.globl	computeForceLJ_4xn_full
	.p2align	4, 0x90
	.type	computeForceLJ_4xn_full,@function
computeForceLJ_4xn_full:                # 
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	pushq	%rax
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rsi, %r15
	movq	%rdi, %r14
	movl	$.L.str.6, %edi
	xorl	%eax, %eax
	callq	debug_printf
	movl	20(%r15), %r11d
	testl	%r11d, %r11d
	jle	.LBB6_5
# %bb.1:
	movq	176(%r15), %r9
	movq	192(%r15), %r10
	decq	%r11
	leaq	64(%r9), %r8
	xorl	%edi, %edi
	vxorpd	%xmm0, %xmm0, %xmm0
	vxorps	%xmm1, %xmm1, %xmm1
	jmp	.LBB6_2
	.p2align	5, 0x90
.LBB6_13:                               #   in Loop: Header=BB6_2 Depth=1
	cmpq	%r11, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB6_5
.LBB6_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB6_8 Depth 2
                                        #     Child Loop BB6_12 Depth 2
	leaq	(%rdi,%rdi,8), %rax
	leaq	(%rax,%rax,2), %rax
	addq	%rdi, %rax
	movl	(%r10,%rax), %ecx
	testl	%ecx, %ecx
	jle	.LBB6_13
# %bb.3:                                #   in Loop: Header=BB6_2 Depth=1
	leal	(,%rdi,4), %esi
	movl	%esi, %eax
	andl	$2147483640, %eax               # imm = 0x7FFFFFF8
	leal	(%rax,%rax,2), %eax
	andl	$4, %esi
	orl	%eax, %esi
	cmpl	$7, %ecx
	ja	.LBB6_7
# %bb.4:                                #   in Loop: Header=BB6_2 Depth=1
	movl	%ecx, %ebx
	andl	$-8, %ebx
	cmpq	%rcx, %rbx
	jae	.LBB6_13
	jmp	.LBB6_11
	.p2align	5, 0x90
.LBB6_7:                                #   in Loop: Header=BB6_2 Depth=1
	leaq	(,%rcx,4), %rbx
	andq	$-32, %rbx
	movl	%esi, %r12d
	leaq	(%r9,%r12,4), %rax
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB6_8:                                #   Parent Loop BB6_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%ymm0, (%rax,%rdx)
	addq	$32, %rdx
	cmpq	%rdx, %rbx
	jne	.LBB6_8
# %bb.9:                                #   in Loop: Header=BB6_2 Depth=1
	movl	%ecx, %ebx
	andl	$-8, %ebx
	addq	%rbx, %r12
	vmovups	%zmm1, (%r9,%r12,4)
	cmpq	%rcx, %rbx
	jae	.LBB6_13
.LBB6_11:                               #   in Loop: Header=BB6_2 Depth=1
	movl	%esi, %eax
	leaq	(%r8,%rax,4), %rdx
	.p2align	4, 0x90
.LBB6_12:                               #   Parent Loop BB6_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$0, -64(%rdx,%rbx,4)
	movl	$0, -32(%rdx,%rbx,4)
	movl	$0, (%rdx,%rbx,4)
	incq	%rbx
	cmpq	%rbx, %rcx
	jne	.LBB6_12
	jmp	.LBB6_13
	.p2align	5, 0x90
.LBB6_5:
	xorl	%eax, %eax
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, (%rsp)                   # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	cmpl	$0, 20(%r15)
	jg	.LBB6_6
# %bb.14:
	movl	$.L.str.1, %edi
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	184(%r14), %xmm3                # xmm3 = mem[0],zero
	vsubsd	(%rsp), %xmm0, %xmm1            # 8-byte Folded Reload
	vmovsd	%xmm1, (%rsp)                   # 8-byte Spill
	vmulsd	.LCPI6_0(%rip), %xmm3, %xmm0
	vmulsd	%xmm1, %xmm0, %xmm0
	vxorpd	%xmm2, %xmm2, %xmm2
	vdivsd	%xmm2, %xmm0, %xmm2
	movl	$.L.str.4, %edi
	xorl	%esi, %esi
	vmovapd	%xmm3, %xmm0
	movb	$3, %al
	callq	printf
	movl	$.L.str.7, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	(%rsp), %xmm0                   # 8-byte Reload
                                        # xmm0 = mem[0],zero
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
	.p2align	5, 0x90
.LBB6_6:
	.cfi_def_cfa_offset 48
	callq	simd_incr_reduced_sum
.Lfunc_end6:
	.size	computeForceLJ_4xn_full, .Lfunc_end6-computeForceLJ_4xn_full
	.cfi_endproc
                                        # -- End function
	.globl	computeForceLJ_4xn              # -- Begin function computeForceLJ_4xn
	.p2align	4, 0x90
	.type	computeForceLJ_4xn,@function
computeForceLJ_4xn:                     # 
	.cfi_startproc
# %bb.0:
	cmpl	$0, 32(%rdx)
	je	.LBB7_2
# %bb.1:
	jmp	computeForceLJ_4xn_half         # TAILCALL
	.p2align	5, 0x90
.LBB7_2:
	jmp	computeForceLJ_4xn_full         # TAILCALL
.Lfunc_end7:
	.size	computeForceLJ_4xn, .Lfunc_end7-computeForceLJ_4xn
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
	.asciz	"Its: %u  Freq: %f  Time: %f\nCy/it: %f\n"
	.size	.L.str.4, 39
	.type	.L.str.5,@object                # 
.L.str.5:
	.asciz	"computeForceLJ_2xnn end\n"
	.size	.L.str.5, 25
	.type	.L.str.6,@object                # 
.L.str.6:
	.asciz	"computeForceLJ_4xn begin\n"
	.size	.L.str.6, 26
	.type	.L.str.7,@object                # 
.L.str.7:
	.asciz	"computeForceLJ_4xn end\n"
	.size	.L.str.7, 24
	.type	.L.str.8,@object                # 
.L.str.8:
	.asciz	"simd_h_reduce_sum(): Called with AVX512 intrinsics and single-precision which is not valid!\n"
	.size	.L.str.8, 93
	.ident	"Intel(R) oneAPI DPC++/C++ Compiler 2022.1.0 (2022.1.0.20220316)"
	.section	".note.GNU-stack","",@progbits
