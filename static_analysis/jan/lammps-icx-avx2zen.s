	.text
	.file	"force_lj.c"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3               # -- Begin function computeForceLJFullNeigh_plain_c
.LCPI0_0:
	.quad	4631952216750555136     #  48
.LCPI0_3:
	.quad	4607182418800017408     #  1
.LCPI0_4:
	.quad	-4620693217682128896    #  -0.5
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2
.LCPI0_1:
	.long	3                       # 0x3
.LCPI0_2:
	.long	2                       # 0x2
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI0_5:
	.zero	16,255
	.text
	.globl	computeForceLJFullNeigh_plain_c
	.p2align	4, 0x90
	.type	computeForceLJFullNeigh_plain_c,@function
computeForceLJFullNeigh_plain_c:        # 
.LcomputeForceLJFullNeigh_plain_c$local:
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
	subq	$264, %rsp              # imm = 0x108
	.cfi_def_cfa_offset 320
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rcx, %rbx
	movq	%rdx, %r15
	movq	%rsi, %r12
	movl	4(%rsi), %r14d
	vmovsd	144(%rdi), %xmm0        # xmm0 = mem[0],zero
	vmovsd	%xmm0, (%rsp)           # 8-byte Spill
	vmovsd	40(%rdi), %xmm0         # xmm0 = mem[0],zero
	vmovsd	%xmm0, 128(%rsp)        # 8-byte Spill
	vmovq	56(%rdi), %xmm0         # xmm0 = mem[0],zero
	vmovdqa	%xmm0, 80(%rsp)         # 16-byte Spill
	testl	%r14d, %r14d
	jle	.LBB0_2
# %bb.1:                                # 
	movq	64(%r12), %rdi
	leaq	(,%r14,8), %rax
	leaq	(%rax,%rax,2), %rdx
	xorl	%esi, %esi
	callq	_intel_fast_memset
.LBB0_2:                                # 
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovq	%xmm0, 32(%rsp)         # 8-byte Folded Spill
	movl	$.L.str, %edi
	callq	likwid_markerStartRegion
	testl	%r14d, %r14d
	jle	.LBB0_19
# %bb.3:                                # 
	vmovsd	(%rsp), %xmm0           # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm13
	movq	16(%r15), %r11
	movq	24(%r15), %rsi
	movslq	8(%r15), %rdi
	movq	16(%r12), %r15
	movq	64(%r12), %r8
	vmovsd	128(%rsp), %xmm0        # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	.LCPI0_0(%rip), %xmm0, %xmm15
	movq	%rbx, 24(%rsp)          # 8-byte Spill
	vmovdqu	(%rbx), %xmm14
	decq	%r14
	vmovq	%r15, %xmm0
	vpbroadcastq	%xmm0, %ymm3
	vbroadcastsd	%xmm13, %ymm2
	vmovapd	80(%rsp), %xmm12        # 16-byte Reload
	vbroadcastsd	%xmm12, %ymm8
	vbroadcastsd	%xmm15, %ymm9
	shlq	$2, %rdi
	xorl	%r10d, %r10d
	movq	%r14, 56(%rsp)          # 8-byte Spill
	vmovapd	%xmm13, 192(%rsp)       # 16-byte Spill
	movq	%rsi, 48(%rsp)          # 8-byte Spill
	movq	%rdi, 40(%rsp)          # 8-byte Spill
	vmovapd	%xmm15, 176(%rsp)       # 16-byte Spill
	vmovupd	%ymm2, 224(%rsp)        # 32-byte Spill
	vmovupd	%ymm9, 128(%rsp)        # 32-byte Spill
	jmp	.LBB0_6
	.p2align	4, 0x90
.LBB0_17:                               # 
                                        #   in Loop: Header=BB0_6 Depth=1
	movq	%r13, %rdx
.LBB0_5:                                # 
                                        #   in Loop: Header=BB0_6 Depth=1
	vaddsd	(%r8,%r12,8), %xmm10, %xmm0
	vmovsd	%xmm0, (%r8,%r12,8)
	vaddsd	(%r8,%rbx,8), %xmm11, %xmm0
	vmovsd	%xmm0, (%r8,%rbx,8)
	vaddsd	(%r8,%rbp,8), %xmm5, %xmm0
	vmovsd	%xmm0, (%r8,%rbp,8)
	leal	3(%r13), %eax
	addl	$6, %r13d
	testl	%eax, %eax
	cmovnsl	%eax, %r13d
	sarl	$2, %r13d
	movslq	%r13d, %rax
	vmovq	%rax, %xmm0
	vmovq	%rdx, %xmm1
	vpunpcklqdq	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
	vpaddq	%xmm0, %xmm14, %xmm14
	addq	%rdi, %r11
	cmpq	%r14, %r10
	leaq	1(%r10), %r10
	je	.LBB0_18
.LBB0_6:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_9 Depth 2
                                        #     Child Loop BB0_13 Depth 2
	movl	(%rsi,%r10,4), %r13d
	leal	(%r10,%r10,2), %r12d
	leal	(%r10,%r10,2), %ebx
	incl	%ebx
	leal	(%r10,%r10,2), %ebp
	addl	$2, %ebp
	testl	%r13d, %r13d
	jle	.LBB0_4
# %bb.7:                                # 
                                        #   in Loop: Header=BB0_6 Depth=1
	vmovsd	(%r15,%r12,8), %xmm0    # xmm0 = mem[0],zero
	vmovsd	(%r15,%rbx,8), %xmm1    # xmm1 = mem[0],zero
	vmovsd	(%r15,%rbp,8), %xmm2    # xmm2 = mem[0],zero
	movq	%r13, %rdx
	movl	$4294967292, %eax       # imm = 0xFFFFFFFC
	andq	%rax, %rdx
	vmovapd	%xmm0, 112(%rsp)        # 16-byte Spill
	vmovapd	%xmm1, 96(%rsp)         # 16-byte Spill
	vmovapd	%xmm2, (%rsp)           # 16-byte Spill
	je	.LBB0_16
# %bb.8:                                # 
                                        #   in Loop: Header=BB0_6 Depth=1
	movq	%rbp, 64(%rsp)          # 8-byte Spill
	movq	%rbx, 72(%rsp)          # 8-byte Spill
	vmovdqa	%xmm14, 208(%rsp)       # 16-byte Spill
	vbroadcastsd	%xmm0, %ymm14
	vbroadcastsd	%xmm1, %ymm5
	vbroadcastsd	%xmm2, %ymm10
	vxorpd	%xmm0, %xmm0, %xmm0
	vxorpd	%xmm15, %xmm15, %xmm15
	vxorpd	%xmm13, %xmm13, %xmm13
	xorl	%ebp, %ebp
	vmovapd	%ymm8, %ymm9
	vmovupd	224(%rsp), %ymm8        # 32-byte Reload
	.p2align	4, 0x90
movl      $111, %ebx # OSACA START MARKER
.byte     100        # OSACA START MARKER
.byte     103        # OSACA START MARKER
.byte     144        # OSACA START MARKER
# pointer_increment=16 e95035fc9e97f63299dd5188a0872bfc
# LLVM-MCA-BEGIN
.LBB0_9:                                # 
                                        #   Parent Loop BB0_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vpbroadcastd	.LCPI0_1(%rip), %xmm1 # xmm1 = [3,3,3,3]
	vpmulld	(%r11,%rbp,4), %xmm1, %xmm11
	vpmovsxdq	%xmm11, %ymm1
	vpsllq	$3, %ymm1, %ymm1
	vpaddq	%ymm1, %ymm3, %ymm1
	vmovq	%xmm1, %r14
	vpextrq	$1, %xmm1, %r9
	vextracti128	$1, %ymm1, %xmm1
	vmovsd	(%r14), %xmm2           # xmm2 = mem[0],zero
	vpsubd	.LCPI0_5, %xmm11, %xmm6
	vpmovsxdq	%xmm6, %ymm6
	vpsllq	$3, %ymm6, %ymm6
	vmovq	%xmm1, %rdi
	vpaddq	%ymm6, %ymm3, %ymm6
	vmovq	%xmm6, %rcx
	vpextrq	$1, %xmm1, %rbx
	vpextrq	$1, %xmm6, %rax
	vextracti128	$1, %ymm6, %xmm1
	vmovsd	(%rdi), %xmm6           # xmm6 = mem[0],zero
	vmovq	%xmm1, %rdi
	vpextrq	$1, %xmm1, %rsi
	vmovsd	(%rdi), %xmm1           # xmm1 = mem[0],zero
	vmovsd	(%rcx), %xmm7           # xmm7 = mem[0],zero
	vpbroadcastd	.LCPI0_2(%rip), %xmm12 # xmm12 = [2,2,2,2]
	vmovhpd	(%r9), %xmm2, %xmm2     # xmm2 = xmm2[0],mem[0]
	vpaddd	%xmm12, %xmm11, %xmm4
	vpmovsxdq	%xmm4, %ymm4
	vmovhpd	(%rax), %xmm7, %xmm7    # xmm7 = xmm7[0],mem[0]
	vpsllq	$3, %ymm4, %ymm4
	vpaddq	%ymm4, %ymm3, %ymm4
	vmovhpd	(%rbx), %xmm6, %xmm6    # xmm6 = xmm6[0],mem[0]
	vpextrq	$1, %xmm4, %rax
	vmovhpd	(%rsi), %xmm1, %xmm1    # xmm1 = xmm1[0],mem[0]
	vmovq	%xmm4, %rcx
	vextracti128	$1, %ymm4, %xmm4
	vmovq	%xmm4, %rsi
	vinsertf128	$1, %xmm6, %ymm2, %ymm2
	vpextrq	$1, %xmm4, %rdi
	vmovsd	(%rsi), %xmm4           # xmm4 = mem[0],zero
	vsubpd	%ymm2, %ymm14, %ymm2
	vmovhpd	(%rdi), %xmm4, %xmm4    # xmm4 = xmm4[0],mem[0]
	vmovsd	(%rcx), %xmm6           # xmm6 = mem[0],zero
	vinsertf128	$1, %xmm1, %ymm7, %ymm1
	vmovhpd	(%rax), %xmm6, %xmm6    # xmm6 = xmm6[0],mem[0]
	vinsertf128	$1, %xmm4, %ymm6, %ymm4
	vsubpd	%ymm1, %ymm5, %ymm1
	vsubpd	%ymm4, %ymm10, %ymm4
	vmulpd	%ymm2, %ymm2, %ymm6
	vfmadd231pd	%ymm1, %ymm1, %ymm6 # ymm6 = (ymm1 * ymm1) + ymm6
	vfmadd231pd	%ymm4, %ymm4, %ymm6 # ymm6 = (ymm4 * ymm4) + ymm6
	vbroadcastsd	.LCPI0_3(%rip), %ymm7 # ymm7 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0]
	vdivpd	%ymm6, %ymm7, %ymm7
	vmulpd	%ymm7, %ymm7, %ymm11
	vmulpd	%ymm9, %ymm11, %ymm11
	vbroadcastsd	.LCPI0_4(%rip), %ymm12 # ymm12 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
	vmulpd	%ymm7, %ymm11, %ymm11
	vaddpd	%ymm12, %ymm11, %ymm12
	vmulpd	128(%rsp), %ymm7, %ymm7 # 32-byte Folded Reload
	vmulpd	%ymm7, %ymm11, %ymm7
	vmulpd	%ymm7, %ymm12, %ymm7
	vcmpltpd	%ymm8, %ymm6, %ymm6
	vfmadd213pd	%ymm0, %ymm7, %ymm2 # ymm2 = (ymm7 * ymm2) + ymm0
	vblendvpd	%ymm6, %ymm2, %ymm0, %ymm0
	vfmadd213pd	%ymm15, %ymm7, %ymm1 # ymm1 = (ymm7 * ymm1) + ymm15
	vfmadd213pd	%ymm13, %ymm7, %ymm4 # ymm4 = (ymm7 * ymm4) + ymm13
	vblendvpd	%ymm6, %ymm1, %ymm15, %ymm15
	vblendvpd	%ymm6, %ymm4, %ymm13, %ymm13
	addq	$4, %rbp
	cmpq	%rdx, %rbp
	jb	.LBB0_9
# LLVM-MCA-END
movl      $222, %ebx # OSACA END MARKER
.byte     100        # OSACA END MARKER
.byte     103        # OSACA END MARKER
.byte     144        # OSACA END MARKER
# %bb.10:                               # 
                                        #   in Loop: Header=BB0_6 Depth=1
	vpermilpd	$1, %xmm0, %xmm1 # xmm1 = xmm0[1,0]
	vaddsd	%xmm1, %xmm0, %xmm1
	vextractf128	$1, %ymm0, %xmm0
	vaddsd	%xmm0, %xmm1, %xmm1
	vpermilpd	$1, %xmm0, %xmm0 # xmm0 = xmm0[1,0]
	vaddsd	%xmm0, %xmm1, %xmm10
	vpermilpd	$1, %xmm15, %xmm1 # xmm1 = xmm15[1,0]
	vaddsd	%xmm1, %xmm15, %xmm1
	vextractf128	$1, %ymm15, %xmm2
	vaddsd	%xmm2, %xmm1, %xmm1
	vpermilpd	$1, %xmm2, %xmm2 # xmm2 = xmm2[1,0]
	vaddsd	%xmm2, %xmm1, %xmm11
	vpermilpd	$1, %xmm13, %xmm1 # xmm1 = xmm13[1,0]
	vaddsd	%xmm1, %xmm13, %xmm1
	vextractf128	$1, %ymm13, %xmm2
	vaddsd	%xmm2, %xmm1, %xmm1
	vpermilpd	$1, %xmm2, %xmm2 # xmm2 = xmm2[1,0]
	vaddsd	%xmm2, %xmm1, %xmm5
	movq	56(%rsp), %r14          # 8-byte Reload
	vmovapd	80(%rsp), %xmm12        # 16-byte Reload
	vmovapd	192(%rsp), %xmm13       # 16-byte Reload
	movq	48(%rsp), %rsi          # 8-byte Reload
	movq	40(%rsp), %rdi          # 8-byte Reload
	vmovdqa	208(%rsp), %xmm14       # 16-byte Reload
	vmovapd	176(%rsp), %xmm15       # 16-byte Reload
	vmovapd	%ymm9, %ymm8
	movq	72(%rsp), %rbx          # 8-byte Reload
	movq	64(%rsp), %rbp          # 8-byte Reload
	vmovapd	112(%rsp), %xmm0        # 16-byte Reload
	cmpq	%r13, %rdx
	jae	.LBB0_17
	jmp	.LBB0_11
	.p2align	4, 0x90
.LBB0_4:                                # 
                                        #   in Loop: Header=BB0_6 Depth=1
	movslq	%r13d, %rdx
	vxorpd	%xmm5, %xmm5, %xmm5
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorpd	%xmm10, %xmm10, %xmm10
	jmp	.LBB0_5
	.p2align	4, 0x90
.LBB0_16:                               # 
                                        #   in Loop: Header=BB0_6 Depth=1
	vxorpd	%xmm10, %xmm10, %xmm10
	vxorpd	%xmm11, %xmm11, %xmm11
	vxorpd	%xmm5, %xmm5, %xmm5
	cmpq	%r13, %rdx
	jae	.LBB0_17
.LBB0_11:                               # 
                                        #   in Loop: Header=BB0_6 Depth=1
	vmovapd	96(%rsp), %xmm4         # 16-byte Reload
	jmp	.LBB0_13
	.p2align	4, 0x90
.LBB0_12:                               # 
                                        #   in Loop: Header=BB0_13 Depth=2
	incq	%rdx
	cmpq	%rdx, %r13
	je	.LBB0_17
.LBB0_13:                               # 
                                        #   Parent Loop BB0_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	(%r11,%rdx,4), %eax
	leal	(%rax,%rax,2), %ecx
	movslq	%ecx, %rcx
	vsubsd	(%r15,%rcx,8), %xmm0, %xmm6
	leal	(%rax,%rax,2), %ecx
	incl	%ecx
	movslq	%ecx, %rcx
	vsubsd	(%r15,%rcx,8), %xmm4, %xmm2
	leal	2(%rax,%rax,2), %eax
	cltq
	vmovapd	(%rsp), %xmm1           # 16-byte Reload
	vsubsd	(%r15,%rax,8), %xmm1, %xmm1
	vmulsd	%xmm6, %xmm6, %xmm7
	vfmadd231sd	%xmm2, %xmm2, %xmm7 # xmm7 = (xmm2 * xmm2) + xmm7
	vfmadd231sd	%xmm1, %xmm1, %xmm7 # xmm7 = (xmm1 * xmm1) + xmm7
	vucomisd	%xmm13, %xmm7
	jae	.LBB0_12
# %bb.14:                               # 
                                        #   in Loop: Header=BB0_13 Depth=2
	vmovsd	.LCPI0_3(%rip), %xmm0   # xmm0 = mem[0],zero
	vdivsd	%xmm7, %xmm0, %xmm7
	vmulsd	%xmm7, %xmm7, %xmm0
	vmulsd	%xmm0, %xmm12, %xmm0
	vmulsd	%xmm7, %xmm0, %xmm0
	vaddsd	.LCPI0_4(%rip), %xmm0, %xmm4
	vmulsd	%xmm7, %xmm15, %xmm7
	vmulsd	%xmm0, %xmm7, %xmm0
	vmulsd	%xmm4, %xmm0, %xmm0
	vmovapd	96(%rsp), %xmm4         # 16-byte Reload
	vfmadd231sd	%xmm6, %xmm0, %xmm10 # xmm10 = (xmm0 * xmm6) + xmm10
	vfmadd231sd	%xmm2, %xmm0, %xmm11 # xmm11 = (xmm0 * xmm2) + xmm11
	vfmadd231sd	%xmm1, %xmm0, %xmm5 # xmm5 = (xmm0 * xmm1) + xmm5
	vmovapd	112(%rsp), %xmm0        # 16-byte Reload
	jmp	.LBB0_12
.LBB0_18:                               # 
	movq	24(%rsp), %rax          # 8-byte Reload
	vmovdqu	%xmm14, (%rax)
.LBB0_19:                               # 
	movl	$.L.str, %edi
	vzeroupper
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vsubsd	32(%rsp), %xmm0, %xmm0  # 8-byte Folded Reload
	addq	$264, %rsp              # imm = 0x108
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
	.size	computeForceLJFullNeigh_plain_c, .Lfunc_end0-computeForceLJFullNeigh_plain_c
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3               # -- Begin function computeForceLJHalfNeigh
.LCPI1_0:
	.quad	4631952216750555136     #  48
.LCPI1_1:
	.quad	4607182418800017408     #  1
.LCPI1_2:
	.quad	-4620693217682128896    #  -0.5
	.text
	.globl	computeForceLJHalfNeigh
	.p2align	4, 0x90
	.type	computeForceLJHalfNeigh,@function
computeForceLJHalfNeigh:                # 
.LcomputeForceLJHalfNeigh$local:
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rcx, 16(%rsp)          # 8-byte Spill
	movq	%rdx, %r15
	movq	%rsi, %r12
	movl	4(%rsi), %r13d
	vmovsd	144(%rdi), %xmm0        # xmm0 = mem[0],zero
	vmovsd	%xmm0, 8(%rsp)          # 8-byte Spill
	vmovsd	40(%rdi), %xmm0         # xmm0 = mem[0],zero
	vmovsd	%xmm0, (%rsp)           # 8-byte Spill
	vmovsd	56(%rdi), %xmm0         # xmm0 = mem[0],zero
	vmovsd	%xmm0, 32(%rsp)         # 8-byte Spill
	testl	%r13d, %r13d
	jle	.LBB1_2
# %bb.1:                                # 
	movq	64(%r12), %rdi
	leaq	(,%r13,8), %rax
	leaq	(%rax,%rax,2), %rdx
	xorl	%esi, %esi
	callq	_intel_fast_memset
.LBB1_2:                                # 
	xorl	%eax, %eax
	callq	getTimeStamp
	vmovsd	%xmm0, 24(%rsp)         # 8-byte Spill
	movl	$.L.str.1, %edi
	callq	likwid_markerStartRegion
	testl	%r13d, %r13d
	jle	.LBB1_8
# %bb.3:                                # 
	vmovsd	8(%rsp), %xmm0          # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	%xmm0, %xmm0, %xmm12
	movq	16(%r15), %rax
	movq	24(%r15), %rcx
	movq	%rcx, 8(%rsp)           # 8-byte Spill
	movslq	8(%r15), %rdx
	movq	16(%r12), %rsi
	movq	64(%r12), %rdi
	vmovsd	(%rsp), %xmm0           # 8-byte Reload
                                        # xmm0 = mem[0],zero
	vmulsd	.LCPI1_0(%rip), %xmm0, %xmm11
	movq	16(%rsp), %rcx          # 8-byte Reload
	vmovdqu	(%rcx), %xmm10
	shlq	$2, %rdx
	movq	%rdx, (%rsp)            # 8-byte Spill
	xorl	%r12d, %r12d
	jmp	.LBB1_4
	.p2align	4, 0x90
.LBB1_5:                                # 
                                        #   in Loop: Header=BB1_4 Depth=1
	vxorpd	%xmm13, %xmm13, %xmm13
	movq	%r9, %rdx
	vxorpd	%xmm9, %xmm9, %xmm9
	vxorpd	%xmm14, %xmm14, %xmm14
.LBB1_6:                                # 
                                        #   in Loop: Header=BB1_4 Depth=1
	vaddsd	(%rdi,%r15,8), %xmm14, %xmm0
	vmovsd	%xmm0, (%rdi,%r15,8)
	vaddsd	(%rdi,%r10,8), %xmm9, %xmm0
	vmovsd	%xmm0, (%rdi,%r10,8)
	vaddsd	(%rdi,%r11,8), %xmm13, %xmm0
	vmovsd	%xmm0, (%rdi,%r11,8)
	leal	3(%r9), %ecx
	addl	$6, %r9d
	testl	%ecx, %ecx
	cmovnsl	%ecx, %r9d
	sarl	$2, %r9d
	movslq	%r9d, %rcx
	vmovq	%rcx, %xmm0
	vmovq	%rdx, %xmm1
	vpunpcklqdq	%xmm0, %xmm1, %xmm0 # xmm0 = xmm1[0],xmm0[0]
	vpaddq	%xmm0, %xmm10, %xmm10
	incq	%r12
	addq	(%rsp), %rax            # 8-byte Folded Reload
	cmpq	%r13, %r12
	je	.LBB1_7
.LBB1_4:                                # 
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_10 Depth 2
	movq	8(%rsp), %rcx           # 8-byte Reload
	movslq	(%rcx,%r12,4), %r9
	leaq	(%r12,%r12,2), %rcx
	leal	1(%rcx), %r10d
	leal	2(%rcx), %r11d
	movl	%ecx, %r15d
	testq	%r9, %r9
	jle	.LBB1_5
# %bb.9:                                # 
                                        #   in Loop: Header=BB1_4 Depth=1
	vmovsd	(%rsi,%r15,8), %xmm15   # xmm15 = mem[0],zero
	vmovsd	(%rsi,%r10,8), %xmm4    # xmm4 = mem[0],zero
	vmovsd	(%rsi,%r11,8), %xmm1    # xmm1 = mem[0],zero
	movl	%r9d, %edx
	vxorpd	%xmm14, %xmm14, %xmm14
	xorl	%ecx, %ecx
	vxorpd	%xmm9, %xmm9, %xmm9
	vxorpd	%xmm13, %xmm13, %xmm13
	jmp	.LBB1_10
	.p2align	4, 0x90
.LBB1_13:                               # 
                                        #   in Loop: Header=BB1_10 Depth=2
	incq	%rcx
	cmpq	%rcx, %rdx
	je	.LBB1_6
.LBB1_10:                               # 
                                        #   Parent Loop BB1_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	(%rax,%rcx,4), %r8
	leaq	(%r8,%r8,2), %r14
	vsubsd	(%rsi,%r14,8), %xmm15, %xmm2
	movslq	%r14d, %rbp
	vsubsd	8(%rsi,%rbp,8), %xmm4, %xmm5
	vsubsd	16(%rsi,%rbp,8), %xmm1, %xmm0
	vmulsd	%xmm2, %xmm2, %xmm6
	vfmadd231sd	%xmm5, %xmm5, %xmm6 # xmm6 = (xmm5 * xmm5) + xmm6
	vfmadd231sd	%xmm0, %xmm0, %xmm6 # xmm6 = (xmm0 * xmm0) + xmm6
	vucomisd	%xmm12, %xmm6
	jae	.LBB1_13
# %bb.11:                               # 
                                        #   in Loop: Header=BB1_10 Depth=2
	vmovsd	.LCPI1_1(%rip), %xmm3   # xmm3 = mem[0],zero
	vdivsd	%xmm6, %xmm3, %xmm6
	vmulsd	32(%rsp), %xmm6, %xmm3  # 8-byte Folded Reload
	vmulsd	%xmm6, %xmm6, %xmm8
	vmulsd	%xmm3, %xmm8, %xmm3
	vaddsd	.LCPI1_2(%rip), %xmm3, %xmm7
	vmulsd	%xmm6, %xmm11, %xmm6
	vmulsd	%xmm3, %xmm6, %xmm3
	vmulsd	%xmm7, %xmm3, %xmm3
	vmulsd	%xmm2, %xmm3, %xmm6
	vaddsd	%xmm6, %xmm14, %xmm14
	vmulsd	%xmm5, %xmm3, %xmm2
	vaddsd	%xmm2, %xmm9, %xmm9
	vmulsd	%xmm0, %xmm3, %xmm0
	vaddsd	%xmm0, %xmm13, %xmm13
	cmpl	%r13d, %r8d
	jge	.LBB1_13
# %bb.12:                               # 
                                        #   in Loop: Header=BB1_10 Depth=2
	leaq	1(%rbp), %rbx
	addq	$2, %rbp
	vmovsd	(%rdi,%r14,8), %xmm3    # xmm3 = mem[0],zero
	vsubsd	%xmm6, %xmm3, %xmm3
	vmovsd	%xmm3, (%rdi,%r14,8)
	vmovsd	(%rdi,%rbx,8), %xmm3    # xmm3 = mem[0],zero
	vsubsd	%xmm2, %xmm3, %xmm2
	vmovsd	%xmm2, (%rdi,%rbx,8)
	vmovsd	(%rdi,%rbp,8), %xmm2    # xmm2 = mem[0],zero
	vsubsd	%xmm0, %xmm2, %xmm0
	vmovsd	%xmm0, (%rdi,%rbp,8)
	jmp	.LBB1_13
.LBB1_7:                                # 
	movq	16(%rsp), %rax          # 8-byte Reload
	vmovdqu	%xmm10, (%rax)
.LBB1_8:                                # 
	movl	$.L.str.1, %edi
	callq	likwid_markerStopRegion
	xorl	%eax, %eax
	callq	getTimeStamp
	vsubsd	24(%rsp), %xmm0, %xmm0  # 8-byte Folded Reload
	addq	$40, %rsp
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
	.size	computeForceLJHalfNeigh, .Lfunc_end1-computeForceLJHalfNeigh
	.cfi_endproc
                                        # -- End function
	.globl	computeForceLJFullNeigh_simd # -- Begin function computeForceLJFullNeigh_simd
	.p2align	4, 0x90
	.type	computeForceLJFullNeigh_simd,@function
computeForceLJFullNeigh_simd:           # 
.LcomputeForceLJFullNeigh_simd$local:
	.cfi_startproc
# %bb.0:                                # 
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	4(%rsi), %eax
	testl	%eax, %eax
	jle	.LBB2_2
# %bb.1:                                # 
	movq	64(%rsi), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rdx
	xorl	%esi, %esi
	callq	_intel_fast_memset
.LBB2_2:                                # 
	xorl	%eax, %eax
	callq	getTimeStamp
	movq	stderr(%rip), %rcx
	movl	$.L.str.2, %edi
	movl	$65, %esi
	movl	$1, %edx
	callq	fwrite
	movl	$-1, %edi
	callq	exit
.Lfunc_end2:
	.size	computeForceLJFullNeigh_simd, .Lfunc_end2-computeForceLJFullNeigh_simd
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object          # 
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"force"
	.size	.L.str, 6
	.type	.L.str.1,@object        # 
.L.str.1:
	.asciz	"forceLJ-halfneigh"
	.size	.L.str.1, 18
	.type	.L.str.2,@object        # 
.L.str.2:
	.asciz	"Error: SIMD kernel not implemented for specified instruction set!"
	.size	.L.str.2, 66
	.ident	"Intel(R) oneAPI DPC++ Compiler 2021.1-beta05 (2020.2.0.0304)"
	.section	".note.GNU-stack","",@progbits
