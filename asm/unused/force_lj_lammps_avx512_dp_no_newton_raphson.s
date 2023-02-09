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
                                                          #21.104
        pushq     %rbp                                          #21.104
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #21.104
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #21.104
        pushq     %r13                                          #21.104
        pushq     %r14                                          #21.104
        pushq     %r15                                          #21.104
        pushq     %rbx                                          #21.104
        subq      $96, %rsp                                     #21.104
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
        movq      %rsi, %r13                                    #21.104
        vmovsd    144(%rdi), %xmm0                              #25.27
        movq      %rcx, %r14                                    #21.104
        vmovsd    56(%rdi), %xmm1                               #26.23
        movq      %rdx, %rbx                                    #21.104
        vmovsd    40(%rdi), %xmm2                               #27.24
        movl      4(%r13), %r15d                                #22.18
        vmovsd    %xmm0, 32(%rsp)                               #25.27[spill]
        vmovsd    %xmm1, 16(%rsp)                               #26.23[spill]
        vmovsd    %xmm2, 24(%rsp)                               #27.24[spill]
        testl     %r15d, %r15d                                  #30.24
        jle       ..B1.27       # Prob 50%                      #30.24
                                # LOE rbx r12 r13 r14 r15d
..B1.2:                         # Preds ..B1.1
                                # Execution count [5.00e-03]
        movq      64(%r13), %rdi                                #31.9
        lea       (%r15,%r15,2), %esi                           #22.18
        cmpl      $12, %esi                                     #30.5
        jle       ..B1.34       # Prob 0%                       #30.5
                                # LOE rbx rdi r12 r13 r14 esi r15d
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
        movslq    %r15d, %r15                                   #30.5
        xorl      %esi, %esi                                    #30.5
        lea       (%r15,%r15,2), %rdx                           #30.5
        shlq      $3, %rdx                                      #30.5
        call      __intel_skx_avx512_memset                     #30.5
                                # LOE rbx r12 r13 r14 r15
..B1.4:                         # Preds ..B1.3 ..B1.46 ..B1.39
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #36.16
        vzeroupper                                              #36.16
..___tag_value_computeForceLJFullNeigh_plain_c.13:
#       getTimeStamp()
        call      getTimeStamp                                  #36.16
..___tag_value_computeForceLJFullNeigh_plain_c.14:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.43:                        # Preds ..B1.4
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 40(%rsp)                               #36.16[spill]
                                # LOE rbx r12 r13 r14 r15
..B1.5:                         # Preds ..B1.43
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.0, %edi                         #37.5
..___tag_value_computeForceLJFullNeigh_plain_c.16:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #37.5
..___tag_value_computeForceLJFullNeigh_plain_c.17:
                                # LOE rbx r12 r13 r14 r15
..B1.6:                         # Preds ..B1.5
                                # Execution count [9.00e-01]
        vmovsd    32(%rsp), %xmm13                              #25.45[spill]
        xorl      %esi, %esi                                    #40.15
        vmovsd    24(%rsp), %xmm0                               #72.41[spill]
        xorl      %edi, %edi                                    #40.5
        vmulsd    %xmm13, %xmm13, %xmm14                        #25.45
        xorl      %eax, %eax                                    #40.5
        vmovdqu32 .L_2il0floatpacket.0(%rip), %ymm16            #54.9
        vmulsd    .L_2il0floatpacket.3(%rip), %xmm0, %xmm1      #72.41
        vmovdqu   .L_2il0floatpacket.1(%rip), %ymm15            #54.9
        vmovups   .L_2il0floatpacket.4(%rip), %zmm5             #72.54
        vbroadcastsd %xmm14, %zmm14                             #25.25
        vbroadcastsd 16(%rsp), %zmm13                           #26.21[spill]
        vbroadcastsd %xmm1, %zmm12                              #72.41
        movq      24(%rbx), %r11                                #42.25
        movq      64(%r13), %r10                                #84.9
        movq      16(%rbx), %r9                                 #41.19
        movslq    8(%rbx), %r8                                  #41.43
        shlq      $2, %r8                                       #23.5
        movq      16(%r13), %rbx                                #43.25
        movq      (%r14), %rdx                                  #88.9
        movq      8(%r14), %rcx                                 #89.9
        movq      %r10, 48(%rsp)                                #40.5[spill]
        movq      %r11, 56(%rsp)                                #40.5[spill]
        movq      %r15, 64(%rsp)                                #40.5[spill]
        movq      %r14, (%rsp)                                  #40.5[spill]
        movq      %r12, 8(%rsp)                                 #40.5[spill]
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0x88, 0xff, 0xff, 0xff, 0x22
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 ymm15 ymm16 zmm5 zmm12 zmm13 zmm14
..B1.7:                         # Preds ..B1.25 ..B1.6
                                # Execution count [5.00e+00]
        movq      56(%rsp), %r10                                #42.25[spill]
        vxorpd    %xmm24, %xmm24, %xmm24                        #46.22
        vmovapd   %xmm24, %xmm18                                #47.22
        movl      (%r10,%rdi,4), %r13d                          #42.25
        vmovapd   %xmm18, %xmm4                                 #48.22
        vmovsd    (%rax,%rbx), %xmm11                           #43.25
        vmovsd    8(%rax,%rbx), %xmm6                           #44.25
        vmovsd    16(%rax,%rbx), %xmm7                          #45.25
        testl     %r13d, %r13d                                  #54.28
        jle       ..B1.25       # Prob 50%                      #54.28
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r13d xmm4 xmm6 xmm7 xmm11 xmm18 xmm24 ymm15 ymm16 zmm5 zmm12 zmm13 zmm14
..B1.8:                         # Preds ..B1.7
                                # Execution count [4.50e+00]
        vpxord    %zmm10, %zmm10, %zmm10                        #46.22
        vmovaps   %zmm10, %zmm9                                 #47.22
        vmovaps   %zmm9, %zmm8                                  #48.22
        cmpl      $8, %r13d                                     #54.9
        jl        ..B1.33       # Prob 10%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.9:                         # Preds ..B1.8
                                # Execution count [4.50e+00]
        cmpl      $1200, %r13d                                  #54.9
        jl        ..B1.32       # Prob 10%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.10:                        # Preds ..B1.9
                                # Execution count [4.50e+00]
        movq      %r8, %r10                                     #41.43
        imulq     %rsi, %r10                                    #41.43
        addq      %r9, %r10                                     #23.5
        movq      %r10, %r12                                    #54.9
        andq      $63, %r12                                     #54.9
        testl     $3, %r12d                                     #54.9
        je        ..B1.12       # Prob 50%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.11:                        # Preds ..B1.10
                                # Execution count [2.25e+00]
        xorl      %r12d, %r12d                                  #54.9
        jmp       ..B1.14       # Prob 100%                     #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.12:                        # Preds ..B1.10
                                # Execution count [2.25e+00]
        testl     %r12d, %r12d                                  #54.9
        je        ..B1.14       # Prob 50%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.13:                        # Preds ..B1.12
                                # Execution count [2.50e+01]
        negl      %r12d                                         #54.9
        addl      $64, %r12d                                    #54.9
        shrl      $2, %r12d                                     #54.9
        cmpl      %r12d, %r13d                                  #54.9
        cmovl     %r13d, %r12d                                  #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.14:                        # Preds ..B1.11 ..B1.13 ..B1.12
                                # Execution count [5.00e+00]
        movl      %r13d, %r11d                                  #54.9
        subl      %r12d, %r11d                                  #54.9
        andl      $7, %r11d                                     #54.9
        negl      %r11d                                         #54.9
        addl      %r13d, %r11d                                  #54.9
        cmpl      $1, %r12d                                     #54.9
        jb        ..B1.18       # Prob 50%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.15:                        # Preds ..B1.14
                                # Execution count [4.50e+00]
        vmovdqa32 %ymm16, %ymm4                                 #54.9
        xorl      %r15d, %r15d                                  #54.9
        vpbroadcastd %r12d, %ymm3                               #54.9
        vbroadcastsd %xmm11, %zmm2                              #43.23
        vbroadcastsd %xmm6, %zmm1                               #44.23
        vbroadcastsd %xmm7, %zmm0                               #45.23
        movslq    %r12d, %r14                                   #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r15 r11d r12d r13d xmm6 xmm7 xmm11 ymm3 ymm4 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.16:                        # Preds ..B1.16 ..B1.15
                                # Execution count [2.50e+01]
        vpcmpgtd  %ymm4, %ymm3, %k5                             #54.9
        vpaddd    %ymm15, %ymm4, %ymm4                          #54.9
        vmovdqu32 (%r10,%r15,4), %ymm17{%k5}{z}                 #55.21
        vpaddd    %ymm17, %ymm17, %ymm18                        #56.36
        addq      $8, %r15                                      #54.9
        vpaddd    %ymm18, %ymm17, %ymm19                        #56.36
        kmovw     %k5, %k2                                      #56.36
        kmovw     %k5, %k3                                      #56.36
        kmovw     %k5, %k1                                      #56.36
        vpxord    %zmm21, %zmm21, %zmm21                        #56.36
        vpxord    %zmm20, %zmm20, %zmm20                        #56.36
        vpxord    %zmm22, %zmm22, %zmm22                        #56.36
        vgatherdpd 8(%rbx,%ymm19,8), %zmm21{%k2}                #56.36
        vgatherdpd (%rbx,%ymm19,8), %zmm20{%k3}                 #56.36
        vgatherdpd 16(%rbx,%ymm19,8), %zmm22{%k1}               #56.36
        vsubpd    %zmm21, %zmm1, %zmm18                         #57.36
        vsubpd    %zmm20, %zmm2, %zmm17                         #56.36
        vsubpd    %zmm22, %zmm0, %zmm19                         #58.36
        vmulpd    %zmm18, %zmm18, %zmm31                        #59.49
        vfmadd231pd %zmm17, %zmm17, %zmm31                      #59.49
        vfmadd231pd %zmm19, %zmm19, %zmm31                      #59.63
        vrcp14pd  %zmm31, %zmm30                                #70.38
        vcmppd    $1, %zmm14, %zmm31, %k6{%k5}                  #69.22
        #vfpclasspd $30, %zmm30, %k0                             #70.38
        #vmovaps   %zmm31, %zmm23                                #70.38
        #vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm30, %zmm23 #70.38
        #knotw     %k0, %k4                                      #70.38
        #vmulpd    %zmm23, %zmm23, %zmm24                        #70.38
        #vfmadd213pd %zmm30, %zmm23, %zmm30{%k4}                 #70.38
        #vfmadd213pd %zmm30, %zmm24, %zmm30{%k4}                 #70.38
        vmulpd    %zmm13, %zmm30, %zmm25                        #71.38
        vmulpd    %zmm12, %zmm30, %zmm27                        #72.54
        vmulpd    %zmm25, %zmm30, %zmm28                        #71.44
        vmulpd    %zmm28, %zmm30, %zmm26                        #71.50
        vfmsub213pd %zmm5, %zmm28, %zmm30                       #72.54
        vmulpd    %zmm27, %zmm26, %zmm29                        #72.61
        vmulpd    %zmm30, %zmm29, %zmm23                        #72.67
        vfmadd231pd %zmm17, %zmm23, %zmm10{%k6}                 #73.17
        vfmadd231pd %zmm18, %zmm23, %zmm9{%k6}                  #74.17
        vfmadd231pd %zmm19, %zmm23, %zmm8{%k6}                  #75.17
        cmpq      %r14, %r15                                    #54.9
        jb        ..B1.16       # Prob 82%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r15 r11d r12d r13d xmm6 xmm7 xmm11 ymm3 ymm4 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.17:                        # Preds ..B1.16
                                # Execution count [4.50e+00]
        cmpl      %r12d, %r13d                                  #54.9
        je        ..B1.24       # Prob 10%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.18:                        # Preds ..B1.17 ..B1.14 ..B1.32
                                # Execution count [2.50e+01]
        lea       8(%r12), %r10d                                #54.9
        cmpl      %r10d, %r11d                                  #54.9
        jl        ..B1.22       # Prob 50%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.19:                        # Preds ..B1.18
                                # Execution count [4.50e+00]
        movq      %r8, %r10                                     #41.43
        imulq     %rsi, %r10                                    #41.43
        vbroadcastsd %xmm11, %zmm2                              #43.23
        vbroadcastsd %xmm6, %zmm1                               #44.23
        vbroadcastsd %xmm7, %zmm0                               #45.23
        movslq    %r12d, %r14                                   #54.9
        addq      %r9, %r10                                     #23.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r11d r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.20:                        # Preds ..B1.20 ..B1.19
                                # Execution count [2.50e+01]
        vmovdqu   (%r10,%r14,4), %ymm3                          #55.21
        addl      $8, %r12d                                     #54.9
        vpcmpeqb  %xmm0, %xmm0, %k2                             #56.36
        vpcmpeqb  %xmm0, %xmm0, %k3                             #56.36
        vpcmpeqb  %xmm0, %xmm0, %k1                             #56.36
        vpaddd    %ymm3, %ymm3, %ymm4                           #56.36
        vpaddd    %ymm4, %ymm3, %ymm17                          #56.36
        addq      $8, %r14                                      #54.9
        vpxord    %zmm19, %zmm19, %zmm19                        #56.36
        vpxord    %zmm18, %zmm18, %zmm18                        #56.36
        vpxord    %zmm20, %zmm20, %zmm20                        #56.36
        vgatherdpd 8(%rbx,%ymm17,8), %zmm19{%k2}                #56.36
        vgatherdpd (%rbx,%ymm17,8), %zmm18{%k3}                 #56.36
        vgatherdpd 16(%rbx,%ymm17,8), %zmm20{%k1}               #56.36
        vsubpd    %zmm19, %zmm1, %zmm30                         #57.36
        vsubpd    %zmm18, %zmm2, %zmm29                         #56.36
        vsubpd    %zmm20, %zmm0, %zmm3                          #58.36
        vmulpd    %zmm30, %zmm30, %zmm21                        #59.49
        vfmadd231pd %zmm29, %zmm29, %zmm21                      #59.49
        vfmadd231pd %zmm3, %zmm3, %zmm21                        #59.63
        vrcp14pd  %zmm21, %zmm28                                #70.38
        vcmppd    $1, %zmm14, %zmm21, %k5                       #69.22
        #vfpclasspd $30, %zmm28, %k0                             #70.38
        #vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm28, %zmm21 #70.38
        #knotw     %k0, %k4                                      #70.38
        #vmulpd    %zmm21, %zmm21, %zmm22                        #70.38
        #vfmadd213pd %zmm28, %zmm21, %zmm28{%k4}                 #70.38
        #vfmadd213pd %zmm28, %zmm22, %zmm28{%k4}                 #70.38
        vmulpd    %zmm13, %zmm28, %zmm23                        #71.38
        vmulpd    %zmm12, %zmm28, %zmm25                        #72.54
        vmulpd    %zmm23, %zmm28, %zmm26                        #71.44
        vmulpd    %zmm26, %zmm28, %zmm24                        #71.50
        vfmsub213pd %zmm5, %zmm26, %zmm28                       #72.54
        vmulpd    %zmm25, %zmm24, %zmm27                        #72.61
        vmulpd    %zmm28, %zmm27, %zmm31                        #72.67
        vfmadd231pd %zmm29, %zmm31, %zmm10{%k5}                 #73.17
        vfmadd231pd %zmm30, %zmm31, %zmm9{%k5}                  #74.17
        vfmadd231pd %zmm3, %zmm31, %zmm8{%k5}                   #75.17
        cmpl      %r11d, %r12d                                  #54.9
        jb        ..B1.20       # Prob 82%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r11d r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.22:                        # Preds ..B1.20 ..B1.18 ..B1.33
                                # Execution count [5.00e+00]
        lea       1(%r11), %r10d                                #54.9
        cmpl      %r13d, %r10d                                  #54.9
        ja        ..B1.24       # Prob 50%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.23:                        # Preds ..B1.22
                                # Execution count [2.50e+01]
        imulq     %r8, %rsi                                     #41.43
        vbroadcastsd %xmm7, %zmm17                              #45.23
        vbroadcastsd %xmm6, %zmm4                               #44.23
        vbroadcastsd %xmm11, %zmm2                              #43.23
        movl      %r13d, %r10d                                  #54.9
        addq      %r9, %rsi                                     #23.5
        subl      %r11d, %r10d                                  #54.9
        vpbroadcastd %r10d, %ymm7                               #54.9
        vpcmpgtd  %ymm16, %ymm7, %k5                            #54.9
        movslq    %r11d, %r11                                   #54.9
        kmovw     %k5, %k2                                      #56.36
        kmovw     %k5, %k3                                      #56.36
        kmovw     %k5, %k1                                      #56.36
        vmovdqu32 (%rsi,%r11,4), %ymm6{%k5}{z}                  #55.21
        vpaddd    %ymm6, %ymm6, %ymm0                           #56.36
        vpaddd    %ymm0, %ymm6, %ymm1                           #56.36
        vpxord    %zmm11, %zmm11, %zmm11                        #56.36
        vpxord    %zmm3, %zmm3, %zmm3                           #56.36
        vpxord    %zmm18, %zmm18, %zmm18                        #56.36
        vgatherdpd 8(%rbx,%ymm1,8), %zmm11{%k2}                 #56.36
        vgatherdpd (%rbx,%ymm1,8), %zmm3{%k3}                   #56.36
        vgatherdpd 16(%rbx,%ymm1,8), %zmm18{%k1}                #56.36
        vsubpd    %zmm11, %zmm4, %zmm29                         #57.36
        vsubpd    %zmm3, %zmm2, %zmm28                          #56.36
        vsubpd    %zmm18, %zmm17, %zmm31                        #58.36
        vmulpd    %zmm29, %zmm29, %zmm27                        #59.49
        vfmadd231pd %zmm28, %zmm28, %zmm27                      #59.49
        vfmadd231pd %zmm31, %zmm31, %zmm27                      #59.63
        vrcp14pd  %zmm27, %zmm26                                #70.38
        vcmppd    $1, %zmm14, %zmm27, %k6{%k5}                  #69.22
        #vfpclasspd $30, %zmm26, %k0                             #70.38
        #vmovaps   %zmm27, %zmm19                                #70.38
        #vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm26, %zmm19 #70.38
        #knotw     %k0, %k4                                      #70.38
        #vmulpd    %zmm19, %zmm19, %zmm20                        #70.38
        #vfmadd213pd %zmm26, %zmm19, %zmm26{%k4}                 #70.38
        #vfmadd213pd %zmm26, %zmm20, %zmm26{%k4}                 #70.38
        vmulpd    %zmm13, %zmm26, %zmm21                        #71.38
        vmulpd    %zmm12, %zmm26, %zmm23                        #72.54
        vmulpd    %zmm21, %zmm26, %zmm24                        #71.44
        vmulpd    %zmm24, %zmm26, %zmm22                        #71.50
        vfmsub213pd %zmm5, %zmm24, %zmm26                       #72.54
        vmulpd    %zmm23, %zmm22, %zmm25                        #72.61
        vmulpd    %zmm26, %zmm25, %zmm30                        #72.67
        vfmadd231pd %zmm28, %zmm30, %zmm10{%k6}                 #73.17
        vfmadd231pd %zmm29, %zmm30, %zmm9{%k6}                  #74.17
        vfmadd231pd %zmm31, %zmm30, %zmm8{%k6}                  #75.17
                                # LOE rax rdx rcx rbx rdi r8 r9 r13d ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.24:                        # Preds ..B1.17 ..B1.23 ..B1.22
                                # Execution count [4.50e+00]
        vmovups   .L_2il0floatpacket.6(%rip), %zmm19            #48.22
        vpermd    %zmm8, %zmm19, %zmm0                          #48.22
        vpermd    %zmm9, %zmm19, %zmm6                          #47.22
        vpermd    %zmm10, %zmm19, %zmm20                        #46.22
        vaddpd    %zmm8, %zmm0, %zmm8                           #48.22
        vaddpd    %zmm9, %zmm6, %zmm9                           #47.22
        vaddpd    %zmm10, %zmm20, %zmm10                        #46.22
        vpermpd   $78, %zmm8, %zmm1                             #48.22
        vpermpd   $78, %zmm9, %zmm7                             #47.22
        vpermpd   $78, %zmm10, %zmm21                           #46.22
        vaddpd    %zmm1, %zmm8, %zmm2                           #48.22
        vaddpd    %zmm7, %zmm9, %zmm11                          #47.22
        vaddpd    %zmm21, %zmm10, %zmm22                        #46.22
        vpermpd   $177, %zmm2, %zmm3                            #48.22
        vpermpd   $177, %zmm11, %zmm17                          #47.22
        vpermpd   $177, %zmm22, %zmm23                          #46.22
        vaddpd    %zmm3, %zmm2, %zmm4                           #48.22
        vaddpd    %zmm17, %zmm11, %zmm18                        #47.22
        vaddpd    %zmm23, %zmm22, %zmm24                        #46.22
                                # LOE rax rdx rcx rbx rdi r8 r9 r13d xmm4 xmm18 xmm24 ymm15 ymm16 zmm5 zmm12 zmm13 zmm14
..B1.25:                        # Preds ..B1.24 ..B1.7
                                # Execution count [5.00e+00]
        movslq    %r13d, %r13                                   #88.9
        movq      48(%rsp), %rsi                                #84.9[spill]
        lea       7(%r13), %r10d                                #89.9
        sarl      $2, %r10d                                     #89.9
        addq      %r13, %rdx                                    #88.9
        shrl      $29, %r10d                                    #89.9
        vaddsd    (%rax,%rsi), %xmm24, %xmm0                    #84.9
        vaddsd    8(%rax,%rsi), %xmm18, %xmm1                   #85.9
        vaddsd    16(%rax,%rsi), %xmm4, %xmm2                   #86.9
        vmovsd    %xmm0, (%rax,%rsi)                            #84.9
        lea       7(%r10,%r13), %r11d                           #89.9
        sarl      $3, %r11d                                     #89.9
        vmovsd    %xmm1, 8(%rax,%rsi)                           #85.9
        vmovsd    %xmm2, 16(%rax,%rsi)                          #86.9
        addq      $24, %rax                                     #40.5
        movslq    %r11d, %r11                                   #89.9
        movslq    %edi, %rsi                                    #40.32
        incq      %rdi                                          #40.5
        addq      %r11, %rcx                                    #89.9
        incq      %rsi                                          #40.32
        cmpq      64(%rsp), %rdi                                #40.5[spill]
        jb        ..B1.7        # Prob 82%                      #40.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 ymm15 ymm16 zmm5 zmm12 zmm13 zmm14
..B1.26:                        # Preds ..B1.25
                                # Execution count [9.00e-01]
        movq      (%rsp), %r14                                  #[spill]
        movq      8(%rsp), %r12                                 #[spill]
	.cfi_restore 12
        movq      %rdx, (%r14)                                  #88.9
        movq      %rcx, 8(%r14)                                 #89.9
        jmp       ..B1.29       # Prob 100%                     #89.9
                                # LOE r12
..B1.27:                        # Preds ..B1.1
                                # Execution count [5.00e-01]
        xorl      %eax, %eax                                    #36.16
..___tag_value_computeForceLJFullNeigh_plain_c.33:
#       getTimeStamp()
        call      getTimeStamp                                  #36.16
..___tag_value_computeForceLJFullNeigh_plain_c.34:
                                # LOE r12 xmm0
..B1.44:                        # Preds ..B1.27
                                # Execution count [5.00e-01]
        vmovsd    %xmm0, 40(%rsp)                               #36.16[spill]
                                # LOE r12
..B1.28:                        # Preds ..B1.44
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.0, %edi                         #37.5
..___tag_value_computeForceLJFullNeigh_plain_c.36:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #37.5
..___tag_value_computeForceLJFullNeigh_plain_c.37:
                                # LOE r12
..B1.29:                        # Preds ..B1.26 ..B1.28
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.0, %edi                         #92.5
        vzeroupper                                              #92.5
..___tag_value_computeForceLJFullNeigh_plain_c.38:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #92.5
..___tag_value_computeForceLJFullNeigh_plain_c.39:
                                # LOE r12
..B1.30:                        # Preds ..B1.29
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #93.16
..___tag_value_computeForceLJFullNeigh_plain_c.40:
#       getTimeStamp()
        call      getTimeStamp                                  #93.16
..___tag_value_computeForceLJFullNeigh_plain_c.41:
                                # LOE r12 xmm0
..B1.31:                        # Preds ..B1.30
                                # Execution count [1.00e+00]
        vsubsd    40(%rsp), %xmm0, %xmm0                        #94.14[spill]
        addq      $96, %rsp                                     #94.14
	.cfi_restore 3
        popq      %rbx                                          #94.14
	.cfi_restore 15
        popq      %r15                                          #94.14
	.cfi_restore 14
        popq      %r14                                          #94.14
	.cfi_restore 13
        popq      %r13                                          #94.14
        movq      %rbp, %rsp                                    #94.14
        popq      %rbp                                          #94.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #94.14
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
        movl      %r13d, %r11d                                  #54.9
        xorl      %r12d, %r12d                                  #54.9
        andl      $-8, %r11d                                    #54.9
        jmp       ..B1.18       # Prob 100%                     #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.33:                        # Preds ..B1.8
                                # Execution count [4.50e-01]: Infreq
        xorl      %r11d, %r11d                                  #54.9
        jmp       ..B1.22       # Prob 100%                     #54.9
	.cfi_restore 12
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.34:                        # Preds ..B1.2
                                # Execution count [1.00e+00]: Infreq
        cmpl      $8, %esi                                      #30.5
        jl        ..B1.40       # Prob 10%                      #30.5
                                # LOE rbx rdi r12 r13 r14 esi r15d
..B1.35:                        # Preds ..B1.34
                                # Execution count [1.00e+00]: Infreq
        movl      %esi, %eax                                    #30.5
        xorl      %ecx, %ecx                                    #30.5
        andl      $-8, %eax                                     #30.5
        movslq    %eax, %rdx                                    #30.5
        vpxord    %zmm0, %zmm0, %zmm0                           #31.22
                                # LOE rdx rcx rbx rdi r12 r13 r14 eax esi r15d zmm0
..B1.36:                        # Preds ..B1.36 ..B1.35
                                # Execution count [5.56e+00]: Infreq
        vmovupd   %zmm0, (%rdi,%rcx,8)                          #31.9
        addq      $8, %rcx                                      #30.5
        cmpq      %rdx, %rcx                                    #30.5
        jb        ..B1.36       # Prob 82%                      #30.5
                                # LOE rdx rcx rbx rdi r12 r13 r14 eax esi r15d zmm0
..B1.38:                        # Preds ..B1.36 ..B1.40
                                # Execution count [1.11e+00]: Infreq
        lea       1(%rax), %edx                                 #30.5
        cmpl      %esi, %edx                                    #30.5
        ja        ..B1.46       # Prob 50%                      #30.5
                                # LOE rbx rdi r12 r13 r14 eax esi r15d
..B1.39:                        # Preds ..B1.38
                                # Execution count [5.56e+00]: Infreq
        subl      %eax, %esi                                    #30.5
        vpbroadcastd %esi, %ymm0                                #30.5
        vpcmpgtd  .L_2il0floatpacket.0(%rip), %ymm0, %k1        #30.5
        movslq    %eax, %rax                                    #30.5
        movslq    %r15d, %r15                                   #30.5
        vpxord    %zmm1, %zmm1, %zmm1                           #31.22
        vmovupd   %zmm1, (%rdi,%rax,8){%k1}                     #31.9
        jmp       ..B1.4        # Prob 100%                     #31.9
                                # LOE rbx r12 r13 r14 r15
..B1.40:                        # Preds ..B1.34
                                # Execution count [1.00e-01]: Infreq
        xorl      %eax, %eax                                    #30.5
        jmp       ..B1.38       # Prob 100%                     #30.5
                                # LOE rbx rdi r12 r13 r14 eax esi r15d
..B1.46:                        # Preds ..B1.38
                                # Execution count [5.56e-01]: Infreq
        movslq    %r15d, %r15                                   #30.5
        jmp       ..B1.4        # Prob 100%                     #30.5
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
                                                         #97.96
        pushq     %rbp                                          #97.96
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #97.96
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #97.96
        pushq     %r12                                          #97.96
        pushq     %r13                                          #97.96
        pushq     %r14                                          #97.96
        pushq     %r15                                          #97.96
        pushq     %rbx                                          #97.96
        subq      $88, %rsp                                     #97.96
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
        movq      %rsi, %r13                                    #97.96
        vmovsd    144(%rdi), %xmm0                              #101.27
        movq      %rcx, %r14                                    #97.96
        vmovsd    56(%rdi), %xmm1                               #102.23
        movq      %rdx, %r12                                    #97.96
        vmovsd    40(%rdi), %xmm2                               #103.24
        movl      4(%r13), %ebx                                 #98.18
        vmovsd    %xmm0, 24(%rsp)                               #101.27[spill]
        vmovsd    %xmm1, 32(%rsp)                               #102.23[spill]
        vmovsd    %xmm2, 16(%rsp)                               #103.24[spill]
        testl     %ebx, %ebx                                    #106.24
        jle       ..B2.28       # Prob 50%                      #106.24
                                # LOE r12 r13 r14 ebx
..B2.2:                         # Preds ..B2.1
                                # Execution count [5.00e-03]
        movq      64(%r13), %rdi                                #107.9
        lea       (%rbx,%rbx,2), %esi                           #98.18
        cmpl      $12, %esi                                     #106.5
        jle       ..B2.35       # Prob 0%                       #106.5
                                # LOE rdi r12 r13 r14 ebx esi
..B2.3:                         # Preds ..B2.2
                                # Execution count [1.00e+00]
        movslq    %ebx, %r15                                    #106.5
        xorl      %esi, %esi                                    #106.5
        lea       (%r15,%r15,2), %rdx                           #106.5
        shlq      $3, %rdx                                      #106.5
        call      __intel_skx_avx512_memset                     #106.5
                                # LOE r12 r13 r14 r15 ebx
..B2.4:                         # Preds ..B2.3 ..B2.47 ..B2.40
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #112.16
        vzeroupper                                              #112.16
..___tag_value_computeForceLJHalfNeigh.71:
#       getTimeStamp()
        call      getTimeStamp                                  #112.16
..___tag_value_computeForceLJHalfNeigh.72:
                                # LOE r12 r13 r14 r15 ebx xmm0
..B2.44:                        # Preds ..B2.4
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 8(%rsp)                                #112.16[spill]
                                # LOE r12 r13 r14 r15 ebx
..B2.5:                         # Preds ..B2.44
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.1, %edi                         #113.5
..___tag_value_computeForceLJHalfNeigh.74:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #113.5
..___tag_value_computeForceLJHalfNeigh.75:
                                # LOE r12 r13 r14 r15 ebx
..B2.6:                         # Preds ..B2.5
                                # Execution count [9.00e-01]
        vmovsd    24(%rsp), %xmm9                               #101.45[spill]
        xorl      %r10d, %r10d                                  #115.15
        vmovsd    16(%rsp), %xmm0                               #151.41[spill]
        xorl      %r9d, %r9d                                    #115.5
        vmulsd    %xmm9, %xmm9, %xmm10                          #101.45
        xorl      %eax, %eax                                    #115.5
        vmovdqu   .L_2il0floatpacket.0(%rip), %ymm14            #133.9
        vmulsd    .L_2il0floatpacket.3(%rip), %xmm0, %xmm1      #151.41
        vmovdqu   .L_2il0floatpacket.1(%rip), %ymm13            #133.9
        vmovdqu   .L_2il0floatpacket.7(%rip), %ymm12            #136.36
        vmovdqu   .L_2il0floatpacket.8(%rip), %ymm11            #137.36
        vmovups   .L_2il0floatpacket.4(%rip), %zmm5             #151.54
        vpbroadcastd %ebx, %ymm4                                #98.18
        vbroadcastsd %xmm10, %zmm10                             #101.25
        vbroadcastsd 32(%rsp), %zmm9                            #102.21[spill]
        vbroadcastsd %xmm1, %zmm7                               #151.41
        movq      24(%r12), %r11                                #117.25
        movslq    8(%r12), %rdi                                 #116.43
        movq      16(%r12), %r8                                 #116.19
        shlq      $2, %rdi                                      #99.5
        movq      16(%r13), %rsi                                #118.25
        movq      64(%r13), %rdx                                #158.21
        movq      (%r14), %rcx                                  #169.9
        movq      8(%r14), %rbx                                 #170.9
        movq      %r11, 40(%rsp)                                #115.5[spill]
        movq      %r15, 48(%rsp)                                #115.5[spill]
        movq      %r14, (%rsp)                                  #115.5[spill]
        vpxord    %zmm15, %zmm15, %zmm15                        #115.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 ymm4 ymm11 ymm12 ymm13 ymm14 zmm5 zmm7 zmm9 zmm10 zmm15
..B2.7:                         # Preds ..B2.26 ..B2.6
                                # Execution count [5.00e+00]
        movq      40(%rsp), %r11                                #117.25[spill]
        vxorpd    %xmm27, %xmm27, %xmm27                        #121.22
        vmovapd   %xmm27, %xmm21                                #122.22
        movl      (%r11,%r9,4), %r11d                           #117.25
        vmovapd   %xmm21, %xmm3                                 #123.22
        vmovsd    (%rax,%rsi), %xmm1                            #118.25
        vmovsd    8(%rax,%rsi), %xmm0                           #119.25
        vmovsd    16(%rax,%rsi), %xmm2                          #120.25
        testl     %r11d, %r11d                                  #133.9
        jle       ..B2.26       # Prob 50%                      #133.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d xmm0 xmm1 xmm2 xmm3 xmm21 xmm27 ymm4 ymm11 ymm12 ymm13 ymm14 zmm5 zmm7 zmm9 zmm10 zmm15
..B2.8:                         # Preds ..B2.7
                                # Execution count [2.50e+00]
        jbe       ..B2.26       # Prob 50%                      #133.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d xmm0 xmm1 xmm2 xmm3 xmm21 xmm27 ymm4 ymm11 ymm12 ymm13 ymm14 zmm5 zmm7 zmm9 zmm10 zmm15
..B2.9:                         # Preds ..B2.8
                                # Execution count [2.25e+00]
        vmovaps   %zmm15, %zmm8                                 #121.22
        vmovaps   %zmm8, %zmm6                                  #122.22
        vmovaps   %zmm6, %zmm3                                  #123.22
        cmpl      $8, %r11d                                     #133.9
        jb        ..B2.34       # Prob 10%                      #133.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.10:                        # Preds ..B2.9
                                # Execution count [2.25e+00]
        cmpl      $1200, %r11d                                  #133.9
        jb        ..B2.33       # Prob 10%                      #133.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.11:                        # Preds ..B2.10
                                # Execution count [2.25e+00]
        movq      %rdi, %r15                                    #116.43
        imulq     %r10, %r15                                    #116.43
        addq      %r8, %r15                                     #99.5
        movq      %r15, %r12                                    #133.9
        andq      $63, %r12                                     #133.9
        testl     $3, %r12d                                     #133.9
        je        ..B2.13       # Prob 50%                      #133.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r15 r11d r12d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.12:                        # Preds ..B2.11
                                # Execution count [1.12e+00]
        movl      %r11d, %r14d                                  #133.9
        xorl      %r12d, %r12d                                  #133.9
        andl      $7, %r14d                                     #133.9
        negl      %r14d                                         #133.9
        addl      %r11d, %r14d                                  #133.9
        jmp       ..B2.19       # Prob 100%                     #133.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.13:                        # Preds ..B2.11
                                # Execution count [1.12e+00]
        testl     %r12d, %r12d                                  #133.9
        je        ..B2.18       # Prob 50%                      #133.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r15 r11d r12d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.14:                        # Preds ..B2.13
                                # Execution count [1.25e+01]
        negl      %r12d                                         #133.9
        movl      %r11d, %r14d                                  #133.9
        addl      $64, %r12d                                    #133.9
        shrl      $2, %r12d                                     #133.9
        cmpl      %r12d, %r11d                                  #133.9
        cmovb     %r11d, %r12d                                  #133.9
        subl      %r12d, %r14d                                  #133.9
        andl      $7, %r14d                                     #133.9
        negl      %r14d                                         #133.9
        addl      %r11d, %r14d                                  #133.9
        cmpl      $1, %r12d                                     #133.9
        jb        ..B2.19       # Prob 50%                      #133.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r15 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.15:                        # Preds ..B2.14
                                # Execution count [2.25e+00]
        vpbroadcastd %r12d, %ymm28                              #133.9
        xorl      %r13d, %r13d                                  #133.9
        vbroadcastsd %xmm1, %zmm27                              #118.23
        vbroadcastsd %xmm0, %zmm26                              #119.23
        vbroadcastsd %xmm2, %zmm25                              #120.23
        movslq    %r12d, %r12                                   #133.9
        movq      %r10, 16(%rsp)                                #133.9[spill]
        vmovdqa32 %ymm14, %ymm29                                #133.9
        movq      %r12, %r10                                    #133.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r13 r15 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 ymm28 ymm29 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15 zmm25 zmm26 zmm27
..B2.16:                        # Preds ..B2.16 ..B2.15
                                # Execution count [1.25e+01]
        vpcmpud   $1, %ymm28, %ymm29, %k4                       #133.9
        vpaddd    %ymm13, %ymm29, %ymm29                        #133.9
        vmovdqu32 (%r15,%r13,4), %ymm21{%k4}{z}                 #134.21
        vpaddd    %ymm21, %ymm21, %ymm30                        #135.36
        addq      $8, %r13                                      #133.9
        vpcmpgtd  %ymm21, %ymm4, %k6                            #157.24
        vpaddd    %ymm30, %ymm21, %ymm24                        #135.36
        kmovw     %k4, %k2                                      #135.36
        kmovw     %k4, %k3                                      #135.36
        kmovw     %k4, %k1                                      #135.36
        vpxord    %zmm16, %zmm16, %zmm16                        #135.36
        vpxord    %zmm31, %zmm31, %zmm31                        #135.36
        vpxord    %zmm20, %zmm20, %zmm20                        #135.36
        vpaddd    %ymm12, %ymm24, %ymm17                        #136.36
        vgatherdpd 8(%rsi,%ymm24,8), %zmm16{%k2}                #135.36
        vgatherdpd (%rsi,%ymm24,8), %zmm31{%k3}                 #135.36
        vgatherdpd 16(%rsi,%ymm24,8), %zmm20{%k1}               #135.36
        vsubpd    %zmm16, %zmm26, %zmm22                        #136.36
        vsubpd    %zmm31, %zmm27, %zmm23                        #135.36
        vsubpd    %zmm20, %zmm25, %zmm20                        #137.36
        vmulpd    %zmm22, %zmm22, %zmm18                        #138.49
        vpaddd    %ymm11, %ymm24, %ymm16                        #137.36
        vfmadd231pd %zmm23, %zmm23, %zmm18                      #138.49
        vfmadd231pd %zmm20, %zmm20, %zmm18                      #138.63
        vrcp14pd  %zmm18, %zmm19                                #149.38
        vcmppd    $1, %zmm10, %zmm18, %k7{%k4}                  #148.22
        vfpclasspd $30, %zmm19, %k0                             #149.38
        vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm19, %zmm18 #149.38
        knotw     %k0, %k5                                      #149.38
        kandw     %k6, %k7, %k6                                 #157.24
        vmulpd    %zmm18, %zmm18, %zmm21                        #149.38
        vfmadd213pd %zmm19, %zmm18, %zmm19{%k5}                 #149.38
        vfmadd213pd %zmm19, %zmm21, %zmm19{%k5}                 #149.38
        vmulpd    %zmm9, %zmm19, %zmm30                         #150.38
        vmulpd    %zmm30, %zmm19, %zmm18                        #150.44
        vmulpd    %zmm18, %zmm19, %zmm31                        #150.50
        vfmsub213pd %zmm5, %zmm19, %zmm18                       #151.54
        vmulpd    %zmm7, %zmm19, %zmm19                         #151.54
        vmulpd    %zmm19, %zmm31, %zmm19                        #151.61
        vmulpd    %zmm18, %zmm19, %zmm21                        #151.67
        vmovaps   %zmm15, %zmm18                                #158.21
        kmovw     %k6, %k1                                      #158.21
        vfmadd231pd %zmm23, %zmm21, %zmm8{%k7}                  #152.17
        vfmadd231pd %zmm22, %zmm21, %zmm6{%k7}                  #153.17
        vfmadd231pd %zmm20, %zmm21, %zmm3{%k7}                  #154.17
        .byte     144                                           #158.21
        vgatherdpd (%rdx,%ymm24,8), %zmm18{%k1}                 #158.21
        vfnmadd213pd %zmm18, %zmm21, %zmm23                     #158.21
        kmovw     %k6, %k2                                      #158.21
        vscatterdpd %zmm23, (%rdx,%ymm24,8){%k2}                #158.21
        vmovaps   %zmm15, %zmm23                                #159.21
        kmovw     %k6, %k3                                      #159.21
        kmovw     %k6, %k4                                      #159.21
        kmovw     %k6, %k5                                      #160.21
        vgatherdpd (%rdx,%ymm17,8), %zmm23{%k3}                 #159.21
        vfnmadd213pd %zmm23, %zmm21, %zmm22                     #159.21
        vscatterdpd %zmm22, (%rdx,%ymm17,8){%k4}                #159.21
        vmovaps   %zmm15, %zmm17                                #160.21
        vgatherdpd (%rdx,%ymm16,8), %zmm17{%k5}                 #160.21
        vfnmadd213pd %zmm17, %zmm21, %zmm20                     #160.21
        vscatterdpd %zmm20, (%rdx,%ymm16,8){%k6}                #160.21
        cmpq      %r10, %r13                                    #133.9
        jb        ..B2.16       # Prob 82%                      #133.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r13 r15 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 ymm28 ymm29 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15 zmm25 zmm26 zmm27
..B2.17:                        # Preds ..B2.16
                                # Execution count [2.25e+00]
        movq      16(%rsp), %r10                                #[spill]
        cmpl      %r12d, %r11d                                  #133.9
        je        ..B2.25       # Prob 10%                      #133.9
        jmp       ..B2.19       # Prob 100%                     #133.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.18:                        # Preds ..B2.13
                                # Execution count [5.62e-01]
        movl      %r11d, %r14d                                  #133.9
        andl      $7, %r14d                                     #133.9
        negl      %r14d                                         #133.9
        addl      %r11d, %r14d                                  #133.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.19:                        # Preds ..B2.12 ..B2.18 ..B2.17 ..B2.14 ..B2.33
                                #      
                                # Execution count [1.25e+01]
        lea       8(%r12), %r13d                                #133.9
        cmpl      %r13d, %r14d                                  #133.9
        jb        ..B2.23       # Prob 50%                      #133.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.20:                        # Preds ..B2.19
                                # Execution count [2.25e+00]
        movq      %rdi, %r13                                    #116.43
        imulq     %r10, %r13                                    #116.43
        vbroadcastsd %xmm1, %zmm26                              #118.23
        vbroadcastsd %xmm0, %zmm25                              #119.23
        vbroadcastsd %xmm2, %zmm23                              #120.23
        movslq    %r12d, %r15                                   #133.9
        addq      %r8, %r13                                     #99.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r13 r15 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15 zmm23 zmm25 zmm26
..B2.21:                        # Preds ..B2.21 ..B2.20
                                # Execution count [1.25e+01]
        vmovdqu32 (%r13,%r15,4), %ymm24                         #134.21
        addl      $8, %r12d                                     #133.9
        vpcmpeqb  %xmm0, %xmm0, %k2                             #135.36
        vpcmpeqb  %xmm0, %xmm0, %k3                             #135.36
        vpcmpeqb  %xmm0, %xmm0, %k1                             #135.36
        vpcmpgtd  %ymm24, %ymm4, %k6                            #157.24
        vpaddd    %ymm24, %ymm24, %ymm27                        #135.36
        vpaddd    %ymm27, %ymm24, %ymm20                        #135.36
        addq      $8, %r15                                      #133.9
        vpxord    %zmm29, %zmm29, %zmm29                        #135.36
        vpxord    %zmm28, %zmm28, %zmm28                        #135.36
        vpxord    %zmm30, %zmm30, %zmm30                        #135.36
        vpaddd    %ymm20, %ymm12, %ymm21                        #136.36
        vpaddd    %ymm20, %ymm11, %ymm18                        #137.36
        vgatherdpd 8(%rsi,%ymm20,8), %zmm29{%k2}                #135.36
        vgatherdpd (%rsi,%ymm20,8), %zmm28{%k3}                 #135.36
        vgatherdpd 16(%rsi,%ymm20,8), %zmm30{%k1}               #135.36
        vsubpd    %zmm29, %zmm25, %zmm19                        #136.36
        vsubpd    %zmm28, %zmm26, %zmm22                        #135.36
        vsubpd    %zmm30, %zmm23, %zmm17                        #137.36
        vmulpd    %zmm19, %zmm19, %zmm31                        #138.49
        vfmadd231pd %zmm22, %zmm22, %zmm31                      #138.49
        vfmadd231pd %zmm17, %zmm17, %zmm31                      #138.63
        vrcp14pd  %zmm31, %zmm16                                #149.38
        vcmppd    $1, %zmm10, %zmm31, %k5                       #148.22
        vfpclasspd $30, %zmm16, %k0                             #149.38
        vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm16, %zmm31 #149.38
        knotw     %k0, %k4                                      #149.38
        vmulpd    %zmm31, %zmm31, %zmm27                        #149.38
        vfmadd213pd %zmm16, %zmm31, %zmm16{%k4}                 #149.38
        vfmadd213pd %zmm16, %zmm27, %zmm16{%k4}                 #149.38
        vmulpd    %zmm9, %zmm16, %zmm28                         #150.38
        vmulpd    %zmm7, %zmm16, %zmm24                         #151.54
        vmulpd    %zmm28, %zmm16, %zmm30                        #150.44
        vmulpd    %zmm30, %zmm16, %zmm29                        #150.50
        vfmsub213pd %zmm5, %zmm30, %zmm16                       #151.54
        vmulpd    %zmm24, %zmm29, %zmm31                        #151.61
        vmulpd    %zmm16, %zmm31, %zmm24                        #151.67
        vfmadd231pd %zmm22, %zmm24, %zmm8{%k5}                  #152.17
        vfmadd231pd %zmm19, %zmm24, %zmm6{%k5}                  #153.17
        vfmadd231pd %zmm17, %zmm24, %zmm3{%k5}                  #154.17
        kandw     %k6, %k5, %k5                                 #157.24
        vmovaps   %zmm15, %zmm16                                #158.21
        kmovw     %k5, %k7                                      #158.21
        kmovw     %k5, %k1                                      #158.21
        kmovw     %k5, %k2                                      #159.21
        kmovw     %k5, %k3                                      #159.21
        kmovw     %k5, %k4                                      #160.21
        vgatherdpd (%rdx,%ymm20,8), %zmm16{%k7}                 #158.21
        vfnmadd213pd %zmm16, %zmm24, %zmm22                     #158.21
        vscatterdpd %zmm22, (%rdx,%ymm20,8){%k1}                #158.21
        vmovaps   %zmm15, %zmm20                                #159.21
        vgatherdpd (%rdx,%ymm21,8), %zmm20{%k2}                 #159.21
        vfnmadd213pd %zmm20, %zmm24, %zmm19                     #159.21
        vscatterdpd %zmm19, (%rdx,%ymm21,8){%k3}                #159.21
        vmovaps   %zmm15, %zmm19                                #160.21
        vgatherdpd (%rdx,%ymm18,8), %zmm19{%k4}                 #160.21
        vfnmadd213pd %zmm19, %zmm24, %zmm17                     #160.21
        vscatterdpd %zmm17, (%rdx,%ymm18,8){%k5}                #160.21
        cmpl      %r14d, %r12d                                  #133.9
        jb        ..B2.21       # Prob 82%                      #133.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r13 r15 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15 zmm23 zmm25 zmm26
..B2.23:                        # Preds ..B2.21 ..B2.19 ..B2.34
                                # Execution count [2.50e+00]
        lea       1(%r14), %r12d                                #133.9
        cmpl      %r11d, %r12d                                  #133.9
        ja        ..B2.25       # Prob 50%                      #133.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.24:                        # Preds ..B2.23
                                # Execution count [1.25e+01]
        imulq     %rdi, %r10                                    #116.43
        vbroadcastsd %xmm0, %zmm24                              #119.23
        vbroadcastsd %xmm1, %zmm22                              #118.23
        vbroadcastsd %xmm2, %zmm26                              #120.23
        movl      %r11d, %r12d                                  #133.9
        addq      %r8, %r10                                     #99.5
        subl      %r14d, %r12d                                  #133.9
        vpbroadcastd %r12d, %ymm20                              #133.9
        vpcmpud   $1, %ymm20, %ymm14, %k5                       #133.9
        movslq    %r14d, %r14                                   #133.9
        kmovw     %k5, %k2                                      #135.36
        kmovw     %k5, %k3                                      #135.36
        kmovw     %k5, %k1                                      #135.36
        vmovdqu32 (%r10,%r14,4), %ymm19{%k5}{z}                 #134.21
        vpaddd    %ymm19, %ymm19, %ymm21                        #135.36
        vpcmpgtd  %ymm19, %ymm4, %k7                            #157.24
        vpaddd    %ymm21, %ymm19, %ymm18                        #135.36
        vmovaps   %zmm15, %zmm19                                #158.21
        vpxord    %zmm25, %zmm25, %zmm25                        #135.36
        vpxord    %zmm23, %zmm23, %zmm23                        #135.36
        vpxord    %zmm27, %zmm27, %zmm27                        #135.36
        vpaddd    %ymm18, %ymm12, %ymm16                        #136.36
        vpaddd    %ymm18, %ymm11, %ymm0                         #137.36
        vgatherdpd 8(%rsi,%ymm18,8), %zmm25{%k2}                #135.36
        vgatherdpd (%rsi,%ymm18,8), %zmm23{%k3}                 #135.36
        vgatherdpd 16(%rsi,%ymm18,8), %zmm27{%k1}               #135.36
        vsubpd    %zmm25, %zmm24, %zmm1                         #136.36
        vsubpd    %zmm23, %zmm22, %zmm17                        #135.36
        vsubpd    %zmm27, %zmm26, %zmm2                         #137.36
        vmulpd    %zmm1, %zmm1, %zmm21                          #138.49
        vfmadd231pd %zmm17, %zmm17, %zmm21                      #138.49
        vfmadd231pd %zmm2, %zmm2, %zmm21                        #138.63
        vrcp14pd  %zmm21, %zmm20                                #149.38
        vcmppd    $1, %zmm10, %zmm21, %k6{%k5}                  #148.22
        vfpclasspd $30, %zmm20, %k0                             #149.38
        vmovaps   %zmm21, %zmm28                                #149.38
        vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm20, %zmm28 #149.38
        knotw     %k0, %k4                                      #149.38
        vmulpd    %zmm28, %zmm28, %zmm29                        #149.38
        vfmadd213pd %zmm20, %zmm28, %zmm20{%k4}                 #149.38
        vfmadd213pd %zmm20, %zmm29, %zmm20{%k4}                 #149.38
        vmulpd    %zmm9, %zmm20, %zmm30                         #150.38
        vmulpd    %zmm7, %zmm20, %zmm28                         #151.54
        vmulpd    %zmm30, %zmm20, %zmm29                        #150.44
        vmulpd    %zmm29, %zmm20, %zmm31                        #150.50
        vfmsub213pd %zmm5, %zmm29, %zmm20                       #151.54
        vmulpd    %zmm28, %zmm31, %zmm30                        #151.61
        vmulpd    %zmm20, %zmm30, %zmm22                        #151.67
        vfmadd231pd %zmm17, %zmm22, %zmm8{%k6}                  #152.17
        vfmadd231pd %zmm1, %zmm22, %zmm6{%k6}                   #153.17
        vfmadd231pd %zmm2, %zmm22, %zmm3{%k6}                   #154.17
        kandw     %k7, %k6, %k6                                 #157.24
        kmovw     %k6, %k1                                      #158.21
        kmovw     %k6, %k2                                      #158.21
        kmovw     %k6, %k3                                      #159.21
        kmovw     %k6, %k4                                      #159.21
        kmovw     %k6, %k5                                      #160.21
        vgatherdpd (%rdx,%ymm18,8), %zmm19{%k1}                 #158.21
        vfnmadd213pd %zmm19, %zmm22, %zmm17                     #158.21
        vscatterdpd %zmm17, (%rdx,%ymm18,8){%k2}                #158.21
        vmovaps   %zmm15, %zmm17                                #159.21
        vgatherdpd (%rdx,%ymm16,8), %zmm17{%k3}                 #159.21
        vfnmadd213pd %zmm17, %zmm22, %zmm1                      #159.21
        vscatterdpd %zmm1, (%rdx,%ymm16,8){%k4}                 #159.21
        vmovaps   %zmm15, %zmm1                                 #160.21
        vgatherdpd (%rdx,%ymm0,8), %zmm1{%k5}                   #160.21
        vfnmadd213pd %zmm1, %zmm22, %zmm2                       #160.21
        vscatterdpd %zmm2, (%rdx,%ymm0,8){%k6}                  #160.21
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.25:                        # Preds ..B2.17 ..B2.24 ..B2.23
                                # Execution count [2.25e+00]
        vmovups   .L_2il0floatpacket.6(%rip), %zmm22            #123.22
        vpermd    %zmm3, %zmm22, %zmm0                          #123.22
        vpermd    %zmm6, %zmm22, %zmm17                         #122.22
        vpermd    %zmm8, %zmm22, %zmm23                         #121.22
        vaddpd    %zmm3, %zmm0, %zmm3                           #123.22
        vaddpd    %zmm6, %zmm17, %zmm6                          #122.22
        vaddpd    %zmm8, %zmm23, %zmm8                          #121.22
        vpermpd   $78, %zmm3, %zmm1                             #123.22
        vpermpd   $78, %zmm6, %zmm18                            #122.22
        vpermpd   $78, %zmm8, %zmm24                            #121.22
        vaddpd    %zmm1, %zmm3, %zmm2                           #123.22
        vaddpd    %zmm18, %zmm6, %zmm19                         #122.22
        vaddpd    %zmm24, %zmm8, %zmm25                         #121.22
        vpermpd   $177, %zmm2, %zmm16                           #123.22
        vpermpd   $177, %zmm19, %zmm20                          #122.22
        vpermpd   $177, %zmm25, %zmm26                          #121.22
        vaddpd    %zmm16, %zmm2, %zmm3                          #123.22
        vaddpd    %zmm20, %zmm19, %zmm21                        #122.22
        vaddpd    %zmm26, %zmm25, %zmm27                        #121.22
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d xmm3 xmm21 xmm27 ymm4 ymm11 ymm12 ymm13 ymm14 zmm5 zmm7 zmm9 zmm10 zmm15
..B2.26:                        # Preds ..B2.25 ..B2.8 ..B2.7
                                # Execution count [5.00e+00]
        movslq    %r11d, %r11                                   #169.9
        vaddsd    (%rax,%rdx), %xmm27, %xmm0                    #165.9
        vaddsd    8(%rax,%rdx), %xmm21, %xmm1                   #166.9
        vaddsd    16(%rax,%rdx), %xmm3, %xmm2                   #167.9
        vmovsd    %xmm0, (%rax,%rdx)                            #165.9
        lea       7(%r11), %r10d                                #170.9
        sarl      $2, %r10d                                     #170.9
        addq      %r11, %rcx                                    #169.9
        shrl      $29, %r10d                                    #170.9
        vmovsd    %xmm1, 8(%rax,%rdx)                           #166.9
        vmovsd    %xmm2, 16(%rax,%rdx)                          #167.9
        addq      $24, %rax                                     #115.5
        lea       7(%r10,%r11), %r12d                           #170.9
        movslq    %r9d, %r10                                    #115.32
        sarl      $3, %r12d                                     #170.9
        incq      %r9                                           #115.5
        movslq    %r12d, %r12                                   #170.9
        incq      %r10                                          #115.32
        addq      %r12, %rbx                                    #170.9
        cmpq      48(%rsp), %r9                                 #115.5[spill]
        jb        ..B2.7        # Prob 82%                      #115.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 ymm4 ymm11 ymm12 ymm13 ymm14 zmm5 zmm7 zmm9 zmm10 zmm15
..B2.27:                        # Preds ..B2.26
                                # Execution count [9.00e-01]
        movq      (%rsp), %r14                                  #[spill]
        movq      %rcx, (%r14)                                  #169.9
        movq      %rbx, 8(%r14)                                 #170.9
        jmp       ..B2.30       # Prob 100%                     #170.9
                                # LOE
..B2.28:                        # Preds ..B2.1
                                # Execution count [5.00e-01]
        xorl      %eax, %eax                                    #112.16
..___tag_value_computeForceLJHalfNeigh.87:
#       getTimeStamp()
        call      getTimeStamp                                  #112.16
..___tag_value_computeForceLJHalfNeigh.88:
                                # LOE xmm0
..B2.45:                        # Preds ..B2.28
                                # Execution count [5.00e-01]
        vmovsd    %xmm0, 8(%rsp)                                #112.16[spill]
                                # LOE
..B2.29:                        # Preds ..B2.45
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.1, %edi                         #113.5
..___tag_value_computeForceLJHalfNeigh.90:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #113.5
..___tag_value_computeForceLJHalfNeigh.91:
                                # LOE
..B2.30:                        # Preds ..B2.27 ..B2.29
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.1, %edi                         #173.5
        vzeroupper                                              #173.5
..___tag_value_computeForceLJHalfNeigh.92:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #173.5
..___tag_value_computeForceLJHalfNeigh.93:
                                # LOE
..B2.31:                        # Preds ..B2.30
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #174.16
..___tag_value_computeForceLJHalfNeigh.94:
#       getTimeStamp()
        call      getTimeStamp                                  #174.16
..___tag_value_computeForceLJHalfNeigh.95:
                                # LOE xmm0
..B2.32:                        # Preds ..B2.31
                                # Execution count [1.00e+00]
        vsubsd    8(%rsp), %xmm0, %xmm0                         #175.14[spill]
        addq      $88, %rsp                                     #175.14
	.cfi_restore 3
        popq      %rbx                                          #175.14
	.cfi_restore 15
        popq      %r15                                          #175.14
	.cfi_restore 14
        popq      %r14                                          #175.14
	.cfi_restore 13
        popq      %r13                                          #175.14
	.cfi_restore 12
        popq      %r12                                          #175.14
        movq      %rbp, %rsp                                    #175.14
        popq      %rbp                                          #175.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #175.14
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B2.33:                        # Preds ..B2.10
                                # Execution count [2.25e-01]: Infreq
        movl      %r11d, %r14d                                  #133.9
        xorl      %r12d, %r12d                                  #133.9
        andl      $-8, %r14d                                    #133.9
        jmp       ..B2.19       # Prob 100%                     #133.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.34:                        # Preds ..B2.9
                                # Execution count [2.25e-01]: Infreq
        xorl      %r14d, %r14d                                  #133.9
        jmp       ..B2.23       # Prob 100%                     #133.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.35:                        # Preds ..B2.2
                                # Execution count [1.00e+00]: Infreq
        cmpl      $8, %esi                                      #106.5
        jl        ..B2.41       # Prob 10%                      #106.5
                                # LOE rdi r12 r13 r14 ebx esi
..B2.36:                        # Preds ..B2.35
                                # Execution count [1.00e+00]: Infreq
        movl      %esi, %eax                                    #106.5
        xorl      %ecx, %ecx                                    #106.5
        andl      $-8, %eax                                     #106.5
        movslq    %eax, %rdx                                    #106.5
        vpxord    %zmm0, %zmm0, %zmm0                           #106.5
                                # LOE rdx rcx rdi r12 r13 r14 eax ebx esi zmm0
..B2.37:                        # Preds ..B2.37 ..B2.36
                                # Execution count [5.56e+00]: Infreq
        vmovupd   %zmm0, (%rdi,%rcx,8)                          #107.9
        addq      $8, %rcx                                      #106.5
        cmpq      %rdx, %rcx                                    #106.5
        jb        ..B2.37       # Prob 82%                      #106.5
                                # LOE rdx rcx rdi r12 r13 r14 eax ebx esi zmm0
..B2.39:                        # Preds ..B2.37 ..B2.41
                                # Execution count [1.11e+00]: Infreq
        lea       1(%rax), %edx                                 #106.5
        cmpl      %esi, %edx                                    #106.5
        ja        ..B2.47       # Prob 50%                      #106.5
                                # LOE rdi r12 r13 r14 eax ebx esi
..B2.40:                        # Preds ..B2.39
                                # Execution count [5.56e+00]: Infreq
        subl      %eax, %esi                                    #106.5
        vpbroadcastd %esi, %ymm0                                #106.5
        vpcmpgtd  .L_2il0floatpacket.0(%rip), %ymm0, %k1        #106.5
        movslq    %eax, %rax                                    #106.5
        movslq    %ebx, %r15                                    #106.5
        vpxord    %zmm1, %zmm1, %zmm1                           #107.9
        vmovupd   %zmm1, (%rdi,%rax,8){%k1}                     #107.9
        jmp       ..B2.4        # Prob 100%                     #107.9
                                # LOE r12 r13 r14 r15 ebx
..B2.41:                        # Preds ..B2.35
                                # Execution count [1.00e-01]: Infreq
        xorl      %eax, %eax                                    #106.5
        jmp       ..B2.39       # Prob 100%                     #106.5
                                # LOE rdi r12 r13 r14 eax ebx esi
..B2.47:                        # Preds ..B2.39
                                # Execution count [5.56e-01]: Infreq
        movslq    %ebx, %r15                                    #106.5
        jmp       ..B2.4        # Prob 100%                     #106.5
        .align    16,0x90
                                # LOE r12 r13 r14 r15 ebx
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
..___tag_value_computeForceLJFullNeigh_simd.112:
..L113:
                                                        #178.101
        pushq     %rbp                                          #178.101
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #178.101
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #178.101
        pushq     %r14                                          #178.101
        pushq     %r15                                          #178.101
        pushq     %rbx                                          #178.101
        subq      $232, %rsp                                    #178.101
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
        movq      %rsi, %r14                                    #178.101
        vmovsd    144(%rdi), %xmm0                              #181.27
        movq      %rdx, %r15                                    #178.101
        vmovsd    56(%rdi), %xmm1                               #182.23
        vmovsd    40(%rdi), %xmm2                               #183.24
        movl      4(%r14), %ebx                                 #179.18
        vmovsd    %xmm0, 8(%rsp)                                #181.27[spill]
        vmovsd    %xmm1, 16(%rsp)                               #182.23[spill]
        vmovsd    %xmm2, (%rsp)                                 #183.24[spill]
        testl     %ebx, %ebx                                    #185.24
        jle       ..B3.9        # Prob 50%                      #185.24
                                # LOE r12 r13 r14 r15 ebx
..B3.2:                         # Preds ..B3.1
                                # Execution count [1.00e+00]
        movl      %ebx, %eax                                    #185.5
        xorl      %edx, %edx                                    #185.5
        movl      $1, %ecx                                      #185.5
        xorl      %esi, %esi                                    #185.5
        shrl      $1, %eax                                      #185.5
        je        ..B3.6        # Prob 9%                       #185.5
                                # LOE rax rdx rsi r12 r13 r14 r15 ecx ebx
..B3.3:                         # Preds ..B3.2
                                # Execution count [9.00e-01]
        xorl      %ecx, %ecx                                    #185.5
        .align    16,0x90
                                # LOE rax rdx rcx rsi r12 r13 r14 r15 ebx
..B3.4:                         # Preds ..B3.4 ..B3.3
                                # Execution count [2.50e+00]
        movq      64(%r14), %rdi                                #186.9
        incq      %rdx                                          #185.5
        movq      %rcx, (%rdi,%rsi)                             #186.9
        movq      64(%r14), %r8                                 #187.9
        movq      %rcx, 8(%r8,%rsi)                             #187.9
        movq      64(%r14), %r9                                 #188.9
        movq      %rcx, 16(%r9,%rsi)                            #188.9
        movq      64(%r14), %r10                                #186.9
        movq      %rcx, 24(%r10,%rsi)                           #186.9
        movq      64(%r14), %r11                                #187.9
        movq      %rcx, 32(%r11,%rsi)                           #187.9
        movq      64(%r14), %rdi                                #188.9
        movq      %rcx, 40(%rdi,%rsi)                           #188.9
        addq      $48, %rsi                                     #185.5
        cmpq      %rax, %rdx                                    #185.5
        jb        ..B3.4        # Prob 63%                      #185.5
                                # LOE rax rdx rcx rsi r12 r13 r14 r15 ebx
..B3.5:                         # Preds ..B3.4
                                # Execution count [9.00e-01]
        lea       1(%rdx,%rdx), %ecx                            #186.9
                                # LOE r12 r13 r14 r15 ecx ebx
..B3.6:                         # Preds ..B3.5 ..B3.2
                                # Execution count [1.00e+00]
        lea       -1(%rcx), %eax                                #185.5
        cmpl      %ebx, %eax                                    #185.5
        jae       ..B3.9        # Prob 9%                       #185.5
                                # LOE r12 r13 r14 r15 ecx ebx
..B3.7:                         # Preds ..B3.6
                                # Execution count [9.00e-01]
        movslq    %ecx, %rcx                                    #186.9
        xorl      %esi, %esi                                    #186.9
        movq      64(%r14), %rax                                #186.9
        lea       (%rcx,%rcx,2), %r8                            #186.9
        movq      %rsi, -24(%rax,%r8,8)                         #186.9
        movq      64(%r14), %rdx                                #187.9
        movq      %rsi, -16(%rdx,%r8,8)                         #187.9
        movq      64(%r14), %rdi                                #188.9
        movq      %rsi, -8(%rdi,%r8,8)                          #188.9
                                # LOE r12 r13 r14 r15 ebx
..B3.9:                         # Preds ..B3.7 ..B3.6 ..B3.1
                                # Execution count [5.00e-01]
        xorl      %eax, %eax                                    #191.16
..___tag_value_computeForceLJFullNeigh_simd.123:
#       getTimeStamp()
        call      getTimeStamp                                  #191.16
..___tag_value_computeForceLJFullNeigh_simd.124:
                                # LOE r12 r13 r14 r15 ebx xmm0
..B3.25:                        # Preds ..B3.9
                                # Execution count [5.00e-01]
        vmovsd    %xmm0, 192(%rsp)                              #191.16[spill]
                                # LOE r12 r13 r14 r15 ebx
..B3.10:                        # Preds ..B3.25
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.0, %edi                         #192.5
..___tag_value_computeForceLJFullNeigh_simd.126:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #192.5
..___tag_value_computeForceLJFullNeigh_simd.127:
                                # LOE r12 r13 r14 r15 ebx
..B3.11:                        # Preds ..B3.10
                                # Execution count [1.00e+00]
        vmovsd    8(%rsp), %xmm0                                #198.36[spill]
        xorl      %ecx, %ecx                                    #206.9
        vmulsd    %xmm0, %xmm0, %xmm1                           #198.36
        xorl      %r10d, %r10d                                  #205.5
        vbroadcastsd 16(%rsp), %zmm10                           #199.32[spill]
        vbroadcastsd (%rsp), %zmm9                              #200.29[spill]
        vbroadcastsd %xmm1, %zmm11                              #198.36
        vbroadcastsd .L_2il0floatpacket.3(%rip), %zmm8          #201.29
        vbroadcastsd .L_2il0floatpacket.9(%rip), %zmm13         #202.29
        xorl      %edx, %edx                                    #206.9
        testl     %ebx, %ebx                                    #205.24
        jle       ..B3.19       # Prob 9%                       #205.24
                                # LOE rdx rcx r12 r13 r14 r15 ebx r10d zmm8 zmm9 zmm10 zmm11 zmm13
..B3.12:                        # Preds ..B3.11
                                # Execution count [9.00e-01]
        vmovdqu   .L_2il0floatpacket.10(%rip), %ymm12           #218.101
        vmovups   .L_2il0floatpacket.6(%rip), %zmm0             #241.23
        vpxord    %zmm1, %zmm1, %zmm1                           #212.29
                                # LOE rdx rcx r12 r13 r14 r15 ebx r10d ymm12 zmm0 zmm1 zmm8 zmm9 zmm10 zmm11 zmm13
..B3.13:                        # Preds ..B3.17 ..B3.12
                                # Execution count [5.00e+00]
        movl      %r10d, %edi                                   #206.43
        xorl      %r9d, %r9d                                    #216.9
        imull     8(%r15), %edi                                 #206.43
        movslq    %edi, %rdi                                    #206.19
        movq      24(%r15), %rsi                                #207.25
        movq      16(%r15), %rax                                #206.19
        movq      16(%r14), %r8                                 #209.45
        vmovaps   %zmm1, %zmm3                                  #212.29
        vmovaps   %zmm3, %zmm2                                  #213.29
        lea       (%rax,%rdi,4), %rdi                           #206.19
        movl      (%rsi,%rcx,4), %esi                           #207.25
        xorl      %eax, %eax                                    #218.78
        vmovaps   %zmm2, %zmm7                                  #214.29
        vpbroadcastd %esi, %ymm6                                #208.37
        vbroadcastsd (%r8,%rdx,8), %zmm5                        #209.30
        vbroadcastsd 8(%r8,%rdx,8), %zmm4                       #210.30
        vbroadcastsd 16(%r8,%rdx,8), %zmm14                     #211.30
        testl     %esi, %esi                                    #216.28
        jle       ..B3.17       # Prob 10%                      #216.28
                                # LOE rdx rcx rdi r8 r12 r13 r14 r15 eax ebx esi r9d r10d ymm6 ymm12 zmm0 zmm1 zmm2 zmm3 zmm4 zmm5 zmm7 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B3.14:                        # Preds ..B3.13
                                # Execution count [4.50e+00]
        addl      $7, %esi                                      #207.25
        shrl      $3, %esi                                      #207.25
                                # LOE rdx rcx rdi r8 r12 r13 r14 r15 eax ebx esi r9d r10d ymm6 ymm12 zmm0 zmm1 zmm2 zmm3 zmm4 zmm5 zmm7 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B3.15:                        # Preds ..B3.15 ..B3.14
                                # Execution count [2.50e+01]
        vpbroadcastd %eax, %ymm15                               #218.78
        incl      %r9d                                          #216.9
        vpcmpeqb  %xmm0, %xmm0, %k4                             #224.41
        vpcmpeqb  %xmm0, %xmm0, %k3                             #223.41
        vpcmpeqb  %xmm0, %xmm0, %k2                             #222.41
        vpaddd    %ymm12, %ymm15, %ymm16                        #218.65
        vpcmpgtd  %ymm16, %ymm6, %k1                            #218.43
        movslq    %eax, %rax                                    #219.29
        kmovw     %k1, %r11d                                    #218.43
        kmovb     %r11d, %k5                                    #231.40
        vmovdqu32 (%rdi,%rax,4), %ymm18{%k1}{z}                 #219.29
        addl      $8, %eax                                      #216.9
        vpaddd    %ymm18, %ymm18, %ymm17                        #221.43
        vpaddd    %ymm18, %ymm17, %ymm19                        #221.30
        vpxord    %zmm22, %zmm22, %zmm22                        #224.41
        vpxord    %zmm21, %zmm21, %zmm21                        #223.41
        vpxord    %zmm20, %zmm20, %zmm20                        #222.41
        vgatherdpd 16(%r8,%ymm19,8), %zmm22{%k4}                #224.41
        vgatherdpd 8(%r8,%ymm19,8), %zmm21{%k3}                 #223.41
        vgatherdpd (%r8,%ymm19,8), %zmm20{%k2}                  #222.41
        vsubpd    %zmm22, %zmm14, %zmm16                        #224.41
        vsubpd    %zmm21, %zmm4, %zmm15                         #223.41
        vsubpd    %zmm20, %zmm5, %zmm31                         #222.41
        vmulpd    %zmm16, %zmm16, %zmm23                        #230.75
        vfmadd231pd %zmm15, %zmm15, %zmm23                      #230.54
        vfmadd231pd %zmm31, %zmm31, %zmm23                      #230.33
        vrcp14pd  %zmm23, %zmm25                                #232.33
        vcmppd    $17, %zmm11, %zmm23, %k0                      #231.70
        vmulpd    %zmm10, %zmm25, %zmm24                        #233.61
        vmulpd    %zmm9, %zmm25, %zmm27                         #234.100
        kmovw     %k0, %r11d                                    #231.70
        vmulpd    %zmm24, %zmm25, %zmm26                        #233.47
        vmulpd    %zmm26, %zmm25, %zmm28                        #233.33
        vfmsub213pd %zmm13, %zmm25, %zmm26                      #234.76
        vmulpd    %zmm27, %zmm26, %zmm29                        #234.67
        vmulpd    %zmm29, %zmm28, %zmm30                        #234.53
        vmulpd    %zmm30, %zmm8, %zmm23                         #234.35
        kmovb     %r11d, %k6                                    #231.40
        kandb     %k6, %k5, %k7                                 #231.40
        kmovb     %k7, %r11d                                    #231.40
        kmovw     %r11d, %k1                                    #236.19
        vfmadd231pd %zmm31, %zmm23, %zmm3{%k1}                  #236.19
        vfmadd231pd %zmm15, %zmm23, %zmm2{%k1}                  #237.19
        vfmadd231pd %zmm16, %zmm23, %zmm7{%k1}                  #238.19
        cmpl      %esi, %r9d                                    #216.9
        jb        ..B3.15       # Prob 82%                      #216.9
                                # LOE rdx rcx rdi r8 r12 r13 r14 r15 eax ebx esi r9d r10d ymm6 ymm12 zmm0 zmm1 zmm2 zmm3 zmm4 zmm5 zmm7 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B3.17:                        # Preds ..B3.15 ..B3.13
                                # Execution count [5.00e+00]
        vpermd    %zmm3, %zmm0, %zmm4                           #241.23
        incl      %r10d                                         #205.5
        vpermd    %zmm2, %zmm0, %zmm18                          #242.23
        vpermd    %zmm7, %zmm0, %zmm25                          #243.23
        vaddpd    %zmm3, %zmm4, %zmm5                           #241.23
        vaddpd    %zmm2, %zmm18, %zmm19                         #242.23
        vaddpd    %zmm7, %zmm25, %zmm26                         #243.23
        vshuff64x2 $17, %zmm5, %zmm5, %zmm3                     #241.23
        vshuff64x2 $17, %zmm19, %zmm19, %zmm2                   #242.23
        vshuff64x2 $17, %zmm26, %zmm26, %zmm7                   #243.23
        vaddpd    %zmm5, %zmm3, %zmm14                          #241.23
        vaddpd    %zmm19, %zmm2, %zmm21                         #242.23
        vaddpd    %zmm26, %zmm7, %zmm28                         #243.23
        vpermilpd $1, %zmm14, %zmm6                             #241.23
        incq      %rcx                                          #205.5
        vaddpd    %zmm14, %zmm6, %zmm15                         #241.23
        vmovups   %zmm15, (%rsp)                                #241.23
        movq      64(%r14), %rax                                #241.9
        vpermilpd $1, %zmm21, %zmm20                            #242.23
        vaddpd    %zmm21, %zmm20, %zmm22                        #242.23
        vmovsd    (%rax,%rdx,8), %xmm16                         #241.9
        vaddsd    (%rsp), %xmm16, %xmm17                        #241.9
        vmovups   %zmm22, 64(%rsp)                              #242.23
        vmovsd    %xmm17, (%rax,%rdx,8)                         #241.9
        movq      64(%r14), %rsi                                #242.9
        vpermilpd $1, %zmm28, %zmm27                            #243.23
        vaddpd    %zmm28, %zmm27, %zmm29                        #243.23
        vmovsd    8(%rsi,%rdx,8), %xmm23                        #242.9
        vaddsd    64(%rsp), %xmm23, %xmm24                      #242.9
        vmovups   %zmm29, 128(%rsp)                             #243.23
        vmovsd    %xmm24, 8(%rsi,%rdx,8)                        #242.9
        movq      64(%r14), %rdi                                #243.9
        vmovsd    16(%rdi,%rdx,8), %xmm30                       #243.9
        vaddsd    128(%rsp), %xmm30, %xmm31                     #243.9
        vmovsd    %xmm31, 16(%rdi,%rdx,8)                       #243.9
        addq      $3, %rdx                                      #205.5
        cmpl      %ebx, %r10d                                   #205.5
        jb        ..B3.13       # Prob 82%                      #205.5
                                # LOE rdx rcx r12 r13 r14 r15 ebx r10d ymm12 zmm0 zmm1 zmm8 zmm9 zmm10 zmm11 zmm13
..B3.19:                        # Preds ..B3.17 ..B3.11
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.0, %edi                         #247.5
        vzeroupper                                              #247.5
..___tag_value_computeForceLJFullNeigh_simd.131:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #247.5
..___tag_value_computeForceLJFullNeigh_simd.132:
                                # LOE r12 r13
..B3.20:                        # Preds ..B3.19
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #248.16
..___tag_value_computeForceLJFullNeigh_simd.133:
#       getTimeStamp()
        call      getTimeStamp                                  #248.16
..___tag_value_computeForceLJFullNeigh_simd.134:
                                # LOE r12 r13 xmm0
..B3.21:                        # Preds ..B3.20
                                # Execution count [1.00e+00]
        vsubsd    192(%rsp), %xmm0, %xmm0                       #249.14[spill]
        addq      $232, %rsp                                    #249.14
	.cfi_restore 3
        popq      %rbx                                          #249.14
	.cfi_restore 15
        popq      %r15                                          #249.14
	.cfi_restore 14
        popq      %r14                                          #249.14
        movq      %rbp, %rsp                                    #249.14
        popq      %rbp                                          #249.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #249.14
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
.L_2il0floatpacket.10:
	.long	0x00000000,0x00000001,0x00000002,0x00000003,0x00000004,0x00000005,0x00000006,0x00000007
	.type	.L_2il0floatpacket.10,@object
	.size	.L_2il0floatpacket.10,32
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
	.long	0x00000000,0x3fe00000
	.type	.L_2il0floatpacket.9,@object
	.size	.L_2il0floatpacket.9,8
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
	.data
	.section .note.GNU-stack, ""
# End
