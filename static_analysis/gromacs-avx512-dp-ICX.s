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
	movq	8(%rax), %rsi
	movq	%rsi, 64(%rsp)          # 8-byte Spill
	movq	24(%rax), %rsi
	movq	%rsi, 80(%rsp)          # 8-byte Spill
	movslq	16(%rax), %rax
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
	movslq	(%rax,%rcx,4), %rdi
	movq	%rdi, %rax
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
	movq	%rbx, %rsi
.LBB0_32:                               # 
                                        #   in Loop: Header=BB0_12 Depth=4
	incq	(%rsi)
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
	cmpl	%edi, %r14d
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
	movq	%r10, %rsi
	jmp	.LBB0_32
	.p2align	4, 0x90
.LBB0_21:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	cmpl	%edi, %r14d
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
	cmpl	%edi, %r14d
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
	cmpl	%edi, %r14d
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
	cmpl	%edi, %r14d
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
	cmpl	%edi, %r14d
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
	cmpl	%edi, %r14d
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
	cmpl	%edi, %r14d
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
	cmpl	%edi, %r14d
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
	cmpl	%edi, %r14d
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
	movq	%rcx, 40(%rsp)          # 8-byte Spill
	movq	%rdx, %r14
	movq	%rsi, %rbx
	movq	%rdi, %rbp
	movl	$.L.str.3, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	144(%rbp), %xmm0        # xmm0 = mem[0],zero
	vmovsd	%xmm0, 16(%rsp)         # 8-byte Spill
	vbroadcastsd	56(%rbp), %zmm1
	vmovsd	40(%rbp), %xmm0         # xmm0 = mem[0],zero
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
.LBB1_21:                               # 
                                        #   in Loop: Header=BB1_2 Depth=1
	cmpq	%r10, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB1_5
.LBB1_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_16 Depth 2
                                        #     Child Loop BB1_20 Depth 2
	imulq	$56, %rdi, %rax
	movl	(%r9,%rax), %eax
	testl	%eax, %eax
	jle	.LBB1_21
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
# %bb.15:                               # 
                                        #   in Loop: Header=BB1_2 Depth=1
	leaq	(%r11,%rsi,8), %rbp
	shlq	$6, %rdx
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB1_16:                               # 
                                        #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%zmm0, (%rbp,%rcx)
	addq	$64, %rcx
	cmpq	%rcx, %rdx
	jne	.LBB1_16
# %bb.17:                               # 
                                        #   in Loop: Header=BB1_2 Depth=1
	movl	%eax, %ebp
	andl	$-8, %ebp
	leaq	(%rsi,%rbp), %rcx
	vmovupd	%zmm0, (%r11,%rcx,8)
	vmovupd	%zmm0, 64(%r11,%rcx,8)
	cmpq	%rax, %rbp
	jae	.LBB1_21
	jmp	.LBB1_19
	.p2align	4, 0x90
.LBB1_4:                                # 
                                        #   in Loop: Header=BB1_2 Depth=1
	movl	%eax, %ebp
	andl	$-8, %ebp
	cmpq	%rax, %rbp
	jae	.LBB1_21
.LBB1_19:                               # 
                                        #   in Loop: Header=BB1_2 Depth=1
	leaq	(%r8,%rsi,8), %rdx
	.p2align	4, 0x90
.LBB1_20:                               # 
                                        #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, -128(%rdx,%rbp,8)
	movq	$0, -64(%rdx,%rbp,8)
	movq	$0, (%rdx,%rbp,8)
	incq	%rbp
	cmpq	%rbp, %rax
	jne	.LBB1_20
	jmp	.LBB1_21
.LBB1_5:                                # 
	xorl	%eax, %eax
	vmovupd	%zmm1, 128(%rsp)        # 64-byte Spill
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 24(%rsp)         # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	vmovupd	128(%rsp), %zmm30       # 64-byte Reload
	cmpl	$0, 20(%rbx)
	jle	.LBB1_10
# %bb.6:                                # 
	vmovsd	16(%rsp), %xmm0         # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm0
	vbroadcastsd	%xmm0, %zmm0
	vmovupd	64(%rsp), %zmm1         # 64-byte Reload
	vmulsd	.LCPI1_0(%rip), %xmm1, %xmm1
	vbroadcastsd	%xmm1, %zmm1
	vbroadcastsd	.LCPI1_1(%rip), %zmm2 # zmm2 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vmovdqa	.LCPI1_2(%rip), %xmm3   # xmm3 = <1,u>
	vmovsd	.LCPI1_3(%rip), %xmm4   # xmm4 = mem[0],zero
	xorl	%edi, %edi
	movq	%r14, 32(%rsp)          # 8-byte Spill
	movq	%rbx, 8(%rsp)           # 8-byte Spill
	jmp	.LBB1_7
	.p2align	4, 0x90
.LBB1_13:                               # 
                                        #   in Loop: Header=BB1_7 Depth=1
	movq	32(%rsp), %r14          # 8-byte Reload
	movq	8(%rsp), %rbx           # 8-byte Reload
	movq	64(%rsp), %rdx          # 8-byte Reload
	movq	16(%rsp), %rsi          # 8-byte Reload
	movq	56(%rsp), %r11          # 8-byte Reload
	movq	48(%rsp), %rcx          # 8-byte Reload
.LBB1_9:                                # 
                                        #   in Loop: Header=BB1_7 Depth=1
	vpermpd	$238, %zmm10, %zmm9     # zmm9 = zmm10[2,3,2,3,6,7,6,7]
	vaddpd	%zmm10, %zmm9, %zmm9
	vpermpd	$68, %zmm13, %zmm10     # zmm10 = zmm13[0,1,0,1,4,5,4,5]
	movb	$-52, %al
	kmovd	%eax, %k1
	vaddpd	%zmm13, %zmm10, %zmm9 {%k1}
	vpermilpd	$85, %zmm9, %zmm10 # zmm10 = zmm9[1,0,3,2,5,4,7,6]
	vaddpd	%zmm9, %zmm10, %zmm9
	vextractf64x4	$1, %zmm9, %ymm10
	vblendpd	$10, %ymm10, %ymm9, %ymm9 # ymm9 = ymm9[0],ymm10[1],ymm9[2],ymm10[3]
	vaddpd	(%r11,%rdx,8), %ymm9, %ymm9
	vmovapd	%ymm9, (%r11,%rdx,8)
	vpermpd	$238, %zmm8, %zmm9      # zmm9 = zmm8[2,3,2,3,6,7,6,7]
	vaddpd	%zmm8, %zmm9, %zmm8
	vpermpd	$68, %zmm7, %zmm9       # zmm9 = zmm7[0,1,0,1,4,5,4,5]
	vaddpd	%zmm7, %zmm9, %zmm8 {%k1}
	vpermilpd	$85, %zmm8, %zmm7 # zmm7 = zmm8[1,0,3,2,5,4,7,6]
	vaddpd	%zmm8, %zmm7, %zmm7
	vextractf64x4	$1, %zmm7, %ymm8
	vblendpd	$10, %ymm8, %ymm7, %ymm7 # ymm7 = ymm7[0],ymm8[1],ymm7[2],ymm8[3]
	vaddpd	64(%r11,%rdx,8), %ymm7, %ymm7
	vmovapd	%ymm7, 64(%r11,%rdx,8)
	vpermpd	$238, %zmm6, %zmm7      # zmm7 = zmm6[2,3,2,3,6,7,6,7]
	vaddpd	%zmm6, %zmm7, %zmm6
	vpermpd	$68, %zmm5, %zmm7       # zmm7 = zmm5[0,1,0,1,4,5,4,5]
	vaddpd	%zmm5, %zmm7, %zmm6 {%k1}
	vpermilpd	$85, %zmm6, %zmm5 # zmm5 = zmm6[1,0,3,2,5,4,7,6]
	vaddpd	%zmm6, %zmm5, %zmm5
	vextractf64x4	$1, %zmm5, %ymm6
	vblendpd	$10, %ymm6, %ymm5, %ymm5 # ymm5 = ymm5[0],ymm6[1],ymm5[2],ymm6[3]
	vaddpd	128(%r11,%rdx,8), %ymm5, %ymm5
	vmovapd	%ymm5, 128(%r11,%rdx,8)
	vpinsrq	$1, %rcx, %xmm3, %xmm5
	movq	40(%rsp), %rcx          # 8-byte Reload
	vpaddq	(%rcx), %xmm5, %xmm5
	vmovdqu	%xmm5, (%rcx)
	vcvtsi2sd	%esi, %xmm11, %xmm5
	vmulsd	%xmm4, %xmm5, %xmm5
	vcvttsd2si	%xmm5, %rax
	addq	%rax, 16(%rcx)
	incq	%rdi
	movslq	20(%rbx), %rax
	cmpq	%rax, %rdi
	jge	.LBB1_10
.LBB1_7:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_12 Depth 2
	leal	(,%rdi,4), %edx
	movl	%edx, %ecx
	andl	$-8, %ecx
	leal	(%rcx,%rcx,2), %ecx
	andl	$4, %edx
	orl	%ecx, %edx
	movq	176(%rbx), %r11
	movq	24(%r14), %rcx
	movslq	(%rcx,%rdi,4), %rsi
	testq	%rsi, %rsi
	jle	.LBB1_8
# %bb.11:                               # 
                                        #   in Loop: Header=BB1_7 Depth=1
	movq	160(%rbx), %r10
	vbroadcastsd	(%r10,%rdx,8), %zmm5
	movq	8(%r14), %rcx
	vbroadcastsd	8(%r10,%rdx,8), %ymm6
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm9
	vbroadcastsd	16(%r10,%rdx,8), %zmm5
	vbroadcastsd	24(%r10,%rdx,8), %ymm6
	vbroadcastsd	64(%r10,%rdx,8), %zmm7
	vbroadcastsd	72(%r10,%rdx,8), %ymm8
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm11
	vinsertf64x4	$1, %ymm8, %zmm7, %zmm12
	vbroadcastsd	80(%r10,%rdx,8), %zmm5
	vbroadcastsd	88(%r10,%rdx,8), %ymm6
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm14
	vbroadcastsd	128(%r10,%rdx,8), %zmm5
	vbroadcastsd	136(%r10,%rdx,8), %ymm6
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm15
	vbroadcastsd	144(%r10,%rdx,8), %zmm5
	movq	%rdx, 64(%rsp)          # 8-byte Spill
	vbroadcastsd	152(%r10,%rdx,8), %ymm6
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm16
	movq	%rsi, 16(%rsp)          # 8-byte Spill
	movl	%esi, %eax
	movl	16(%r14), %edx
	imull	%edi, %edx
	movslq	%edx, %rdx
	leaq	(%rcx,%rdx,4), %r9
	movq	%rax, 48(%rsp)          # 8-byte Spill
	leaq	-1(%rax), %r8
	vxorpd	%xmm10, %xmm10, %xmm10
	movq	%r11, 56(%rsp)          # 8-byte Spill
	movl	$0, %r14d
	vxorpd	%xmm8, %xmm8, %xmm8
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm13, %xmm13, %xmm13
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm5, %xmm5, %xmm5
	.p2align	4, 0x90
.LBB1_12:                               # 
                                        #   Parent Loop BB1_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%r9,%r14,4), %rcx
	leal	(%rcx,%rcx), %edx
	leal	(%rcx,%rcx), %esi
	incl	%esi
	shlq	$6, %rcx
	leaq	(%rcx,%rcx,2), %r13
	vbroadcastf64x4	(%r10,%r13), %zmm17 # zmm17 = mem[0,1,2,3,0,1,2,3]
	vbroadcastf64x4	64(%r10,%r13), %zmm18 # zmm18 = mem[0,1,2,3,0,1,2,3]
	vbroadcastf64x4	128(%r10,%r13), %zmm19 # zmm19 = mem[0,1,2,3,0,1,2,3]
	xorl	%eax, %eax
	cmpq	%rsi, %rdi
	movl	$255, %ecx
	movl	$224, %esi
	cmovel	%esi, %ecx
	sete	%al
	movl	$0, %ebx
	movl	$127, %esi
	cmovel	%esi, %ebx
	movl	$0, %ebp
	movl	$15, %esi
	cmovel	%esi, %ebp
	xorl	%esi, %esi
	cmpq	%rdx, %rdi
	sete	%r10b
	setne	%sil
	leal	(%rsi,%rsi,2), %r15d
	leal	(%rax,%rax,2), %eax
	movl	$255, %edx
	movl	$248, %esi
	cmovel	%esi, %edx
	movl	$15, %esi
	movl	$0, %r12d
	cmovel	%r12d, %esi
	subb	%al, %r15b
	subb	%bl, %dl
	subb	%bpl, %sil
	subb	%r10b, %cl
	shlb	$4, %r15b
	orb	%cl, %r15b
	kmovd	%r15d, %k1
	vsubpd	%zmm17, %zmm9, %zmm20
	vsubpd	%zmm18, %zmm12, %zmm21
	vsubpd	%zmm19, %zmm15, %zmm22
	vsubpd	%zmm17, %zmm11, %zmm17
	vsubpd	%zmm18, %zmm14, %zmm18
	vsubpd	%zmm19, %zmm16, %zmm19
	shlb	$4, %sil
	vmulpd	%zmm22, %zmm22, %zmm23
	vfmadd231pd	%zmm21, %zmm21, %zmm23 # zmm23 = (zmm21 * zmm21) + zmm23
	vfmadd231pd	%zmm20, %zmm20, %zmm23 # zmm23 = (zmm20 * zmm20) + zmm23
	vmulpd	%zmm19, %zmm19, %zmm24
	vfmadd231pd	%zmm18, %zmm18, %zmm24 # zmm24 = (zmm18 * zmm18) + zmm24
	vfmadd231pd	%zmm17, %zmm17, %zmm24 # zmm24 = (zmm17 * zmm17) + zmm24
	vrcp14pd	%zmm23, %zmm25
	vrcp14pd	%zmm24, %zmm26
	orb	%dl, %sil
	kmovd	%esi, %k2
	vmulpd	%zmm30, %zmm25, %zmm27
	vmulpd	%zmm25, %zmm25, %zmm28
	vmulpd	%zmm27, %zmm28, %zmm27
	vmulpd	%zmm30, %zmm26, %zmm28
	vmulpd	%zmm26, %zmm26, %zmm29
	vmulpd	%zmm28, %zmm29, %zmm28
	vaddpd	%zmm2, %zmm27, %zmm29
	vmulpd	%zmm25, %zmm1, %zmm25
	vmulpd	%zmm27, %zmm25, %zmm25
	vmulpd	%zmm29, %zmm25, %zmm25
	vaddpd	%zmm2, %zmm28, %zmm27
	vmulpd	%zmm26, %zmm1, %zmm26
	vmulpd	%zmm28, %zmm26, %zmm26
	vmulpd	%zmm27, %zmm26, %zmm26
	vcmpltpd	%zmm0, %zmm23, %k1 {%k1}
	vmulpd	%zmm20, %zmm25, %zmm20 {%k1} {z}
	vmulpd	%zmm21, %zmm25, %zmm21 {%k1} {z}
	vmulpd	%zmm22, %zmm25, %zmm22 {%k1} {z}
	vcmpltpd	%zmm0, %zmm24, %k1 {%k2}
	vmulpd	%zmm17, %zmm26, %zmm17 {%k1} {z}
	vmulpd	%zmm18, %zmm26, %zmm18 {%k1} {z}
	vmulpd	%zmm19, %zmm26, %zmm19 {%k1} {z}
	vaddpd	%zmm20, %zmm17, %zmm23
	vaddpd	%zmm21, %zmm18, %zmm24
	vextractf64x4	$1, %zmm23, %ymm25
	vaddpd	%ymm23, %ymm25, %ymm23
	vmovapd	(%r11,%r13), %ymm25
	vsubpd	%ymm23, %ymm25, %ymm23
	vmovapd	64(%r11,%r13), %ymm25
	vmovapd	128(%r11,%r13), %ymm26
	vmovapd	%ymm23, (%r11,%r13)
	vaddpd	%zmm22, %zmm19, %zmm23
	vextractf64x4	$1, %zmm24, %ymm27
	vaddpd	%ymm24, %ymm27, %ymm24
	vsubpd	%ymm24, %ymm25, %ymm24
	vmovapd	%ymm24, 64(%r11,%r13)
	vextractf64x4	$1, %zmm23, %ymm24
	vaddpd	%ymm23, %ymm24, %ymm23
	vsubpd	%ymm23, %ymm26, %ymm23
	vmovapd	%ymm23, 128(%r11,%r13)
	vaddpd	%zmm10, %zmm20, %zmm10
	vaddpd	%zmm8, %zmm21, %zmm8
	vaddpd	%zmm6, %zmm22, %zmm6
	vaddpd	%zmm13, %zmm17, %zmm13
	vaddpd	%zmm7, %zmm18, %zmm7
	vaddpd	%zmm5, %zmm19, %zmm5
	cmpq	%r14, %r8
	je	.LBB1_13
# %bb.14:                               # 
                                        #   in Loop: Header=BB1_12 Depth=2
	incq	%r14
	movq	8(%rsp), %rax           # 8-byte Reload
	movq	160(%rax), %r10
	movq	176(%rax), %r11
	jmp	.LBB1_12
	.p2align	4, 0x90
.LBB1_8:                                # 
                                        #   in Loop: Header=BB1_7 Depth=1
	vxorpd	%xmm5, %xmm5, %xmm5
	movq	%rsi, %rcx
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm13, %xmm13, %xmm13
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm8, %xmm8, %xmm8
	vxorpd	%xmm10, %xmm10, %xmm10
	jmp	.LBB1_9
.LBB1_10:                               # 
	movl	$.L.str.1, %edi
	vzeroupper
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, 8(%rsp)          # 8-byte Spill
	movl	$.L.str.4, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	8(%rsp), %xmm0          # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vsubsd	24(%rsp), %xmm0, %xmm0  # 8-byte Folded Reload
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
	movq	%rcx, %r13
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %r12
	movl	$.L.str.3, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	144(%r12), %xmm0        # xmm0 = mem[0],zero
	vmovsd	%xmm0, 48(%rsp)         # 8-byte Spill
	vbroadcastsd	56(%r12), %zmm1
	vmovsd	40(%r12), %xmm0         # xmm0 = mem[0],zero
	vmovupd	%zmm0, 128(%rsp)        # 64-byte Spill
	movl	20(%r15), %r10d
	testl	%r10d, %r10d
	jle	.LBB2_5
# %bb.1:                                # 
	movq	176(%r15), %r11
	movq	192(%r15), %r9
	decq	%r10
	leaq	128(%r11), %r8
	xorl	%edi, %edi
	vxorpd	%xmm0, %xmm0, %xmm0
	jmp	.LBB2_2
	.p2align	4, 0x90
.LBB2_19:                               # 
                                        #   in Loop: Header=BB2_2 Depth=1
	cmpq	%r10, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB2_5
.LBB2_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_14 Depth 2
                                        #     Child Loop BB2_18 Depth 2
	imulq	$56, %rdi, %rax
	movl	(%r9,%rax), %eax
	testl	%eax, %eax
	jle	.LBB2_19
# %bb.3:                                # 
                                        #   in Loop: Header=BB2_2 Depth=1
	leal	(,%rdi,4), %ecx
	movl	%ecx, %edx
	andl	$-8, %edx
	leal	(%rdx,%rdx,2), %edx
	andl	$4, %ecx
	orl	%edx, %ecx
	movq	%rax, %rdx
	shrq	$3, %rdx
	movl	%ecx, %esi
	je	.LBB2_4
# %bb.13:                               # 
                                        #   in Loop: Header=BB2_2 Depth=1
	leaq	(%r11,%rsi,8), %rbx
	shlq	$6, %rdx
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB2_14:                               # 
                                        #   Parent Loop BB2_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%zmm0, (%rbx,%rcx)
	addq	$64, %rcx
	cmpq	%rcx, %rdx
	jne	.LBB2_14
# %bb.15:                               # 
                                        #   in Loop: Header=BB2_2 Depth=1
	movl	%eax, %ebx
	andl	$-8, %ebx
	leaq	(%rbx,%rsi), %rcx
	vmovupd	%zmm0, (%r11,%rcx,8)
	vmovupd	%zmm0, 64(%r11,%rcx,8)
	cmpq	%rax, %rbx
	jae	.LBB2_19
	jmp	.LBB2_17
	.p2align	4, 0x90
.LBB2_4:                                # 
                                        #   in Loop: Header=BB2_2 Depth=1
	movl	%eax, %ebx
	andl	$-8, %ebx
	cmpq	%rax, %rbx
	jae	.LBB2_19
.LBB2_17:                               # 
                                        #   in Loop: Header=BB2_2 Depth=1
	leaq	(%r8,%rsi,8), %rdx
	.p2align	4, 0x90
.LBB2_18:                               # 
                                        #   Parent Loop BB2_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, -128(%rdx,%rbx,8)
	movq	$0, -64(%rdx,%rbx,8)
	movq	$0, (%rdx,%rbx,8)
	incq	%rbx
	cmpq	%rbx, %rax
	jne	.LBB2_18
	jmp	.LBB2_19
.LBB2_5:                                # 
	xorl	%eax, %eax
	vmovupd	%zmm1, 64(%rsp)         # 64-byte Spill
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 56(%rsp)         # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	vmovupd	64(%rsp), %zmm29        # 64-byte Reload
	cmpl	$0, 20(%r15)
	jle	.LBB2_10
# %bb.6:                                # 
	vmovsd	48(%rsp), %xmm0         # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm0
	vbroadcastsd	%xmm0, %zmm0
	vmovupd	128(%rsp), %zmm1        # 64-byte Reload
	vmulsd	.LCPI2_0(%rip), %xmm1, %xmm1
	vbroadcastsd	%xmm1, %zmm1
	xorl	%eax, %eax
	vbroadcastsd	.LCPI2_1(%rip), %zmm2 # zmm2 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	movb	$-52, %r8b
	vmovdqa	.LCPI2_2(%rip), %xmm3   # xmm3 = <1,u>
	jmp	.LBB2_7
	.p2align	4, 0x90
.LBB2_8:                                # 
                                        #   in Loop: Header=BB2_7 Depth=1
	vxorpd	%xmm4, %xmm4, %xmm4
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm10, %xmm10, %xmm10
	vxorpd	%xmm5, %xmm5, %xmm5
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm11, %xmm11, %xmm11
.LBB2_9:                                # 
                                        #   in Loop: Header=BB2_7 Depth=1
	vpermpd	$238, %zmm11, %zmm8     # zmm8 = zmm11[2,3,2,3,6,7,6,7]
	vaddpd	%zmm11, %zmm8, %zmm8
	vpermpd	$68, %zmm10, %zmm9      # zmm9 = zmm10[0,1,0,1,4,5,4,5]
	kmovd	%r8d, %k1
	vaddpd	%zmm10, %zmm9, %zmm8 {%k1}
	vpermilpd	$85, %zmm8, %zmm9 # zmm9 = zmm8[1,0,3,2,5,4,7,6]
	vaddpd	%zmm8, %zmm9, %zmm8
	vextractf64x4	$1, %zmm8, %ymm9
	vblendpd	$10, %ymm9, %ymm8, %ymm8 # ymm8 = ymm8[0],ymm9[1],ymm8[2],ymm9[3]
	vaddpd	(%r9,%r10,8), %ymm8, %ymm8
	vmovapd	%ymm8, (%r9,%r10,8)
	vpermpd	$238, %zmm7, %zmm8      # zmm8 = zmm7[2,3,2,3,6,7,6,7]
	vaddpd	%zmm7, %zmm8, %zmm7
	vpermpd	$68, %zmm6, %zmm8       # zmm8 = zmm6[0,1,0,1,4,5,4,5]
	vaddpd	%zmm6, %zmm8, %zmm7 {%k1}
	vpermilpd	$85, %zmm7, %zmm6 # zmm6 = zmm7[1,0,3,2,5,4,7,6]
	vaddpd	%zmm7, %zmm6, %zmm6
	vextractf64x4	$1, %zmm6, %ymm7
	vblendpd	$10, %ymm7, %ymm6, %ymm6 # ymm6 = ymm6[0],ymm7[1],ymm6[2],ymm7[3]
	vaddpd	64(%r9,%r10,8), %ymm6, %ymm6
	vmovapd	%ymm6, 64(%r9,%r10,8)
	vpermpd	$238, %zmm5, %zmm6      # zmm6 = zmm5[2,3,2,3,6,7,6,7]
	vaddpd	%zmm5, %zmm6, %zmm5
	vpermpd	$68, %zmm4, %zmm6       # zmm6 = zmm4[0,1,0,1,4,5,4,5]
	vaddpd	%zmm4, %zmm6, %zmm5 {%k1}
	vpermilpd	$85, %zmm5, %zmm4 # zmm4 = zmm5[1,0,3,2,5,4,7,6]
	vaddpd	%zmm5, %zmm4, %zmm4
	vextractf64x4	$1, %zmm4, %ymm5
	vblendpd	$10, %ymm5, %ymm4, %ymm4 # ymm4 = ymm4[0],ymm5[1],ymm4[2],ymm5[3]
	vaddpd	128(%r9,%r10,8), %ymm4, %ymm4
	vmovapd	%ymm4, 128(%r9,%r10,8)
	vpinsrq	$1, %r11, %xmm3, %xmm4
	vpaddq	(%r13), %xmm4, %xmm4
	vmovdqu	%xmm4, (%r13)
	addq	%r11, 16(%r13)
	incq	%rax
	movslq	20(%r15), %rcx
	cmpq	%rcx, %rax
	jge	.LBB2_10
.LBB2_7:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_12 Depth 2
	leal	(,%rax,4), %r10d
	movl	%r10d, %ecx
	andl	$-8, %ecx
	leal	(%rcx,%rcx,2), %ecx
	andl	$4, %r10d
	orl	%ecx, %r10d
	movq	176(%r15), %r9
	movq	24(%r14), %rcx
	movslq	(%rcx,%rax,4), %r11
	testq	%r11, %r11
	jle	.LBB2_8
# %bb.11:                               # 
                                        #   in Loop: Header=BB2_7 Depth=1
	movq	160(%r15), %rcx
	movq	8(%r14), %rdi
	vbroadcastsd	(%rcx,%r10,8), %zmm4
	vbroadcastsd	8(%rcx,%r10,8), %ymm5
	vbroadcastsd	16(%rcx,%r10,8), %zmm6
	vinsertf64x4	$1, %ymm5, %zmm4, %zmm8
	vbroadcastsd	24(%rcx,%r10,8), %ymm4
	vinsertf64x4	$1, %ymm4, %zmm6, %zmm9
	vbroadcastsd	64(%rcx,%r10,8), %zmm4
	vbroadcastsd	72(%rcx,%r10,8), %ymm5
	vbroadcastsd	80(%rcx,%r10,8), %zmm6
	vbroadcastsd	88(%rcx,%r10,8), %ymm7
	vinsertf64x4	$1, %ymm5, %zmm4, %zmm12
	vinsertf64x4	$1, %ymm7, %zmm6, %zmm13
	vbroadcastsd	128(%rcx,%r10,8), %zmm4
	vbroadcastsd	136(%rcx,%r10,8), %ymm5
	vinsertf64x4	$1, %ymm5, %zmm4, %zmm14
	vbroadcastsd	144(%rcx,%r10,8), %zmm4
	vbroadcastsd	152(%rcx,%r10,8), %ymm5
	vinsertf64x4	$1, %ymm5, %zmm4, %zmm15
	movl	%r11d, %r11d
	movl	16(%r14), %ebx
	imull	%eax, %ebx
	movslq	%ebx, %rbx
	leaq	(%rdi,%rbx,4), %r12
	vxorpd	%xmm11, %xmm11, %xmm11
	movl	$0, %edi
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm5, %xmm5, %xmm5
	vxorpd	%xmm10, %xmm10, %xmm10
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm4, %xmm4, %xmm4
	.p2align	4, 0x90
.LBB2_12:                               # 
                                        #   Parent Loop BB2_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%r12,%rdi,4), %rdx
	leaq	(%rdx,%rdx,2), %rsi
	shlq	$6, %rsi
	vbroadcastf64x4	128(%rcx,%rsi), %zmm16 # zmm16 = mem[0,1,2,3,0,1,2,3]
	vbroadcastf64x4	64(%rcx,%rsi), %zmm19 # zmm19 = mem[0,1,2,3,0,1,2,3]
	vsubpd	%zmm19, %zmm12, %zmm18
	vsubpd	%zmm16, %zmm14, %zmm17
	vsubpd	%zmm16, %zmm15, %zmm16
	leal	(%rdx,%rdx), %ebx
	vbroadcastf64x4	(%rcx,%rsi), %zmm20 # zmm20 = mem[0,1,2,3,0,1,2,3]
	cmpq	%rbx, %rax
	setne	%sil
	sete	%bl
	addl	%edx, %edx
	incl	%edx
	cmpq	%rdx, %rax
	vsubpd	%zmm20, %zmm8, %zmm21
	sete	%dl
	movl	%edx, %ebp
	shlb	$4, %bpl
	notb	%bpl
	subb	%bl, %bpl
	shlb	$2, %sil
	vsubpd	%zmm20, %zmm9, %zmm20
	shlb	$6, %dl
	subb	%dl, %sil
	addb	$-5, %sil
	orb	$16, %bpl
	kmovd	%ebp, %k2
	orb	$112, %sil
	kmovd	%esi, %k1
	vsubpd	%zmm19, %zmm13, %zmm19
	vmulpd	%zmm17, %zmm17, %zmm22
	vfmadd231pd	%zmm18, %zmm18, %zmm22 # zmm22 = (zmm18 * zmm18) + zmm22
	vfmadd231pd	%zmm21, %zmm21, %zmm22 # zmm22 = (zmm21 * zmm21) + zmm22
	vmulpd	%zmm16, %zmm16, %zmm23
	vfmadd231pd	%zmm19, %zmm19, %zmm23 # zmm23 = (zmm19 * zmm19) + zmm23
	vfmadd231pd	%zmm20, %zmm20, %zmm23 # zmm23 = (zmm20 * zmm20) + zmm23
	vrcp14pd	%zmm22, %zmm24
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
	vcmpltpd	%zmm0, %zmm22, %k2 {%k2}
	vfmadd231pd	%zmm21, %zmm24, %zmm11 {%k2} # zmm11 = (zmm24 * zmm21) + zmm11
	vfmadd231pd	%zmm18, %zmm24, %zmm7 {%k2} # zmm7 = (zmm24 * zmm18) + zmm7
	vfmadd231pd	%zmm17, %zmm24, %zmm5 {%k2} # zmm5 = (zmm24 * zmm17) + zmm5
	vcmpltpd	%zmm0, %zmm23, %k1 {%k1}
	vfmadd231pd	%zmm20, %zmm25, %zmm10 {%k1} # zmm10 = (zmm25 * zmm20) + zmm10
	vfmadd231pd	%zmm19, %zmm25, %zmm6 {%k1} # zmm6 = (zmm25 * zmm19) + zmm6
	vfmadd231pd	%zmm16, %zmm25, %zmm4 {%k1} # zmm4 = (zmm25 * zmm16) + zmm4
	incq	%rdi
	cmpq	%rdi, %r11
	jne	.LBB2_12
	jmp	.LBB2_9
.LBB2_10:                               # 
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
	vsubsd	56(%rsp), %xmm0, %xmm0  # 8-byte Folded Reload
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
	movq	%rcx, 24(%rsp)          # 8-byte Spill
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %r12
	movl	$.L.str.5, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	144(%r12), %xmm0        # xmm0 = mem[0],zero
	vmovsd	%xmm0, 128(%rsp)        # 8-byte Spill
	vbroadcastsd	56(%r12), %zmm0
	vmovups	%zmm0, 576(%rsp)        # 64-byte Spill
	vmovsd	40(%r12), %xmm0         # xmm0 = mem[0],zero
	vmovupd	%zmm0, 64(%rsp)         # 64-byte Spill
	xorl	%eax, %eax
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 8(%rsp)          # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	movl	20(%r15), %r10d
	testl	%r10d, %r10d
	jle	.LBB4_5
# %bb.1:                                # 
	vmovsd	128(%rsp), %xmm0        # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm0
	vbroadcastsd	%xmm0, %zmm0
	vmovupd	%zmm0, 512(%rsp)        # 64-byte Spill
	movq	176(%r15), %rbx
	movq	192(%r15), %r9
	decq	%r10
	leaq	128(%rbx), %r8
	xorl	%esi, %esi
	vxorpd	%xmm1, %xmm1, %xmm1
	jmp	.LBB4_2
	.p2align	4, 0x90
.LBB4_20:                               # 
                                        #   in Loop: Header=BB4_2 Depth=1
	cmpq	%r10, %rsi
	leaq	1(%rsi), %rsi
	je	.LBB4_21
.LBB4_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_15 Depth 2
                                        #     Child Loop BB4_19 Depth 2
	imulq	$56, %rsi, %rax
	movl	(%r9,%rax), %edx
	testl	%edx, %edx
	jle	.LBB4_20
# %bb.3:                                # 
                                        #   in Loop: Header=BB4_2 Depth=1
	leal	(,%rsi,4), %eax
	movl	%eax, %ecx
	andl	$-8, %ecx
	leal	(%rcx,%rcx,2), %ecx
	andl	$4, %eax
	orl	%ecx, %eax
	movq	%rdx, %rdi
	shrq	$3, %rdi
	movl	%eax, %ebp
	je	.LBB4_4
# %bb.14:                               # 
                                        #   in Loop: Header=BB4_2 Depth=1
	leaq	(%rbx,%rbp,8), %rcx
	shlq	$6, %rdi
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB4_15:                               # 
                                        #   Parent Loop BB4_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%zmm1, (%rcx,%rax)
	addq	$64, %rax
	cmpq	%rax, %rdi
	jne	.LBB4_15
# %bb.16:                               # 
                                        #   in Loop: Header=BB4_2 Depth=1
	movl	%edx, %edi
	andl	$-8, %edi
	leaq	(%rdi,%rbp), %rax
	vmovupd	%zmm1, (%rbx,%rax,8)
	vmovupd	%zmm1, 64(%rbx,%rax,8)
	cmpq	%rdx, %rdi
	jae	.LBB4_20
	jmp	.LBB4_18
	.p2align	4, 0x90
.LBB4_4:                                # 
                                        #   in Loop: Header=BB4_2 Depth=1
	movl	%edx, %edi
	andl	$-8, %edi
	cmpq	%rdx, %rdi
	jae	.LBB4_20
.LBB4_18:                               # 
                                        #   in Loop: Header=BB4_2 Depth=1
	leaq	(%r8,%rbp,8), %rcx
	.p2align	4, 0x90
.LBB4_19:                               # 
                                        #   Parent Loop BB4_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, -128(%rcx,%rdi,8)
	movq	$0, -64(%rcx,%rdi,8)
	movq	$0, (%rcx,%rdi,8)
	incq	%rdi
	cmpq	%rdi, %rdx
	jne	.LBB4_19
	jmp	.LBB4_20
.LBB4_21:                               # 
	vmovupd	64(%rsp), %zmm0         # 64-byte Reload
	vmulsd	.LCPI4_0(%rip), %xmm0, %xmm0
	vbroadcastsd	%xmm0, %zmm0
	vmovupd	%zmm0, 448(%rsp)        # 64-byte Spill
	xorl	%r13d, %r13d
	movq	%r14, 16(%rsp)          # 8-byte Spill
	movq	%r15, (%rsp)            # 8-byte Spill
	.p2align	4, 0x90
.LBB4_6:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_11 Depth 2
	leal	(,%r13,4), %eax
	movl	%eax, %edi
	andl	$-8, %edi
	leal	(%rdi,%rdi,2), %edi
	andl	$4, %eax
	orl	%edi, %eax
	movq	24(%r14), %rdi
	movslq	(%rdi,%r13,4), %rcx
	testq	%rcx, %rcx
	jle	.LBB4_7
# %bb.10:                               # 
                                        #   in Loop: Header=BB4_6 Depth=1
	movq	160(%r15), %r15
	vbroadcastsd	(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 1344(%rsp)       # 64-byte Spill
	vbroadcastsd	8(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 1280(%rsp)       # 64-byte Spill
	vbroadcastsd	16(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 1216(%rsp)       # 64-byte Spill
	vbroadcastsd	24(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 1152(%rsp)       # 64-byte Spill
	vbroadcastsd	64(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 1088(%rsp)       # 64-byte Spill
	vbroadcastsd	72(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 1024(%rsp)       # 64-byte Spill
	vbroadcastsd	80(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 960(%rsp)        # 64-byte Spill
	vbroadcastsd	88(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 896(%rsp)        # 64-byte Spill
	vbroadcastsd	128(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 832(%rsp)        # 64-byte Spill
	vbroadcastsd	136(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 768(%rsp)        # 64-byte Spill
	movq	8(%r14), %rdi
	vbroadcastsd	144(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 704(%rsp)        # 64-byte Spill
	movq	%rax, 48(%rsp)          # 8-byte Spill
	vbroadcastsd	152(%r15,%rax,8), %zmm0
	vmovups	%zmm0, 640(%rsp)        # 64-byte Spill
	movq	%rcx, 40(%rsp)          # 8-byte Spill
	movl	%ecx, %eax
	movl	16(%r14), %ebp
	imull	%r13d, %ebp
	movslq	%ebp, %rbp
	leaq	(%rdi,%rbp,4), %r10
	movq	%rax, 32(%rsp)          # 8-byte Spill
	leaq	-1(%rax), %r9
	vxorpd	%xmm14, %xmm14, %xmm14
	movq	%rbx, 56(%rsp)          # 8-byte Spill
	movq	%rbx, %r8
	movl	$0, %r14d
	vxorpd	%xmm12, %xmm12, %xmm12
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%zmm0, 320(%rsp)        # 64-byte Spill
	vxorpd	%xmm15, %xmm15, %xmm15
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%zmm0, 192(%rsp)        # 64-byte Spill
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%zmm0, 128(%rsp)        # 64-byte Spill
	vxorpd	%xmm16, %xmm16, %xmm16
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%zmm0, 384(%rsp)        # 64-byte Spill
	vxorpd	%xmm13, %xmm13, %xmm13
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%zmm0, 256(%rsp)        # 64-byte Spill
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%zmm0, 64(%rsp)         # 64-byte Spill
	.p2align	4, 0x90
.LBB4_11:                               # 
                                        #   Parent Loop BB4_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%r10,%r14,4), %r11
	movq	%r11, %rax
	shlq	$6, %rax
	leaq	(%rax,%rax,2), %r12
	vmovapd	(%r15,%r12), %zmm18
	vmovapd	64(%r15,%r12), %zmm22
	vmovapd	128(%r15,%r12), %zmm24
	vmovupd	1344(%rsp), %zmm0       # 64-byte Reload
	vsubpd	%zmm18, %zmm0, %zmm3
	vmovupd	1088(%rsp), %zmm0       # 64-byte Reload
	vsubpd	%zmm22, %zmm0, %zmm19
	vmovupd	832(%rsp), %zmm0        # 64-byte Reload
	vsubpd	%zmm24, %zmm0, %zmm23
	vmovupd	1280(%rsp), %zmm0       # 64-byte Reload
	vsubpd	%zmm18, %zmm0, %zmm29
	vmovupd	1024(%rsp), %zmm0       # 64-byte Reload
	vsubpd	%zmm22, %zmm0, %zmm4
	vmovupd	768(%rsp), %zmm0        # 64-byte Reload
	vsubpd	%zmm24, %zmm0, %zmm20
	vmovupd	1216(%rsp), %zmm0       # 64-byte Reload
	vsubpd	%zmm18, %zmm0, %zmm30
	vmovupd	960(%rsp), %zmm0        # 64-byte Reload
	vsubpd	%zmm22, %zmm0, %zmm17
	vmovupd	704(%rsp), %zmm0        # 64-byte Reload
	vsubpd	%zmm24, %zmm0, %zmm21
	vmovupd	1152(%rsp), %zmm0       # 64-byte Reload
	vsubpd	%zmm18, %zmm0, %zmm31
	vmovupd	896(%rsp), %zmm0        # 64-byte Reload
	vsubpd	%zmm22, %zmm0, %zmm18
	vmovupd	640(%rsp), %zmm0        # 64-byte Reload
	vsubpd	%zmm24, %zmm0, %zmm22
	vmulpd	%zmm23, %zmm23, %zmm24
	vfmadd231pd	%zmm19, %zmm19, %zmm24 # zmm24 = (zmm19 * zmm19) + zmm24
	vfmadd231pd	%zmm3, %zmm3, %zmm24 # zmm24 = (zmm3 * zmm3) + zmm24
	vmulpd	%zmm20, %zmm20, %zmm25
	vfmadd231pd	%zmm4, %zmm4, %zmm25 # zmm25 = (zmm4 * zmm4) + zmm25
	vfmadd231pd	%zmm29, %zmm29, %zmm25 # zmm25 = (zmm29 * zmm29) + zmm25
	vmulpd	%zmm21, %zmm21, %zmm26
	vfmadd231pd	%zmm17, %zmm17, %zmm26 # zmm26 = (zmm17 * zmm17) + zmm26
	vfmadd231pd	%zmm30, %zmm30, %zmm26 # zmm26 = (zmm30 * zmm30) + zmm26
	vmulpd	%zmm22, %zmm22, %zmm27
	vfmadd231pd	%zmm18, %zmm18, %zmm27 # zmm27 = (zmm18 * zmm18) + zmm27
	vrcp14pd	%zmm24, %zmm28
	vrcp14pd	%zmm25, %zmm2
	vrcp14pd	%zmm26, %zmm0
	vfmadd231pd	%zmm31, %zmm31, %zmm27 # zmm27 = (zmm31 * zmm31) + zmm27
	vrcp14pd	%zmm27, %zmm1
	vmovupd	576(%rsp), %zmm9        # 64-byte Reload
	vmulpd	%zmm9, %zmm28, %zmm5
	vmulpd	%zmm28, %zmm28, %zmm6
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
	vmovupd	448(%rsp), %zmm10       # 64-byte Reload
	vmulpd	%zmm28, %zmm10, %zmm9
	vmulpd	%zmm5, %zmm9, %zmm9
	vbroadcastsd	.LCPI4_1(%rip), %zmm28 # zmm28 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vaddpd	%zmm28, %zmm5, %zmm5
	vmulpd	%zmm5, %zmm9, %zmm5
	vmulpd	%zmm2, %zmm10, %zmm2
	vmulpd	%zmm6, %zmm2, %zmm2
	vaddpd	%zmm28, %zmm6, %zmm6
	vmulpd	%zmm6, %zmm2, %zmm2
	vmulpd	%zmm0, %zmm10, %zmm0
	vmulpd	%zmm7, %zmm0, %zmm0
	vaddpd	%zmm28, %zmm7, %zmm6
	vmulpd	%zmm6, %zmm0, %zmm0
	vmulpd	%zmm1, %zmm10, %zmm1
	vmulpd	%zmm8, %zmm1, %zmm1
	vaddpd	%zmm28, %zmm8, %zmm6
	vmulpd	%zmm6, %zmm1, %zmm1
	leal	(%r11,%r11), %eax
	leal	(%r11,%r11), %edx
	incl	%edx
	xorl	%esi, %esi
	cmpq	%rax, %r13
	sete	%r15b
	setne	%sil
	movl	$255, %ebx
	movl	$248, %ecx
	cmovel	%ecx, %ebx
	movl	$255, %edi
	movl	$240, %ecx
	cmovel	%ecx, %edi
	cmpq	%rdx, %r13
	sete	%r11b
	movl	$255, %ebp
	movl	$224, %ecx
	cmovel	%ecx, %ebp
	movl	$0, %ecx
	movl	$63, %edx
	cmovel	%edx, %ecx
	movl	$0, %edx
	movl	$127, %eax
	cmovel	%eax, %edx
	subb	%r15b, %bpl
	kmovd	%ebp, %k1
	vmovupd	512(%rsp), %zmm28       # 64-byte Reload
	vcmpltpd	%zmm28, %zmm24, %k1 {%k1}
	vmulpd	%zmm3, %zmm5, %zmm3 {%k1} {z}
	vmulpd	%zmm19, %zmm5, %zmm6 {%k1} {z}
	vmulpd	%zmm23, %zmm5, %zmm5 {%k1} {z}
	leal	(%rsi,%rsi,2), %eax
	addl	$252, %eax
	subb	%cl, %al
	kmovd	%eax, %k1
	vcmpltpd	%zmm28, %zmm25, %k1 {%k1}
	vmulpd	%zmm29, %zmm2, %zmm7 {%k1} {z}
	vmulpd	%zmm4, %zmm2, %zmm4 {%k1} {z}
	vmulpd	%zmm20, %zmm2, %zmm2 {%k1} {z}
	subb	%dl, %bl
	kmovd	%ebx, %k1
	vcmpltpd	%zmm28, %zmm26, %k1 {%k1}
	vmulpd	%zmm30, %zmm0, %zmm8 {%k1} {z}
	vmulpd	%zmm17, %zmm0, %zmm9 {%k1} {z}
	vmulpd	%zmm21, %zmm0, %zmm0 {%k1} {z}
	addb	%r11b, %dil
	kmovd	%edi, %k1
	vcmpltpd	%zmm28, %zmm27, %k1 {%k1}
	vmulpd	%zmm31, %zmm1, %zmm17 {%k1} {z}
	vmulpd	%zmm18, %zmm1, %zmm18 {%k1} {z}
	vmulpd	%zmm22, %zmm1, %zmm1 {%k1} {z}
	vaddpd	%zmm14, %zmm3, %zmm14
	vaddpd	%zmm15, %zmm7, %zmm15
	vaddpd	%zmm16, %zmm8, %zmm16
	vaddpd	%zmm13, %zmm17, %zmm13
	vaddpd	%zmm7, %zmm3, %zmm3
	vaddpd	%zmm17, %zmm8, %zmm7
	vaddpd	%zmm7, %zmm3, %zmm3
	vmovapd	(%r8,%r12), %zmm7
	vmovapd	64(%r8,%r12), %zmm8
	vmovapd	128(%r8,%r12), %zmm17
	vsubpd	%zmm3, %zmm7, %zmm3
	vmovapd	%zmm3, (%r8,%r12)
	vaddpd	%zmm12, %zmm6, %zmm12
	vmovupd	192(%rsp), %zmm10       # 64-byte Reload
	vaddpd	%zmm10, %zmm4, %zmm10
	vaddpd	%zmm4, %zmm6, %zmm3
	vaddpd	%zmm11, %zmm9, %zmm11
	vaddpd	%zmm18, %zmm9, %zmm4
	vaddpd	%zmm4, %zmm3, %zmm3
	vsubpd	%zmm3, %zmm8, %zmm3
	vmovapd	%zmm3, 64(%r8,%r12)
	vmovupd	256(%rsp), %zmm9        # 64-byte Reload
	vaddpd	%zmm9, %zmm18, %zmm9
	vmovupd	320(%rsp), %zmm8        # 64-byte Reload
	vaddpd	%zmm8, %zmm5, %zmm8
	vmovupd	128(%rsp), %zmm6        # 64-byte Reload
	vaddpd	%zmm6, %zmm2, %zmm6
	vaddpd	%zmm2, %zmm5, %zmm2
	vmovupd	384(%rsp), %zmm7        # 64-byte Reload
	vaddpd	%zmm7, %zmm0, %zmm7
	vmovupd	64(%rsp), %zmm5         # 64-byte Reload
	vaddpd	%zmm5, %zmm1, %zmm5
	vaddpd	%zmm1, %zmm0, %zmm0
	vaddpd	%zmm0, %zmm2, %zmm0
	vsubpd	%zmm0, %zmm17, %zmm0
	vmovapd	%zmm0, 128(%r8,%r12)
	cmpq	%r14, %r9
	je	.LBB4_12
# %bb.13:                               # 
                                        #   in Loop: Header=BB4_11 Depth=2
	vmovupd	%zmm10, 192(%rsp)       # 64-byte Spill
	vmovupd	%zmm9, 256(%rsp)        # 64-byte Spill
	vmovupd	%zmm8, 320(%rsp)        # 64-byte Spill
	vmovupd	%zmm7, 384(%rsp)        # 64-byte Spill
	vmovupd	%zmm6, 128(%rsp)        # 64-byte Spill
	vmovupd	%zmm5, 64(%rsp)         # 64-byte Spill
	incq	%r14
	movq	(%rsp), %rax            # 8-byte Reload
	movq	160(%rax), %r15
	movq	176(%rax), %r8
	jmp	.LBB4_11
	.p2align	4, 0x90
.LBB4_12:                               # 
                                        #   in Loop: Header=BB4_6 Depth=1
	movq	16(%rsp), %r14          # 8-byte Reload
	movq	(%rsp), %r15            # 8-byte Reload
	movq	56(%rsp), %rbx          # 8-byte Reload
	movq	48(%rsp), %rax          # 8-byte Reload
	movq	40(%rsp), %rcx          # 8-byte Reload
	movq	32(%rsp), %rdx          # 8-byte Reload
	jmp	.LBB4_8
	.p2align	4, 0x90
.LBB4_7:                                # 
                                        #   in Loop: Header=BB4_6 Depth=1
	vxorpd	%xmm5, %xmm5, %xmm5
	movq	%rcx, %rdx
	vxorpd	%xmm9, %xmm9, %xmm9
	vxorpd	%xmm13, %xmm13, %xmm13
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorpd	%xmm16, %xmm16, %xmm16
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm10, %xmm10, %xmm10
	vxorpd	%xmm15, %xmm15, %xmm15
	vxorpd	%xmm8, %xmm8, %xmm8
	vxorpd	%xmm12, %xmm12, %xmm12
	vxorpd	%xmm14, %xmm14, %xmm14
.LBB4_8:                                # 
                                        #   in Loop: Header=BB4_6 Depth=1
	vpermilpd	$85, %zmm14, %zmm3 # zmm3 = zmm14[1,0,3,2,5,4,7,6]
	vaddpd	%zmm14, %zmm3, %zmm3
	vpermilpd	$85, %zmm16, %zmm4 # zmm4 = zmm16[1,0,3,2,5,4,7,6]
	vaddpd	%zmm16, %zmm4, %zmm4
	vmovddup	%zmm15, %zmm14  # zmm14 = zmm15[0,0,2,2,4,4,6,6]
	vaddpd	%zmm15, %zmm14, %zmm14
	vshufpd	$170, %zmm14, %zmm3, %zmm3 # zmm3 = zmm3[0],zmm14[1],zmm3[2],zmm14[3],zmm3[4],zmm14[5],zmm3[6],zmm14[7]
	vmovddup	%zmm13, %zmm14  # zmm14 = zmm13[0,0,2,2,4,4,6,6]
	vaddpd	%zmm13, %zmm14, %zmm13
	vshufpd	$170, %zmm13, %zmm4, %zmm4 # zmm4 = zmm4[0],zmm13[1],zmm4[2],zmm13[3],zmm4[4],zmm13[5],zmm4[6],zmm13[7]
	vextractf64x4	$1, %zmm3, %ymm13
	vaddpd	%zmm3, %zmm13, %zmm3
	vinsertf64x4	$1, %ymm4, %zmm0, %zmm13
	vaddpd	%zmm4, %zmm13, %zmm4
	vshuff64x2	$228, %zmm4, %zmm3, %zmm3 # zmm3 = zmm3[0,1,2,3],zmm4[4,5,6,7]
	vpermpd	$78, %zmm3, %zmm4       # zmm4 = zmm3[2,3,0,1,6,7,4,5]
	vaddpd	%zmm3, %zmm4, %zmm3
	vextractf64x4	$1, %zmm3, %ymm4
	vblendpd	$12, %ymm4, %ymm3, %ymm3 # ymm3 = ymm3[0,1],ymm4[2,3]
	vaddpd	(%rbx,%rax,8), %ymm3, %ymm3
	vmovapd	%ymm3, (%rbx,%rax,8)
	vpermilpd	$85, %zmm12, %zmm3 # zmm3 = zmm12[1,0,3,2,5,4,7,6]
	vaddpd	%zmm12, %zmm3, %zmm3
	vpermilpd	$85, %zmm11, %zmm4 # zmm4 = zmm11[1,0,3,2,5,4,7,6]
	vaddpd	%zmm11, %zmm4, %zmm4
	vmovddup	%zmm10, %zmm11  # zmm11 = zmm10[0,0,2,2,4,4,6,6]
	vaddpd	%zmm10, %zmm11, %zmm10
	vshufpd	$170, %zmm10, %zmm3, %zmm3 # zmm3 = zmm3[0],zmm10[1],zmm3[2],zmm10[3],zmm3[4],zmm10[5],zmm3[6],zmm10[7]
	vmovddup	%zmm9, %zmm10   # zmm10 = zmm9[0,0,2,2,4,4,6,6]
	vaddpd	%zmm9, %zmm10, %zmm9
	vshufpd	$170, %zmm9, %zmm4, %zmm4 # zmm4 = zmm4[0],zmm9[1],zmm4[2],zmm9[3],zmm4[4],zmm9[5],zmm4[6],zmm9[7]
	vextractf64x4	$1, %zmm3, %ymm9
	vaddpd	%zmm3, %zmm9, %zmm3
	vinsertf64x4	$1, %ymm4, %zmm0, %zmm9
	vaddpd	%zmm4, %zmm9, %zmm4
	vshuff64x2	$228, %zmm4, %zmm3, %zmm3 # zmm3 = zmm3[0,1,2,3],zmm4[4,5,6,7]
	vpermpd	$78, %zmm3, %zmm4       # zmm4 = zmm3[2,3,0,1,6,7,4,5]
	vaddpd	%zmm3, %zmm4, %zmm3
	vextractf64x4	$1, %zmm3, %ymm4
	vblendpd	$12, %ymm4, %ymm3, %ymm3 # ymm3 = ymm3[0,1],ymm4[2,3]
	vaddpd	64(%rbx,%rax,8), %ymm3, %ymm3
	vmovapd	%ymm3, 64(%rbx,%rax,8)
	vpermilpd	$85, %zmm8, %zmm3 # zmm3 = zmm8[1,0,3,2,5,4,7,6]
	vaddpd	%zmm8, %zmm3, %zmm3
	vpermilpd	$85, %zmm7, %zmm4 # zmm4 = zmm7[1,0,3,2,5,4,7,6]
	vaddpd	%zmm7, %zmm4, %zmm4
	vmovddup	%zmm6, %zmm7    # zmm7 = zmm6[0,0,2,2,4,4,6,6]
	vaddpd	%zmm6, %zmm7, %zmm6
	vshufpd	$170, %zmm6, %zmm3, %zmm3 # zmm3 = zmm3[0],zmm6[1],zmm3[2],zmm6[3],zmm3[4],zmm6[5],zmm3[6],zmm6[7]
	vmovddup	%zmm5, %zmm6    # zmm6 = zmm5[0,0,2,2,4,4,6,6]
	vaddpd	%zmm5, %zmm6, %zmm5
	vshufpd	$170, %zmm5, %zmm4, %zmm4 # zmm4 = zmm4[0],zmm5[1],zmm4[2],zmm5[3],zmm4[4],zmm5[5],zmm4[6],zmm5[7]
	vextractf64x4	$1, %zmm3, %ymm5
	vaddpd	%zmm3, %zmm5, %zmm3
	vinsertf64x4	$1, %ymm4, %zmm0, %zmm5
	vaddpd	%zmm4, %zmm5, %zmm4
	vshuff64x2	$228, %zmm4, %zmm3, %zmm3 # zmm3 = zmm3[0,1,2,3],zmm4[4,5,6,7]
	vpermpd	$78, %zmm3, %zmm4       # zmm4 = zmm3[2,3,0,1,6,7,4,5]
	vaddpd	%zmm3, %zmm4, %zmm3
	vextractf64x4	$1, %zmm3, %ymm4
	vblendpd	$12, %ymm4, %ymm3, %ymm3 # ymm3 = ymm3[0,1],ymm4[2,3]
	vaddpd	128(%rbx,%rax,8), %ymm3, %ymm3
	vmovapd	%ymm3, 128(%rbx,%rax,8)
	vmovdqa	.LCPI4_2(%rip), %xmm0   # xmm0 = <1,u>
	vpinsrq	$1, %rdx, %xmm0, %xmm3
	movq	24(%rsp), %rax          # 8-byte Reload
	vpaddq	(%rax), %xmm3, %xmm3
	vmovdqu	%xmm3, (%rax)
	vcvtsi2sd	%ecx, %xmm19, %xmm3
	vmulsd	.LCPI4_3(%rip), %xmm3, %xmm3
	vcvttsd2si	%xmm3, %rsi
	addq	%rsi, 16(%rax)
	incq	%r13
	movslq	20(%r15), %rsi
	cmpq	%rsi, %r13
	jge	.LBB4_5
# %bb.9:                                # 
                                        #   in Loop: Header=BB4_6 Depth=1
	movq	176(%r15), %rbx
	jmp	.LBB4_6
.LBB4_5:                                # 
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
	vsubsd	8(%rsp), %xmm0, %xmm0   # 8-byte Folded Reload
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
.LCPI5_3:
	.quad	4602678819172646912     #  0.5
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
	subq	$520, %rsp              # imm = 0x208
	.cfi_def_cfa_offset 576
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
	movl	$.L.str.5, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	144(%r12), %xmm0        # xmm0 = mem[0],zero
	vmovsd	%xmm0, 128(%rsp)        # 8-byte Spill
	vbroadcastsd	56(%r12), %zmm0
	vmovups	%zmm0, 192(%rsp)        # 64-byte Spill
	vmovsd	40(%r12), %xmm0         # xmm0 = mem[0],zero
	vmovupd	%zmm0, 64(%rsp)         # 64-byte Spill
	xorl	%eax, %eax
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 48(%rsp)         # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	movl	20(%rbp), %r11d
	testl	%r11d, %r11d
	jle	.LBB5_5
# %bb.1:                                # 
	vmovsd	128(%rsp), %xmm0        # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm0
	vbroadcastsd	%xmm0, %zmm0
	movq	176(%rbp), %r9
	movq	192(%rbp), %r10
	decq	%r11
	leaq	128(%r9), %r8
	xorl	%esi, %esi
	vxorps	%xmm1, %xmm1, %xmm1
	jmp	.LBB5_2
	.p2align	4, 0x90
.LBB5_19:                               # 
                                        #   in Loop: Header=BB5_2 Depth=1
	cmpq	%r11, %rsi
	leaq	1(%rsi), %rsi
	je	.LBB5_20
.LBB5_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_14 Depth 2
                                        #     Child Loop BB5_18 Depth 2
	imulq	$56, %rsi, %rax
	movl	(%r10,%rax), %edx
	testl	%edx, %edx
	jle	.LBB5_19
# %bb.3:                                # 
                                        #   in Loop: Header=BB5_2 Depth=1
	leal	(,%rsi,4), %eax
	movl	%eax, %ecx
	andl	$-8, %ecx
	leal	(%rcx,%rcx,2), %ecx
	andl	$4, %eax
	orl	%ecx, %eax
	movq	%rdx, %rdi
	shrq	$3, %rdi
	movl	%eax, %ebx
	je	.LBB5_4
# %bb.13:                               # 
                                        #   in Loop: Header=BB5_2 Depth=1
	leaq	(%r9,%rbx,8), %rcx
	shlq	$6, %rdi
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB5_14:                               # 
                                        #   Parent Loop BB5_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovups	%zmm1, (%rcx,%rax)
	addq	$64, %rax
	cmpq	%rax, %rdi
	jne	.LBB5_14
# %bb.15:                               # 
                                        #   in Loop: Header=BB5_2 Depth=1
	movl	%edx, %edi
	andl	$-8, %edi
	leaq	(%rdi,%rbx), %rax
	vmovups	%zmm1, (%r9,%rax,8)
	vmovups	%zmm1, 64(%r9,%rax,8)
	cmpq	%rdx, %rdi
	jae	.LBB5_19
	jmp	.LBB5_17
	.p2align	4, 0x90
.LBB5_4:                                # 
                                        #   in Loop: Header=BB5_2 Depth=1
	movl	%edx, %edi
	andl	$-8, %edi
	cmpq	%rdx, %rdi
	jae	.LBB5_19
.LBB5_17:                               # 
                                        #   in Loop: Header=BB5_2 Depth=1
	leaq	(%r8,%rbx,8), %rcx
	.p2align	4, 0x90
.LBB5_18:                               # 
                                        #   Parent Loop BB5_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, -128(%rcx,%rdi,8)
	movq	$0, -64(%rcx,%rdi,8)
	movq	$0, (%rcx,%rdi,8)
	incq	%rdi
	cmpq	%rdi, %rdx
	jne	.LBB5_18
	jmp	.LBB5_19
.LBB5_20:                               # 
	vmovupd	64(%rsp), %zmm1         # 64-byte Reload
	vmulsd	.LCPI5_0(%rip), %xmm1, %xmm1
	vbroadcastsd	%xmm1, %zmm1
	xorl	%edi, %edi
	vbroadcastsd	.LCPI5_1(%rip), %zmm2 # zmm2 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	movq	%rbp, 56(%rsp)          # 8-byte Spill
	vmovupd	192(%rsp), %zmm22       # 64-byte Reload
	.p2align	4, 0x90
.LBB5_6:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_11 Depth 2
	leal	(,%rdi,4), %r10d
	movl	%r10d, %eax
	andl	$-8, %eax
	leal	(%rax,%rax,2), %eax
	andl	$4, %r10d
	orl	%eax, %r10d
	movq	24(%r14), %rax
	movslq	(%rax,%rdi,4), %r8
	testq	%r8, %r8
	jle	.LBB5_7
# %bb.10:                               # 
                                        #   in Loop: Header=BB5_6 Depth=1
	movq	160(%rbp), %rsi
	movq	8(%r14), %rax
	vbroadcastsd	(%rsi,%r10,8), %zmm3
	vmovups	%zmm3, 64(%rsp)         # 64-byte Spill
	vbroadcastsd	8(%rsi,%r10,8), %zmm3
	vmovups	%zmm3, 128(%rsp)        # 64-byte Spill
	vbroadcastsd	16(%rsi,%r10,8), %zmm3
	vmovups	%zmm3, 448(%rsp)        # 64-byte Spill
	vbroadcastsd	24(%rsi,%r10,8), %zmm3
	vmovups	%zmm3, 384(%rsp)        # 64-byte Spill
	vbroadcastsd	64(%rsi,%r10,8), %zmm3
	vmovups	%zmm3, 320(%rsp)        # 64-byte Spill
	vbroadcastsd	72(%rsi,%r10,8), %zmm3
	vmovups	%zmm3, 256(%rsp)        # 64-byte Spill
	vbroadcastsd	80(%rsi,%r10,8), %zmm23
	vbroadcastsd	88(%rsi,%r10,8), %zmm24
	vbroadcastsd	128(%rsi,%r10,8), %zmm25
	vbroadcastsd	136(%rsi,%r10,8), %zmm26
	vbroadcastsd	144(%rsi,%r10,8), %zmm27
	vbroadcastsd	152(%rsi,%r10,8), %zmm28
	movl	%r8d, %r11d
	movq	%r14, %r15
	movl	16(%r14), %ecx
	imull	%edi, %ecx
	movslq	%ecx, %rcx
	leaq	(%rax,%rcx,4), %r12
	vxorpd	%xmm15, %xmm15, %xmm15
	movl	$0, %r14d
	vxorpd	%xmm12, %xmm12, %xmm12
	vxorpd	%xmm8, %xmm8, %xmm8
	vxorpd	%xmm14, %xmm14, %xmm14
	vxorpd	%xmm10, %xmm10, %xmm10
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm16, %xmm16, %xmm16
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm13, %xmm13, %xmm13
	vxorpd	%xmm9, %xmm9, %xmm9
	vxorpd	%xmm5, %xmm5, %xmm5
	.p2align	4, 0x90
    movl    $111,%ebx       #IACA/OSACA START MARKER
    .byte   100,103,144     #IACA/OSACA START MARKER
.LBB5_11:                               # 
                                        #   Parent Loop BB5_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%r12,%r14,4), %rbx
	leaq	(%rbx,%rbx,2), %rcx
	shlq	$6, %rcx
	vmovapd	(%rsi,%rcx), %zmm29
	vmovapd	64(%rsi,%rcx), %zmm30
	vmovapd	128(%rsi,%rcx), %zmm31
	vmovupd	64(%rsp), %zmm3         # 64-byte Reload
	vsubpd	%zmm29, %zmm3, %zmm4
	vmovupd	320(%rsp), %zmm3        # 64-byte Reload
	vsubpd	%zmm30, %zmm3, %zmm3
	leal	(%rbx,%rbx), %ecx
	cmpq	%rcx, %rdi
	setne	%dl
	sete	%cl
	leal	1(%rbx,%rbx), %ebx
	vsubpd	%zmm31, %zmm25, %zmm17
	vmulpd	%zmm17, %zmm17, %zmm18
	vfmadd231pd	%zmm3, %zmm3, %zmm18 # zmm18 = (zmm3 * zmm3) + zmm18
	vfmadd231pd	%zmm4, %zmm4, %zmm18 # zmm18 = (zmm4 * zmm4) + zmm18
	vrcp14pd	%zmm18, %zmm19
	cmpq	%rbx, %rdi
	sete	%bl
	movl	%ebx, %ebp
	vmulpd	%zmm22, %zmm19, %zmm20
	vmulpd	%zmm19, %zmm19, %zmm21
	vmulpd	%zmm20, %zmm21, %zmm20
	vmovupd	128(%rsp), %zmm21       # 64-byte Reload
	vsubpd	%zmm29, %zmm21, %zmm21
	shlb	$4, %bpl
	vmulpd	%zmm19, %zmm1, %zmm19
	vmulpd	%zmm20, %zmm19, %zmm19
	vaddpd	%zmm2, %zmm20, %zmm20
	vmulpd	%zmm20, %zmm19, %zmm19
	vmovupd	256(%rsp), %zmm20       # 64-byte Reload
	vsubpd	%zmm30, %zmm20, %zmm20
	notb	%bpl
	subb	%cl, %bpl
	kmovd	%ebp, %k1
	vcmpltpd	%zmm0, %zmm18, %k1 {%k1}
	vsubpd	%zmm31, %zmm26, %zmm18
	vfmadd231pd	%zmm4, %zmm19, %zmm15 {%k1} # zmm15 = (zmm19 * zmm4) + zmm15
	vmulpd	%zmm18, %zmm18, %zmm4
	vfmadd231pd	%zmm20, %zmm20, %zmm4 # zmm4 = (zmm20 * zmm20) + zmm4
	vfmadd231pd	%zmm21, %zmm21, %zmm4 # zmm4 = (zmm21 * zmm21) + zmm4
	vfmadd231pd	%zmm3, %zmm19, %zmm12 {%k1} # zmm12 = (zmm19 * zmm3) + zmm12
	vrcp14pd	%zmm4, %zmm3
	leal	(%rdx,%rdx), %ecx
	movl	%ebx, %eax
	vfmadd231pd	%zmm17, %zmm19, %zmm8 {%k1} # zmm8 = (zmm19 * zmm17) + zmm8
	vmulpd	%zmm22, %zmm3, %zmm17
	vmulpd	%zmm3, %zmm3, %zmm19
	vmulpd	%zmm17, %zmm19, %zmm17
	vmovupd	448(%rsp), %zmm19       # 64-byte Reload
	vsubpd	%zmm29, %zmm19, %zmm19
	shlb	$5, %al
	vmulpd	%zmm3, %zmm1, %zmm3
	vmulpd	%zmm17, %zmm3, %zmm3
	vaddpd	%zmm2, %zmm17, %zmm17
	vmulpd	%zmm17, %zmm3, %zmm3
	vsubpd	%zmm30, %zmm23, %zmm17
	subb	%al, %cl
	addb	$-3, %cl
	kmovd	%ecx, %k1
	vcmpltpd	%zmm0, %zmm4, %k1 {%k1}
	vsubpd	%zmm31, %zmm27, %zmm4
	vfmadd231pd	%zmm21, %zmm3, %zmm14 {%k1} # zmm14 = (zmm3 * zmm21) + zmm14
	vmulpd	%zmm4, %zmm4, %zmm21
	vfmadd231pd	%zmm17, %zmm17, %zmm21 # zmm21 = (zmm17 * zmm17) + zmm21
	vfmadd231pd	%zmm19, %zmm19, %zmm21 # zmm21 = (zmm19 * zmm19) + zmm21
	vfmadd231pd	%zmm20, %zmm3, %zmm10 {%k1} # zmm10 = (zmm3 * zmm20) + zmm10
	vrcp14pd	%zmm21, %zmm20
	vfmadd231pd	%zmm18, %zmm3, %zmm6 {%k1} # zmm6 = (zmm3 * zmm18) + zmm6
	vmulpd	%zmm22, %zmm20, %zmm3
	vmulpd	%zmm20, %zmm20, %zmm18
	vmulpd	%zmm3, %zmm18, %zmm3
	vmulpd	%zmm20, %zmm1, %zmm18
	vmulpd	%zmm3, %zmm18, %zmm18
	vaddpd	%zmm2, %zmm3, %zmm3
	vmulpd	%zmm3, %zmm18, %zmm3
	leal	(,%rdx,4), %eax
	movl	%ebx, %ecx
	shlb	$6, %cl
	subb	%cl, %al
	addb	$-5, %al
	kmovd	%eax, %k1
	vcmpltpd	%zmm0, %zmm21, %k1 {%k1}
	vmovupd	384(%rsp), %zmm18       # 64-byte Reload
	vsubpd	%zmm29, %zmm18, %zmm18
	vsubpd	%zmm30, %zmm24, %zmm20
	vsubpd	%zmm31, %zmm28, %zmm21
	vfmadd231pd	%zmm19, %zmm3, %zmm16 {%k1} # zmm16 = (zmm3 * zmm19) + zmm16
	vmulpd	%zmm21, %zmm21, %zmm19
	vfmadd231pd	%zmm20, %zmm20, %zmm19 # zmm19 = (zmm20 * zmm20) + zmm19
	vfmadd231pd	%zmm18, %zmm18, %zmm19 # zmm19 = (zmm18 * zmm18) + zmm19
	vfmadd231pd	%zmm17, %zmm3, %zmm11 {%k1} # zmm11 = (zmm3 * zmm17) + zmm11
	vrcp14pd	%zmm19, %zmm17
	vfmadd231pd	%zmm4, %zmm3, %zmm7 {%k1} # zmm7 = (zmm3 * zmm4) + zmm7
	vmulpd	%zmm22, %zmm17, %zmm3
	vmulpd	%zmm17, %zmm17, %zmm4
	vmulpd	%zmm3, %zmm4, %zmm3
	vmulpd	%zmm17, %zmm1, %zmm4
	vmulpd	%zmm3, %zmm4, %zmm4
	vaddpd	%zmm2, %zmm3, %zmm3
	vmulpd	%zmm3, %zmm4, %zmm3
	shlb	$3, %dl
	shlb	$7, %bl
	subb	%bl, %dl
	addb	$-9, %dl
	kmovd	%edx, %k1
	vcmpltpd	%zmm0, %zmm19, %k1 {%k1}
	vfmadd231pd	%zmm18, %zmm3, %zmm13 {%k1} # zmm13 = (zmm3 * zmm18) + zmm13
	vfmadd231pd	%zmm20, %zmm3, %zmm9 {%k1} # zmm9 = (zmm3 * zmm20) + zmm9
	vfmadd231pd	%zmm21, %zmm3, %zmm5 {%k1} # zmm5 = (zmm3 * zmm21) + zmm5
	incq	%r14
	cmpq	%r14, %r11
	jne	.LBB5_11
    movl    $222,%ebx       #IACA/OSACA END MARKER
    .byte   100,103,144     #IACA/OSACA END MARKER
# %bb.12:                               # 
                                        #   in Loop: Header=BB5_6 Depth=1
	movq	%r15, %r14
	movq	56(%rsp), %rbp          # 8-byte Reload
	jmp	.LBB5_8
	.p2align	4, 0x90
.LBB5_7:                                # 
                                        #   in Loop: Header=BB5_6 Depth=1
	vxorpd	%xmm5, %xmm5, %xmm5
	movq	%r8, %r11
	vxorpd	%xmm9, %xmm9, %xmm9
	vxorpd	%xmm13, %xmm13, %xmm13
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorpd	%xmm16, %xmm16, %xmm16
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm10, %xmm10, %xmm10
	vxorpd	%xmm14, %xmm14, %xmm14
	vxorpd	%xmm8, %xmm8, %xmm8
	vxorpd	%xmm12, %xmm12, %xmm12
	vxorpd	%xmm15, %xmm15, %xmm15
.LBB5_8:                                # 
                                        #   in Loop: Header=BB5_6 Depth=1
	vpermilpd	$85, %zmm15, %zmm3 # zmm3 = zmm15[1,0,3,2,5,4,7,6]
	vaddpd	%zmm15, %zmm3, %zmm3
	vpermilpd	$85, %zmm16, %zmm4 # zmm4 = zmm16[1,0,3,2,5,4,7,6]
	vaddpd	%zmm16, %zmm4, %zmm4
	vmovddup	%zmm14, %zmm15  # zmm15 = zmm14[0,0,2,2,4,4,6,6]
	vaddpd	%zmm14, %zmm15, %zmm14
	vshufpd	$170, %zmm14, %zmm3, %zmm3 # zmm3 = zmm3[0],zmm14[1],zmm3[2],zmm14[3],zmm3[4],zmm14[5],zmm3[6],zmm14[7]
	vmovddup	%zmm13, %zmm14  # zmm14 = zmm13[0,0,2,2,4,4,6,6]
	vaddpd	%zmm13, %zmm14, %zmm13
	vshufpd	$170, %zmm13, %zmm4, %zmm4 # zmm4 = zmm4[0],zmm13[1],zmm4[2],zmm13[3],zmm4[4],zmm13[5],zmm4[6],zmm13[7]
	vextractf64x4	$1, %zmm3, %ymm13
	vaddpd	%zmm3, %zmm13, %zmm3
	vinsertf64x4	$1, %ymm4, %zmm0, %zmm13
	vaddpd	%zmm4, %zmm13, %zmm4
	vshuff64x2	$228, %zmm4, %zmm3, %zmm3 # zmm3 = zmm3[0,1,2,3],zmm4[4,5,6,7]
	vpermpd	$78, %zmm3, %zmm4       # zmm4 = zmm3[2,3,0,1,6,7,4,5]
	vaddpd	%zmm3, %zmm4, %zmm3
	vextractf64x4	$1, %zmm3, %ymm4
	vblendpd	$12, %ymm4, %ymm3, %ymm3 # ymm3 = ymm3[0,1],ymm4[2,3]
	vaddpd	(%r9,%r10,8), %ymm3, %ymm3
	vmovapd	%ymm3, (%r9,%r10,8)
	vpermilpd	$85, %zmm12, %zmm3 # zmm3 = zmm12[1,0,3,2,5,4,7,6]
	vaddpd	%zmm12, %zmm3, %zmm3
	vpermilpd	$85, %zmm11, %zmm4 # zmm4 = zmm11[1,0,3,2,5,4,7,6]
	vaddpd	%zmm11, %zmm4, %zmm4
	vmovddup	%zmm10, %zmm11  # zmm11 = zmm10[0,0,2,2,4,4,6,6]
	vaddpd	%zmm10, %zmm11, %zmm10
	vshufpd	$170, %zmm10, %zmm3, %zmm3 # zmm3 = zmm3[0],zmm10[1],zmm3[2],zmm10[3],zmm3[4],zmm10[5],zmm3[6],zmm10[7]
	vmovddup	%zmm9, %zmm10   # zmm10 = zmm9[0,0,2,2,4,4,6,6]
	vaddpd	%zmm9, %zmm10, %zmm9
	vshufpd	$170, %zmm9, %zmm4, %zmm4 # zmm4 = zmm4[0],zmm9[1],zmm4[2],zmm9[3],zmm4[4],zmm9[5],zmm4[6],zmm9[7]
	vextractf64x4	$1, %zmm3, %ymm9
	vaddpd	%zmm3, %zmm9, %zmm3
	vinsertf64x4	$1, %ymm4, %zmm0, %zmm9
	vaddpd	%zmm4, %zmm9, %zmm4
	vshuff64x2	$228, %zmm4, %zmm3, %zmm3 # zmm3 = zmm3[0,1,2,3],zmm4[4,5,6,7]
	vpermpd	$78, %zmm3, %zmm4       # zmm4 = zmm3[2,3,0,1,6,7,4,5]
	vaddpd	%zmm3, %zmm4, %zmm3
	vextractf64x4	$1, %zmm3, %ymm4
	vblendpd	$12, %ymm4, %ymm3, %ymm3 # ymm3 = ymm3[0,1],ymm4[2,3]
	vaddpd	64(%r9,%r10,8), %ymm3, %ymm3
	vmovapd	%ymm3, 64(%r9,%r10,8)
	vpermilpd	$85, %zmm8, %zmm3 # zmm3 = zmm8[1,0,3,2,5,4,7,6]
	vaddpd	%zmm8, %zmm3, %zmm3
	vpermilpd	$85, %zmm7, %zmm4 # zmm4 = zmm7[1,0,3,2,5,4,7,6]
	vaddpd	%zmm7, %zmm4, %zmm4
	vmovddup	%zmm6, %zmm7    # zmm7 = zmm6[0,0,2,2,4,4,6,6]
	vaddpd	%zmm6, %zmm7, %zmm6
	vshufpd	$170, %zmm6, %zmm3, %zmm3 # zmm3 = zmm3[0],zmm6[1],zmm3[2],zmm6[3],zmm3[4],zmm6[5],zmm3[6],zmm6[7]
	vmovddup	%zmm5, %zmm6    # zmm6 = zmm5[0,0,2,2,4,4,6,6]
	vaddpd	%zmm5, %zmm6, %zmm5
	vshufpd	$170, %zmm5, %zmm4, %zmm4 # zmm4 = zmm4[0],zmm5[1],zmm4[2],zmm5[3],zmm4[4],zmm5[5],zmm4[6],zmm5[7]
	vextractf64x4	$1, %zmm3, %ymm5
	vaddpd	%zmm3, %zmm5, %zmm3
	vinsertf64x4	$1, %ymm4, %zmm0, %zmm5
	vaddpd	%zmm4, %zmm5, %zmm4
	vshuff64x2	$228, %zmm4, %zmm3, %zmm3 # zmm3 = zmm3[0,1,2,3],zmm4[4,5,6,7]
	vpermpd	$78, %zmm3, %zmm4       # zmm4 = zmm3[2,3,0,1,6,7,4,5]
	vaddpd	%zmm3, %zmm4, %zmm3
	vextractf64x4	$1, %zmm3, %ymm4
	vblendpd	$12, %ymm4, %ymm3, %ymm3 # ymm3 = ymm3[0,1],ymm4[2,3]
	vaddpd	128(%r9,%r10,8), %ymm3, %ymm3
	vmovapd	%ymm3, 128(%r9,%r10,8)
	vmovdqa	.LCPI5_2(%rip), %xmm3   # xmm3 = <1,u>
	vpinsrq	$1, %r11, %xmm3, %xmm3
	vpaddq	(%r13), %xmm3, %xmm3
	vmovdqu	%xmm3, (%r13)
	vcvtsi2sd	%r8d, %xmm23, %xmm3
	vmulsd	.LCPI5_3(%rip), %xmm3, %xmm3
	vcvttsd2si	%xmm3, %rax
	addq	%rax, 16(%r13)
	incq	%rdi
	movslq	20(%rbp), %rax
	cmpq	%rax, %rdi
	jge	.LBB5_5
# %bb.9:                                # 
                                        #   in Loop: Header=BB5_6 Depth=1
	movq	176(%rbp), %r9
	jmp	.LBB5_6
.LBB5_5:                                # 
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
	vsubsd	48(%rsp), %xmm0, %xmm0  # 8-byte Folded Reload
	addq	$520, %rsp              # imm = 0x208
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
