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
        testl     %r15d, %r15d                                  #33.24
        jle       ..B1.27       # Prob 50%                      #33.24
                                # LOE rbx r12 r13 r14 r15d
..B1.2:                         # Preds ..B1.1
                                # Execution count [5.00e-03]
        movq      64(%r13), %rdi                                #34.9
        lea       (%r15,%r15,2), %esi                           #22.18
        cmpl      $12, %esi                                     #33.5
        jle       ..B1.34       # Prob 0%                       #33.5
                                # LOE rbx rdi r12 r13 r14 esi r15d
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
        movslq    %r15d, %r15                                   #33.5
        xorl      %esi, %esi                                    #33.5
        lea       (%r15,%r15,2), %rdx                           #33.5
        shlq      $3, %rdx                                      #33.5
        call      __intel_skx_avx512_memset                     #33.5
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
        movl      $.L_2__STRING.0, %edi                         #42.5
..___tag_value_computeForceLJFullNeigh_plain_c.16:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #42.5
..___tag_value_computeForceLJFullNeigh_plain_c.17:
                                # LOE rbx r12 r13 r14 r15
..B1.6:                         # Preds ..B1.5
                                # Execution count [9.00e-01]
        vmovsd    32(%rsp), %xmm13                              #25.45[spill]
        xorl      %esi, %esi                                    #45.15
        vmovsd    24(%rsp), %xmm0                               #77.42[spill]
        xorl      %edi, %edi                                    #45.5
        vmulsd    %xmm13, %xmm13, %xmm14                        #25.45
        xorl      %eax, %eax                                    #45.5
        vmovdqu32 .L_2il0floatpacket.0(%rip), %ymm16            #59.9
        vmulsd    .L_2il0floatpacket.3(%rip), %xmm0, %xmm1      #77.42
        vmovdqu   .L_2il0floatpacket.1(%rip), %ymm15            #59.9
        vmovups   .L_2il0floatpacket.4(%rip), %zmm5             #77.55
        vbroadcastsd %xmm14, %zmm14                             #25.25
        vbroadcastsd 16(%rsp), %zmm13                           #26.21[spill]
        vbroadcastsd %xmm1, %zmm12                              #77.42
        movq      24(%rbx), %r11                                #47.25
        movq      64(%r13), %r10                                #89.9
        movq      16(%rbx), %r9                                 #46.19
        movslq    8(%rbx), %r8                                  #46.43
        shlq      $2, %r8                                       #23.5
        movq      16(%r13), %rbx                                #48.25
        movq      (%r14), %rdx                                  #93.9
        movq      8(%r14), %rcx                                 #94.9
        movq      %r10, 48(%rsp)                                #45.5[spill]
        movq      %r11, 56(%rsp)                                #45.5[spill]
        movq      %r15, 64(%rsp)                                #45.5[spill]
        movq      %r14, (%rsp)                                  #45.5[spill]
        movq      %r12, 8(%rsp)                                 #45.5[spill]
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0x88, 0xff, 0xff, 0xff, 0x22
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 ymm15 ymm16 zmm5 zmm12 zmm13 zmm14
..B1.7:                         # Preds ..B1.25 ..B1.6
                                # Execution count [5.00e+00]
        movq      56(%rsp), %r10                                #47.25[spill]
        vxorpd    %xmm24, %xmm24, %xmm24                        #51.22
        vmovapd   %xmm24, %xmm18                                #52.22
        movl      (%r10,%rdi,4), %r13d                          #47.25
        vmovapd   %xmm18, %xmm4                                 #53.22
        vmovsd    (%rax,%rbx), %xmm11                           #48.25
        vmovsd    8(%rax,%rbx), %xmm6                           #49.25
        vmovsd    16(%rax,%rbx), %xmm7                          #50.25
        testl     %r13d, %r13d                                  #59.28
        jle       ..B1.25       # Prob 50%                      #59.28
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r13d xmm4 xmm6 xmm7 xmm11 xmm18 xmm24 ymm15 ymm16 zmm5 zmm12 zmm13 zmm14
..B1.8:                         # Preds ..B1.7
                                # Execution count [4.50e+00]
        vpxord    %zmm10, %zmm10, %zmm10                        #51.22
        vmovaps   %zmm10, %zmm9                                 #52.22
        vmovaps   %zmm9, %zmm8                                  #53.22
        cmpl      $8, %r13d                                     #59.9
        jl        ..B1.33       # Prob 10%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.9:                         # Preds ..B1.8
                                # Execution count [4.50e+00]
        cmpl      $1200, %r13d                                  #59.9
        jl        ..B1.32       # Prob 10%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.10:                        # Preds ..B1.9
                                # Execution count [4.50e+00]
        movq      %r8, %r10                                     #46.43
        imulq     %rsi, %r10                                    #46.43
        addq      %r9, %r10                                     #23.5
        movq      %r10, %r12                                    #59.9
        andq      $63, %r12                                     #59.9
        testl     $3, %r12d                                     #59.9
        je        ..B1.12       # Prob 50%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.11:                        # Preds ..B1.10
                                # Execution count [2.25e+00]
        xorl      %r12d, %r12d                                  #59.9
        jmp       ..B1.14       # Prob 100%                     #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.12:                        # Preds ..B1.10
                                # Execution count [2.25e+00]
        testl     %r12d, %r12d                                  #59.9
        je        ..B1.14       # Prob 50%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.13:                        # Preds ..B1.12
                                # Execution count [2.50e+01]
        negl      %r12d                                         #59.9
        addl      $64, %r12d                                    #59.9
        shrl      $2, %r12d                                     #59.9
        cmpl      %r12d, %r13d                                  #59.9
        cmovl     %r13d, %r12d                                  #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.14:                        # Preds ..B1.11 ..B1.13 ..B1.12
                                # Execution count [5.00e+00]
        movl      %r13d, %r11d                                  #59.9
        subl      %r12d, %r11d                                  #59.9
        andl      $7, %r11d                                     #59.9
        negl      %r11d                                         #59.9
        addl      %r13d, %r11d                                  #59.9
        cmpl      $1, %r12d                                     #59.9
        jb        ..B1.18       # Prob 50%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.15:                        # Preds ..B1.14
                                # Execution count [4.50e+00]
        vmovdqa32 %ymm16, %ymm4                                 #59.9
        xorl      %r15d, %r15d                                  #59.9
        vpbroadcastd %r12d, %ymm3                               #59.9
        vbroadcastsd %xmm11, %zmm2                              #48.23
        vbroadcastsd %xmm6, %zmm1                               #49.23
        vbroadcastsd %xmm7, %zmm0                               #50.23
        movslq    %r12d, %r14                                   #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r15 r11d r12d r13d xmm6 xmm7 xmm11 ymm3 ymm4 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
movl      $111, %ebx # OSACA START MARKER
.byte     100        # OSACA START MARKER
.byte     103        # OSACA START MARKER
.byte     144        # OSACA START MARKER
# pointer_increment=64 1303ca335e79351a96cfc07b8b9ec9d4
# LLVM-MCA-BEGIN
..B1.16:                        # Preds ..B1.16 ..B1.15
                                # Execution count [2.50e+01]
        vpcmpgtd  %ymm4, %ymm3, %k5                             #59.9
        vpaddd    %ymm15, %ymm4, %ymm4                          #59.9
        vmovdqu32 (%r10,%r15,4), %ymm17{%k5}{z}                 #60.21
        vpaddd    %ymm17, %ymm17, %ymm18                        #61.36
        addq      $8, %r15                                      #59.9
        vpaddd    %ymm18, %ymm17, %ymm19                        #61.36
        kmovw     %k5, %k2                                      #61.36
        kmovw     %k5, %k3                                      #61.36
        kmovw     %k5, %k1                                      #61.36
        vpxord    %zmm21, %zmm21, %zmm21                        #61.36
        vpxord    %zmm20, %zmm20, %zmm20                        #61.36
        vpxord    %zmm22, %zmm22, %zmm22                        #61.36
        vgatherdpd 8(%rbx,%ymm19,8), %zmm21{%k2}                #61.36
        vgatherdpd (%rbx,%ymm19,8), %zmm20{%k3}                 #61.36
        vgatherdpd 16(%rbx,%ymm19,8), %zmm22{%k1}               #61.36
        vsubpd    %zmm21, %zmm1, %zmm18                         #62.36
        vsubpd    %zmm20, %zmm2, %zmm17                         #61.36
        vsubpd    %zmm22, %zmm0, %zmm19                         #63.36
        vmulpd    %zmm18, %zmm18, %zmm31                        #64.49
        vfmadd231pd %zmm17, %zmm17, %zmm31                      #64.49
        vfmadd231pd %zmm19, %zmm19, %zmm31                      #64.63
        vrcp14pd  %zmm31, %zmm30                                #75.39
        vcmppd    $1, %zmm14, %zmm31, %k6{%k5}                  #74.22
        vfpclasspd $30, %zmm30, %k0                             #75.39
        vmovaps   %zmm31, %zmm23                                #75.39
        vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm30, %zmm23 #75.39
        knotw     %k0, %k4                                      #75.39
        vmulpd    %zmm23, %zmm23, %zmm24                        #75.39
        vfmadd213pd %zmm30, %zmm23, %zmm30{%k4}                 #75.39
        vfmadd213pd %zmm30, %zmm24, %zmm30{%k4}                 #75.39
        vmulpd    %zmm13, %zmm30, %zmm25                        #76.38
        vmulpd    %zmm12, %zmm30, %zmm27                        #77.55
        vmulpd    %zmm25, %zmm30, %zmm28                        #76.44
        vmulpd    %zmm28, %zmm30, %zmm26                        #76.50
        vfmsub213pd %zmm5, %zmm28, %zmm30                       #77.55
        vmulpd    %zmm27, %zmm26, %zmm29                        #77.64
        vmulpd    %zmm30, %zmm29, %zmm23                        #77.70
        vfmadd231pd %zmm17, %zmm23, %zmm10{%k6}                 #78.17
        vfmadd231pd %zmm18, %zmm23, %zmm9{%k6}                  #79.17
        vfmadd231pd %zmm19, %zmm23, %zmm8{%k6}                  #80.17
        cmpq      %r14, %r15                                    #59.9
        jb        ..B1.16       # Prob 82%                      #59.9
# LLVM-MCA-END
movl      $222, %ebx # OSACA END MARKER
.byte     100        # OSACA END MARKER
.byte     103        # OSACA END MARKER
.byte     144        # OSACA END MARKER
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r15 r11d r12d r13d xmm6 xmm7 xmm11 ymm3 ymm4 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.17:                        # Preds ..B1.16
                                # Execution count [4.50e+00]
        cmpl      %r12d, %r13d                                  #59.9
        je        ..B1.24       # Prob 10%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.18:                        # Preds ..B1.17 ..B1.14 ..B1.32
                                # Execution count [2.50e+01]
        lea       8(%r12), %r10d                                #59.9
        cmpl      %r10d, %r11d                                  #59.9
        jl        ..B1.22       # Prob 50%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.19:                        # Preds ..B1.18
                                # Execution count [4.50e+00]
        movq      %r8, %r10                                     #46.43
        imulq     %rsi, %r10                                    #46.43
        vbroadcastsd %xmm11, %zmm2                              #48.23
        vbroadcastsd %xmm6, %zmm1                               #49.23
        vbroadcastsd %xmm7, %zmm0                               #50.23
        movslq    %r12d, %r14                                   #59.9
        addq      %r9, %r10                                     #23.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r11d r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.20:                        # Preds ..B1.20 ..B1.19
                                # Execution count [2.50e+01]
        vmovdqu   (%r10,%r14,4), %ymm3                          #60.21
        addl      $8, %r12d                                     #59.9
        vpcmpeqb  %xmm0, %xmm0, %k2                             #61.36
        vpcmpeqb  %xmm0, %xmm0, %k3                             #61.36
        vpcmpeqb  %xmm0, %xmm0, %k1                             #61.36
        vpaddd    %ymm3, %ymm3, %ymm4                           #61.36
        vpaddd    %ymm4, %ymm3, %ymm17                          #61.36
        addq      $8, %r14                                      #59.9
        vpxord    %zmm19, %zmm19, %zmm19                        #61.36
        vpxord    %zmm18, %zmm18, %zmm18                        #61.36
        vpxord    %zmm20, %zmm20, %zmm20                        #61.36
        vgatherdpd 8(%rbx,%ymm17,8), %zmm19{%k2}                #61.36
        vgatherdpd (%rbx,%ymm17,8), %zmm18{%k3}                 #61.36
        vgatherdpd 16(%rbx,%ymm17,8), %zmm20{%k1}               #61.36
        vsubpd    %zmm19, %zmm1, %zmm30                         #62.36
        vsubpd    %zmm18, %zmm2, %zmm29                         #61.36
        vsubpd    %zmm20, %zmm0, %zmm3                          #63.36
        vmulpd    %zmm30, %zmm30, %zmm21                        #64.49
        vfmadd231pd %zmm29, %zmm29, %zmm21                      #64.49
        vfmadd231pd %zmm3, %zmm3, %zmm21                        #64.63
        vrcp14pd  %zmm21, %zmm28                                #75.39
        vcmppd    $1, %zmm14, %zmm21, %k5                       #74.22
        vfpclasspd $30, %zmm28, %k0                             #75.39
        vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm28, %zmm21 #75.39
        knotw     %k0, %k4                                      #75.39
        vmulpd    %zmm21, %zmm21, %zmm22                        #75.39
        vfmadd213pd %zmm28, %zmm21, %zmm28{%k4}                 #75.39
        vfmadd213pd %zmm28, %zmm22, %zmm28{%k4}                 #75.39
        vmulpd    %zmm13, %zmm28, %zmm23                        #76.38
        vmulpd    %zmm12, %zmm28, %zmm25                        #77.55
        vmulpd    %zmm23, %zmm28, %zmm26                        #76.44
        vmulpd    %zmm26, %zmm28, %zmm24                        #76.50
        vfmsub213pd %zmm5, %zmm26, %zmm28                       #77.55
        vmulpd    %zmm25, %zmm24, %zmm27                        #77.64
        vmulpd    %zmm28, %zmm27, %zmm31                        #77.70
        vfmadd231pd %zmm29, %zmm31, %zmm10{%k5}                 #78.17
        vfmadd231pd %zmm30, %zmm31, %zmm9{%k5}                  #79.17
        vfmadd231pd %zmm3, %zmm31, %zmm8{%k5}                   #80.17
        cmpl      %r11d, %r12d                                  #59.9
        jb        ..B1.20       # Prob 82%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r11d r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.22:                        # Preds ..B1.20 ..B1.18 ..B1.33
                                # Execution count [5.00e+00]
        lea       1(%r11), %r10d                                #59.9
        cmpl      %r13d, %r10d                                  #59.9
        ja        ..B1.24       # Prob 50%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.23:                        # Preds ..B1.22
                                # Execution count [2.50e+01]
        imulq     %r8, %rsi                                     #46.43
        vbroadcastsd %xmm7, %zmm17                              #50.23
        vbroadcastsd %xmm6, %zmm4                               #49.23
        vbroadcastsd %xmm11, %zmm2                              #48.23
        movl      %r13d, %r10d                                  #59.9
        addq      %r9, %rsi                                     #23.5
        subl      %r11d, %r10d                                  #59.9
        vpbroadcastd %r10d, %ymm7                               #59.9
        vpcmpgtd  %ymm16, %ymm7, %k5                            #59.9
        movslq    %r11d, %r11                                   #59.9
        kmovw     %k5, %k2                                      #61.36
        kmovw     %k5, %k3                                      #61.36
        kmovw     %k5, %k1                                      #61.36
        vmovdqu32 (%rsi,%r11,4), %ymm6{%k5}{z}                  #60.21
        vpaddd    %ymm6, %ymm6, %ymm0                           #61.36
        vpaddd    %ymm0, %ymm6, %ymm1                           #61.36
        vpxord    %zmm11, %zmm11, %zmm11                        #61.36
        vpxord    %zmm3, %zmm3, %zmm3                           #61.36
        vpxord    %zmm18, %zmm18, %zmm18                        #61.36
        vgatherdpd 8(%rbx,%ymm1,8), %zmm11{%k2}                 #61.36
        vgatherdpd (%rbx,%ymm1,8), %zmm3{%k3}                   #61.36
        vgatherdpd 16(%rbx,%ymm1,8), %zmm18{%k1}                #61.36
        vsubpd    %zmm11, %zmm4, %zmm29                         #62.36
        vsubpd    %zmm3, %zmm2, %zmm28                          #61.36
        vsubpd    %zmm18, %zmm17, %zmm31                        #63.36
        vmulpd    %zmm29, %zmm29, %zmm27                        #64.49
        vfmadd231pd %zmm28, %zmm28, %zmm27                      #64.49
        vfmadd231pd %zmm31, %zmm31, %zmm27                      #64.63
        vrcp14pd  %zmm27, %zmm26                                #75.39
        vcmppd    $1, %zmm14, %zmm27, %k6{%k5}                  #74.22
        vfpclasspd $30, %zmm26, %k0                             #75.39
        vmovaps   %zmm27, %zmm19                                #75.39
        vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm26, %zmm19 #75.39
        knotw     %k0, %k4                                      #75.39
        vmulpd    %zmm19, %zmm19, %zmm20                        #75.39
        vfmadd213pd %zmm26, %zmm19, %zmm26{%k4}                 #75.39
        vfmadd213pd %zmm26, %zmm20, %zmm26{%k4}                 #75.39
        vmulpd    %zmm13, %zmm26, %zmm21                        #76.38
        vmulpd    %zmm12, %zmm26, %zmm23                        #77.55
        vmulpd    %zmm21, %zmm26, %zmm24                        #76.44
        vmulpd    %zmm24, %zmm26, %zmm22                        #76.50
        vfmsub213pd %zmm5, %zmm24, %zmm26                       #77.55
        vmulpd    %zmm23, %zmm22, %zmm25                        #77.64
        vmulpd    %zmm26, %zmm25, %zmm30                        #77.70
        vfmadd231pd %zmm28, %zmm30, %zmm10{%k6}                 #78.17
        vfmadd231pd %zmm29, %zmm30, %zmm9{%k6}                  #79.17
        vfmadd231pd %zmm31, %zmm30, %zmm8{%k6}                  #80.17
                                # LOE rax rdx rcx rbx rdi r8 r9 r13d ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.24:                        # Preds ..B1.17 ..B1.23 ..B1.22
                                # Execution count [4.50e+00]
        vmovups   .L_2il0floatpacket.6(%rip), %zmm19            #53.22
        vpermd    %zmm8, %zmm19, %zmm0                          #53.22
        vpermd    %zmm9, %zmm19, %zmm6                          #52.22
        vpermd    %zmm10, %zmm19, %zmm20                        #51.22
        vaddpd    %zmm8, %zmm0, %zmm8                           #53.22
        vaddpd    %zmm9, %zmm6, %zmm9                           #52.22
        vaddpd    %zmm10, %zmm20, %zmm10                        #51.22
        vpermpd   $78, %zmm8, %zmm1                             #53.22
        vpermpd   $78, %zmm9, %zmm7                             #52.22
        vpermpd   $78, %zmm10, %zmm21                           #51.22
        vaddpd    %zmm1, %zmm8, %zmm2                           #53.22
        vaddpd    %zmm7, %zmm9, %zmm11                          #52.22
        vaddpd    %zmm21, %zmm10, %zmm22                        #51.22
        vpermpd   $177, %zmm2, %zmm3                            #53.22
        vpermpd   $177, %zmm11, %zmm17                          #52.22
        vpermpd   $177, %zmm22, %zmm23                          #51.22
        vaddpd    %zmm3, %zmm2, %zmm4                           #53.22
        vaddpd    %zmm17, %zmm11, %zmm18                        #52.22
        vaddpd    %zmm23, %zmm22, %zmm24                        #51.22
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
        addq      $24, %rax                                     #45.5
        movslq    %r11d, %r11                                   #94.9
        movslq    %edi, %rsi                                    #45.32
        incq      %rdi                                          #45.5
        addq      %r11, %rcx                                    #94.9
        incq      %rsi                                          #45.32
        cmpq      64(%rsp), %rdi                                #45.5[spill]
        jb        ..B1.7        # Prob 82%                      #45.5
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
        movl      $.L_2__STRING.0, %edi                         #42.5
..___tag_value_computeForceLJFullNeigh_plain_c.36:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #42.5
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
        xorl      %eax, %eax                                    #100.16
..___tag_value_computeForceLJFullNeigh_plain_c.40:
#       getTimeStamp()
        call      getTimeStamp                                  #100.16
..___tag_value_computeForceLJFullNeigh_plain_c.41:
                                # LOE r12 xmm0
..B1.31:                        # Preds ..B1.30
                                # Execution count [1.00e+00]
        vsubsd    40(%rsp), %xmm0, %xmm0                        #101.14[spill]
        addq      $96, %rsp                                     #101.14
	.cfi_restore 3
        popq      %rbx                                          #101.14
	.cfi_restore 15
        popq      %r15                                          #101.14
	.cfi_restore 14
        popq      %r14                                          #101.14
	.cfi_restore 13
        popq      %r13                                          #101.14
        movq      %rbp, %rsp                                    #101.14
        popq      %rbp                                          #101.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #101.14
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
        movl      %r13d, %r11d                                  #59.9
        xorl      %r12d, %r12d                                  #59.9
        andl      $-8, %r11d                                    #59.9
        jmp       ..B1.18       # Prob 100%                     #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r12d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.33:                        # Preds ..B1.8
                                # Execution count [4.50e-01]: Infreq
        xorl      %r11d, %r11d                                  #59.9
        jmp       ..B1.22       # Prob 100%                     #59.9
	.cfi_restore 12
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r13d xmm6 xmm7 xmm11 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm12 zmm13 zmm14
..B1.34:                        # Preds ..B1.2
                                # Execution count [1.00e+00]: Infreq
        cmpl      $8, %esi                                      #33.5
        jl        ..B1.40       # Prob 10%                      #33.5
                                # LOE rbx rdi r12 r13 r14 esi r15d
..B1.35:                        # Preds ..B1.34
                                # Execution count [1.00e+00]: Infreq
        movl      %esi, %eax                                    #33.5
        xorl      %ecx, %ecx                                    #33.5
        andl      $-8, %eax                                     #33.5
        movslq    %eax, %rdx                                    #33.5
        vpxord    %zmm0, %zmm0, %zmm0                           #34.22
                                # LOE rdx rcx rbx rdi r12 r13 r14 eax esi r15d zmm0
..B1.36:                        # Preds ..B1.36 ..B1.35
                                # Execution count [5.56e+00]: Infreq
        vmovupd   %zmm0, (%rdi,%rcx,8)                          #34.9
        addq      $8, %rcx                                      #33.5
        cmpq      %rdx, %rcx                                    #33.5
        jb        ..B1.36       # Prob 82%                      #33.5
                                # LOE rdx rcx rbx rdi r12 r13 r14 eax esi r15d zmm0
..B1.38:                        # Preds ..B1.36 ..B1.40
                                # Execution count [1.11e+00]: Infreq
        lea       1(%rax), %edx                                 #33.5
        cmpl      %esi, %edx                                    #33.5
        ja        ..B1.46       # Prob 50%                      #33.5
                                # LOE rbx rdi r12 r13 r14 eax esi r15d
..B1.39:                        # Preds ..B1.38
                                # Execution count [5.56e+00]: Infreq
        subl      %eax, %esi                                    #33.5
        vpbroadcastd %esi, %ymm0                                #33.5
        vpcmpgtd  .L_2il0floatpacket.0(%rip), %ymm0, %k1        #33.5
        movslq    %eax, %rax                                    #33.5
        movslq    %r15d, %r15                                   #33.5
        vpxord    %zmm1, %zmm1, %zmm1                           #34.22
        vmovupd   %zmm1, (%rdi,%rax,8){%k1}                     #34.9
        jmp       ..B1.4        # Prob 100%                     #34.9
                                # LOE rbx r12 r13 r14 r15
..B1.40:                        # Preds ..B1.34
                                # Execution count [1.00e-01]: Infreq
        xorl      %eax, %eax                                    #33.5
        jmp       ..B1.38       # Prob 100%                     #33.5
                                # LOE rbx rdi r12 r13 r14 eax esi r15d
..B1.46:                        # Preds ..B1.38
                                # Execution count [5.56e-01]: Infreq
        movslq    %r15d, %r15                                   #33.5
        jmp       ..B1.4        # Prob 100%                     #33.5
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
                                                         #104.96
        pushq     %rbp                                          #104.96
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #104.96
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #104.96
        pushq     %r12                                          #104.96
        pushq     %r13                                          #104.96
        pushq     %r14                                          #104.96
        pushq     %r15                                          #104.96
        pushq     %rbx                                          #104.96
        subq      $88, %rsp                                     #104.96
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
        movq      %rsi, %r13                                    #104.96
        vmovsd    144(%rdi), %xmm0                              #108.27
        movq      %rcx, %r14                                    #104.96
        vmovsd    56(%rdi), %xmm1                               #109.23
        movq      %rdx, %r12                                    #104.96
        vmovsd    40(%rdi), %xmm2                               #110.24
        movl      4(%r13), %ebx                                 #105.18
        vmovsd    %xmm0, 24(%rsp)                               #108.27[spill]
        vmovsd    %xmm1, 32(%rsp)                               #109.23[spill]
        vmovsd    %xmm2, 16(%rsp)                               #110.24[spill]
        testl     %ebx, %ebx                                    #113.24
        jle       ..B2.28       # Prob 50%                      #113.24
                                # LOE r12 r13 r14 ebx
..B2.2:                         # Preds ..B2.1
                                # Execution count [5.00e-03]
        movq      64(%r13), %rdi                                #114.9
        lea       (%rbx,%rbx,2), %esi                           #105.18
        cmpl      $12, %esi                                     #113.5
        jle       ..B2.35       # Prob 0%                       #113.5
                                # LOE rdi r12 r13 r14 ebx esi
..B2.3:                         # Preds ..B2.2
                                # Execution count [1.00e+00]
        movslq    %ebx, %r15                                    #113.5
        xorl      %esi, %esi                                    #113.5
        lea       (%r15,%r15,2), %rdx                           #113.5
        shlq      $3, %rdx                                      #113.5
        call      __intel_skx_avx512_memset                     #113.5
                                # LOE r12 r13 r14 r15 ebx
..B2.4:                         # Preds ..B2.3 ..B2.47 ..B2.40
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #119.16
        vzeroupper                                              #119.16
..___tag_value_computeForceLJHalfNeigh.71:
#       getTimeStamp()
        call      getTimeStamp                                  #119.16
..___tag_value_computeForceLJHalfNeigh.72:
                                # LOE r12 r13 r14 r15 ebx xmm0
..B2.44:                        # Preds ..B2.4
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 8(%rsp)                                #119.16[spill]
                                # LOE r12 r13 r14 r15 ebx
..B2.5:                         # Preds ..B2.44
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.1, %edi                         #123.5
..___tag_value_computeForceLJHalfNeigh.74:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #123.5
..___tag_value_computeForceLJHalfNeigh.75:
                                # LOE r12 r13 r14 r15 ebx
..B2.6:                         # Preds ..B2.5
                                # Execution count [9.00e-01]
        vmovsd    24(%rsp), %xmm9                               #108.45[spill]
        xorl      %r10d, %r10d                                  #126.15
        vmovsd    16(%rsp), %xmm0                               #162.41[spill]
        xorl      %r9d, %r9d                                    #126.5
        vmulsd    %xmm9, %xmm9, %xmm10                          #108.45
        xorl      %eax, %eax                                    #126.5
        vmovdqu   .L_2il0floatpacket.0(%rip), %ymm14            #144.9
        vmulsd    .L_2il0floatpacket.3(%rip), %xmm0, %xmm1      #162.41
        vmovdqu   .L_2il0floatpacket.1(%rip), %ymm13            #144.9
        vmovdqu   .L_2il0floatpacket.7(%rip), %ymm12            #147.36
        vmovdqu   .L_2il0floatpacket.8(%rip), %ymm11            #148.36
        vmovups   .L_2il0floatpacket.4(%rip), %zmm5             #162.54
        vpbroadcastd %ebx, %ymm4                                #105.18
        vbroadcastsd %xmm10, %zmm10                             #108.25
        vbroadcastsd 32(%rsp), %zmm9                            #109.21[spill]
        vbroadcastsd %xmm1, %zmm7                               #162.41
        movq      24(%r12), %r11                                #128.25
        movslq    8(%r12), %rdi                                 #127.43
        movq      16(%r12), %r8                                 #127.19
        shlq      $2, %rdi                                      #106.5
        movq      16(%r13), %rsi                                #129.25
        movq      64(%r13), %rdx                                #169.21
        movq      (%r14), %rcx                                  #180.9
        movq      8(%r14), %rbx                                 #181.9
        movq      %r11, 40(%rsp)                                #126.5[spill]
        movq      %r15, 48(%rsp)                                #126.5[spill]
        movq      %r14, (%rsp)                                  #126.5[spill]
        vpxord    %zmm15, %zmm15, %zmm15                        #126.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 ymm4 ymm11 ymm12 ymm13 ymm14 zmm5 zmm7 zmm9 zmm10 zmm15
..B2.7:                         # Preds ..B2.26 ..B2.6
                                # Execution count [5.00e+00]
        movq      40(%rsp), %r11                                #128.25[spill]
        vxorpd    %xmm27, %xmm27, %xmm27                        #132.22
        vmovapd   %xmm27, %xmm21                                #133.22
        movl      (%r11,%r9,4), %r11d                           #128.25
        vmovapd   %xmm21, %xmm3                                 #134.22
        vmovsd    (%rax,%rsi), %xmm1                            #129.25
        vmovsd    8(%rax,%rsi), %xmm0                           #130.25
        vmovsd    16(%rax,%rsi), %xmm2                          #131.25
        testl     %r11d, %r11d                                  #144.9
        jle       ..B2.26       # Prob 50%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d xmm0 xmm1 xmm2 xmm3 xmm21 xmm27 ymm4 ymm11 ymm12 ymm13 ymm14 zmm5 zmm7 zmm9 zmm10 zmm15
..B2.8:                         # Preds ..B2.7
                                # Execution count [2.50e+00]
        jbe       ..B2.26       # Prob 50%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d xmm0 xmm1 xmm2 xmm3 xmm21 xmm27 ymm4 ymm11 ymm12 ymm13 ymm14 zmm5 zmm7 zmm9 zmm10 zmm15
..B2.9:                         # Preds ..B2.8
                                # Execution count [2.25e+00]
        vmovaps   %zmm15, %zmm8                                 #132.22
        vmovaps   %zmm8, %zmm6                                  #133.22
        vmovaps   %zmm6, %zmm3                                  #134.22
        cmpl      $8, %r11d                                     #144.9
        jb        ..B2.34       # Prob 10%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.10:                        # Preds ..B2.9
                                # Execution count [2.25e+00]
        cmpl      $1200, %r11d                                  #144.9
        jb        ..B2.33       # Prob 10%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.11:                        # Preds ..B2.10
                                # Execution count [2.25e+00]
        movq      %rdi, %r15                                    #127.43
        imulq     %r10, %r15                                    #127.43
        addq      %r8, %r15                                     #106.5
        movq      %r15, %r12                                    #144.9
        andq      $63, %r12                                     #144.9
        testl     $3, %r12d                                     #144.9
        je        ..B2.13       # Prob 50%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r15 r11d r12d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.12:                        # Preds ..B2.11
                                # Execution count [1.12e+00]
        movl      %r11d, %r14d                                  #144.9
        xorl      %r12d, %r12d                                  #144.9
        andl      $7, %r14d                                     #144.9
        negl      %r14d                                         #144.9
        addl      %r11d, %r14d                                  #144.9
        jmp       ..B2.19       # Prob 100%                     #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.13:                        # Preds ..B2.11
                                # Execution count [1.12e+00]
        testl     %r12d, %r12d                                  #144.9
        je        ..B2.18       # Prob 50%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r15 r11d r12d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.14:                        # Preds ..B2.13
                                # Execution count [1.25e+01]
        negl      %r12d                                         #144.9
        movl      %r11d, %r14d                                  #144.9
        addl      $64, %r12d                                    #144.9
        shrl      $2, %r12d                                     #144.9
        cmpl      %r12d, %r11d                                  #144.9
        cmovb     %r11d, %r12d                                  #144.9
        subl      %r12d, %r14d                                  #144.9
        andl      $7, %r14d                                     #144.9
        negl      %r14d                                         #144.9
        addl      %r11d, %r14d                                  #144.9
        cmpl      $1, %r12d                                     #144.9
        jb        ..B2.19       # Prob 50%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r15 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.15:                        # Preds ..B2.14
                                # Execution count [2.25e+00]
        vpbroadcastd %r12d, %ymm28                              #144.9
        xorl      %r13d, %r13d                                  #144.9
        vbroadcastsd %xmm1, %zmm27                              #129.23
        vbroadcastsd %xmm0, %zmm26                              #130.23
        vbroadcastsd %xmm2, %zmm25                              #131.23
        movslq    %r12d, %r12                                   #144.9
        movq      %r10, 16(%rsp)                                #144.9[spill]
        vmovdqa32 %ymm14, %ymm29                                #144.9
        movq      %r12, %r10                                    #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r13 r15 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 ymm28 ymm29 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15 zmm25 zmm26 zmm27
..B2.16:                        # Preds ..B2.16 ..B2.15
                                # Execution count [1.25e+01]
        vpcmpud   $1, %ymm28, %ymm29, %k4                       #144.9
        vpaddd    %ymm13, %ymm29, %ymm29                        #144.9
        vmovdqu32 (%r15,%r13,4), %ymm21{%k4}{z}                 #145.21
        vpaddd    %ymm21, %ymm21, %ymm30                        #146.36
        addq      $8, %r13                                      #144.9
        vpcmpgtd  %ymm21, %ymm4, %k6                            #168.24
        vpaddd    %ymm30, %ymm21, %ymm24                        #146.36
        kmovw     %k4, %k2                                      #146.36
        kmovw     %k4, %k3                                      #146.36
        kmovw     %k4, %k1                                      #146.36
        vpxord    %zmm16, %zmm16, %zmm16                        #146.36
        vpxord    %zmm31, %zmm31, %zmm31                        #146.36
        vpxord    %zmm20, %zmm20, %zmm20                        #146.36
        vpaddd    %ymm12, %ymm24, %ymm17                        #147.36
        vgatherdpd 8(%rsi,%ymm24,8), %zmm16{%k2}                #146.36
        vgatherdpd (%rsi,%ymm24,8), %zmm31{%k3}                 #146.36
        vgatherdpd 16(%rsi,%ymm24,8), %zmm20{%k1}               #146.36
        vsubpd    %zmm16, %zmm26, %zmm22                        #147.36
        vsubpd    %zmm31, %zmm27, %zmm23                        #146.36
        vsubpd    %zmm20, %zmm25, %zmm20                        #148.36
        vmulpd    %zmm22, %zmm22, %zmm18                        #149.49
        vpaddd    %ymm11, %ymm24, %ymm16                        #148.36
        vfmadd231pd %zmm23, %zmm23, %zmm18                      #149.49
        vfmadd231pd %zmm20, %zmm20, %zmm18                      #149.63
        vrcp14pd  %zmm18, %zmm19                                #160.38
        vcmppd    $1, %zmm10, %zmm18, %k7{%k4}                  #159.22
        vfpclasspd $30, %zmm19, %k0                             #160.38
        vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm19, %zmm18 #160.38
        knotw     %k0, %k5                                      #160.38
        kandw     %k6, %k7, %k6                                 #168.24
        vmulpd    %zmm18, %zmm18, %zmm21                        #160.38
        vfmadd213pd %zmm19, %zmm18, %zmm19{%k5}                 #160.38
        vfmadd213pd %zmm19, %zmm21, %zmm19{%k5}                 #160.38
        vmulpd    %zmm9, %zmm19, %zmm30                         #161.38
        vmulpd    %zmm30, %zmm19, %zmm18                        #161.44
        vmulpd    %zmm18, %zmm19, %zmm31                        #161.50
        vfmsub213pd %zmm5, %zmm19, %zmm18                       #162.54
        vmulpd    %zmm7, %zmm19, %zmm19                         #162.54
        vmulpd    %zmm19, %zmm31, %zmm19                        #162.61
        vmulpd    %zmm18, %zmm19, %zmm21                        #162.67
        vmovaps   %zmm15, %zmm18                                #169.21
        kmovw     %k6, %k1                                      #169.21
        vfmadd231pd %zmm23, %zmm21, %zmm8{%k7}                  #163.17
        vfmadd231pd %zmm22, %zmm21, %zmm6{%k7}                  #164.17
        vfmadd231pd %zmm20, %zmm21, %zmm3{%k7}                  #165.17
        .byte     144                                           #169.21
        vgatherdpd (%rdx,%ymm24,8), %zmm18{%k1}                 #169.21
        vfnmadd213pd %zmm18, %zmm21, %zmm23                     #169.21
        kmovw     %k6, %k2                                      #169.21
        vscatterdpd %zmm23, (%rdx,%ymm24,8){%k2}                #169.21
        vmovaps   %zmm15, %zmm23                                #170.21
        kmovw     %k6, %k3                                      #170.21
        kmovw     %k6, %k4                                      #170.21
        kmovw     %k6, %k5                                      #171.21
        vgatherdpd (%rdx,%ymm17,8), %zmm23{%k3}                 #170.21
        vfnmadd213pd %zmm23, %zmm21, %zmm22                     #170.21
        vscatterdpd %zmm22, (%rdx,%ymm17,8){%k4}                #170.21
        vmovaps   %zmm15, %zmm17                                #171.21
        vgatherdpd (%rdx,%ymm16,8), %zmm17{%k5}                 #171.21
        vfnmadd213pd %zmm17, %zmm21, %zmm20                     #171.21
        vscatterdpd %zmm20, (%rdx,%ymm16,8){%k6}                #171.21
        cmpq      %r10, %r13                                    #144.9
        jb        ..B2.16       # Prob 82%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r13 r15 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 ymm28 ymm29 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15 zmm25 zmm26 zmm27
..B2.17:                        # Preds ..B2.16
                                # Execution count [2.25e+00]
        movq      16(%rsp), %r10                                #[spill]
        cmpl      %r12d, %r11d                                  #144.9
        je        ..B2.25       # Prob 10%                      #144.9
        jmp       ..B2.19       # Prob 100%                     #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.18:                        # Preds ..B2.13
                                # Execution count [5.62e-01]
        movl      %r11d, %r14d                                  #144.9
        andl      $7, %r14d                                     #144.9
        negl      %r14d                                         #144.9
        addl      %r11d, %r14d                                  #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.19:                        # Preds ..B2.12 ..B2.18 ..B2.17 ..B2.14 ..B2.33
                                #      
                                # Execution count [1.25e+01]
        lea       8(%r12), %r13d                                #144.9
        cmpl      %r13d, %r14d                                  #144.9
        jb        ..B2.23       # Prob 50%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.20:                        # Preds ..B2.19
                                # Execution count [2.25e+00]
        movq      %rdi, %r13                                    #127.43
        imulq     %r10, %r13                                    #127.43
        vbroadcastsd %xmm1, %zmm26                              #129.23
        vbroadcastsd %xmm0, %zmm25                              #130.23
        vbroadcastsd %xmm2, %zmm23                              #131.23
        movslq    %r12d, %r15                                   #144.9
        addq      %r8, %r13                                     #106.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r13 r15 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15 zmm23 zmm25 zmm26
..B2.21:                        # Preds ..B2.21 ..B2.20
                                # Execution count [1.25e+01]
        vmovdqu32 (%r13,%r15,4), %ymm24                         #145.21
        addl      $8, %r12d                                     #144.9
        vpcmpeqb  %xmm0, %xmm0, %k2                             #146.36
        vpcmpeqb  %xmm0, %xmm0, %k3                             #146.36
        vpcmpeqb  %xmm0, %xmm0, %k1                             #146.36
        vpcmpgtd  %ymm24, %ymm4, %k6                            #168.24
        vpaddd    %ymm24, %ymm24, %ymm27                        #146.36
        vpaddd    %ymm27, %ymm24, %ymm20                        #146.36
        addq      $8, %r15                                      #144.9
        vpxord    %zmm29, %zmm29, %zmm29                        #146.36
        vpxord    %zmm28, %zmm28, %zmm28                        #146.36
        vpxord    %zmm30, %zmm30, %zmm30                        #146.36
        vpaddd    %ymm20, %ymm12, %ymm21                        #147.36
        vpaddd    %ymm20, %ymm11, %ymm18                        #148.36
        vgatherdpd 8(%rsi,%ymm20,8), %zmm29{%k2}                #146.36
        vgatherdpd (%rsi,%ymm20,8), %zmm28{%k3}                 #146.36
        vgatherdpd 16(%rsi,%ymm20,8), %zmm30{%k1}               #146.36
        vsubpd    %zmm29, %zmm25, %zmm19                        #147.36
        vsubpd    %zmm28, %zmm26, %zmm22                        #146.36
        vsubpd    %zmm30, %zmm23, %zmm17                        #148.36
        vmulpd    %zmm19, %zmm19, %zmm31                        #149.49
        vfmadd231pd %zmm22, %zmm22, %zmm31                      #149.49
        vfmadd231pd %zmm17, %zmm17, %zmm31                      #149.63
        vrcp14pd  %zmm31, %zmm16                                #160.38
        vcmppd    $1, %zmm10, %zmm31, %k5                       #159.22
        vfpclasspd $30, %zmm16, %k0                             #160.38
        vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm16, %zmm31 #160.38
        knotw     %k0, %k4                                      #160.38
        vmulpd    %zmm31, %zmm31, %zmm27                        #160.38
        vfmadd213pd %zmm16, %zmm31, %zmm16{%k4}                 #160.38
        vfmadd213pd %zmm16, %zmm27, %zmm16{%k4}                 #160.38
        vmulpd    %zmm9, %zmm16, %zmm28                         #161.38
        vmulpd    %zmm7, %zmm16, %zmm24                         #162.54
        vmulpd    %zmm28, %zmm16, %zmm30                        #161.44
        vmulpd    %zmm30, %zmm16, %zmm29                        #161.50
        vfmsub213pd %zmm5, %zmm30, %zmm16                       #162.54
        vmulpd    %zmm24, %zmm29, %zmm31                        #162.61
        vmulpd    %zmm16, %zmm31, %zmm24                        #162.67
        vfmadd231pd %zmm22, %zmm24, %zmm8{%k5}                  #163.17
        vfmadd231pd %zmm19, %zmm24, %zmm6{%k5}                  #164.17
        vfmadd231pd %zmm17, %zmm24, %zmm3{%k5}                  #165.17
        kandw     %k6, %k5, %k5                                 #168.24
        vmovaps   %zmm15, %zmm16                                #169.21
        kmovw     %k5, %k7                                      #169.21
        kmovw     %k5, %k1                                      #169.21
        kmovw     %k5, %k2                                      #170.21
        kmovw     %k5, %k3                                      #170.21
        kmovw     %k5, %k4                                      #171.21
        vgatherdpd (%rdx,%ymm20,8), %zmm16{%k7}                 #169.21
        vfnmadd213pd %zmm16, %zmm24, %zmm22                     #169.21
        vscatterdpd %zmm22, (%rdx,%ymm20,8){%k1}                #169.21
        vmovaps   %zmm15, %zmm20                                #170.21
        vgatherdpd (%rdx,%ymm21,8), %zmm20{%k2}                 #170.21
        vfnmadd213pd %zmm20, %zmm24, %zmm19                     #170.21
        vscatterdpd %zmm19, (%rdx,%ymm21,8){%k3}                #170.21
        vmovaps   %zmm15, %zmm19                                #171.21
        vgatherdpd (%rdx,%ymm18,8), %zmm19{%k4}                 #171.21
        vfnmadd213pd %zmm19, %zmm24, %zmm17                     #171.21
        vscatterdpd %zmm17, (%rdx,%ymm18,8){%k5}                #171.21
        cmpl      %r14d, %r12d                                  #144.9
        jb        ..B2.21       # Prob 82%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r13 r15 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15 zmm23 zmm25 zmm26
..B2.23:                        # Preds ..B2.21 ..B2.19 ..B2.34
                                # Execution count [2.50e+00]
        lea       1(%r14), %r12d                                #144.9
        cmpl      %r11d, %r12d                                  #144.9
        ja        ..B2.25       # Prob 50%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.24:                        # Preds ..B2.23
                                # Execution count [1.25e+01]
        imulq     %rdi, %r10                                    #127.43
        vbroadcastsd %xmm0, %zmm24                              #130.23
        vbroadcastsd %xmm1, %zmm22                              #129.23
        vbroadcastsd %xmm2, %zmm26                              #131.23
        movl      %r11d, %r12d                                  #144.9
        addq      %r8, %r10                                     #106.5
        subl      %r14d, %r12d                                  #144.9
        vpbroadcastd %r12d, %ymm20                              #144.9
        vpcmpud   $1, %ymm20, %ymm14, %k5                       #144.9
        movslq    %r14d, %r14                                   #144.9
        kmovw     %k5, %k2                                      #146.36
        kmovw     %k5, %k3                                      #146.36
        kmovw     %k5, %k1                                      #146.36
        vmovdqu32 (%r10,%r14,4), %ymm19{%k5}{z}                 #145.21
        vpaddd    %ymm19, %ymm19, %ymm21                        #146.36
        vpcmpgtd  %ymm19, %ymm4, %k7                            #168.24
        vpaddd    %ymm21, %ymm19, %ymm18                        #146.36
        vmovaps   %zmm15, %zmm19                                #169.21
        vpxord    %zmm25, %zmm25, %zmm25                        #146.36
        vpxord    %zmm23, %zmm23, %zmm23                        #146.36
        vpxord    %zmm27, %zmm27, %zmm27                        #146.36
        vpaddd    %ymm18, %ymm12, %ymm16                        #147.36
        vpaddd    %ymm18, %ymm11, %ymm0                         #148.36
        vgatherdpd 8(%rsi,%ymm18,8), %zmm25{%k2}                #146.36
        vgatherdpd (%rsi,%ymm18,8), %zmm23{%k3}                 #146.36
        vgatherdpd 16(%rsi,%ymm18,8), %zmm27{%k1}               #146.36
        vsubpd    %zmm25, %zmm24, %zmm1                         #147.36
        vsubpd    %zmm23, %zmm22, %zmm17                        #146.36
        vsubpd    %zmm27, %zmm26, %zmm2                         #148.36
        vmulpd    %zmm1, %zmm1, %zmm21                          #149.49
        vfmadd231pd %zmm17, %zmm17, %zmm21                      #149.49
        vfmadd231pd %zmm2, %zmm2, %zmm21                        #149.63
        vrcp14pd  %zmm21, %zmm20                                #160.38
        vcmppd    $1, %zmm10, %zmm21, %k6{%k5}                  #159.22
        vfpclasspd $30, %zmm20, %k0                             #160.38
        vmovaps   %zmm21, %zmm28                                #160.38
        vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm20, %zmm28 #160.38
        knotw     %k0, %k4                                      #160.38
        vmulpd    %zmm28, %zmm28, %zmm29                        #160.38
        vfmadd213pd %zmm20, %zmm28, %zmm20{%k4}                 #160.38
        vfmadd213pd %zmm20, %zmm29, %zmm20{%k4}                 #160.38
        vmulpd    %zmm9, %zmm20, %zmm30                         #161.38
        vmulpd    %zmm7, %zmm20, %zmm28                         #162.54
        vmulpd    %zmm30, %zmm20, %zmm29                        #161.44
        vmulpd    %zmm29, %zmm20, %zmm31                        #161.50
        vfmsub213pd %zmm5, %zmm29, %zmm20                       #162.54
        vmulpd    %zmm28, %zmm31, %zmm30                        #162.61
        vmulpd    %zmm20, %zmm30, %zmm22                        #162.67
        vfmadd231pd %zmm17, %zmm22, %zmm8{%k6}                  #163.17
        vfmadd231pd %zmm1, %zmm22, %zmm6{%k6}                   #164.17
        vfmadd231pd %zmm2, %zmm22, %zmm3{%k6}                   #165.17
        kandw     %k7, %k6, %k6                                 #168.24
        kmovw     %k6, %k1                                      #169.21
        kmovw     %k6, %k2                                      #169.21
        kmovw     %k6, %k3                                      #170.21
        kmovw     %k6, %k4                                      #170.21
        kmovw     %k6, %k5                                      #171.21
        vgatherdpd (%rdx,%ymm18,8), %zmm19{%k1}                 #169.21
        vfnmadd213pd %zmm19, %zmm22, %zmm17                     #169.21
        vscatterdpd %zmm17, (%rdx,%ymm18,8){%k2}                #169.21
        vmovaps   %zmm15, %zmm17                                #170.21
        vgatherdpd (%rdx,%ymm16,8), %zmm17{%k3}                 #170.21
        vfnmadd213pd %zmm17, %zmm22, %zmm1                      #170.21
        vscatterdpd %zmm1, (%rdx,%ymm16,8){%k4}                 #170.21
        vmovaps   %zmm15, %zmm1                                 #171.21
        vgatherdpd (%rdx,%ymm0,8), %zmm1{%k5}                   #171.21
        vfnmadd213pd %zmm1, %zmm22, %zmm2                       #171.21
        vscatterdpd %zmm2, (%rdx,%ymm0,8){%k6}                  #171.21
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.25:                        # Preds ..B2.17 ..B2.24 ..B2.23
                                # Execution count [2.25e+00]
        vmovups   .L_2il0floatpacket.6(%rip), %zmm22            #134.22
        vpermd    %zmm3, %zmm22, %zmm0                          #134.22
        vpermd    %zmm6, %zmm22, %zmm17                         #133.22
        vpermd    %zmm8, %zmm22, %zmm23                         #132.22
        vaddpd    %zmm3, %zmm0, %zmm3                           #134.22
        vaddpd    %zmm6, %zmm17, %zmm6                          #133.22
        vaddpd    %zmm8, %zmm23, %zmm8                          #132.22
        vpermpd   $78, %zmm3, %zmm1                             #134.22
        vpermpd   $78, %zmm6, %zmm18                            #133.22
        vpermpd   $78, %zmm8, %zmm24                            #132.22
        vaddpd    %zmm1, %zmm3, %zmm2                           #134.22
        vaddpd    %zmm18, %zmm6, %zmm19                         #133.22
        vaddpd    %zmm24, %zmm8, %zmm25                         #132.22
        vpermpd   $177, %zmm2, %zmm16                           #134.22
        vpermpd   $177, %zmm19, %zmm20                          #133.22
        vpermpd   $177, %zmm25, %zmm26                          #132.22
        vaddpd    %zmm16, %zmm2, %zmm3                          #134.22
        vaddpd    %zmm20, %zmm19, %zmm21                        #133.22
        vaddpd    %zmm26, %zmm25, %zmm27                        #132.22
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d xmm3 xmm21 xmm27 ymm4 ymm11 ymm12 ymm13 ymm14 zmm5 zmm7 zmm9 zmm10 zmm15
..B2.26:                        # Preds ..B2.25 ..B2.8 ..B2.7
                                # Execution count [5.00e+00]
        movslq    %r11d, %r11                                   #180.9
        vaddsd    (%rax,%rdx), %xmm27, %xmm0                    #176.9
        vaddsd    8(%rax,%rdx), %xmm21, %xmm1                   #177.9
        vaddsd    16(%rax,%rdx), %xmm3, %xmm2                   #178.9
        vmovsd    %xmm0, (%rax,%rdx)                            #176.9
        lea       7(%r11), %r10d                                #181.9
        sarl      $2, %r10d                                     #181.9
        addq      %r11, %rcx                                    #180.9
        shrl      $29, %r10d                                    #181.9
        vmovsd    %xmm1, 8(%rax,%rdx)                           #177.9
        vmovsd    %xmm2, 16(%rax,%rdx)                          #178.9
        addq      $24, %rax                                     #126.5
        lea       7(%r10,%r11), %r12d                           #181.9
        movslq    %r9d, %r10                                    #126.32
        sarl      $3, %r12d                                     #181.9
        incq      %r9                                           #126.5
        movslq    %r12d, %r12                                   #181.9
        incq      %r10                                          #126.32
        addq      %r12, %rbx                                    #181.9
        cmpq      48(%rsp), %r9                                 #126.5[spill]
        jb        ..B2.7        # Prob 82%                      #126.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 ymm4 ymm11 ymm12 ymm13 ymm14 zmm5 zmm7 zmm9 zmm10 zmm15
..B2.27:                        # Preds ..B2.26
                                # Execution count [9.00e-01]
        movq      (%rsp), %r14                                  #[spill]
        movq      %rcx, (%r14)                                  #180.9
        movq      %rbx, 8(%r14)                                 #181.9
        jmp       ..B2.30       # Prob 100%                     #181.9
                                # LOE
..B2.28:                        # Preds ..B2.1
                                # Execution count [5.00e-01]
        xorl      %eax, %eax                                    #119.16
..___tag_value_computeForceLJHalfNeigh.87:
#       getTimeStamp()
        call      getTimeStamp                                  #119.16
..___tag_value_computeForceLJHalfNeigh.88:
                                # LOE xmm0
..B2.45:                        # Preds ..B2.28
                                # Execution count [5.00e-01]
        vmovsd    %xmm0, 8(%rsp)                                #119.16[spill]
                                # LOE
..B2.29:                        # Preds ..B2.45
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.1, %edi                         #123.5
..___tag_value_computeForceLJHalfNeigh.90:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #123.5
..___tag_value_computeForceLJHalfNeigh.91:
                                # LOE
..B2.30:                        # Preds ..B2.27 ..B2.29
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.1, %edi                         #184.5
        vzeroupper                                              #184.5
..___tag_value_computeForceLJHalfNeigh.92:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #184.5
..___tag_value_computeForceLJHalfNeigh.93:
                                # LOE
..B2.31:                        # Preds ..B2.30
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #187.16
..___tag_value_computeForceLJHalfNeigh.94:
#       getTimeStamp()
        call      getTimeStamp                                  #187.16
..___tag_value_computeForceLJHalfNeigh.95:
                                # LOE xmm0
..B2.32:                        # Preds ..B2.31
                                # Execution count [1.00e+00]
        vsubsd    8(%rsp), %xmm0, %xmm0                         #188.14[spill]
        addq      $88, %rsp                                     #188.14
	.cfi_restore 3
        popq      %rbx                                          #188.14
	.cfi_restore 15
        popq      %r15                                          #188.14
	.cfi_restore 14
        popq      %r14                                          #188.14
	.cfi_restore 13
        popq      %r13                                          #188.14
	.cfi_restore 12
        popq      %r12                                          #188.14
        movq      %rbp, %rsp                                    #188.14
        popq      %rbp                                          #188.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #188.14
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
        movl      %r11d, %r14d                                  #144.9
        xorl      %r12d, %r12d                                  #144.9
        andl      $-8, %r14d                                    #144.9
        jmp       ..B2.19       # Prob 100%                     #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.34:                        # Preds ..B2.9
                                # Execution count [2.25e-01]: Infreq
        xorl      %r14d, %r14d                                  #144.9
        jmp       ..B2.23       # Prob 100%                     #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r14d xmm0 xmm1 xmm2 ymm4 ymm11 ymm12 ymm13 ymm14 zmm3 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm15
..B2.35:                        # Preds ..B2.2
                                # Execution count [1.00e+00]: Infreq
        cmpl      $8, %esi                                      #113.5
        jl        ..B2.41       # Prob 10%                      #113.5
                                # LOE rdi r12 r13 r14 ebx esi
..B2.36:                        # Preds ..B2.35
                                # Execution count [1.00e+00]: Infreq
        movl      %esi, %eax                                    #113.5
        xorl      %ecx, %ecx                                    #113.5
        andl      $-8, %eax                                     #113.5
        movslq    %eax, %rdx                                    #113.5
        vpxord    %zmm0, %zmm0, %zmm0                           #113.5
                                # LOE rdx rcx rdi r12 r13 r14 eax ebx esi zmm0
..B2.37:                        # Preds ..B2.37 ..B2.36
                                # Execution count [5.56e+00]: Infreq
        vmovupd   %zmm0, (%rdi,%rcx,8)                          #114.9
        addq      $8, %rcx                                      #113.5
        cmpq      %rdx, %rcx                                    #113.5
        jb        ..B2.37       # Prob 82%                      #113.5
                                # LOE rdx rcx rdi r12 r13 r14 eax ebx esi zmm0
..B2.39:                        # Preds ..B2.37 ..B2.41
                                # Execution count [1.11e+00]: Infreq
        lea       1(%rax), %edx                                 #113.5
        cmpl      %esi, %edx                                    #113.5
        ja        ..B2.47       # Prob 50%                      #113.5
                                # LOE rdi r12 r13 r14 eax ebx esi
..B2.40:                        # Preds ..B2.39
                                # Execution count [5.56e+00]: Infreq
        subl      %eax, %esi                                    #113.5
        vpbroadcastd %esi, %ymm0                                #113.5
        vpcmpgtd  .L_2il0floatpacket.0(%rip), %ymm0, %k1        #113.5
        movslq    %eax, %rax                                    #113.5
        movslq    %ebx, %r15                                    #113.5
        vpxord    %zmm1, %zmm1, %zmm1                           #114.9
        vmovupd   %zmm1, (%rdi,%rax,8){%k1}                     #114.9
        jmp       ..B2.4        # Prob 100%                     #114.9
                                # LOE r12 r13 r14 r15 ebx
..B2.41:                        # Preds ..B2.35
                                # Execution count [1.00e-01]: Infreq
        xorl      %eax, %eax                                    #113.5
        jmp       ..B2.39       # Prob 100%                     #113.5
                                # LOE rdi r12 r13 r14 eax ebx esi
..B2.47:                        # Preds ..B2.39
                                # Execution count [5.56e-01]: Infreq
        movslq    %ebx, %r15                                    #113.5
        jmp       ..B2.4        # Prob 100%                     #113.5
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
                                                        #191.101
        pushq     %rbp                                          #191.101
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #191.101
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #191.101
        pushq     %r14                                          #191.101
        pushq     %r15                                          #191.101
        pushq     %rbx                                          #191.101
        subq      $232, %rsp                                    #191.101
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
        movq      %rsi, %r14                                    #191.101
        vmovsd    144(%rdi), %xmm0                              #194.27
        movq      %rdx, %r15                                    #191.101
        vmovsd    56(%rdi), %xmm1                               #195.23
        vmovsd    40(%rdi), %xmm2                               #196.24
        movl      4(%r14), %ebx                                 #192.18
        vmovsd    %xmm0, 216(%rsp)                              #194.27[spill]
        vmovsd    %xmm1, 200(%rsp)                              #195.23[spill]
        vmovsd    %xmm2, 208(%rsp)                              #196.24[spill]
        testl     %ebx, %ebx                                    #198.24
        jle       ..B3.8        # Prob 50%                      #198.24
                                # LOE r12 r13 r14 r15 ebx
..B3.2:                         # Preds ..B3.1
                                # Execution count [1.00e+00]
        movl      %ebx, %eax                                    #198.5
        xorl      %edx, %edx                                    #198.5
        movl      $1, %ecx                                      #198.5
        xorl      %esi, %esi                                    #198.5
        shrl      $1, %eax                                      #198.5
        je        ..B3.6        # Prob 9%                       #198.5
                                # LOE rax rdx rsi r12 r13 r14 r15 ecx ebx
..B3.3:                         # Preds ..B3.2
                                # Execution count [9.00e-01]
        xorl      %ecx, %ecx                                    #198.5
        .align    16,0x90
                                # LOE rax rdx rcx rsi r12 r13 r14 r15 ebx
..B3.4:                         # Preds ..B3.4 ..B3.3
                                # Execution count [2.50e+00]
        movq      64(%r14), %rdi                                #199.9
        incq      %rdx                                          #198.5
        movq      %rcx, (%rdi,%rsi)                             #199.9
        movq      64(%r14), %r8                                 #200.9
        movq      %rcx, 8(%r8,%rsi)                             #200.9
        movq      64(%r14), %r9                                 #201.9
        movq      %rcx, 16(%r9,%rsi)                            #201.9
        movq      64(%r14), %r10                                #199.9
        movq      %rcx, 24(%r10,%rsi)                           #199.9
        movq      64(%r14), %r11                                #200.9
        movq      %rcx, 32(%r11,%rsi)                           #200.9
        movq      64(%r14), %rdi                                #201.9
        movq      %rcx, 40(%rdi,%rsi)                           #201.9
        addq      $48, %rsi                                     #198.5
        cmpq      %rax, %rdx                                    #198.5
        jb        ..B3.4        # Prob 63%                      #198.5
                                # LOE rax rdx rcx rsi r12 r13 r14 r15 ebx
..B3.5:                         # Preds ..B3.4
                                # Execution count [9.00e-01]
        lea       1(%rdx,%rdx), %ecx                            #199.9
                                # LOE r12 r13 r14 r15 ecx ebx
..B3.6:                         # Preds ..B3.5 ..B3.2
                                # Execution count [1.00e+00]
        lea       -1(%rcx), %eax                                #198.5
        cmpl      %ebx, %eax                                    #198.5
        jae       ..B3.8        # Prob 9%                       #198.5
                                # LOE r12 r13 r14 r15 ecx ebx
..B3.7:                         # Preds ..B3.6
                                # Execution count [9.00e-01]
        movslq    %ecx, %rcx                                    #199.9
        xorl      %esi, %esi                                    #199.9
        movq      64(%r14), %rax                                #199.9
        lea       (%rcx,%rcx,2), %r8                            #199.9
        movq      %rsi, -24(%rax,%r8,8)                         #199.9
        movq      64(%r14), %rdx                                #200.9
        movq      %rsi, -16(%rdx,%r8,8)                         #200.9
        movq      64(%r14), %rdi                                #201.9
        movq      %rsi, -8(%rdi,%r8,8)                          #201.9
                                # LOE r12 r13 r14 r15 ebx
..B3.8:                         # Preds ..B3.1 ..B3.6 ..B3.7
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #204.16
..___tag_value_computeForceLJFullNeigh_simd.123:
#       getTimeStamp()
        call      getTimeStamp                                  #204.16
..___tag_value_computeForceLJFullNeigh_simd.124:
                                # LOE r12 r13 r14 r15 ebx xmm0
..B3.23:                        # Preds ..B3.8
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 192(%rsp)                              #204.16[spill]
                                # LOE r12 r13 r14 r15 ebx
..B3.9:                         # Preds ..B3.23
                                # Execution count [1.00e+00]
        vmovsd    216(%rsp), %xmm0                              #210.36[spill]
        movl      $.L_2__STRING.0, %edi                         #219.5
        vmulsd    %xmm0, %xmm0, %xmm1                           #210.36
        vbroadcastsd 200(%rsp), %zmm3                           #211.32[spill]
        vbroadcastsd 208(%rsp), %zmm4                           #212.29[spill]
        vbroadcastsd %xmm1, %zmm2                               #210.36
        vmovups   %zmm3, 64(%rsp)                               #211.32[spill]
        vmovups   %zmm4, 128(%rsp)                              #212.29[spill]
        vmovups   %zmm2, (%rsp)                                 #210.36[spill]
        vzeroupper                                              #219.5
..___tag_value_computeForceLJFullNeigh_simd.132:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #219.5
..___tag_value_computeForceLJFullNeigh_simd.133:
                                # LOE r12 r13 r14 r15 ebx
..B3.10:                        # Preds ..B3.9
                                # Execution count [1.00e+00]
        xorl      %ecx, %ecx                                    #223.9
        xorl      %r10d, %r10d                                  #222.5
        xorl      %edx, %edx                                    #223.9
        testl     %ebx, %ebx                                    #222.24
        jle       ..B3.18       # Prob 9%                       #222.24
                                # LOE rdx rcx r12 r13 r14 r15 ebx r10d
..B3.11:                        # Preds ..B3.10
                                # Execution count [9.00e-01]
        vmovdqu   .L_2il0floatpacket.10(%rip), %ymm13           #235.101
        vmovups   .L_2il0floatpacket.6(%rip), %zmm0             #258.23
        vmovups   128(%rsp), %zmm10                             #258.23[spill]
        vmovups   64(%rsp), %zmm11                              #258.23[spill]
        vmovups   (%rsp), %zmm12                                #258.23[spill]
        vbroadcastsd .L_2il0floatpacket.9(%rip), %zmm8          #258.23
        vbroadcastsd .L_2il0floatpacket.3(%rip), %zmm9          #258.23
        vpxord    %zmm1, %zmm1, %zmm1                           #229.29
                                # LOE rdx rcx r12 r13 r14 r15 ebx r10d ymm13 zmm0 zmm1 zmm8 zmm9 zmm10 zmm11 zmm12
..B3.12:                        # Preds ..B3.16 ..B3.11
                                # Execution count [5.00e+00]
        movl      %r10d, %edi                                   #223.43
        xorl      %r9d, %r9d                                    #233.9
        imull     8(%r15), %edi                                 #223.43
        movslq    %edi, %rdi                                    #223.19
        movq      24(%r15), %rsi                                #224.25
        movq      16(%r15), %rax                                #223.19
        movq      16(%r14), %r8                                 #226.45
        vmovaps   %zmm1, %zmm3                                  #229.29
        vmovaps   %zmm3, %zmm2                                  #230.29
        lea       (%rax,%rdi,4), %rdi                           #223.19
        movl      (%rsi,%rcx,4), %esi                           #224.25
        xorl      %eax, %eax                                    #235.78
        vmovaps   %zmm2, %zmm7                                  #231.29
        vpbroadcastd %esi, %ymm6                                #225.37
        vbroadcastsd (%r8,%rdx,8), %zmm5                        #226.30
        vbroadcastsd 8(%r8,%rdx,8), %zmm4                       #227.30
        vbroadcastsd 16(%r8,%rdx,8), %zmm14                     #228.30
        testl     %esi, %esi                                    #233.28
        jle       ..B3.16       # Prob 10%                      #233.28
                                # LOE rdx rcx rdi r8 r12 r13 r14 r15 eax ebx esi r9d r10d ymm6 ymm13 zmm0 zmm1 zmm2 zmm3 zmm4 zmm5 zmm7 zmm8 zmm9 zmm10 zmm11 zmm12 zmm14
..B3.13:                        # Preds ..B3.12
                                # Execution count [4.50e+00]
        addl      $7, %esi                                      #224.25
        shrl      $3, %esi                                      #224.25
                                # LOE rdx rcx rdi r8 r12 r13 r14 r15 eax ebx esi r9d r10d ymm6 ymm13 zmm0 zmm1 zmm2 zmm3 zmm4 zmm5 zmm7 zmm8 zmm9 zmm10 zmm11 zmm12 zmm14
..B3.14:                        # Preds ..B3.14 ..B3.13
                                # Execution count [2.50e+01]
        vpbroadcastd %eax, %ymm15                               #235.78
        incl      %r9d                                          #233.9
        vpcmpeqb  %xmm0, %xmm0, %k4                             #241.41
        vpcmpeqb  %xmm0, %xmm0, %k3                             #240.41
        vpcmpeqb  %xmm0, %xmm0, %k2                             #239.41
        vpaddd    %ymm13, %ymm15, %ymm16                        #235.65
        vpcmpgtd  %ymm16, %ymm6, %k1                            #235.43
        movslq    %eax, %rax                                    #236.29
        kmovw     %k1, %r11d                                    #235.43
        kmovb     %r11d, %k5                                    #248.40
        vmovdqu32 (%rdi,%rax,4), %ymm18{%k1}{z}                 #236.29
        addl      $8, %eax                                      #233.9
        vpaddd    %ymm18, %ymm18, %ymm17                        #238.43
        vpaddd    %ymm18, %ymm17, %ymm19                        #238.30
        vpxord    %zmm22, %zmm22, %zmm22                        #241.41
        vpxord    %zmm21, %zmm21, %zmm21                        #240.41
        vpxord    %zmm20, %zmm20, %zmm20                        #239.41
        vgatherdpd 16(%r8,%ymm19,8), %zmm22{%k4}                #241.41
        vgatherdpd 8(%r8,%ymm19,8), %zmm21{%k3}                 #240.41
        vgatherdpd (%r8,%ymm19,8), %zmm20{%k2}                  #239.41
        vsubpd    %zmm22, %zmm14, %zmm16                        #241.41
        vsubpd    %zmm21, %zmm4, %zmm15                         #240.41
        vsubpd    %zmm20, %zmm5, %zmm31                         #239.41
        vmulpd    %zmm16, %zmm16, %zmm23                        #247.75
        vfmadd231pd %zmm15, %zmm15, %zmm23                      #247.54
        vfmadd231pd %zmm31, %zmm31, %zmm23                      #247.33
        vrcp14pd  %zmm23, %zmm25                                #249.33
        vcmppd    $17, %zmm12, %zmm23, %k0                      #248.70
        vmulpd    %zmm11, %zmm25, %zmm24                        #250.61
        vmulpd    %zmm10, %zmm25, %zmm27                        #251.100
        kmovw     %k0, %r11d                                    #248.70
        vmulpd    %zmm24, %zmm25, %zmm26                        #250.47
        vmulpd    %zmm26, %zmm25, %zmm28                        #250.33
        vfmsub213pd %zmm8, %zmm25, %zmm26                       #251.76
        vmulpd    %zmm27, %zmm26, %zmm29                        #251.67
        vmulpd    %zmm29, %zmm28, %zmm30                        #251.53
        vmulpd    %zmm30, %zmm9, %zmm23                         #251.35
        kmovb     %r11d, %k6                                    #248.40
        kandb     %k6, %k5, %k7                                 #248.40
        kmovb     %k7, %r11d                                    #248.40
        kmovw     %r11d, %k1                                    #253.19
        vfmadd231pd %zmm31, %zmm23, %zmm3{%k1}                  #253.19
        vfmadd231pd %zmm15, %zmm23, %zmm2{%k1}                  #254.19
        vfmadd231pd %zmm16, %zmm23, %zmm7{%k1}                  #255.19
        cmpl      %esi, %r9d                                    #233.9
        jb        ..B3.14       # Prob 82%                      #233.9
                                # LOE rdx rcx rdi r8 r12 r13 r14 r15 eax ebx esi r9d r10d ymm6 ymm13 zmm0 zmm1 zmm2 zmm3 zmm4 zmm5 zmm7 zmm8 zmm9 zmm10 zmm11 zmm12 zmm14
..B3.16:                        # Preds ..B3.14 ..B3.12
                                # Execution count [5.00e+00]
        vpermd    %zmm3, %zmm0, %zmm4                           #258.23
        incl      %r10d                                         #222.5
        vpermd    %zmm2, %zmm0, %zmm18                          #259.23
        vpermd    %zmm7, %zmm0, %zmm25                          #260.23
        vaddpd    %zmm3, %zmm4, %zmm5                           #258.23
        vaddpd    %zmm2, %zmm18, %zmm19                         #259.23
        vaddpd    %zmm7, %zmm25, %zmm26                         #260.23
        vshuff64x2 $17, %zmm5, %zmm5, %zmm3                     #258.23
        vshuff64x2 $17, %zmm19, %zmm19, %zmm2                   #259.23
        vshuff64x2 $17, %zmm26, %zmm26, %zmm7                   #260.23
        vaddpd    %zmm5, %zmm3, %zmm14                          #258.23
        vaddpd    %zmm19, %zmm2, %zmm21                         #259.23
        vaddpd    %zmm26, %zmm7, %zmm28                         #260.23
        vpermilpd $1, %zmm14, %zmm6                             #258.23
        incq      %rcx                                          #222.5
        vaddpd    %zmm14, %zmm6, %zmm15                         #258.23
        vmovups   %zmm15, (%rsp)                                #258.23
        movq      64(%r14), %rax                                #258.9
        vpermilpd $1, %zmm21, %zmm20                            #259.23
        vaddpd    %zmm21, %zmm20, %zmm22                        #259.23
        vmovsd    (%rax,%rdx,8), %xmm16                         #258.9
        vaddsd    (%rsp), %xmm16, %xmm17                        #258.9
        vmovups   %zmm22, 64(%rsp)                              #259.23
        vmovsd    %xmm17, (%rax,%rdx,8)                         #258.9
        movq      64(%r14), %rsi                                #259.9
        vpermilpd $1, %zmm28, %zmm27                            #260.23
        vaddpd    %zmm28, %zmm27, %zmm29                        #260.23
        vmovsd    8(%rsi,%rdx,8), %xmm23                        #259.9
        vaddsd    64(%rsp), %xmm23, %xmm24                      #259.9
        vmovups   %zmm29, 128(%rsp)                             #260.23
        vmovsd    %xmm24, 8(%rsi,%rdx,8)                        #259.9
        movq      64(%r14), %rdi                                #260.9
        vmovsd    16(%rdi,%rdx,8), %xmm30                       #260.9
        vaddsd    128(%rsp), %xmm30, %xmm31                     #260.9
        vmovsd    %xmm31, 16(%rdi,%rdx,8)                       #260.9
        addq      $3, %rdx                                      #222.5
        cmpl      %ebx, %r10d                                   #222.5
        jb        ..B3.12       # Prob 82%                      #222.5
                                # LOE rdx rcx r12 r13 r14 r15 ebx r10d ymm13 zmm0 zmm1 zmm8 zmm9 zmm10 zmm11 zmm12
..B3.18:                        # Preds ..B3.16 ..B3.10
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.0, %edi                         #263.5
        vzeroupper                                              #263.5
..___tag_value_computeForceLJFullNeigh_simd.137:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #263.5
..___tag_value_computeForceLJFullNeigh_simd.138:
                                # LOE r12 r13
..B3.19:                        # Preds ..B3.18
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #267.16
..___tag_value_computeForceLJFullNeigh_simd.139:
#       getTimeStamp()
        call      getTimeStamp                                  #267.16
..___tag_value_computeForceLJFullNeigh_simd.140:
                                # LOE r12 r13 xmm0
..B3.20:                        # Preds ..B3.19
                                # Execution count [1.00e+00]
        vsubsd    192(%rsp), %xmm0, %xmm0                       #268.14[spill]
        addq      $232, %rsp                                    #268.14
	.cfi_restore 3
        popq      %rbx                                          #268.14
	.cfi_restore 15
        popq      %r15                                          #268.14
	.cfi_restore 14
        popq      %r14                                          #268.14
        movq      %rbp, %rsp                                    #268.14
        popq      %rbp                                          #268.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #268.14
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
