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
	movq	%rcx, %r14
	movq	%rdx, 24(%rsp)          # 8-byte Spill
	movq	%rsi, %r12
	movq	%rdi, %rbx
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	144(%rbx), %xmm0        # xmm0 = mem[0],zero
	vmovsd	%xmm0, 8(%rsp)          # 8-byte Spill
	vmovsd	40(%rbx), %xmm0         # xmm0 = mem[0],zero
	vmovsd	%xmm0, 16(%rsp)         # 8-byte Spill
	vmovsd	56(%rbx), %xmm1         # xmm1 = mem[0],zero
	movl	20(%r12), %r9d
	testl	%r9d, %r9d
	jle	.LBB0_6
# %bb.1:                                # 
	movq	176(%r12), %rcx
	movq	192(%r12), %r8
	xorl	%r10d, %r10d
	vxorps	%xmm0, %xmm0, %xmm0
	leaq	288(%rcx), %rdi
	jmp	.LBB0_2
	.p2align	4, 0x90
.LBB0_22:                               # 
                                        #   in Loop: Header=BB0_2 Depth=1
	incq	%r10
	addq	$96, %rdi
	addq	$96, %rcx
	cmpq	%r9, %r10
	jae	.LBB0_6
.LBB0_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_17 Depth 2
                                        #     Child Loop BB0_20 Depth 2
                                        #     Child Loop BB0_5 Depth 2
	imulq	$56, %r10, %rax
	movl	(%r8,%rax), %ebx
	testl	%ebx, %ebx
	jle	.LBB0_22
# %bb.3:                                # 
                                        #   in Loop: Header=BB0_2 Depth=1
	cmpl	$3, %ebx
	ja	.LBB0_14
# %bb.4:                                # 
                                        #   in Loop: Header=BB0_2 Depth=1
	xorl	%ebp, %ebp
	jmp	.LBB0_5
	.p2align	4, 0x90
.LBB0_14:                               # 
                                        #   in Loop: Header=BB0_2 Depth=1
	movl	%ebx, %ebp
	andl	$-4, %ebp
	leaq	-4(%rbp), %rdx
	movq	%rdx, %rax
	shrq	$2, %rax
	incq	%rax
	movl	%eax, %esi
	andl	$7, %esi
	cmpq	$28, %rdx
	jae	.LBB0_16
# %bb.15:                               # 
                                        #   in Loop: Header=BB0_2 Depth=1
	xorl	%eax, %eax
	jmp	.LBB0_18
.LBB0_16:                               # 
                                        #   in Loop: Header=BB0_2 Depth=1
	movq	%rsi, %rdx
	subq	%rax, %rdx
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB0_17:                               # 
                                        #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovups	%ymm0, -288(%rdi,%rax,8)
	vmovups	%ymm0, -256(%rdi,%rax,8)
	vmovups	%ymm0, -224(%rdi,%rax,8)
	vmovups	%ymm0, -192(%rdi,%rax,8)
	vmovups	%ymm0, -160(%rdi,%rax,8)
	vmovups	%ymm0, -128(%rdi,%rax,8)
	vmovups	%ymm0, -96(%rdi,%rax,8)
	vmovups	%ymm0, -64(%rdi,%rax,8)
	vmovups	%ymm0, -32(%rdi,%rax,8)
	vmovups	%ymm0, (%rdi,%rax,8)
	addq	$32, %rax
	addq	$8, %rdx
	jne	.LBB0_17
.LBB0_18:                               # 
                                        #   in Loop: Header=BB0_2 Depth=1
	testq	%rsi, %rsi
	je	.LBB0_21
# %bb.19:                               # 
                                        #   in Loop: Header=BB0_2 Depth=1
	leaq	(%rcx,%rax,8), %rax
	shlq	$5, %rsi
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB0_20:                               # 
                                        #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovups	%ymm0, (%rax,%rdx)
	vmovups	%ymm0, 32(%rax,%rdx)
	vmovups	%ymm0, 64(%rax,%rdx)
	addq	$32, %rdx
	cmpq	%rdx, %rsi
	jne	.LBB0_20
.LBB0_21:                               # 
                                        #   in Loop: Header=BB0_2 Depth=1
	cmpq	%rbx, %rbp
	je	.LBB0_22
	.p2align	4, 0x90
.LBB0_5:                                # 
                                        #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, (%rcx,%rbp,8)
	movq	$0, 32(%rcx,%rbp,8)
	movq	$0, 64(%rcx,%rbp,8)
	incq	%rbp
	cmpq	%rbx, %rbp
	jb	.LBB0_5
	jmp	.LBB0_22
.LBB0_6:                                # 
	vmovsd	%xmm1, (%rsp)           # 8-byte Spill
	xorl	%r13d, %r13d
	xorl	%eax, %eax
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 56(%rsp)         # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	movl	20(%r12), %eax
	movq	%rax, 104(%rsp)         # 8-byte Spill
	testl	%eax, %eax
	jle	.LBB0_24
# %bb.7:                                # 
	vmovsd	8(%rsp), %xmm0          # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm8
	movq	160(%r12), %rcx
	movq	176(%r12), %rdx
	movq	24(%rsp), %rax          # 8-byte Reload
	movq	16(%rax), %rsi
	movq	%rsi, 96(%rsp)          # 8-byte Spill
	movq	40(%rax), %rsi
	movq	%rsi, 88(%rsp)          # 8-byte Spill
	movslq	8(%rax), %rax
	movq	%rax, 80(%rsp)          # 8-byte Spill
	vmovsd	16(%rsp), %xmm0         # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	.LCPI0_0(%rip), %xmm0, %xmm12
	leaq	32(%r14), %r8
	leaq	24(%r14), %rsi
	leaq	40(%r14), %rax
	leaq	48(%r14), %rdi
	movq	%rdi, 16(%rsp)          # 8-byte Spill
	vmovupd	(%r14), %xmm0
	vmovapd	%xmm0, 32(%rsp)         # 16-byte Spill
	movq	%r14, 48(%rsp)          # 8-byte Spill
	movq	16(%r14), %rdi
	movq	%rdx, 128(%rsp)         # 8-byte Spill
	leaq	64(%rdx), %rdx
	movq	%rdx, 72(%rsp)          # 8-byte Spill
	movq	%rcx, 136(%rsp)         # 8-byte Spill
	leaq	64(%rcx), %rcx
	movq	%rcx, 64(%rsp)          # 8-byte Spill
	vmovsd	.LCPI0_1(%rip), %xmm9   # xmm9 = mem[0],zero
	vmovsd	.LCPI0_2(%rip), %xmm13  # xmm13 = mem[0],zero
	xorl	%r15d, %r15d
	vmovsd	%xmm8, 8(%rsp)          # 8-byte Spill
	jmp	.LBB0_8
	.p2align	4, 0x90
.LBB0_26:                               # 
                                        #   in Loop: Header=BB0_8 Depth=1
	movq	120(%rsp), %r13         # 8-byte Reload
	movq	112(%rsp), %rdi         # 8-byte Reload
.LBB0_27:                               # 
                                        #   in Loop: Header=BB0_8 Depth=1
	vmovdqa	.LCPI0_3(%rip), %xmm0   # xmm0 = <1,u>
	vpinsrq	$1, %rbp, %xmm0, %xmm0
	vmovdqa	32(%rsp), %xmm1         # 16-byte Reload
	vpaddq	%xmm0, %xmm1, %xmm1
	vmovdqa	%xmm1, 32(%rsp)         # 16-byte Spill
	addq	%rbp, %rdi
	incq	%r15
	addl	$3, %r13d
	cmpq	104(%rsp), %r15         # 8-byte Folded Reload
	jae	.LBB0_23
.LBB0_8:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_10 Depth 2
                                        #       Child Loop BB0_11 Depth 3
	movq	96(%rsp), %rcx          # 8-byte Reload
	movslq	(%rcx,%r15,4), %rbp
	testq	%rbp, %rbp
	jle	.LBB0_27
# %bb.9:                                # 
                                        #   in Loop: Header=BB0_8 Depth=1
	movq	%rdi, 112(%rsp)         # 8-byte Spill
	movq	%r13, 120(%rsp)         # 8-byte Spill
                                        # kill: def $r13d killed $r13d killed $r13 def $r13
	andl	$1073741823, %r13d      # imm = 0x3FFFFFFF
	shlq	$5, %r13
	movq	72(%rsp), %rcx          # 8-byte Reload
	leaq	(%rcx,%r13), %r9
	addq	64(%rsp), %r13          # 8-byte Folded Reload
	movq	%r15, %rcx
	imulq	80(%rsp), %rcx          # 8-byte Folded Reload
	movq	88(%rsp), %rdx          # 8-byte Reload
	leaq	(%rdx,%rcx,4), %rcx
	movq	%rcx, 144(%rsp)         # 8-byte Spill
	movq	24(%rsp), %rcx          # 8-byte Reload
	movl	32(%rcx), %r10d
	movl	%ebp, %ebp
	xorl	%edx, %edx
	movq	%rbp, 152(%rsp)         # 8-byte Spill
	jmp	.LBB0_10
	.p2align	4, 0x90
.LBB0_25:                               # 
                                        #   in Loop: Header=BB0_10 Depth=2
	movq	160(%rsp), %rdx         # 8-byte Reload
	incq	%rdx
	movq	152(%rsp), %rbp         # 8-byte Reload
	cmpq	%rbp, %rdx
	je	.LBB0_26
.LBB0_10:                               # 
                                        #   Parent Loop BB0_8 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_11 Depth 3
	movq	144(%rsp), %rcx         # 8-byte Reload
	movq	%rdx, 160(%rsp)         # 8-byte Spill
	movl	(%rcx,%rdx,4), %r12d
	movslq	%r12d, %rcx
	shlq	$5, %rcx
	leaq	(%rcx,%rcx,2), %rbp
	movq	136(%rsp), %rcx         # 8-byte Reload
	addq	%rbp, %rcx
	addq	128(%rsp), %rbp         # 8-byte Folded Reload
	xorl	%edx, %edx
	xorl	%r14d, %r14d
	jmp	.LBB0_11
	.p2align	4, 0x90
.LBB0_41:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	incq	(%r8)
.LBB0_42:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	testl	%r14d, %r14d
	movq	%rax, %rdi
	cmoveq	16(%rsp), %rdi          # 8-byte Folded Reload
.LBB0_44:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	incq	(%rdi)
	vaddsd	-64(%r9,%rdx,8), %xmm5, %xmm0
	vmovsd	%xmm0, -64(%r9,%rdx,8)
	vaddsd	-32(%r9,%rdx,8), %xmm11, %xmm0
	vmovsd	%xmm0, -32(%r9,%rdx,8)
	vaddsd	(%r9,%rdx,8), %xmm6, %xmm0
	vmovsd	%xmm0, (%r9,%rdx,8)
	incq	%rdx
	cmpq	$4, %rdx
	je	.LBB0_25
.LBB0_11:                               # 
                                        #   Parent Loop BB0_8 Depth=1
                                        #     Parent Loop BB0_10 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vmovsd	-64(%r13,%rdx,8), %xmm10 # xmm10 = mem[0],zero
	vmovsd	-32(%r13,%rdx,8), %xmm15 # xmm15 = mem[0],zero
	vmovsd	(%r13,%rdx,8), %xmm14   # xmm14 = mem[0],zero
	cmpq	%r12, %r15
	jne	.LBB0_35
# %bb.12:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vxorpd	%xmm6, %xmm6, %xmm6
	testl	%r10d, %r10d
	jne	.LBB0_13
# %bb.28:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	testq	%rdx, %rdx
	je	.LBB0_13
# %bb.29:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vsubsd	(%rcx), %xmm10, %xmm0
	vsubsd	32(%rcx), %xmm15, %xmm1
	vsubsd	64(%rcx), %xmm14, %xmm2
	vmulsd	%xmm0, %xmm0, %xmm3
	vfmadd231sd	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231sd	%xmm2, %xmm2, %xmm3 # xmm3 = (xmm2 * xmm2) + xmm3
	vxorpd	%xmm6, %xmm6, %xmm6
	vucomisd	%xmm8, %xmm3
	movq	%r8, %rdi
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorpd	%xmm5, %xmm5, %xmm5
	jae	.LBB0_31
# %bb.30:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vdivsd	%xmm3, %xmm9, %xmm3
	vmulsd	(%rsp), %xmm3, %xmm5    # 8-byte Folded Reload
	vmulsd	%xmm3, %xmm3, %xmm6
	vmulsd	%xmm5, %xmm6, %xmm5
	vaddsd	%xmm5, %xmm13, %xmm6
	vmulsd	%xmm3, %xmm12, %xmm3
	vmulsd	%xmm5, %xmm3, %xmm3
	vmulsd	%xmm6, %xmm3, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm5
	vmulsd	%xmm1, %xmm3, %xmm11
	vmulsd	%xmm2, %xmm3, %xmm6
	movl	$1, %r14d
	movq	%rsi, %rdi
.LBB0_31:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	incq	(%rdi)
	jmp	.LBB0_32
	.p2align	4, 0x90
.LBB0_35:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vsubsd	(%rcx), %xmm10, %xmm1
	vsubsd	32(%rcx), %xmm15, %xmm0
	vsubsd	64(%rcx), %xmm14, %xmm2
	vmulsd	%xmm1, %xmm1, %xmm3
	vfmadd231sd	%xmm0, %xmm0, %xmm3 # xmm3 = (xmm0 * xmm0) + xmm3
	vfmadd231sd	%xmm2, %xmm2, %xmm3 # xmm3 = (xmm2 * xmm2) + xmm3
	vxorpd	%xmm6, %xmm6, %xmm6
	vucomisd	%xmm8, %xmm3
	movq	%r8, %rdi
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorpd	%xmm5, %xmm5, %xmm5
	jae	.LBB0_39
# %bb.36:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vdivsd	%xmm3, %xmm9, %xmm3
	vmulsd	(%rsp), %xmm3, %xmm5    # 8-byte Folded Reload
	vmulsd	%xmm3, %xmm3, %xmm6
	vmulsd	%xmm5, %xmm6, %xmm5
	vaddsd	%xmm5, %xmm13, %xmm6
	vmulsd	%xmm3, %xmm12, %xmm3
	vmulsd	%xmm5, %xmm3, %xmm3
	vmulsd	%xmm6, %xmm3, %xmm3
	vmulsd	%xmm1, %xmm3, %xmm5
	vmulsd	%xmm0, %xmm3, %xmm11
	vmulsd	%xmm2, %xmm3, %xmm6
	movl	$1, %r14d
	testl	%r10d, %r10d
	je	.LBB0_38
# %bb.37:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vmovsd	(%rbp), %xmm0           # xmm0 = mem[0],zero
	vmovsd	32(%rbp), %xmm1         # xmm1 = mem[0],zero
	vsubsd	%xmm5, %xmm0, %xmm0
	vmovsd	%xmm0, (%rbp)
	vsubsd	%xmm11, %xmm1, %xmm0
	vmovsd	%xmm0, 32(%rbp)
	vmovsd	64(%rbp), %xmm0         # xmm0 = mem[0],zero
	vsubsd	%xmm6, %xmm0, %xmm0
	vmovsd	%xmm0, 64(%rbp)
.LBB0_38:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	movq	%rsi, %rdi
.LBB0_39:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	incq	(%rdi)
	vsubsd	8(%rcx), %xmm10, %xmm0
	vsubsd	40(%rcx), %xmm15, %xmm1
	vsubsd	72(%rcx), %xmm14, %xmm2
	vmulsd	%xmm0, %xmm0, %xmm3
	vfmadd231sd	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231sd	%xmm2, %xmm2, %xmm3 # xmm3 = (xmm2 * xmm2) + xmm3
	vucomisd	%xmm8, %xmm3
	jae	.LBB0_40
# %bb.61:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vdivsd	%xmm3, %xmm9, %xmm3
	vmulsd	(%rsp), %xmm3, %xmm4    # 8-byte Folded Reload
	vmulsd	%xmm3, %xmm3, %xmm7
	vmulsd	%xmm4, %xmm7, %xmm4
	vaddsd	%xmm4, %xmm13, %xmm7
	vmulsd	%xmm3, %xmm12, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vmulsd	%xmm1, %xmm3, %xmm1
	vmulsd	%xmm2, %xmm3, %xmm2
	testl	%r10d, %r10d
	je	.LBB0_63
# %bb.62:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vmovsd	8(%rbp), %xmm3          # xmm3 = mem[0],zero
	vmovsd	40(%rbp), %xmm4         # xmm4 = mem[0],zero
	vsubsd	%xmm0, %xmm3, %xmm3
	vmovsd	%xmm3, 8(%rbp)
	vsubsd	%xmm1, %xmm4, %xmm3
	vmovsd	%xmm3, 40(%rbp)
	vmovsd	72(%rbp), %xmm3         # xmm3 = mem[0],zero
	vsubsd	%xmm2, %xmm3, %xmm3
	vmovsd	%xmm3, 72(%rbp)
.LBB0_63:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vaddsd	%xmm5, %xmm0, %xmm5
	vaddsd	%xmm1, %xmm11, %xmm11
	vaddsd	%xmm6, %xmm2, %xmm6
	movl	$1, %r14d
	movq	%rsi, %rdi
	jmp	.LBB0_64
	.p2align	4, 0x90
.LBB0_13:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorpd	%xmm5, %xmm5, %xmm5
.LBB0_32:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	xorl	%edi, %edi
	cmpq	$1, %rdx
	setne	%dil
	xorl	%r11d, %r11d
	testq	%rdx, %rdx
	sete	%r11b
	testl	%r10d, %r10d
	cmovel	%edi, %r11d
	testb	%r11b, %r11b
	je	.LBB0_49
# %bb.33:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vsubsd	8(%rcx), %xmm10, %xmm0
	vsubsd	40(%rcx), %xmm15, %xmm1
	vsubsd	72(%rcx), %xmm14, %xmm2
	vmulsd	%xmm0, %xmm0, %xmm3
	vfmadd231sd	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231sd	%xmm2, %xmm2, %xmm3 # xmm3 = (xmm2 * xmm2) + xmm3
	vucomisd	%xmm8, %xmm3
	jae	.LBB0_34
# %bb.45:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vmovapd	%xmm13, %xmm7
	vdivsd	%xmm3, %xmm9, %xmm3
	vmulsd	(%rsp), %xmm3, %xmm8    # 8-byte Folded Reload
	vmulsd	%xmm3, %xmm3, %xmm9
	vmulsd	%xmm8, %xmm9, %xmm4
	vaddsd	%xmm4, %xmm13, %xmm7
	vmovapd	%xmm12, %xmm8
	vmulsd	%xmm3, %xmm12, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vmulsd	%xmm1, %xmm3, %xmm1
	vmulsd	%xmm2, %xmm3, %xmm2
	testl	%r10d, %r10d
	je	.LBB0_47
# %bb.46:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vmovsd	8(%rbp), %xmm3          # xmm3 = mem[0],zero
	vmovsd	40(%rbp), %xmm4         # xmm4 = mem[0],zero
	vsubsd	%xmm0, %xmm3, %xmm3
	vmovsd	%xmm3, 8(%rbp)
	vsubsd	%xmm1, %xmm4, %xmm3
	vmovsd	%xmm3, 40(%rbp)
	vmovsd	72(%rbp), %xmm3         # xmm3 = mem[0],zero
	vsubsd	%xmm2, %xmm3, %xmm3
	vmovsd	%xmm3, 72(%rbp)
.LBB0_47:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vaddsd	%xmm5, %xmm0, %xmm5
	vaddsd	%xmm1, %xmm11, %xmm11
	vaddsd	%xmm6, %xmm2, %xmm6
	movl	$1, %r14d
	movq	%rsi, %rdi
	vmovsd	.LCPI0_1(%rip), %xmm9   # xmm9 = mem[0],zero
	vmovapd	%xmm8, %xmm12
	vmovsd	8(%rsp), %xmm8          # 8-byte Reload
                                        # xmm8 = mem[0],zero
	jmp	.LBB0_48
	.p2align	4, 0x90
.LBB0_40:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	movq	%r8, %rdi
.LBB0_64:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	incq	(%rdi)
	vsubsd	16(%rcx), %xmm10, %xmm0
	vsubsd	48(%rcx), %xmm15, %xmm1
	vsubsd	80(%rcx), %xmm14, %xmm2
	vmulsd	%xmm0, %xmm0, %xmm3
	vfmadd231sd	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231sd	%xmm2, %xmm2, %xmm3 # xmm3 = (xmm2 * xmm2) + xmm3
	vucomisd	%xmm8, %xmm3
	jae	.LBB0_65
# %bb.66:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vdivsd	%xmm3, %xmm9, %xmm3
	vmulsd	(%rsp), %xmm3, %xmm4    # 8-byte Folded Reload
	vmulsd	%xmm3, %xmm3, %xmm7
	vmulsd	%xmm4, %xmm7, %xmm4
	vaddsd	%xmm4, %xmm13, %xmm7
	vmulsd	%xmm3, %xmm12, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vmulsd	%xmm1, %xmm3, %xmm1
	vmulsd	%xmm2, %xmm3, %xmm2
	testl	%r10d, %r10d
	je	.LBB0_68
# %bb.67:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vmovsd	16(%rbp), %xmm3         # xmm3 = mem[0],zero
	vmovsd	48(%rbp), %xmm4         # xmm4 = mem[0],zero
	vsubsd	%xmm0, %xmm3, %xmm3
	vmovsd	%xmm3, 16(%rbp)
	vsubsd	%xmm1, %xmm4, %xmm3
	vmovsd	%xmm3, 48(%rbp)
	vmovsd	80(%rbp), %xmm3         # xmm3 = mem[0],zero
	vsubsd	%xmm2, %xmm3, %xmm3
	vmovsd	%xmm3, 80(%rbp)
.LBB0_68:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vaddsd	%xmm5, %xmm0, %xmm5
	vaddsd	%xmm1, %xmm11, %xmm11
	vaddsd	%xmm6, %xmm2, %xmm6
	movl	$1, %r14d
	movq	%rsi, %rdi
	incq	(%rsi)
	jmp	.LBB0_57
	.p2align	4, 0x90
.LBB0_65:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	movq	%r8, %rdi
	incq	(%r8)
	jmp	.LBB0_57
.LBB0_34:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	movq	%r8, %rdi
.LBB0_48:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	incq	(%rdi)
.LBB0_49:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	xorl	%edi, %edi
	xorl	%ebx, %ebx
	cmpq	$2, %rdx
	setne	%dil
	setb	%bl
	testl	%r10d, %r10d
	cmovel	%edi, %ebx
	cmpb	$1, %bl
	jne	.LBB0_56
# %bb.50:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vsubsd	16(%rcx), %xmm10, %xmm0
	vsubsd	48(%rcx), %xmm15, %xmm1
	vsubsd	80(%rcx), %xmm14, %xmm2
	vmulsd	%xmm0, %xmm0, %xmm3
	vfmadd231sd	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231sd	%xmm2, %xmm2, %xmm3 # xmm3 = (xmm2 * xmm2) + xmm3
	vucomisd	%xmm8, %xmm3
	jae	.LBB0_51
# %bb.52:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vdivsd	%xmm3, %xmm9, %xmm3
	vmulsd	(%rsp), %xmm3, %xmm4    # 8-byte Folded Reload
	vmulsd	%xmm3, %xmm3, %xmm7
	vmulsd	%xmm4, %xmm7, %xmm4
	vaddsd	%xmm4, %xmm13, %xmm7
	vmulsd	%xmm3, %xmm12, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vmulsd	%xmm1, %xmm3, %xmm1
	vmulsd	%xmm2, %xmm3, %xmm2
	testl	%r10d, %r10d
	je	.LBB0_54
# %bb.53:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vmovsd	16(%rbp), %xmm3         # xmm3 = mem[0],zero
	vmovsd	48(%rbp), %xmm4         # xmm4 = mem[0],zero
	vsubsd	%xmm0, %xmm3, %xmm3
	vmovsd	%xmm3, 16(%rbp)
	vsubsd	%xmm1, %xmm4, %xmm3
	vmovsd	%xmm3, 48(%rbp)
	vmovsd	80(%rbp), %xmm3         # xmm3 = mem[0],zero
	vsubsd	%xmm2, %xmm3, %xmm3
	vmovsd	%xmm3, 80(%rbp)
.LBB0_54:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vaddsd	%xmm5, %xmm0, %xmm5
	vaddsd	%xmm1, %xmm11, %xmm11
	vaddsd	%xmm6, %xmm2, %xmm6
	movl	$1, %r14d
	movq	%rsi, %rdi
	jmp	.LBB0_55
.LBB0_51:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	movq	%r8, %rdi
.LBB0_55:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	incq	(%rdi)
.LBB0_56:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	xorl	%edi, %edi
	xorl	%ebx, %ebx
	cmpq	$3, %rdx
	setne	%dil
	setb	%bl
	testl	%r10d, %r10d
	cmovel	%edi, %ebx
	cmpb	$1, %bl
	jne	.LBB0_42
.LBB0_57:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vsubsd	24(%rcx), %xmm10, %xmm0
	vsubsd	56(%rcx), %xmm15, %xmm1
	vsubsd	88(%rcx), %xmm14, %xmm2
	vmulsd	%xmm0, %xmm0, %xmm3
	vfmadd231sd	%xmm1, %xmm1, %xmm3 # xmm3 = (xmm1 * xmm1) + xmm3
	vfmadd231sd	%xmm2, %xmm2, %xmm3 # xmm3 = (xmm2 * xmm2) + xmm3
	vucomisd	%xmm8, %xmm3
	jae	.LBB0_41
# %bb.58:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vdivsd	%xmm3, %xmm9, %xmm3
	vmulsd	(%rsp), %xmm3, %xmm4    # 8-byte Folded Reload
	vmulsd	%xmm3, %xmm3, %xmm7
	vmulsd	%xmm4, %xmm7, %xmm4
	vaddsd	%xmm4, %xmm13, %xmm7
	vmulsd	%xmm3, %xmm12, %xmm3
	vmulsd	%xmm4, %xmm3, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vmulsd	%xmm0, %xmm3, %xmm0
	vmulsd	%xmm1, %xmm3, %xmm1
	vmulsd	%xmm2, %xmm3, %xmm2
	testl	%r10d, %r10d
	je	.LBB0_60
# %bb.59:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vmovsd	24(%rbp), %xmm3         # xmm3 = mem[0],zero
	vmovsd	56(%rbp), %xmm4         # xmm4 = mem[0],zero
	vsubsd	%xmm0, %xmm3, %xmm3
	vmovsd	%xmm3, 24(%rbp)
	vsubsd	%xmm1, %xmm4, %xmm3
	vmovsd	%xmm3, 56(%rbp)
	vmovsd	88(%rbp), %xmm3         # xmm3 = mem[0],zero
	vsubsd	%xmm2, %xmm3, %xmm3
	vmovsd	%xmm3, 88(%rbp)
.LBB0_60:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	vaddsd	%xmm5, %xmm0, %xmm5
	vaddsd	%xmm1, %xmm11, %xmm11
	vaddsd	%xmm6, %xmm2, %xmm6
# %bb.43:                               # 
                                        #   in Loop: Header=BB0_11 Depth=3
	incq	(%rsi)
	movl	$1, %r14d
	movq	%rax, %rdi
	jmp	.LBB0_44
.LBB0_23:                               # 
	movq	48(%rsp), %rax          # 8-byte Reload
	vmovaps	32(%rsp), %xmm0         # 16-byte Reload
	vmovups	%xmm0, (%rax)
	movq	%rdi, 16(%rax)
.LBB0_24:                               # 
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
	vsubsd	56(%rsp), %xmm0, %xmm0  # 8-byte Folded Reload
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
	.globl	computeForceLJ_2xnn_half # -- Begin function computeForceLJ_2xnn_half
	.p2align	4, 0x90
	.type	computeForceLJ_2xnn_half,@function
computeForceLJ_2xnn_half:               # 
.LcomputeForceLJ_2xnn_half$local:
	.cfi_startproc
# %bb.0:                                # 
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	%rsi, %r14
	movl	$.L.str.3, %edi
	xorl	%eax, %eax
	callq	debug_printf
	movl	20(%r14), %r9d
	testl	%r9d, %r9d
	jle	.LBB1_15
# %bb.1:                                # 
	movq	176(%r14), %rcx
	movq	192(%r14), %r8
	xorl	%r10d, %r10d
	vxorps	%xmm0, %xmm0, %xmm0
	leaq	288(%rcx), %rdi
	jmp	.LBB1_2
	.p2align	4, 0x90
.LBB1_14:                               # 
                                        #   in Loop: Header=BB1_2 Depth=1
	incq	%r10
	addq	$96, %rdi
	addq	$96, %rcx
	cmpq	%r9, %r10
	jae	.LBB1_15
.LBB1_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_9 Depth 2
                                        #     Child Loop BB1_12 Depth 2
                                        #     Child Loop BB1_5 Depth 2
	imulq	$56, %r10, %rax
	movl	(%r8,%rax), %edx
	testl	%edx, %edx
	jle	.LBB1_14
# %bb.3:                                # 
                                        #   in Loop: Header=BB1_2 Depth=1
	cmpl	$3, %edx
	ja	.LBB1_6
# %bb.4:                                # 
                                        #   in Loop: Header=BB1_2 Depth=1
	xorl	%ebx, %ebx
	jmp	.LBB1_5
	.p2align	4, 0x90
.LBB1_6:                                # 
                                        #   in Loop: Header=BB1_2 Depth=1
	movl	%edx, %ebx
	andl	$-4, %ebx
	leaq	-4(%rbx), %rax
	movq	%rax, %rsi
	shrq	$2, %rsi
	incq	%rsi
	movl	%esi, %r11d
	andl	$7, %r11d
	cmpq	$28, %rax
	jae	.LBB1_8
# %bb.7:                                # 
                                        #   in Loop: Header=BB1_2 Depth=1
	xorl	%esi, %esi
	jmp	.LBB1_10
.LBB1_8:                                # 
                                        #   in Loop: Header=BB1_2 Depth=1
	movq	%r11, %rax
	subq	%rsi, %rax
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB1_9:                                # 
                                        #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovups	%ymm0, -288(%rdi,%rsi,8)
	vmovups	%ymm0, -256(%rdi,%rsi,8)
	vmovups	%ymm0, -224(%rdi,%rsi,8)
	vmovups	%ymm0, -192(%rdi,%rsi,8)
	vmovups	%ymm0, -160(%rdi,%rsi,8)
	vmovups	%ymm0, -128(%rdi,%rsi,8)
	vmovups	%ymm0, -96(%rdi,%rsi,8)
	vmovups	%ymm0, -64(%rdi,%rsi,8)
	vmovups	%ymm0, -32(%rdi,%rsi,8)
	vmovups	%ymm0, (%rdi,%rsi,8)
	addq	$32, %rsi
	addq	$8, %rax
	jne	.LBB1_9
.LBB1_10:                               # 
                                        #   in Loop: Header=BB1_2 Depth=1
	testq	%r11, %r11
	je	.LBB1_13
# %bb.11:                               # 
                                        #   in Loop: Header=BB1_2 Depth=1
	leaq	(%rcx,%rsi,8), %rax
	shlq	$5, %r11
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB1_12:                               # 
                                        #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovups	%ymm0, (%rax,%rsi)
	vmovups	%ymm0, 32(%rax,%rsi)
	vmovups	%ymm0, 64(%rax,%rsi)
	addq	$32, %rsi
	cmpq	%rsi, %r11
	jne	.LBB1_12
.LBB1_13:                               # 
                                        #   in Loop: Header=BB1_2 Depth=1
	cmpq	%rdx, %rbx
	je	.LBB1_14
	.p2align	4, 0x90
.LBB1_5:                                # 
                                        #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, (%rcx,%rbx,8)
	movq	$0, 32(%rcx,%rbx,8)
	movq	$0, 64(%rcx,%rbx,8)
	incq	%rbx
	cmpq	%rdx, %rbx
	jb	.LBB1_5
	jmp	.LBB1_14
.LBB1_15:                               # 
	xorl	%eax, %eax
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 16(%rsp)         # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	cmpl	$0, 20(%r14)
	jg	.LBB1_17
# %bb.16:                               # 
	movl	$.L.str.1, %edi
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, 8(%rsp)          # 8-byte Spill
	movl	$.L.str.4, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	8(%rsp), %xmm0          # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vsubsd	16(%rsp), %xmm0, %xmm0  # 8-byte Folded Reload
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.LBB1_17:                               # 
	.cfi_def_cfa_offset 48
	callq	simd_load_h_dual
.Lfunc_end1:
	.size	computeForceLJ_2xnn_half, .Lfunc_end1-computeForceLJ_2xnn_half
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90         # -- Begin function simd_load_h_dual
	.type	simd_load_h_dual,@function
simd_load_h_dual:                       # 
	.cfi_startproc
# %bb.0:                                # 
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	stderr(%rip), %rcx
	movl	$.L.str.7, %edi
	movl	$67, %esi
	movl	$1, %edx
	callq	fwrite
	movl	$-1, %edi
	callq	exit
.Lfunc_end2:
	.size	simd_load_h_dual, .Lfunc_end2-simd_load_h_dual
	.cfi_endproc
                                        # -- End function
	.globl	computeForceLJ_2xnn_full # -- Begin function computeForceLJ_2xnn_full
	.p2align	4, 0x90
	.type	computeForceLJ_2xnn_full,@function
computeForceLJ_2xnn_full:               # 
.LcomputeForceLJ_2xnn_full$local:
	.cfi_startproc
# %bb.0:                                # 
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	%rsi, %r14
	movl	$.L.str.3, %edi
	xorl	%eax, %eax
	callq	debug_printf
	movl	20(%r14), %r9d
	testl	%r9d, %r9d
	jle	.LBB3_15
# %bb.1:                                # 
	movq	176(%r14), %rcx
	movq	192(%r14), %r8
	xorl	%r10d, %r10d
	vxorps	%xmm0, %xmm0, %xmm0
	leaq	288(%rcx), %rdi
	jmp	.LBB3_2
	.p2align	4, 0x90
.LBB3_14:                               # 
                                        #   in Loop: Header=BB3_2 Depth=1
	incq	%r10
	addq	$96, %rdi
	addq	$96, %rcx
	cmpq	%r9, %r10
	jae	.LBB3_15
.LBB3_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_9 Depth 2
                                        #     Child Loop BB3_12 Depth 2
                                        #     Child Loop BB3_5 Depth 2
	imulq	$56, %r10, %rax
	movl	(%r8,%rax), %edx
	testl	%edx, %edx
	jle	.LBB3_14
# %bb.3:                                # 
                                        #   in Loop: Header=BB3_2 Depth=1
	cmpl	$3, %edx
	ja	.LBB3_6
# %bb.4:                                # 
                                        #   in Loop: Header=BB3_2 Depth=1
	xorl	%ebx, %ebx
	jmp	.LBB3_5
	.p2align	4, 0x90
.LBB3_6:                                # 
                                        #   in Loop: Header=BB3_2 Depth=1
	movl	%edx, %ebx
	andl	$-4, %ebx
	leaq	-4(%rbx), %rax
	movq	%rax, %rsi
	shrq	$2, %rsi
	incq	%rsi
	movl	%esi, %r11d
	andl	$7, %r11d
	cmpq	$28, %rax
	jae	.LBB3_8
# %bb.7:                                # 
                                        #   in Loop: Header=BB3_2 Depth=1
	xorl	%esi, %esi
	jmp	.LBB3_10
.LBB3_8:                                # 
                                        #   in Loop: Header=BB3_2 Depth=1
	movq	%r11, %rax
	subq	%rsi, %rax
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB3_9:                                # 
                                        #   Parent Loop BB3_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovups	%ymm0, -288(%rdi,%rsi,8)
	vmovups	%ymm0, -256(%rdi,%rsi,8)
	vmovups	%ymm0, -224(%rdi,%rsi,8)
	vmovups	%ymm0, -192(%rdi,%rsi,8)
	vmovups	%ymm0, -160(%rdi,%rsi,8)
	vmovups	%ymm0, -128(%rdi,%rsi,8)
	vmovups	%ymm0, -96(%rdi,%rsi,8)
	vmovups	%ymm0, -64(%rdi,%rsi,8)
	vmovups	%ymm0, -32(%rdi,%rsi,8)
	vmovups	%ymm0, (%rdi,%rsi,8)
	addq	$32, %rsi
	addq	$8, %rax
	jne	.LBB3_9
.LBB3_10:                               # 
                                        #   in Loop: Header=BB3_2 Depth=1
	testq	%r11, %r11
	je	.LBB3_13
# %bb.11:                               # 
                                        #   in Loop: Header=BB3_2 Depth=1
	leaq	(%rcx,%rsi,8), %rax
	shlq	$5, %r11
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB3_12:                               # 
                                        #   Parent Loop BB3_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovups	%ymm0, (%rax,%rsi)
	vmovups	%ymm0, 32(%rax,%rsi)
	vmovups	%ymm0, 64(%rax,%rsi)
	addq	$32, %rsi
	cmpq	%rsi, %r11
	jne	.LBB3_12
.LBB3_13:                               # 
                                        #   in Loop: Header=BB3_2 Depth=1
	cmpq	%rdx, %rbx
	je	.LBB3_14
	.p2align	4, 0x90
.LBB3_5:                                # 
                                        #   Parent Loop BB3_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, (%rcx,%rbx,8)
	movq	$0, 32(%rcx,%rbx,8)
	movq	$0, 64(%rcx,%rbx,8)
	incq	%rbx
	cmpq	%rdx, %rbx
	jb	.LBB3_5
	jmp	.LBB3_14
.LBB3_15:                               # 
	xorl	%eax, %eax
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 16(%rsp)         # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	cmpl	$0, 20(%r14)
	jg	.LBB3_17
# %bb.16:                               # 
	movl	$.L.str.1, %edi
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, 8(%rsp)          # 8-byte Spill
	movl	$.L.str.4, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	8(%rsp), %xmm0          # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vsubsd	16(%rsp), %xmm0, %xmm0  # 8-byte Folded Reload
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.LBB3_17:                               # 
	.cfi_def_cfa_offset 48
	callq	simd_load_h_dual
.Lfunc_end3:
	.size	computeForceLJ_2xnn_full, .Lfunc_end3-computeForceLJ_2xnn_full
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
	je	.LBB4_2
# %bb.1:                                # 
	jmp	.LcomputeForceLJ_2xnn_half$local # TAILCALL
.LBB4_2:                                # 
	jmp	.LcomputeForceLJ_2xnn_full$local # TAILCALL
.Lfunc_end4:
	.size	computeForceLJ_2xnn, .Lfunc_end4-computeForceLJ_2xnn
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3               # -- Begin function computeForceLJ_4xn_half
.LCPI5_0:
	.quad	4631952216750555136     #  48
.LCPI5_2:
	.quad	-4620693217682128896    #  -0.5
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI5_1:
	.long	31                      # 0x1f
	.long	30                      # 0x1e
	.long	29                      # 0x1d
	.long	28                      # 0x1c
.LCPI5_3:
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
	subq	$1256, %rsp             # imm = 0x4E8
	.cfi_def_cfa_offset 1312
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rcx, 80(%rsp)          # 8-byte Spill
	movq	%rdx, 72(%rsp)          # 8-byte Spill
	movq	%rsi, %rbx
	movq	%rdi, %r12
	movl	$.L.str.5, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	144(%r12), %xmm0        # xmm0 = mem[0],zero
	vmovsd	%xmm0, 96(%rsp)         # 8-byte Spill
	vbroadcastsd	56(%r12), %ymm0
	vmovups	%ymm0, 832(%rsp)        # 32-byte Spill
	vmovsd	40(%r12), %xmm0         # xmm0 = mem[0],zero
	vmovupd	%ymm0, 32(%rsp)         # 32-byte Spill
	movl	20(%rbx), %r9d
	testl	%r9d, %r9d
	jle	.LBB5_6
# %bb.1:                                # 
	movq	176(%rbx), %rcx
	movq	192(%rbx), %r8
	xorl	%r10d, %r10d
	vxorpd	%xmm0, %xmm0, %xmm0
	leaq	288(%rcx), %rdi
	jmp	.LBB5_2
	.p2align	4, 0x90
.LBB5_25:                               # 
                                        #   in Loop: Header=BB5_2 Depth=1
	incq	%r10
	addq	$96, %rdi
	addq	$96, %rcx
	cmpq	%r9, %r10
	jae	.LBB5_6
.LBB5_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_20 Depth 2
                                        #     Child Loop BB5_23 Depth 2
                                        #     Child Loop BB5_5 Depth 2
	imulq	$56, %r10, %rax
	movl	(%r8,%rax), %edx
	testl	%edx, %edx
	jle	.LBB5_25
# %bb.3:                                # 
                                        #   in Loop: Header=BB5_2 Depth=1
	cmpl	$3, %edx
	ja	.LBB5_17
# %bb.4:                                # 
                                        #   in Loop: Header=BB5_2 Depth=1
	xorl	%ebp, %ebp
	jmp	.LBB5_5
	.p2align	4, 0x90
.LBB5_17:                               # 
                                        #   in Loop: Header=BB5_2 Depth=1
	movl	%edx, %ebp
	andl	$-4, %ebp
	leaq	-4(%rbp), %rax
	movq	%rax, %rsi
	shrq	$2, %rsi
	incq	%rsi
	movl	%esi, %r11d
	andl	$7, %r11d
	cmpq	$28, %rax
	jae	.LBB5_19
# %bb.18:                               # 
                                        #   in Loop: Header=BB5_2 Depth=1
	xorl	%esi, %esi
	jmp	.LBB5_21
.LBB5_19:                               # 
                                        #   in Loop: Header=BB5_2 Depth=1
	movq	%r11, %rax
	subq	%rsi, %rax
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB5_20:                               # 
                                        #   Parent Loop BB5_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%ymm0, -288(%rdi,%rsi,8)
	vmovupd	%ymm0, -256(%rdi,%rsi,8)
	vmovupd	%ymm0, -224(%rdi,%rsi,8)
	vmovupd	%ymm0, -192(%rdi,%rsi,8)
	vmovupd	%ymm0, -160(%rdi,%rsi,8)
	vmovupd	%ymm0, -128(%rdi,%rsi,8)
	vmovupd	%ymm0, -96(%rdi,%rsi,8)
	vmovupd	%ymm0, -64(%rdi,%rsi,8)
	vmovupd	%ymm0, -32(%rdi,%rsi,8)
	vmovupd	%ymm0, (%rdi,%rsi,8)
	addq	$32, %rsi
	addq	$8, %rax
	jne	.LBB5_20
.LBB5_21:                               # 
                                        #   in Loop: Header=BB5_2 Depth=1
	testq	%r11, %r11
	je	.LBB5_24
# %bb.22:                               # 
                                        #   in Loop: Header=BB5_2 Depth=1
	leaq	(%rcx,%rsi,8), %rax
	shlq	$5, %r11
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB5_23:                               # 
                                        #   Parent Loop BB5_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%ymm0, (%rax,%rsi)
	vmovupd	%ymm0, 32(%rax,%rsi)
	vmovupd	%ymm0, 64(%rax,%rsi)
	addq	$32, %rsi
	cmpq	%rsi, %r11
	jne	.LBB5_23
.LBB5_24:                               # 
                                        #   in Loop: Header=BB5_2 Depth=1
	cmpq	%rdx, %rbp
	je	.LBB5_25
	.p2align	4, 0x90
.LBB5_5:                                # 
                                        #   Parent Loop BB5_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, (%rcx,%rbp,8)
	movq	$0, 32(%rcx,%rbp,8)
	movq	$0, 64(%rcx,%rbp,8)
	incq	%rbp
	cmpq	%rdx, %rbp
	jb	.LBB5_5
	jmp	.LBB5_25
.LBB5_6:                                # 
	xorl	%eax, %eax
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 64(%rsp)         # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	cmpl	$0, 20(%rbx)
	jle	.LBB5_16
# %bb.7:                                # 
	vmovsd	96(%rsp), %xmm0         # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm0
	vbroadcastsd	%xmm0, %ymm0
	vmovupd	%ymm0, 800(%rsp)        # 32-byte Spill
	vmovupd	32(%rsp), %ymm0         # 32-byte Reload
	vmulsd	.LCPI5_0(%rip), %xmm0, %xmm0
	vbroadcastsd	%xmm0, %ymm0
	vmovupd	%ymm0, 768(%rsp)        # 32-byte Spill
	xorl	%r8d, %r8d
	jmp	.LBB5_8
	.p2align	4, 0x90
.LBB5_15:                               # 
                                        #   in Loop: Header=BB5_8 Depth=1
	vhaddpd	%ymm0, %ymm1, %ymm0
	vhaddpd	%ymm15, %ymm14, %ymm1
	vhaddpd	%ymm4, %ymm11, %ymm2
	vhaddpd	%ymm3, %ymm13, %ymm3
	vhaddpd	%ymm7, %ymm5, %ymm4
	vhaddpd	%ymm6, %ymm12, %ymm5
	vperm2f128	$33, %ymm4, %ymm5, %ymm6 # ymm6 = ymm5[2,3],ymm4[0,1]
	vaddpd	%ymm5, %ymm6, %ymm5
	vaddpd	%ymm4, %ymm6, %ymm4
	vblendpd	$12, %ymm4, %ymm5, %ymm4 # ymm4 = ymm5[0,1],ymm4[2,3]
	vaddpd	(%r11,%r12,8), %ymm4, %ymm4
	vmovapd	%ymm4, (%r11,%r12,8)
	vperm2f128	$33, %ymm2, %ymm3, %ymm4 # ymm4 = ymm3[2,3],ymm2[0,1]
	vaddpd	%ymm3, %ymm4, %ymm3
	vaddpd	%ymm2, %ymm4, %ymm2
	vblendpd	$12, %ymm2, %ymm3, %ymm2 # ymm2 = ymm3[0,1],ymm2[2,3]
	vaddpd	32(%r11,%r12,8), %ymm2, %ymm2
	vmovapd	%ymm2, 32(%r11,%r12,8)
	vperm2f128	$33, %ymm0, %ymm1, %ymm2 # ymm2 = ymm1[2,3],ymm0[0,1]
	vaddpd	%ymm1, %ymm2, %ymm1
	vaddpd	%ymm0, %ymm2, %ymm0
	vblendpd	$12, %ymm0, %ymm1, %ymm0 # ymm0 = ymm1[0,1],ymm0[2,3]
	vaddpd	64(%r11,%r12,8), %ymm0, %ymm0
	vmovapd	%ymm0, 64(%r11,%r12,8)
	vmovdqa	.LCPI5_3(%rip), %xmm0   # xmm0 = <1,u>
	vpinsrq	$1, %r13, %xmm0, %xmm0
	movq	80(%rsp), %rax          # 8-byte Reload
	vpaddq	(%rax), %xmm0, %xmm0
	vmovdqu	%xmm0, (%rax)
	addq	%r13, 16(%rax)
	incq	%r8
	movslq	20(%rbx), %rax
	cmpq	%rax, %r8
	jge	.LBB5_16
.LBB5_8:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_27 Depth 2
                                        #     Child Loop BB5_12 Depth 2
	leaq	(,%r8,4), %rax
	leaq	(%rax,%rax,2), %r12
	movq	160(%rbx), %r15
	movq	176(%rbx), %r11
	movq	72(%rsp), %rcx          # 8-byte Reload
	movq	40(%rcx), %rdx
	movl	8(%rcx), %esi
	movq	16(%rcx), %rax
	movslq	(%rax,%r8,4), %r13
	movq	24(%rcx), %rax
	movl	(%rax,%r8,4), %r10d
	vbroadcastsd	(%r15,%r12,8), %ymm0
	vmovups	%ymm0, 1216(%rsp)       # 32-byte Spill
	vbroadcastsd	8(%r15,%r12,8), %ymm0
	vmovups	%ymm0, 1184(%rsp)       # 32-byte Spill
	vbroadcastsd	16(%r15,%r12,8), %ymm0
	vmovups	%ymm0, 1152(%rsp)       # 32-byte Spill
	vbroadcastsd	24(%r15,%r12,8), %ymm0
	vmovups	%ymm0, 1120(%rsp)       # 32-byte Spill
	vbroadcastsd	32(%r15,%r12,8), %ymm0
	vmovups	%ymm0, 1088(%rsp)       # 32-byte Spill
	vbroadcastsd	40(%r15,%r12,8), %ymm0
	vmovups	%ymm0, 1056(%rsp)       # 32-byte Spill
	vbroadcastsd	48(%r15,%r12,8), %ymm0
	vmovups	%ymm0, 1024(%rsp)       # 32-byte Spill
	vbroadcastsd	56(%r15,%r12,8), %ymm0
	vmovups	%ymm0, 992(%rsp)        # 32-byte Spill
	vbroadcastsd	64(%r15,%r12,8), %ymm0
	vmovups	%ymm0, 960(%rsp)        # 32-byte Spill
	vbroadcastsd	72(%r15,%r12,8), %ymm0
	vmovups	%ymm0, 928(%rsp)        # 32-byte Spill
	vbroadcastsd	80(%r15,%r12,8), %ymm0
	vmovups	%ymm0, 896(%rsp)        # 32-byte Spill
	vbroadcastsd	88(%r15,%r12,8), %ymm0
	vmovupd	%ymm0, 864(%rsp)        # 32-byte Spill
	testl	%r10d, %r10d
	jle	.LBB5_9
# %bb.26:                               # 
                                        #   in Loop: Header=BB5_8 Depth=1
	movl	%esi, 28(%rsp)          # 4-byte Spill
	movl	%esi, %eax
	imull	%r8d, %eax
	cltq
	movq	%rdx, 88(%rsp)          # 8-byte Spill
	leaq	(%rdx,%rax,4), %r9
	leaq	-1(%r10), %rdx
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%ymm0, 32(%rsp)         # 32-byte Spill
	movq	%r11, %rsi
	movl	$0, %ecx
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%ymm0, 384(%rsp)        # 32-byte Spill
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%ymm0, 256(%rsp)        # 32-byte Spill
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%ymm0, 96(%rsp)         # 32-byte Spill
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%ymm0, 352(%rsp)        # 32-byte Spill
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%ymm0, 224(%rsp)        # 32-byte Spill
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%ymm0, 448(%rsp)        # 32-byte Spill
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%ymm0, 320(%rsp)        # 32-byte Spill
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%ymm0, 160(%rsp)        # 32-byte Spill
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%ymm0, 416(%rsp)        # 32-byte Spill
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%ymm0, 288(%rsp)        # 32-byte Spill
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovupd	%ymm0, 192(%rsp)        # 32-byte Spill
	.p2align	4, 0x90
.LBB5_27:                               # 
                                        #   Parent Loop BB5_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%r9,%rcx,4), %r14
	movq	%r14, %rax
	shlq	$2, %rax
	leaq	(%rax,%rax,2), %rbp
	vmovapd	(%r15,%rbp,8), %ymm4
	vmovapd	32(%r15,%rbp,8), %ymm15
	vmovapd	64(%r15,%rbp,8), %ymm2
	vmovupd	1216(%rsp), %ymm0       # 32-byte Reload
	vsubpd	%ymm4, %ymm0, %ymm13
	vmovupd	%ymm13, 608(%rsp)       # 32-byte Spill
	vmovupd	1088(%rsp), %ymm0       # 32-byte Reload
	vsubpd	%ymm15, %ymm0, %ymm12
	vmovupd	%ymm12, 672(%rsp)       # 32-byte Spill
	vmovupd	960(%rsp), %ymm0        # 32-byte Reload
	vsubpd	%ymm2, %ymm0, %ymm11
	vmovupd	%ymm11, 128(%rsp)       # 32-byte Spill
	vmovupd	1184(%rsp), %ymm0       # 32-byte Reload
	vsubpd	%ymm4, %ymm0, %ymm10
	vmovupd	%ymm10, 640(%rsp)       # 32-byte Spill
	vmovupd	1056(%rsp), %ymm0       # 32-byte Reload
	vsubpd	%ymm15, %ymm0, %ymm9
	vmovupd	%ymm9, 704(%rsp)        # 32-byte Spill
	vmovupd	928(%rsp), %ymm0        # 32-byte Reload
	vsubpd	%ymm2, %ymm0, %ymm6
	vmovupd	%ymm6, 736(%rsp)        # 32-byte Spill
	movl	%r14d, %edi
	xorl	%eax, %eax
	cmpq	%rdi, %r8
	sete	%al
	leal	(,%rax,4), %edi
	vpbroadcastd	312(%rbx,%rdi,4), %xmm0
	vmovdqa	.LCPI5_1(%rip), %xmm7   # xmm7 = [31,30,29,28]
	vpsllvd	%xmm7, %xmm0, %xmm0
	vmovupd	1024(%rsp), %ymm1       # 32-byte Reload
	vsubpd	%ymm15, %ymm1, %ymm14
	vmovupd	%ymm14, 544(%rsp)       # 32-byte Spill
	vpsrad	$31, %xmm0, %xmm0
	vpmovsxdq	%xmm0, %ymm5
	leal	1(,%rax,4), %edi
	vpbroadcastd	312(%rbx,%rdi,4), %xmm0
	vpsllvd	%xmm7, %xmm0, %xmm0
	vpsrad	$31, %xmm0, %xmm0
	vpmovsxdq	%xmm0, %ymm3
	leal	2(,%rax,4), %edi
	vpbroadcastd	312(%rbx,%rdi,4), %xmm0
	vpsllvd	%xmm7, %xmm0, %xmm8
	vmulpd	%ymm11, %ymm11, %ymm0
	vfmadd231pd	%ymm12, %ymm12, %ymm0 # ymm0 = (ymm12 * ymm12) + ymm0
	vfmadd231pd	%ymm13, %ymm13, %ymm0 # ymm0 = (ymm13 * ymm13) + ymm0
	vmulpd	%ymm6, %ymm6, %ymm1
	vfmadd231pd	%ymm9, %ymm9, %ymm1 # ymm1 = (ymm9 * ymm9) + ymm1
	vfmadd231pd	%ymm10, %ymm10, %ymm1 # ymm1 = (ymm10 * ymm10) + ymm1
	vmovupd	800(%rsp), %ymm9        # 32-byte Reload
	vcmpltpd	%ymm9, %ymm0, %ymm10
	vandpd	%ymm5, %ymm10, %ymm5
	vcmpltpd	%ymm9, %ymm1, %ymm10
	vandpd	%ymm3, %ymm10, %ymm11
	vmovupd	896(%rsp), %ymm3        # 32-byte Reload
	vsubpd	%ymm2, %ymm3, %ymm6
	vmovupd	%ymm6, 576(%rsp)        # 32-byte Spill
	vpsrad	$31, %xmm8, %xmm3
	vpmovsxdq	%xmm3, %ymm8
	vmulpd	%ymm6, %ymm6, %ymm3
	vfmadd231pd	%ymm14, %ymm14, %ymm3 # ymm3 = (ymm14 * ymm14) + ymm3
	vmovupd	1152(%rsp), %ymm6       # 32-byte Reload
	vsubpd	%ymm4, %ymm6, %ymm13
	vfmadd231pd	%ymm13, %ymm13, %ymm3 # ymm3 = (ymm13 * ymm13) + ymm3
	vcmpltpd	%ymm9, %ymm3, %ymm10
	vandpd	%ymm8, %ymm10, %ymm10
	vmovupd	1120(%rsp), %ymm6       # 32-byte Reload
	vsubpd	%ymm4, %ymm6, %ymm12
	vmovupd	%ymm12, 480(%rsp)       # 32-byte Spill
	leal	3(,%rax,4), %eax
	vpbroadcastd	312(%rbx,%rax,4), %xmm6
	vpsllvd	%xmm7, %xmm6, %xmm6
	vmovupd	992(%rsp), %ymm4        # 32-byte Reload
	vsubpd	%ymm15, %ymm4, %ymm8
	vmovupd	864(%rsp), %ymm4        # 32-byte Reload
	vsubpd	%ymm2, %ymm4, %ymm2
	vmovupd	%ymm2, 512(%rsp)        # 32-byte Spill
	vpsrad	$31, %xmm6, %xmm6
	vpmovsxdq	%xmm6, %ymm15
	vmulpd	%ymm2, %ymm2, %ymm6
	vfmadd231pd	%ymm8, %ymm8, %ymm6 # ymm6 = (ymm8 * ymm8) + ymm6
	vfmadd231pd	%ymm12, %ymm12, %ymm6 # ymm6 = (ymm12 * ymm12) + ymm6
	vcmpltpd	%ymm9, %ymm6, %ymm9
	vandpd	%ymm15, %ymm9, %ymm15
	vcvtpd2ps	%ymm0, %xmm0
	vrcpps	%xmm0, %xmm0
	vcvtps2pd	%xmm0, %ymm0
	vmovupd	832(%rsp), %ymm2        # 32-byte Reload
	vmulpd	%ymm2, %ymm0, %ymm9
	vmulpd	%ymm0, %ymm0, %ymm12
	vmulpd	%ymm9, %ymm12, %ymm9
	vcvtpd2ps	%ymm1, %xmm1
	vrcpps	%xmm1, %xmm1
	vcvtps2pd	%xmm1, %ymm1
	vmulpd	%ymm2, %ymm1, %ymm12
	vmulpd	%ymm1, %ymm1, %ymm14
	vmulpd	%ymm12, %ymm14, %ymm12
	vcvtpd2ps	%ymm3, %xmm3
	vrcpps	%xmm3, %xmm3
	vcvtps2pd	%xmm3, %ymm3
	vmulpd	%ymm2, %ymm3, %ymm14
	vmulpd	%ymm3, %ymm3, %ymm7
	vmulpd	%ymm7, %ymm14, %ymm7
	vcvtpd2ps	%ymm6, %xmm6
	vrcpps	%xmm6, %xmm6
	vcvtps2pd	%xmm6, %ymm6
	vmulpd	%ymm2, %ymm6, %ymm14
	vmulpd	%ymm6, %ymm6, %ymm2
	vmulpd	%ymm2, %ymm14, %ymm4
	vmovupd	768(%rsp), %ymm2        # 32-byte Reload
	vmulpd	%ymm0, %ymm2, %ymm0
	vmulpd	%ymm0, %ymm9, %ymm0
	vbroadcastsd	.LCPI5_2(%rip), %ymm14 # ymm14 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vaddpd	%ymm14, %ymm9, %ymm9
	vmulpd	%ymm0, %ymm9, %ymm0
	vmulpd	%ymm1, %ymm2, %ymm1
	vmulpd	%ymm1, %ymm12, %ymm1
	vaddpd	%ymm14, %ymm12, %ymm9
	vmulpd	%ymm1, %ymm9, %ymm9
	vmulpd	%ymm3, %ymm2, %ymm1
	vmulpd	%ymm7, %ymm1, %ymm1
	vaddpd	%ymm7, %ymm14, %ymm3
	vmulpd	%ymm3, %ymm1, %ymm7
	vaddpd	%ymm4, %ymm14, %ymm1
	vmulpd	%ymm6, %ymm2, %ymm3
	vmulpd	%ymm4, %ymm3, %ymm2
	vmulpd	%ymm1, %ymm2, %ymm2
	vmulpd	608(%rsp), %ymm0, %ymm1 # 32-byte Folded Reload
	vmulpd	672(%rsp), %ymm0, %ymm3 # 32-byte Folded Reload
	vmulpd	128(%rsp), %ymm0, %ymm0 # 32-byte Folded Reload
	vandpd	%ymm1, %ymm5, %ymm12
	vandpd	%ymm3, %ymm5, %ymm6
	vandpd	%ymm0, %ymm5, %ymm1
	vmulpd	640(%rsp), %ymm9, %ymm0 # 32-byte Folded Reload
	vmulpd	704(%rsp), %ymm9, %ymm3 # 32-byte Folded Reload
	vmulpd	736(%rsp), %ymm9, %ymm9 # 32-byte Folded Reload
	vandpd	%ymm0, %ymm11, %ymm5
	vandpd	%ymm3, %ymm11, %ymm3
	vandpd	%ymm9, %ymm11, %ymm0
	vmulpd	%ymm7, %ymm13, %ymm9
	vmulpd	544(%rsp), %ymm7, %ymm13 # 32-byte Folded Reload
	vmulpd	576(%rsp), %ymm7, %ymm7 # 32-byte Folded Reload
	vandpd	%ymm9, %ymm10, %ymm11
	vandpd	%ymm13, %ymm10, %ymm9
	vandpd	%ymm7, %ymm10, %ymm7
	vmulpd	480(%rsp), %ymm2, %ymm4 # 32-byte Folded Reload
	vmulpd	%ymm2, %ymm8, %ymm10
	vmulpd	512(%rsp), %ymm2, %ymm2 # 32-byte Folded Reload
	vandpd	%ymm4, %ymm15, %ymm8
	vandpd	%ymm10, %ymm15, %ymm4
	vandpd	%ymm2, %ymm15, %ymm2
	cmpl	4(%rbx), %r14d
	jge	.LBB5_29
# %bb.28:                               # 
                                        #   in Loop: Header=BB5_27 Depth=2
	vmovapd	32(%rsi,%rbp,8), %ymm10
	vmovapd	64(%rsi,%rbp,8), %ymm13
	vaddpd	%ymm5, %ymm12, %ymm14
	vaddpd	%ymm11, %ymm8, %ymm15
	vsubpd	(%rsi,%rbp,8), %ymm14, %ymm14
	vaddpd	%ymm15, %ymm14, %ymm14
	vxorpd	%xmm15, %xmm15, %xmm15
	vsubpd	%ymm14, %ymm15, %ymm14
	vmovapd	%ymm14, (%rsi,%rbp,8)
	vaddpd	%ymm3, %ymm6, %ymm14
	vsubpd	%ymm10, %ymm14, %ymm10
	vaddpd	%ymm4, %ymm9, %ymm14
	vaddpd	%ymm14, %ymm10, %ymm10
	vsubpd	%ymm10, %ymm15, %ymm10
	vmovapd	%ymm10, 32(%rsi,%rbp,8)
	vaddpd	%ymm0, %ymm1, %ymm10
	vsubpd	%ymm13, %ymm10, %ymm10
	vaddpd	%ymm7, %ymm2, %ymm13
	vaddpd	%ymm13, %ymm10, %ymm10
	vsubpd	%ymm10, %ymm15, %ymm10
	vmovapd	%ymm10, 64(%rsi,%rbp,8)
.LBB5_29:                               # 
                                        #   in Loop: Header=BB5_27 Depth=2
	vmovupd	32(%rsp), %ymm10        # 32-byte Reload
	vaddpd	%ymm12, %ymm10, %ymm12
	vmovupd	384(%rsp), %ymm13       # 32-byte Reload
	vaddpd	%ymm6, %ymm13, %ymm13
	vmovupd	256(%rsp), %ymm14       # 32-byte Reload
	vaddpd	%ymm1, %ymm14, %ymm14
	vmovupd	96(%rsp), %ymm6         # 32-byte Reload
	vaddpd	%ymm5, %ymm6, %ymm6
	vmovupd	352(%rsp), %ymm1        # 32-byte Reload
	vaddpd	%ymm3, %ymm1, %ymm3
	vmovupd	224(%rsp), %ymm15       # 32-byte Reload
	vaddpd	%ymm0, %ymm15, %ymm15
	vmovupd	448(%rsp), %ymm5        # 32-byte Reload
	vaddpd	%ymm5, %ymm11, %ymm5
	vmovupd	320(%rsp), %ymm11       # 32-byte Reload
	vaddpd	%ymm9, %ymm11, %ymm11
	vmovupd	160(%rsp), %ymm1        # 32-byte Reload
	vaddpd	%ymm7, %ymm1, %ymm1
	vmovupd	416(%rsp), %ymm7        # 32-byte Reload
	vaddpd	%ymm7, %ymm8, %ymm7
	vmovupd	288(%rsp), %ymm0        # 32-byte Reload
	vaddpd	%ymm4, %ymm0, %ymm4
	vmovupd	192(%rsp), %ymm0        # 32-byte Reload
	vaddpd	%ymm2, %ymm0, %ymm0
	cmpq	%rcx, %rdx
	je	.LBB5_30
# %bb.31:                               # 
                                        #   in Loop: Header=BB5_27 Depth=2
	vmovupd	%ymm1, 160(%rsp)        # 32-byte Spill
	vmovupd	%ymm0, 192(%rsp)        # 32-byte Spill
	vmovupd	%ymm15, 224(%rsp)       # 32-byte Spill
	vmovupd	%ymm14, 256(%rsp)       # 32-byte Spill
	vmovupd	%ymm4, 288(%rsp)        # 32-byte Spill
	vmovupd	%ymm11, 320(%rsp)       # 32-byte Spill
	vmovupd	%ymm3, 352(%rsp)        # 32-byte Spill
	vmovupd	%ymm13, 384(%rsp)       # 32-byte Spill
	vmovupd	%ymm7, 416(%rsp)        # 32-byte Spill
	vmovupd	%ymm5, 448(%rsp)        # 32-byte Spill
	vmovupd	%ymm6, 96(%rsp)         # 32-byte Spill
	vmovupd	%ymm12, 32(%rsp)        # 32-byte Spill
	incq	%rcx
	movq	160(%rbx), %r15
	movq	176(%rbx), %rsi
	jmp	.LBB5_27
	.p2align	4, 0x90
.LBB5_30:                               # 
                                        #   in Loop: Header=BB5_8 Depth=1
	movq	88(%rsp), %rdx          # 8-byte Reload
	movl	28(%rsp), %esi          # 4-byte Reload
	cmpl	%r13d, %r10d
	jge	.LBB5_15
	jmp	.LBB5_11
	.p2align	4, 0x90
.LBB5_9:                                # 
                                        #   in Loop: Header=BB5_8 Depth=1
	vxorpd	%xmm0, %xmm0, %xmm0
	vxorpd	%xmm4, %xmm4, %xmm4
	vxorpd	%xmm7, %xmm7, %xmm7
	vxorpd	%xmm1, %xmm1, %xmm1
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorpd	%xmm5, %xmm5, %xmm5
	vxorpd	%xmm15, %xmm15, %xmm15
	vxorpd	%xmm3, %xmm3, %xmm3
	vxorpd	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm14, %xmm14, %xmm14
	vxorpd	%xmm13, %xmm13, %xmm13
	vxorpd	%xmm12, %xmm12, %xmm12
	cmpl	%r13d, %r10d
	jge	.LBB5_15
.LBB5_11:                               # 
                                        #   in Loop: Header=BB5_8 Depth=1
	movslq	%r10d, %rcx
	imull	%r8d, %esi
	movslq	%esi, %rax
	leaq	(%rdx,%rax,4), %rdx
	jmp	.LBB5_12
	.p2align	4, 0x90
.LBB5_14:                               # 
                                        #   in Loop: Header=BB5_12 Depth=2
	vmovupd	32(%rsp), %ymm12        # 32-byte Reload
	vaddpd	%ymm3, %ymm12, %ymm12
	vmovupd	384(%rsp), %ymm13       # 32-byte Reload
	vaddpd	%ymm14, %ymm13, %ymm13
	vmovupd	256(%rsp), %ymm14       # 32-byte Reload
	vaddpd	%ymm6, %ymm14, %ymm14
	vmovupd	96(%rsp), %ymm3         # 32-byte Reload
	vaddpd	%ymm4, %ymm3, %ymm6
	vmovupd	352(%rsp), %ymm3        # 32-byte Reload
	vaddpd	%ymm5, %ymm3, %ymm3
	vmovupd	224(%rsp), %ymm15       # 32-byte Reload
	vaddpd	%ymm2, %ymm15, %ymm15
	vmovupd	448(%rsp), %ymm5        # 32-byte Reload
	vaddpd	%ymm5, %ymm8, %ymm5
	vmovupd	320(%rsp), %ymm11       # 32-byte Reload
	vaddpd	%ymm1, %ymm11, %ymm11
	vmovupd	160(%rsp), %ymm1        # 32-byte Reload
	vaddpd	%ymm0, %ymm1, %ymm1
	vmovupd	416(%rsp), %ymm0        # 32-byte Reload
	vaddpd	%ymm7, %ymm0, %ymm7
	vmovupd	288(%rsp), %ymm4        # 32-byte Reload
	vaddpd	%ymm4, %ymm10, %ymm4
	vmovupd	192(%rsp), %ymm0        # 32-byte Reload
	vaddpd	%ymm0, %ymm9, %ymm0
	incq	%rcx
	cmpq	%rcx, %r13
	je	.LBB5_15
.LBB5_12:                               # 
                                        #   Parent Loop BB5_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%ymm1, 160(%rsp)        # 32-byte Spill
	vmovupd	%ymm0, 192(%rsp)        # 32-byte Spill
	vmovupd	%ymm15, 224(%rsp)       # 32-byte Spill
	vmovupd	%ymm14, 256(%rsp)       # 32-byte Spill
	vmovupd	%ymm4, 288(%rsp)        # 32-byte Spill
	vmovupd	%ymm11, 320(%rsp)       # 32-byte Spill
	vmovupd	%ymm3, 352(%rsp)        # 32-byte Spill
	vmovupd	%ymm13, 384(%rsp)       # 32-byte Spill
	vmovupd	%ymm7, 416(%rsp)        # 32-byte Spill
	vmovupd	%ymm5, 448(%rsp)        # 32-byte Spill
	vmovupd	%ymm6, 96(%rsp)         # 32-byte Spill
	vmovupd	%ymm12, 32(%rsp)        # 32-byte Spill
	movslq	(%rdx,%rcx,4), %rdi
	movq	%rdi, %rax
	shlq	$2, %rax
	leaq	(%rax,%rax,2), %rsi
	movq	160(%rbx), %rax
	vmovapd	(%rax,%rsi,8), %ymm2
	vmovapd	32(%rax,%rsi,8), %ymm13
	vmovapd	64(%rax,%rsi,8), %ymm5
	vmovupd	1216(%rsp), %ymm0       # 32-byte Reload
	vsubpd	%ymm2, %ymm0, %ymm10
	vmovupd	%ymm10, 640(%rsp)       # 32-byte Spill
	vmovupd	1088(%rsp), %ymm0       # 32-byte Reload
	vsubpd	%ymm13, %ymm0, %ymm9
	vmovupd	%ymm9, 672(%rsp)        # 32-byte Spill
	vmovupd	960(%rsp), %ymm0        # 32-byte Reload
	vsubpd	%ymm5, %ymm0, %ymm4
	vmovupd	%ymm4, 128(%rsp)        # 32-byte Spill
	vmovupd	1184(%rsp), %ymm0       # 32-byte Reload
	vsubpd	%ymm2, %ymm0, %ymm8
	vmovupd	%ymm8, 608(%rsp)        # 32-byte Spill
	vmovupd	1056(%rsp), %ymm0       # 32-byte Reload
	vsubpd	%ymm13, %ymm0, %ymm3
	vmovupd	%ymm3, 704(%rsp)        # 32-byte Spill
	vmovupd	928(%rsp), %ymm0        # 32-byte Reload
	vsubpd	%ymm5, %ymm0, %ymm1
	vmovupd	%ymm1, 736(%rsp)        # 32-byte Spill
	vmovupd	1024(%rsp), %ymm0       # 32-byte Reload
	vsubpd	%ymm13, %ymm0, %ymm7
	vmovupd	%ymm7, 544(%rsp)        # 32-byte Spill
	vmovupd	896(%rsp), %ymm0        # 32-byte Reload
	vsubpd	%ymm5, %ymm0, %ymm6
	vmovupd	%ymm6, 576(%rsp)        # 32-byte Spill
	vmulpd	%ymm4, %ymm4, %ymm4
	vfmadd231pd	%ymm9, %ymm9, %ymm4 # ymm4 = (ymm9 * ymm9) + ymm4
	vfmadd231pd	%ymm10, %ymm10, %ymm4 # ymm4 = (ymm10 * ymm10) + ymm4
	vmulpd	%ymm1, %ymm1, %ymm12
	vfmadd231pd	%ymm3, %ymm3, %ymm12 # ymm12 = (ymm3 * ymm3) + ymm12
	vcvtpd2ps	%ymm4, %xmm0
	vfmadd231pd	%ymm8, %ymm8, %ymm12 # ymm12 = (ymm8 * ymm8) + ymm12
	vrcpps	%xmm0, %xmm0
	vcvtps2pd	%xmm0, %ymm0
	vmovupd	832(%rsp), %ymm10       # 32-byte Reload
	vmulpd	%ymm0, %ymm10, %ymm1
	vmulpd	%ymm0, %ymm0, %ymm11
	vmulpd	%ymm1, %ymm11, %ymm3
	vmulpd	%ymm6, %ymm6, %ymm11
	vfmadd231pd	%ymm7, %ymm7, %ymm11 # ymm11 = (ymm7 * ymm7) + ymm11
	vmovupd	1152(%rsp), %ymm1       # 32-byte Reload
	vsubpd	%ymm2, %ymm1, %ymm15
	vcvtpd2ps	%ymm12, %xmm7
	vfmadd231pd	%ymm15, %ymm15, %ymm11 # ymm11 = (ymm15 * ymm15) + ymm11
	vrcpps	%xmm7, %xmm7
	vcvtps2pd	%xmm7, %ymm8
	vcvtpd2ps	%ymm11, %xmm7
	vmulpd	%ymm10, %ymm8, %ymm1
	vmulpd	%ymm8, %ymm8, %ymm9
	vmulpd	%ymm1, %ymm9, %ymm1
	vrcpps	%xmm7, %xmm7
	vcvtps2pd	%xmm7, %ymm9
	vmulpd	%ymm10, %ymm9, %ymm7
	vmulpd	%ymm9, %ymm9, %ymm6
	vmulpd	%ymm7, %ymm6, %ymm6
	vmovupd	1120(%rsp), %ymm7       # 32-byte Reload
	vsubpd	%ymm2, %ymm7, %ymm7
	vmovupd	992(%rsp), %ymm2        # 32-byte Reload
	vsubpd	%ymm13, %ymm2, %ymm14
	vmovupd	%ymm14, 480(%rsp)       # 32-byte Spill
	vmovupd	864(%rsp), %ymm2        # 32-byte Reload
	vsubpd	%ymm5, %ymm2, %ymm2
	vmovupd	%ymm2, 512(%rsp)        # 32-byte Spill
	vmulpd	%ymm2, %ymm2, %ymm13
	vfmadd231pd	%ymm14, %ymm14, %ymm13 # ymm13 = (ymm14 * ymm14) + ymm13
	vfmadd231pd	%ymm7, %ymm7, %ymm13 # ymm13 = (ymm7 * ymm7) + ymm13
	vcvtpd2ps	%ymm13, %xmm14
	vrcpps	%xmm14, %xmm5
	vcvtps2pd	%xmm5, %ymm5
	vmulpd	%ymm5, %ymm10, %ymm14
	vmulpd	%ymm5, %ymm5, %ymm10
	vmulpd	%ymm14, %ymm10, %ymm10
	vmovupd	768(%rsp), %ymm2        # 32-byte Reload
	vmulpd	%ymm0, %ymm2, %ymm0
	vmulpd	%ymm3, %ymm0, %ymm0
	vbroadcastsd	.LCPI5_2(%rip), %ymm14 # ymm14 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vaddpd	%ymm3, %ymm14, %ymm3
	vmulpd	%ymm3, %ymm0, %ymm0
	vmulpd	%ymm2, %ymm8, %ymm3
	vmulpd	%ymm1, %ymm3, %ymm3
	vaddpd	%ymm1, %ymm14, %ymm1
	vmulpd	%ymm1, %ymm3, %ymm1
	vmulpd	%ymm2, %ymm9, %ymm3
	vmulpd	%ymm6, %ymm3, %ymm3
	vaddpd	%ymm6, %ymm14, %ymm6
	vmulpd	%ymm6, %ymm3, %ymm8
	vaddpd	%ymm14, %ymm10, %ymm3
	vmulpd	%ymm5, %ymm2, %ymm5
	vmulpd	%ymm5, %ymm10, %ymm5
	vmulpd	%ymm3, %ymm5, %ymm9
	vmulpd	640(%rsp), %ymm0, %ymm3 # 32-byte Folded Reload
	vmulpd	672(%rsp), %ymm0, %ymm5 # 32-byte Folded Reload
	vmulpd	128(%rsp), %ymm0, %ymm0 # 32-byte Folded Reload
	vmovupd	800(%rsp), %ymm14       # 32-byte Reload
	vcmpltpd	%ymm14, %ymm4, %ymm4
	vandpd	%ymm4, %ymm3, %ymm2
	vmovupd	%ymm2, 128(%rsp)        # 32-byte Spill
	vandpd	%ymm4, %ymm5, %ymm3
	vandpd	%ymm4, %ymm0, %ymm6
	vmulpd	608(%rsp), %ymm1, %ymm0 # 32-byte Folded Reload
	vmulpd	704(%rsp), %ymm1, %ymm5 # 32-byte Folded Reload
	vmulpd	736(%rsp), %ymm1, %ymm1 # 32-byte Folded Reload
	vcmpltpd	%ymm14, %ymm12, %ymm2
	vandpd	%ymm2, %ymm0, %ymm4
	vandpd	%ymm2, %ymm5, %ymm5
	vandpd	%ymm2, %ymm1, %ymm2
	vmulpd	%ymm15, %ymm8, %ymm0
	vmulpd	544(%rsp), %ymm8, %ymm1 # 32-byte Folded Reload
	vmulpd	576(%rsp), %ymm8, %ymm10 # 32-byte Folded Reload
	vcmpltpd	%ymm14, %ymm11, %ymm11
	vandpd	%ymm0, %ymm11, %ymm8
	vandpd	%ymm1, %ymm11, %ymm1
	vandpd	%ymm11, %ymm10, %ymm0
	vmulpd	%ymm7, %ymm9, %ymm7
	vmulpd	480(%rsp), %ymm9, %ymm10 # 32-byte Folded Reload
	vmulpd	512(%rsp), %ymm9, %ymm9 # 32-byte Folded Reload
	vcmpltpd	%ymm14, %ymm13, %ymm11
	vmovapd	%ymm3, %ymm14
	vmovupd	128(%rsp), %ymm3        # 32-byte Reload
	vandpd	%ymm7, %ymm11, %ymm7
	vandpd	%ymm11, %ymm10, %ymm10
	vandpd	%ymm11, %ymm9, %ymm9
	cmpl	4(%rbx), %edi
	jge	.LBB5_14
# %bb.13:                               # 
                                        #   in Loop: Header=BB5_12 Depth=2
	movq	176(%rbx), %rax
	vmovapd	32(%rax,%rsi,8), %ymm11
	vmovapd	64(%rax,%rsi,8), %ymm12
	vaddpd	%ymm4, %ymm3, %ymm13
	vaddpd	%ymm7, %ymm8, %ymm15
	vsubpd	(%rax,%rsi,8), %ymm13, %ymm13
	vaddpd	%ymm15, %ymm13, %ymm13
	vxorpd	%xmm15, %xmm15, %xmm15
	vsubpd	%ymm13, %ymm15, %ymm13
	vmovapd	%ymm13, (%rax,%rsi,8)
	vaddpd	%ymm5, %ymm14, %ymm13
	vsubpd	%ymm11, %ymm13, %ymm11
	vaddpd	%ymm1, %ymm10, %ymm13
	vaddpd	%ymm13, %ymm11, %ymm11
	vsubpd	%ymm11, %ymm15, %ymm11
	vmovapd	%ymm11, 32(%rax,%rsi,8)
	vaddpd	%ymm2, %ymm6, %ymm11
	vsubpd	%ymm12, %ymm11, %ymm11
	vaddpd	%ymm0, %ymm9, %ymm12
	vaddpd	%ymm12, %ymm11, %ymm11
	vsubpd	%ymm11, %ymm15, %ymm11
	vmovapd	%ymm11, 64(%rax,%rsi,8)
	jmp	.LBB5_14
.LBB5_16:                               # 
	movl	$.L.str.1, %edi
	vzeroupper
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, 32(%rsp)         # 8-byte Spill
	movl	$.L.str.6, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	32(%rsp), %xmm0         # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vsubsd	64(%rsp), %xmm0, %xmm0  # 8-byte Folded Reload
	addq	$1256, %rsp             # imm = 0x4E8
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
	.size	computeForceLJ_4xn_half, .Lfunc_end5-computeForceLJ_4xn_half
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3               # -- Begin function computeForceLJ_4xn_full
.LCPI6_0:
	.quad	4631952216750555136     #  48
.LCPI6_2:
	.quad	-4620693217682128896    #  -0.5
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI6_1:
	.long	31                      # 0x1f
	.long	30                      # 0x1e
	.long	29                      # 0x1d
	.long	28                      # 0x1c
.LCPI6_3:
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
	subq	$1256, %rsp             # imm = 0x4E8
	.cfi_def_cfa_offset 1312
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rcx, %r14
	movq	%rdx, %r15
	movq	%rsi, %rbp
	movq	%rdi, %r12
	movl	$.L.str.5, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	144(%r12), %xmm0        # xmm0 = mem[0],zero
	vmovsd	%xmm0, 32(%rsp)         # 8-byte Spill
	vbroadcastsd	56(%r12), %ymm1
	vmovsd	40(%r12), %xmm0         # xmm0 = mem[0],zero
	vmovupd	%ymm0, (%rsp)           # 32-byte Spill
	movl	20(%rbp), %r9d
	testl	%r9d, %r9d
	jle	.LBB6_6
# %bb.1:                                # 
	movq	176(%rbp), %rcx
	movq	192(%rbp), %r8
	xorl	%r10d, %r10d
	vxorpd	%xmm0, %xmm0, %xmm0
	leaq	288(%rcx), %rdi
	jmp	.LBB6_2
	.p2align	4, 0x90
.LBB6_22:                               # 
                                        #   in Loop: Header=BB6_2 Depth=1
	incq	%r10
	addq	$96, %rdi
	addq	$96, %rcx
	cmpq	%r9, %r10
	jae	.LBB6_6
.LBB6_2:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB6_17 Depth 2
                                        #     Child Loop BB6_20 Depth 2
                                        #     Child Loop BB6_5 Depth 2
	imulq	$56, %r10, %rax
	movl	(%r8,%rax), %eax
	testl	%eax, %eax
	jle	.LBB6_22
# %bb.3:                                # 
                                        #   in Loop: Header=BB6_2 Depth=1
	cmpl	$3, %eax
	ja	.LBB6_14
# %bb.4:                                # 
                                        #   in Loop: Header=BB6_2 Depth=1
	xorl	%edx, %edx
	jmp	.LBB6_5
	.p2align	4, 0x90
.LBB6_14:                               # 
                                        #   in Loop: Header=BB6_2 Depth=1
	movl	%eax, %edx
	andl	$-4, %edx
	leaq	-4(%rdx), %rbx
	movq	%rbx, %rsi
	shrq	$2, %rsi
	incq	%rsi
	movl	%esi, %r11d
	andl	$7, %r11d
	cmpq	$28, %rbx
	jae	.LBB6_16
# %bb.15:                               # 
                                        #   in Loop: Header=BB6_2 Depth=1
	xorl	%esi, %esi
	jmp	.LBB6_18
.LBB6_16:                               # 
                                        #   in Loop: Header=BB6_2 Depth=1
	movq	%r11, %rbx
	subq	%rsi, %rbx
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB6_17:                               # 
                                        #   Parent Loop BB6_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%ymm0, -288(%rdi,%rsi,8)
	vmovupd	%ymm0, -256(%rdi,%rsi,8)
	vmovupd	%ymm0, -224(%rdi,%rsi,8)
	vmovupd	%ymm0, -192(%rdi,%rsi,8)
	vmovupd	%ymm0, -160(%rdi,%rsi,8)
	vmovupd	%ymm0, -128(%rdi,%rsi,8)
	vmovupd	%ymm0, -96(%rdi,%rsi,8)
	vmovupd	%ymm0, -64(%rdi,%rsi,8)
	vmovupd	%ymm0, -32(%rdi,%rsi,8)
	vmovupd	%ymm0, (%rdi,%rsi,8)
	addq	$32, %rsi
	addq	$8, %rbx
	jne	.LBB6_17
.LBB6_18:                               # 
                                        #   in Loop: Header=BB6_2 Depth=1
	testq	%r11, %r11
	je	.LBB6_21
# %bb.19:                               # 
                                        #   in Loop: Header=BB6_2 Depth=1
	leaq	(%rcx,%rsi,8), %rsi
	shlq	$5, %r11
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB6_20:                               # 
                                        #   Parent Loop BB6_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovupd	%ymm0, (%rsi,%rbx)
	vmovupd	%ymm0, 32(%rsi,%rbx)
	vmovupd	%ymm0, 64(%rsi,%rbx)
	addq	$32, %rbx
	cmpq	%rbx, %r11
	jne	.LBB6_20
.LBB6_21:                               # 
                                        #   in Loop: Header=BB6_2 Depth=1
	cmpq	%rax, %rdx
	je	.LBB6_22
	.p2align	4, 0x90
.LBB6_5:                                # 
                                        #   Parent Loop BB6_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	$0, (%rcx,%rdx,8)
	movq	$0, 32(%rcx,%rdx,8)
	movq	$0, 64(%rcx,%rdx,8)
	incq	%rdx
	cmpq	%rax, %rdx
	jb	.LBB6_5
	jmp	.LBB6_22
.LBB6_6:                                # 
	vmovupd	%ymm1, 800(%rsp)        # 32-byte Spill
	xorl	%eax, %eax
	vzeroupper
	callq	getTimeStamp
	vmovsd	%xmm0, 152(%rsp)        # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	cmpl	$0, 20(%rbp)
	jle	.LBB6_13
# %bb.7:                                # 
	vmovsd	32(%rsp), %xmm0         # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm0
	vbroadcastsd	%xmm0, %ymm1
	vmovupd	(%rsp), %ymm0           # 32-byte Reload
	vmulsd	.LCPI6_0(%rip), %xmm0, %xmm0
	vbroadcastsd	%xmm0, %ymm0
	xorl	%r13d, %r13d
	vmovupd	%ymm1, 768(%rsp)        # 32-byte Spill
	vmovupd	%ymm0, 736(%rsp)        # 32-byte Spill
	jmp	.LBB6_8
	.p2align	4, 0x90
.LBB6_11:                               # 
                                        #   in Loop: Header=BB6_8 Depth=1
	vmovapd	%ymm13, %ymm3
	vmovapd	%ymm15, %ymm4
	vmovapd	%ymm11, %ymm15
	vmovupd	96(%rsp), %ymm6         # 32-byte Reload
.LBB6_12:                               # 
                                        #   in Loop: Header=BB6_8 Depth=1
	vhaddpd	%ymm14, %ymm6, %ymm0
	vhaddpd	64(%rsp), %ymm15, %ymm1 # 32-byte Folded Reload
	vhaddpd	%ymm2, %ymm4, %ymm2
	vhaddpd	%ymm3, %ymm12, %ymm3
	vhaddpd	%ymm8, %ymm7, %ymm4
	vhaddpd	%ymm10, %ymm9, %ymm5
	vperm2f128	$33, %ymm4, %ymm5, %ymm6 # ymm6 = ymm5[2,3],ymm4[0,1]
	vaddpd	%ymm5, %ymm6, %ymm5
	vaddpd	%ymm4, %ymm6, %ymm4
	vblendpd	$12, %ymm4, %ymm5, %ymm4 # ymm4 = ymm5[0,1],ymm4[2,3]
	vaddpd	(%r10,%r11,8), %ymm4, %ymm4
	vmovapd	%ymm4, (%r10,%r11,8)
	vperm2f128	$33, %ymm2, %ymm3, %ymm4 # ymm4 = ymm3[2,3],ymm2[0,1]
	vaddpd	%ymm3, %ymm4, %ymm3
	vaddpd	%ymm2, %ymm4, %ymm2
	vblendpd	$12, %ymm2, %ymm3, %ymm2 # ymm2 = ymm3[0,1],ymm2[2,3]
	vaddpd	32(%r10,%r11,8), %ymm2, %ymm2
	vmovapd	%ymm2, 32(%r10,%r11,8)
	vperm2f128	$33, %ymm0, %ymm1, %ymm2 # ymm2 = ymm1[2,3],ymm0[0,1]
	vaddpd	%ymm1, %ymm2, %ymm1
	vaddpd	%ymm0, %ymm2, %ymm0
	vblendpd	$12, %ymm0, %ymm1, %ymm0 # ymm0 = ymm1[0,1],ymm0[2,3]
	vaddpd	64(%r10,%r11,8), %ymm0, %ymm0
	vmovapd	%ymm0, 64(%r10,%r11,8)
	vmovdqa	.LCPI6_3(%rip), %xmm0   # xmm0 = <1,u>
	vpinsrq	$1, %r12, %xmm0, %xmm0
	vpaddq	(%r14), %xmm0, %xmm0
	vmovdqu	%xmm0, (%r14)
	addq	%r12, 16(%r14)
	incq	%r13
	movslq	20(%rbp), %rax
	cmpq	%rax, %r13
	jge	.LBB6_13
.LBB6_8:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB6_24 Depth 2
                                        #     Child Loop BB6_26 Depth 2
	leaq	(,%r13,4), %rax
	leaq	(%rax,%rax,2), %r11
	movq	160(%rbp), %rdi
	movq	176(%rbp), %r10
	movq	40(%r15), %r8
	movl	8(%r15), %r9d
	movq	16(%r15), %rax
	movslq	(%rax,%r13,4), %r12
	movq	24(%r15), %rax
	movl	(%rax,%r13,4), %edx
	vbroadcastsd	(%rdi,%r11,8), %ymm3
	vbroadcastsd	8(%rdi,%r11,8), %ymm4
	vbroadcastsd	16(%rdi,%r11,8), %ymm5
	vbroadcastsd	24(%rdi,%r11,8), %ymm6
	vbroadcastsd	32(%rdi,%r11,8), %ymm7
	vbroadcastsd	40(%rdi,%r11,8), %ymm8
	vbroadcastsd	48(%rdi,%r11,8), %ymm9
	vbroadcastsd	56(%rdi,%r11,8), %ymm10
	vbroadcastsd	64(%rdi,%r11,8), %ymm11
	vbroadcastsd	72(%rdi,%r11,8), %ymm12
	vbroadcastsd	80(%rdi,%r11,8), %ymm13
	vbroadcastsd	88(%rdi,%r11,8), %ymm14
	testl	%edx, %edx
	vmovupd	%ymm9, 1184(%rsp)       # 32-byte Spill
	vmovupd	%ymm10, 1152(%rsp)      # 32-byte Spill
	vmovupd	%ymm8, 1120(%rsp)       # 32-byte Spill
	vmovupd	%ymm4, 1088(%rsp)       # 32-byte Spill
	vmovupd	%ymm6, 1056(%rsp)       # 32-byte Spill
	vmovupd	%ymm11, 1024(%rsp)      # 32-byte Spill
	vmovupd	%ymm12, 992(%rsp)       # 32-byte Spill
	vmovupd	%ymm13, 960(%rsp)       # 32-byte Spill
	vmovupd	%ymm14, 928(%rsp)       # 32-byte Spill
	vmovupd	%ymm3, 896(%rsp)        # 32-byte Spill
	vmovupd	%ymm5, 864(%rsp)        # 32-byte Spill
	vmovupd	%ymm7, 832(%rsp)        # 32-byte Spill
	jle	.LBB6_9
# %bb.23:                               # 
                                        #   in Loop: Header=BB6_8 Depth=1
	movl	%r9d, %eax
	imull	%r13d, %eax
	cltq
	leaq	(%r8,%rax,4), %rcx
	vxorps	%xmm15, %xmm15, %xmm15
	vmovups	%ymm15, 384(%rsp)       # 32-byte Spill
	movl	$0, %esi
	vxorps	%xmm15, %xmm15, %xmm15
	vmovups	%ymm15, 256(%rsp)       # 32-byte Spill
	vxorps	%xmm15, %xmm15, %xmm15
	vmovups	%ymm15, 192(%rsp)       # 32-byte Spill
	vxorps	%xmm15, %xmm15, %xmm15
	vmovups	%ymm15, 352(%rsp)       # 32-byte Spill
	vxorps	%xmm15, %xmm15, %xmm15
	vmovups	%ymm15, 160(%rsp)       # 32-byte Spill
	vxorps	%xmm15, %xmm15, %xmm15
	vmovups	%ymm15, 64(%rsp)        # 32-byte Spill
	vxorps	%xmm15, %xmm15, %xmm15
	vmovups	%ymm15, 320(%rsp)       # 32-byte Spill
	vxorps	%xmm15, %xmm15, %xmm15
	vmovups	%ymm15, 224(%rsp)       # 32-byte Spill
	vxorps	%xmm15, %xmm15, %xmm15
	vmovups	%ymm15, 96(%rsp)        # 32-byte Spill
	vxorps	%xmm15, %xmm15, %xmm15
	vmovups	%ymm15, 288(%rsp)       # 32-byte Spill
	vxorps	%xmm15, %xmm15, %xmm15
	vmovups	%ymm15, (%rsp)          # 32-byte Spill
	vxorps	%xmm15, %xmm15, %xmm15
	vmovups	%ymm15, 32(%rsp)        # 32-byte Spill
	.p2align	4, 0x90
.LBB6_24:                               # 
                                        #   Parent Loop BB6_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	(%rcx,%rsi,4), %ebx
	movslq	%ebx, %rax
	leaq	(%rax,%rax,2), %rax
	shlq	$5, %rax
	vmovapd	(%rdi,%rax), %ymm6
	vmovapd	32(%rdi,%rax), %ymm13
	vmovapd	64(%rdi,%rax), %ymm1
	vmovupd	896(%rsp), %ymm0        # 32-byte Reload
	vsubpd	%ymm6, %ymm0, %ymm11
	vmovupd	%ymm11, 448(%rsp)       # 32-byte Spill
	vmovupd	832(%rsp), %ymm0        # 32-byte Reload
	vsubpd	%ymm13, %ymm0, %ymm10
	vmovupd	%ymm10, 576(%rsp)       # 32-byte Spill
	vmovupd	1024(%rsp), %ymm0       # 32-byte Reload
	vsubpd	%ymm1, %ymm0, %ymm9
	vmovupd	%ymm9, 672(%rsp)        # 32-byte Spill
	vmovupd	1088(%rsp), %ymm0       # 32-byte Reload
	vsubpd	%ymm6, %ymm0, %ymm8
	vmovupd	%ymm8, 544(%rsp)        # 32-byte Spill
	xorl	%eax, %eax
	vmovupd	1120(%rsp), %ymm0       # 32-byte Reload
	vsubpd	%ymm13, %ymm0, %ymm12
	vmovupd	%ymm12, 640(%rsp)       # 32-byte Spill
	cmpq	%rbx, %r13
	sete	%al
	leal	(,%rax,4), %ebx
	vmovupd	992(%rsp), %ymm0        # 32-byte Reload
	vsubpd	%ymm1, %ymm0, %ymm14
	vmovupd	%ymm14, 704(%rsp)       # 32-byte Spill
	vpbroadcastd	376(%rbp,%rbx,4), %xmm0
	leal	1(,%rax,4), %ebx
	vpbroadcastd	376(%rbp,%rbx,4), %xmm2
	vmovupd	1184(%rsp), %ymm3       # 32-byte Reload
	vsubpd	%ymm13, %ymm3, %ymm3
	vmovupd	%ymm3, 416(%rsp)        # 32-byte Spill
	leal	2(,%rax,4), %ebx
	vmovdqa	.LCPI6_1(%rip), %xmm5   # xmm5 = [31,30,29,28]
	vpsllvd	%xmm5, %xmm0, %xmm0
	vpbroadcastd	376(%rbp,%rbx,4), %xmm4
	vpsllvd	%xmm5, %xmm2, %xmm2
	vpsllvd	%xmm5, %xmm4, %xmm7
	vpsrad	$31, %xmm0, %xmm0
	vpmovsxdq	%xmm0, %ymm0
	vpsrad	$31, %xmm2, %xmm2
	vmulpd	%ymm9, %ymm9, %ymm4
	vpmovsxdq	%xmm2, %ymm9
	vfmadd231pd	%ymm10, %ymm10, %ymm4 # ymm4 = (ymm10 * ymm10) + ymm4
	vmulpd	%ymm14, %ymm14, %ymm2
	vfmadd231pd	%ymm12, %ymm12, %ymm2 # ymm2 = (ymm12 * ymm12) + ymm2
	vfmadd231pd	%ymm11, %ymm11, %ymm4 # ymm4 = (ymm11 * ymm11) + ymm4
	vfmadd231pd	%ymm8, %ymm8, %ymm2 # ymm2 = (ymm8 * ymm8) + ymm2
	vmovupd	768(%rsp), %ymm3        # 32-byte Reload
	vcmpltpd	%ymm3, %ymm4, %ymm11
	vandpd	%ymm0, %ymm11, %ymm15
	vcmpltpd	%ymm3, %ymm2, %ymm0
	vandpd	%ymm0, %ymm9, %ymm9
	vmovupd	960(%rsp), %ymm0        # 32-byte Reload
	vsubpd	%ymm1, %ymm0, %ymm0
	vmovupd	%ymm0, 512(%rsp)        # 32-byte Spill
	vpsrad	$31, %xmm7, %xmm7
	vpmovsxdq	%xmm7, %ymm7
	vmulpd	%ymm0, %ymm0, %ymm8
	vmovupd	416(%rsp), %ymm0        # 32-byte Reload
	vfmadd231pd	%ymm0, %ymm0, %ymm8 # ymm8 = (ymm0 * ymm0) + ymm8
	vmovupd	864(%rsp), %ymm0        # 32-byte Reload
	vsubpd	%ymm6, %ymm0, %ymm14
	vfmadd231pd	%ymm14, %ymm14, %ymm8 # ymm8 = (ymm14 * ymm14) + ymm8
	vcmpltpd	%ymm3, %ymm8, %ymm11
	vandpd	%ymm7, %ymm11, %ymm12
	leal	3(,%rax,4), %eax
	vmovupd	1056(%rsp), %ymm0       # 32-byte Reload
	vsubpd	%ymm6, %ymm0, %ymm11
	vpbroadcastd	376(%rbp,%rax,4), %xmm6
	vpsllvd	%xmm5, %xmm6, %xmm7
	vmovupd	1152(%rsp), %ymm0       # 32-byte Reload
	vsubpd	%ymm13, %ymm0, %ymm5
	vmovupd	%ymm5, 480(%rsp)        # 32-byte Spill
	vmovupd	928(%rsp), %ymm0        # 32-byte Reload
	vsubpd	%ymm1, %ymm0, %ymm0
	vmovupd	%ymm0, 608(%rsp)        # 32-byte Spill
	vpsrad	$31, %xmm7, %xmm7
	vpmovsxdq	%xmm7, %ymm7
	vmulpd	%ymm0, %ymm0, %ymm10
	vfmadd231pd	%ymm5, %ymm5, %ymm10 # ymm10 = (ymm5 * ymm5) + ymm10
	vfmadd231pd	%ymm11, %ymm11, %ymm10 # ymm10 = (ymm11 * ymm11) + ymm10
	vcmpltpd	%ymm3, %ymm10, %ymm13
	vandpd	%ymm7, %ymm13, %ymm13
	vcvtpd2ps	%ymm4, %xmm4
	vrcpps	%xmm4, %xmm4
	vcvtps2pd	%xmm4, %ymm4
	vmovupd	800(%rsp), %ymm0        # 32-byte Reload
	vmulpd	%ymm0, %ymm4, %ymm7
	vmulpd	%ymm4, %ymm4, %ymm5
	vmulpd	%ymm7, %ymm5, %ymm5
	vcvtpd2ps	%ymm2, %xmm2
	vrcpps	%xmm2, %xmm2
	vcvtps2pd	%xmm2, %ymm2
	vmulpd	%ymm0, %ymm2, %ymm7
	vmulpd	%ymm2, %ymm2, %ymm3
	vmulpd	%ymm7, %ymm3, %ymm3
	vcvtpd2ps	%ymm8, %xmm7
	vrcpps	%xmm7, %xmm7
	vcvtps2pd	%xmm7, %ymm7
	vmulpd	%ymm0, %ymm7, %ymm8
	vmulpd	%ymm7, %ymm7, %ymm1
	vmulpd	%ymm1, %ymm8, %ymm1
	vcvtpd2ps	%ymm10, %xmm6
	vrcpps	%xmm6, %xmm6
	vcvtps2pd	%xmm6, %ymm6
	vmulpd	%ymm0, %ymm6, %ymm8
	vmulpd	%ymm6, %ymm6, %ymm10
	vmulpd	%ymm8, %ymm10, %ymm8
	vmovupd	736(%rsp), %ymm0        # 32-byte Reload
	vmulpd	%ymm4, %ymm0, %ymm4
	vmulpd	%ymm5, %ymm4, %ymm4
	vbroadcastsd	.LCPI6_2(%rip), %ymm10 # ymm10 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vaddpd	%ymm5, %ymm10, %ymm5
	vmulpd	%ymm5, %ymm4, %ymm4
	vmulpd	%ymm2, %ymm0, %ymm2
	vmulpd	%ymm3, %ymm2, %ymm2
	vaddpd	%ymm3, %ymm10, %ymm3
	vmulpd	%ymm3, %ymm2, %ymm3
	vmulpd	%ymm7, %ymm0, %ymm2
	vmulpd	%ymm1, %ymm2, %ymm2
	vaddpd	%ymm1, %ymm10, %ymm1
	vmulpd	%ymm1, %ymm2, %ymm1
	vmulpd	%ymm6, %ymm0, %ymm2
	vaddpd	%ymm10, %ymm8, %ymm5
	vmulpd	%ymm2, %ymm8, %ymm2
	vmulpd	%ymm5, %ymm2, %ymm2
	vmulpd	448(%rsp), %ymm4, %ymm5 # 32-byte Folded Reload
	vandpd	%ymm5, %ymm15, %ymm5
	vmovupd	384(%rsp), %ymm6        # 32-byte Reload
	vaddpd	%ymm5, %ymm6, %ymm6
	vmovupd	%ymm6, 384(%rsp)        # 32-byte Spill
	vmulpd	576(%rsp), %ymm4, %ymm5 # 32-byte Folded Reload
	vandpd	%ymm5, %ymm15, %ymm5
	vmovupd	256(%rsp), %ymm6        # 32-byte Reload
	vaddpd	%ymm5, %ymm6, %ymm6
	vmovupd	%ymm6, 256(%rsp)        # 32-byte Spill
	vmulpd	672(%rsp), %ymm4, %ymm4 # 32-byte Folded Reload
	vandpd	%ymm4, %ymm15, %ymm4
	vmovupd	192(%rsp), %ymm5        # 32-byte Reload
	vaddpd	%ymm4, %ymm5, %ymm5
	vmovupd	%ymm5, 192(%rsp)        # 32-byte Spill
	vmulpd	544(%rsp), %ymm3, %ymm4 # 32-byte Folded Reload
	vandpd	%ymm4, %ymm9, %ymm4
	vmovupd	352(%rsp), %ymm5        # 32-byte Reload
	vaddpd	%ymm4, %ymm5, %ymm5
	vmovupd	%ymm5, 352(%rsp)        # 32-byte Spill
	vmulpd	640(%rsp), %ymm3, %ymm4 # 32-byte Folded Reload
	vandpd	%ymm4, %ymm9, %ymm4
	vmovupd	160(%rsp), %ymm5        # 32-byte Reload
	vaddpd	%ymm4, %ymm5, %ymm5
	vmovupd	%ymm5, 160(%rsp)        # 32-byte Spill
	vmulpd	704(%rsp), %ymm3, %ymm3 # 32-byte Folded Reload
	vandpd	%ymm3, %ymm9, %ymm0
	vmovupd	64(%rsp), %ymm3         # 32-byte Reload
	vaddpd	%ymm0, %ymm3, %ymm3
	vmovupd	%ymm3, 64(%rsp)         # 32-byte Spill
	vmulpd	%ymm1, %ymm14, %ymm0
	vandpd	%ymm0, %ymm12, %ymm0
	vmovupd	320(%rsp), %ymm3        # 32-byte Reload
	vaddpd	%ymm0, %ymm3, %ymm3
	vmovupd	%ymm3, 320(%rsp)        # 32-byte Spill
	vmulpd	416(%rsp), %ymm1, %ymm0 # 32-byte Folded Reload
	vmulpd	512(%rsp), %ymm1, %ymm1 # 32-byte Folded Reload
	vandpd	%ymm0, %ymm12, %ymm0
	vandpd	%ymm1, %ymm12, %ymm1
	vmovupd	224(%rsp), %ymm3        # 32-byte Reload
	vaddpd	%ymm0, %ymm3, %ymm3
	vmovupd	%ymm3, 224(%rsp)        # 32-byte Spill
	vmovupd	96(%rsp), %ymm0         # 32-byte Reload
	vaddpd	%ymm1, %ymm0, %ymm0
	vmovupd	%ymm0, 96(%rsp)         # 32-byte Spill
	vmulpd	%ymm2, %ymm11, %ymm0
	vandpd	%ymm0, %ymm13, %ymm0
	vmovupd	288(%rsp), %ymm1        # 32-byte Reload
	vaddpd	%ymm0, %ymm1, %ymm1
	vmovupd	%ymm1, 288(%rsp)        # 32-byte Spill
	vmulpd	480(%rsp), %ymm2, %ymm0 # 32-byte Folded Reload
	vmulpd	608(%rsp), %ymm2, %ymm1 # 32-byte Folded Reload
	vandpd	%ymm0, %ymm13, %ymm0
	vmovupd	(%rsp), %ymm2           # 32-byte Reload
	vaddpd	%ymm0, %ymm2, %ymm2
	vmovupd	%ymm2, (%rsp)           # 32-byte Spill
	vandpd	%ymm1, %ymm13, %ymm0
	vmovupd	32(%rsp), %ymm1         # 32-byte Reload
	vaddpd	%ymm0, %ymm1, %ymm1
	vmovupd	%ymm1, 32(%rsp)         # 32-byte Spill
	incq	%rsi
	cmpq	%rsi, %rdx
	jne	.LBB6_24
	jmp	.LBB6_10
	.p2align	4, 0x90
.LBB6_9:                                # 
                                        #   in Loop: Header=BB6_8 Depth=1
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovupd	%ymm2, 32(%rsp)         # 32-byte Spill
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovupd	%ymm2, (%rsp)           # 32-byte Spill
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovupd	%ymm2, 288(%rsp)        # 32-byte Spill
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovupd	%ymm2, 96(%rsp)         # 32-byte Spill
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovupd	%ymm2, 224(%rsp)        # 32-byte Spill
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovupd	%ymm2, 320(%rsp)        # 32-byte Spill
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovupd	%ymm2, 64(%rsp)         # 32-byte Spill
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovupd	%ymm2, 160(%rsp)        # 32-byte Spill
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovupd	%ymm2, 352(%rsp)        # 32-byte Spill
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovupd	%ymm2, 192(%rsp)        # 32-byte Spill
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovupd	%ymm2, 256(%rsp)        # 32-byte Spill
	vxorpd	%xmm2, %xmm2, %xmm2
	vmovupd	%ymm2, 384(%rsp)        # 32-byte Spill
.LBB6_10:                               # 
                                        #   in Loop: Header=BB6_8 Depth=1
	vmovupd	32(%rsp), %ymm14        # 32-byte Reload
	vmovupd	64(%rsp), %ymm5         # 32-byte Reload
	vmovupd	192(%rsp), %ymm11       # 32-byte Reload
	vmovupd	(%rsp), %ymm2           # 32-byte Reload
	vmovupd	224(%rsp), %ymm15       # 32-byte Reload
	vmovupd	160(%rsp), %ymm13       # 32-byte Reload
	vmovupd	256(%rsp), %ymm12       # 32-byte Reload
	vmovupd	288(%rsp), %ymm8        # 32-byte Reload
	vmovupd	320(%rsp), %ymm7        # 32-byte Reload
	vmovupd	352(%rsp), %ymm10       # 32-byte Reload
	vmovupd	384(%rsp), %ymm9        # 32-byte Reload
	cmpl	%r12d, %edx
	vmovupd	%ymm5, 64(%rsp)         # 32-byte Spill
	jge	.LBB6_11
# %bb.25:                               # 
                                        #   in Loop: Header=BB6_8 Depth=1
	movslq	%edx, %rcx
	imull	%r13d, %r9d
	movslq	%r9d, %rax
	leaq	(%r8,%rax,4), %rdx
	vmovapd	%ymm13, %ymm3
	vmovapd	%ymm15, %ymm4
	vmovapd	%ymm11, %ymm15
	vmovups	96(%rsp), %ymm6         # 32-byte Reload
	.p2align	4, 0x90
movl      $111, %ebx # OSACA START MARKER
.byte     100        # OSACA START MARKER
.byte     103        # OSACA START MARKER
.byte     144        # OSACA START MARKER
# pointer_increment=64 da67166e5736661e6b03ea29ee7bfd67
# LLVM-MCA-BEGIN
.LBB6_26:                               # 
                                        #   Parent Loop BB6_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovups	%ymm6, 96(%rsp)         # 32-byte Spill
	vmovupd	%ymm14, 32(%rsp)        # 32-byte Spill
	vmovupd	%ymm15, 192(%rsp)       # 32-byte Spill
	vmovupd	%ymm2, (%rsp)           # 32-byte Spill
	vmovupd	%ymm4, 224(%rsp)        # 32-byte Spill
	vmovupd	%ymm12, 256(%rsp)       # 32-byte Spill
	vmovupd	%ymm8, 288(%rsp)        # 32-byte Spill
	vmovupd	%ymm7, 320(%rsp)        # 32-byte Spill
	vmovupd	%ymm10, 352(%rsp)       # 32-byte Spill
	vmovupd	%ymm9, 384(%rsp)        # 32-byte Spill
	movslq	(%rdx,%rcx,4), %rax
	leaq	(%rax,%rax,2), %rax
	shlq	$5, %rax
	vmovapd	(%rdi,%rax), %ymm5
	vmovapd	32(%rdi,%rax), %ymm12
	vmovapd	64(%rdi,%rax), %ymm14
	vmovupd	896(%rsp), %ymm0        # 32-byte Reload
	vsubpd	%ymm5, %ymm0, %ymm11
	vmovupd	%ymm11, 640(%rsp)       # 32-byte Spill
	vmovupd	832(%rsp), %ymm0        # 32-byte Reload
	vsubpd	%ymm12, %ymm0, %ymm10
	vmovupd	%ymm10, 672(%rsp)       # 32-byte Spill
	vmovupd	1024(%rsp), %ymm0       # 32-byte Reload
	vsubpd	%ymm14, %ymm0, %ymm1
	vmovupd	%ymm1, 160(%rsp)        # 32-byte Spill
	vmovupd	1088(%rsp), %ymm0       # 32-byte Reload
	vsubpd	%ymm5, %ymm0, %ymm8
	vmovupd	%ymm8, 448(%rsp)        # 32-byte Spill
	vmovupd	1120(%rsp), %ymm0       # 32-byte Reload
	vsubpd	%ymm12, %ymm0, %ymm4
	vmovupd	%ymm4, 704(%rsp)        # 32-byte Spill
	vmovupd	992(%rsp), %ymm0        # 32-byte Reload
	vsubpd	%ymm14, %ymm0, %ymm2
	vmovupd	%ymm2, 416(%rsp)        # 32-byte Spill
	vmovupd	1184(%rsp), %ymm0       # 32-byte Reload
	vsubpd	%ymm12, %ymm0, %ymm7
	vmovupd	%ymm7, 576(%rsp)        # 32-byte Spill
	vmovupd	960(%rsp), %ymm0        # 32-byte Reload
	vsubpd	%ymm14, %ymm0, %ymm6
	vmovupd	%ymm6, 608(%rsp)        # 32-byte Spill
	vmulpd	%ymm1, %ymm1, %ymm9
	vfmadd231pd	%ymm10, %ymm10, %ymm9 # ymm9 = (ymm10 * ymm10) + ymm9
	vfmadd231pd	%ymm11, %ymm11, %ymm9 # ymm9 = (ymm11 * ymm11) + ymm9
	vmulpd	%ymm2, %ymm2, %ymm1
	vfmadd231pd	%ymm4, %ymm4, %ymm1 # ymm1 = (ymm4 * ymm4) + ymm1
	vcvtpd2ps	%ymm9, %xmm0
	vrcpps	%xmm0, %xmm0
	vcvtps2pd	%xmm0, %ymm0
	vmovupd	800(%rsp), %ymm11       # 32-byte Reload
	vmulpd	%ymm0, %ymm11, %ymm2
	vmovapd	%ymm3, %ymm4
	vmulpd	%ymm0, %ymm0, %ymm3
	vmulpd	%ymm2, %ymm3, %ymm3
	vmulpd	%ymm6, %ymm6, %ymm2
	vfmadd231pd	%ymm8, %ymm8, %ymm1 # ymm1 = (ymm8 * ymm8) + ymm1
	vfmadd231pd	%ymm7, %ymm7, %ymm2 # ymm2 = (ymm7 * ymm7) + ymm2
	vmovupd	864(%rsp), %ymm6        # 32-byte Reload
	vsubpd	%ymm5, %ymm6, %ymm6
	vmovupd	%ymm6, 480(%rsp)        # 32-byte Spill
	vcvtpd2ps	%ymm1, %xmm7
	vfmadd231pd	%ymm6, %ymm6, %ymm2 # ymm2 = (ymm6 * ymm6) + ymm2
	vrcpps	%xmm7, %xmm7
	vcvtps2pd	%xmm7, %ymm7
	vcvtpd2ps	%ymm2, %xmm6
	vmulpd	%ymm7, %ymm11, %ymm10
	vmulpd	%ymm7, %ymm7, %ymm15
	vmulpd	%ymm10, %ymm15, %ymm10
	vrcpps	%xmm6, %xmm6
	vcvtps2pd	%xmm6, %ymm6
	vmulpd	%ymm6, %ymm11, %ymm15
	vmulpd	%ymm6, %ymm6, %ymm13
	vmulpd	%ymm15, %ymm13, %ymm13
	vmovupd	1152(%rsp), %ymm8       # 32-byte Reload
	vsubpd	%ymm12, %ymm8, %ymm12
	vmovupd	%ymm12, 512(%rsp)       # 32-byte Spill
	vmovupd	928(%rsp), %ymm8        # 32-byte Reload
	vsubpd	%ymm14, %ymm8, %ymm8
	vmovupd	%ymm8, 544(%rsp)        # 32-byte Spill
	vmulpd	%ymm8, %ymm8, %ymm14
	vfmadd231pd	%ymm12, %ymm12, %ymm14 # ymm14 = (ymm12 * ymm12) + ymm14
	vmovupd	1056(%rsp), %ymm8       # 32-byte Reload
	vsubpd	%ymm5, %ymm8, %ymm5
	vmovupd	%ymm5, 1216(%rsp)       # 32-byte Spill
	vfmadd231pd	%ymm5, %ymm5, %ymm14 # ymm14 = (ymm5 * ymm5) + ymm14
	vcvtpd2ps	%ymm14, %xmm8
	vrcpps	%xmm8, %xmm5
	vcvtps2pd	%xmm5, %ymm5
	vmulpd	%ymm5, %ymm11, %ymm8
	vmulpd	%ymm5, %ymm5, %ymm12
	vmulpd	%ymm8, %ymm12, %ymm8
	vmovupd	736(%rsp), %ymm11       # 32-byte Reload
	vmulpd	%ymm0, %ymm11, %ymm0
	vmulpd	%ymm3, %ymm0, %ymm0
	vbroadcastsd	.LCPI6_2(%rip), %ymm12 # ymm12 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vaddpd	%ymm3, %ymm12, %ymm3
	vmulpd	%ymm3, %ymm0, %ymm3
	vmulpd	%ymm7, %ymm11, %ymm0
	vmulpd	%ymm0, %ymm10, %ymm0
	vaddpd	%ymm12, %ymm10, %ymm7
	vmulpd	%ymm7, %ymm0, %ymm7
	vmulpd	%ymm6, %ymm11, %ymm0
	vmulpd	%ymm0, %ymm13, %ymm0
	vaddpd	%ymm12, %ymm13, %ymm6
	vmovupd	192(%rsp), %ymm15       # 32-byte Reload
	vmulpd	%ymm6, %ymm0, %ymm6
	vmulpd	%ymm5, %ymm11, %ymm0
	vaddpd	%ymm12, %ymm8, %ymm5
	vmovupd	256(%rsp), %ymm12       # 32-byte Reload
	vmovupd	352(%rsp), %ymm10       # 32-byte Reload
	vmulpd	%ymm0, %ymm8, %ymm0
	vmulpd	%ymm5, %ymm0, %ymm0
	vmovupd	768(%rsp), %ymm13       # 32-byte Reload
	vcmpltpd	%ymm13, %ymm9, %ymm5
	vmovupd	384(%rsp), %ymm9        # 32-byte Reload
	vmulpd	640(%rsp), %ymm3, %ymm8 # 32-byte Folded Reload
	vandpd	%ymm5, %ymm8, %ymm8
	vaddpd	%ymm8, %ymm9, %ymm9
	vmulpd	672(%rsp), %ymm3, %ymm8 # 32-byte Folded Reload
	vandpd	%ymm5, %ymm8, %ymm8
	vaddpd	%ymm8, %ymm12, %ymm12
	vmulpd	160(%rsp), %ymm3, %ymm3 # 32-byte Folded Reload
	vandpd	%ymm5, %ymm3, %ymm3
	vaddpd	%ymm3, %ymm15, %ymm15
	vcmpltpd	%ymm13, %ymm1, %ymm1
	vmulpd	448(%rsp), %ymm7, %ymm3 # 32-byte Folded Reload
	vandpd	%ymm1, %ymm3, %ymm3
	vaddpd	%ymm3, %ymm10, %ymm10
	vmulpd	704(%rsp), %ymm7, %ymm3 # 32-byte Folded Reload
	vmulpd	416(%rsp), %ymm7, %ymm5 # 32-byte Folded Reload
	vandpd	%ymm1, %ymm3, %ymm3
	vaddpd	%ymm3, %ymm4, %ymm3
	vmovupd	224(%rsp), %ymm4        # 32-byte Reload
	vandpd	%ymm1, %ymm5, %ymm1
	vmovupd	64(%rsp), %ymm5         # 32-byte Reload
	vaddpd	%ymm1, %ymm5, %ymm5
	vmovupd	%ymm5, 64(%rsp)         # 32-byte Spill
	vcmpltpd	%ymm13, %ymm2, %ymm1
	vmulpd	480(%rsp), %ymm6, %ymm2 # 32-byte Folded Reload
	vmovupd	288(%rsp), %ymm8        # 32-byte Reload
	vmovupd	320(%rsp), %ymm7        # 32-byte Reload
	vandpd	%ymm1, %ymm2, %ymm2
	vaddpd	%ymm2, %ymm7, %ymm7
	vmulpd	576(%rsp), %ymm6, %ymm2 # 32-byte Folded Reload
	vandpd	%ymm1, %ymm2, %ymm2
	vaddpd	%ymm2, %ymm4, %ymm4
	vmulpd	608(%rsp), %ymm6, %ymm2 # 32-byte Folded Reload
	vmovupd	96(%rsp), %ymm6         # 32-byte Reload
	vandpd	%ymm1, %ymm2, %ymm1
	vaddpd	%ymm1, %ymm6, %ymm6
	vcmpltpd	%ymm13, %ymm14, %ymm1
	vmulpd	1216(%rsp), %ymm0, %ymm2 # 32-byte Folded Reload
	vandpd	%ymm1, %ymm2, %ymm2
	vaddpd	%ymm2, %ymm8, %ymm8
	vmulpd	512(%rsp), %ymm0, %ymm2 # 32-byte Folded Reload
	vmulpd	544(%rsp), %ymm0, %ymm0 # 32-byte Folded Reload
	vandpd	%ymm1, %ymm2, %ymm2
	vmovupd	(%rsp), %ymm5           # 32-byte Reload
	vaddpd	%ymm2, %ymm5, %ymm5
	vmovupd	%ymm5, (%rsp)           # 32-byte Spill
	vmovupd	(%rsp), %ymm2           # 32-byte Reload
	vandpd	%ymm1, %ymm0, %ymm0
	vmovupd	32(%rsp), %ymm1         # 32-byte Reload
	vaddpd	%ymm0, %ymm1, %ymm1
	vmovupd	%ymm1, 32(%rsp)         # 32-byte Spill
	vmovupd	32(%rsp), %ymm14        # 32-byte Reload
	incq	%rcx
	cmpq	%rcx, %r12
	jne	.LBB6_26
	jmp	.LBB6_12
# LLVM-MCA-END
movl      $222, %ebx # OSACA END MARKER
.byte     100        # OSACA END MARKER
.byte     103        # OSACA END MARKER
.byte     144        # OSACA END MARKER
.LBB6_13:                               # 
	movl	$.L.str.1, %edi
	vzeroupper
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, (%rsp)           # 8-byte Spill
	movl	$.L.str.6, %edi
	xorl	%eax, %eax
	callq	debug_printf
	vmovsd	(%rsp), %xmm0           # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vsubsd	152(%rsp), %xmm0, %xmm0 # 8-byte Folded Reload
	addq	$1256, %rsp             # imm = 0x4E8
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
	.asciz	"simd_load_h_dual(): Not implemented for AVX2 with double precision!"
	.size	.L.str.7, 68

	.ident	"Intel(R) oneAPI DPC++ Compiler 2021.1-beta05 (2020.2.0.0304)"
	.section	".note.GNU-stack","",@progbits
