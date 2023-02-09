# mark_description "Intel(R) C Intel(R) 64 Compiler Classic for applications running on Intel(R) 64, Version 2021.6.0 Build 2022";
# mark_description "0226_000000";
# mark_description "-I/apps/likwid/5.2.2/include -I././lammps/includes -I././common/includes -S -std=c11 -pedantic-errors -D_GNU";
# mark_description "_SOURCE -DLIKWID_PERFMON -DAOS -DPRECISION=2 -DCOMPUTE_STATS -DVECTOR_WIDTH=8 -D__SIMD_KERNEL__ -D__ISA_AVX5";
# mark_description "12__ -DENABLE_OMP_SIMD -DALIGNMENT=64 -restrict -Ofast -xCORE-AVX512 -qopt-zmm-usage=high -o build-lammps-IC";
# mark_description "C-AVX512-DP/force_lj.s";
	.file "force_lj.c"
	.text
..TXTST0:
.L_2__routine_start_computeForceLJFullNeigh_plain_c_0:
# -- Begin  computeForceLJFullNeigh_plain_c
	.text
# mark_begin;
       .align    16,0x90
	.globl computeForceLJFullNeigh_plain_c
# --- computeForceLJFullNeigh_plain_c(Parameter *, Atom *, Neighbor *, Stats *)
computeForceLJFullNeigh_plain_c:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %rcx
..B1.1:                         # Preds ..B1.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForceLJFullNeigh_plain_c.1:
..L2:
                                                          #23.104
        pushq     %rbp                                          #23.104
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #23.104
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #23.104
        pushq     %r13                                          #23.104
        pushq     %r14                                          #23.104
        pushq     %r15                                          #23.104
        pushq     %rbx                                          #23.104
        subq      $96, %rsp                                     #23.104
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
        movq      %rsi, %r13                                    #23.104
        vmovsd    144(%rdi), %xmm0                              #27.27
        movq      %rcx, %r14                                    #23.104
        vmovsd    56(%rdi), %xmm1                               #28.23
        movq      %rdx, %rbx                                    #23.104
        vmovsd    40(%rdi), %xmm2                               #29.24
        movl      4(%r13), %r15d                                #24.18
        vmovsd    %xmm0, 32(%rsp)                               #27.27[spill]
        vmovsd    %xmm1, 16(%rsp)                               #28.23[spill]
        vmovsd    %xmm2, 24(%rsp)                               #29.24[spill]
        testl     %r15d, %r15d                                  #32.24
        jle       ..B1.27       # Prob 50%                      #32.24
                                # LOE rbx r12 r13 r14 r15d
..B1.2:                         # Preds ..B1.1
                                # Execution count [5.00e-03]
        movq      64(%r13), %rdi                                #33.9
        lea       (%r15,%r15,2), %esi                           #24.18
        cmpl      $12, %esi                                     #32.5
        jle       ..B1.34       # Prob 0%                       #32.5
                                # LOE rbx rdi r12 r13 r14 esi r15d
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
        movslq    %r15d, %r15                                   #32.5
        xorl      %esi, %esi                                    #32.5
        lea       (%r15,%r15,2), %rdx                           #32.5
        shlq      $3, %rdx                                      #32.5
        call      __intel_skx_avx512_memset                     #32.5
                                # LOE rbx r12 r13 r14 r15
..B1.4:                         # Preds ..B1.3 ..B1.46 ..B1.39
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #38.16
        vzeroupper                                              #38.16
..___tag_value_computeForceLJFullNeigh_plain_c.13:
#       getTimeStamp()
        call      getTimeStamp                                  #38.16
..___tag_value_computeForceLJFullNeigh_plain_c.14:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.43:                        # Preds ..B1.4
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 40(%rsp)                               #38.16[spill]
                                # LOE rbx r12 r13 r14 r15
..B1.5:                         # Preds ..B1.43
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.0, %edi                         #39.5
..___tag_value_computeForceLJFullNeigh_plain_c.16:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #39.5
..___tag_value_computeForceLJFullNeigh_plain_c.17:
                                # LOE rbx r12 r13 r14 r15
..B1.6:                         # Preds ..B1.5
                                # Execution count [9.00e-01]
        vmovsd    32(%rsp), %xmm13                              #27.45[spill]
        xorl      %esi, %esi                                    #41.15
        vmovsd    24(%rsp), %xmm0                               #77.41[spill]
        xorl      %edi, %edi                                    #41.5
        vmulsd    %xmm13, %xmm13, %xmm14                        #27.45
        xorl      %eax, %eax                                    #41.5
        vmovdqu32 .L_2il0floatpacket.0(%rip), %ymm16            #56.9
        vmulsd    .L_2il0floatpacket.3(%rip), %xmm0, %xmm1      #77.41
        vmovdqu   .L_2il0floatpacket.1(%rip), %ymm15            #56.9
        vmovups   .L_2il0floatpacket.4(%rip), %zmm5             #77.54
        vbroadcastsd %xmm14, %zmm14                             #27.25
        vbroadcastsd 16(%rsp), %zmm13                           #28.21[spill]
        vbroadcastsd %xmm1, %zmm12                              #77.41
        movq      24(%rbx), %r11                                #43.25
        movq      64(%r13), %r10                                #89.9
        movq      16(%rbx), %r9                                 #42.19
        movslq    8(%rbx), %r8                                  #42.43
        shlq      $2, %r8                                       #25.5
        movq      16(%r13), %rbx                                #44.25
        movq      (%r14), %rdx                                  #93.9
        movq      8(%r14), %rcx                                 #94.9
        movq      %r10, 48(%rsp)                                #41.5[spill]
        movq      %r11, 56(%rsp)                                #41.5[spill]
        movq      %r15, 64(%rsp)                                #41.5[spill]
        movq      %r14, (%rsp)                                  #41.5[spill]
        movq      %r12, 8(%rsp)                                 #41.5[spill]
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0x88, 0xff, 0xff, 0xff, 0x22
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 ymm15 ymm16 zmm5 zmm12 zmm13 zmm14
..B1.7:                         # Preds ..B1.25 ..B1.6
                                # Execution count [5.00e+00]
        movq      56(%rsp), %r10                                #43.25[spill]
        vxorpd    %xmm24, %xmm24, %xmm24                        #47.22
        vmovapd   %xmm24, %xmm18                                #48.22
        movl      (%r10,%rdi,4), %r13d                          #43.25
        vmovapd   %xmm18, %xmm4                                 #49.22
        vmovsd    (%rax,%rbx), %xmm11                           #44.25
        vmovsd    8(%rax,%rbx), %xmm6                           #45.25
        vmovsd    16(%rax,%rbx), %xmm7                          #46.25
        testl     %r13d, %r13d                                  #56.28
        jle       ..B1.25       # Prob 50%                      #56.28
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r13d xmm4 xmm6 xmm7 xmm11 xmm18 xmm24 ymm15 ymm16 zmm5 zmm12 zmm13 zmm14
..B1.8:                         # Preds ..B1.7
                                # Execution count [4.50e+00]
        vpxord    %zmm10, %zmm10, %zmm10                        #47.22
        vmovaps   %zmm10, %zmm9                                 #48.22
        vmovaps   %zmm9, %zmm8                                  #49.22
        cmpl      $8, %r13d                                     #56.9
        jl        ..B1.33       # Prob 10%                      #56.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.9:                         # Preds ..B1.8
                                # Execution count [4.50e+00]
        cmpl      $1200, %r13d                                  #56.9
        jl        ..B1.32       # Prob 10%                      #56.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.10:                        # Preds ..B1.9
                                # Execution count [4.50e+00]
        movq      %r8, %r10                                     #42.43
        imulq     %rsi, %r10                                    #42.43
        addq      %r9, %r10                                     #25.5
        movq      %r10, %r12                                    #56.9
        andq      $63, %r12                                     #56.9
        testl     $3, %r12d                                     #56.9
        je        ..B1.12       # Prob 50%                      #56.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.11:                        # Preds ..B1.10
                                # Execution count [2.25e+00]
        xorl      %r12d, %r12d                                  #56.9
        jmp       ..B1.14       # Prob 100%                     #56.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.12:                        # Preds ..B1.10
                                # Execution count [2.25e+00]
        testl     %r12d, %r12d                                  #56.9
        je        ..B1.14       # Prob 50%                      #56.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.13:                        # Preds ..B1.12
                                # Execution count [2.50e+01]
        negl      %r12d                                         #56.9
        addl      $64, %r12d                                    #56.9
        shrl      $2, %r12d                                     #56.9
        cmpl      %r12d, %r13d                                  #56.9
        cmovl     %r13d, %r12d                                  #56.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.14:                        # Preds ..B1.11 ..B1.13 ..B1.12
                                # Execution count [5.00e+00]
        movl      %r13d, %r11d                                  #56.9
        subl      %r12d, %r11d                                  #56.9
        andl      $7, %r11d                                     #56.9
        negl      %r11d                                         #56.9
        addl      %r13d, %r11d                                  #56.9
        cmpl      $1, %r12d                                     #56.9
        jb        ..B1.18       # Prob 50%                      #56.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.15:                        # Preds ..B1.14
                                # Execution count [4.50e+00]
        vmovdqa32 %ymm16, %ymm4                                 #56.9
        xorl      %r15d, %r15d                                  #56.9
        vpbroadcastd %r12d, %ymm3                               #56.9
        vbroadcastsd %xmm11, %zmm2                              #44.23
        vbroadcastsd %xmm6, %zmm1                               #45.23
        vbroadcastsd %xmm7, %zmm0                               #46.23
        movslq    %r12d, %r14                                   #56.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r15 r11d r12d r13d xmm6 xmm7 xmm11 ymm3 ymm4 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
movl      $111, %ebx # OSACA START MARKER
.byte     100        # OSACA START MARKER
.byte     103        # OSACA START MARKER
.byte     144        # OSACA START MARKER
# LLVM-MCA-BEGIN
# pointer_increment=64 55c62179dea305ceefda0dbc87792a60
..B1.16:                        # Preds ..B1.16 ..B1.15
                                # Execution count [2.50e+01]
        vpcmpgtd  %ymm4, %ymm3, %k5                             #56.9
        vpaddd    %ymm15, %ymm4, %ymm4                          #56.9
        vmovdqu32 (%r10,%r15,4), %ymm17{%k5}{z}                 #57.21
        vpaddd    %ymm17, %ymm17, %ymm18                        #58.36
        addq      $8, %r15                                      #56.9
        vpaddd    %ymm18, %ymm17, %ymm19                        #58.36
        kmovw     %k5, %k2                                      #58.36
        kmovw     %k5, %k3                                      #58.36
        kmovw     %k5, %k1                                      #58.36
        vpxord    %zmm21, %zmm21, %zmm21                        #58.36
        vpxord    %zmm20, %zmm20, %zmm20                        #58.36
        vpxord    %zmm22, %zmm22, %zmm22                        #58.36
        vgatherdpd 8(%rbx,%ymm19,8), %zmm21{%k2}                #58.36
        vgatherdpd (%rbx,%ymm19,8), %zmm20{%k3}                 #58.36
        vgatherdpd 16(%rbx,%ymm19,8), %zmm22{%k1}               #58.36
        vsubpd    %zmm21, %zmm1, %zmm18                         #59.36
        vsubpd    %zmm20, %zmm2, %zmm17                         #58.36
        vsubpd    %zmm22, %zmm0, %zmm19                         #60.36
        vmulpd    %zmm18, %zmm18, %zmm31                        #61.49
        vfmadd231pd %zmm17, %zmm17, %zmm31                      #61.49
        vfmadd231pd %zmm19, %zmm19, %zmm31                      #61.63
        vrcp14pd  %zmm31, %zmm30                                #75.38
        vcmppd    $1, %zmm14, %zmm31, %k6{%k5}                  #71.22
        vfpclasspd $30, %zmm30, %k0                             #75.38
        vmovaps   %zmm31, %zmm23                                #75.38
        vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm30, %zmm23 #75.38
        knotw     %k0, %k4                                      #75.38
        vmulpd    %zmm23, %zmm23, %zmm24                        #75.38
        vfmadd213pd %zmm30, %zmm23, %zmm30{%k4}                 #75.38
        vfmadd213pd %zmm30, %zmm24, %zmm30{%k4}                 #75.38
        vmulpd    %zmm13, %zmm30, %zmm25                        #76.38
        vmulpd    %zmm12, %zmm30, %zmm27                        #77.54
        vmulpd    %zmm25, %zmm30, %zmm28                        #76.44
        vmulpd    %zmm28, %zmm30, %zmm26                        #76.50
        vfmsub213pd %zmm5, %zmm28, %zmm30                       #77.54
        vmulpd    %zmm27, %zmm26, %zmm29                        #77.61
        vmulpd    %zmm30, %zmm29, %zmm23                        #77.67
        vfmadd231pd %zmm17, %zmm23, %zmm10{%k6}                 #78.17
        vfmadd231pd %zmm18, %zmm23, %zmm9{%k6}                  #79.17
        vfmadd231pd %zmm19, %zmm23, %zmm8{%k6}                  #80.17
        cmpq      %r14, %r15                                    #56.9
        jb        ..B1.16       # Prob 82%                      #56.9
# LLVM-MCA-END
movl      $222, %ebx # OSACA END MARKER
.byte     100        # OSACA END MARKER
.byte     103        # OSACA END MARKER
.byte     144        # OSACA END MARKER
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r15 r11d r12d r13d xmm6 xmm7 xmm11 ymm3 ymm4 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.17:                        # Preds ..B1.16
                                # Execution count [4.50e+00]
        cmpl      %r12d, %r13d                                  #56.9
        je        ..B1.24       # Prob 10%                      #56.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.18:                        # Preds ..B1.17 ..B1.14 ..B1.32
                                # Execution count [2.50e+01]
        lea       8(%r12), %r10d                                #56.9
        cmpl      %r10d, %r11d                                  #56.9
        jl        ..B1.22       # Prob 50%                      #56.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.19:                        # Preds ..B1.18
                                # Execution count [4.50e+00]
        movq      %r8, %r10                                     #42.43
        imulq     %rsi, %r10                                    #42.43
        vbroadcastsd %xmm11, %zmm2                              #44.23
        vbroadcastsd %xmm6, %zmm1                               #45.23
        vbroadcastsd %xmm7, %zmm0                               #46.23
        movslq    %r12d, %r14                                   #56.9
        addq      %r9, %r10                                     #25.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r11d r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.20:                        # Preds ..B1.20 ..B1.19
                                # Execution count [2.50e+01]
        vmovdqu   (%r10,%r14,4), %ymm3                          #57.21
        addl      $8, %r12d                                     #56.9
        vpcmpeqb  %xmm0, %xmm0, %k2                             #58.36
        vpcmpeqb  %xmm0, %xmm0, %k3                             #58.36
        vpcmpeqb  %xmm0, %xmm0, %k1                             #58.36
        vpaddd    %ymm3, %ymm3, %ymm4                           #58.36
        vpaddd    %ymm4, %ymm3, %ymm17                          #58.36
        addq      $8, %r14                                      #56.9
        vpxord    %zmm19, %zmm19, %zmm19                        #58.36
        vpxord    %zmm18, %zmm18, %zmm18                        #58.36
        vpxord    %zmm20, %zmm20, %zmm20                        #58.36
        vgatherdpd 8(%rbx,%ymm17,8), %zmm19{%k2}                #58.36
        vgatherdpd (%rbx,%ymm17,8), %zmm18{%k3}                 #58.36
        vgatherdpd 16(%rbx,%ymm17,8), %zmm20{%k1}               #58.36
        vsubpd    %zmm19, %zmm1, %zmm30                         #59.36
        vsubpd    %zmm18, %zmm2, %zmm29                         #58.36
        vsubpd    %zmm20, %zmm0, %zmm3                          #60.36
        vmulpd    %zmm30, %zmm30, %zmm21                        #61.49
        vfmadd231pd %zmm29, %zmm29, %zmm21                      #61.49
        vfmadd231pd %zmm3, %zmm3, %zmm21                        #61.63
        vrcp14pd  %zmm21, %zmm28                                #75.38
        vcmppd    $1, %zmm14, %zmm21, %k5                       #71.22
        vfpclasspd $30, %zmm28, %k0                             #75.38
        vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm28, %zmm21 #75.38
        knotw     %k0, %k4                                      #75.38
        vmulpd    %zmm21, %zmm21, %zmm22                        #75.38
        vfmadd213pd %zmm28, %zmm21, %zmm28{%k4}                 #75.38
        vfmadd213pd %zmm28, %zmm22, %zmm28{%k4}                 #75.38
        vmulpd    %zmm13, %zmm28, %zmm23                        #76.38
        vmulpd    %zmm12, %zmm28, %zmm25                        #77.54
        vmulpd    %zmm23, %zmm28, %zmm26                        #76.44
        vmulpd    %zmm26, %zmm28, %zmm24                        #76.50
        vfmsub213pd %zmm5, %zmm26, %zmm28                       #77.54
        vmulpd    %zmm25, %zmm24, %zmm27                        #77.61
        vmulpd    %zmm28, %zmm27, %zmm31                        #77.67
        vfmadd231pd %zmm29, %zmm31, %zmm10{%k5}                 #78.17
        vfmadd231pd %zmm30, %zmm31, %zmm9{%k5}                  #79.17
        vfmadd231pd %zmm3, %zmm31, %zmm8{%k5}                   #80.17
        cmpl      %r11d, %r12d                                  #56.9
        jb        ..B1.20       # Prob 82%                      #56.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r11d r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.22:                        # Preds ..B1.20 ..B1.18 ..B1.33
                                # Execution count [5.00e+00]
        lea       1(%r11), %r10d                                #56.9
        cmpl      %r13d, %r10d                                  #56.9
        ja        ..B1.24       # Prob 50%                      #56.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.23:                        # Preds ..B1.22
                                # Execution count [2.50e+01]
        imulq     %r8, %rsi                                     #42.43
        vbroadcastsd %xmm7, %zmm17                              #46.23
        vbroadcastsd %xmm6, %zmm4                               #45.23
        vbroadcastsd %xmm11, %zmm2                              #44.23
        movl      %r13d, %r10d                                  #56.9
        addq      %r9, %rsi                                     #25.5
        subl      %r11d, %r10d                                  #56.9
        vpbroadcastd %r10d, %ymm7                               #56.9
        vpcmpgtd  %ymm16, %ymm7, %k5                            #56.9
        movslq    %r11d, %r11                                   #56.9
        kmovw     %k5, %k2                                      #58.36
        kmovw     %k5, %k3                                      #58.36
        kmovw     %k5, %k1                                      #58.36
        vmovdqu32 (%rsi,%r11,4), %ymm6{%k5}{z}                  #57.21
        vpaddd    %ymm6, %ymm6, %ymm0                           #58.36
        vpaddd    %ymm0, %ymm6, %ymm1                           #58.36
        vpxord    %zmm11, %zmm11, %zmm11                        #58.36
        vpxord    %zmm3, %zmm3, %zmm3                           #58.36
        vpxord    %zmm18, %zmm18, %zmm18                        #58.36
        vgatherdpd 8(%rbx,%ymm1,8), %zmm11{%k2}                 #58.36
        vgatherdpd (%rbx,%ymm1,8), %zmm3{%k3}                   #58.36
        vgatherdpd 16(%rbx,%ymm1,8), %zmm18{%k1}                #58.36
        vsubpd    %zmm11, %zmm4, %zmm29                         #59.36
        vsubpd    %zmm3, %zmm2, %zmm28                          #58.36
        vsubpd    %zmm18, %zmm17, %zmm31                        #60.36
        vmulpd    %zmm29, %zmm29, %zmm27                        #61.49
        vfmadd231pd %zmm28, %zmm28, %zmm27                      #61.49
        vfmadd231pd %zmm31, %zmm31, %zmm27                      #61.63
        vrcp14pd  %zmm27, %zmm26                                #75.38
        vcmppd    $1, %zmm14, %zmm27, %k6{%k5}                  #71.22
        vfpclasspd $30, %zmm26, %k0                             #75.38
        vmovaps   %zmm27, %zmm19                                #75.38
        vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm26, %zmm19 #75.38
        knotw     %k0, %k4                                      #75.38
        vmulpd    %zmm19, %zmm19, %zmm20                        #75.38
        vfmadd213pd %zmm26, %zmm19, %zmm26{%k4}                 #75.38
        vfmadd213pd %zmm26, %zmm20, %zmm26{%k4}                 #75.38
        vmulpd    %zmm13, %zmm26, %zmm21                        #76.38
        vmulpd    %zmm12, %zmm26, %zmm23                        #77.54
        vmulpd    %zmm21, %zmm26, %zmm24                        #76.44
        vmulpd    %zmm24, %zmm26, %zmm22                        #76.50
        vfmsub213pd %zmm5, %zmm24, %zmm26                       #77.54
        vmulpd    %zmm23, %zmm22, %zmm25                        #77.61
        vmulpd    %zmm26, %zmm25, %zmm30                        #77.67
        vfmadd231pd %zmm28, %zmm30, %zmm10{%k6}                 #78.17
        vfmadd231pd %zmm29, %zmm30, %zmm9{%k6}                  #79.17
        vfmadd231pd %zmm31, %zmm30, %zmm8{%k6}                  #80.17
                                # LOE rax rdx rcx rbx rdi r8 r9 r13d ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.24:                        # Preds ..B1.17 ..B1.23 ..B1.22
                                # Execution count [4.50e+00]
        vmovups   .L_2il0floatpacket.6(%rip), %zmm19            #49.22
        vpermd    %zmm8, %zmm19, %zmm0                          #49.22
        vpermd    %zmm9, %zmm19, %zmm6                          #48.22
        vpermd    %zmm10, %zmm19, %zmm20                        #47.22
        vaddpd    %zmm8, %zmm0, %zmm8                           #49.22
        vaddpd    %zmm9, %zmm6, %zmm9                           #48.22
        vaddpd    %zmm10, %zmm20, %zmm10                        #47.22
        vpermpd   $78, %zmm8, %zmm1                             #49.22
        vpermpd   $78, %zmm9, %zmm7                             #48.22
        vpermpd   $78, %zmm10, %zmm21                           #47.22
        vaddpd    %zmm1, %zmm8, %zmm2                           #49.22
        vaddpd    %zmm7, %zmm9, %zmm11                          #48.22
        vaddpd    %zmm21, %zmm10, %zmm22                        #47.22
        vpermpd   $177, %zmm2, %zmm3                            #49.22
        vpermpd   $177, %zmm11, %zmm17                          #48.22
        vpermpd   $177, %zmm22, %zmm23                          #47.22
        vaddpd    %zmm3, %zmm2, %zmm4                           #49.22
        vaddpd    %zmm17, %zmm11, %zmm18                        #48.22
        vaddpd    %zmm23, %zmm22, %zmm24                        #47.22
                                # LOE rax rdx rcx rbx rdi r8 r9 r13d xmm4 xmm18 xmm24 ymm15 ymm16 zmm5 zmm12 zmm13 zmm14
..B1.25:                        # Preds ..B1.24 ..B1.7
                                # Execution count [5.00e+00]
        movslq    %r13d, %r13                                   #93.9
        movq      48(%rsp), %rsi                                #89.9[spill]
        lea       7(%r13), %r10d                                #94.9
        sarl      $2, %r10d                                     #94.9
        addq      %r13, %rdx                                    #93.9
        shrl      $29, %r10d                                    #94.9
        vaddsd    (%rax,%rsi), %xmm24, %xmm0                    #89.9
        vaddsd    8(%rax,%rsi), %xmm18, %xmm1                   #90.9
        vaddsd    16(%rax,%rsi), %xmm4, %xmm2                   #91.9
        vmovsd    %xmm0, (%rax,%rsi)                            #89.9
        lea       7(%r10,%r13), %r11d                           #94.9
        sarl      $3, %r11d                                     #94.9
        vmovsd    %xmm1, 8(%rax,%rsi)                           #90.9
        vmovsd    %xmm2, 16(%rax,%rsi)                          #91.9
        addq      $24, %rax                                     #41.5
        movslq    %r11d, %r11                                   #94.9
        movslq    %edi, %rsi                                    #41.32
        incq      %rdi                                          #41.5
        addq      %r11, %rcx                                    #94.9
        incq      %rsi                                          #41.32
        cmpq      64(%rsp), %rdi                                #41.5[spill]
        jb        ..B1.7        # Prob 82%                      #41.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 ymm15 ymm16 zmm5 zmm12 zmm13 zmm14
..B1.26:                        # Preds ..B1.25
                                # Execution count [9.00e-01]
        movq      (%rsp), %r14                                  #[spill]
        movq      8(%rsp), %r12                                 #[spill]
	.cfi_restore 12
        movq      %rdx, (%r14)                                  #93.9
        movq      %rcx, 8(%r14)                                 #94.9
        jmp       ..B1.29       # Prob 100%                     #94.9
                                # LOE r12
..B1.27:                        # Preds ..B1.1
                                # Execution count [5.00e-01]
        xorl      %eax, %eax                                    #38.16
..___tag_value_computeForceLJFullNeigh_plain_c.33:
#       getTimeStamp()
        call      getTimeStamp                                  #38.16
..___tag_value_computeForceLJFullNeigh_plain_c.34:
                                # LOE r12 xmm0
..B1.44:                        # Preds ..B1.27
                                # Execution count [5.00e-01]
        vmovsd    %xmm0, 40(%rsp)                               #38.16[spill]
                                # LOE r12
..B1.28:                        # Preds ..B1.44
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.0, %edi                         #39.5
..___tag_value_computeForceLJFullNeigh_plain_c.36:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #39.5
..___tag_value_computeForceLJFullNeigh_plain_c.37:
                                # LOE r12
..B1.29:                        # Preds ..B1.26 ..B1.28
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.0, %edi                         #97.5
        vzeroupper                                              #97.5
..___tag_value_computeForceLJFullNeigh_plain_c.38:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #97.5
..___tag_value_computeForceLJFullNeigh_plain_c.39:
                                # LOE r12
..B1.30:                        # Preds ..B1.29
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #98.16
..___tag_value_computeForceLJFullNeigh_plain_c.40:
#       getTimeStamp()
        call      getTimeStamp                                  #98.16
..___tag_value_computeForceLJFullNeigh_plain_c.41:
                                # LOE r12 xmm0
..B1.31:                        # Preds ..B1.30
                                # Execution count [1.00e+00]
        vsubsd    40(%rsp), %xmm0, %xmm0                        #102.14[spill]
        addq      $96, %rsp                                     #102.14
	.cfi_restore 3
        popq      %rbx                                          #102.14
	.cfi_restore 15
        popq      %r15                                          #102.14
	.cfi_restore 14
        popq      %r14                                          #102.14
	.cfi_restore 13
        popq      %r13                                          #102.14
        movq      %rbp, %rsp                                    #102.14
        popq      %rbp                                          #102.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #102.14
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0x88, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B1.32:                        # Preds ..B1.9
                                # Execution count [4.50e-01]: Infreq
        movl      %r13d, %r11d                                  #56.9
        xorl      %r12d, %r12d                                  #56.9
        andl      $-8, %r11d                                    #56.9
        jmp       ..B1.18       # Prob 100%                     #56.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.33:                        # Preds ..B1.8
                                # Execution count [4.50e-01]: Infreq
        xorl      %r11d, %r11d                                  #56.9
        jmp       ..B1.22       # Prob 100%                     #56.9
	.cfi_restore 12
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.34:                        # Preds ..B1.2
                                # Execution count [1.00e+00]: Infreq
        cmpl      $8, %esi                                      #32.5
        jl        ..B1.40       # Prob 10%                      #32.5
                                # LOE rbx rdi r12 r13 r14 esi r15d
..B1.35:                        # Preds ..B1.34
                                # Execution count [1.00e+00]: Infreq
        movl      %esi, %eax                                    #32.5
        xorl      %ecx, %ecx                                    #32.5
        andl      $-8, %eax                                     #32.5
        movslq    %eax, %rdx                                    #32.5
        vpxord    %zmm0, %zmm0, %zmm0                           #33.22
                                # LOE rdx rcx rbx rdi r12 r13 r14 eax esi r15d zmm0
..B1.36:                        # Preds ..B1.36 ..B1.35
                                # Execution count [5.56e+00]: Infreq
        vmovupd   %zmm0, (%rdi,%rcx,8)                          #33.9
        addq      $8, %rcx                                      #32.5
        cmpq      %rdx, %rcx                                    #32.5
        jb        ..B1.36       # Prob 82%                      #32.5
                                # LOE rdx rcx rbx rdi r12 r13 r14 eax esi r15d zmm0
..B1.38:                        # Preds ..B1.36 ..B1.40
                                # Execution count [1.11e+00]: Infreq
        lea       1(%rax), %edx                                 #32.5
        cmpl      %esi, %edx                                    #32.5
        ja        ..B1.46       # Prob 50%                      #32.5
                                # LOE rbx rdi r12 r13 r14 eax esi r15d
..B1.39:                        # Preds ..B1.38
                                # Execution count [5.56e+00]: Infreq
        subl      %eax, %esi                                    #32.5
        vpbroadcastd %esi, %ymm0                                #32.5
        vpcmpgtd  .L_2il0floatpacket.0(%rip), %ymm0, %k1        #32.5
        movslq    %eax, %rax                                    #32.5
        movslq    %r15d, %r15                                   #32.5
        vpxord    %zmm1, %zmm1, %zmm1                           #33.22
        vmovupd   %zmm1, (%rdi,%rax,8){%k1}                     #33.9
        jmp       ..B1.4        # Prob 100%                     #33.9
                                # LOE rbx r12 r13 r14 r15
..B1.40:                        # Preds ..B1.34
                                # Execution count [1.00e-01]: Infreq
        xorl      %eax, %eax                                    #32.5
        jmp       ..B1.38       # Prob 100%                     #32.5
                                # LOE rbx rdi r12 r13 r14 eax esi r15d
..B1.46:                        # Preds ..B1.38
                                # Execution count [5.56e-01]: Infreq
        movslq    %r15d, %r15                                   #32.5
        jmp       ..B1.4        # Prob 100%                     #32.5
        .align    16,0x90
                                # LOE rbx r12 r13 r14 r15
	.cfi_endproc
# mark_end;
	.type	computeForceLJFullNeigh_plain_c,@function
	.size	computeForceLJFullNeigh_plain_c,.-computeForceLJFullNeigh_plain_c
..LNcomputeForceLJFullNeigh_plain_c.0:
	.data
# -- End  computeForceLJFullNeigh_plain_c
	.text
.L_2__routine_start_computeForceLJHalfNeigh_1:
# -- Begin  computeForceLJHalfNeigh
	.text
# mark_begin;
       .align    16,0x90
	.globl computeForceLJHalfNeigh
# --- computeForceLJHalfNeigh(Parameter *, Atom *, Neighbor *, Stats *)
computeForceLJHalfNeigh:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %rcx
..B2.1:                         # Preds ..B2.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForceLJHalfNeigh.58:
..L59:
                                                         #105.96
        pushq     %rbp                                          #105.96
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #105.96
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #105.96
        pushq     %r12                                          #105.96
        pushq     %r13                                          #105.96
        pushq     %r14                                          #105.96
        pushq     %r15                                          #105.96
        pushq     %rbx                                          #105.96
        subq      $88, %rsp                                     #105.96
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
        movq      %rsi, %rbx                                    #105.96
        vmovsd    144(%rdi), %xmm0                              #109.27
        movq      %rcx, %r13                                    #105.96
        vmovsd    56(%rdi), %xmm1                               #110.23
        vmovsd    40(%rdi), %xmm2                               #111.24
        movl      4(%rbx), %r15d                                #106.18
        movq      %rdx, 48(%rsp)                                #105.96[spill]
        movq      %rdi, 16(%rsp)                                #105.96[spill]
        vmovsd    %xmm0, 32(%rsp)                               #109.27[spill]
        vmovsd    %xmm1, 24(%rsp)                               #110.23[spill]
        vmovsd    %xmm2, 40(%rsp)                               #111.24[spill]
        testl     %r15d, %r15d                                  #114.24
        jle       ..B2.28       # Prob 50%                      #114.24
                                # LOE rbx r13 r15d
..B2.2:                         # Preds ..B2.1
                                # Execution count [5.00e-03]
        movq      64(%rbx), %rdi                                #115.9
        lea       (%r15,%r15,2), %esi                           #106.18
        cmpl      $12, %esi                                     #114.5
        jle       ..B2.36       # Prob 0%                       #114.5
                                # LOE rbx rdi r13 esi r15d
..B2.3:                         # Preds ..B2.2
                                # Execution count [1.00e+00]
        movslq    %r15d, %r14                                   #114.5
        xorl      %esi, %esi                                    #114.5
        lea       (%r14,%r14,2), %rdx                           #114.5
        shlq      $3, %rdx                                      #114.5
        call      __intel_skx_avx512_memset                     #114.5
                                # LOE rbx r13 r14 r15d
..B2.4:                         # Preds ..B2.3 ..B2.48 ..B2.41
                                # Execution count [1.00e+00]
        xorl      %r12d, %r12d                                  #120.22
        xorl      %eax, %eax                                    #121.16
        vzeroupper                                              #121.16
..___tag_value_computeForceLJHalfNeigh.73:
#       getTimeStamp()
        call      getTimeStamp                                  #121.16
..___tag_value_computeForceLJHalfNeigh.74:
                                # LOE rbx r13 r14 r12d r15d xmm0
..B2.45:                        # Preds ..B2.4
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 8(%rsp)                                #121.16[spill]
                                # LOE rbx r13 r14 r12d r15d
..B2.5:                         # Preds ..B2.45
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.1, %edi                         #122.5
..___tag_value_computeForceLJHalfNeigh.76:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #122.5
..___tag_value_computeForceLJHalfNeigh.77:
                                # LOE rbx r13 r14 r12d r15d
..B2.6:                         # Preds ..B2.5
                                # Execution count [9.00e-01]
        vmovsd    32(%rsp), %xmm9                               #109.45[spill]
        xorl      %edi, %edi                                    #124.15
        vmovsd    40(%rsp), %xmm0                               #161.41[spill]
        xorl      %r9d, %r9d                                    #124.5
        vmulsd    %xmm9, %xmm9, %xmm10                          #109.45
        vmovdqu   .L_2il0floatpacket.0(%rip), %ymm14            #143.9
        vmulsd    .L_2il0floatpacket.3(%rip), %xmm0, %xmm1      #161.41
        vmovdqu   .L_2il0floatpacket.1(%rip), %ymm13            #143.9
        vmovdqu   .L_2il0floatpacket.7(%rip), %ymm12            #146.36
        vmovdqu   .L_2il0floatpacket.8(%rip), %ymm11            #147.36
        vmovups   .L_2il0floatpacket.4(%rip), %zmm5             #161.54
        vpbroadcastd %r15d, %ymm4                               #106.18
        vbroadcastsd %xmm10, %zmm10                             #109.25
        vbroadcastsd 24(%rsp), %zmm9                            #110.21[spill]
        vbroadcastsd %xmm1, %zmm7                               #161.41
        movq      48(%rsp), %rax                                #125.19[spill]
        movq      16(%rbx), %r11                                #127.25
        movq      64(%rbx), %rdx                                #168.21
        movq      24(%rax), %r15                                #126.25
        movslq    8(%rax), %r8                                  #125.43
        movq      16(%rax), %r10                                #125.19
        xorl      %eax, %eax                                    #124.5
        shlq      $2, %r8                                       #107.5
        movq      (%r13), %rcx                                  #179.9
        movq      8(%r13), %rbx                                 #180.9
        movq      %r15, 56(%rsp)                                #124.5[spill]
        movq      %r14, 64(%rsp)                                #124.5[spill]
        movq      %r13, (%rsp)                                  #124.5[spill]
        vpxord    %zmm15, %zmm15, %zmm15                        #124.5
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r11 r12d ymm4 ymm11 ymm12 ymm13 ymm14 zmm5 zmm7 zmm9 zmm10 zmm15
..B2.7:                         # Preds ..B2.26 ..B2.6
                                # Execution count [5.00e+00]
        movq      56(%rsp), %r13                                #126.25[spill]
        vxorpd    %xmm27, %xmm27, %xmm27                        #130.22
        vmovapd   %xmm27, %xmm21                                #131.22
        movl      (%r13,%r9,4), %r13d                           #126.25
        addl      %r13d, %r12d                                  #138.9
        vmovsd    (%rax,%r11), %xmm1                            #127.25
        vmovapd   %xmm21, %xmm3                                 #132.22
        vmovsd    8(%rax,%r11), %xmm0                           #128.25
        vmovsd    16(%rax,%r11), %xmm2                          #129.25
        testl     %r13d, %r13d                                  #143.9
        jle       ..B2.26       # Prob 50%                      #143.9
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r11 r12d r13d xmm0 xmm1 xmm2 xmm3 xmm21 xmm27 ymm4 ymm11 ymm12 ymm13 ymm14 zmm5 zmm7 zmm9 zmm10 zmm15
..B2.8:                         # Preds ..B2.7
                                # Execution count [2.50e+00]
        jbe       ..B2.26       # Prob 50%                      #143.9
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r11 r12d r13d xmm0 xmm1 xmm2 xmm3 xmm21 xmm27 ymm4 ymm11 ymm12 ymm13 ymm14 zmm5 zmm7 zmm9 zmm10 zmm15
..B2.9:                         # Preds ..B2.8
                                # Execution count [2.25e+00]
        vmovaps   %zmm15, %zmm8                                 #130.22
        vmovaps   %zmm8, %zmm6                                  #131.22
        vmovaps   %zmm6, %zmm3                                  #132.22
        cmpl      $8, %r13d                                     #143.9
        jb        ..B2.35       # Prob 10%                      #143.9
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r11 r12d r13d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.10:                        # Preds ..B2.9
                                # Execution count [2.25e+00]
        cmpl      $1200, %r13d                                  #143.9
        jb        ..B2.34       # Prob 10%                      #143.9
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r11 r12d r13d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.11:                        # Preds ..B2.10
                                # Execution count [2.25e+00]
        movq      %r8, %rsi                                     #125.43
        imulq     %rdi, %rsi                                    #125.43
        addq      %r10, %rsi                                    #107.5
        movq      %rsi, %r14                                    #143.9
        andq      $63, %r14                                     #143.9
        testl     $3, %r14d                                     #143.9
        je        ..B2.13       # Prob 50%                      #143.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12d r13d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.12:                        # Preds ..B2.11
                                # Execution count [1.12e+00]
        movl      %r13d, %r15d                                  #143.9
        xorl      %r14d, %r14d                                  #143.9
        andl      $7, %r15d                                     #143.9
        negl      %r15d                                         #143.9
        addl      %r13d, %r15d                                  #143.9
        jmp       ..B2.19       # Prob 100%                     #143.9
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r11 r12d r13d r14d r15d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.13:                        # Preds ..B2.11
                                # Execution count [1.12e+00]
        testl     %r14d, %r14d                                  #143.9
        je        ..B2.18       # Prob 50%                      #143.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12d r13d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.14:                        # Preds ..B2.13
                                # Execution count [1.25e+01]
        negl      %r14d                                         #143.9
        movl      %r13d, %r15d                                  #143.9
        addl      $64, %r14d                                    #143.9
        shrl      $2, %r14d                                     #143.9
        cmpl      %r14d, %r13d                                  #143.9
        cmovb     %r13d, %r14d                                  #143.9
        subl      %r14d, %r15d                                  #143.9
        andl      $7, %r15d                                     #143.9
        negl      %r15d                                         #143.9
        addl      %r13d, %r15d                                  #143.9
        cmpl      $1, %r14d                                     #143.9
        jb        ..B2.19       # Prob 50%                      #143.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12d r13d r14d r15d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.15:                        # Preds ..B2.14
                                # Execution count [2.25e+00]
        vpbroadcastd %r14d, %ymm28                              #143.9
        vbroadcastsd %xmm1, %zmm27                              #127.23
        vbroadcastsd %xmm0, %zmm26                              #128.23
        vbroadcastsd %xmm2, %zmm25                              #129.23
        movslq    %r14d, %r14                                   #143.9
        movq      $0, 40(%rsp)                                  #143.9[spill]
        movq      %r9, 24(%rsp)                                 #143.9[spill]
        movq      %rdi, 32(%rsp)                                #143.9[spill]
        vmovdqa32 %ymm14, %ymm29                                #143.9
        movq      %r14, %rdi                                    #143.9
        movq      40(%rsp), %r9                                 #143.9[spill]
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12d r13d r14d r15d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 ymm28 ymm29 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15 zmm25 zmm26 zmm27
..B2.16:                        # Preds ..B2.16 ..B2.15
                                # Execution count [1.25e+01]
        vpcmpud   $1, %ymm28, %ymm29, %k4                       #143.9
        vpaddd    %ymm13, %ymm29, %ymm29                        #143.9
        vmovdqu32 (%rsi,%r9,4), %ymm21{%k4}{z}                  #144.21
        vpaddd    %ymm21, %ymm21, %ymm30                        #145.36
        addq      $8, %r9                                       #143.9
        vpcmpgtd  %ymm21, %ymm4, %k6                            #167.24
        vpaddd    %ymm30, %ymm21, %ymm24                        #145.36
        kmovw     %k4, %k2                                      #145.36
        kmovw     %k4, %k3                                      #145.36
        kmovw     %k4, %k1                                      #145.36
        vpxord    %zmm16, %zmm16, %zmm16                        #145.36
        vpxord    %zmm31, %zmm31, %zmm31                        #145.36
        vpxord    %zmm20, %zmm20, %zmm20                        #145.36
        vpaddd    %ymm12, %ymm24, %ymm17                        #146.36
        vgatherdpd 8(%r11,%ymm24,8), %zmm16{%k2}                #145.36
        vgatherdpd (%r11,%ymm24,8), %zmm31{%k3}                 #145.36
        vgatherdpd 16(%r11,%ymm24,8), %zmm20{%k1}               #145.36
        vsubpd    %zmm16, %zmm26, %zmm22                        #146.36
        vsubpd    %zmm31, %zmm27, %zmm23                        #145.36
        vsubpd    %zmm20, %zmm25, %zmm20                        #147.36
        vmulpd    %zmm22, %zmm22, %zmm18                        #148.49
        vpaddd    %ymm11, %ymm24, %ymm16                        #147.36
        vfmadd231pd %zmm23, %zmm23, %zmm18                      #148.49
        vfmadd231pd %zmm20, %zmm20, %zmm18                      #148.63
        vrcp14pd  %zmm18, %zmm19                                #159.38
        vcmppd    $1, %zmm10, %zmm18, %k7{%k4}                  #158.22
        vfpclasspd $30, %zmm19, %k0                             #159.38
        vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm19, %zmm18 #159.38
        knotw     %k0, %k5                                      #159.38
        kandw     %k6, %k7, %k6                                 #167.24
        vmulpd    %zmm18, %zmm18, %zmm21                        #159.38
        vfmadd213pd %zmm19, %zmm18, %zmm19{%k5}                 #159.38
        vfmadd213pd %zmm19, %zmm21, %zmm19{%k5}                 #159.38
        vmulpd    %zmm9, %zmm19, %zmm30                         #160.38
        vmulpd    %zmm30, %zmm19, %zmm18                        #160.44
        vmulpd    %zmm18, %zmm19, %zmm31                        #160.50
        vfmsub213pd %zmm5, %zmm19, %zmm18                       #161.54
        vmulpd    %zmm7, %zmm19, %zmm19                         #161.54
        vmulpd    %zmm19, %zmm31, %zmm19                        #161.61
        vmulpd    %zmm18, %zmm19, %zmm21                        #161.67
        vmovaps   %zmm15, %zmm18                                #168.21
        kmovw     %k6, %k1                                      #168.21
        vfmadd231pd %zmm23, %zmm21, %zmm8{%k7}                  #162.17
        vfmadd231pd %zmm22, %zmm21, %zmm6{%k7}                  #163.17
        vfmadd231pd %zmm20, %zmm21, %zmm3{%k7}                  #164.17
        .byte     144                                           #168.21
        vgatherdpd (%rdx,%ymm24,8), %zmm18{%k1}                 #168.21
        vfnmadd213pd %zmm18, %zmm21, %zmm23                     #168.21
        kmovw     %k6, %k2                                      #168.21
        vscatterdpd %zmm23, (%rdx,%ymm24,8){%k2}                #168.21
        vmovaps   %zmm15, %zmm23                                #169.21
        kmovw     %k6, %k3                                      #169.21
        kmovw     %k6, %k4                                      #169.21
        kmovw     %k6, %k5                                      #170.21
        vgatherdpd (%rdx,%ymm17,8), %zmm23{%k3}                 #169.21
        vfnmadd213pd %zmm23, %zmm21, %zmm22                     #169.21
        vscatterdpd %zmm22, (%rdx,%ymm17,8){%k4}                #169.21
        vmovaps   %zmm15, %zmm17                                #170.21
        vgatherdpd (%rdx,%ymm16,8), %zmm17{%k5}                 #170.21
        vfnmadd213pd %zmm17, %zmm21, %zmm20                     #170.21
        vscatterdpd %zmm20, (%rdx,%ymm16,8){%k6}                #170.21
        cmpq      %rdi, %r9                                     #143.9
        jb        ..B2.16       # Prob 82%                      #143.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12d r13d r14d r15d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 ymm28 ymm29 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15 zmm25 zmm26 zmm27
..B2.17:                        # Preds ..B2.16
                                # Execution count [2.25e+00]
        movq      24(%rsp), %r9                                 #[spill]
        movq      32(%rsp), %rdi                                #[spill]
        cmpl      %r14d, %r13d                                  #143.9
        je        ..B2.25       # Prob 10%                      #143.9
        jmp       ..B2.19       # Prob 100%                     #143.9
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r11 r12d r13d r14d r15d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.18:                        # Preds ..B2.13
                                # Execution count [5.62e-01]
        movl      %r13d, %r15d                                  #143.9
        andl      $7, %r15d                                     #143.9
        negl      %r15d                                         #143.9
        addl      %r13d, %r15d                                  #143.9
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r11 r12d r13d r14d r15d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.19:                        # Preds ..B2.12 ..B2.18 ..B2.17 ..B2.14 ..B2.34
                                #      
                                # Execution count [1.25e+01]
        lea       8(%r14), %esi                                 #143.9
        cmpl      %esi, %r15d                                   #143.9
        jb        ..B2.23       # Prob 50%                      #143.9
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r11 r12d r13d r14d r15d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.20:                        # Preds ..B2.19
                                # Execution count [2.25e+00]
        movq      %r8, %rsi                                     #125.43
        imulq     %rdi, %rsi                                    #125.43
        vbroadcastsd %xmm1, %zmm26                              #127.23
        vbroadcastsd %xmm0, %zmm25                              #128.23
        vbroadcastsd %xmm2, %zmm23                              #129.23
        movslq    %r14d, %r14                                   #143.9
        addq      %r10, %rsi                                    #107.5
        movq      %rdi, 32(%rsp)                                #107.5[spill]
        movq      %r14, %rdi                                    #107.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12d r13d r14d r15d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15 zmm23 zmm25 zmm26
..B2.21:                        # Preds ..B2.21 ..B2.20
                                # Execution count [1.25e+01]
        vmovdqu32 (%rsi,%rdi,4), %ymm24                         #144.21
        addl      $8, %r14d                                     #143.9
        vpcmpeqb  %xmm0, %xmm0, %k2                             #145.36
        vpcmpeqb  %xmm0, %xmm0, %k3                             #145.36
        vpcmpeqb  %xmm0, %xmm0, %k1                             #145.36
        vpcmpgtd  %ymm24, %ymm4, %k6                            #167.24
        vpaddd    %ymm24, %ymm24, %ymm27                        #145.36
        vpaddd    %ymm27, %ymm24, %ymm20                        #145.36
        addq      $8, %rdi                                      #143.9
        vpxord    %zmm29, %zmm29, %zmm29                        #145.36
        vpxord    %zmm28, %zmm28, %zmm28                        #145.36
        vpxord    %zmm30, %zmm30, %zmm30                        #145.36
        vpaddd    %ymm20, %ymm12, %ymm21                        #146.36
        vpaddd    %ymm20, %ymm11, %ymm18                        #147.36
        vgatherdpd 8(%r11,%ymm20,8), %zmm29{%k2}                #145.36
        vgatherdpd (%r11,%ymm20,8), %zmm28{%k3}                 #145.36
        vgatherdpd 16(%r11,%ymm20,8), %zmm30{%k1}               #145.36
        vsubpd    %zmm29, %zmm25, %zmm19                        #146.36
        vsubpd    %zmm28, %zmm26, %zmm22                        #145.36
        vsubpd    %zmm30, %zmm23, %zmm17                        #147.36
        vmulpd    %zmm19, %zmm19, %zmm31                        #148.49
        vfmadd231pd %zmm22, %zmm22, %zmm31                      #148.49
        vfmadd231pd %zmm17, %zmm17, %zmm31                      #148.63
        vrcp14pd  %zmm31, %zmm16                                #159.38
        vcmppd    $1, %zmm10, %zmm31, %k5                       #158.22
        vfpclasspd $30, %zmm16, %k0                             #159.38
        vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm16, %zmm31 #159.38
        knotw     %k0, %k4                                      #159.38
        vmulpd    %zmm31, %zmm31, %zmm27                        #159.38
        vfmadd213pd %zmm16, %zmm31, %zmm16{%k4}                 #159.38
        vfmadd213pd %zmm16, %zmm27, %zmm16{%k4}                 #159.38
        vmulpd    %zmm9, %zmm16, %zmm28                         #160.38
        vmulpd    %zmm7, %zmm16, %zmm24                         #161.54
        vmulpd    %zmm28, %zmm16, %zmm30                        #160.44
        vmulpd    %zmm30, %zmm16, %zmm29                        #160.50
        vfmsub213pd %zmm5, %zmm30, %zmm16                       #161.54
        vmulpd    %zmm24, %zmm29, %zmm31                        #161.61
        vmulpd    %zmm16, %zmm31, %zmm24                        #161.67
        vfmadd231pd %zmm22, %zmm24, %zmm8{%k5}                  #162.17
        vfmadd231pd %zmm19, %zmm24, %zmm6{%k5}                  #163.17
        vfmadd231pd %zmm17, %zmm24, %zmm3{%k5}                  #164.17
        kandw     %k6, %k5, %k5                                 #167.24
        vmovaps   %zmm15, %zmm16                                #168.21
        kmovw     %k5, %k7                                      #168.21
        kmovw     %k5, %k1                                      #168.21
        kmovw     %k5, %k2                                      #169.21
        kmovw     %k5, %k3                                      #169.21
        kmovw     %k5, %k4                                      #170.21
        vgatherdpd (%rdx,%ymm20,8), %zmm16{%k7}                 #168.21
        vfnmadd213pd %zmm16, %zmm24, %zmm22                     #168.21
        vscatterdpd %zmm22, (%rdx,%ymm20,8){%k1}                #168.21
        vmovaps   %zmm15, %zmm20                                #169.21
        vgatherdpd (%rdx,%ymm21,8), %zmm20{%k2}                 #169.21
        vfnmadd213pd %zmm20, %zmm24, %zmm19                     #169.21
        vscatterdpd %zmm19, (%rdx,%ymm21,8){%k3}                #169.21
        vmovaps   %zmm15, %zmm19                                #170.21
        vgatherdpd (%rdx,%ymm18,8), %zmm19{%k4}                 #170.21
        vfnmadd213pd %zmm19, %zmm24, %zmm17                     #170.21
        vscatterdpd %zmm17, (%rdx,%ymm18,8){%k5}                #170.21
        cmpl      %r15d, %r14d                                  #143.9
        jb        ..B2.21       # Prob 82%                      #143.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12d r13d r14d r15d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15 zmm23 zmm25 zmm26
..B2.22:                        # Preds ..B2.21
                                # Execution count [2.25e+00]
        movq      32(%rsp), %rdi                                #[spill]
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r11 r12d r13d r15d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.23:                        # Preds ..B2.22 ..B2.19 ..B2.35
                                # Execution count [2.50e+00]
        lea       1(%r15), %r14d                                #143.9
        cmpl      %r13d, %r14d                                  #143.9
        ja        ..B2.25       # Prob 50%                      #143.9
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r11 r12d r13d r15d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.24:                        # Preds ..B2.23
                                # Execution count [1.25e+01]
        imulq     %r8, %rdi                                     #125.43
        vbroadcastsd %xmm0, %zmm24                              #128.23
        vbroadcastsd %xmm1, %zmm22                              #127.23
        vbroadcastsd %xmm2, %zmm26                              #129.23
        movl      %r13d, %r14d                                  #143.9
        addq      %r10, %rdi                                    #107.5
        subl      %r15d, %r14d                                  #143.9
        vpbroadcastd %r14d, %ymm20                              #143.9
        vpcmpud   $1, %ymm20, %ymm14, %k5                       #143.9
        movslq    %r15d, %r15                                   #143.9
        kmovw     %k5, %k2                                      #145.36
        kmovw     %k5, %k3                                      #145.36
        kmovw     %k5, %k1                                      #145.36
        vmovdqu32 (%rdi,%r15,4), %ymm19{%k5}{z}                 #144.21
        vpaddd    %ymm19, %ymm19, %ymm21                        #145.36
        vpcmpgtd  %ymm19, %ymm4, %k7                            #167.24
        vpaddd    %ymm21, %ymm19, %ymm18                        #145.36
        vmovaps   %zmm15, %zmm19                                #168.21
        vpxord    %zmm25, %zmm25, %zmm25                        #145.36
        vpxord    %zmm23, %zmm23, %zmm23                        #145.36
        vpxord    %zmm27, %zmm27, %zmm27                        #145.36
        vpaddd    %ymm18, %ymm12, %ymm16                        #146.36
        vpaddd    %ymm18, %ymm11, %ymm0                         #147.36
        vgatherdpd 8(%r11,%ymm18,8), %zmm25{%k2}                #145.36
        vgatherdpd (%r11,%ymm18,8), %zmm23{%k3}                 #145.36
        vgatherdpd 16(%r11,%ymm18,8), %zmm27{%k1}               #145.36
        vsubpd    %zmm25, %zmm24, %zmm1                         #146.36
        vsubpd    %zmm23, %zmm22, %zmm17                        #145.36
        vsubpd    %zmm27, %zmm26, %zmm2                         #147.36
        vmulpd    %zmm1, %zmm1, %zmm21                          #148.49
        vfmadd231pd %zmm17, %zmm17, %zmm21                      #148.49
        vfmadd231pd %zmm2, %zmm2, %zmm21                        #148.63
        vrcp14pd  %zmm21, %zmm20                                #159.38
        vcmppd    $1, %zmm10, %zmm21, %k6{%k5}                  #158.22
        vfpclasspd $30, %zmm20, %k0                             #159.38
        vmovaps   %zmm21, %zmm28                                #159.38
        vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm20, %zmm28 #159.38
        knotw     %k0, %k4                                      #159.38
        vmulpd    %zmm28, %zmm28, %zmm29                        #159.38
        vfmadd213pd %zmm20, %zmm28, %zmm20{%k4}                 #159.38
        vfmadd213pd %zmm20, %zmm29, %zmm20{%k4}                 #159.38
        vmulpd    %zmm9, %zmm20, %zmm30                         #160.38
        vmulpd    %zmm7, %zmm20, %zmm28                         #161.54
        vmulpd    %zmm30, %zmm20, %zmm29                        #160.44
        vmulpd    %zmm29, %zmm20, %zmm31                        #160.50
        vfmsub213pd %zmm5, %zmm29, %zmm20                       #161.54
        vmulpd    %zmm28, %zmm31, %zmm30                        #161.61
        vmulpd    %zmm20, %zmm30, %zmm22                        #161.67
        vfmadd231pd %zmm17, %zmm22, %zmm8{%k6}                  #162.17
        vfmadd231pd %zmm1, %zmm22, %zmm6{%k6}                   #163.17
        vfmadd231pd %zmm2, %zmm22, %zmm3{%k6}                   #164.17
        kandw     %k7, %k6, %k6                                 #167.24
        kmovw     %k6, %k1                                      #168.21
        kmovw     %k6, %k2                                      #168.21
        kmovw     %k6, %k3                                      #169.21
        kmovw     %k6, %k4                                      #169.21
        kmovw     %k6, %k5                                      #170.21
        vgatherdpd (%rdx,%ymm18,8), %zmm19{%k1}                 #168.21
        vfnmadd213pd %zmm19, %zmm22, %zmm17                     #168.21
        vscatterdpd %zmm17, (%rdx,%ymm18,8){%k2}                #168.21
        vmovaps   %zmm15, %zmm17                                #169.21
        vgatherdpd (%rdx,%ymm16,8), %zmm17{%k3}                 #169.21
        vfnmadd213pd %zmm17, %zmm22, %zmm1                      #169.21
        vscatterdpd %zmm1, (%rdx,%ymm16,8){%k4}                 #169.21
        vmovaps   %zmm15, %zmm1                                 #170.21
        vgatherdpd (%rdx,%ymm0,8), %zmm1{%k5}                   #170.21
        vfnmadd213pd %zmm1, %zmm22, %zmm2                       #170.21
        vscatterdpd %zmm2, (%rdx,%ymm0,8){%k6}                  #170.21
                                # LOE rax rdx rcx rbx r8 r9 r10 r11 r12d r13d ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.25:                        # Preds ..B2.17 ..B2.24 ..B2.23
                                # Execution count [2.25e+00]
        vmovups   .L_2il0floatpacket.6(%rip), %zmm22            #132.22
        vpermd    %zmm3, %zmm22, %zmm0                          #132.22
        vpermd    %zmm6, %zmm22, %zmm17                         #131.22
        vpermd    %zmm8, %zmm22, %zmm23                         #130.22
        vaddpd    %zmm3, %zmm0, %zmm3                           #132.22
        vaddpd    %zmm6, %zmm17, %zmm6                          #131.22
        vaddpd    %zmm8, %zmm23, %zmm8                          #130.22
        vpermpd   $78, %zmm3, %zmm1                             #132.22
        vpermpd   $78, %zmm6, %zmm18                            #131.22
        vpermpd   $78, %zmm8, %zmm24                            #130.22
        vaddpd    %zmm1, %zmm3, %zmm2                           #132.22
        vaddpd    %zmm18, %zmm6, %zmm19                         #131.22
        vaddpd    %zmm24, %zmm8, %zmm25                         #130.22
        vpermpd   $177, %zmm2, %zmm16                           #132.22
        vpermpd   $177, %zmm19, %zmm20                          #131.22
        vpermpd   $177, %zmm25, %zmm26                          #130.22
        vaddpd    %zmm16, %zmm2, %zmm3                          #132.22
        vaddpd    %zmm20, %zmm19, %zmm21                        #131.22
        vaddpd    %zmm26, %zmm25, %zmm27                        #130.22
                                # LOE rax rdx rcx rbx r8 r9 r10 r11 r12d r13d xmm3 xmm21 xmm27 ymm4 ymm11 ymm12 ymm13 ymm14 zmm5 zmm7 zmm9 zmm10 zmm15
..B2.26:                        # Preds ..B2.25 ..B2.8 ..B2.7
                                # Execution count [5.00e+00]
        movslq    %r13d, %r13                                   #179.9
        vaddsd    (%rax,%rdx), %xmm27, %xmm0                    #175.9
        vaddsd    8(%rax,%rdx), %xmm21, %xmm1                   #176.9
        vaddsd    16(%rax,%rdx), %xmm3, %xmm2                   #177.9
        vmovsd    %xmm0, (%rax,%rdx)                            #175.9
        lea       7(%r13), %edi                                 #180.9
        sarl      $2, %edi                                      #180.9
        addq      %r13, %rcx                                    #179.9
        shrl      $29, %edi                                     #180.9
        vmovsd    %xmm1, 8(%rax,%rdx)                           #176.9
        vmovsd    %xmm2, 16(%rax,%rdx)                          #177.9
        addq      $24, %rax                                     #124.5
        lea       7(%rdi,%r13), %r14d                           #180.9
        movslq    %r9d, %rdi                                    #124.32
        sarl      $3, %r14d                                     #180.9
        incq      %r9                                           #124.5
        movslq    %r14d, %r14                                   #180.9
        incq      %rdi                                          #124.32
        addq      %r14, %rbx                                    #180.9
        cmpq      64(%rsp), %r9                                 #124.5[spill]
        jb        ..B2.7        # Prob 82%                      #124.5
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r11 r12d ymm4 ymm11 ymm12 ymm13 ymm14 zmm5 zmm7 zmm9 zmm10 zmm15
..B2.27:                        # Preds ..B2.26
                                # Execution count [9.00e-01]
        movq      (%rsp), %r13                                  #[spill]
        movq      %rcx, (%r13)                                  #179.9
        movq      %rbx, 8(%r13)                                 #180.9
        jmp       ..B2.30       # Prob 100%                     #180.9
                                # LOE r12d
..B2.28:                        # Preds ..B2.1
                                # Execution count [5.00e-01]
        xorl      %r12d, %r12d                                  #120.22
        xorl      %eax, %eax                                    #121.16
..___tag_value_computeForceLJHalfNeigh.96:
#       getTimeStamp()
        call      getTimeStamp                                  #121.16
..___tag_value_computeForceLJHalfNeigh.97:
                                # LOE r12d xmm0
..B2.46:                        # Preds ..B2.28
                                # Execution count [5.00e-01]
        vmovsd    %xmm0, 8(%rsp)                                #121.16[spill]
                                # LOE r12d
..B2.29:                        # Preds ..B2.46
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.1, %edi                         #122.5
..___tag_value_computeForceLJHalfNeigh.99:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #122.5
..___tag_value_computeForceLJHalfNeigh.100:
                                # LOE r12d
..B2.30:                        # Preds ..B2.27 ..B2.29
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.1, %edi                         #183.5
        vzeroupper                                              #183.5
..___tag_value_computeForceLJHalfNeigh.101:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #183.5
..___tag_value_computeForceLJHalfNeigh.102:
                                # LOE r12d
..B2.31:                        # Preds ..B2.30
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #184.16
..___tag_value_computeForceLJHalfNeigh.103:
#       getTimeStamp()
        call      getTimeStamp                                  #184.16
..___tag_value_computeForceLJHalfNeigh.104:
                                # LOE r12d xmm0
..B2.32:                        # Preds ..B2.31
                                # Execution count [1.00e+00]
        vxorpd    %xmm4, %xmm4, %xmm4                           #185.5
        movl      $.L_2__STRING.2, %edi                         #185.5
        vmovsd    .L_2il0floatpacket.9(%rip), %xmm3             #185.5
        movl      %r12d, %esi                                   #185.5
        movq      16(%rsp), %rax                                #185.74[spill]
        vsubsd    8(%rsp), %xmm0, %xmm1                         #185.94[spill]
        vmovsd    264(%rax), %xmm7                              #185.74
        movl      $3, %eax                                      #185.5
        vcvtusi2sdl %r12d, %xmm4, %xmm4                         #185.5
        vdivsd    %xmm4, %xmm3, %xmm5                           #185.5
        vmulsd    %xmm1, %xmm5, %xmm6                           #185.5
        vmulsd    %xmm7, %xmm6, %xmm2                           #185.5
        vmovapd   %xmm7, %xmm0                                  #185.5
        vmovsd    %xmm1, (%rsp)                                 #185.5[spill]
..___tag_value_computeForceLJHalfNeigh.107:
#       printf(const char *__restrict__, ...)
        call      printf                                        #185.5
..___tag_value_computeForceLJHalfNeigh.108:
                                # LOE
..B2.33:                        # Preds ..B2.32
                                # Execution count [1.00e+00]
        vmovsd    (%rsp), %xmm1                                 #[spill]
        vmovapd   %xmm1, %xmm0                                  #186.14
        addq      $88, %rsp                                     #186.14
	.cfi_restore 3
        popq      %rbx                                          #186.14
	.cfi_restore 15
        popq      %r15                                          #186.14
	.cfi_restore 14
        popq      %r14                                          #186.14
	.cfi_restore 13
        popq      %r13                                          #186.14
	.cfi_restore 12
        popq      %r12                                          #186.14
        movq      %rbp, %rsp                                    #186.14
        popq      %rbp                                          #186.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #186.14
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B2.34:                        # Preds ..B2.10
                                # Execution count [2.25e-01]: Infreq
        movl      %r13d, %r15d                                  #143.9
        xorl      %r14d, %r14d                                  #143.9
        andl      $-8, %r15d                                    #143.9
        jmp       ..B2.19       # Prob 100%                     #143.9
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r11 r12d r13d r14d r15d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.35:                        # Preds ..B2.9
                                # Execution count [2.25e-01]: Infreq
        xorl      %r15d, %r15d                                  #143.9
        jmp       ..B2.23       # Prob 100%                     #143.9
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r11 r12d r13d r15d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.36:                        # Preds ..B2.2
                                # Execution count [1.00e+00]: Infreq
        cmpl      $8, %esi                                      #114.5
        jl        ..B2.42       # Prob 10%                      #114.5
                                # LOE rbx rdi r13 esi r15d
..B2.37:                        # Preds ..B2.36
                                # Execution count [1.00e+00]: Infreq
        movl      %esi, %eax                                    #114.5
        xorl      %ecx, %ecx                                    #114.5
        andl      $-8, %eax                                     #114.5
        movslq    %eax, %rdx                                    #114.5
        vpxord    %zmm0, %zmm0, %zmm0                           #114.5
                                # LOE rdx rcx rbx rdi r13 eax esi r15d zmm0
..B2.38:                        # Preds ..B2.38 ..B2.37
                                # Execution count [5.56e+00]: Infreq
        vmovupd   %zmm0, (%rdi,%rcx,8)                          #115.9
        addq      $8, %rcx                                      #114.5
        cmpq      %rdx, %rcx                                    #114.5
        jb        ..B2.38       # Prob 82%                      #114.5
                                # LOE rdx rcx rbx rdi r13 eax esi r15d zmm0
..B2.40:                        # Preds ..B2.38 ..B2.42
                                # Execution count [1.11e+00]: Infreq
        lea       1(%rax), %edx                                 #114.5
        cmpl      %esi, %edx                                    #114.5
        ja        ..B2.48       # Prob 50%                      #114.5
                                # LOE rbx rdi r13 eax esi r15d
..B2.41:                        # Preds ..B2.40
                                # Execution count [5.56e+00]: Infreq
        subl      %eax, %esi                                    #114.5
        vpbroadcastd %esi, %ymm0                                #114.5
        vpcmpgtd  .L_2il0floatpacket.0(%rip), %ymm0, %k1        #114.5
        movslq    %eax, %rax                                    #114.5
        movslq    %r15d, %r14                                   #114.5
        vpxord    %zmm1, %zmm1, %zmm1                           #115.9
        vmovupd   %zmm1, (%rdi,%rax,8){%k1}                     #115.9
        jmp       ..B2.4        # Prob 100%                     #115.9
                                # LOE rbx r13 r14 r15d
..B2.42:                        # Preds ..B2.36
                                # Execution count [1.00e-01]: Infreq
        xorl      %eax, %eax                                    #114.5
        jmp       ..B2.40       # Prob 100%                     #114.5
                                # LOE rbx rdi r13 eax esi r15d
..B2.48:                        # Preds ..B2.40
                                # Execution count [5.56e-01]: Infreq
        movslq    %r15d, %r14                                   #114.5
        jmp       ..B2.4        # Prob 100%                     #114.5
        .align    16,0x90
                                # LOE rbx r13 r14 r15d
	.cfi_endproc
# mark_end;
	.type	computeForceLJHalfNeigh,@function
	.size	computeForceLJHalfNeigh,.-computeForceLJHalfNeigh
..LNcomputeForceLJHalfNeigh.1:
	.data
# -- End  computeForceLJHalfNeigh
	.text
.L_2__routine_start_computeForceLJFullNeigh_simd_2:
# -- Begin  computeForceLJFullNeigh_simd
	.text
# mark_begin;
       .align    16,0x90
	.globl computeForceLJFullNeigh_simd
# --- computeForceLJFullNeigh_simd(Parameter *, Atom *, Neighbor *, Stats *)
computeForceLJFullNeigh_simd:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %rcx
..B3.1:                         # Preds ..B3.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForceLJFullNeigh_simd.126:
..L127:
                                                        #189.101
        pushq     %rbp                                          #189.101
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #189.101
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #189.101
        pushq     %r12                                          #189.101
        pushq     %r13                                          #189.101
        pushq     %r14                                          #189.101
        pushq     %r15                                          #189.101
        pushq     %rbx                                          #189.101
        subq      $216, %rsp                                    #189.101
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
        movq      %rdi, %rbx                                    #189.101
        movq      %rsi, %r13                                    #189.101
        movq      %rdx, %r12                                    #189.101
        vmovsd    144(%rbx), %xmm0                              #192.27
        vmovsd    56(%rbx), %xmm1                               #193.23
        vmovsd    40(%rbx), %xmm2                               #194.24
        movl      4(%r13), %r14d                                #190.18
        vmovsd    %xmm0, 16(%rsp)                               #192.27[spill]
        vmovsd    %xmm1, 8(%rsp)                                #193.23[spill]
        vmovsd    %xmm2, (%rsp)                                 #194.24[spill]
        testl     %r14d, %r14d                                  #196.24
        jle       ..B3.9        # Prob 50%                      #196.24
                                # LOE rbx r12 r13 r14d
..B3.2:                         # Preds ..B3.1
                                # Execution count [1.00e+00]
        movl      %r14d, %ecx                                   #196.5
        xorl      %edx, %edx                                    #196.5
        movl      $1, %esi                                      #196.5
        xorl      %eax, %eax                                    #196.5
        shrl      $1, %ecx                                      #196.5
        je        ..B3.6        # Prob 9%                       #196.5
                                # LOE rax rdx rcx rbx r12 r13 esi r14d
..B3.3:                         # Preds ..B3.2
                                # Execution count [9.00e-01]
        xorl      %r15d, %r15d                                  #196.5
        .align    16,0x90
                                # LOE rax rdx rcx rbx r12 r13 r15 r14d
..B3.4:                         # Preds ..B3.4 ..B3.3
                                # Execution count [2.50e+00]
        movq      64(%r13), %rsi                                #197.9
        incq      %rdx                                          #196.5
        movq      %r15, (%rsi,%rax)                             #197.9
        movq      64(%r13), %rdi                                #198.9
        movq      %r15, 8(%rdi,%rax)                            #198.9
        movq      64(%r13), %r8                                 #199.9
        movq      %r15, 16(%r8,%rax)                            #199.9
        movq      64(%r13), %r9                                 #197.9
        movq      %r15, 24(%r9,%rax)                            #197.9
        movq      64(%r13), %r10                                #198.9
        movq      %r15, 32(%r10,%rax)                           #198.9
        movq      64(%r13), %r11                                #199.9
        movq      %r15, 40(%r11,%rax)                           #199.9
        addq      $48, %rax                                     #196.5
        cmpq      %rcx, %rdx                                    #196.5
        jb        ..B3.4        # Prob 63%                      #196.5
                                # LOE rax rdx rcx rbx r12 r13 r15 r14d
..B3.5:                         # Preds ..B3.4
                                # Execution count [9.00e-01]
        lea       1(%rdx,%rdx), %esi                            #197.9
                                # LOE rbx r12 r13 esi r14d
..B3.6:                         # Preds ..B3.5 ..B3.2
                                # Execution count [1.00e+00]
        lea       -1(%rsi), %eax                                #196.5
        cmpl      %r14d, %eax                                   #196.5
        jae       ..B3.9        # Prob 9%                       #196.5
                                # LOE rbx r12 r13 esi r14d
..B3.7:                         # Preds ..B3.6
                                # Execution count [9.00e-01]
        movslq    %esi, %rsi                                    #197.9
        xorl      %ecx, %ecx                                    #197.9
        movq      64(%r13), %rax                                #197.9
        lea       (%rsi,%rsi,2), %r8                            #197.9
        movq      %rcx, -24(%rax,%r8,8)                         #197.9
        movq      64(%r13), %rdx                                #198.9
        movq      %rcx, -16(%rdx,%r8,8)                         #198.9
        movq      64(%r13), %rdi                                #199.9
        movq      %rcx, -8(%rdi,%r8,8)                          #199.9
                                # LOE rbx r12 r13 r14d
..B3.9:                         # Preds ..B3.7 ..B3.6 ..B3.1
                                # Execution count [5.00e-01]
        xorl      %eax, %eax                                    #203.16
..___tag_value_computeForceLJFullNeigh_simd.139:
#       getTimeStamp()
        call      getTimeStamp                                  #203.16
..___tag_value_computeForceLJFullNeigh_simd.140:
                                # LOE rbx r12 r13 r14d xmm0
..B3.26:                        # Preds ..B3.9
                                # Execution count [5.00e-01]
        vmovsd    %xmm0, 192(%rsp)                              #203.16[spill]
                                # LOE rbx r12 r13 r14d
..B3.10:                        # Preds ..B3.26
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.0, %edi                         #204.5
        xorl      %r15d, %r15d                                  #204.5
..___tag_value_computeForceLJFullNeigh_simd.142:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #204.5
..___tag_value_computeForceLJFullNeigh_simd.143:
                                # LOE rbx r12 r13 r14d r15d
..B3.11:                        # Preds ..B3.10
                                # Execution count [1.00e+00]
        vmovsd    16(%rsp), %xmm0                               #210.36[spill]
        xorl      %edi, %edi                                    #217.9
        vmulsd    %xmm0, %xmm0, %xmm1                           #210.36
        xorl      %r11d, %r11d                                  #216.5
        vbroadcastsd 8(%rsp), %zmm10                            #211.32[spill]
        vbroadcastsd (%rsp), %zmm9                              #212.29[spill]
        vbroadcastsd %xmm1, %zmm11                              #210.36
        vbroadcastsd .L_2il0floatpacket.3(%rip), %zmm8          #213.29
        vbroadcastsd .L_2il0floatpacket.10(%rip), %zmm13        #214.29
        xorl      %edx, %edx                                    #217.9
        testl     %r14d, %r14d                                  #216.24
        jle       ..B3.19       # Prob 9%                       #216.24
                                # LOE rdx rbx rdi r12 r13 r11d r14d r15d zmm8 zmm9 zmm10 zmm11 zmm13
..B3.12:                        # Preds ..B3.11
                                # Execution count [9.00e-01]
        vmovdqu   .L_2il0floatpacket.11(%rip), %ymm12           #230.101
        vmovups   .L_2il0floatpacket.6(%rip), %zmm0             #253.23
        vpxord    %zmm1, %zmm1, %zmm1                           #223.29
                                # LOE rdx rbx rdi r12 r13 r11d r14d r15d ymm12 zmm0 zmm1 zmm8 zmm9 zmm10 zmm11 zmm13
..B3.13:                        # Preds ..B3.17 ..B3.12
                                # Execution count [5.00e+00]
        movl      %r11d, %r8d                                   #217.43
        xorl      %r10d, %r10d                                  #228.9
        imull     8(%r12), %r8d                                 #217.43
        movslq    %r8d, %r8                                     #217.19
        movq      24(%r12), %rcx                                #218.25
        movq      16(%r12), %rax                                #217.19
        movq      16(%r13), %r9                                 #220.45
        vmovaps   %zmm1, %zmm3                                  #223.29
        vmovaps   %zmm3, %zmm2                                  #224.29
        lea       (%rax,%r8,4), %r8                             #217.19
        movl      (%rcx,%rdi,4), %ecx                           #218.25
        addl      %ecx, %r15d                                   #227.9
        vmovaps   %zmm2, %zmm7                                  #225.29
        xorl      %eax, %eax                                    #230.78
        vpbroadcastd %ecx, %ymm6                                #219.37
        vbroadcastsd (%r9,%rdx,8), %zmm5                        #220.30
        vbroadcastsd 8(%r9,%rdx,8), %zmm4                       #221.30
        vbroadcastsd 16(%r9,%rdx,8), %zmm14                     #222.30
        testl     %ecx, %ecx                                    #228.28
        jle       ..B3.17       # Prob 10%                      #228.28
                                # LOE rdx rbx rdi r8 r9 r12 r13 eax ecx r10d r11d r14d r15d ymm6 ymm12 zmm0 zmm1 zmm2 zmm3 zmm4 zmm5 zmm7 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B3.14:                        # Preds ..B3.13
                                # Execution count [4.50e+00]
        addl      $7, %ecx                                      #218.25
        shrl      $3, %ecx                                      #218.25
                                # LOE rdx rbx rdi r8 r9 r12 r13 eax ecx r10d r11d r14d r15d ymm6 ymm12 zmm0 zmm1 zmm2 zmm3 zmm4 zmm5 zmm7 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B3.15:                        # Preds ..B3.15 ..B3.14
                                # Execution count [2.50e+01]
        vpbroadcastd %eax, %ymm15                               #230.78
        incl      %r10d                                         #228.9
        vpcmpeqb  %xmm0, %xmm0, %k4                             #236.41
        vpcmpeqb  %xmm0, %xmm0, %k3                             #235.41
        vpcmpeqb  %xmm0, %xmm0, %k2                             #234.41
        vpaddd    %ymm12, %ymm15, %ymm16                        #230.65
        vpcmpgtd  %ymm16, %ymm6, %k1                            #230.43
        movslq    %eax, %rax                                    #231.29
        kmovw     %k1, %esi                                     #230.43
        kmovb     %esi, %k5                                     #243.40
        vmovdqu32 (%r8,%rax,4), %ymm18{%k1}{z}                  #231.29
        addl      $8, %eax                                      #228.9
        vpaddd    %ymm18, %ymm18, %ymm17                        #233.43
        vpaddd    %ymm18, %ymm17, %ymm19                        #233.30
        vpxord    %zmm22, %zmm22, %zmm22                        #236.41
        vpxord    %zmm21, %zmm21, %zmm21                        #235.41
        vpxord    %zmm20, %zmm20, %zmm20                        #234.41
        vgatherdpd 16(%r9,%ymm19,8), %zmm22{%k4}                #236.41
        vgatherdpd 8(%r9,%ymm19,8), %zmm21{%k3}                 #235.41
        vgatherdpd (%r9,%ymm19,8), %zmm20{%k2}                  #234.41
        vsubpd    %zmm22, %zmm14, %zmm16                        #236.41
        vsubpd    %zmm21, %zmm4, %zmm15                         #235.41
        vsubpd    %zmm20, %zmm5, %zmm31                         #234.41
        vmulpd    %zmm16, %zmm16, %zmm23                        #242.75
        vfmadd231pd %zmm15, %zmm15, %zmm23                      #242.54
        vfmadd231pd %zmm31, %zmm31, %zmm23                      #242.33
        vrcp14pd  %zmm23, %zmm25                                #244.33
        vcmppd    $17, %zmm11, %zmm23, %k0                      #243.70
        vmulpd    %zmm10, %zmm25, %zmm24                        #245.61
        vmulpd    %zmm9, %zmm25, %zmm27                         #246.100
        kmovw     %k0, %esi                                     #243.70
        vmulpd    %zmm24, %zmm25, %zmm26                        #245.47
        vmulpd    %zmm26, %zmm25, %zmm28                        #245.33
        vfmsub213pd %zmm13, %zmm25, %zmm26                      #246.76
        vmulpd    %zmm27, %zmm26, %zmm29                        #246.67
        vmulpd    %zmm29, %zmm28, %zmm30                        #246.53
        vmulpd    %zmm30, %zmm8, %zmm23                         #246.35
        kmovb     %esi, %k6                                     #243.40
        kandb     %k6, %k5, %k7                                 #243.40
        kmovb     %k7, %esi                                     #243.40
        kmovw     %esi, %k1                                     #248.19
        vfmadd231pd %zmm31, %zmm23, %zmm3{%k1}                  #248.19
        vfmadd231pd %zmm15, %zmm23, %zmm2{%k1}                  #249.19
        vfmadd231pd %zmm16, %zmm23, %zmm7{%k1}                  #250.19
        cmpl      %ecx, %r10d                                   #228.9
        jb        ..B3.15       # Prob 82%                      #228.9
                                # LOE rdx rbx rdi r8 r9 r12 r13 eax ecx r10d r11d r14d r15d ymm6 ymm12 zmm0 zmm1 zmm2 zmm3 zmm4 zmm5 zmm7 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B3.17:                        # Preds ..B3.15 ..B3.13
                                # Execution count [5.00e+00]
        vpermd    %zmm3, %zmm0, %zmm4                           #253.23
        incl      %r11d                                         #216.5
        vpermd    %zmm2, %zmm0, %zmm16                          #254.23
        vpermd    %zmm7, %zmm0, %zmm21                          #255.23
        vaddpd    %zmm3, %zmm4, %zmm5                           #253.23
        vaddpd    %zmm2, %zmm16, %zmm17                         #254.23
        vaddpd    %zmm7, %zmm21, %zmm22                         #255.23
        vshuff64x2 $17, %zmm5, %zmm5, %zmm3                     #253.23
        vshuff64x2 $17, %zmm17, %zmm17, %zmm2                   #254.23
        vshuff64x2 $17, %zmm22, %zmm22, %zmm7                   #255.23
        vaddpd    %zmm5, %zmm3, %zmm14                          #253.23
        vaddpd    %zmm17, %zmm2, %zmm19                         #254.23
        vaddpd    %zmm22, %zmm7, %zmm24                         #255.23
        vpermilpd $1, %zmm14, %zmm6                             #253.23
        incq      %rdi                                          #216.5
        vaddpd    %zmm14, %zmm6, %zmm15                         #253.23
        vmovups   %zmm15, (%rsp)                                #253.23
        movq      64(%r13), %rax                                #253.9
        vpermilpd $1, %zmm19, %zmm18                            #254.23
        vaddpd    %zmm19, %zmm18, %zmm20                        #254.23
        vmovsd    (%rax,%rdx,8), %xmm26                         #253.9
        vaddsd    (%rsp), %xmm26, %xmm27                        #253.9
        vmovups   %zmm20, 64(%rsp)                              #254.23
        vmovsd    %xmm27, (%rax,%rdx,8)                         #253.9
        movq      64(%r13), %rcx                                #254.9
        vpermilpd $1, %zmm24, %zmm23                            #255.23
        vaddpd    %zmm24, %zmm23, %zmm25                        #255.23
        vmovsd    8(%rcx,%rdx,8), %xmm28                        #254.9
        vaddsd    64(%rsp), %xmm28, %xmm29                      #254.9
        vmovups   %zmm25, 128(%rsp)                             #255.23
        vmovsd    %xmm29, 8(%rcx,%rdx,8)                        #254.9
        movq      64(%r13), %r8                                 #255.9
        vmovsd    16(%r8,%rdx,8), %xmm30                        #255.9
        vaddsd    128(%rsp), %xmm30, %xmm31                     #255.9
        vmovsd    %xmm31, 16(%r8,%rdx,8)                        #255.9
        addq      $3, %rdx                                      #216.5
        cmpl      %r14d, %r11d                                  #216.5
        jb        ..B3.13       # Prob 82%                      #216.5
                                # LOE rdx rbx rdi r12 r13 r11d r14d r15d ymm12 zmm0 zmm1 zmm8 zmm9 zmm10 zmm11 zmm13
..B3.19:                        # Preds ..B3.17 ..B3.11
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.0, %edi                         #259.5
        vzeroupper                                              #259.5
..___tag_value_computeForceLJFullNeigh_simd.147:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #259.5
..___tag_value_computeForceLJFullNeigh_simd.148:
                                # LOE rbx r15d
..B3.20:                        # Preds ..B3.19
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #260.16
..___tag_value_computeForceLJFullNeigh_simd.149:
#       getTimeStamp()
        call      getTimeStamp                                  #260.16
..___tag_value_computeForceLJFullNeigh_simd.150:
                                # LOE rbx r15d xmm0
..B3.21:                        # Preds ..B3.20
                                # Execution count [1.00e+00]
        vxorpd    %xmm4, %xmm4, %xmm4                           #261.5
        movl      $.L_2__STRING.3, %edi                         #261.5
        vmovsd    .L_2il0floatpacket.9(%rip), %xmm3             #261.5
        movl      %r15d, %esi                                   #261.5
        vmovsd    264(%rbx), %xmm7                              #261.68
        movl      $3, %eax                                      #261.5
        vsubsd    192(%rsp), %xmm0, %xmm1                       #261.88[spill]
        vcvtusi2sdl %r15d, %xmm4, %xmm4                         #261.5
        vdivsd    %xmm4, %xmm3, %xmm5                           #261.5
        vmulsd    %xmm1, %xmm5, %xmm6                           #261.5
        vmulsd    %xmm7, %xmm6, %xmm2                           #261.5
        vmovapd   %xmm7, %xmm0                                  #261.5
        vmovsd    %xmm1, (%rsp)                                 #261.5[spill]
..___tag_value_computeForceLJFullNeigh_simd.152:
#       printf(const char *__restrict__, ...)
        call      printf                                        #261.5
..___tag_value_computeForceLJFullNeigh_simd.153:
                                # LOE
..B3.22:                        # Preds ..B3.21
                                # Execution count [1.00e+00]
        vmovsd    (%rsp), %xmm1                                 #[spill]
        vmovapd   %xmm1, %xmm0                                  #262.14
        addq      $216, %rsp                                    #262.14
	.cfi_restore 3
        popq      %rbx                                          #262.14
	.cfi_restore 15
        popq      %r15                                          #262.14
	.cfi_restore 14
        popq      %r14                                          #262.14
	.cfi_restore 13
        popq      %r13                                          #262.14
	.cfi_restore 12
        popq      %r12                                          #262.14
        movq      %rbp, %rsp                                    #262.14
        popq      %rbp                                          #262.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #262.14
        .align    16,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	computeForceLJFullNeigh_simd,@function
	.size	computeForceLJFullNeigh_simd,.-computeForceLJFullNeigh_simd
..LNcomputeForceLJFullNeigh_simd.2:
	.data
# -- End  computeForceLJFullNeigh_simd
	.section .rodata, "a"
	.align 64
	.align 64
.L_2il0floatpacket.2:
	.long	0x00000000,0x3ff00000,0x00000000,0x3ff00000,0x00000000,0x3ff00000,0x00000000,0x3ff00000,0x00000000,0x3ff00000,0x00000000,0x3ff00000,0x00000000,0x3ff00000,0x00000000,0x3ff00000
	.type	.L_2il0floatpacket.2,@object
	.size	.L_2il0floatpacket.2,64
	.align 64
.L_2il0floatpacket.4:
	.long	0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000
	.type	.L_2il0floatpacket.4,@object
	.size	.L_2il0floatpacket.4,64
	.align 64
.L_2il0floatpacket.6:
	.long	0x00000008,0x00000009,0x0000000a,0x0000000b,0x0000000c,0x0000000d,0x0000000e,0x0000000f,0x00000008,0x00000009,0x0000000a,0x0000000b,0x0000000c,0x0000000d,0x0000000e,0x0000000f
	.type	.L_2il0floatpacket.6,@object
	.size	.L_2il0floatpacket.6,64
	.align 32
.L_2il0floatpacket.0:
	.long	0x00000000,0x00000001,0x00000002,0x00000003,0x00000004,0x00000005,0x00000006,0x00000007
	.type	.L_2il0floatpacket.0,@object
	.size	.L_2il0floatpacket.0,32
	.align 32
.L_2il0floatpacket.1:
	.long	0x00000008,0x00000008,0x00000008,0x00000008,0x00000008,0x00000008,0x00000008,0x00000008
	.type	.L_2il0floatpacket.1,@object
	.size	.L_2il0floatpacket.1,32
	.align 32
.L_2il0floatpacket.7:
	.long	0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001
	.type	.L_2il0floatpacket.7,@object
	.size	.L_2il0floatpacket.7,32
	.align 32
.L_2il0floatpacket.8:
	.long	0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002
	.type	.L_2il0floatpacket.8,@object
	.size	.L_2il0floatpacket.8,32
	.align 32
.L_2il0floatpacket.11:
	.long	0x00000000,0x00000001,0x00000002,0x00000003,0x00000004,0x00000005,0x00000006,0x00000007
	.type	.L_2il0floatpacket.11,@object
	.size	.L_2il0floatpacket.11,32
	.align 8
.L_2il0floatpacket.3:
	.long	0x00000000,0x40480000
	.type	.L_2il0floatpacket.3,@object
	.size	.L_2il0floatpacket.3,8
	.align 8
.L_2il0floatpacket.5:
	.long	0x00000000,0x3ff00000
	.type	.L_2il0floatpacket.5,@object
	.size	.L_2il0floatpacket.5,8
	.align 8
.L_2il0floatpacket.9:
	.long	0x00000000,0x41cdcd65
	.type	.L_2il0floatpacket.9,@object
	.size	.L_2il0floatpacket.9,8
	.align 8
.L_2il0floatpacket.10:
	.long	0x00000000,0x3fe00000
	.type	.L_2il0floatpacket.10,@object
	.size	.L_2il0floatpacket.10,8
	.section .rodata.str1.4, "aMS",@progbits,1
	.align 4
	.align 4
.L_2__STRING.0:
	.long	1668444006
	.word	101
	.type	.L_2__STRING.0,@object
	.size	.L_2__STRING.0,6
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.1:
	.long	1668444006
	.long	759843941
	.long	1718378856
	.long	1734960494
	.word	104
	.type	.L_2__STRING.1,@object
	.size	.L_2__STRING.1,18
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.2:
	.long	980644937
	.long	544548128
	.long	1701987872
	.long	622869105
	.long	1411391590
	.long	979725673
	.long	174466336
	.long	1764718915
	.long	622869108
	.long	1747460198
	.long	761687137
	.long	1734960494
	.long	665960
	.type	.L_2__STRING.2,@object
	.size	.L_2__STRING.2,52
	.align 4
.L_2__STRING.3:
	.long	980644937
	.long	544548128
	.long	1701987872
	.long	622869105
	.long	1411391590
	.long	979725673
	.long	174466336
	.long	1764718915
	.long	622869108
	.long	1932009574
	.long	694447465
	.word	10
	.type	.L_2__STRING.3,@object
	.size	.L_2__STRING.3,46
	.data
	.section .note.GNU-stack, ""
# End
