	.text
	.file	"force_lj.c"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3               # -- Begin function computeForceLJ_ref
.LCPI0_0:
	.quad	4631952216750555136     #  48
.LCPI0_2:
	.quad	-4620693217682128896    #  -0.5
.LCPI0_4:
	.quad	4602678819172646912     #  0.5
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2
.LCPI0_1:
	.long	1065353216              #  1
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
	movq	%rcx, 24(%rsp)          # 8-byte Spill
	movq	%rdx, 32(%rsp)          # 8-byte Spill
	movq	%rsi, %r12
	movq	%rdi, %rbx
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovss	108(%rbx), %xmm0        # xmm0 = mem[0],zero,zero,zero
	vmovss	%xmm0, 8(%rsp)          # 4-byte Spill
	vmovss	40(%rbx), %xmm0         # xmm0 = mem[0],zero,zero,zero
	vmovss	%xmm0, (%rsp)           # 4-byte Spill
	vmovss	48(%rbx), %xmm2         # xmm2 = mem[0],zero,zero,zero
	movl	20(%r12), %eax
	testl	%eax, %eax
	jle	.LBB0_5
# %bb.1:                                # 
	movq	176(%r12), %r9
	movq	192(%r12), %r10
	decq	%rax
	leaq	64(%r9), %r8
	xorl	%edi, %edi
	vxorpd	%xmm0, %xmm0, %xmm0
	vxorps	%xmm1, %xmm1, %xmm1
	jmp	.LBB0_2
	.p2align	4, 0x90
.LBB0_41:                               # 
                                        #   in Loop: Header=BB0_2 Depth=1
	cmpq	%rax, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB0_5
.LBB0_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_36 Depth 2
                                        #     Child Loop BB0_40 Depth 2
	leaq	(%rdi,%rdi,8), %rcx
	leaq	(%rcx,%rcx,2), %rcx
	addq	%rdi, %rcx
	movl	(%r10,%rcx), %ecx
	testl	%ecx, %ecx
	jle	.LBB0_41
# %bb.3:                                # 
                                        #   in Loop: Header=BB0_2 Depth=1
	leal	(,%rdi,4), %edx
	movl	%edx, %esi
	andl	$-8, %esi
	leal	(%rsi,%rsi,2), %esi
	andl	$4, %edx
	orl	%esi, %edx
	movq	%rcx, %rsi
	shrq	$3, %rsi
	movl	%edx, %ebx
	je	.LBB0_4
# %bb.35:                               # 
                                        #   in Loop: Header=BB0_2 Depth=1
	leaq	(%r9,%rbx,4), %rbp
	shlq	$5, %rsi
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB0_36:                               # 
                                        #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%ymm0, (%rbp,%rdx)
	addq	$32, %rdx
	cmpq	%rdx, %rsi
	jne	.LBB0_36
# %bb.37:                               # 
                                        #   in Loop: Header=BB0_2 Depth=1
	movl	%ecx, %ebp
	andl	$-8, %ebp
	leaq	(%rbx,%rbp), %rdx
	vmovups	%zmm1, (%r9,%rdx,4)
	cmpq	%rcx, %rbp
	jae	.LBB0_41
	jmp	.LBB0_39
	.p2align	4, 0x90
.LBB0_4:                                # 
                                        #   in Loop: Header=BB0_2 Depth=1
	movl	%ecx, %ebp
	andl	$-8, %ebp
	cmpq	%rcx, %rbp
	jae	.LBB0_41
.LBB0_39:                               # 
                                        #   in Loop: Header=BB0_2 Depth=1
	leaq	(%r8,%rbx,4), %rsi
	.p2align	4, 0x90
.LBB0_40:                               # 
                                        #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$0, -64(%rsi,%rbp,4)
	movl	$0, -32(%rsi,%rbp,4)
	movl	$0, (%rsi,%rbp,4)
	incq	%rbp
	cmpq	%rbp, %rcx
	jne	.LBB0_40
	jmp	.LBB0_41
.LBB0_5:                                # 
	vmovss	%xmm2, 20(%rsp)         # 4-byte Spill
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
	vmovss	8(%rsp), %xmm0          # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	vmulss	%xmm0, %xmm0, %xmm14
	movq	160(%r12), %rcx
	movq	176(%r12), %rdx
	movq	32(%rsp), %rax          # 8-byte Reload
	movq	16(%rax), %rsi
	movq	%rsi, 80(%rsp)          # 8-byte Spill
	movq	40(%rax), %rsi
	movq	%rsi, 64(%rsp)          # 8-byte Spill
	movslq	8(%rax), %rax
	movq	%rax, 56(%rsp)          # 8-byte Spill
	vmovss	(%rsp), %xmm0           # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vmulsd	.LCPI0_0(%rip), %xmm0, %xmm13
	movq	24(%rsp), %rax          # 8-byte Reload
	leaq	32(%rax), %r10
	leaq	24(%rax), %rbx
	leaq	40(%rax), %rsi
	movq	%rsi, 8(%rsp)           # 8-byte Spill
	leaq	48(%rax), %rsi
	movq	%rsi, 160(%rsp)         # 8-byte Spill
	vmovdqu	(%rax), %xmm10
	movq	16(%rax), %rsi
	movq	%rdx, 72(%rsp)          # 8-byte Spill
	leaq	64(%rdx), %rax
	movq	%rax, 128(%rsp)         # 8-byte Spill
	movq	%rcx, 40(%rsp)          # 8-byte Spill
	leaq	64(%rcx), %rax
	movq	%rax, 120(%rsp)         # 8-byte Spill
	xorl	%edi, %edi
	vmovss	.LCPI0_1(%rip), %xmm11  # xmm11 = mem[0],zero,zero,zero
	vmovsd	.LCPI0_2(%rip), %xmm12  # xmm12 = mem[0],zero
	vmovdqa	.LCPI0_3(%rip), %xmm8   # xmm8 = <1,u>
	vmovsd	.LCPI0_4(%rip), %xmm9   # xmm9 = mem[0],zero
	vmovss	20(%rsp), %xmm20        # 4-byte Reload
                                        # xmm20 = mem[0],zero,zero,zero
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
	movq	40(%rsp), %rdx          # 8-byte Reload
	leaq	(%rdx,%rax,4), %r15
	movq	72(%rsp), %rdx          # 8-byte Reload
	leaq	(%rdx,%rax,4), %r11
	movq	%rdi, 104(%rsp)         # 8-byte Spill
	movq	%rdi, %rax
	imulq	56(%rsp), %rax          # 8-byte Folded Reload
	movq	64(%rsp), %rdx          # 8-byte Reload
	leaq	(%rdx,%rax,4), %rax
	movq	%rax, 136(%rsp)         # 8-byte Spill
	movq	32(%rsp), %rax          # 8-byte Reload
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
	shlq	$5, %rax
	leaq	(%rax,%rax,2), %rbp
	movq	40(%rsp), %rax          # 8-byte Reload
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
	vaddss	(%r11,%r8,4), %xmm5, %xmm0
	vmovss	%xmm0, (%r11,%r8,4)
	vaddss	32(%r11,%r8,4), %xmm6, %xmm0
	vmovss	%xmm0, 32(%r11,%r8,4)
	vaddss	64(%r11,%r8,4), %xmm19, %xmm0
	vmovss	%xmm0, 64(%r11,%r8,4)
	incq	%r8
	cmpq	$4, %r8
	je	.LBB0_18
.LBB0_10:                               # 
                                        #   Parent Loop BB0_7 Depth=1
                                        #     Parent Loop BB0_9 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_12 Depth 4
	vmovss	(%r15,%r8,4), %xmm15    # xmm15 = mem[0],zero,zero,zero
	leaq	(%r8,%r12), %r9
	vmovss	32(%r15,%r8,4), %xmm17  # xmm17 = mem[0],zero,zero,zero
	vmovss	64(%r15,%r8,4), %xmm18  # xmm18 = mem[0],zero,zero,zero
	cmpl	$0, (%rsp)              # 4-byte Folded Reload
	je	.LBB0_21
# %bb.11:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vxorps	%xmm5, %xmm5, %xmm5
	xorl	%edx, %edx
	vxorps	%xmm6, %xmm6, %xmm6
	vxorps	%xmm19, %xmm19, %xmm19
	jmp	.LBB0_12
	.p2align	4, 0x90
.LBB0_31:                               # 
                                        #   in Loop: Header=BB0_12 Depth=4
	vdivss	%xmm3, %xmm11, %xmm3
	vmulss	%xmm20, %xmm3, %xmm4
	vmulss	%xmm3, %xmm3, %xmm7
	vmulss	%xmm4, %xmm7, %xmm4
	vcvtss2sd	%xmm4, %xmm4, %xmm4
	vaddsd	%xmm4, %xmm12, %xmm7
	vcvtss2sd	%xmm3, %xmm3, %xmm3
	vmulsd	%xmm3, %xmm13, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vcvtsd2ss	%xmm3, %xmm3, %xmm3
	vmovss	-32(%r13,%rdx,4), %xmm4 # xmm4 = mem[0],zero,zero,zero
	vmovss	-64(%r13,%rdx,4), %xmm7 # xmm7 = mem[0],zero,zero,zero
	vfnmadd231ss	%xmm2, %xmm3, %xmm7 # xmm7 = -(xmm3 * xmm2) + xmm7
	vmovss	%xmm7, -64(%r13,%rdx,4)
	vfnmadd231ss	%xmm0, %xmm3, %xmm4 # xmm4 = -(xmm3 * xmm0) + xmm4
	vmovss	%xmm4, -32(%r13,%rdx,4)
	vmovss	(%r13,%rdx,4), %xmm4    # xmm4 = mem[0],zero,zero,zero
	vfnmadd231ss	%xmm1, %xmm3, %xmm4 # xmm4 = -(xmm3 * xmm1) + xmm4
	vmovss	%xmm4, (%r13,%rdx,4)
	vfmadd231ss	%xmm2, %xmm3, %xmm5 # xmm5 = (xmm3 * xmm2) + xmm5
	vfmadd231ss	%xmm0, %xmm3, %xmm6 # xmm6 = (xmm3 * xmm0) + xmm6
	vfmadd231ss	%xmm1, %xmm3, %xmm19 # xmm19 = (xmm3 * xmm1) + xmm19
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
	vsubss	-64(%rbp,%rdx,4), %xmm15, %xmm2
	vsubss	-32(%rbp,%rdx,4), %xmm17, %xmm0
	vsubss	(%rbp,%rdx,4), %xmm18, %xmm1
	vmulss	%xmm2, %xmm2, %xmm3
	vfmadd231ss	%xmm0, %xmm0, %xmm3 # xmm3 = (xmm0 * xmm0) + xmm3
	vfmadd231ss	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vucomiss	%xmm14, %xmm3
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
	vxorps	%xmm19, %xmm19, %xmm19
	testq	%r9, %r9
	jne	.LBB0_24
# %bb.23:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vxorps	%xmm6, %xmm6, %xmm6
	vxorps	%xmm5, %xmm5, %xmm5
	cmpl	%esi, %r14d
	je	.LBB0_28
	jmp	.LBB0_29
.LBB0_24:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vsubss	(%rcx), %xmm15, %xmm16
	vsubss	32(%rcx), %xmm17, %xmm1
	vsubss	64(%rcx), %xmm18, %xmm2
	vmulss	%xmm16, %xmm16, %xmm0
	vfmadd231ss	%xmm1, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm1) + xmm0
	vfmadd231ss	%xmm2, %xmm2, %xmm0 # xmm0 = (xmm2 * xmm2) + xmm0
	vxorps	%xmm19, %xmm19, %xmm19
	vucomiss	%xmm14, %xmm0
	movq	%r10, %rdx
	vxorps	%xmm6, %xmm6, %xmm6
	vxorps	%xmm5, %xmm5, %xmm5
	jae	.LBB0_26
# %bb.25:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vdivss	%xmm0, %xmm11, %xmm0
	vmulss	%xmm20, %xmm0, %xmm3
	vmulss	%xmm0, %xmm0, %xmm5
	vmulss	%xmm3, %xmm5, %xmm3
	vcvtss2sd	%xmm3, %xmm3, %xmm3
	vaddsd	%xmm3, %xmm12, %xmm5
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vmulsd	%xmm0, %xmm13, %xmm0
	vmulsd	%xmm3, %xmm0, %xmm0
	vmulsd	%xmm5, %xmm0, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmulss	%xmm0, %xmm16, %xmm5
	vmulss	%xmm0, %xmm1, %xmm6
	vmulss	%xmm0, %xmm2, %xmm19
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
	vsubss	4(%rcx), %xmm15, %xmm2
	vsubss	36(%rcx), %xmm17, %xmm1
	vsubss	68(%rcx), %xmm18, %xmm0
	vmulss	%xmm2, %xmm2, %xmm3
	vfmadd231ss	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231ss	%xmm0, %xmm0, %xmm3 # xmm3 = (xmm0 * xmm0) + xmm3
	vucomiss	%xmm14, %xmm3
	jae	.LBB0_30
# %bb.42:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vdivss	%xmm3, %xmm11, %xmm3
	vmulss	%xmm20, %xmm3, %xmm4
	vmulss	%xmm3, %xmm3, %xmm7
	vmulss	%xmm4, %xmm7, %xmm4
	vcvtss2sd	%xmm4, %xmm4, %xmm4
	vaddsd	%xmm4, %xmm12, %xmm7
	vcvtss2sd	%xmm3, %xmm3, %xmm3
	vmulsd	%xmm3, %xmm13, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vcvtsd2ss	%xmm3, %xmm3, %xmm3
	vfmadd231ss	%xmm2, %xmm3, %xmm5 # xmm5 = (xmm3 * xmm2) + xmm5
	vfmadd231ss	%xmm1, %xmm3, %xmm6 # xmm6 = (xmm3 * xmm1) + xmm6
	vfmadd231ss	%xmm0, %xmm3, %xmm19 # xmm19 = (xmm3 * xmm0) + xmm19
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
	vsubss	8(%rcx), %xmm15, %xmm2
	vsubss	40(%rcx), %xmm17, %xmm1
	vsubss	72(%rcx), %xmm18, %xmm0
	vmulss	%xmm2, %xmm2, %xmm3
	vfmadd231ss	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231ss	%xmm0, %xmm0, %xmm3 # xmm3 = (xmm0 * xmm0) + xmm3
	vucomiss	%xmm14, %xmm3
	jae	.LBB0_47
# %bb.48:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vdivss	%xmm3, %xmm11, %xmm3
	vmulss	%xmm20, %xmm3, %xmm4
	vmulss	%xmm3, %xmm3, %xmm7
	vmulss	%xmm4, %xmm7, %xmm4
	vcvtss2sd	%xmm4, %xmm4, %xmm4
	vaddsd	%xmm4, %xmm12, %xmm7
	vcvtss2sd	%xmm3, %xmm3, %xmm3
	vmulsd	%xmm3, %xmm13, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vcvtsd2ss	%xmm3, %xmm3, %xmm3
	vfmadd231ss	%xmm2, %xmm3, %xmm5 # xmm5 = (xmm3 * xmm2) + xmm5
	vfmadd231ss	%xmm1, %xmm3, %xmm6 # xmm6 = (xmm3 * xmm1) + xmm6
	vfmadd231ss	%xmm0, %xmm3, %xmm19 # xmm19 = (xmm3 * xmm0) + xmm19
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
	vsubss	12(%rcx), %xmm15, %xmm2
	vsubss	44(%rcx), %xmm17, %xmm1
	vsubss	76(%rcx), %xmm18, %xmm0
	vmulss	%xmm2, %xmm2, %xmm3
	vfmadd231ss	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231ss	%xmm0, %xmm0, %xmm3 # xmm3 = (xmm0 * xmm0) + xmm3
	vucomiss	%xmm14, %xmm3
	jae	.LBB0_53
# %bb.54:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vdivss	%xmm3, %xmm11, %xmm3
	vmulss	%xmm20, %xmm3, %xmm4
	vmulss	%xmm3, %xmm3, %xmm7
	vmulss	%xmm4, %xmm7, %xmm4
	vcvtss2sd	%xmm4, %xmm4, %xmm4
	vaddsd	%xmm4, %xmm12, %xmm7
	vcvtss2sd	%xmm3, %xmm3, %xmm3
	vmulsd	%xmm3, %xmm13, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vcvtsd2ss	%xmm3, %xmm3, %xmm3
	vfmadd231ss	%xmm2, %xmm3, %xmm5 # xmm5 = (xmm3 * xmm2) + xmm5
	vfmadd231ss	%xmm1, %xmm3, %xmm6 # xmm6 = (xmm3 * xmm1) + xmm6
	vfmadd231ss	%xmm0, %xmm3, %xmm19 # xmm19 = (xmm3 * xmm0) + xmm19
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
	vsubss	16(%rcx), %xmm15, %xmm2
	vsubss	48(%rcx), %xmm17, %xmm1
	vsubss	80(%rcx), %xmm18, %xmm0
	vmulss	%xmm2, %xmm2, %xmm3
	vfmadd231ss	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231ss	%xmm0, %xmm0, %xmm3 # xmm3 = (xmm0 * xmm0) + xmm3
	vucomiss	%xmm14, %xmm3
	jae	.LBB0_59
# %bb.60:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vdivss	%xmm3, %xmm11, %xmm3
	vmulss	%xmm20, %xmm3, %xmm4
	vmulss	%xmm3, %xmm3, %xmm7
	vmulss	%xmm4, %xmm7, %xmm4
	vcvtss2sd	%xmm4, %xmm4, %xmm4
	vaddsd	%xmm4, %xmm12, %xmm7
	vcvtss2sd	%xmm3, %xmm3, %xmm3
	vmulsd	%xmm3, %xmm13, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vcvtsd2ss	%xmm3, %xmm3, %xmm3
	vfmadd231ss	%xmm2, %xmm3, %xmm5 # xmm5 = (xmm3 * xmm2) + xmm5
	vfmadd231ss	%xmm1, %xmm3, %xmm6 # xmm6 = (xmm3 * xmm1) + xmm6
	vfmadd231ss	%xmm0, %xmm3, %xmm19 # xmm19 = (xmm3 * xmm0) + xmm19
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
	vsubss	20(%rcx), %xmm15, %xmm2
	vsubss	52(%rcx), %xmm17, %xmm1
	vsubss	84(%rcx), %xmm18, %xmm0
	vmulss	%xmm2, %xmm2, %xmm3
	vfmadd231ss	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231ss	%xmm0, %xmm0, %xmm3 # xmm3 = (xmm0 * xmm0) + xmm3
	vucomiss	%xmm14, %xmm3
	jae	.LBB0_65
# %bb.66:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vdivss	%xmm3, %xmm11, %xmm3
	vmulss	%xmm20, %xmm3, %xmm4
	vmulss	%xmm3, %xmm3, %xmm7
	vmulss	%xmm4, %xmm7, %xmm4
	vcvtss2sd	%xmm4, %xmm4, %xmm4
	vaddsd	%xmm4, %xmm12, %xmm7
	vcvtss2sd	%xmm3, %xmm3, %xmm3
	vmulsd	%xmm3, %xmm13, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vcvtsd2ss	%xmm3, %xmm3, %xmm3
	vfmadd231ss	%xmm2, %xmm3, %xmm5 # xmm5 = (xmm3 * xmm2) + xmm5
	vfmadd231ss	%xmm1, %xmm3, %xmm6 # xmm6 = (xmm3 * xmm1) + xmm6
	vfmadd231ss	%xmm0, %xmm3, %xmm19 # xmm19 = (xmm3 * xmm0) + xmm19
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
	vsubss	24(%rcx), %xmm15, %xmm2
	vsubss	56(%rcx), %xmm17, %xmm1
	vsubss	88(%rcx), %xmm18, %xmm0
	vmulss	%xmm2, %xmm2, %xmm3
	vfmadd231ss	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231ss	%xmm0, %xmm0, %xmm3 # xmm3 = (xmm0 * xmm0) + xmm3
	vucomiss	%xmm14, %xmm3
	jae	.LBB0_71
# %bb.72:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vdivss	%xmm3, %xmm11, %xmm3
	vmulss	%xmm20, %xmm3, %xmm4
	vmulss	%xmm3, %xmm3, %xmm7
	vmulss	%xmm4, %xmm7, %xmm4
	vcvtss2sd	%xmm4, %xmm4, %xmm4
	vaddsd	%xmm4, %xmm12, %xmm7
	vcvtss2sd	%xmm3, %xmm3, %xmm3
	vmulsd	%xmm3, %xmm13, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vcvtsd2ss	%xmm3, %xmm3, %xmm3
	vfmadd231ss	%xmm2, %xmm3, %xmm5 # xmm5 = (xmm3 * xmm2) + xmm5
	vfmadd231ss	%xmm1, %xmm3, %xmm6 # xmm6 = (xmm3 * xmm1) + xmm6
	vfmadd231ss	%xmm0, %xmm3, %xmm19 # xmm19 = (xmm3 * xmm0) + xmm19
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
	vsubss	28(%rcx), %xmm15, %xmm2
	vsubss	60(%rcx), %xmm17, %xmm1
	vsubss	92(%rcx), %xmm18, %xmm0
	vmulss	%xmm2, %xmm2, %xmm3
	vfmadd231ss	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231ss	%xmm0, %xmm0, %xmm3 # xmm3 = (xmm0 * xmm0) + xmm3
	vucomiss	%xmm14, %xmm3
	jae	.LBB0_77
# %bb.78:                               # 
                                        #   in Loop: Header=BB0_10 Depth=3
	vdivss	%xmm3, %xmm11, %xmm3
	vmulss	%xmm20, %xmm3, %xmm4
	vmulss	%xmm3, %xmm3, %xmm7
	vmulss	%xmm4, %xmm7, %xmm4
	vcvtss2sd	%xmm4, %xmm4, %xmm4
	vaddsd	%xmm4, %xmm12, %xmm7
	vcvtss2sd	%xmm3, %xmm3, %xmm3
	vmulsd	%xmm3, %xmm13, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vcvtsd2ss	%xmm3, %xmm3, %xmm3
	vfmadd231ss	%xmm2, %xmm3, %xmm5 # xmm5 = (xmm3 * xmm2) + xmm5
	vfmadd231ss	%xmm1, %xmm3, %xmm6 # xmm6 = (xmm3 * xmm1) + xmm6
	vfmadd231ss	%xmm0, %xmm3, %xmm19 # xmm19 = (xmm3 * xmm0) + xmm19
	movl	$1, %eax
	movq	%rbx, %rdx
	incq	(%rbx)
	jmp	.LBB0_34
.LBB0_16:                               # 
	movq	24(%rsp), %rax          # 8-byte Reload
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
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2               # -- Begin function computeForceLJ_2xnn_half
.LCPI1_0:
	.long	1111490560              #  48
.LCPI1_1:
	.long	3204448256              #  -0.5
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI1_2:
	.quad	1                       # 0x1
	.zero	8
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI1_3:
	.quad	4602678819172646912     #  0.5
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
	vmovss	108(%r12), %xmm0        # xmm0 = mem[0],zero,zero,zero
	vmovss	%xmm0, 36(%rsp)         # 4-byte Spill
	vbroadcastss	48(%r12), %zmm2
	vmovss	40(%r12), %xmm0         # xmm0 = mem[0],zero,zero,zero
	vmovups	%zmm0, 64(%rsp)         # 64-byte Spill
	movl	20(%rbx), %r11d
	testl	%r11d, %r11d
	jle	.LBB1_5
# %bb.1:                                # 
	movq	176(%rbx), %r9
	movq	192(%rbx), %r10
	decq	%r11
	leaq	64(%r9), %r8
	xorl	%edi, %edi
	vxorps	%xmm0, %xmm0, %xmm0
	vxorps	%xmm1, %xmm1, %xmm1
	jmp	.LBB1_2
	.p2align	4, 0x90
.LBB1_28:                               # 
                                        #   in Loop: Header=BB1_2 Depth=1
	cmpq	%r11, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB1_5
.LBB1_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_23 Depth 2
                                        #     Child Loop BB1_27 Depth 2
	leaq	(%rdi,%rdi,8), %rax
	leaq	(%rax,%rax,2), %rax
	addq	%rdi, %rax
	movl	(%r10,%rax), %edx
	testl	%edx, %edx
	jle	.LBB1_28
# %bb.3:                                # 
                                        #   in Loop: Header=BB1_2 Depth=1
	leal	(,%rdi,4), %eax
	movl	%eax, %ecx
	andl	$-8, %ecx
	leal	(%rcx,%rcx,2), %ecx
	andl	$4, %eax
	orl	%ecx, %eax
	movq	%rdx, %rcx
	shrq	$3, %rcx
	movl	%eax, %esi
	je	.LBB1_4
# %bb.22:                               # 
                                        #   in Loop: Header=BB1_2 Depth=1
	leaq	(%r9,%rsi,4), %rbp
	shlq	$5, %rcx
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB1_23:                               # 
                                        #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovups	%ymm0, (%rbp,%rax)
	addq	$32, %rax
	cmpq	%rax, %rcx
	jne	.LBB1_23
# %bb.24:                               # 
                                        #   in Loop: Header=BB1_2 Depth=1
	movl	%edx, %ebp
	andl	$-8, %ebp
	leaq	(%rsi,%rbp), %rax
	vmovups	%zmm1, (%r9,%rax,4)
	cmpq	%rdx, %rbp
	jae	.LBB1_28
	jmp	.LBB1_26
	.p2align	4, 0x90
.LBB1_4:                                # 
                                        #   in Loop: Header=BB1_2 Depth=1
	movl	%edx, %ebp
	andl	$-8, %ebp
	cmpq	%rdx, %rbp
	jae	.LBB1_28
.LBB1_26:                               # 
                                        #   in Loop: Header=BB1_2 Depth=1
	leaq	(%r8,%rsi,4), %rcx
	.p2align	4, 0x90
.LBB1_27:                               # 
                                        #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$0, -64(%rcx,%rbp,4)
	movl	$0, -32(%rcx,%rbp,4)
	movl	$0, (%rcx,%rbp,4)
	incq	%rbp
	cmpq	%rbp, %rdx
	jne	.LBB1_27
	jmp	.LBB1_28
.LBB1_5:                                # 
	xorl	%eax, %eax
	vmovups	%zmm2, 128(%rsp)        # 64-byte Spill
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 40(%rsp)         # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	vmovups	128(%rsp), %zmm30       # 64-byte Reload
	cmpl	$0, 20(%rbx)
	jle	.LBB1_15
# %bb.6:                                # 
	vmovss	36(%rsp), %xmm0         # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	vmulss	%xmm0, %xmm0, %xmm0
	vbroadcastss	%xmm0, %zmm0
	vmovups	64(%rsp), %zmm1         # 64-byte Reload
	vmulss	.LCPI1_0(%rip), %xmm1, %xmm1
	vbroadcastss	%xmm1, %zmm1
	vbroadcastss	.LCPI1_1(%rip), %zmm2 # zmm2 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	xorl	%r9d, %r9d
	vmovdqa	.LCPI1_2(%rip), %xmm3   # xmm3 = <1,u>
	vmovsd	.LCPI1_3(%rip), %xmm4   # xmm4 = mem[0],zero
	jmp	.LBB1_7
	.p2align	4, 0x90
.LBB1_14:                               # 
                                        #   in Loop: Header=BB1_7 Depth=1
	vshuff64x2	$136, %zmm16, %zmm14, %zmm7 # zmm7 = zmm14[0,1,4,5],zmm16[0,1,4,5]
	vshuff64x2	$221, %zmm16, %zmm14, %zmm8 # zmm8 = zmm14[2,3,6,7],zmm16[2,3,6,7]
	vaddps	%zmm7, %zmm8, %zmm7
	vpermilpd	$85, %zmm7, %zmm8 # zmm8 = zmm7[1,0,3,2,5,4,7,6]
	vaddps	%zmm7, %zmm8, %zmm7
	vpermilps	$177, %zmm7, %zmm8 # zmm8 = zmm7[1,0,3,2,5,4,7,6,9,8,11,10,13,12,15,14]
	vaddps	%zmm7, %zmm8, %zmm7
	movw	$4369, %ax              # imm = 0x1111
	kmovd	%eax, %k1
	vcompressps	%zmm7, %zmm7 {%k1} {z}
	vaddps	(%r11,%r15,4), %xmm7, %xmm7
	vmovaps	%xmm7, (%r11,%r15,4)
	vshuff64x2	$136, %zmm11, %zmm10, %zmm7 # zmm7 = zmm10[0,1,4,5],zmm11[0,1,4,5]
	vshuff64x2	$221, %zmm11, %zmm10, %zmm8 # zmm8 = zmm10[2,3,6,7],zmm11[2,3,6,7]
	vaddps	%zmm7, %zmm8, %zmm7
	vpermilpd	$85, %zmm7, %zmm8 # zmm8 = zmm7[1,0,3,2,5,4,7,6]
	vaddps	%zmm7, %zmm8, %zmm7
	vpermilps	$177, %zmm7, %zmm8 # zmm8 = zmm7[1,0,3,2,5,4,7,6,9,8,11,10,13,12,15,14]
	vaddps	%zmm7, %zmm8, %zmm7
	vcompressps	%zmm7, %zmm7 {%k1} {z}
	vaddps	32(%r11,%r15,4), %xmm7, %xmm7
	vmovaps	%xmm7, 32(%r11,%r15,4)
	vshuff64x2	$136, %zmm5, %zmm6, %zmm7 # zmm7 = zmm6[0,1,4,5],zmm5[0,1,4,5]
	vshuff64x2	$221, %zmm5, %zmm6, %zmm5 # zmm5 = zmm6[2,3,6,7],zmm5[2,3,6,7]
	vaddps	%zmm7, %zmm5, %zmm5
	vpermilpd	$85, %zmm5, %zmm6 # zmm6 = zmm5[1,0,3,2,5,4,7,6]
	vaddps	%zmm5, %zmm6, %zmm5
	vpermilps	$177, %zmm5, %zmm6 # zmm6 = zmm5[1,0,3,2,5,4,7,6,9,8,11,10,13,12,15,14]
	vaddps	%zmm5, %zmm6, %zmm5
	vcompressps	%zmm5, %zmm5 {%k1} {z}
	vaddps	64(%r11,%r15,4), %xmm5, %xmm5
	vmovaps	%xmm5, 64(%r11,%r15,4)
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
	vbroadcastss	(%r14,%r15,4), %zmm5
	movl	(%rcx,%r9,4), %r12d
	vbroadcastss	4(%r14,%r15,4), %ymm6
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm7
	vbroadcastss	8(%r14,%r15,4), %zmm5
	vbroadcastss	12(%r14,%r15,4), %ymm6
	vbroadcastss	32(%r14,%r15,4), %zmm9
	vbroadcastss	36(%r14,%r15,4), %ymm10
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm8
	vinsertf64x4	$1, %ymm10, %zmm9, %zmm9
	vbroadcastss	40(%r14,%r15,4), %zmm5
	vbroadcastss	44(%r14,%r15,4), %ymm6
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm12
	vbroadcastss	64(%r14,%r15,4), %zmm5
	vbroadcastss	68(%r14,%r15,4), %ymm6
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm13
	vbroadcastss	72(%r14,%r15,4), %zmm5
	vbroadcastss	76(%r14,%r15,4), %ymm6
	vinsertf64x4	$1, %ymm6, %zmm5, %zmm15
	testl	%r12d, %r12d
	jle	.LBB1_8
# %bb.16:                               # 
                                        #   in Loop: Header=BB1_7 Depth=1
	movl	%esi, 36(%rsp)          # 4-byte Spill
	movl	%esi, %ecx
	imull	%r9d, %ecx
	movslq	%ecx, %rcx
	movq	%rdx, 64(%rsp)          # 8-byte Spill
	leaq	(%rdx,%rcx,4), %r10
	leaq	-1(%r12), %rcx
	vxorps	%xmm14, %xmm14, %xmm14
	movl	$0, %edi
	vxorps	%xmm10, %xmm10, %xmm10
	vxorps	%xmm6, %xmm6, %xmm6
	vxorps	%xmm16, %xmm16, %xmm16
	vxorps	%xmm11, %xmm11, %xmm11
	vxorps	%xmm5, %xmm5, %xmm5
	.p2align	4, 0x90
.LBB1_17:                               # 
                                        #   Parent Loop BB1_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%r10,%rdi,4), %r8
	movq	%r8, %rbp
	shlq	$3, %rbp
	leaq	(%rbp,%rbp,2), %rbp
	vmovupd	(%r14,%rbp,4), %zmm17
	vinsertf64x4	$1, (%r14,%rbp,4), %zmm17, %zmm18
	vshuff64x2	$238, %zmm17, %zmm17, %zmm17 # zmm17 = zmm17[4,5,6,7,4,5,6,7]
	vbroadcastf64x4	64(%r14,%rbp,4), %zmm19 # zmm19 = mem[0,1,2,3,0,1,2,3]
	vsubps	%zmm18, %zmm7, %zmm20
	vsubps	%zmm17, %zmm9, %zmm21
	vsubps	%zmm19, %zmm13, %zmm22
	vsubps	%zmm18, %zmm8, %zmm23
	vsubps	%zmm17, %zmm12, %zmm24
	vsubps	%zmm19, %zmm15, %zmm25
	vmulps	%zmm22, %zmm22, %zmm17
	vfmadd231ps	%zmm21, %zmm21, %zmm17 # zmm17 = (zmm21 * zmm21) + zmm17
	vfmadd231ps	%zmm20, %zmm20, %zmm17 # zmm17 = (zmm20 * zmm20) + zmm17
	vmulps	%zmm25, %zmm25, %zmm26
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
	kmovw	248(%rbx,%rdx,4), %k2
	leal	(%rax,%rsi,2), %eax
	incl	%eax
	kmovw	248(%rbx,%rax,4), %k1
	vrcp14ps	%zmm17, %zmm18
	vfmadd231ps	%zmm24, %zmm24, %zmm26 # zmm26 = (zmm24 * zmm24) + zmm26
	vfmadd231ps	%zmm23, %zmm23, %zmm26 # zmm26 = (zmm23 * zmm23) + zmm26
	vrcp14ps	%zmm26, %zmm19
	vmulps	%zmm30, %zmm18, %zmm27
	vmulps	%zmm18, %zmm18, %zmm28
	vmulps	%zmm27, %zmm28, %zmm27
	vmulps	%zmm30, %zmm19, %zmm28
	vmulps	%zmm19, %zmm19, %zmm29
	vmulps	%zmm28, %zmm29, %zmm28
	vaddps	%zmm2, %zmm27, %zmm29
	vmulps	%zmm18, %zmm1, %zmm18
	vmulps	%zmm27, %zmm18, %zmm18
	vmulps	%zmm29, %zmm18, %zmm27
	vaddps	%zmm2, %zmm28, %zmm18
	vmulps	%zmm19, %zmm1, %zmm19
	vmulps	%zmm28, %zmm19, %zmm19
	vmulps	%zmm18, %zmm19, %zmm28
	vcmpltps	%zmm0, %zmm17, %k2 {%k2}
	vmulps	%zmm20, %zmm27, %zmm17 {%k2} {z}
	vmulps	%zmm21, %zmm27, %zmm18 {%k2} {z}
	vmulps	%zmm22, %zmm27, %zmm19 {%k2} {z}
	vcmpltps	%zmm0, %zmm26, %k1 {%k1}
	vmulps	%zmm23, %zmm28, %zmm20 {%k1} {z}
	vmulps	%zmm24, %zmm28, %zmm21 {%k1} {z}
	vmulps	%zmm25, %zmm28, %zmm22 {%k1} {z}
	movl	4(%rbx), %eax
	sarl	%eax
	cmpl	%eax, %r8d
	jge	.LBB1_19
# %bb.18:                               # 
                                        #   in Loop: Header=BB1_17 Depth=2
	movq	176(%rbx), %rax
	vaddps	%zmm17, %zmm20, %zmm23
	vaddps	%zmm18, %zmm21, %zmm24
	vextractf64x4	$1, %zmm23, %ymm25
	vaddps	%ymm23, %ymm25, %ymm23
	vmovaps	(%rax,%rbp,4), %ymm25
	vsubps	%ymm23, %ymm25, %ymm23
	vmovaps	32(%rax,%rbp,4), %ymm25
	vmovaps	64(%rax,%rbp,4), %ymm26
	vextractf64x4	$1, %zmm24, %ymm27
	vmovaps	%ymm23, (%rax,%rbp,4)
	vaddps	%ymm24, %ymm27, %ymm23
	vsubps	%ymm23, %ymm25, %ymm23
	vmovaps	%ymm23, 32(%rax,%rbp,4)
	vaddps	%zmm19, %zmm22, %zmm23
	vextractf64x4	$1, %zmm23, %ymm24
	vaddps	%ymm23, %ymm24, %ymm23
	vsubps	%ymm23, %ymm26, %ymm23
	vmovaps	%ymm23, 64(%rax,%rbp,4)
.LBB1_19:                               # 
                                        #   in Loop: Header=BB1_17 Depth=2
	vaddps	%zmm14, %zmm17, %zmm14
	vaddps	%zmm10, %zmm18, %zmm10
	vaddps	%zmm6, %zmm19, %zmm6
	vaddps	%zmm16, %zmm20, %zmm16
	vaddps	%zmm11, %zmm21, %zmm11
	vaddps	%zmm5, %zmm22, %zmm5
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
	movl	36(%rsp), %esi          # 4-byte Reload
	cmpl	%r13d, %r12d
	jge	.LBB1_14
	jmp	.LBB1_10
	.p2align	4, 0x90
.LBB1_8:                                # 
                                        #   in Loop: Header=BB1_7 Depth=1
	vxorps	%xmm5, %xmm5, %xmm5
	vxorps	%xmm11, %xmm11, %xmm11
	vxorps	%xmm16, %xmm16, %xmm16
	vxorps	%xmm6, %xmm6, %xmm6
	vxorps	%xmm10, %xmm10, %xmm10
	vxorps	%xmm14, %xmm14, %xmm14
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
	vaddps	%zmm14, %zmm17, %zmm14
	vaddps	%zmm10, %zmm18, %zmm10
	vaddps	%zmm6, %zmm19, %zmm6
	vaddps	%zmm16, %zmm20, %zmm16
	vaddps	%zmm11, %zmm21, %zmm11
	vaddps	%zmm5, %zmm22, %zmm5
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
	vmovupd	(%rax,%rdi,4), %zmm17
	vinsertf64x4	$1, (%rax,%rdi,4), %zmm17, %zmm18
	vshuff64x2	$238, %zmm17, %zmm17, %zmm17 # zmm17 = zmm17[4,5,6,7,4,5,6,7]
	vbroadcastf64x4	64(%rax,%rdi,4), %zmm19 # zmm19 = mem[0,1,2,3,0,1,2,3]
	vsubps	%zmm18, %zmm7, %zmm20
	vsubps	%zmm17, %zmm9, %zmm21
	vsubps	%zmm19, %zmm13, %zmm22
	vsubps	%zmm18, %zmm8, %zmm23
	vsubps	%zmm17, %zmm12, %zmm24
	vsubps	%zmm19, %zmm15, %zmm25
	vmulps	%zmm22, %zmm22, %zmm17
	vfmadd231ps	%zmm21, %zmm21, %zmm17 # zmm17 = (zmm21 * zmm21) + zmm17
	vfmadd231ps	%zmm20, %zmm20, %zmm17 # zmm17 = (zmm20 * zmm20) + zmm17
	vmulps	%zmm25, %zmm25, %zmm18
	vfmadd231ps	%zmm24, %zmm24, %zmm18 # zmm18 = (zmm24 * zmm24) + zmm18
	vfmadd231ps	%zmm23, %zmm23, %zmm18 # zmm18 = (zmm23 * zmm23) + zmm18
	vcmpltps	%zmm0, %zmm17, %k1
	vrcp14ps	%zmm17, %zmm17
	vrcp14ps	%zmm18, %zmm19
	vcmpltps	%zmm0, %zmm18, %k2
	vmulps	%zmm30, %zmm17, %zmm18
	vmulps	%zmm17, %zmm17, %zmm26
	vmulps	%zmm18, %zmm26, %zmm18
	vmulps	%zmm30, %zmm19, %zmm26
	vmulps	%zmm19, %zmm19, %zmm27
	vmulps	%zmm26, %zmm27, %zmm26
	vaddps	%zmm2, %zmm18, %zmm27
	vmulps	%zmm17, %zmm1, %zmm17
	vmulps	%zmm18, %zmm17, %zmm17
	vmulps	%zmm27, %zmm17, %zmm27
	vaddps	%zmm2, %zmm26, %zmm17
	vmulps	%zmm19, %zmm1, %zmm18
	vmulps	%zmm26, %zmm18, %zmm18
	vmulps	%zmm17, %zmm18, %zmm26
	vmulps	%zmm20, %zmm27, %zmm17 {%k1} {z}
	vmulps	%zmm21, %zmm27, %zmm18 {%k1} {z}
	vmulps	%zmm22, %zmm27, %zmm19 {%k1} {z}
	vmulps	%zmm23, %zmm26, %zmm20 {%k2} {z}
	vmulps	%zmm24, %zmm26, %zmm21 {%k2} {z}
	vmulps	%zmm25, %zmm26, %zmm22 {%k2} {z}
	movl	4(%rbx), %eax
	sarl	%eax
	cmpl	%eax, %ebp
	jge	.LBB1_13
# %bb.12:                               # 
                                        #   in Loop: Header=BB1_11 Depth=2
	movq	176(%rbx), %rax
	vaddps	%zmm17, %zmm20, %zmm23
	vaddps	%zmm18, %zmm21, %zmm24
	vextractf64x4	$1, %zmm23, %ymm25
	vaddps	%ymm23, %ymm25, %ymm23
	vmovaps	(%rax,%rdi,4), %ymm25
	vsubps	%ymm23, %ymm25, %ymm23
	vmovaps	32(%rax,%rdi,4), %ymm25
	vmovaps	64(%rax,%rdi,4), %ymm26
	vextractf64x4	$1, %zmm24, %ymm27
	vmovaps	%ymm23, (%rax,%rdi,4)
	vaddps	%ymm24, %ymm27, %ymm23
	vsubps	%ymm23, %ymm25, %ymm23
	vmovaps	%ymm23, 32(%rax,%rdi,4)
	vaddps	%zmm19, %zmm22, %zmm23
	vextractf64x4	$1, %zmm23, %ymm24
	vaddps	%ymm23, %ymm24, %ymm23
	vsubps	%ymm23, %ymm26, %ymm23
	vmovaps	%ymm23, 64(%rax,%rdi,4)
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
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2               # -- Begin function computeForceLJ_2xnn_full
.LCPI2_0:
	.long	1111490560              #  48
.LCPI2_1:
	.long	3204448256              #  -0.5
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
	vmovss	108(%r12), %xmm0        # xmm0 = mem[0],zero,zero,zero
	vmovss	%xmm0, 44(%rsp)         # 4-byte Spill
	vbroadcastss	48(%r12), %zmm2
	vmovss	40(%r12), %xmm0         # xmm0 = mem[0],zero,zero,zero
	vmovups	%zmm0, 64(%rsp)         # 64-byte Spill
	movl	20(%r14), %r11d
	testl	%r11d, %r11d
	jle	.LBB2_5
# %bb.1:                                # 
	movq	176(%r14), %r9
	movq	192(%r14), %r10
	decq	%r11
	leaq	64(%r9), %r8
	xorl	%edi, %edi
	vxorps	%xmm0, %xmm0, %xmm0
	vxorps	%xmm1, %xmm1, %xmm1
	jmp	.LBB2_2
	.p2align	4, 0x90
.LBB2_22:                               # 
                                        #   in Loop: Header=BB2_2 Depth=1
	cmpq	%r11, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB2_5
.LBB2_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_17 Depth 2
                                        #     Child Loop BB2_21 Depth 2
	leaq	(%rdi,%rdi,8), %rax
	leaq	(%rax,%rax,2), %rax
	addq	%rdi, %rax
	movl	(%r10,%rax), %ebp
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
	movl	%eax, %ecx
	je	.LBB2_4
# %bb.16:                               # 
                                        #   in Loop: Header=BB2_2 Depth=1
	leaq	(%r9,%rcx,4), %rdx
	shlq	$5, %rsi
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB2_17:                               # 
                                        #   Parent Loop BB2_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovups	%ymm0, (%rdx,%rax)
	addq	$32, %rax
	cmpq	%rax, %rsi
	jne	.LBB2_17
# %bb.18:                               # 
                                        #   in Loop: Header=BB2_2 Depth=1
	movl	%ebp, %esi
	andl	$-8, %esi
	leaq	(%rsi,%rcx), %rax
	vmovups	%zmm1, (%r9,%rax,4)
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
	leaq	(%r8,%rcx,4), %rcx
	.p2align	4, 0x90
.LBB2_21:                               # 
                                        #   Parent Loop BB2_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$0, -64(%rcx,%rsi,4)
	movl	$0, -32(%rcx,%rsi,4)
	movl	$0, (%rcx,%rsi,4)
	incq	%rsi
	cmpq	%rsi, %rbp
	jne	.LBB2_21
	jmp	.LBB2_22
.LBB2_5:                                # 
	xorl	%eax, %eax
	vmovups	%zmm2, 128(%rsp)        # 64-byte Spill
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 48(%rsp)         # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	vmovups	128(%rsp), %zmm29       # 64-byte Reload
	cmpl	$0, 20(%r14)
	jle	.LBB2_13
# %bb.6:                                # 
	vmovss	44(%rsp), %xmm0         # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	vmulss	%xmm0, %xmm0, %xmm0
	vbroadcastss	%xmm0, %zmm0
	vmovups	64(%rsp), %zmm1         # 64-byte Reload
	vmulss	.LCPI2_0(%rip), %xmm1, %xmm1
	vbroadcastss	%xmm1, %zmm1
	xorl	%eax, %eax
	vbroadcastss	.LCPI2_1(%rip), %zmm2 # zmm2 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vmovdqa	.LCPI2_2(%rip), %xmm3   # xmm3 = <1,u>
	jmp	.LBB2_7
	.p2align	4, 0x90
.LBB2_12:                               # 
                                        #   in Loop: Header=BB2_7 Depth=1
	vshuff64x2	$136, %zmm15, %zmm13, %zmm6 # zmm6 = zmm13[0,1,4,5],zmm15[0,1,4,5]
	vshuff64x2	$221, %zmm15, %zmm13, %zmm9 # zmm9 = zmm13[2,3,6,7],zmm15[2,3,6,7]
	vaddps	%zmm6, %zmm9, %zmm6
	vpermilpd	$85, %zmm6, %zmm9 # zmm9 = zmm6[1,0,3,2,5,4,7,6]
	vaddps	%zmm6, %zmm9, %zmm6
	vpermilps	$177, %zmm6, %zmm9 # zmm9 = zmm6[1,0,3,2,5,4,7,6,9,8,11,10,13,12,15,14]
	vaddps	%zmm6, %zmm9, %zmm6
	movw	$4369, %cx              # imm = 0x1111
	kmovd	%ecx, %k1
	vcompressps	%zmm6, %zmm6 {%k1} {z}
	vaddps	(%r11,%r13,4), %xmm6, %xmm6
	vmovaps	%xmm6, (%r11,%r13,4)
	vshuff64x2	$136, %zmm7, %zmm8, %zmm6 # zmm6 = zmm8[0,1,4,5],zmm7[0,1,4,5]
	vshuff64x2	$221, %zmm7, %zmm8, %zmm7 # zmm7 = zmm8[2,3,6,7],zmm7[2,3,6,7]
	vaddps	%zmm6, %zmm7, %zmm6
	vpermilpd	$85, %zmm6, %zmm7 # zmm7 = zmm6[1,0,3,2,5,4,7,6]
	vaddps	%zmm6, %zmm7, %zmm6
	vpermilps	$177, %zmm6, %zmm7 # zmm7 = zmm6[1,0,3,2,5,4,7,6,9,8,11,10,13,12,15,14]
	vaddps	%zmm6, %zmm7, %zmm6
	vcompressps	%zmm6, %zmm6 {%k1} {z}
	vaddps	32(%r11,%r13,4), %xmm6, %xmm6
	vmovaps	%xmm6, 32(%r11,%r13,4)
	vshuff64x2	$136, %zmm4, %zmm5, %zmm6 # zmm6 = zmm5[0,1,4,5],zmm4[0,1,4,5]
	vshuff64x2	$221, %zmm4, %zmm5, %zmm4 # zmm4 = zmm5[2,3,6,7],zmm4[2,3,6,7]
	vaddps	%zmm6, %zmm4, %zmm4
	vpermilpd	$85, %zmm4, %zmm5 # zmm5 = zmm4[1,0,3,2,5,4,7,6]
	vaddps	%zmm4, %zmm5, %zmm4
	vpermilps	$177, %zmm4, %zmm5 # zmm5 = zmm4[1,0,3,2,5,4,7,6,9,8,11,10,13,12,15,14]
	vaddps	%zmm4, %zmm5, %zmm4
	vcompressps	%zmm4, %zmm4 {%k1} {z}
	vaddps	64(%r11,%r13,4), %xmm4, %xmm4
	vmovaps	%xmm4, 64(%r11,%r13,4)
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
	vbroadcastss	(%rcx,%r13,4), %zmm4
	movl	(%rdx,%rax,4), %r15d
	vbroadcastss	4(%rcx,%r13,4), %ymm5
	vinsertf64x4	$1, %ymm5, %zmm4, %zmm6
	vbroadcastss	8(%rcx,%r13,4), %zmm4
	vbroadcastss	12(%rcx,%r13,4), %ymm5
	vbroadcastss	32(%rcx,%r13,4), %zmm7
	vbroadcastss	36(%rcx,%r13,4), %ymm8
	vinsertf64x4	$1, %ymm5, %zmm4, %zmm9
	vinsertf64x4	$1, %ymm8, %zmm7, %zmm10
	vbroadcastss	40(%rcx,%r13,4), %zmm4
	vbroadcastss	44(%rcx,%r13,4), %ymm5
	vinsertf64x4	$1, %ymm5, %zmm4, %zmm11
	vbroadcastss	64(%rcx,%r13,4), %zmm4
	vbroadcastss	68(%rcx,%r13,4), %ymm5
	vinsertf64x4	$1, %ymm5, %zmm4, %zmm12
	vbroadcastss	72(%rcx,%r13,4), %zmm4
	vbroadcastss	76(%rcx,%r13,4), %ymm5
	vinsertf64x4	$1, %ymm5, %zmm4, %zmm14
	testl	%r15d, %r15d
	jle	.LBB2_8
# %bb.14:                               # 
                                        #   in Loop: Header=BB2_7 Depth=1
	movl	%r10d, %edx
	imull	%eax, %edx
	movslq	%edx, %rdx
	leaq	(%r9,%rdx,4), %rdi
	vxorps	%xmm13, %xmm13, %xmm13
	movl	$0, %edx
	vxorps	%xmm8, %xmm8, %xmm8
	vxorps	%xmm5, %xmm5, %xmm5
	vxorps	%xmm15, %xmm15, %xmm15
	vxorps	%xmm7, %xmm7, %xmm7
	vxorps	%xmm4, %xmm4, %xmm4
	.p2align	4, 0x90
.LBB2_15:                               # 
                                        #   Parent Loop BB2_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%rdi,%rdx,4), %rbp
	leaq	(,%rbp,2), %r8
	addq	%rbp, %r8
	shlq	$5, %r8
	vmovupd	(%rcx,%r8), %zmm16
	vbroadcastf64x4	64(%rcx,%r8), %zmm19 # zmm19 = mem[0,1,2,3,0,1,2,3]
	vinsertf64x4	$1, (%rcx,%r8), %zmm16, %zmm17
	vshuff64x2	$238, %zmm16, %zmm16, %zmm16 # zmm16 = zmm16[4,5,6,7,4,5,6,7]
	vsubps	%zmm17, %zmm6, %zmm20
	vsubps	%zmm16, %zmm10, %zmm21
	vsubps	%zmm19, %zmm12, %zmm22
	vsubps	%zmm17, %zmm9, %zmm18
	vsubps	%zmm16, %zmm11, %zmm17
	vsubps	%zmm19, %zmm14, %zmm16
	vmulps	%zmm22, %zmm22, %zmm19
	vfmadd231ps	%zmm21, %zmm21, %zmm19 # zmm19 = (zmm21 * zmm21) + zmm19
	vmulps	%zmm16, %zmm16, %zmm23
	vfmadd231ps	%zmm17, %zmm17, %zmm23 # zmm23 = (zmm17 * zmm17) + zmm23
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
	kmovw	280(%r14,%rbp,4), %k2
	vfmadd231ps	%zmm18, %zmm18, %zmm23 # zmm23 = (zmm18 * zmm18) + zmm23
	leal	(%rsi,%rbx,2), %esi
	incl	%esi
	kmovw	280(%r14,%rsi,4), %k1
	vfmadd231ps	%zmm20, %zmm20, %zmm19 # zmm19 = (zmm20 * zmm20) + zmm19
	vrcp14ps	%zmm19, %zmm24
	vrcp14ps	%zmm23, %zmm25
	vmulps	%zmm29, %zmm24, %zmm26
	vmulps	%zmm24, %zmm24, %zmm27
	vmulps	%zmm26, %zmm27, %zmm26
	vmulps	%zmm29, %zmm25, %zmm27
	vmulps	%zmm25, %zmm25, %zmm28
	vmulps	%zmm27, %zmm28, %zmm27
	vaddps	%zmm2, %zmm26, %zmm28
	vmulps	%zmm24, %zmm1, %zmm24
	vmulps	%zmm26, %zmm24, %zmm24
	vaddps	%zmm2, %zmm27, %zmm26
	vmulps	%zmm25, %zmm1, %zmm25
	vmulps	%zmm28, %zmm24, %zmm24
	vmulps	%zmm27, %zmm25, %zmm25
	vmulps	%zmm26, %zmm25, %zmm25
	vcmpltps	%zmm0, %zmm19, %k2 {%k2}
	vfmadd231ps	%zmm20, %zmm24, %zmm13 {%k2} # zmm13 = (zmm24 * zmm20) + zmm13
	vfmadd231ps	%zmm21, %zmm24, %zmm8 {%k2} # zmm8 = (zmm24 * zmm21) + zmm8
	vfmadd231ps	%zmm22, %zmm24, %zmm5 {%k2} # zmm5 = (zmm24 * zmm22) + zmm5
	vcmpltps	%zmm0, %zmm23, %k1 {%k1}
	vfmadd231ps	%zmm18, %zmm25, %zmm15 {%k1} # zmm15 = (zmm25 * zmm18) + zmm15
	vfmadd231ps	%zmm17, %zmm25, %zmm7 {%k1} # zmm7 = (zmm25 * zmm17) + zmm7
	vfmadd231ps	%zmm16, %zmm25, %zmm4 {%k1} # zmm4 = (zmm25 * zmm16) + zmm4
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
	vxorps	%xmm4, %xmm4, %xmm4
	vxorps	%xmm7, %xmm7, %xmm7
	vxorps	%xmm15, %xmm15, %xmm15
	vxorps	%xmm5, %xmm5, %xmm5
	vxorps	%xmm8, %xmm8, %xmm8
	vxorps	%xmm13, %xmm13, %xmm13
	cmpl	%r12d, %r15d
	jge	.LBB2_12
.LBB2_10:                               # 
                                        #   in Loop: Header=BB2_7 Depth=1
	movslq	%r15d, %rdx
	imull	%eax, %r10d
	movslq	%r10d, %rsi
	leaq	(%r9,%rsi,4), %rsi
	.p2align	4, 0x90
movl      $111, %ebx # OSACA START MARKER
.byte     100        # OSACA START MARKER
.byte     103        # OSACA START MARKER
.byte     144        # OSACA START MARKER
# LLVM-MCA-BEGIN
.LBB2_11:                               # 
                                        #   Parent Loop BB2_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%rsi,%rdx,4), %rdi
	leaq	(%rdi,%rdi,2), %rdi
	shlq	$5, %rdi
	vmovupd	(%rcx,%rdi), %zmm16
	vinsertf64x4	$1, (%rcx,%rdi), %zmm16, %zmm17
	vbroadcastf64x4	64(%rcx,%rdi), %zmm18 # zmm18 = mem[0,1,2,3,0,1,2,3]
	vshuff64x2	$238, %zmm16, %zmm16, %zmm16 # zmm16 = zmm16[4,5,6,7,4,5,6,7]
	vsubps	%zmm17, %zmm6, %zmm19
	vsubps	%zmm16, %zmm10, %zmm20
	vsubps	%zmm18, %zmm12, %zmm21
	vsubps	%zmm17, %zmm9, %zmm17
	vsubps	%zmm18, %zmm14, %zmm18
	vsubps	%zmm16, %zmm11, %zmm16
	vmulps	%zmm21, %zmm21, %zmm22
	vfmadd231ps	%zmm20, %zmm20, %zmm22 # zmm22 = (zmm20 * zmm20) + zmm22
	vfmadd231ps	%zmm19, %zmm19, %zmm22 # zmm22 = (zmm19 * zmm19) + zmm22
	vmulps	%zmm18, %zmm18, %zmm23
	vfmadd231ps	%zmm16, %zmm16, %zmm23 # zmm23 = (zmm16 * zmm16) + zmm23
	vfmadd231ps	%zmm17, %zmm17, %zmm23 # zmm23 = (zmm17 * zmm17) + zmm23
	vrcp14ps	%zmm22, %zmm24
	vrcp14ps	%zmm23, %zmm25
	vcmpltps	%zmm0, %zmm22, %k2
	vcmpltps	%zmm0, %zmm23, %k1
	vmulps	%zmm29, %zmm24, %zmm22
	vmulps	%zmm24, %zmm24, %zmm23
	vmulps	%zmm29, %zmm25, %zmm26
	vmulps	%zmm22, %zmm23, %zmm22
	vmulps	%zmm25, %zmm25, %zmm23
	vmulps	%zmm26, %zmm23, %zmm23
	vaddps	%zmm2, %zmm22, %zmm26
	vmulps	%zmm24, %zmm1, %zmm24
	vmulps	%zmm22, %zmm24, %zmm22
	vmulps	%zmm26, %zmm22, %zmm22
	vaddps	%zmm2, %zmm23, %zmm24
	vmulps	%zmm25, %zmm1, %zmm25
	vmulps	%zmm23, %zmm25, %zmm23
	vmulps	%zmm24, %zmm23, %zmm23
	vfmadd231ps	%zmm19, %zmm22, %zmm13 {%k2} # zmm13 = (zmm22 * zmm19) + zmm13
	vfmadd231ps	%zmm20, %zmm22, %zmm8 {%k2} # zmm8 = (zmm22 * zmm20) + zmm8
	vfmadd231ps	%zmm21, %zmm22, %zmm5 {%k2} # zmm5 = (zmm22 * zmm21) + zmm5
	vfmadd231ps	%zmm17, %zmm23, %zmm15 {%k1} # zmm15 = (zmm23 * zmm17) + zmm15
	vfmadd231ps	%zmm16, %zmm23, %zmm7 {%k1} # zmm7 = (zmm23 * zmm16) + zmm7
	vfmadd231ps	%zmm18, %zmm23, %zmm4 {%k1} # zmm4 = (zmm23 * zmm18) + zmm4
	incq	%rdx
	cmpq	%rdx, %r12
	jne	.LBB2_11
	jmp	.LBB2_12
# LLVM-MCA-END
movl      $222, %ebx # OSACA END MARKER
.byte     100        # OSACA END MARKER
.byte     103        # OSACA END MARKER
.byte     144        # OSACA END MARKER
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
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2               # -- Begin function computeForceLJ_4xn_half
.LCPI4_0:
	.long	3258974208              #  -48
.LCPI4_1:
	.long	3204448256              #  -0.5
.LCPI4_2:
	.long	2147483648              #  -0
	.text
	.globl	computeForceLJ_4xn_half
	.p2align	4, 0x90
	.type	computeForceLJ_4xn_half,@function
computeForceLJ_4xn_half:                # 
.LcomputeForceLJ_4xn_half$local:
	.cfi_startproc
# %bb.0:                                # 
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$224, %rsp
	.cfi_def_cfa_offset 256
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %rbx
	movl	$.L.str.5, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovss	108(%rbx), %xmm0        # xmm0 = mem[0],zero,zero,zero
	vmovss	%xmm0, 52(%rsp)         # 4-byte Spill
	vbroadcastss	48(%rbx), %zmm0
	vmovups	%zmm0, 64(%rsp)         # 64-byte Spill
	vbroadcastss	40(%rbx), %zmm0
	vmovups	%zmm0, 128(%rsp)        # 64-byte Spill
	movl	20(%r15), %r11d
	testl	%r11d, %r11d
	jle	.LBB4_5
# %bb.1:                                # 
	movq	176(%r15), %r9
	movq	192(%r15), %r10
	decq	%r11
	leaq	64(%r9), %r8
	xorl	%edi, %edi
	vxorps	%xmm0, %xmm0, %xmm0
	vxorps	%xmm1, %xmm1, %xmm1
	jmp	.LBB4_2
	.p2align	4, 0x90
.LBB4_24:                               # 
                                        #   in Loop: Header=BB4_2 Depth=1
	cmpq	%r11, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB4_5
.LBB4_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_19 Depth 2
                                        #     Child Loop BB4_23 Depth 2
	leaq	(%rdi,%rdi,8), %rax
	leaq	(%rax,%rax,2), %rax
	addq	%rdi, %rax
	movl	(%r10,%rax), %edx
	testl	%edx, %edx
	jle	.LBB4_24
# %bb.3:                                # 
                                        #   in Loop: Header=BB4_2 Depth=1
	leal	(,%rdi,4), %eax
	movl	%eax, %ecx
	andl	$-8, %ecx
	leal	(%rcx,%rcx,2), %ecx
	andl	$4, %eax
	orl	%ecx, %eax
	movq	%rdx, %rcx
	shrq	$3, %rcx
	movl	%eax, %esi
	je	.LBB4_4
# %bb.18:                               # 
                                        #   in Loop: Header=BB4_2 Depth=1
	leaq	(%r9,%rsi,4), %rbx
	shlq	$5, %rcx
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB4_19:                               # 
                                        #   Parent Loop BB4_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovups	%ymm0, (%rbx,%rax)
	addq	$32, %rax
	cmpq	%rax, %rcx
	jne	.LBB4_19
# %bb.20:                               # 
                                        #   in Loop: Header=BB4_2 Depth=1
	movl	%edx, %ebx
	andl	$-8, %ebx
	leaq	(%rbx,%rsi), %rax
	vmovups	%zmm1, (%r9,%rax,4)
	cmpq	%rdx, %rbx
	jae	.LBB4_24
	jmp	.LBB4_22
	.p2align	4, 0x90
.LBB4_4:                                # 
                                        #   in Loop: Header=BB4_2 Depth=1
	movl	%edx, %ebx
	andl	$-8, %ebx
	cmpq	%rdx, %rbx
	jae	.LBB4_24
.LBB4_22:                               # 
                                        #   in Loop: Header=BB4_2 Depth=1
	leaq	(%r8,%rsi,4), %rcx
	.p2align	4, 0x90
.LBB4_23:                               # 
                                        #   Parent Loop BB4_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$0, -64(%rcx,%rbx,4)
	movl	$0, -32(%rcx,%rbx,4)
	movl	$0, (%rcx,%rbx,4)
	incq	%rbx
	cmpq	%rbx, %rdx
	jne	.LBB4_23
	jmp	.LBB4_24
.LBB4_5:                                # 
	xorl	%eax, %eax
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 56(%rsp)         # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	cmpl	$0, 20(%r15)
	jg	.LBB4_6
# %bb.25:                               # 
	movl	$.L.str.1, %edi
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, 64(%rsp)         # 8-byte Spill
	movl	$.L.str.6, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	64(%rsp), %xmm0         # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vsubsd	56(%rsp), %xmm0, %xmm0  # 8-byte Folded Reload
	addq	$224, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB4_6:                                # 
	.cfi_def_cfa_offset 256
	vmovss	52(%rsp), %xmm0         # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	vmulss	%xmm0, %xmm0, %xmm0
	vbroadcastss	%xmm0, %zmm0
	movq	160(%r15), %rsi
	movq	40(%r14), %r10
	movq	16(%r14), %rax
	movq	24(%r14), %rcx
	movslq	(%rax), %r9
	vbroadcastss	(%rsi), %zmm1
	vbroadcastss	4(%rsi), %zmm2
	vbroadcastss	8(%rsi), %zmm3
	vbroadcastss	12(%rsi), %zmm4
	vbroadcastss	32(%rsi), %zmm5
	vbroadcastss	36(%rsi), %zmm6
	vbroadcastss	40(%rsi), %zmm7
	vbroadcastss	44(%rsi), %zmm8
	vbroadcastss	64(%rsi), %zmm9
	vbroadcastss	68(%rsi), %zmm10
	movl	(%rcx), %edx
	vbroadcastss	72(%rsi), %zmm11
	vbroadcastss	76(%rsi), %zmm12
	testl	%edx, %edx
	jle	.LBB4_11
# %bb.7:                                # 
	vmovups	128(%rsp), %zmm13       # 64-byte Reload
	vmulps	.LCPI4_0(%rip){1to16}, %zmm13, %zmm13
	leaq	-1(%rdx), %r8
	xorl	%r11d, %r11d
	vbroadcastss	.LCPI4_1(%rip), %zmm14 # zmm14 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vbroadcastss	.LCPI4_2(%rip), %zmm15 # zmm15 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
	vmovups	64(%rsp), %zmm30        # 64-byte Reload
.LBB4_8:                                # 
                                        # =>This Inner Loop Header: Depth=1
	movslq	(%r10,%r11,4), %rbx
	xorl	%ecx, %ecx
	testl	$2147483647, %ebx       # imm = 0x7FFFFFFF
	sete	%al
	movl	4(%r15), %edi
	sarl	%edi
	cmpl	%edi, %ebx
	jge	.LBB4_10
# %bb.9:                                # 
                                        #   in Loop: Header=BB4_8 Depth=1
	shlq	$3, %rbx
	leaq	(%rbx,%rbx,2), %rbx
	vmovaps	(%rsi,%rbx,4), %zmm19
	vmovaps	32(%rsi,%rbx,4), %zmm20
	vmovaps	64(%rsi,%rbx,4), %zmm28
	vsubps	%zmm19, %zmm1, %zmm27
	vsubps	%zmm20, %zmm5, %zmm26
	vsubps	%zmm28, %zmm9, %zmm24
	vsubps	%zmm19, %zmm2, %zmm16
	vsubps	%zmm20, %zmm6, %zmm17
	vsubps	%zmm28, %zmm10, %zmm18
	movb	%al, %cl
	leal	(,%rcx,8), %eax
	kmovw	312(%r15,%rax,4), %k4
	vsubps	%zmm19, %zmm3, %zmm23
	vsubps	%zmm20, %zmm7, %zmm22
	leal	1(,%rcx,8), %eax
	kmovw	312(%r15,%rax,4), %k3
	vsubps	%zmm28, %zmm11, %zmm25
	vsubps	%zmm19, %zmm4, %zmm19
	leal	2(,%rcx,8), %eax
	kmovw	312(%r15,%rax,4), %k2
	vsubps	%zmm20, %zmm8, %zmm21
	vsubps	%zmm28, %zmm12, %zmm20
	leal	3(,%rcx,8), %eax
	kmovw	312(%r15,%rax,4), %k1
	vmulps	%zmm24, %zmm24, %zmm28
	vfmadd231ps	%zmm26, %zmm26, %zmm28 # zmm28 = (zmm26 * zmm26) + zmm28
	vfmadd231ps	%zmm27, %zmm27, %zmm28 # zmm28 = (zmm27 * zmm27) + zmm28
	vrcp14ps	%zmm28, %zmm29
	vcmpltps	%zmm0, %zmm28, %k4 {%k4}
	vmulps	%zmm29, %zmm29, %zmm28
	vmulps	%zmm30, %zmm28, %zmm28
	vmulps	%zmm29, %zmm28, %zmm28
	vmulps	%zmm13, %zmm29, %zmm29
	vmulps	%zmm29, %zmm28, %zmm29
	vaddps	%zmm14, %zmm28, %zmm28
	vmulps	%zmm29, %zmm28, %zmm28
	vmovaps	%zmm15, %zmm29
	vmulps	%zmm28, %zmm27, %zmm29 {%k4}
	vmovaps	%zmm15, %zmm27
	vmulps	%zmm28, %zmm26, %zmm27 {%k4}
	vmovaps	%zmm15, %zmm26
	vmulps	%zmm28, %zmm24, %zmm26 {%k4}
	vmulps	%zmm18, %zmm18, %zmm24
	vfmadd231ps	%zmm17, %zmm17, %zmm24 # zmm24 = (zmm17 * zmm17) + zmm24
	vfmadd231ps	%zmm16, %zmm16, %zmm24 # zmm24 = (zmm16 * zmm16) + zmm24
	vrcp14ps	%zmm24, %zmm28
	vcmpltps	%zmm0, %zmm24, %k3 {%k3}
	vmulps	%zmm28, %zmm28, %zmm24
	vmulps	%zmm30, %zmm24, %zmm24
	vmulps	%zmm28, %zmm24, %zmm24
	vmulps	%zmm13, %zmm28, %zmm28
	vmulps	%zmm28, %zmm24, %zmm28
	vaddps	%zmm14, %zmm24, %zmm24
	vmulps	%zmm28, %zmm24, %zmm24
	vmovaps	%zmm15, %zmm28
	vmulps	%zmm24, %zmm16, %zmm28 {%k3}
	vmovaps	%zmm15, %zmm16
	vmulps	%zmm24, %zmm17, %zmm16 {%k3}
	vmovaps	%zmm15, %zmm17
	vmulps	%zmm24, %zmm18, %zmm17 {%k3}
	vmulps	%zmm25, %zmm25, %zmm18
	vfmadd231ps	%zmm22, %zmm22, %zmm18 # zmm18 = (zmm22 * zmm22) + zmm18
	vfmadd231ps	%zmm23, %zmm23, %zmm18 # zmm18 = (zmm23 * zmm23) + zmm18
	vrcp14ps	%zmm18, %zmm24
	vcmpltps	%zmm0, %zmm18, %k2 {%k2}
	vmulps	%zmm24, %zmm24, %zmm18
	vmulps	%zmm30, %zmm18, %zmm18
	vmulps	%zmm24, %zmm18, %zmm18
	vmulps	%zmm13, %zmm24, %zmm24
	vmulps	%zmm24, %zmm18, %zmm24
	vaddps	%zmm14, %zmm18, %zmm18
	vmulps	%zmm24, %zmm18, %zmm18
	vmovaps	%zmm15, %zmm24
	vmulps	%zmm18, %zmm23, %zmm24 {%k2}
	vmovaps	%zmm15, %zmm23
	vmulps	%zmm18, %zmm22, %zmm23 {%k2}
	vmovaps	%zmm15, %zmm22
	vmulps	%zmm18, %zmm25, %zmm22 {%k2}
	vmulps	%zmm20, %zmm20, %zmm18
	vfmadd231ps	%zmm21, %zmm21, %zmm18 # zmm18 = (zmm21 * zmm21) + zmm18
	vfmadd231ps	%zmm19, %zmm19, %zmm18 # zmm18 = (zmm19 * zmm19) + zmm18
	vrcp14ps	%zmm18, %zmm25
	vcmpltps	%zmm0, %zmm18, %k1 {%k1}
	vmulps	%zmm25, %zmm25, %zmm18
	vmulps	%zmm30, %zmm18, %zmm18
	vmulps	%zmm25, %zmm18, %zmm18
	vmulps	%zmm13, %zmm25, %zmm25
	vmulps	%zmm25, %zmm18, %zmm25
	vaddps	%zmm14, %zmm18, %zmm18
	vmulps	%zmm25, %zmm18, %zmm18
	vmovaps	%zmm15, %zmm25
	vmulps	%zmm18, %zmm19, %zmm25 {%k1}
	vmovaps	%zmm15, %zmm19
	vmulps	%zmm18, %zmm21, %zmm19 {%k1}
	vmovaps	%zmm15, %zmm21
	vmulps	%zmm18, %zmm20, %zmm21 {%k1}
	vaddps	%zmm29, %zmm28, %zmm18
	vaddps	%zmm25, %zmm24, %zmm20
	vaddps	%zmm20, %zmm18, %zmm18
	movq	176(%r15), %rax
	vaddps	(%rax,%rbx,4), %zmm18, %zmm18
	vmovaps	%zmm18, (%rax,%rbx,4)
	vaddps	%zmm27, %zmm16, %zmm16
	vaddps	%zmm19, %zmm23, %zmm18
	vaddps	%zmm18, %zmm16, %zmm16
	vaddps	32(%rax,%rbx,4), %zmm16, %zmm16
	vmovaps	%zmm16, 32(%rax,%rbx,4)
	vaddps	%zmm26, %zmm17, %zmm16
	vaddps	%zmm21, %zmm22, %zmm17
	vaddps	%zmm17, %zmm16, %zmm16
	vaddps	64(%rax,%rbx,4), %zmm16, %zmm16
	vmovaps	%zmm16, 64(%rax,%rbx,4)
.LBB4_10:                               # 
                                        #   in Loop: Header=BB4_8 Depth=1
	cmpq	%r11, %r8
	je	.LBB4_11
# %bb.17:                               # 
                                        #   in Loop: Header=BB4_8 Depth=1
	incq	%r11
	movq	160(%r15), %rsi
	jmp	.LBB4_8
.LBB4_11:                               # 
	cmpl	%r9d, %edx
	jge	.LBB4_16
# %bb.12:                               # 
	movslq	%edx, %rdx
	vmovups	128(%rsp), %zmm13       # 64-byte Reload
	vmulps	.LCPI4_0(%rip){1to16}, %zmm13, %zmm13
	vbroadcastss	.LCPI4_1(%rip), %zmm14 # zmm14 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vbroadcastss	.LCPI4_2(%rip), %zmm15 # zmm15 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
	vmovups	64(%rsp), %zmm30        # 64-byte Reload
.LBB4_13:                               # 
                                        # =>This Inner Loop Header: Depth=1
	movslq	(%r10,%rdx,4), %rax
	movl	4(%r15), %ecx
	sarl	%ecx
	cmpl	%ecx, %eax
	jge	.LBB4_15
# %bb.14:                               # 
                                        #   in Loop: Header=BB4_13 Depth=1
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movq	160(%r15), %rax
	vmovaps	(%rax,%rsi,4), %zmm16
	vmovaps	32(%rax,%rsi,4), %zmm17
	vmovaps	64(%rax,%rsi,4), %zmm27
	vsubps	%zmm16, %zmm1, %zmm28
	vsubps	%zmm17, %zmm5, %zmm26
	vsubps	%zmm27, %zmm9, %zmm25
	vsubps	%zmm16, %zmm2, %zmm24
	vsubps	%zmm17, %zmm6, %zmm23
	vsubps	%zmm27, %zmm10, %zmm22
	vsubps	%zmm16, %zmm3, %zmm21
	vsubps	%zmm17, %zmm7, %zmm20
	vsubps	%zmm27, %zmm11, %zmm19
	vsubps	%zmm16, %zmm4, %zmm18
	vsubps	%zmm17, %zmm8, %zmm17
	vsubps	%zmm27, %zmm12, %zmm16
	vmulps	%zmm25, %zmm25, %zmm27
	vfmadd231ps	%zmm26, %zmm26, %zmm27 # zmm27 = (zmm26 * zmm26) + zmm27
	vfmadd231ps	%zmm28, %zmm28, %zmm27 # zmm27 = (zmm28 * zmm28) + zmm27
	vrcp14ps	%zmm27, %zmm29
	vcmpltps	%zmm0, %zmm27, %k1
	vmulps	%zmm29, %zmm29, %zmm27
	vmulps	%zmm30, %zmm27, %zmm27
	vmulps	%zmm29, %zmm27, %zmm27
	vmulps	%zmm13, %zmm29, %zmm29
	vmulps	%zmm29, %zmm27, %zmm29
	vaddps	%zmm14, %zmm27, %zmm27
	vmulps	%zmm29, %zmm27, %zmm27
	vmovaps	%zmm15, %zmm29
	vmulps	%zmm27, %zmm28, %zmm29 {%k1}
	vmovaps	%zmm15, %zmm28
	vmulps	%zmm27, %zmm26, %zmm28 {%k1}
	vmovaps	%zmm15, %zmm26
	vmulps	%zmm27, %zmm25, %zmm26 {%k1}
	vmulps	%zmm22, %zmm22, %zmm25
	vfmadd231ps	%zmm23, %zmm23, %zmm25 # zmm25 = (zmm23 * zmm23) + zmm25
	vfmadd231ps	%zmm24, %zmm24, %zmm25 # zmm25 = (zmm24 * zmm24) + zmm25
	vrcp14ps	%zmm25, %zmm27
	vcmpltps	%zmm0, %zmm25, %k1
	vmulps	%zmm27, %zmm27, %zmm25
	vmulps	%zmm30, %zmm25, %zmm25
	vmulps	%zmm27, %zmm25, %zmm25
	vmulps	%zmm13, %zmm27, %zmm27
	vmulps	%zmm27, %zmm25, %zmm27
	vaddps	%zmm14, %zmm25, %zmm25
	vmulps	%zmm27, %zmm25, %zmm25
	vmovaps	%zmm15, %zmm27
	vmulps	%zmm25, %zmm24, %zmm27 {%k1}
	vmovaps	%zmm15, %zmm24
	vmulps	%zmm25, %zmm23, %zmm24 {%k1}
	vmovaps	%zmm15, %zmm23
	vmulps	%zmm25, %zmm22, %zmm23 {%k1}
	vmulps	%zmm19, %zmm19, %zmm22
	vfmadd231ps	%zmm20, %zmm20, %zmm22 # zmm22 = (zmm20 * zmm20) + zmm22
	vfmadd231ps	%zmm21, %zmm21, %zmm22 # zmm22 = (zmm21 * zmm21) + zmm22
	vrcp14ps	%zmm22, %zmm25
	vcmpltps	%zmm0, %zmm22, %k1
	vmulps	%zmm25, %zmm25, %zmm22
	vmulps	%zmm30, %zmm22, %zmm22
	vmulps	%zmm25, %zmm22, %zmm22
	vmulps	%zmm13, %zmm25, %zmm25
	vmulps	%zmm25, %zmm22, %zmm25
	vaddps	%zmm14, %zmm22, %zmm22
	vmulps	%zmm25, %zmm22, %zmm22
	vmovaps	%zmm15, %zmm25
	vmulps	%zmm22, %zmm21, %zmm25 {%k1}
	vmovaps	%zmm15, %zmm21
	vmulps	%zmm22, %zmm20, %zmm21 {%k1}
	vmovaps	%zmm15, %zmm20
	vmulps	%zmm22, %zmm19, %zmm20 {%k1}
	vmulps	%zmm16, %zmm16, %zmm19
	vfmadd231ps	%zmm17, %zmm17, %zmm19 # zmm19 = (zmm17 * zmm17) + zmm19
	vfmadd231ps	%zmm18, %zmm18, %zmm19 # zmm19 = (zmm18 * zmm18) + zmm19
	vrcp14ps	%zmm19, %zmm22
	vcmpltps	%zmm0, %zmm19, %k1
	vmulps	%zmm22, %zmm22, %zmm19
	vmulps	%zmm30, %zmm19, %zmm19
	vmulps	%zmm22, %zmm19, %zmm19
	vmulps	%zmm13, %zmm22, %zmm22
	vmulps	%zmm22, %zmm19, %zmm22
	vaddps	%zmm14, %zmm19, %zmm19
	vmulps	%zmm22, %zmm19, %zmm19
	vmovaps	%zmm15, %zmm22
	vmulps	%zmm19, %zmm18, %zmm22 {%k1}
	vmovaps	%zmm15, %zmm18
	vmulps	%zmm19, %zmm17, %zmm18 {%k1}
	vmovaps	%zmm15, %zmm17
	vmulps	%zmm19, %zmm16, %zmm17 {%k1}
	vaddps	%zmm29, %zmm27, %zmm16
	vaddps	%zmm22, %zmm25, %zmm19
	vaddps	%zmm19, %zmm16, %zmm16
	movq	176(%r15), %rax
	vaddps	(%rax,%rsi,4), %zmm16, %zmm16
	vmovaps	%zmm16, (%rax,%rsi,4)
	vaddps	%zmm28, %zmm24, %zmm16
	vaddps	%zmm18, %zmm21, %zmm18
	vaddps	%zmm18, %zmm16, %zmm16
	vaddps	32(%rax,%rsi,4), %zmm16, %zmm16
	vmovaps	%zmm16, 32(%rax,%rsi,4)
	vaddps	%zmm26, %zmm23, %zmm16
	vaddps	%zmm17, %zmm20, %zmm17
	vaddps	%zmm17, %zmm16, %zmm16
	vaddps	64(%rax,%rsi,4), %zmm16, %zmm16
	vmovaps	%zmm16, 64(%rax,%rsi,4)
.LBB4_15:                               # 
                                        #   in Loop: Header=BB4_13 Depth=1
	incq	%rdx
	cmpq	%rdx, %r9
	jne	.LBB4_13
.LBB4_16:                               # 
	vzeroupper
	callq	simd_incr_reduced_sum
.Lfunc_end4:
	.size	computeForceLJ_4xn_half, .Lfunc_end4-computeForceLJ_4xn_half
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90         # -- Begin function simd_incr_reduced_sum
	.type	simd_incr_reduced_sum,@function
simd_incr_reduced_sum:                  # 
	.cfi_startproc
# %bb.0:                                # 
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	stderr(%rip), %rcx
	movl	$.L.str.7, %edi
	movl	$92, %esi
	movl	$1, %edx
	callq	fwrite
	movl	$-1, %edi
	callq	exit
.Lfunc_end5:
	.size	simd_incr_reduced_sum, .Lfunc_end5-simd_incr_reduced_sum
	.cfi_endproc
                                        # -- End function
	.globl	computeForceLJ_4xn_full # -- Begin function computeForceLJ_4xn_full
	.p2align	4, 0x90
	.type	computeForceLJ_4xn_full,@function
computeForceLJ_4xn_full:                # 
.LcomputeForceLJ_4xn_full$local:
	.cfi_startproc
# %bb.0:                                # 
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdx, %r14
	movq	%rsi, %r15
	movl	$.L.str.5, %edi
	xorl	%eax, %eax
	callq	debug_printf
	movl	20(%r15), %r11d
	testl	%r11d, %r11d
	jle	.LBB6_5
# %bb.1:                                # 
	movq	176(%r15), %r9
	movq	192(%r15), %r10
	decq	%r11
	leaq	64(%r9), %r8
	xorl	%edi, %edi
	vxorps	%xmm0, %xmm0, %xmm0
	vxorps	%xmm1, %xmm1, %xmm1
	jmp	.LBB6_2
	.p2align	4, 0x90
.LBB6_19:                               # 
                                        #   in Loop: Header=BB6_2 Depth=1
	cmpq	%r11, %rdi
	leaq	1(%rdi), %rdi
	je	.LBB6_5
.LBB6_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB6_14 Depth 2
                                        #     Child Loop BB6_18 Depth 2
	leaq	(%rdi,%rdi,8), %rax
	leaq	(%rax,%rax,2), %rax
	addq	%rdi, %rax
	movl	(%r10,%rax), %edx
	testl	%edx, %edx
	jle	.LBB6_19
# %bb.3:                                # 
                                        #   in Loop: Header=BB6_2 Depth=1
	leal	(,%rdi,4), %eax
	movl	%eax, %ecx
	andl	$-8, %ecx
	leal	(%rcx,%rcx,2), %ecx
	andl	$4, %eax
	orl	%ecx, %eax
	movq	%rdx, %rcx
	shrq	$3, %rcx
	movl	%eax, %esi
	je	.LBB6_4
# %bb.13:                               # 
                                        #   in Loop: Header=BB6_2 Depth=1
	leaq	(%r9,%rsi,4), %rbx
	shlq	$5, %rcx
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB6_14:                               # 
                                        #   Parent Loop BB6_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovups	%ymm0, (%rbx,%rax)
	addq	$32, %rax
	cmpq	%rax, %rcx
	jne	.LBB6_14
# %bb.15:                               # 
                                        #   in Loop: Header=BB6_2 Depth=1
	movl	%edx, %ebx
	andl	$-8, %ebx
	leaq	(%rbx,%rsi), %rax
	vmovups	%zmm1, (%r9,%rax,4)
	cmpq	%rdx, %rbx
	jae	.LBB6_19
	jmp	.LBB6_17
	.p2align	4, 0x90
.LBB6_4:                                # 
                                        #   in Loop: Header=BB6_2 Depth=1
	movl	%edx, %ebx
	andl	$-8, %ebx
	cmpq	%rdx, %rbx
	jae	.LBB6_19
.LBB6_17:                               # 
                                        #   in Loop: Header=BB6_2 Depth=1
	leaq	(%r8,%rsi,4), %rcx
	.p2align	4, 0x90
.LBB6_18:                               # 
                                        #   Parent Loop BB6_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$0, -64(%rcx,%rbx,4)
	movl	$0, -32(%rcx,%rbx,4)
	movl	$0, (%rcx,%rbx,4)
	incq	%rbx
	cmpq	%rbx, %rdx
	jne	.LBB6_18
	jmp	.LBB6_19
.LBB6_5:                                # 
	xorl	%eax, %eax
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 8(%rsp)          # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	cmpl	$0, 20(%r15)
	jg	.LBB6_6
# %bb.20:                               # 
	movl	$.L.str.1, %edi
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, (%rsp)           # 8-byte Spill
	movl	$.L.str.6, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	(%rsp), %xmm0           # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vsubsd	8(%rsp), %xmm0, %xmm0   # 8-byte Folded Reload
	addq	$16, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB6_6:                                # 
	.cfi_def_cfa_offset 48
	movq	24(%r14), %rax
	movl	(%rax), %ecx
	testl	%ecx, %ecx
	jle	.LBB6_12
# %bb.7:                                # 
	leaq	-1(%rcx), %rdx
	movl	%ecx, %eax
	andl	$7, %eax
	cmpq	$7, %rdx
	jb	.LBB6_10
# %bb.8:                                # 
	movq	%rax, %rdx
	subq	%rcx, %rdx
.LBB6_9:                                # 
                                        # =>This Inner Loop Header: Depth=1
	addq	$8, %rdx
	jne	.LBB6_9
.LBB6_10:                               # 
	testq	%rax, %rax
	je	.LBB6_12
.LBB6_11:                               # 
                                        # =>This Inner Loop Header: Depth=1
	decq	%rax
	jne	.LBB6_11
.LBB6_12:                               # 
	callq	simd_incr_reduced_sum
.Lfunc_end6:
	.size	computeForceLJ_4xn_full, .Lfunc_end6-computeForceLJ_4xn_full
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
	je	.LBB7_2
# %bb.1:                                # 
	jmp	.LcomputeForceLJ_4xn_half$local # TAILCALL
.LBB7_2:                                # 
	jmp	.LcomputeForceLJ_4xn_full$local # TAILCALL
.Lfunc_end7:
	.size	computeForceLJ_4xn, .Lfunc_end7-computeForceLJ_4xn
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

	.type	.L.str.7,@object        # 
.L.str.7:
	.asciz	"simd_h_reduce_sum(): Called with AVX512 intrinsics and single-precision which is not valid!\n"
	.size	.L.str.7, 93

	.ident	"Intel(R) oneAPI DPC++ Compiler 2021.1-beta05 (2020.2.0.0304)"
	.section	".note.GNU-stack","",@progbits
