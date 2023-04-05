	.text
	.file	"force_lj.c"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3               # -- Begin function computeForceLJ_ref
.LCPI0_0:
	.quad	4631952216750555136     #  48
.LCPI0_1:
	.quad	4607182418800017408     #  1
.LCPI0_2:
	.quad	-4620693217682128896    #  -0.5
.LCPI0_4:
	.quad	4602678819172646912     #  0.5
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI0_3:
	.quad	1                       # 0x1
	.zero	8
	.text
	.globl	computeForceLJ_ref
	.p2align	4, 0x90
	.type	computeForceLJ_ref,@function
computeForceLJ_ref:                     # 
.LcomputeForceLJ_ref$local:
	.cfi_startproc
# %bb.0:                                # 
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
	movq	%rcx, 16(%rsp)          # 8-byte Spill
	movq	%rdx, 24(%rsp)          # 8-byte Spill
	movq	%rsi, %r12
	movq	%rdi, %rbx
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	144(%rbx), %xmm0        # xmm0 = mem[0],zero
	vmovsd	%xmm0, 8(%rsp)          # 8-byte Spill
	vmovsd	40(%rbx), %xmm0         # xmm0 = mem[0],zero
	vmovsd	%xmm0, (%rsp)           # 8-byte Spill
	vmovsd	56(%rbx), %xmm1         # xmm1 = mem[0],zero
	movl	20(%r12), %r10d
	testl	%r10d, %r10d
	jle	.LBB0_5
# %bb.1:                                # 
	movq	176(%r12), %rcx
	movq	192(%r12), %r9
	decq	%r10
	leaq	128(%rcx), %r8
	xorl	%edi, %edi
	vxorpd	%xmm0, %xmm0, %xmm0
	jmp	.LBB0_2
	.p2align	4, 0x90
.LBB0_41:                               # 
                                        #   in Loop: Header=BB0_2 Depth=1
	cmpq	%r10, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB0_5
.LBB0_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_36 Depth 2
                                        #     Child Loop BB0_40 Depth 2
	imulq	$56, %rdi, %rax
	movl	(%r9,%rax), %edx
	testl	%edx, %edx
	jle	.LBB0_41
# %bb.3:                                # 
                                        #   in Loop: Header=BB0_2 Depth=1
	leal	(,%rdi,4), %eax
	movl	%eax, %esi
	andl	$-8, %esi
	leal	(%rsi,%rsi,2), %esi
	andl	$4, %eax
	orl	%esi, %eax
	movq	%rdx, %rsi
	shrq	$3, %rsi
	movl	%eax, %ebx
	je	.LBB0_4
# %bb.35:                               # 
                                        #   in Loop: Header=BB0_2 Depth=1
	leaq	(%rcx,%rbx,8), %rbp
	shlq	$6, %rsi
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB0_36:                               # 
                                        #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%zmm0, (%rbp,%rax)
	addq	$64, %rax
	cmpq	%rax, %rsi
	jne	.LBB0_36
# %bb.37:                               # 
                                        #   in Loop: Header=BB0_2 Depth=1
	movl	%edx, %ebp
	andl	$-8, %ebp
	leaq	(%rbx,%rbp), %rax
	vmovupd	%zmm0, (%rcx,%rax,8)
	vmovupd	%zmm0, 64(%rcx,%rax,8)
	cmpq	%rdx, %rbp
	jae	.LBB0_41
	jmp	.LBB0_39
	.p2align	4, 0x90
.LBB0_4:                                # 
                                        #   in Loop: Header=BB0_2 Depth=1
	movl	%edx, %ebp
	andl	$-8, %ebp
	cmpq	%rdx, %rbp
	jae	.LBB0_41
.LBB0_39:                               # 
                                        #   in Loop: Header=BB0_2 Depth=1
	leaq	(%r8,%rbx,8), %rsi
	.p2align	4, 0x90
.LBB0_40:                               # 
                                        #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, -128(%rsi,%rbp,8)
	movq	$0, -64(%rsi,%rbp,8)
	movq	$0, (%rsi,%rbp,8)
	incq	%rbp
	cmpq	%rbp, %rdx
	jne	.LBB0_40
	jmp	.LBB0_41
.LBB0_5:                                # 
	vmovsd	%xmm1, 40(%rsp)         # 8-byte Spill
	xorl	%eax, %eax
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 48(%rsp)         # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	movl	20(%r12), %eax
	movq	%rax, 88(%rsp)          # 8-byte Spill
	testl	%eax, %eax
	jle	.LBB0_17
# %bb.6:                                # 
	vmovsd	8(%rsp), %xmm0          # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm14
	movq	160(%r12), %rcx
	movq	176(%r12), %rdx
	movq	24(%rsp), %rax          # 8-byte Reload
	movq	16(%rax), %rsi
	movq	%rsi, 80(%rsp)          # 8-byte Spill
	movq	40(%rax), %rsi
	movq	%rsi, 64(%rsp)          # 8-byte Spill
	movslq	8(%rax), %rax
	movq	%rax, 56(%rsp)          # 8-byte Spill
	vmovsd	(%rsp), %xmm0           # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	.LCPI0_0(%rip), %xmm0, %xmm13
	movq	16(%rsp), %rax          # 8-byte Reload
	leaq	32(%rax), %r10
	leaq	24(%rax), %rbx
	leaq	40(%rax), %rsi
	movq	%rsi, 8(%rsp)           # 8-byte Spill
	leaq	48(%rax), %rsi
	movq	%rsi, 160(%rsp)         # 8-byte Spill
	vmovdqu	(%rax), %xmm10
	movq	16(%rax), %rsi
	movq	%rdx, 72(%rsp)          # 8-byte Spill
	leaq	128(%rdx), %rax
	movq	%rax, 128(%rsp)         # 8-byte Spill
	movq	%rcx, 32(%rsp)          # 8-byte Spill
	leaq	128(%rcx), %rax
	movq	%rax, 120(%rsp)         # 8-byte Spill
	xorl	%edi, %edi
	vmovsd	.LCPI0_1(%rip), %xmm11  # xmm11 = mem[0],zero
	vmovsd	.LCPI0_2(%rip), %xmm12  # xmm12 = mem[0],zero
	vmovdqa	.LCPI0_3(%rip), %xmm8   # xmm8 = <1,u>
	vmovsd	.LCPI0_4(%rip), %xmm9   # xmm9 = mem[0],zero
	vmovsd	40(%rsp), %xmm20        # 8-byte Reload
                                        # xmm20 = mem[0],zero
	jmp	.LBB0_7
	.p2align	4, 0x90
.LBB0_19:                               # 
                                        #   in Loop: Header=BB0_7 Depth=1
	movq	112(%rsp), %rsi         # 8-byte Reload
	movq	104(%rsp), %rdi         # 8-byte Reload
	movq	96(%rsp), %rbp          # 8-byte Reload
.LBB0_20:                               # 
                                        #   in Loop: Header=BB0_7 Depth=1
	vpinsrq	$1, %rax, %xmm8, %xmm0
	vpaddq	%xmm0, %xmm10, %xmm10
	vcvtsi2sd	%ebp, %xmm21, %xmm0
	vmulsd	%xmm0, %xmm9, %xmm0
	vcvttsd2si	%xmm0, %rax
	addq	%rax, %rsi
	incq	%rdi
	cmpq	88(%rsp), %rdi          # 8-byte Folded Reload
	jae	.LBB0_16
.LBB0_7:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_9 Depth 2
                                        #       Child Loop BB0_10 Depth 3
                                        #         Child Loop BB0_12 Depth 4
	movq	80(%rsp), %rax          # 8-byte Reload
	movslq	(%rax,%rdi,4), %rbp
	movq	%rbp, %rax
	testq	%rbp, %rbp
	jle	.LBB0_20
# %bb.8:                                # 
                                        #   in Loop: Header=BB0_7 Depth=1
	movq	%rsi, 112(%rsp)         # 8-byte Spill
	movl	%edi, %r14d
	shrl	%r14d
	leal	(,%r14,8), %eax
	leal	(%rax,%rax,2), %eax
	leal	(,%rdi,4), %ecx
	andl	$4, %ecx
	orl	%ecx, %eax
	movq	32(%rsp), %rdx          # 8-byte Reload
	leaq	(%rdx,%rax,8), %r15
	movq	72(%rsp), %rdx          # 8-byte Reload
	leaq	(%rdx,%rax,8), %r11
	movq	%rdi, 104(%rsp)         # 8-byte Spill
	movq	%rdi, %rax
	imulq	56(%rsp), %rax          # 8-byte Folded Reload
	movq	64(%rsp), %rdx          # 8-byte Reload
	leaq	(%rdx,%rax,4), %rax
	movq	%rax, 136(%rsp)         # 8-byte Spill
	movq	24(%rsp), %rax          # 8-byte Reload
	movl	32(%rax), %eax
	movl	%eax, (%rsp)            # 4-byte Spill
	movl	%ecx, %r12d
	movq	%rbp, 96(%rsp)          # 8-byte Spill
	movl	%ebp, %eax
	xorl	%ecx, %ecx
	movq	%rax, 144(%rsp)         # 8-byte Spill
	jmp	.LBB0_9
	.p2align	4, 0x90
.LBB0_18:                               # 
                                        #   in Loop: Header=BB0_9 Depth=2
	movq	152(%rsp), %rcx         # 8-byte Reload
	incq	%rcx
	movq	144(%rsp), %rax         # 8-byte Reload
	cmpq	%rax, %rcx
	je	.LBB0_19
.LBB0_9:                                # 
                                        #   Parent Loop BB0_7 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_10 Depth 3
                                        #         Child Loop BB0_12 Depth 4
	movq	136(%rsp), %rax         # 8-byte Reload
	movq	%rcx, 152(%rsp)         # 8-byte Spill
	movslq	(%rax,%rcx,4), %rsi
	movq	%rsi, %rax
	shlq	$6, %rax
	leaq	(%rax,%rax,2), %rbp
	movq	32(%rsp), %rax          # 8-byte Reload
	leaq	(%rax,%rbp), %rcx
	movq	128(%rsp), %rax         # 8-byte Reload
	leaq	(%rax,%rbp), %r13
	addq	120(%rsp), %rbp         # 8-byte Folded Reload
	xorl	%r8d, %r8d
	xorl	%eax, %eax
	jmp	.LBB0_10
.LBB0_77:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	movq	%r10, %rdx
	incq	(%r10)
	.p2align	4, 0x90
.LBB0_34:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	testl	%eax, %eax
	movq	8(%rsp), %rdx           # 8-byte Reload
	cmoveq	160(%rsp), %rdx         # 8-byte Folded Reload
	incq	(%rdx)
	vaddsd	(%r11,%r8,8), %xmm5, %xmm0
	vmovsd	%xmm0, (%r11,%r8,8)
	vaddsd	64(%r11,%r8,8), %xmm6, %xmm0
	vmovsd	%xmm0, 64(%r11,%r8,8)
	vaddsd	128(%r11,%r8,8), %xmm19, %xmm0
	vmovsd	%xmm0, 128(%r11,%r8,8)
	incq	%r8
	cmpq	$4, %r8
	je	.LBB0_18
.LBB0_10:                               # 
                                        #   Parent Loop BB0_7 Depth=1
                                        #     Parent Loop BB0_9 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_12 Depth 4
	vmovsd	(%r15,%r8,8), %xmm15    # xmm15 = mem[0],zero
	leaq	(%r8,%r12), %r9
	vmovsd	64(%r15,%r8,8), %xmm17  # xmm17 = mem[0],zero
	vmovsd	128(%r15,%r8,8), %xmm18 # xmm18 = mem[0],zero
	cmpl	$0, (%rsp)              # 4-byte Folded Reload
	je	.LBB0_21
# %bb.11:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vxorpd	%xmm5, %xmm5, %xmm5
	xorl	%edx, %edx
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm19, %xmm19, %xmm19
	jmp	.LBB0_12
	.p2align	4, 0x90
.LBB0_31:                               # 
                                        #   in Loop: Header=BB0_12 Depth=4
	vdivsd	%xmm3, %xmm11, %xmm3
	vmulsd	%xmm20, %xmm3, %xmm4
	vmulsd	%xmm3, %xmm3, %xmm7
	vmulsd	%xmm4, %xmm7, %xmm4
	vaddsd	%xmm4, %xmm12, %xmm7
	vmulsd	%xmm3, %xmm13, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmovsd	-64(%r13,%rdx,8), %xmm4 # xmm4 = mem[0],zero
	vmulsd	%xmm7, %xmm3, %xmm3
	vmovsd	-128(%r13,%rdx,8), %xmm7 # xmm7 = mem[0],zero
	vfnmadd231sd	%xmm3, %xmm2, %xmm7 # xmm7 = -(xmm2 * xmm3) + xmm7
	vmovsd	%xmm7, -128(%r13,%rdx,8)
	vfnmadd231sd	%xmm3, %xmm0, %xmm4 # xmm4 = -(xmm0 * xmm3) + xmm4
	vmovsd	%xmm4, -64(%r13,%rdx,8)
	vmovsd	(%r13,%rdx,8), %xmm4    # xmm4 = mem[0],zero
	vfnmadd231sd	%xmm3, %xmm1, %xmm4 # xmm4 = -(xmm1 * xmm3) + xmm4
	vmovsd	%xmm4, (%r13,%rdx,8)
	vfmadd231sd	%xmm2, %xmm3, %xmm5 # xmm5 = (xmm3 * xmm2) + xmm5
	vfmadd231sd	%xmm0, %xmm3, %xmm6 # xmm6 = (xmm3 * xmm0) + xmm6
	vfmadd231sd	%xmm3, %xmm1, %xmm19 # xmm19 = (xmm1 * xmm3) + xmm19
	movl	$1, %eax
	movq	%rbx, %rdi
.LBB0_32:                               # 
                                        #   in Loop: Header=BB0_12 Depth=4
	incq	(%rdi)
.LBB0_33:                               # 
                                        #   in Loop: Header=BB0_12 Depth=4
	incq	%rdx
	cmpq	$8, %rdx
	je	.LBB0_34
.LBB0_12:                               # 
                                        #   Parent Loop BB0_7 Depth=1
                                        #     Parent Loop BB0_9 Depth=2
                                        #       Parent Loop BB0_10 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	cmpl	%esi, %r14d
	jne	.LBB0_14
# %bb.13:                               # 
                                        #   in Loop: Header=BB0_12 Depth=4
	cmpq	%rdx, %r9
	jae	.LBB0_33
.LBB0_14:                               # 
                                        #   in Loop: Header=BB0_12 Depth=4
	vsubsd	-128(%rbp,%rdx,8), %xmm15, %xmm2
	vsubsd	-64(%rbp,%rdx,8), %xmm17, %xmm0
	vsubsd	(%rbp,%rdx,8), %xmm18, %xmm1
	vmulsd	%xmm2, %xmm2, %xmm3
	vfmadd231sd	%xmm0, %xmm0, %xmm3 # xmm3 = (xmm0 * xmm0) + xmm3
	vfmadd231sd	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vucomisd	%xmm14, %xmm3
	jb	.LBB0_31
# %bb.15:                               # 
                                        #   in Loop: Header=BB0_12 Depth=4
	movq	%r10, %rdi
	jmp	.LBB0_32
	.p2align	4, 0x90
.LBB0_21:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	cmpl	%esi, %r14d
	jne	.LBB0_24
# %bb.22:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vxorpd	%xmm19, %xmm19, %xmm19
	testq	%r9, %r9
	jne	.LBB0_24
# %bb.23:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm5, %xmm5, %xmm5
	cmpl	%esi, %r14d
	je	.LBB0_28
	jmp	.LBB0_29
.LBB0_24:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vsubsd	(%rcx), %xmm15, %xmm16
	vsubsd	64(%rcx), %xmm17, %xmm1
	vsubsd	128(%rcx), %xmm18, %xmm2
	vmulsd	%xmm16, %xmm16, %xmm0
	vfmadd231sd	%xmm1, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm1) + xmm0
	vfmadd231sd	%xmm2, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm2) + xmm0
	vxorpd	%xmm19, %xmm19, %xmm19
	vucomisd	%xmm14, %xmm0
	movq	%r10, %rdx
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm5, %xmm5, %xmm5
	jae	.LBB0_26
# %bb.25:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vdivsd	%xmm0, %xmm11, %xmm0
	vmulsd	%xmm20, %xmm0, %xmm3
	vmulsd	%xmm0, %xmm0, %xmm5
	vmulsd	%xmm3, %xmm5, %xmm3
	vaddsd	%xmm3, %xmm12, %xmm5
	vmulsd	%xmm0, %xmm13, %xmm0
	vmulsd	%xmm3, %xmm0, %xmm0
	vmulsd	%xmm5, %xmm0, %xmm0
	vmulsd	%xmm16, %xmm0, %xmm5
	vmulsd	%xmm1, %xmm0, %xmm6
	vmulsd	%xmm2, %xmm0, %xmm19
	movl	$1, %eax
	movq	%rbx, %rdx
.LBB0_26:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	incq	(%rdx)
	cmpl	%esi, %r14d
	jne	.LBB0_29
.LBB0_28:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	cmpq	$1, %r9
	je	.LBB0_44
.LBB0_29:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vsubsd	8(%rcx), %xmm15, %xmm2
	vsubsd	72(%rcx), %xmm17, %xmm1
	vsubsd	136(%rcx), %xmm18, %xmm0
	vmulsd	%xmm2, %xmm2, %xmm3
	vfmadd231sd	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231sd	%xmm0, %xmm0, %xmm3 # xmm3 = (xmm0 * xmm0) + xmm3
	vucomisd	%xmm14, %xmm3
	jae	.LBB0_30
# %bb.42:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vdivsd	%xmm3, %xmm11, %xmm3
	vmulsd	%xmm20, %xmm3, %xmm4
	vmulsd	%xmm3, %xmm3, %xmm7
	vmulsd	%xmm4, %xmm7, %xmm4
	vaddsd	%xmm4, %xmm12, %xmm7
	vmulsd	%xmm3, %xmm13, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vfmadd231sd	%xmm2, %xmm3, %xmm5 # xmm5 = (xmm3 * xmm2) + xmm5
	vfmadd231sd	%xmm1, %xmm3, %xmm6 # xmm6 = (xmm3 * xmm1) + xmm6
	vfmadd231sd	%xmm0, %xmm3, %xmm19 # xmm19 = (xmm3 * xmm0) + xmm19
	movl	$1, %eax
	movq	%rbx, %rdx
	jmp	.LBB0_43
.LBB0_30:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	movq	%r10, %rdx
.LBB0_43:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	incq	(%rdx)
.LBB0_44:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	cmpl	%esi, %r14d
	jne	.LBB0_46
# %bb.45:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	cmpq	$2, %r9
	je	.LBB0_50
.LBB0_46:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vsubsd	16(%rcx), %xmm15, %xmm2
	vsubsd	80(%rcx), %xmm17, %xmm1
	vsubsd	144(%rcx), %xmm18, %xmm0
	vmulsd	%xmm2, %xmm2, %xmm3
	vfmadd231sd	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231sd	%xmm0, %xmm0, %xmm3 # xmm3 = (xmm0 * xmm0) + xmm3
	vucomisd	%xmm14, %xmm3
	jae	.LBB0_47
# %bb.48:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vdivsd	%xmm3, %xmm11, %xmm3
	vmulsd	%xmm20, %xmm3, %xmm4
	vmulsd	%xmm3, %xmm3, %xmm7
	vmulsd	%xmm4, %xmm7, %xmm4
	vaddsd	%xmm4, %xmm12, %xmm7
	vmulsd	%xmm3, %xmm13, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vfmadd231sd	%xmm2, %xmm3, %xmm5 # xmm5 = (xmm3 * xmm2) + xmm5
	vfmadd231sd	%xmm1, %xmm3, %xmm6 # xmm6 = (xmm3 * xmm1) + xmm6
	vfmadd231sd	%xmm0, %xmm3, %xmm19 # xmm19 = (xmm3 * xmm0) + xmm19
	movl	$1, %eax
	movq	%rbx, %rdx
	jmp	.LBB0_49
.LBB0_47:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	movq	%r10, %rdx
.LBB0_49:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	incq	(%rdx)
.LBB0_50:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	cmpl	%esi, %r14d
	jne	.LBB0_52
# %bb.51:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	cmpq	$3, %r9
	je	.LBB0_56
.LBB0_52:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vsubsd	24(%rcx), %xmm15, %xmm2
	vsubsd	88(%rcx), %xmm17, %xmm1
	vsubsd	152(%rcx), %xmm18, %xmm0
	vmulsd	%xmm2, %xmm2, %xmm3
	vfmadd231sd	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231sd	%xmm0, %xmm0, %xmm3 # xmm3 = (xmm0 * xmm0) + xmm3
	vucomisd	%xmm14, %xmm3
	jae	.LBB0_53
# %bb.54:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vdivsd	%xmm3, %xmm11, %xmm3
	vmulsd	%xmm20, %xmm3, %xmm4
	vmulsd	%xmm3, %xmm3, %xmm7
	vmulsd	%xmm4, %xmm7, %xmm4
	vaddsd	%xmm4, %xmm12, %xmm7
	vmulsd	%xmm3, %xmm13, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vfmadd231sd	%xmm2, %xmm3, %xmm5 # xmm5 = (xmm3 * xmm2) + xmm5
	vfmadd231sd	%xmm1, %xmm3, %xmm6 # xmm6 = (xmm3 * xmm1) + xmm6
	vfmadd231sd	%xmm0, %xmm3, %xmm19 # xmm19 = (xmm3 * xmm0) + xmm19
	movl	$1, %eax
	movq	%rbx, %rdx
	jmp	.LBB0_55
.LBB0_53:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	movq	%r10, %rdx
.LBB0_55:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	incq	(%rdx)
.LBB0_56:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	cmpl	%esi, %r14d
	jne	.LBB0_58
# %bb.57:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	cmpq	$4, %r9
	je	.LBB0_62
.LBB0_58:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vsubsd	32(%rcx), %xmm15, %xmm2
	vsubsd	96(%rcx), %xmm17, %xmm1
	vsubsd	160(%rcx), %xmm18, %xmm0
	vmulsd	%xmm2, %xmm2, %xmm3
	vfmadd231sd	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231sd	%xmm0, %xmm0, %xmm3 # xmm3 = (xmm0 * xmm0) + xmm3
	vucomisd	%xmm14, %xmm3
	jae	.LBB0_59
# %bb.60:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vdivsd	%xmm3, %xmm11, %xmm3
	vmulsd	%xmm20, %xmm3, %xmm4
	vmulsd	%xmm3, %xmm3, %xmm7
	vmulsd	%xmm4, %xmm7, %xmm4
	vaddsd	%xmm4, %xmm12, %xmm7
	vmulsd	%xmm3, %xmm13, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vfmadd231sd	%xmm2, %xmm3, %xmm5 # xmm5 = (xmm3 * xmm2) + xmm5
	vfmadd231sd	%xmm1, %xmm3, %xmm6 # xmm6 = (xmm3 * xmm1) + xmm6
	vfmadd231sd	%xmm0, %xmm3, %xmm19 # xmm19 = (xmm3 * xmm0) + xmm19
	movl	$1, %eax
	movq	%rbx, %rdx
	jmp	.LBB0_61
.LBB0_59:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	movq	%r10, %rdx
.LBB0_61:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	incq	(%rdx)
.LBB0_62:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	cmpl	%esi, %r14d
	jne	.LBB0_64
# %bb.63:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	cmpq	$5, %r9
	je	.LBB0_68
.LBB0_64:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vsubsd	40(%rcx), %xmm15, %xmm2
	vsubsd	104(%rcx), %xmm17, %xmm1
	vsubsd	168(%rcx), %xmm18, %xmm0
	vmulsd	%xmm2, %xmm2, %xmm3
	vfmadd231sd	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231sd	%xmm0, %xmm0, %xmm3 # xmm3 = (xmm0 * xmm0) + xmm3
	vucomisd	%xmm14, %xmm3
	jae	.LBB0_65
# %bb.66:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vdivsd	%xmm3, %xmm11, %xmm3
	vmulsd	%xmm20, %xmm3, %xmm4
	vmulsd	%xmm3, %xmm3, %xmm7
	vmulsd	%xmm4, %xmm7, %xmm4
	vaddsd	%xmm4, %xmm12, %xmm7
	vmulsd	%xmm3, %xmm13, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vfmadd231sd	%xmm2, %xmm3, %xmm5 # xmm5 = (xmm3 * xmm2) + xmm5
	vfmadd231sd	%xmm1, %xmm3, %xmm6 # xmm6 = (xmm3 * xmm1) + xmm6
	vfmadd231sd	%xmm0, %xmm3, %xmm19 # xmm19 = (xmm3 * xmm0) + xmm19
	movl	$1, %eax
	movq	%rbx, %rdx
	jmp	.LBB0_67
.LBB0_65:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	movq	%r10, %rdx
.LBB0_67:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	incq	(%rdx)
.LBB0_68:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	cmpl	%esi, %r14d
	jne	.LBB0_70
# %bb.69:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	cmpq	$6, %r9
	je	.LBB0_74
.LBB0_70:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vsubsd	48(%rcx), %xmm15, %xmm2
	vsubsd	112(%rcx), %xmm17, %xmm1
	vsubsd	176(%rcx), %xmm18, %xmm0
	vmulsd	%xmm2, %xmm2, %xmm3
	vfmadd231sd	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231sd	%xmm0, %xmm0, %xmm3 # xmm3 = (xmm0 * xmm0) + xmm3
	vucomisd	%xmm14, %xmm3
	jae	.LBB0_71
# %bb.72:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vdivsd	%xmm3, %xmm11, %xmm3
	vmulsd	%xmm20, %xmm3, %xmm4
	vmulsd	%xmm3, %xmm3, %xmm7
	vmulsd	%xmm4, %xmm7, %xmm4
	vaddsd	%xmm4, %xmm12, %xmm7
	vmulsd	%xmm3, %xmm13, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vfmadd231sd	%xmm2, %xmm3, %xmm5 # xmm5 = (xmm3 * xmm2) + xmm5
	vfmadd231sd	%xmm1, %xmm3, %xmm6 # xmm6 = (xmm3 * xmm1) + xmm6
	vfmadd231sd	%xmm0, %xmm3, %xmm19 # xmm19 = (xmm3 * xmm0) + xmm19
	movl	$1, %eax
	movq	%rbx, %rdx
	jmp	.LBB0_73
.LBB0_71:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	movq	%r10, %rdx
.LBB0_73:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	incq	(%rdx)
.LBB0_74:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	cmpl	%esi, %r14d
	jne	.LBB0_76
# %bb.75:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	cmpq	$7, %r9
	je	.LBB0_34
.LBB0_76:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vsubsd	56(%rcx), %xmm15, %xmm2
	vsubsd	120(%rcx), %xmm17, %xmm1
	vsubsd	184(%rcx), %xmm18, %xmm0
	vmulsd	%xmm2, %xmm2, %xmm3
	vfmadd231sd	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231sd	%xmm0, %xmm0, %xmm3 # xmm3 = (xmm0 * xmm0) + xmm3
	vucomisd	%xmm14, %xmm3
	jae	.LBB0_77
# %bb.78:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vdivsd	%xmm3, %xmm11, %xmm3
	vmulsd	%xmm20, %xmm3, %xmm4
	vmulsd	%xmm3, %xmm3, %xmm7
	vmulsd	%xmm4, %xmm7, %xmm4
	vaddsd	%xmm4, %xmm12, %xmm7
	vmulsd	%xmm3, %xmm13, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vfmadd231sd	%xmm2, %xmm3, %xmm5 # xmm5 = (xmm3 * xmm2) + xmm5
	vfmadd231sd	%xmm1, %xmm3, %xmm6 # xmm6 = (xmm3 * xmm1) + xmm6
	vfmadd231sd	%xmm0, %xmm3, %xmm19 # xmm19 = (xmm3 * xmm0) + xmm19
	movl	$1, %eax
	movq	%rbx, %rdx
	incq	(%rbx)
	jmp	.LBB0_34
.LBB0_16:                               # 
	movq	16(%rsp), %rax          # 8-byte Reload
	vmovdqu	%xmm10, (%rax)
	movq	%rsi, 16(%rax)
.LBB0_17:                               # 
	movl	$.L.str.1, %edi
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, (%rsp)           # 8-byte Spill
	movl	$.L.str.2, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	(%rsp), %xmm0           # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vsubsd	48(%rsp), %xmm0, %xmm0  # 8-byte Folded Reload
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
.Lfunc_end0:
	.size	computeForceLJ_ref, .Lfunc_end0-computeForceLJ_ref
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3               # -- Begin function computeForceLJ_2xnn_half
.LCPI1_0:
	.quad	4631952216750555136     #  48
.LCPI1_1:
	.quad	-4620693217682128896    #  -0.5
.LCPI1_3:
	.quad	4602678819172646912     #  0.5
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI1_2:
	.quad	1                       # 0x1
	.zero	8
	.text
	.globl	computeForceLJ_2xnn_half
	.p2align	4, 0x90
	.type	computeForceLJ_2xnn_half,@function
computeForceLJ_2xnn_half:               # 
.LcomputeForceLJ_2xnn_half$local:
	.cfi_startproc
# %bb.0:                                # 
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
	movq	%rcx, 56(%rsp)          # 8-byte Spill
	movq	%rdx, 48(%rsp)          # 8-byte Spill
	movq	%rsi, %rbx
	movq	%rdi, %r12
	movl	$.L.str.3, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	144(%r12), %xmm0        # xmm0 = mem[0],zero
	vmovsd	%xmm0, 32(%rsp)         # 8-byte Spill
	vbroadcastsd	56(%r12), %zmm1
	vmovsd	40(%r12), %xmm0         # xmm0 = mem[0],zero
	vmovupd	%zmm0, 64(%rsp)         # 64-byte Spill
	movl	20(%rbx), %r10d
	testl	%r10d, %r10d
	jle	.LBB1_5
# %bb.1:                                # 
	movq	176(%rbx), %r11
	movq	192(%rbx), %r9
	decq	%r10
	leaq	128(%r11), %r8
	xorl	%edi, %edi
	vxorpd	%xmm0, %xmm0, %xmm0
	jmp	.LBB1_2
	.p2align	4, 0x90
.LBB1_28:                               # 
                                        #   in Loop: Header=BB1_2 Depth=1
	cmpq	%r10, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB1_5
.LBB1_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_23 Depth 2
                                        #     Child Loop BB1_27 Depth 2
	imulq	$56, %rdi, %rax
	movl	(%r9,%rax), %eax
	testl	%eax, %eax
	jle	.LBB1_28
# %bb.3:                                # 
                                        #   in Loop: Header=BB1_2 Depth=1
	leal	(,%rdi,4), %ecx
	movl	%ecx, %edx
	andl	$-8, %edx
	leal	(%rdx,%rdx,2), %edx
	andl	$4, %ecx
	orl	%edx, %ecx
	movq	%rax, %rdx
	shrq	$3, %rdx
	movl	%ecx, %esi
	je	.LBB1_4
# %bb.22:                               # 
                                        #   in Loop: Header=BB1_2 Depth=1
	leaq	(%r11,%rsi,8), %rbp
	shlq	$6, %rdx
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB1_23:                               # 
                                        #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%zmm0, (%rbp,%rcx)
	addq	$64, %rcx
	cmpq	%rcx, %rdx
	jne	.LBB1_23
# %bb.24:                               # 
                                        #   in Loop: Header=BB1_2 Depth=1
	movl	%eax, %ebp
	andl	$-8, %ebp
	leaq	(%rsi,%rbp), %rcx
	vmovupd	%zmm0, (%r11,%rcx,8)
	vmovupd	%zmm0, 64(%r11,%rcx,8)
	cmpq	%rax, %rbp
	jae	.LBB1_28
	jmp	.LBB1_26
	.p2align	4, 0x90
.LBB1_4:                                # 
                                        #   in Loop: Header=BB1_2 Depth=1
	movl	%eax, %ebp
	andl	$-8, %ebp
	cmpq	%rax, %rbp
	jae	.LBB1_28
.LBB1_26:                               # 
                                        #   in Loop: Header=BB1_2 Depth=1
	leaq	(%r8,%rsi,8), %rdx
	.p2align	4, 0x90
.LBB1_27:                               # 
                                        #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, -128(%rdx,%rbp,8)
	movq	$0, -64(%rdx,%rbp,8)
	movq	$0, (%rdx,%rbp,8)
	incq	%rbp
	cmpq	%rbp, %rax
	jne	.LBB1_27
	jmp	.LBB1_28
.LBB1_5:                                # 
	xorl	%eax, %eax
	vmovupd	%zmm1, 128(%rsp)        # 64-byte Spill
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 40(%rsp)         # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	vmovupd	128(%rsp), %zmm30       # 64-byte Reload
	cmpl	$0, 20(%rbx)
	jle	.LBB1_15
# %bb.6:                                # 
	vmovsd	32(%rsp), %xmm0         # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm0
	vbroadcastsd	%xmm0, %zmm0
	vmovupd	64(%rsp), %zmm1         # 64-byte Reload
	vmulsd	.LCPI1_0(%rip), %xmm1, %xmm1
	vbroadcastsd	%xmm1, %zmm1
	vbroadcastsd	.LCPI1_1(%rip), %zmm2 # zmm2 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	xorl	%r9d, %r9d
	vmovdqa	.LCPI1_2(%rip), %xmm3   # xmm3 = <1,u>
	vmovsd	.LCPI1_3(%rip), %xmm4   # xmm4 = mem[0],zero
	jmp	.LBB1_7
	.p2align	4, 0x90
.LBB1_14:                               # 
                                        #   in Loop: Header=BB1_7 Depth=1
	vpermpd	$238, %zmm14, %zmm7     # zmm7 = zmm14[2,3,2,3,6,7,6,7]
	vaddpd	%zmm14, %zmm7, %zmm7
	vpermpd	$68, %zmm15, %zmm10     # zmm10 = zmm15[0,1,0,1,4,5,4,5]
	movb	$-52, %al
	kmovd	%eax, %k1
	vaddpd	%zmm15, %zmm10, %zmm7 {%k1}
	vpermilpd	$85, %zmm7, %zmm10 # zmm10 = zmm7[1,0,3,2,5,4,7,6]
	vaddpd	%zmm7, %zmm10, %zmm7
	vextractf64x4	$1, %zmm7, %ymm10
	vblendpd	$10, %ymm10, %ymm7, %ymm7 # ymm7 = ymm7[0],ymm10[1],ymm7[2],ymm10[3]
	vaddpd	(%r11,%r15,8), %ymm7, %ymm7
	vmovapd	%ymm7, (%r11,%r15,8)
	vpermpd	$238, %zmm9, %zmm7      # zmm7 = zmm9[2,3,2,3,6,7,6,7]
	vaddpd	%zmm9, %zmm7, %zmm7
	vpermpd	$68, %zmm8, %zmm9       # zmm9 = zmm8[0,1,0,1,4,5,4,5]
	vaddpd	%zmm8, %zmm9, %zmm7 {%k1}
	vpermilpd	$85, %zmm7, %zmm8 # zmm8 = zmm7[1,0,3,2,5,4,7,6]
	vaddpd	%zmm7, %zmm8, %zmm7
	vextractf64x4	$1, %zmm7, %ymm8
	vblendpd	$10, %ymm8, %ymm7, %ymm7 # ymm7 = ymm7[0],ymm8[1],ymm7[2],ymm8[3]
	vaddpd	64(%r11,%r15,8), %ymm7, %ymm7
	vmovapd	%ymm7, 64(%r11,%r15,8)
	vpermpd	$238, %zmm6, %zmm7      # zmm7 = zmm6[2,3,2,3,6,7,6,7]
	vaddpd	%zmm6, %zmm7, %zmm6
	vpermpd	$68, %zmm5, %zmm7       # zmm7 = zmm5[0,1,0,1,4,5,4,5]
	vaddpd	%zmm5, %zmm7, %zmm6 {%k1}
	vpermilpd	$85, %zmm6, %zmm5 # zmm5 = zmm6[1,0,3,2,5,4,7,6]
	vaddpd	%zmm6, %zmm5, %zmm5
	vextractf64x4	$1, %zmm5, %ymm6
	vblendpd	$10, %ymm6, %ymm5, %ymm5 # ymm5 = ymm5[0],ymm6[1],ymm5[2],ymm6[3]
	vaddpd	128(%r11,%r15,8), %ymm5, %ymm5
	vmovapd	%ymm5, 128(%r11,%r15,8)
	vpinsrq	$1, %r13, %xmm3, %xmm5
	movq	56(%rsp), %rcx          # 8-byte Reload
	vpaddq	(%rcx), %xmm5, %xmm5
	vmovdqu	%xmm5, (%rcx)
	vcvtsi2sd	%r13d, %xmm31, %xmm5
	vmulsd	%xmm4, %xmm5, %xmm5
	vcvttsd2si	%xmm5, %rax
	addq	%rax, 16(%rcx)
	incq	%r9
	movslq	20(%rbx), %rax
	cmpq	%rax, %r9
	jge	.LBB1_15
.LBB1_7:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_17 Depth 2
                                        #     Child Loop BB1_11 Depth 2
	leal	(,%r9,4), %r15d
	movl	%r15d, %ecx
	andl	$-8, %ecx
	leal	(%rcx,%rcx,2), %ecx
	andl	$4, %r15d
	orl	%ecx, %r15d
	movq	160(%rbx), %r14
	movq	176(%rbx), %r11
	movq	48(%rsp), %rax          # 8-byte Reload
	movq	40(%rax), %rdx
	movl	8(%rax), %esi
	movq	16(%rax), %rcx
	movslq	(%rcx,%r9,4), %r13
	movq	24(%rax), %rcx
	vbroadcastsd	(%r14,%r15,8), %zmm5
	movl	(%rcx,%r9,4), %r12d
	vbroadcastsd	8(%r14,%r15,8), %ymm6
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm7
	vbroadcastsd	16(%r14,%r15,8), %zmm5
	vbroadcastsd	24(%r14,%r15,8), %ymm6
	vbroadcastsd	64(%r14,%r15,8), %zmm8
	vbroadcastsd	72(%r14,%r15,8), %ymm9
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm10
	vinsertf64x4	$1, %ymm9, %zmm8, %zmm11
	vbroadcastsd	80(%r14,%r15,8), %zmm5
	vbroadcastsd	88(%r14,%r15,8), %ymm6
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm12
	vbroadcastsd	128(%r14,%r15,8), %zmm5
	vbroadcastsd	136(%r14,%r15,8), %ymm6
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm13
	vbroadcastsd	144(%r14,%r15,8), %zmm5
	vbroadcastsd	152(%r14,%r15,8), %ymm6
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm16
	testl	%r12d, %r12d
	jle	.LBB1_8
# %bb.16:                               # 
                                        #   in Loop: Header=BB1_7 Depth=1
	movl	%esi, 32(%rsp)          # 4-byte Spill
	movl	%esi, %ecx
	imull	%r9d, %ecx
	movslq	%ecx, %rcx
	movq	%rdx, 64(%rsp)          # 8-byte Spill
	leaq	(%rdx,%rcx,4), %r10
	leaq	-1(%r12), %rcx
	vxorpd	%xmm14, %xmm14, %xmm14
	movl	$0, %edi
	vxorpd	%xmm9, %xmm9, %xmm9
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm15, %xmm15, %xmm15
	vxorpd	%xmm8, %xmm8, %xmm8
	vxorpd	%xmm5, %xmm5, %xmm5
	.p2align	4, 0x90
.LBB1_17:                               # 
                                        #   Parent Loop BB1_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%r10,%rdi,4), %r8
	movq	%r8, %rbp
	shlq	$3, %rbp
	leaq	(%rbp,%rbp,2), %rbp
	vbroadcastf64x4	(%r14,%rbp,8), %zmm17 # zmm17 = mem[0,1,2,3,0,1,2,3]
	vbroadcastf64x4	64(%r14,%rbp,8), %zmm18 # zmm18 = mem[0,1,2,3,0,1,2,3]
	vbroadcastf64x4	128(%r14,%rbp,8), %zmm19 # zmm19 = mem[0,1,2,3,0,1,2,3]
	vsubpd	%zmm17, %zmm7, %zmm20
	vsubpd	%zmm18, %zmm11, %zmm21
	vsubpd	%zmm19, %zmm13, %zmm22
	vsubpd	%zmm17, %zmm10, %zmm23
	vsubpd	%zmm18, %zmm12, %zmm24
	vsubpd	%zmm19, %zmm16, %zmm25
	vmulpd	%zmm22, %zmm22, %zmm17
	vfmadd231pd	%zmm21, %zmm21, %zmm17 # zmm17 = (zmm21 * zmm21) + zmm17
	vfmadd231pd	%zmm20, %zmm20, %zmm17 # zmm17 = (zmm20 * zmm20) + zmm17
	vmulpd	%zmm25, %zmm25, %zmm26
	leal	(%r8,%r8), %edx
	xorl	%eax, %eax
	cmpq	%rdx, %r9
	sete	%al
	leal	(%r8,%r8), %edx
	incl	%edx
	xorl	%esi, %esi
	cmpq	%rdx, %r9
	sete	%sil
	shll	$2, %eax
	leal	(%rax,%rsi,2), %edx
	kmovb	248(%rbx,%rdx,4), %k2
	leal	(%rax,%rsi,2), %eax
	incl	%eax
	kmovb	248(%rbx,%rax,4), %k1
	vrcp14pd	%zmm17, %zmm18
	vfmadd231pd	%zmm24, %zmm24, %zmm26 # zmm26 = (zmm24 * zmm24) + zmm26
	vfmadd231pd	%zmm23, %zmm23, %zmm26 # zmm26 = (zmm23 * zmm23) + zmm26
	vrcp14pd	%zmm26, %zmm19
	vmulpd	%zmm30, %zmm18, %zmm27
	vmulpd	%zmm18, %zmm18, %zmm28
	vmulpd	%zmm27, %zmm28, %zmm27
	vmulpd	%zmm30, %zmm19, %zmm28
	vmulpd	%zmm19, %zmm19, %zmm29
	vmulpd	%zmm28, %zmm29, %zmm28
	vaddpd	%zmm2, %zmm27, %zmm29
	vmulpd	%zmm18, %zmm1, %zmm18
	vmulpd	%zmm27, %zmm18, %zmm18
	vmulpd	%zmm29, %zmm18, %zmm27
	vaddpd	%zmm2, %zmm28, %zmm18
	vmulpd	%zmm19, %zmm1, %zmm19
	vmulpd	%zmm28, %zmm19, %zmm19
	vmulpd	%zmm18, %zmm19, %zmm28
	vcmpltpd	%zmm0, %zmm17, %k2 {%k2}
	vmulpd	%zmm20, %zmm27, %zmm17 {%k2} {z}
	vmulpd	%zmm21, %zmm27, %zmm18 {%k2} {z}
	vmulpd	%zmm22, %zmm27, %zmm19 {%k2} {z}
	vcmpltpd	%zmm0, %zmm26, %k1 {%k1}
	vmulpd	%zmm23, %zmm28, %zmm20 {%k1} {z}
	vmulpd	%zmm24, %zmm28, %zmm21 {%k1} {z}
	vmulpd	%zmm25, %zmm28, %zmm22 {%k1} {z}
	movl	4(%rbx), %eax
	sarl	%eax
	cmpl	%eax, %r8d
	jge	.LBB1_19
# %bb.18:                               # 
                                        #   in Loop: Header=BB1_17 Depth=2
	movq	176(%rbx), %rax
	vaddpd	%zmm17, %zmm20, %zmm23
	vextractf64x4	$1, %zmm23, %ymm24
	vaddpd	%ymm23, %ymm24, %ymm23
	vmovapd	(%rax,%rbp,8), %ymm24
	vsubpd	%ymm23, %ymm24, %ymm23
	vmovapd	64(%rax,%rbp,8), %ymm24
	vmovapd	128(%rax,%rbp,8), %ymm25
	vmovapd	%ymm23, (%rax,%rbp,8)
	vaddpd	%zmm18, %zmm21, %zmm23
	vextractf64x4	$1, %zmm23, %ymm26
	vaddpd	%ymm23, %ymm26, %ymm23
	vsubpd	%ymm23, %ymm24, %ymm23
	vmovapd	%ymm23, 64(%rax,%rbp,8)
	vaddpd	%zmm19, %zmm22, %zmm23
	vextractf64x4	$1, %zmm23, %ymm24
	vaddpd	%ymm23, %ymm24, %ymm23
	vsubpd	%ymm23, %ymm25, %ymm23
	vmovapd	%ymm23, 128(%rax,%rbp,8)
.LBB1_19:                               # 
                                        #   in Loop: Header=BB1_17 Depth=2
	vaddpd	%zmm14, %zmm17, %zmm14
	vaddpd	%zmm9, %zmm18, %zmm9
	vaddpd	%zmm6, %zmm19, %zmm6
	vaddpd	%zmm15, %zmm20, %zmm15
	vaddpd	%zmm8, %zmm21, %zmm8
	vaddpd	%zmm5, %zmm22, %zmm5
	cmpq	%rdi, %rcx
	je	.LBB1_20
# %bb.21:                               # 
                                        #   in Loop: Header=BB1_17 Depth=2
	incq	%rdi
	movq	160(%rbx), %r14
	jmp	.LBB1_17
	.p2align	4, 0x90
.LBB1_20:                               # 
                                        #   in Loop: Header=BB1_7 Depth=1
	movq	64(%rsp), %rdx          # 8-byte Reload
	movl	32(%rsp), %esi          # 4-byte Reload
	cmpl	%r13d, %r12d
	jge	.LBB1_14
	jmp	.LBB1_10
	.p2align	4, 0x90
.LBB1_8:                                # 
                                        #   in Loop: Header=BB1_7 Depth=1
	vxorpd	%xmm5, %xmm5, %xmm5
	vxorpd	%xmm8, %xmm8, %xmm8
	vxorpd	%xmm15, %xmm15, %xmm15
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm9, %xmm9, %xmm9
	vxorpd	%xmm14, %xmm14, %xmm14
	cmpl	%r13d, %r12d
	jge	.LBB1_14
.LBB1_10:                               # 
                                        #   in Loop: Header=BB1_7 Depth=1
	movslq	%r12d, %rcx
	imull	%r9d, %esi
	movslq	%esi, %rsi
	leaq	(%rdx,%rsi,4), %rsi
	jmp	.LBB1_11
	.p2align	4, 0x90
.LBB1_13:                               # 
                                        #   in Loop: Header=BB1_11 Depth=2
	vaddpd	%zmm14, %zmm17, %zmm14
	vaddpd	%zmm9, %zmm18, %zmm9
	vaddpd	%zmm6, %zmm19, %zmm6
	vaddpd	%zmm15, %zmm20, %zmm15
	vaddpd	%zmm8, %zmm21, %zmm8
	vaddpd	%zmm5, %zmm22, %zmm5
	incq	%rcx
	cmpq	%rcx, %r13
	je	.LBB1_14
.LBB1_11:                               # 
                                        #   Parent Loop BB1_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%rsi,%rcx,4), %rbp
	movq	%rbp, %rax
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rdi
	movq	160(%rbx), %rax
	vbroadcastf64x4	(%rax,%rdi,8), %zmm17 # zmm17 = mem[0,1,2,3,0,1,2,3]
	vbroadcastf64x4	64(%rax,%rdi,8), %zmm18 # zmm18 = mem[0,1,2,3,0,1,2,3]
	vbroadcastf64x4	128(%rax,%rdi,8), %zmm19 # zmm19 = mem[0,1,2,3,0,1,2,3]
	vsubpd	%zmm17, %zmm7, %zmm20
	vsubpd	%zmm18, %zmm11, %zmm21
	vsubpd	%zmm19, %zmm13, %zmm22
	vsubpd	%zmm17, %zmm10, %zmm23
	vsubpd	%zmm18, %zmm12, %zmm24
	vsubpd	%zmm19, %zmm16, %zmm25
	vmulpd	%zmm22, %zmm22, %zmm17
	vfmadd231pd	%zmm21, %zmm21, %zmm17 # zmm17 = (zmm21 * zmm21) + zmm17
	vfmadd231pd	%zmm20, %zmm20, %zmm17 # zmm17 = (zmm20 * zmm20) + zmm17
	vmulpd	%zmm25, %zmm25, %zmm18
	vfmadd231pd	%zmm24, %zmm24, %zmm18 # zmm18 = (zmm24 * zmm24) + zmm18
	vfmadd231pd	%zmm23, %zmm23, %zmm18 # zmm18 = (zmm23 * zmm23) + zmm18
	vcmpltpd	%zmm0, %zmm17, %k1
	vrcp14pd	%zmm17, %zmm17
	vrcp14pd	%zmm18, %zmm19
	vcmpltpd	%zmm0, %zmm18, %k2
	vmulpd	%zmm30, %zmm17, %zmm18
	vmulpd	%zmm17, %zmm17, %zmm26
	vmulpd	%zmm18, %zmm26, %zmm18
	vmulpd	%zmm30, %zmm19, %zmm26
	vmulpd	%zmm19, %zmm19, %zmm27
	vmulpd	%zmm26, %zmm27, %zmm26
	vaddpd	%zmm2, %zmm18, %zmm27
	vmulpd	%zmm17, %zmm1, %zmm17
	vmulpd	%zmm18, %zmm17, %zmm17
	vmulpd	%zmm27, %zmm17, %zmm27
	vaddpd	%zmm2, %zmm26, %zmm17
	vmulpd	%zmm19, %zmm1, %zmm18
	vmulpd	%zmm26, %zmm18, %zmm18
	vmulpd	%zmm17, %zmm18, %zmm26
	vmulpd	%zmm20, %zmm27, %zmm17 {%k1} {z}
	vmulpd	%zmm21, %zmm27, %zmm18 {%k1} {z}
	vmulpd	%zmm22, %zmm27, %zmm19 {%k1} {z}
	vmulpd	%zmm23, %zmm26, %zmm20 {%k2} {z}
	vmulpd	%zmm24, %zmm26, %zmm21 {%k2} {z}
	vmulpd	%zmm25, %zmm26, %zmm22 {%k2} {z}
	movl	4(%rbx), %eax
	sarl	%eax
	cmpl	%eax, %ebp
	jge	.LBB1_13
# %bb.12:                               # 
                                        #   in Loop: Header=BB1_11 Depth=2
	movq	176(%rbx), %rax
	vaddpd	%zmm17, %zmm20, %zmm23
	vextractf64x4	$1, %zmm23, %ymm24
	vaddpd	%ymm23, %ymm24, %ymm23
	vmovapd	(%rax,%rdi,8), %ymm24
	vsubpd	%ymm23, %ymm24, %ymm23
	vmovapd	64(%rax,%rdi,8), %ymm24
	vmovapd	128(%rax,%rdi,8), %ymm25
	vmovapd	%ymm23, (%rax,%rdi,8)
	vaddpd	%zmm18, %zmm21, %zmm23
	vextractf64x4	$1, %zmm23, %ymm26
	vaddpd	%ymm23, %ymm26, %ymm23
	vsubpd	%ymm23, %ymm24, %ymm23
	vmovapd	%ymm23, 64(%rax,%rdi,8)
	vaddpd	%zmm19, %zmm22, %zmm23
	vextractf64x4	$1, %zmm23, %ymm24
	vaddpd	%ymm23, %ymm24, %ymm23
	vsubpd	%ymm23, %ymm25, %ymm23
	vmovapd	%ymm23, 128(%rax,%rdi,8)
	jmp	.LBB1_13
.LBB1_15:                               # 
	movl	$.L.str.1, %edi
	vzeroupper
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, 64(%rsp)         # 8-byte Spill
	movl	$.L.str.4, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	64(%rsp), %xmm0         # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vsubsd	40(%rsp), %xmm0, %xmm0  # 8-byte Folded Reload
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
	.p2align	3               # -- Begin function computeForceLJ_2xnn_full
.LCPI2_0:
	.quad	4631952216750555136     #  48
.LCPI2_1:
	.quad	-4620693217682128896    #  -0.5
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI2_2:
	.quad	1                       # 0x1
	.zero	8
	.text
	.globl	computeForceLJ_2xnn_full
	.p2align	4, 0x90
	.type	computeForceLJ_2xnn_full,@function
computeForceLJ_2xnn_full:               # 
.LcomputeForceLJ_2xnn_full$local:
	.cfi_startproc
# %bb.0:                                # 
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
	movq	%rcx, 32(%rsp)          # 8-byte Spill
	movq	%rdx, 56(%rsp)          # 8-byte Spill
	movq	%rsi, %r14
	movq	%rdi, %r12
	movl	$.L.str.3, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	144(%r12), %xmm0        # xmm0 = mem[0],zero
	vmovsd	%xmm0, 40(%rsp)         # 8-byte Spill
	vbroadcastsd	56(%r12), %zmm1
	vmovsd	40(%r12), %xmm0         # xmm0 = mem[0],zero
	vmovupd	%zmm0, 64(%rsp)         # 64-byte Spill
	movl	20(%r14), %r10d
	testl	%r10d, %r10d
	jle	.LBB2_5
# %bb.1:                                # 
	movq	176(%r14), %r11
	movq	192(%r14), %r9
	decq	%r10
	leaq	128(%r11), %r8
	xorl	%edi, %edi
	vxorpd	%xmm0, %xmm0, %xmm0
	jmp	.LBB2_2
	.p2align	4, 0x90
.LBB2_22:                               # 
                                        #   in Loop: Header=BB2_2 Depth=1
	cmpq	%r10, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB2_5
.LBB2_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_17 Depth 2
                                        #     Child Loop BB2_21 Depth 2
	imulq	$56, %rdi, %rax
	movl	(%r9,%rax), %ebp
	testl	%ebp, %ebp
	jle	.LBB2_22
# %bb.3:                                # 
                                        #   in Loop: Header=BB2_2 Depth=1
	leal	(,%rdi,4), %eax
	movl	%eax, %ecx
	andl	$-8, %ecx
	leal	(%rcx,%rcx,2), %ecx
	andl	$4, %eax
	orl	%ecx, %eax
	movq	%rbp, %rsi
	shrq	$3, %rsi
	movl	%eax, %edx
	je	.LBB2_4
# %bb.16:                               # 
                                        #   in Loop: Header=BB2_2 Depth=1
	leaq	(%r11,%rdx,8), %rax
	shlq	$6, %rsi
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB2_17:                               # 
                                        #   Parent Loop BB2_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%zmm0, (%rax,%rcx)
	addq	$64, %rcx
	cmpq	%rcx, %rsi
	jne	.LBB2_17
# %bb.18:                               # 
                                        #   in Loop: Header=BB2_2 Depth=1
	movl	%ebp, %esi
	andl	$-8, %esi
	leaq	(%rsi,%rdx), %rax
	vmovupd	%zmm0, (%r11,%rax,8)
	vmovupd	%zmm0, 64(%r11,%rax,8)
	cmpq	%rbp, %rsi
	jae	.LBB2_22
	jmp	.LBB2_20
	.p2align	4, 0x90
.LBB2_4:                                # 
                                        #   in Loop: Header=BB2_2 Depth=1
	movl	%ebp, %esi
	andl	$-8, %esi
	cmpq	%rbp, %rsi
	jae	.LBB2_22
.LBB2_20:                               # 
                                        #   in Loop: Header=BB2_2 Depth=1
	leaq	(%r8,%rdx,8), %rax
	.p2align	4, 0x90
.LBB2_21:                               # 
                                        #   Parent Loop BB2_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, -128(%rax,%rsi,8)
	movq	$0, -64(%rax,%rsi,8)
	movq	$0, (%rax,%rsi,8)
	incq	%rsi
	cmpq	%rsi, %rbp
	jne	.LBB2_21
	jmp	.LBB2_22
.LBB2_5:                                # 
	xorl	%eax, %eax
	vmovupd	%zmm1, 128(%rsp)        # 64-byte Spill
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 48(%rsp)         # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	vmovupd	128(%rsp), %zmm29       # 64-byte Reload
	cmpl	$0, 20(%r14)
	jle	.LBB2_13
# %bb.6:                                # 
	vmovsd	40(%rsp), %xmm0         # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm0
	vbroadcastsd	%xmm0, %zmm0
	vmovupd	64(%rsp), %zmm1         # 64-byte Reload
	vmulsd	.LCPI2_0(%rip), %xmm1, %xmm1
	vbroadcastsd	%xmm1, %zmm1
	xorl	%eax, %eax
	vbroadcastsd	.LCPI2_1(%rip), %zmm2 # zmm2 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vmovdqa	.LCPI2_2(%rip), %xmm3   # xmm3 = <1,u>
	jmp	.LBB2_7
	.p2align	4, 0x90
.LBB2_12:                               # 
                                        #   in Loop: Header=BB2_7 Depth=1
	vpermpd	$238, %zmm14, %zmm6     # zmm6 = zmm14[2,3,2,3,6,7,6,7]
	vaddpd	%zmm14, %zmm6, %zmm6
	vpermpd	$68, %zmm13, %zmm9      # zmm9 = zmm13[0,1,0,1,4,5,4,5]
	movb	$-52, %cl
	kmovd	%ecx, %k1
	vaddpd	%zmm13, %zmm9, %zmm6 {%k1}
	vpermilpd	$85, %zmm6, %zmm9 # zmm9 = zmm6[1,0,3,2,5,4,7,6]
	vaddpd	%zmm6, %zmm9, %zmm6
	vextractf64x4	$1, %zmm6, %ymm9
	vblendpd	$10, %ymm9, %ymm6, %ymm6 # ymm6 = ymm6[0],ymm9[1],ymm6[2],ymm9[3]
	vaddpd	(%r11,%r13,8), %ymm6, %ymm6
	vmovapd	%ymm6, (%r11,%r13,8)
	vpermpd	$238, %zmm8, %zmm6      # zmm6 = zmm8[2,3,2,3,6,7,6,7]
	vaddpd	%zmm8, %zmm6, %zmm6
	vpermpd	$68, %zmm7, %zmm8       # zmm8 = zmm7[0,1,0,1,4,5,4,5]
	vaddpd	%zmm7, %zmm8, %zmm6 {%k1}
	vpermilpd	$85, %zmm6, %zmm7 # zmm7 = zmm6[1,0,3,2,5,4,7,6]
	vaddpd	%zmm6, %zmm7, %zmm6
	vextractf64x4	$1, %zmm6, %ymm7
	vblendpd	$10, %ymm7, %ymm6, %ymm6 # ymm6 = ymm6[0],ymm7[1],ymm6[2],ymm7[3]
	vaddpd	64(%r11,%r13,8), %ymm6, %ymm6
	vmovapd	%ymm6, 64(%r11,%r13,8)
	vpermpd	$238, %zmm5, %zmm6      # zmm6 = zmm5[2,3,2,3,6,7,6,7]
	vaddpd	%zmm5, %zmm6, %zmm5
	vpermpd	$68, %zmm4, %zmm6       # zmm6 = zmm4[0,1,0,1,4,5,4,5]
	vaddpd	%zmm4, %zmm6, %zmm5 {%k1}
	vpermilpd	$85, %zmm5, %zmm4 # zmm4 = zmm5[1,0,3,2,5,4,7,6]
	vaddpd	%zmm5, %zmm4, %zmm4
	vextractf64x4	$1, %zmm4, %ymm5
	vblendpd	$10, %ymm5, %ymm4, %ymm4 # ymm4 = ymm4[0],ymm5[1],ymm4[2],ymm5[3]
	vaddpd	128(%r11,%r13,8), %ymm4, %ymm4
	vmovapd	%ymm4, 128(%r11,%r13,8)
	vpinsrq	$1, %r12, %xmm3, %xmm4
	movq	32(%rsp), %rcx          # 8-byte Reload
	vpaddq	(%rcx), %xmm4, %xmm4
	vmovdqu	%xmm4, (%rcx)
	addq	%r12, 16(%rcx)
	incq	%rax
	movslq	20(%r14), %rcx
	cmpq	%rcx, %rax
	jge	.LBB2_13
.LBB2_7:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_15 Depth 2
                                        #     Child Loop BB2_11 Depth 2
	leal	(,%rax,4), %r13d
	movl	%r13d, %ecx
	andl	$-8, %ecx
	leal	(%rcx,%rcx,2), %ecx
	andl	$4, %r13d
	orl	%ecx, %r13d
	movq	160(%r14), %rcx
	movq	176(%r14), %r11
	movq	56(%rsp), %rsi          # 8-byte Reload
	movq	40(%rsi), %r9
	movl	8(%rsi), %r10d
	movq	16(%rsi), %rdx
	movslq	(%rdx,%rax,4), %r12
	movq	24(%rsi), %rdx
	vbroadcastsd	(%rcx,%r13,8), %zmm4
	movl	(%rdx,%rax,4), %r15d
	vbroadcastsd	8(%rcx,%r13,8), %ymm5
	vinsertf64x4	$1, %ymm5, %zmm4, %zmm6
	vbroadcastsd	16(%rcx,%r13,8), %zmm4
	vbroadcastsd	24(%rcx,%r13,8), %ymm5
	vbroadcastsd	64(%rcx,%r13,8), %zmm7
	vbroadcastsd	72(%rcx,%r13,8), %ymm8
	vinsertf64x4	$1, %ymm5, %zmm4, %zmm9
	vinsertf64x4	$1, %ymm8, %zmm7, %zmm10
	vbroadcastsd	80(%rcx,%r13,8), %zmm4
	vbroadcastsd	88(%rcx,%r13,8), %ymm5
	vinsertf64x4	$1, %ymm5, %zmm4, %zmm11
	vbroadcastsd	128(%rcx,%r13,8), %zmm4
	vbroadcastsd	136(%rcx,%r13,8), %ymm5
	vinsertf64x4	$1, %ymm5, %zmm4, %zmm12
	vbroadcastsd	144(%rcx,%r13,8), %zmm4
	vbroadcastsd	152(%rcx,%r13,8), %ymm5
	vinsertf64x4	$1, %ymm5, %zmm4, %zmm15
	testl	%r15d, %r15d
	jle	.LBB2_8
# %bb.14:                               # 
                                        #   in Loop: Header=BB2_7 Depth=1
	movl	%r10d, %edx
	imull	%eax, %edx
	movslq	%edx, %rdx
	leaq	(%r9,%rdx,4), %rdi
	vxorpd	%xmm14, %xmm14, %xmm14
	movl	$0, %edx
	vxorpd	%xmm8, %xmm8, %xmm8
	vxorpd	%xmm5, %xmm5, %xmm5
	vxorpd	%xmm13, %xmm13, %xmm13
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm4, %xmm4, %xmm4
	.p2align	4, 0x90
.LBB2_15:                               # 
                                        #   Parent Loop BB2_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%rdi,%rdx,4), %rbp
	leaq	(,%rbp,2), %r8
	addq	%rbp, %r8
	shlq	$6, %r8
	vbroadcastf64x4	(%rcx,%r8), %zmm16 # zmm16 = mem[0,1,2,3,0,1,2,3]
	vbroadcastf64x4	128(%rcx,%r8), %zmm19 # zmm19 = mem[0,1,2,3,0,1,2,3]
	vbroadcastf64x4	64(%rcx,%r8), %zmm17 # zmm17 = mem[0,1,2,3,0,1,2,3]
	vsubpd	%zmm16, %zmm6, %zmm20
	vsubpd	%zmm17, %zmm10, %zmm21
	vsubpd	%zmm19, %zmm12, %zmm22
	vsubpd	%zmm16, %zmm9, %zmm18
	vsubpd	%zmm17, %zmm11, %zmm17
	vsubpd	%zmm19, %zmm15, %zmm16
	vmulpd	%zmm22, %zmm22, %zmm19
	vfmadd231pd	%zmm21, %zmm21, %zmm19 # zmm19 = (zmm21 * zmm21) + zmm19
	vmulpd	%zmm16, %zmm16, %zmm23
	vfmadd231pd	%zmm17, %zmm17, %zmm23 # zmm23 = (zmm17 * zmm17) + zmm23
	leal	(%rbp,%rbp), %ebx
	xorl	%esi, %esi
	cmpq	%rbx, %rax
	sete	%sil
	addl	%ebp, %ebp
	incl	%ebp
	xorl	%ebx, %ebx
	cmpq	%rbp, %rax
	sete	%bl
	shll	$2, %esi
	leal	(%rsi,%rbx,2), %ebp
	kmovb	280(%r14,%rbp,4), %k2
	vfmadd231pd	%zmm18, %zmm18, %zmm23 # zmm23 = (zmm18 * zmm18) + zmm23
	leal	(%rsi,%rbx,2), %esi
	incl	%esi
	kmovb	280(%r14,%rsi,4), %k1
	vfmadd231pd	%zmm20, %zmm20, %zmm19 # zmm19 = (zmm20 * zmm20) + zmm19
	vrcp14pd	%zmm19, %zmm24
	vrcp14pd	%zmm23, %zmm25
	vmulpd	%zmm29, %zmm24, %zmm26
	vmulpd	%zmm24, %zmm24, %zmm27
	vmulpd	%zmm26, %zmm27, %zmm26
	vmulpd	%zmm29, %zmm25, %zmm27
	vmulpd	%zmm25, %zmm25, %zmm28
	vmulpd	%zmm27, %zmm28, %zmm27
	vaddpd	%zmm2, %zmm26, %zmm28
	vmulpd	%zmm24, %zmm1, %zmm24
	vmulpd	%zmm26, %zmm24, %zmm24
	vaddpd	%zmm2, %zmm27, %zmm26
	vmulpd	%zmm25, %zmm1, %zmm25
	vmulpd	%zmm28, %zmm24, %zmm24
	vmulpd	%zmm27, %zmm25, %zmm25
	vmulpd	%zmm26, %zmm25, %zmm25
	vcmpltpd	%zmm0, %zmm19, %k2 {%k2}
	vfmadd231pd	%zmm20, %zmm24, %zmm14 {%k2} # zmm14 = (zmm24 * zmm20) + zmm14
	vfmadd231pd	%zmm21, %zmm24, %zmm8 {%k2} # zmm8 = (zmm24 * zmm21) + zmm8
	vfmadd231pd	%zmm22, %zmm24, %zmm5 {%k2} # zmm5 = (zmm24 * zmm22) + zmm5
	vcmpltpd	%zmm0, %zmm23, %k1 {%k1}
	vfmadd231pd	%zmm18, %zmm25, %zmm13 {%k1} # zmm13 = (zmm25 * zmm18) + zmm13
	vfmadd231pd	%zmm17, %zmm25, %zmm7 {%k1} # zmm7 = (zmm25 * zmm17) + zmm7
	vfmadd231pd	%zmm16, %zmm25, %zmm4 {%k1} # zmm4 = (zmm25 * zmm16) + zmm4
	incq	%rdx
	cmpq	%rdx, %r15
	jne	.LBB2_15
# %bb.9:                                # 
                                        #   in Loop: Header=BB2_7 Depth=1
	cmpl	%r12d, %r15d
	jge	.LBB2_12
	jmp	.LBB2_10
	.p2align	4, 0x90
.LBB2_8:                                # 
                                        #   in Loop: Header=BB2_7 Depth=1
	vxorpd	%xmm4, %xmm4, %xmm4
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm13, %xmm13, %xmm13
	vxorpd	%xmm5, %xmm5, %xmm5
	vxorpd	%xmm8, %xmm8, %xmm8
	vxorpd	%xmm14, %xmm14, %xmm14
	cmpl	%r12d, %r15d
	jge	.LBB2_12
.LBB2_10:                               # 
                                        #   in Loop: Header=BB2_7 Depth=1
	movslq	%r15d, %rdx
	imull	%eax, %r10d
	movslq	%r10d, %rsi
	leaq	(%r9,%rsi,4), %rsi
	.p2align	4, 0x90
.LBB2_11:                               # 
                                        #   Parent Loop BB2_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%rsi,%rdx,4), %rdi
	leaq	(%rdi,%rdi,2), %rdi
	shlq	$6, %rdi
	vbroadcastf64x4	(%rcx,%rdi), %zmm16 # zmm16 = mem[0,1,2,3,0,1,2,3]
	vbroadcastf64x4	128(%rcx,%rdi), %zmm17 # zmm17 = mem[0,1,2,3,0,1,2,3]
	vbroadcastf64x4	64(%rcx,%rdi), %zmm18 # zmm18 = mem[0,1,2,3,0,1,2,3]
	vsubpd	%zmm16, %zmm6, %zmm19
	vsubpd	%zmm18, %zmm10, %zmm20
	vsubpd	%zmm17, %zmm12, %zmm21
	vsubpd	%zmm16, %zmm9, %zmm16
	vsubpd	%zmm17, %zmm15, %zmm17
	vsubpd	%zmm18, %zmm11, %zmm18
	vmulpd	%zmm21, %zmm21, %zmm22
	vfmadd231pd	%zmm20, %zmm20, %zmm22 # zmm22 = (zmm20 * zmm20) + zmm22
	vfmadd231pd	%zmm19, %zmm19, %zmm22 # zmm22 = (zmm19 * zmm19) + zmm22
	vmulpd	%zmm17, %zmm17, %zmm23
	vfmadd231pd	%zmm18, %zmm18, %zmm23 # zmm23 = (zmm18 * zmm18) + zmm23
	vfmadd231pd	%zmm16, %zmm16, %zmm23 # zmm23 = (zmm16 * zmm16) + zmm23
	vrcp14pd	%zmm22, %zmm24
	vrcp14pd	%zmm23, %zmm25
	vcmpltpd	%zmm0, %zmm22, %k2
	vcmpltpd	%zmm0, %zmm23, %k1
	vmulpd	%zmm29, %zmm24, %zmm22
	vmulpd	%zmm24, %zmm24, %zmm23
	vmulpd	%zmm29, %zmm25, %zmm26
	vmulpd	%zmm22, %zmm23, %zmm22
	vmulpd	%zmm25, %zmm25, %zmm23
	vmulpd	%zmm26, %zmm23, %zmm23
	vaddpd	%zmm2, %zmm22, %zmm26
	vmulpd	%zmm24, %zmm1, %zmm24
	vmulpd	%zmm22, %zmm24, %zmm22
	vmulpd	%zmm26, %zmm22, %zmm22
	vaddpd	%zmm2, %zmm23, %zmm24
	vmulpd	%zmm25, %zmm1, %zmm25
	vmulpd	%zmm23, %zmm25, %zmm23
	vmulpd	%zmm24, %zmm23, %zmm23
	vfmadd231pd	%zmm19, %zmm22, %zmm14 {%k2} # zmm14 = (zmm22 * zmm19) + zmm14
	vfmadd231pd	%zmm20, %zmm22, %zmm8 {%k2} # zmm8 = (zmm22 * zmm20) + zmm8
	vfmadd231pd	%zmm21, %zmm22, %zmm5 {%k2} # zmm5 = (zmm22 * zmm21) + zmm5
	vfmadd231pd	%zmm16, %zmm23, %zmm13 {%k1} # zmm13 = (zmm23 * zmm16) + zmm13
	vfmadd231pd	%zmm18, %zmm23, %zmm7 {%k1} # zmm7 = (zmm23 * zmm18) + zmm7
	vfmadd231pd	%zmm17, %zmm23, %zmm4 {%k1} # zmm4 = (zmm23 * zmm17) + zmm4
	incq	%rdx
	cmpq	%rdx, %r12
	jne	.LBB2_11
	jmp	.LBB2_12
.LBB2_13:                               # 
	movl	$.L.str.1, %edi
	vzeroupper
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, 32(%rsp)         # 8-byte Spill
	movl	$.L.str.4, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	32(%rsp), %xmm0         # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vsubsd	48(%rsp), %xmm0, %xmm0  # 8-byte Folded Reload
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
.Lfunc_end2:
	.size	computeForceLJ_2xnn_full, .Lfunc_end2-computeForceLJ_2xnn_full
	.cfi_endproc
                                        # -- End function
	.globl	computeForceLJ_2xnn     # -- Begin function computeForceLJ_2xnn
	.p2align	4, 0x90
	.type	computeForceLJ_2xnn,@function
computeForceLJ_2xnn:                    # 
.LcomputeForceLJ_2xnn$local:
	.cfi_startproc
# %bb.0:                                # 
	cmpl	$0, 32(%rdx)
	je	.LBB3_2
# %bb.1:                                # 
	jmp	.LcomputeForceLJ_2xnn_half$local # TAILCALL
.LBB3_2:                                # 
	jmp	.LcomputeForceLJ_2xnn_full$local # TAILCALL
.Lfunc_end3:
	.size	computeForceLJ_2xnn, .Lfunc_end3-computeForceLJ_2xnn
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3               # -- Begin function computeForceLJ_4xn_half
.LCPI4_0:
	.quad	4631952216750555136     #  48
.LCPI4_1:
	.quad	-4620693217682128896    #  -0.5
.LCPI4_3:
	.quad	4602678819172646912     #  0.5
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI4_2:
	.quad	1                       # 0x1
	.zero	8
	.text
	.globl	computeForceLJ_4xn_half
	.p2align	4, 0x90
	.type	computeForceLJ_4xn_half,@function
computeForceLJ_4xn_half:                # 
.LcomputeForceLJ_4xn_half$local:
	.cfi_startproc
# %bb.0:                                # 
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
	subq	$1416, %rsp             # imm = 0x588
	.cfi_def_cfa_offset 1472
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rcx, 40(%rsp)          # 8-byte Spill
	movq	%rdx, 32(%rsp)          # 8-byte Spill
	movq	%rsi, %rbx
	movq	%rdi, %r12
	movl	$.L.str.5, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	144(%r12), %xmm0        # xmm0 = mem[0],zero
	vmovsd	%xmm0, 128(%rsp)        # 8-byte Spill
	vbroadcastsd	56(%r12), %zmm0
	vmovups	%zmm0, 320(%rsp)        # 64-byte Spill
	vmovsd	40(%r12), %xmm0         # xmm0 = mem[0],zero
	vmovupd	%zmm0, 64(%rsp)         # 64-byte Spill
	movl	20(%rbx), %r10d
	testl	%r10d, %r10d
	jle	.LBB4_5
# %bb.1:                                # 
	movq	176(%rbx), %r11
	movq	192(%rbx), %r9
	decq	%r10
	leaq	128(%r11), %r8
	xorl	%edi, %edi
	vxorpd	%xmm0, %xmm0, %xmm0
	jmp	.LBB4_2
	.p2align	4, 0x90
.LBB4_28:                               # 
                                        #   in Loop: Header=BB4_2 Depth=1
	cmpq	%r10, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB4_5
.LBB4_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_23 Depth 2
                                        #     Child Loop BB4_27 Depth 2
	imulq	$56, %rdi, %rax
	movl	(%r9,%rax), %eax
	testl	%eax, %eax
	jle	.LBB4_28
# %bb.3:                                # 
                                        #   in Loop: Header=BB4_2 Depth=1
	leal	(,%rdi,4), %ecx
	movl	%ecx, %edx
	andl	$-8, %edx
	leal	(%rdx,%rdx,2), %edx
	andl	$4, %ecx
	orl	%edx, %ecx
	movq	%rax, %rdx
	shrq	$3, %rdx
	movl	%ecx, %esi
	je	.LBB4_4
# %bb.22:                               # 
                                        #   in Loop: Header=BB4_2 Depth=1
	leaq	(%r11,%rsi,8), %rbp
	shlq	$6, %rdx
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB4_23:                               # 
                                        #   Parent Loop BB4_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%zmm0, (%rbp,%rcx)
	addq	$64, %rcx
	cmpq	%rcx, %rdx
	jne	.LBB4_23
# %bb.24:                               # 
                                        #   in Loop: Header=BB4_2 Depth=1
	movl	%eax, %ebp
	andl	$-8, %ebp
	leaq	(%rsi,%rbp), %rcx
	vmovupd	%zmm0, (%r11,%rcx,8)
	vmovupd	%zmm0, 64(%r11,%rcx,8)
	cmpq	%rax, %rbp
	jae	.LBB4_28
	jmp	.LBB4_26
	.p2align	4, 0x90
.LBB4_4:                                # 
                                        #   in Loop: Header=BB4_2 Depth=1
	movl	%eax, %ebp
	andl	$-8, %ebp
	cmpq	%rax, %rbp
	jae	.LBB4_28
.LBB4_26:                               # 
                                        #   in Loop: Header=BB4_2 Depth=1
	leaq	(%r8,%rsi,8), %rdx
	.p2align	4, 0x90
.LBB4_27:                               # 
                                        #   Parent Loop BB4_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, -128(%rdx,%rbp,8)
	movq	$0, -64(%rdx,%rbp,8)
	movq	$0, (%rdx,%rbp,8)
	incq	%rbp
	cmpq	%rbp, %rax
	jne	.LBB4_27
	jmp	.LBB4_28
.LBB4_5:                                # 
	xorl	%eax, %eax
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 24(%rsp)         # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	cmpl	$0, 20(%rbx)
	jle	.LBB4_15
# %bb.6:                                # 
	vmovsd	128(%rsp), %xmm0        # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm0
	vbroadcastsd	%xmm0, %zmm0
	vmovupd	%zmm0, 256(%rsp)        # 64-byte Spill
	vmovupd	64(%rsp), %zmm0         # 64-byte Reload
	vmulsd	.LCPI4_0(%rip), %xmm0, %xmm1
	vbroadcastsd	%xmm1, %zmm0
	vmovupd	%zmm0, 192(%rsp)        # 64-byte Spill
	xorl	%r8d, %r8d
	jmp	.LBB4_7
	.p2align	4, 0x90
.LBB4_14:                               # 
                                        #   in Loop: Header=BB4_7 Depth=1
	vpermilpd	$85, %zmm19, %zmm0 # zmm0 = zmm19[1,0,3,2,5,4,7,6]
	vaddpd	%zmm19, %zmm0, %zmm0
	vpermilpd	$85, %zmm24, %zmm1 # zmm1 = zmm24[1,0,3,2,5,4,7,6]
	vaddpd	%zmm24, %zmm1, %zmm1
	vmovddup	%zmm21, %zmm2   # zmm2 = zmm21[0,0,2,2,4,4,6,6]
	vaddpd	%zmm21, %zmm2, %zmm2
	vshufpd	$170, %zmm2, %zmm0, %zmm0 # zmm0 = zmm0[0],zmm2[1],zmm0[2],zmm2[3],zmm0[4],zmm2[5],zmm0[6],zmm2[7]
	vmovddup	%zmm16, %zmm2   # zmm2 = zmm16[0,0,2,2,4,4,6,6]
	vaddpd	%zmm16, %zmm2, %zmm2
	vshufpd	$170, %zmm2, %zmm1, %zmm1 # zmm1 = zmm1[0],zmm2[1],zmm1[2],zmm2[3],zmm1[4],zmm2[5],zmm1[6],zmm2[7]
	vextractf64x4	$1, %zmm0, %ymm2
	vaddpd	%zmm0, %zmm2, %zmm0
	vinsertf64x4	$1, %ymm1, %zmm0, %zmm2
	vaddpd	%zmm1, %zmm2, %zmm1
	vshuff64x2	$228, %zmm1, %zmm0, %zmm0 # zmm0 = zmm0[0,1,2,3],zmm1[4,5,6,7]
	vpermpd	$78, %zmm0, %zmm1       # zmm1 = zmm0[2,3,0,1,6,7,4,5]
	vaddpd	%zmm0, %zmm1, %zmm0
	vextractf64x4	$1, %zmm0, %ymm1
	vblendpd	$12, %ymm1, %ymm0, %ymm0 # ymm0 = ymm0[0,1],ymm1[2,3]
	vaddpd	(%rbp,%r13,8), %ymm0, %ymm0
	vmovapd	%ymm0, (%rbp,%r13,8)
	vpermilpd	$85, %zmm12, %zmm0 # zmm0 = zmm12[1,0,3,2,5,4,7,6]
	vaddpd	%zmm12, %zmm0, %zmm0
	vpermilpd	$85, %zmm11, %zmm1 # zmm1 = zmm11[1,0,3,2,5,4,7,6]
	vaddpd	%zmm11, %zmm1, %zmm1
	vmovddup	%zmm5, %zmm2    # zmm2 = zmm5[0,0,2,2,4,4,6,6]
	vaddpd	%zmm5, %zmm2, %zmm2
	vshufpd	$170, %zmm2, %zmm0, %zmm0 # zmm0 = zmm0[0],zmm2[1],zmm0[2],zmm2[3],zmm0[4],zmm2[5],zmm0[6],zmm2[7]
	vmovddup	%zmm3, %zmm2    # zmm2 = zmm3[0,0,2,2,4,4,6,6]
	vaddpd	%zmm3, %zmm2, %zmm2
	vshufpd	$170, %zmm2, %zmm1, %zmm1 # zmm1 = zmm1[0],zmm2[1],zmm1[2],zmm2[3],zmm1[4],zmm2[5],zmm1[6],zmm2[7]
	vextractf64x4	$1, %zmm0, %ymm2
	vaddpd	%zmm0, %zmm2, %zmm0
	vinsertf64x4	$1, %ymm1, %zmm0, %zmm2
	vaddpd	%zmm1, %zmm2, %zmm1
	vshuff64x2	$228, %zmm1, %zmm0, %zmm0 # zmm0 = zmm0[0,1,2,3],zmm1[4,5,6,7]
	vpermpd	$78, %zmm0, %zmm1       # zmm1 = zmm0[2,3,0,1,6,7,4,5]
	vaddpd	%zmm0, %zmm1, %zmm0
	vextractf64x4	$1, %zmm0, %ymm1
	vblendpd	$12, %ymm1, %ymm0, %ymm0 # ymm0 = ymm0[0,1],ymm1[2,3]
	vaddpd	64(%rbp,%r13,8), %ymm0, %ymm0
	vmovapd	%ymm0, 64(%rbp,%r13,8)
	vpermilpd	$85, %zmm28, %zmm0 # zmm0 = zmm28[1,0,3,2,5,4,7,6]
	vaddpd	%zmm28, %zmm0, %zmm0
	vpermilpd	$85, %zmm27, %zmm1 # zmm1 = zmm27[1,0,3,2,5,4,7,6]
	vaddpd	%zmm27, %zmm1, %zmm1
	vmovddup	%zmm26, %zmm2   # zmm2 = zmm26[0,0,2,2,4,4,6,6]
	vaddpd	%zmm26, %zmm2, %zmm2
	vshufpd	$170, %zmm2, %zmm0, %zmm0 # zmm0 = zmm0[0],zmm2[1],zmm0[2],zmm2[3],zmm0[4],zmm2[5],zmm0[6],zmm2[7]
	vmovddup	%zmm25, %zmm2   # zmm2 = zmm25[0,0,2,2,4,4,6,6]
	vaddpd	%zmm25, %zmm2, %zmm2
	vshufpd	$170, %zmm2, %zmm1, %zmm1 # zmm1 = zmm1[0],zmm2[1],zmm1[2],zmm2[3],zmm1[4],zmm2[5],zmm1[6],zmm2[7]
	vextractf64x4	$1, %zmm0, %ymm2
	vaddpd	%zmm0, %zmm2, %zmm0
	vinsertf64x4	$1, %ymm1, %zmm0, %zmm2
	vaddpd	%zmm1, %zmm2, %zmm1
	vshuff64x2	$228, %zmm1, %zmm0, %zmm0 # zmm0 = zmm0[0,1,2,3],zmm1[4,5,6,7]
	vpermpd	$78, %zmm0, %zmm1       # zmm1 = zmm0[2,3,0,1,6,7,4,5]
	vaddpd	%zmm0, %zmm1, %zmm0
	vextractf64x4	$1, %zmm0, %ymm1
	vblendpd	$12, %ymm1, %ymm0, %ymm0 # ymm0 = ymm0[0,1],ymm1[2,3]
	vaddpd	128(%rbp,%r13,8), %ymm0, %ymm0
	vmovapd	%ymm0, 128(%rbp,%r13,8)
	vmovdqa	.LCPI4_2(%rip), %xmm0   # xmm0 = <1,u>
	vpinsrq	$1, %r12, %xmm0, %xmm0
	movq	40(%rsp), %rcx          # 8-byte Reload
	vpaddq	(%rcx), %xmm0, %xmm0
	vmovdqu	%xmm0, (%rcx)
	vxorps	%xmm7, %xmm7, %xmm7
	vcvtsi2sd	%r12d, %xmm7, %xmm0
	vmulsd	.LCPI4_3(%rip), %xmm0, %xmm0
	vcvttsd2si	%xmm0, %rax
	addq	%rax, 16(%rcx)
	incq	%r8
	movslq	20(%rbx), %rax
	cmpq	%rax, %r8
	jge	.LBB4_15
.LBB4_7:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_17 Depth 2
                                        #     Child Loop BB4_11 Depth 2
	leal	(,%r8,4), %r13d
	movl	%r13d, %ecx
	andl	$-8, %ecx
	leal	(%rcx,%rcx,2), %ecx
	andl	$4, %r13d
	orl	%ecx, %r13d
	movq	160(%rbx), %r15
	movq	176(%rbx), %rbp
	movq	32(%rsp), %rax          # 8-byte Reload
	movq	40(%rax), %rsi
	movl	8(%rax), %edx
	movq	16(%rax), %rcx
	movslq	(%rcx,%r8,4), %r12
	movq	24(%rax), %rcx
	vbroadcastsd	(%r15,%r13,8), %zmm0
	vmovups	%zmm0, 1088(%rsp)       # 64-byte Spill
	vbroadcastsd	8(%r15,%r13,8), %zmm0
	vmovups	%zmm0, 1024(%rsp)       # 64-byte Spill
	vbroadcastsd	16(%r15,%r13,8), %zmm0
	vmovups	%zmm0, 960(%rsp)        # 64-byte Spill
	vbroadcastsd	24(%r15,%r13,8), %zmm0
	vmovups	%zmm0, 896(%rsp)        # 64-byte Spill
	vbroadcastsd	64(%r15,%r13,8), %zmm0
	vmovups	%zmm0, 832(%rsp)        # 64-byte Spill
	vbroadcastsd	72(%r15,%r13,8), %zmm0
	vmovups	%zmm0, 768(%rsp)        # 64-byte Spill
	vbroadcastsd	80(%r15,%r13,8), %zmm0
	vmovups	%zmm0, 704(%rsp)        # 64-byte Spill
	vbroadcastsd	88(%r15,%r13,8), %zmm0
	vmovups	%zmm0, 640(%rsp)        # 64-byte Spill
	vbroadcastsd	128(%r15,%r13,8), %zmm0
	vmovups	%zmm0, 576(%rsp)        # 64-byte Spill
	vbroadcastsd	136(%r15,%r13,8), %zmm0
	vmovups	%zmm0, 512(%rsp)        # 64-byte Spill
	movl	(%rcx,%r8,4), %r11d
	vbroadcastsd	144(%r15,%r13,8), %zmm0
	vmovups	%zmm0, 448(%rsp)        # 64-byte Spill
	vbroadcastsd	152(%r15,%r13,8), %zmm0
	vmovupd	%zmm0, 384(%rsp)        # 64-byte Spill
	testl	%r11d, %r11d
	jle	.LBB4_8
# %bb.16:                               # 
                                        #   in Loop: Header=BB4_7 Depth=1
	movl	%edx, 20(%rsp)          # 4-byte Spill
	movl	%edx, %ecx
	imull	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	%rsi, 48(%rsp)          # 8-byte Spill
	leaq	(%rsi,%rcx,4), %r9
	leaq	-1(%r11), %r10
	vxorpd	%xmm19, %xmm19, %xmm19
	movq	%rbp, 56(%rsp)          # 8-byte Spill
	movq	%rbp, %rcx
	movl	$0, %esi
	vxorpd	%xmm12, %xmm12, %xmm12
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%zmm0, 1152(%rsp)       # 64-byte Spill
	vxorpd	%xmm21, %xmm21, %xmm21
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%zmm0, 128(%rsp)        # 64-byte Spill
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%zmm0, 1280(%rsp)       # 64-byte Spill
	vxorpd	%xmm24, %xmm24, %xmm24
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%zmm0, 1216(%rsp)       # 64-byte Spill
	vxorpd	%xmm16, %xmm16, %xmm16
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%zmm0, 64(%rsp)         # 64-byte Spill
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%zmm0, 1344(%rsp)       # 64-byte Spill
	.p2align	4, 0x90
.LBB4_17:                               # 
                                        #   Parent Loop BB4_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%r9,%rsi,4), %r14
	movq	%r14, %rbp
	shlq	$3, %rbp
	leaq	(%rbp,%rbp,2), %rbp
	vmovapd	(%r15,%rbp,8), %zmm13
	vmovapd	64(%r15,%rbp,8), %zmm17
	vmovapd	128(%r15,%rbp,8), %zmm22
	vmovupd	1088(%rsp), %zmm0       # 64-byte Reload
	vsubpd	%zmm13, %zmm0, %zmm29
	vmovupd	832(%rsp), %zmm0        # 64-byte Reload
	vsubpd	%zmm17, %zmm0, %zmm30
	vmovupd	576(%rsp), %zmm0        # 64-byte Reload
	vsubpd	%zmm22, %zmm0, %zmm31
	vmovupd	1024(%rsp), %zmm0       # 64-byte Reload
	vsubpd	%zmm13, %zmm0, %zmm3
	vmovupd	768(%rsp), %zmm0        # 64-byte Reload
	vsubpd	%zmm17, %zmm0, %zmm14
	vmovupd	512(%rsp), %zmm0        # 64-byte Reload
	vsubpd	%zmm22, %zmm0, %zmm18
	vmovupd	960(%rsp), %zmm0        # 64-byte Reload
	vsubpd	%zmm13, %zmm0, %zmm4
	vmovupd	704(%rsp), %zmm0        # 64-byte Reload
	vsubpd	%zmm17, %zmm0, %zmm15
	vmovupd	448(%rsp), %zmm0        # 64-byte Reload
	vsubpd	%zmm22, %zmm0, %zmm20
	vmovupd	896(%rsp), %zmm0        # 64-byte Reload
	vsubpd	%zmm13, %zmm0, %zmm13
	vmovupd	640(%rsp), %zmm0        # 64-byte Reload
	vsubpd	%zmm17, %zmm0, %zmm17
	vmovupd	384(%rsp), %zmm0        # 64-byte Reload
	vsubpd	%zmm22, %zmm0, %zmm22
	vmulpd	%zmm31, %zmm31, %zmm23
	vfmadd231pd	%zmm30, %zmm30, %zmm23 # zmm23 = (zmm30 * zmm30) + zmm23
	vfmadd231pd	%zmm29, %zmm29, %zmm23 # zmm23 = (zmm29 * zmm29) + zmm23
	vmulpd	%zmm18, %zmm18, %zmm26
	vfmadd231pd	%zmm14, %zmm14, %zmm26 # zmm26 = (zmm14 * zmm14) + zmm26
	vfmadd231pd	%zmm3, %zmm3, %zmm26 # zmm26 = (zmm3 * zmm3) + zmm26
	vmulpd	%zmm20, %zmm20, %zmm27
	vfmadd231pd	%zmm15, %zmm15, %zmm27 # zmm27 = (zmm15 * zmm15) + zmm27
	vfmadd231pd	%zmm4, %zmm4, %zmm27 # zmm27 = (zmm4 * zmm4) + zmm27
	vmulpd	%zmm22, %zmm22, %zmm28
	vfmadd231pd	%zmm17, %zmm17, %zmm28 # zmm28 = (zmm17 * zmm17) + zmm28
	vfmadd231pd	%zmm13, %zmm13, %zmm28 # zmm28 = (zmm13 * zmm13) + zmm28
	vrcp14pd	%zmm23, %zmm25
	vrcp14pd	%zmm26, %zmm2
	vrcp14pd	%zmm27, %zmm0
	vrcp14pd	%zmm28, %zmm1
	vmovupd	320(%rsp), %zmm9        # 64-byte Reload
	vmulpd	%zmm9, %zmm25, %zmm5
	vmulpd	%zmm25, %zmm25, %zmm6
	vmulpd	%zmm5, %zmm6, %zmm5
	vmulpd	%zmm9, %zmm2, %zmm6
	vmulpd	%zmm2, %zmm2, %zmm7
	vmulpd	%zmm6, %zmm7, %zmm6
	vmulpd	%zmm9, %zmm0, %zmm7
	vmulpd	%zmm0, %zmm0, %zmm8
	vmulpd	%zmm7, %zmm8, %zmm7
	vmulpd	%zmm9, %zmm1, %zmm8
	vmulpd	%zmm1, %zmm1, %zmm9
	vmulpd	%zmm8, %zmm9, %zmm8
	vmovupd	192(%rsp), %zmm10       # 64-byte Reload
	vmulpd	%zmm25, %zmm10, %zmm9
	vmulpd	%zmm5, %zmm9, %zmm9
	vbroadcastsd	.LCPI4_1(%rip), %zmm25 # zmm25 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vaddpd	%zmm25, %zmm5, %zmm5
	vmulpd	%zmm5, %zmm9, %zmm5
	vmulpd	%zmm2, %zmm10, %zmm2
	vmulpd	%zmm6, %zmm2, %zmm2
	vaddpd	%zmm25, %zmm6, %zmm6
	vmulpd	%zmm6, %zmm2, %zmm2
	vmulpd	%zmm0, %zmm10, %zmm0
	vmulpd	%zmm7, %zmm0, %zmm0
	vaddpd	%zmm25, %zmm7, %zmm6
	vmulpd	%zmm6, %zmm0, %zmm0
	vmulpd	%zmm1, %zmm10, %zmm1
	vmulpd	%zmm8, %zmm1, %zmm1
	vaddpd	%zmm25, %zmm8, %zmm6
	vmulpd	%zmm6, %zmm1, %zmm1
	leal	(%r14,%r14), %eax
	xorl	%edx, %edx
	cmpq	%rax, %r8
	sete	%dl
	leal	(%r14,%r14), %eax
	incl	%eax
	xorl	%edi, %edi
	cmpq	%rax, %r8
	sete	%dil
	shll	$3, %edx
	leal	(%rdx,%rdi,4), %eax
	kmovb	312(%rbx,%rax,4), %k1
	vmovupd	256(%rsp), %zmm6        # 64-byte Reload
	vcmpltpd	%zmm6, %zmm23, %k1 {%k1}
	leal	1(%rdx,%rdi,4), %eax
	kmovb	312(%rbx,%rax,4), %k2
	vmulpd	%zmm29, %zmm5, %zmm25 {%k1} {z}
	vmulpd	%zmm30, %zmm5, %zmm23 {%k1} {z}
	vmulpd	%zmm31, %zmm5, %zmm29 {%k1} {z}
	vcmpltpd	%zmm6, %zmm26, %k1 {%k2}
	vmulpd	%zmm3, %zmm2, %zmm30 {%k1} {z}
	vmulpd	%zmm14, %zmm2, %zmm14 {%k1} {z}
	vmulpd	%zmm18, %zmm2, %zmm3 {%k1} {z}
	leal	2(%rdx,%rdi,4), %eax
	kmovb	312(%rbx,%rax,4), %k1
	vcmpltpd	%zmm6, %zmm27, %k1 {%k1}
	vmulpd	%zmm4, %zmm0, %zmm18 {%k1} {z}
	vmulpd	%zmm15, %zmm0, %zmm15 {%k1} {z}
	vmulpd	%zmm20, %zmm0, %zmm4 {%k1} {z}
	leal	3(%rdx,%rdi,4), %eax
	kmovb	312(%rbx,%rax,4), %k1
	vcmpltpd	%zmm6, %zmm28, %k1 {%k1}
	vmulpd	%zmm13, %zmm1, %zmm20 {%k1} {z}
	vmulpd	%zmm17, %zmm1, %zmm17 {%k1} {z}
	vmulpd	%zmm22, %zmm1, %zmm13 {%k1} {z}
	movl	4(%rbx), %eax
	sarl	%eax
	cmpl	%eax, %r14d
	jge	.LBB4_19
# %bb.18:                               # 
                                        #   in Loop: Header=BB4_17 Depth=2
	vmovapd	64(%rcx,%rbp,8), %zmm0
	vmovapd	128(%rcx,%rbp,8), %zmm1
	vaddpd	%zmm30, %zmm25, %zmm2
	vaddpd	%zmm18, %zmm20, %zmm5
	vsubpd	(%rcx,%rbp,8), %zmm2, %zmm2
	vaddpd	%zmm5, %zmm2, %zmm2
	vxorpd	%xmm5, %xmm5, %xmm5
	vsubpd	%zmm2, %zmm5, %zmm2
	vmovapd	%zmm2, (%rcx,%rbp,8)
	vaddpd	%zmm14, %zmm23, %zmm2
	vsubpd	%zmm0, %zmm2, %zmm0
	vaddpd	%zmm15, %zmm17, %zmm2
	vaddpd	%zmm2, %zmm0, %zmm0
	vsubpd	%zmm0, %zmm5, %zmm0
	vmovapd	%zmm0, 64(%rcx,%rbp,8)
	vaddpd	%zmm3, %zmm29, %zmm0
	vsubpd	%zmm1, %zmm0, %zmm0
	vaddpd	%zmm4, %zmm13, %zmm1
	vaddpd	%zmm1, %zmm0, %zmm0
	vsubpd	%zmm0, %zmm5, %zmm0
	vmovapd	%zmm0, 128(%rcx,%rbp,8)
.LBB4_19:                               # 
                                        #   in Loop: Header=BB4_17 Depth=2
	vaddpd	%zmm19, %zmm25, %zmm19
	vaddpd	%zmm12, %zmm23, %zmm12
	vmovupd	1152(%rsp), %zmm28      # 64-byte Reload
	vaddpd	%zmm28, %zmm29, %zmm28
	vaddpd	%zmm21, %zmm30, %zmm21
	vmovupd	128(%rsp), %zmm5        # 64-byte Reload
	vaddpd	%zmm5, %zmm14, %zmm5
	vmovupd	1280(%rsp), %zmm26      # 64-byte Reload
	vaddpd	%zmm26, %zmm3, %zmm26
	vaddpd	%zmm24, %zmm18, %zmm24
	vaddpd	%zmm11, %zmm15, %zmm11
	vmovupd	1216(%rsp), %zmm27      # 64-byte Reload
	vaddpd	%zmm27, %zmm4, %zmm27
	vaddpd	%zmm16, %zmm20, %zmm16
	vmovupd	64(%rsp), %zmm3         # 64-byte Reload
	vaddpd	%zmm3, %zmm17, %zmm3
	vmovupd	1344(%rsp), %zmm25      # 64-byte Reload
	vaddpd	%zmm25, %zmm13, %zmm25
	cmpq	%rsi, %r10
	je	.LBB4_20
# %bb.21:                               # 
                                        #   in Loop: Header=BB4_17 Depth=2
	vmovupd	%zmm5, 128(%rsp)        # 64-byte Spill
	vmovupd	%zmm3, 64(%rsp)         # 64-byte Spill
	vmovupd	%zmm28, 1152(%rsp)      # 64-byte Spill
	vmovupd	%zmm27, 1216(%rsp)      # 64-byte Spill
	vmovupd	%zmm26, 1280(%rsp)      # 64-byte Spill
	vmovupd	%zmm25, 1344(%rsp)      # 64-byte Spill
	incq	%rsi
	movq	160(%rbx), %r15
	movq	176(%rbx), %rcx
	jmp	.LBB4_17
	.p2align	4, 0x90
.LBB4_20:                               # 
                                        #   in Loop: Header=BB4_7 Depth=1
	movq	56(%rsp), %rbp          # 8-byte Reload
	movq	48(%rsp), %rsi          # 8-byte Reload
	movl	20(%rsp), %edx          # 4-byte Reload
	cmpl	%r12d, %r11d
	jge	.LBB4_14
	jmp	.LBB4_10
	.p2align	4, 0x90
.LBB4_8:                                # 
                                        #   in Loop: Header=BB4_7 Depth=1
	vxorpd	%xmm25, %xmm25, %xmm25
	vxorpd	%xmm3, %xmm3, %xmm3
	vxorpd	%xmm16, %xmm16, %xmm16
	vxorpd	%xmm27, %xmm27, %xmm27
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorpd	%xmm24, %xmm24, %xmm24
	vxorpd	%xmm26, %xmm26, %xmm26
	vxorpd	%xmm5, %xmm5, %xmm5
	vxorpd	%xmm21, %xmm21, %xmm21
	vxorpd	%xmm28, %xmm28, %xmm28
	vxorpd	%xmm12, %xmm12, %xmm12
	vxorpd	%xmm19, %xmm19, %xmm19
	cmpl	%r12d, %r11d
	jge	.LBB4_14
.LBB4_10:                               # 
                                        #   in Loop: Header=BB4_7 Depth=1
	movslq	%r11d, %rcx
	imull	%r8d, %edx
	movslq	%edx, %rdx
	leaq	(%rsi,%rdx,4), %rdx
	jmp	.LBB4_11
	.p2align	4, 0x90
.LBB4_13:                               # 
                                        #   in Loop: Header=BB4_11 Depth=2
	vaddpd	%zmm19, %zmm3, %zmm19
	vaddpd	%zmm12, %zmm4, %zmm12
	vaddpd	%zmm28, %zmm13, %zmm28
	vaddpd	%zmm21, %zmm14, %zmm21
	vmovupd	128(%rsp), %zmm5        # 64-byte Reload
	vaddpd	%zmm5, %zmm15, %zmm5
	vaddpd	%zmm26, %zmm17, %zmm26
	vaddpd	%zmm24, %zmm18, %zmm24
	vaddpd	%zmm11, %zmm20, %zmm11
	vaddpd	%zmm27, %zmm22, %zmm27
	vaddpd	%zmm16, %zmm29, %zmm16
	vmovupd	64(%rsp), %zmm3         # 64-byte Reload
	vaddpd	%zmm3, %zmm30, %zmm3
	vaddpd	%zmm25, %zmm31, %zmm25
	incq	%rcx
	cmpq	%rcx, %r12
	je	.LBB4_14
.LBB4_11:                               # 
                                        #   Parent Loop BB4_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%zmm5, 128(%rsp)        # 64-byte Spill
	vmovupd	%zmm3, 64(%rsp)         # 64-byte Spill
	movslq	(%rdx,%rcx,4), %rdi
	movq	%rdi, %rax
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movq	160(%rbx), %rax
	vmovapd	(%rax,%rsi,8), %zmm0
	vmovapd	64(%rax,%rsi,8), %zmm1
	vmovapd	128(%rax,%rsi,8), %zmm2
	vmovupd	1088(%rsp), %zmm3       # 64-byte Reload
	vsubpd	%zmm0, %zmm3, %zmm3
	vmovupd	832(%rsp), %zmm4        # 64-byte Reload
	vsubpd	%zmm1, %zmm4, %zmm4
	vmovupd	576(%rsp), %zmm5        # 64-byte Reload
	vsubpd	%zmm2, %zmm5, %zmm13
	vmovupd	1024(%rsp), %zmm5       # 64-byte Reload
	vsubpd	%zmm0, %zmm5, %zmm14
	vmovupd	768(%rsp), %zmm5        # 64-byte Reload
	vsubpd	%zmm1, %zmm5, %zmm15
	vmovupd	512(%rsp), %zmm5        # 64-byte Reload
	vsubpd	%zmm2, %zmm5, %zmm17
	vmovupd	960(%rsp), %zmm5        # 64-byte Reload
	vsubpd	%zmm0, %zmm5, %zmm18
	vmovupd	704(%rsp), %zmm5        # 64-byte Reload
	vsubpd	%zmm1, %zmm5, %zmm20
	vmovupd	448(%rsp), %zmm5        # 64-byte Reload
	vsubpd	%zmm2, %zmm5, %zmm22
	vmovupd	896(%rsp), %zmm5        # 64-byte Reload
	vsubpd	%zmm0, %zmm5, %zmm29
	vmovupd	640(%rsp), %zmm0        # 64-byte Reload
	vsubpd	%zmm1, %zmm0, %zmm30
	vmovupd	384(%rsp), %zmm0        # 64-byte Reload
	vsubpd	%zmm2, %zmm0, %zmm31
	vmulpd	%zmm13, %zmm13, %zmm0
	vfmadd231pd	%zmm4, %zmm4, %zmm0 # zmm0 = (zmm4 * zmm4) + zmm0
	vfmadd231pd	%zmm3, %zmm3, %zmm0 # zmm0 = (zmm3 * zmm3) + zmm0
	vmulpd	%zmm17, %zmm17, %zmm1
	vfmadd231pd	%zmm15, %zmm15, %zmm1 # zmm1 = (zmm15 * zmm15) + zmm1
	vfmadd231pd	%zmm14, %zmm14, %zmm1 # zmm1 = (zmm14 * zmm14) + zmm1
	vmulpd	%zmm22, %zmm22, %zmm2
	vfmadd231pd	%zmm20, %zmm20, %zmm2 # zmm2 = (zmm20 * zmm20) + zmm2
	vfmadd231pd	%zmm18, %zmm18, %zmm2 # zmm2 = (zmm18 * zmm18) + zmm2
	vmulpd	%zmm31, %zmm31, %zmm5
	vfmadd231pd	%zmm30, %zmm30, %zmm5 # zmm5 = (zmm30 * zmm30) + zmm5
	vfmadd231pd	%zmm29, %zmm29, %zmm5 # zmm5 = (zmm29 * zmm29) + zmm5
	vmovupd	256(%rsp), %zmm7        # 64-byte Reload
	vcmpltpd	%zmm7, %zmm0, %k3
	vcmpltpd	%zmm7, %zmm1, %k2
	vrcp14pd	%zmm0, %zmm0
	vrcp14pd	%zmm1, %zmm1
	vrcp14pd	%zmm2, %zmm6
	vcmpltpd	%zmm7, %zmm2, %k4
	vcmpltpd	%zmm7, %zmm5, %k1
	vrcp14pd	%zmm5, %zmm2
	vmovupd	320(%rsp), %zmm23       # 64-byte Reload
	vmulpd	%zmm23, %zmm0, %zmm5
	vmulpd	%zmm0, %zmm0, %zmm7
	vmulpd	%zmm5, %zmm7, %zmm5
	vmulpd	%zmm23, %zmm1, %zmm7
	vmulpd	%zmm1, %zmm1, %zmm8
	vmulpd	%zmm7, %zmm8, %zmm7
	vmulpd	%zmm23, %zmm6, %zmm8
	vmulpd	%zmm6, %zmm6, %zmm9
	vmulpd	%zmm8, %zmm9, %zmm8
	vmulpd	%zmm23, %zmm2, %zmm9
	vmulpd	%zmm2, %zmm2, %zmm23
	vmulpd	%zmm9, %zmm23, %zmm9
	vmovupd	192(%rsp), %zmm10       # 64-byte Reload
	vmulpd	%zmm0, %zmm10, %zmm0
	vmulpd	%zmm5, %zmm0, %zmm0
	vbroadcastsd	.LCPI4_1(%rip), %zmm23 # zmm23 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vaddpd	%zmm23, %zmm5, %zmm5
	vmulpd	%zmm5, %zmm0, %zmm0
	vmulpd	%zmm1, %zmm10, %zmm1
	vmulpd	%zmm7, %zmm1, %zmm1
	vaddpd	%zmm23, %zmm7, %zmm5
	vmulpd	%zmm5, %zmm1, %zmm1
	vmulpd	%zmm6, %zmm10, %zmm5
	vmulpd	%zmm8, %zmm5, %zmm5
	vaddpd	%zmm23, %zmm8, %zmm6
	vmulpd	%zmm6, %zmm5, %zmm5
	vmulpd	%zmm2, %zmm10, %zmm2
	vmulpd	%zmm9, %zmm2, %zmm2
	vaddpd	%zmm23, %zmm9, %zmm6
	vmulpd	%zmm6, %zmm2, %zmm2
	vmulpd	%zmm3, %zmm0, %zmm3 {%k3} {z}
	vmulpd	%zmm4, %zmm0, %zmm4 {%k3} {z}
	vmulpd	%zmm13, %zmm0, %zmm13 {%k3} {z}
	vmulpd	%zmm14, %zmm1, %zmm14 {%k2} {z}
	vmulpd	%zmm15, %zmm1, %zmm15 {%k2} {z}
	vmulpd	%zmm17, %zmm1, %zmm17 {%k2} {z}
	vmulpd	%zmm18, %zmm5, %zmm18 {%k4} {z}
	vmulpd	%zmm20, %zmm5, %zmm20 {%k4} {z}
	vmulpd	%zmm22, %zmm5, %zmm22 {%k4} {z}
	vmulpd	%zmm29, %zmm2, %zmm29 {%k1} {z}
	vmulpd	%zmm30, %zmm2, %zmm30 {%k1} {z}
	vmulpd	%zmm31, %zmm2, %zmm31 {%k1} {z}
	movl	4(%rbx), %eax
	sarl	%eax
	cmpl	%eax, %edi
	jge	.LBB4_13
# %bb.12:                               # 
                                        #   in Loop: Header=BB4_11 Depth=2
	movq	176(%rbx), %rax
	vmovapd	64(%rax,%rsi,8), %zmm0
	vmovapd	128(%rax,%rsi,8), %zmm1
	vaddpd	%zmm14, %zmm3, %zmm2
	vaddpd	%zmm18, %zmm29, %zmm5
	vsubpd	(%rax,%rsi,8), %zmm2, %zmm2
	vaddpd	%zmm5, %zmm2, %zmm2
	vxorpd	%xmm5, %xmm5, %xmm5
	vsubpd	%zmm2, %zmm5, %zmm2
	vmovapd	%zmm2, (%rax,%rsi,8)
	vaddpd	%zmm15, %zmm4, %zmm2
	vsubpd	%zmm0, %zmm2, %zmm0
	vaddpd	%zmm20, %zmm30, %zmm2
	vaddpd	%zmm2, %zmm0, %zmm0
	vsubpd	%zmm0, %zmm5, %zmm0
	vmovapd	%zmm0, 64(%rax,%rsi,8)
	vaddpd	%zmm17, %zmm13, %zmm0
	vsubpd	%zmm1, %zmm0, %zmm0
	vaddpd	%zmm22, %zmm31, %zmm1
	vaddpd	%zmm1, %zmm0, %zmm0
	vsubpd	%zmm0, %zmm5, %zmm0
	vmovapd	%zmm0, 128(%rax,%rsi,8)
	jmp	.LBB4_13
.LBB4_15:                               # 
	movl	$.L.str.1, %edi
	vzeroupper
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, 64(%rsp)         # 8-byte Spill
	movl	$.L.str.6, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	64(%rsp), %xmm0         # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vsubsd	24(%rsp), %xmm0, %xmm0  # 8-byte Folded Reload
	addq	$1416, %rsp             # imm = 0x588
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
	.p2align	3               # -- Begin function computeForceLJ_4xn_full
.LCPI5_0:
	.quad	4631952216750555136     #  48
.LCPI5_1:
	.quad	-4620693217682128896    #  -0.5
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI5_2:
	.quad	1                       # 0x1
	.zero	8
	.text
	.globl	computeForceLJ_4xn_full
	.p2align	4, 0x90
	.type	computeForceLJ_4xn_full,@function
computeForceLJ_4xn_full:                # 
.LcomputeForceLJ_4xn_full$local:
	.cfi_startproc
# %bb.0:                                # 
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
	subq	$648, %rsp              # imm = 0x288
	.cfi_def_cfa_offset 704
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rcx, 56(%rsp)          # 8-byte Spill
	movq	%rdx, 48(%rsp)          # 8-byte Spill
	movq	%rsi, %rbx
	movq	%rdi, %r12
	movl	$.L.str.5, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	144(%r12), %xmm0        # xmm0 = mem[0],zero
	vmovsd	%xmm0, 128(%rsp)        # 8-byte Spill
	vbroadcastsd	56(%r12), %zmm1
	vmovsd	40(%r12), %xmm0         # xmm0 = mem[0],zero
	vmovupd	%zmm0, 64(%rsp)         # 64-byte Spill
	movl	20(%rbx), %r10d
	testl	%r10d, %r10d
	jle	.LBB5_5
# %bb.1:                                # 
	movq	176(%rbx), %r11
	movq	192(%rbx), %r9
	decq	%r10
	leaq	128(%r11), %r8
	xorl	%edi, %edi
	vxorpd	%xmm0, %xmm0, %xmm0
	jmp	.LBB5_2
	.p2align	4, 0x90
.LBB5_22:                               # 
                                        #   in Loop: Header=BB5_2 Depth=1
	cmpq	%r10, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB5_5
.LBB5_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_17 Depth 2
                                        #     Child Loop BB5_21 Depth 2
	imulq	$56, %rdi, %rax
	movl	(%r9,%rax), %eax
	testl	%eax, %eax
	jle	.LBB5_22
# %bb.3:                                # 
                                        #   in Loop: Header=BB5_2 Depth=1
	leal	(,%rdi,4), %ecx
	movl	%ecx, %edx
	andl	$-8, %edx
	leal	(%rdx,%rdx,2), %edx
	andl	$4, %ecx
	orl	%edx, %ecx
	movq	%rax, %rdx
	shrq	$3, %rdx
	movl	%ecx, %esi
	je	.LBB5_4
# %bb.16:                               # 
                                        #   in Loop: Header=BB5_2 Depth=1
	leaq	(%r11,%rsi,8), %rbp
	shlq	$6, %rdx
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB5_17:                               # 
                                        #   Parent Loop BB5_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%zmm0, (%rbp,%rcx)
	addq	$64, %rcx
	cmpq	%rcx, %rdx
	jne	.LBB5_17
# %bb.18:                               # 
                                        #   in Loop: Header=BB5_2 Depth=1
	movl	%eax, %ebp
	andl	$-8, %ebp
	leaq	(%rsi,%rbp), %rcx
	vmovupd	%zmm0, (%r11,%rcx,8)
	vmovupd	%zmm0, 64(%r11,%rcx,8)
	cmpq	%rax, %rbp
	jae	.LBB5_22
	jmp	.LBB5_20
	.p2align	4, 0x90
.LBB5_4:                                # 
                                        #   in Loop: Header=BB5_2 Depth=1
	movl	%eax, %ebp
	andl	$-8, %ebp
	cmpq	%rax, %rbp
	jae	.LBB5_22
.LBB5_20:                               # 
                                        #   in Loop: Header=BB5_2 Depth=1
	leaq	(%r8,%rsi,8), %rdx
	.p2align	4, 0x90
.LBB5_21:                               # 
                                        #   Parent Loop BB5_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, -128(%rdx,%rbp,8)
	movq	$0, -64(%rdx,%rbp,8)
	movq	$0, (%rdx,%rbp,8)
	incq	%rbp
	cmpq	%rbp, %rax
	jne	.LBB5_21
	jmp	.LBB5_22
.LBB5_5:                                # 
	vmovupd	%zmm1, 192(%rsp)        # 64-byte Spill
	xorl	%eax, %eax
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 40(%rsp)         # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	cmpl	$0, 20(%rbx)
	jle	.LBB5_13
# %bb.6:                                # 
	vmovsd	128(%rsp), %xmm0        # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm0
	vbroadcastsd	%xmm0, %zmm0
	vmovupd	64(%rsp), %zmm1         # 64-byte Reload
	vmulsd	.LCPI5_0(%rip), %xmm1, %xmm1
	vbroadcastsd	%xmm1, %zmm1
	xorl	%r13d, %r13d
	vbroadcastsd	.LCPI5_1(%rip), %zmm2 # zmm2 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	jmp	.LBB5_7
	.p2align	4, 0x90
.LBB5_12:                               # 
                                        #   in Loop: Header=BB5_7 Depth=1
	vpermilpd	$85, %zmm19, %zmm3 # zmm3 = zmm19[1,0,3,2,5,4,7,6]
	vaddpd	%zmm19, %zmm3, %zmm3
	vpermilpd	$85, %zmm21, %zmm12 # zmm12 = zmm21[1,0,3,2,5,4,7,6]
	vaddpd	%zmm21, %zmm12, %zmm12
	vmovddup	%zmm17, %zmm14  # zmm14 = zmm17[0,0,2,2,4,4,6,6]
	vaddpd	%zmm17, %zmm14, %zmm14
	vshufpd	$170, %zmm14, %zmm3, %zmm3 # zmm3 = zmm3[0],zmm14[1],zmm3[2],zmm14[3],zmm3[4],zmm14[5],zmm3[6],zmm14[7]
	vmovddup	%zmm13, %zmm14  # zmm14 = zmm13[0,0,2,2,4,4,6,6]
	vaddpd	%zmm13, %zmm14, %zmm13
	vshufpd	$170, %zmm13, %zmm12, %zmm12 # zmm12 = zmm12[0],zmm13[1],zmm12[2],zmm13[3],zmm12[4],zmm13[5],zmm12[6],zmm13[7]
	vextractf64x4	$1, %zmm3, %ymm13
	vaddpd	%zmm3, %zmm13, %zmm3
	vinsertf64x4	$1, %ymm12, %zmm0, %zmm13
	vaddpd	%zmm12, %zmm13, %zmm12
	vshuff64x2	$228, %zmm12, %zmm3, %zmm3 # zmm3 = zmm3[0,1,2,3],zmm12[4,5,6,7]
	vpermpd	$78, %zmm3, %zmm12      # zmm12 = zmm3[2,3,0,1,6,7,4,5]
	vaddpd	%zmm3, %zmm12, %zmm3
	vextractf64x4	$1, %zmm3, %ymm12
	vblendpd	$12, %ymm12, %ymm3, %ymm3 # ymm3 = ymm3[0,1],ymm12[2,3]
	vaddpd	(%r10,%r12,8), %ymm3, %ymm3
	vmovapd	%ymm3, (%r10,%r12,8)
	vpermilpd	$85, %zmm11, %zmm3 # zmm3 = zmm11[1,0,3,2,5,4,7,6]
	vaddpd	%zmm11, %zmm3, %zmm3
	vpermilpd	$85, %zmm10, %zmm11 # zmm11 = zmm10[1,0,3,2,5,4,7,6]
	vaddpd	%zmm10, %zmm11, %zmm10
	vmovddup	%zmm9, %zmm11   # zmm11 = zmm9[0,0,2,2,4,4,6,6]
	vaddpd	%zmm9, %zmm11, %zmm9
	vshufpd	$170, %zmm9, %zmm3, %zmm3 # zmm3 = zmm3[0],zmm9[1],zmm3[2],zmm9[3],zmm3[4],zmm9[5],zmm3[6],zmm9[7]
	vmovddup	%zmm8, %zmm9    # zmm9 = zmm8[0,0,2,2,4,4,6,6]
	vaddpd	%zmm8, %zmm9, %zmm8
	vshufpd	$170, %zmm8, %zmm10, %zmm8 # zmm8 = zmm10[0],zmm8[1],zmm10[2],zmm8[3],zmm10[4],zmm8[5],zmm10[6],zmm8[7]
	vextractf64x4	$1, %zmm3, %ymm9
	vaddpd	%zmm3, %zmm9, %zmm3
	vinsertf64x4	$1, %ymm8, %zmm0, %zmm9
	vaddpd	%zmm8, %zmm9, %zmm8
	vshuff64x2	$228, %zmm8, %zmm3, %zmm3 # zmm3 = zmm3[0,1,2,3],zmm8[4,5,6,7]
	vpermpd	$78, %zmm3, %zmm8       # zmm8 = zmm3[2,3,0,1,6,7,4,5]
	vaddpd	%zmm3, %zmm8, %zmm3
	vextractf64x4	$1, %zmm3, %ymm8
	vblendpd	$12, %ymm8, %ymm3, %ymm3 # ymm3 = ymm3[0,1],ymm8[2,3]
	vaddpd	64(%r10,%r12,8), %ymm3, %ymm3
	vmovapd	%ymm3, 64(%r10,%r12,8)
	vpermilpd	$85, %zmm7, %zmm3 # zmm3 = zmm7[1,0,3,2,5,4,7,6]
	vaddpd	%zmm7, %zmm3, %zmm3
	vpermilpd	$85, %zmm6, %zmm7 # zmm7 = zmm6[1,0,3,2,5,4,7,6]
	vaddpd	%zmm6, %zmm7, %zmm6
	vmovddup	%zmm5, %zmm7    # zmm7 = zmm5[0,0,2,2,4,4,6,6]
	vaddpd	%zmm5, %zmm7, %zmm5
	vshufpd	$170, %zmm5, %zmm3, %zmm3 # zmm3 = zmm3[0],zmm5[1],zmm3[2],zmm5[3],zmm3[4],zmm5[5],zmm3[6],zmm5[7]
	vmovddup	%zmm4, %zmm5    # zmm5 = zmm4[0,0,2,2,4,4,6,6]
	vaddpd	%zmm4, %zmm5, %zmm4
	vshufpd	$170, %zmm4, %zmm6, %zmm4 # zmm4 = zmm6[0],zmm4[1],zmm6[2],zmm4[3],zmm6[4],zmm4[5],zmm6[6],zmm4[7]
	vextractf64x4	$1, %zmm3, %ymm5
	vaddpd	%zmm3, %zmm5, %zmm3
	vinsertf64x4	$1, %ymm4, %zmm0, %zmm5
	vaddpd	%zmm4, %zmm5, %zmm4
	vshuff64x2	$228, %zmm4, %zmm3, %zmm3 # zmm3 = zmm3[0,1,2,3],zmm4[4,5,6,7]
	vpermpd	$78, %zmm3, %zmm4       # zmm4 = zmm3[2,3,0,1,6,7,4,5]
	vaddpd	%zmm3, %zmm4, %zmm3
	vextractf64x4	$1, %zmm3, %ymm4
	vblendpd	$12, %ymm4, %ymm3, %ymm3 # ymm3 = ymm3[0,1],ymm4[2,3]
	vaddpd	128(%r10,%r12,8), %ymm3, %ymm3
	vmovapd	%ymm3, 128(%r10,%r12,8)
	vmovdqa	.LCPI5_2(%rip), %xmm3   # xmm3 = <1,u>
	vpinsrq	$1, %r11, %xmm3, %xmm3
	movq	56(%rsp), %rax          # 8-byte Reload
	vpaddq	(%rax), %xmm3, %xmm3
	vmovdqu	%xmm3, (%rax)
	addq	%r11, 16(%rax)
	incq	%r13
	movslq	20(%rbx), %rax
	cmpq	%rax, %r13
	jge	.LBB5_13
.LBB5_7:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_15 Depth 2
                                        #     Child Loop BB5_11 Depth 2
	leal	(,%r13,4), %r12d
	movl	%r12d, %eax
	andl	$-8, %eax
	leal	(%rax,%rax,2), %eax
	andl	$4, %r12d
	orl	%eax, %r12d
	movq	160(%rbx), %rdi
	movq	176(%rbx), %r10
	movq	48(%rsp), %rcx          # 8-byte Reload
	movq	40(%rcx), %r8
	movl	8(%rcx), %r9d
	movq	16(%rcx), %rax
	movslq	(%rax,%r13,4), %r11
	movq	24(%rcx), %rax
	vbroadcastsd	(%rdi,%r12,8), %zmm22
	vbroadcastsd	8(%rdi,%r12,8), %zmm23
	vbroadcastsd	16(%rdi,%r12,8), %zmm24
	vbroadcastsd	24(%rdi,%r12,8), %zmm25
	vbroadcastsd	64(%rdi,%r12,8), %zmm26
	vbroadcastsd	72(%rdi,%r12,8), %zmm27
	vbroadcastsd	80(%rdi,%r12,8), %zmm3
	vbroadcastsd	88(%rdi,%r12,8), %zmm4
	vbroadcastsd	128(%rdi,%r12,8), %zmm5
	vbroadcastsd	136(%rdi,%r12,8), %zmm6
	movl	(%rax,%r13,4), %r15d
	vbroadcastsd	144(%rdi,%r12,8), %zmm7
	vbroadcastsd	152(%rdi,%r12,8), %zmm8
	testl	%r15d, %r15d
	vmovups	%zmm22, 64(%rsp)        # 64-byte Spill
	vmovupd	%zmm5, 320(%rsp)        # 64-byte Spill
	vmovupd	%zmm4, 128(%rsp)        # 64-byte Spill
	vmovupd	%zmm7, 256(%rsp)        # 64-byte Spill
	vmovupd	%zmm6, 448(%rsp)        # 64-byte Spill
	vmovupd	%zmm8, 384(%rsp)        # 64-byte Spill
	jle	.LBB5_8
# %bb.14:                               # 
                                        #   in Loop: Header=BB5_7 Depth=1
	movl	%r9d, %eax
	imull	%r13d, %eax
	cltq
	leaq	(%r8,%rax,4), %rsi
	vxorpd	%xmm19, %xmm19, %xmm19
	movl	$0, %ecx
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm17, %xmm17, %xmm17
	vxorpd	%xmm9, %xmm9, %xmm9
	vxorpd	%xmm5, %xmm5, %xmm5
	vxorpd	%xmm21, %xmm21, %xmm21
	vxorpd	%xmm10, %xmm10, %xmm10
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm13, %xmm13, %xmm13
	vxorpd	%xmm8, %xmm8, %xmm8
	vxorpd	%xmm4, %xmm4, %xmm4
	vmovupd	192(%rsp), %zmm20       # 64-byte Reload
	vmovapd	%zmm3, %zmm22
	.p2align	4, 0x90
.LBB5_15:                               # 
                                        #   Parent Loop BB5_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%rsi,%rcx,4), %rbp
	leaq	(,%rbp,2), %rax
	addq	%rbp, %rax
	shlq	$6, %rax
	vmovapd	(%rdi,%rax), %zmm28
	vmovapd	128(%rdi,%rax), %zmm29
	vmovapd	64(%rdi,%rax), %zmm30
	vmovupd	64(%rsp), %zmm3         # 64-byte Reload
	vsubpd	%zmm28, %zmm3, %zmm31
	leal	(%rbp,%rbp), %r14d
	xorl	%eax, %eax
	cmpq	%r14, %r13
	vsubpd	%zmm30, %zmm26, %zmm3
	sete	%al
	leal	1(%rbp,%rbp), %edx
	xorl	%ebp, %ebp
	cmpq	%rdx, %r13
	sete	%bpl
	vmovupd	320(%rsp), %zmm12       # 64-byte Reload
	vsubpd	%zmm29, %zmm12, %zmm12
	vmulpd	%zmm12, %zmm12, %zmm14
	vfmadd231pd	%zmm3, %zmm3, %zmm14 # zmm14 = (zmm3 * zmm3) + zmm14
	vfmadd231pd	%zmm31, %zmm31, %zmm14 # zmm14 = (zmm31 * zmm31) + zmm14
	vrcp14pd	%zmm14, %zmm15
	shll	$3, %eax
	leal	(%rax,%rbp,4), %edx
	vmulpd	%zmm20, %zmm15, %zmm16
	vmulpd	%zmm15, %zmm15, %zmm18
	vmulpd	%zmm16, %zmm18, %zmm16
	vsubpd	%zmm28, %zmm23, %zmm18
	kmovb	376(%rbx,%rdx,4), %k1
	vmulpd	%zmm15, %zmm1, %zmm15
	vmulpd	%zmm16, %zmm15, %zmm15
	vaddpd	%zmm2, %zmm16, %zmm16
	vmulpd	%zmm16, %zmm15, %zmm15
	vsubpd	%zmm30, %zmm27, %zmm16
	vcmpltpd	%zmm0, %zmm14, %k1 {%k1}
	vmovupd	448(%rsp), %zmm14       # 64-byte Reload
	vsubpd	%zmm29, %zmm14, %zmm14
	vfmadd231pd	%zmm31, %zmm15, %zmm19 {%k1} # zmm19 = (zmm15 * zmm31) + zmm19
	vmulpd	%zmm14, %zmm14, %zmm31
	vfmadd231pd	%zmm16, %zmm16, %zmm31 # zmm31 = (zmm16 * zmm16) + zmm31
	vfmadd231pd	%zmm18, %zmm18, %zmm31 # zmm31 = (zmm18 * zmm18) + zmm31
	vfmadd231pd	%zmm3, %zmm15, %zmm11 {%k1} # zmm11 = (zmm15 * zmm3) + zmm11
	vrcp14pd	%zmm31, %zmm3
	leal	1(%rax,%rbp,4), %edx
	vfmadd231pd	%zmm12, %zmm15, %zmm7 {%k1} # zmm7 = (zmm15 * zmm12) + zmm7
	vmulpd	%zmm20, %zmm3, %zmm12
	vmulpd	%zmm3, %zmm3, %zmm15
	vmulpd	%zmm12, %zmm15, %zmm12
	vsubpd	%zmm28, %zmm24, %zmm15
	kmovb	376(%rbx,%rdx,4), %k1
	vmulpd	%zmm3, %zmm1, %zmm3
	vmulpd	%zmm12, %zmm3, %zmm3
	vaddpd	%zmm2, %zmm12, %zmm12
	vmulpd	%zmm12, %zmm3, %zmm3
	vsubpd	%zmm30, %zmm22, %zmm12
	vcmpltpd	%zmm0, %zmm31, %k1 {%k1}
	vmovupd	256(%rsp), %zmm31       # 64-byte Reload
	vsubpd	%zmm29, %zmm31, %zmm31
	vfmadd231pd	%zmm18, %zmm3, %zmm17 {%k1} # zmm17 = (zmm3 * zmm18) + zmm17
	vmulpd	%zmm31, %zmm31, %zmm18
	vfmadd231pd	%zmm12, %zmm12, %zmm18 # zmm18 = (zmm12 * zmm12) + zmm18
	vfmadd231pd	%zmm15, %zmm15, %zmm18 # zmm18 = (zmm15 * zmm15) + zmm18
	vfmadd231pd	%zmm16, %zmm3, %zmm9 {%k1} # zmm9 = (zmm3 * zmm16) + zmm9
	vrcp14pd	%zmm18, %zmm16
	vfmadd231pd	%zmm14, %zmm3, %zmm5 {%k1} # zmm5 = (zmm3 * zmm14) + zmm5
	vmulpd	%zmm20, %zmm16, %zmm3
	vmulpd	%zmm16, %zmm16, %zmm14
	vmulpd	%zmm3, %zmm14, %zmm3
	vmulpd	%zmm16, %zmm1, %zmm14
	vmulpd	%zmm3, %zmm14, %zmm14
	vaddpd	%zmm2, %zmm3, %zmm3
	vmulpd	%zmm3, %zmm14, %zmm3
	leal	2(%rax,%rbp,4), %edx
	kmovb	376(%rbx,%rdx,4), %k1
	vcmpltpd	%zmm0, %zmm18, %k1 {%k1}
	vsubpd	%zmm28, %zmm25, %zmm14
	vmovupd	128(%rsp), %zmm16       # 64-byte Reload
	vsubpd	%zmm30, %zmm16, %zmm16
	vmovupd	384(%rsp), %zmm18       # 64-byte Reload
	vsubpd	%zmm29, %zmm18, %zmm18
	vfmadd231pd	%zmm15, %zmm3, %zmm21 {%k1} # zmm21 = (zmm3 * zmm15) + zmm21
	vmulpd	%zmm18, %zmm18, %zmm15
	vfmadd231pd	%zmm16, %zmm16, %zmm15 # zmm15 = (zmm16 * zmm16) + zmm15
	vfmadd231pd	%zmm14, %zmm14, %zmm15 # zmm15 = (zmm14 * zmm14) + zmm15
	vfmadd231pd	%zmm12, %zmm3, %zmm10 {%k1} # zmm10 = (zmm3 * zmm12) + zmm10
	vrcp14pd	%zmm15, %zmm12
	vfmadd231pd	%zmm31, %zmm3, %zmm6 {%k1} # zmm6 = (zmm3 * zmm31) + zmm6
	vmulpd	%zmm20, %zmm12, %zmm3
	vmulpd	%zmm12, %zmm12, %zmm28
	vmulpd	%zmm3, %zmm28, %zmm3
	vmulpd	%zmm12, %zmm1, %zmm12
	vmulpd	%zmm3, %zmm12, %zmm12
	vaddpd	%zmm2, %zmm3, %zmm3
	vmulpd	%zmm3, %zmm12, %zmm3
	leal	3(%rax,%rbp,4), %eax
	kmovb	376(%rbx,%rax,4), %k1
	vcmpltpd	%zmm0, %zmm15, %k1 {%k1}
	vfmadd231pd	%zmm14, %zmm3, %zmm13 {%k1} # zmm13 = (zmm3 * zmm14) + zmm13
	vfmadd231pd	%zmm16, %zmm3, %zmm8 {%k1} # zmm8 = (zmm3 * zmm16) + zmm8
	vfmadd231pd	%zmm18, %zmm3, %zmm4 {%k1} # zmm4 = (zmm3 * zmm18) + zmm4
	incq	%rcx
	cmpq	%rcx, %r15
	jne	.LBB5_15
# %bb.9:                                # 
                                        #   in Loop: Header=BB5_7 Depth=1
	vmovupd	256(%rsp), %zmm16       # 64-byte Reload
	vmovupd	320(%rsp), %zmm14       # 64-byte Reload
	cmpl	%r11d, %r15d
	jge	.LBB5_12
	jmp	.LBB5_10
	.p2align	4, 0x90
.LBB5_8:                                # 
                                        #   in Loop: Header=BB5_7 Depth=1
	vxorpd	%xmm4, %xmm4, %xmm4
	vxorpd	%xmm8, %xmm8, %xmm8
	vxorpd	%xmm13, %xmm13, %xmm13
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm10, %xmm10, %xmm10
	vxorpd	%xmm21, %xmm21, %xmm21
	vxorpd	%xmm5, %xmm5, %xmm5
	vxorpd	%xmm9, %xmm9, %xmm9
	vxorpd	%xmm17, %xmm17, %xmm17
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorpd	%xmm19, %xmm19, %xmm19
	vmovapd	%zmm3, %zmm22
	vmovupd	256(%rsp), %zmm16       # 64-byte Reload
	vmovupd	320(%rsp), %zmm14       # 64-byte Reload
	cmpl	%r11d, %r15d
	jge	.LBB5_12
.LBB5_10:                               # 
                                        #   in Loop: Header=BB5_7 Depth=1
	vmovapd	%zmm22, %zmm3
	movslq	%r15d, %rcx
	imull	%r13d, %r9d
	movslq	%r9d, %rax
	leaq	(%r8,%rax,4), %rdx
	vmovupd	192(%rsp), %zmm20       # 64-byte Reload
	vmovupd	%zmm25, 576(%rsp)       # 64-byte Spill
	vmovupd	%zmm27, 512(%rsp)       # 64-byte Spill
	vmovapd	%zmm14, %zmm25
	vmovapd	%zmm16, %zmm27
	.p2align	4, 0x90
movl      $111, %ebx # OSACA START MARKER
.byte     100        # OSACA START MARKER
.byte     103        # OSACA START MARKER
.byte     144        # OSACA START MARKER
# pointer_increment=64 da67166e5736661e6b03ea29ee7bfd67
# LLVM-MCA-BEGIN
.LBB5_11:                               # 
                                        #   Parent Loop BB5_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%rdx,%rcx,4), %rax
	leaq	(%rax,%rax,2), %rax
	shlq	$6, %rax
	vmovapd	(%rdi,%rax), %zmm28
	vmovapd	64(%rdi,%rax), %zmm29
	vmovapd	128(%rdi,%rax), %zmm30
	vmovupd	64(%rsp), %zmm3         # 64-byte Reload
	vsubpd	%zmm28, %zmm3, %zmm14
	vsubpd	%zmm29, %zmm26, %zmm12
	vsubpd	%zmm30, %zmm25, %zmm31
	vsubpd	%zmm28, %zmm23, %zmm3
	vmulpd	%zmm31, %zmm31, %zmm15
	vfmadd231pd	%zmm12, %zmm12, %zmm15 # zmm15 = (zmm12 * zmm12) + zmm15
	vfmadd231pd	%zmm14, %zmm14, %zmm15 # zmm15 = (zmm14 * zmm14) + zmm15
	vrcp14pd	%zmm15, %zmm16
	vcmpltpd	%zmm0, %zmm15, %k1
	vmulpd	%zmm20, %zmm16, %zmm15
	vmulpd	%zmm16, %zmm16, %zmm18
	vmulpd	%zmm15, %zmm18, %zmm15
	vmovupd	512(%rsp), %zmm18       # 64-byte Reload
	vsubpd	%zmm29, %zmm18, %zmm18
	vmulpd	%zmm16, %zmm1, %zmm16
	vmulpd	%zmm15, %zmm16, %zmm16
	vaddpd	%zmm2, %zmm15, %zmm15
	vmulpd	%zmm15, %zmm16, %zmm15
	vmovupd	448(%rsp), %zmm16       # 64-byte Reload
	vsubpd	%zmm30, %zmm16, %zmm16
	vfmadd231pd	%zmm14, %zmm15, %zmm19 {%k1} # zmm19 = (zmm15 * zmm14) + zmm19
	vmulpd	%zmm16, %zmm16, %zmm14
	vfmadd231pd	%zmm18, %zmm18, %zmm14 # zmm14 = (zmm18 * zmm18) + zmm14
	vfmadd231pd	%zmm3, %zmm3, %zmm14 # zmm14 = (zmm3 * zmm3) + zmm14
	vcmpltpd	%zmm0, %zmm14, %k2
	vrcp14pd	%zmm14, %zmm14
	vfmadd231pd	%zmm12, %zmm15, %zmm11 {%k1} # zmm11 = (zmm15 * zmm12) + zmm11
	vfmadd231pd	%zmm31, %zmm15, %zmm7 {%k1} # zmm7 = (zmm15 * zmm31) + zmm7
	vmulpd	%zmm20, %zmm14, %zmm12
	vmulpd	%zmm14, %zmm14, %zmm15
	vmulpd	%zmm12, %zmm15, %zmm12
	vsubpd	%zmm28, %zmm24, %zmm15
	vmulpd	%zmm14, %zmm1, %zmm14
	vmulpd	%zmm12, %zmm14, %zmm14
	vaddpd	%zmm2, %zmm12, %zmm12
	vmulpd	%zmm12, %zmm14, %zmm12
	vsubpd	%zmm29, %zmm22, %zmm14
	vfmadd231pd	%zmm3, %zmm12, %zmm17 {%k2} # zmm17 = (zmm12 * zmm3) + zmm17
	vsubpd	%zmm30, %zmm27, %zmm3
	vfmadd231pd	%zmm18, %zmm12, %zmm9 {%k2} # zmm9 = (zmm12 * zmm18) + zmm9
	vmulpd	%zmm3, %zmm3, %zmm18
	vfmadd231pd	%zmm14, %zmm14, %zmm18 # zmm18 = (zmm14 * zmm14) + zmm18
	vfmadd231pd	%zmm15, %zmm15, %zmm18 # zmm18 = (zmm15 * zmm15) + zmm18
	vcmpltpd	%zmm0, %zmm18, %k1
	vrcp14pd	%zmm18, %zmm18
	vfmadd231pd	%zmm16, %zmm12, %zmm5 {%k2} # zmm5 = (zmm12 * zmm16) + zmm5
	vmulpd	%zmm20, %zmm18, %zmm12
	vmulpd	%zmm18, %zmm18, %zmm16
	vmulpd	%zmm12, %zmm16, %zmm12
	vmulpd	%zmm18, %zmm1, %zmm16
	vmulpd	%zmm12, %zmm16, %zmm16
	vaddpd	%zmm2, %zmm12, %zmm12
	vmulpd	%zmm12, %zmm16, %zmm12
	vfmadd231pd	%zmm15, %zmm12, %zmm21 {%k1} # zmm21 = (zmm12 * zmm15) + zmm21
	vmovupd	576(%rsp), %zmm15       # 64-byte Reload
	vsubpd	%zmm28, %zmm15, %zmm15
	vmovupd	128(%rsp), %zmm16       # 64-byte Reload
	vsubpd	%zmm29, %zmm16, %zmm16
	vmovupd	384(%rsp), %zmm18       # 64-byte Reload
	vsubpd	%zmm30, %zmm18, %zmm18
	vfmadd231pd	%zmm14, %zmm12, %zmm10 {%k1} # zmm10 = (zmm12 * zmm14) + zmm10
	vmulpd	%zmm18, %zmm18, %zmm14
	vfmadd231pd	%zmm16, %zmm16, %zmm14 # zmm14 = (zmm16 * zmm16) + zmm14
	vfmadd231pd	%zmm15, %zmm15, %zmm14 # zmm14 = (zmm15 * zmm15) + zmm14
	vcmpltpd	%zmm0, %zmm14, %k2
	vrcp14pd	%zmm14, %zmm14
	vfmadd231pd	%zmm3, %zmm12, %zmm6 {%k1} # zmm6 = (zmm12 * zmm3) + zmm6
	vmulpd	%zmm20, %zmm14, %zmm3
	vmulpd	%zmm14, %zmm14, %zmm12
	vmulpd	%zmm3, %zmm12, %zmm3
	vmulpd	%zmm14, %zmm1, %zmm12
	vmulpd	%zmm3, %zmm12, %zmm12
	vaddpd	%zmm2, %zmm3, %zmm3
	vmulpd	%zmm3, %zmm12, %zmm3
	vfmadd231pd	%zmm15, %zmm3, %zmm13 {%k2} # zmm13 = (zmm3 * zmm15) + zmm13
	vfmadd231pd	%zmm16, %zmm3, %zmm8 {%k2} # zmm8 = (zmm3 * zmm16) + zmm8
	vfmadd231pd	%zmm18, %zmm3, %zmm4 {%k2} # zmm4 = (zmm3 * zmm18) + zmm4
	incq	%rcx
	cmpq	%rcx, %r11
	jne	.LBB5_11
	jmp	.LBB5_12
# LLVM-MCA-END
movl      $222, %ebx # OSACA END MARKER
.byte     100        # OSACA END MARKER
.byte     103        # OSACA END MARKER
.byte     144        # OSACA END MARKER
.LBB5_13:                               # 
	movl	$.L.str.1, %edi
	vzeroupper
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, 64(%rsp)         # 8-byte Spill
	movl	$.L.str.6, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	64(%rsp), %xmm0         # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vsubsd	40(%rsp), %xmm0, %xmm0  # 8-byte Folded Reload
	addq	$648, %rsp              # imm = 0x288
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
	.globl	computeForceLJ_4xn      # -- Begin function computeForceLJ_4xn
	.p2align	4, 0x90
	.type	computeForceLJ_4xn,@function
computeForceLJ_4xn:                     # 
.LcomputeForceLJ_4xn$local:
	.cfi_startproc
# %bb.0:                                # 
	cmpl	$0, 32(%rdx)
	je	.LBB6_2
# %bb.1:                                # 
	jmp	.LcomputeForceLJ_4xn_half$local # TAILCALL
.LBB6_2:                                # 
	jmp	.LcomputeForceLJ_4xn_full$local # TAILCALL
.Lfunc_end6:
	.size	computeForceLJ_4xn, .Lfunc_end6-computeForceLJ_4xn
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object          # 
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"computeForceLJ begin\n"
	.size	.L.str, 22

	.type	.L.str.1,@object        # 
.L.str.1:
	.asciz	"force"
	.size	.L.str.1, 6

	.type	.L.str.2,@object        # 
.L.str.2:
	.asciz	"computeForceLJ end\n"
	.size	.L.str.2, 20

	.type	.L.str.3,@object        # 
.L.str.3:
	.asciz	"computeForceLJ_2xnn begin\n"
	.size	.L.str.3, 27

	.type	.L.str.4,@object        # 
.L.str.4:
	.asciz	"computeForceLJ_2xnn end\n"
	.size	.L.str.4, 25

	.type	.L.str.5,@object        # 
.L.str.5:
	.asciz	"computeForceLJ_4xn begin\n"
	.size	.L.str.5, 26

	.type	.L.str.6,@object        # 
.L.str.6:
	.asciz	"computeForceLJ_4xn end\n"
	.size	.L.str.6, 24

	.ident	"Intel(R) oneAPI DPC++ Compiler 2021.1-beta05 (2020.2.0.0304)"
	.section	".note.GNU-stack","",@progbits
