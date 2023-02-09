# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 19.1.2.254 Build 20200623";
# mark_description "-I/mnt/opt/likwid-5.2.2/include -I././lammps/includes -I././common/includes -Xlinker -rpath=/apps/SPACK/0.16";
# mark_description ".0/opt/linux-ubuntu20.04-x86_64/gcc-9.3.0/intel-parallel-studio-cluster.2020.2-il7vseg2hbopqvpwum23devywgyxq";
# mark_description "gcz/compilers_and_libraries_2020.2.254/linux/compiler/lib/intel64 -S -std=c11 -pedantic-errors -D_GNU_SOURCE";
# mark_description " -DLIKWID_PERFMON -DAOS -DPRECISION=1 -DCOMPUTE_STATS -DVECTOR_WIDTH=16 -D__ISA_AVX512__ -DENABLE_OMP_SIMD -";
# mark_description "DALIGNMENT=64 -restrict -Ofast -xCORE-AVX512 -qopt-zmm-usage=high -o build-lammps-ICC-AVX512-SP/force_lj.s";
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
        vmovss    108(%rdi), %xmm0                              #25.27
        movq      %rcx, %r14                                    #21.104
        vmovss    48(%rdi), %xmm1                               #26.23
        movq      %rdx, %rbx                                    #21.104
        vmovss    40(%rdi), %xmm2                               #27.24
        movl      4(%r13), %r15d                                #22.18
        vmovss    %xmm0, 24(%rsp)                               #25.27[spill]
        vmovss    %xmm1, 16(%rsp)                               #26.23[spill]
        vmovss    %xmm2, 32(%rsp)                               #27.24[spill]
        testl     %r15d, %r15d                                  #30.24
        jle       ..B1.27       # Prob 50%                      #30.24
                                # LOE rbx r12 r13 r14 r15d
..B1.2:                         # Preds ..B1.1
                                # Execution count [5.00e-03]
        movq      64(%r13), %rdi                                #31.9
        lea       (%r15,%r15,2), %esi                           #22.18
        cmpl      $24, %esi                                     #30.5
        jle       ..B1.34       # Prob 0%                       #30.5
                                # LOE rbx rdi r12 r13 r14 esi r15d
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
        movslq    %r15d, %r15                                   #30.5
        xorl      %esi, %esi                                    #30.5
        lea       (%r15,%r15,2), %rdx                           #30.5
        shlq      $2, %rdx                                      #30.5
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
        vxorpd    %xmm0, %xmm0, %xmm0                           #72.67
        xorl      %esi, %esi                                    #40.15
        vcvtss2sd 32(%rsp), %xmm0, %xmm0                        #72.67[spill]
        vmovdqu32 .L_2il0floatpacket.4(%rip), %zmm20            #54.9
        vmovups   .L_2il0floatpacket.0(%rip), %zmm19            #54.9
        vmovups   .L_2il0floatpacket.3(%rip), %zmm13            #72.54
        vmovss    24(%rsp), %xmm17                              #25.45[spill]
        vmulsd    .L_2il0floatpacket.2(%rip), %xmm0, %xmm1      #72.41
        vmulss    %xmm17, %xmm17, %xmm18                        #25.45
        vbroadcastss 16(%rsp), %zmm17                           #26.21[spill]
        vbroadcastsd %xmm1, %zmm16                              #72.41
        vbroadcastss %xmm18, %zmm18                             #25.25
        movq      24(%rbx), %r11                                #42.25
        xorl      %edi, %edi                                    #40.5
        movq      64(%r13), %r10                                #84.9
        xorl      %eax, %eax                                    #40.5
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
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 zmm13 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.7:                         # Preds ..B1.25 ..B1.6
                                # Execution count [5.00e+00]
        movq      56(%rsp), %r10                                #42.25[spill]
        vxorps    %xmm30, %xmm30, %xmm30                        #46.22
        vmovaps   %xmm30, %xmm21                                #47.22
        movl      (%r10,%rdi,4), %r13d                          #42.25
        vmovaps   %xmm21, %xmm0                                 #48.22
        vmovss    (%rax,%rbx), %xmm11                           #43.25
        vmovss    4(%rax,%rbx), %xmm9                           #44.25
        vmovss    8(%rax,%rbx), %xmm10                          #45.25
        testl     %r13d, %r13d                                  #54.28
        jle       ..B1.25       # Prob 50%                      #54.28
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r13d xmm0 xmm9 xmm10 xmm11 xmm21 xmm30 zmm13 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.8:                         # Preds ..B1.7
                                # Execution count [4.50e+00]
        vpxord    %zmm15, %zmm15, %zmm15                        #46.22
        vmovaps   %zmm15, %zmm14                                #47.22
        vmovaps   %zmm14, %zmm12                                #48.22
        cmpl      $16, %r13d                                    #54.9
        jl        ..B1.33       # Prob 10%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r13d xmm9 xmm10 xmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.9:                         # Preds ..B1.8
                                # Execution count [4.50e+00]
        cmpl      $2400, %r13d                                  #54.9
        jl        ..B1.32       # Prob 10%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r13d xmm9 xmm10 xmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.10:                        # Preds ..B1.9
                                # Execution count [4.50e+00]
        movq      %r8, %r10                                     #41.43
        imulq     %rsi, %r10                                    #41.43
        addq      %r9, %r10                                     #23.5
        movq      %r10, %r12                                    #54.9
        andq      $63, %r12                                     #54.9
        testl     $3, %r12d                                     #54.9
        je        ..B1.12       # Prob 50%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm9 xmm10 xmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.11:                        # Preds ..B1.10
                                # Execution count [2.25e+00]
        xorl      %r12d, %r12d                                  #54.9
        jmp       ..B1.14       # Prob 100%                     #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm9 xmm10 xmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.12:                        # Preds ..B1.10
                                # Execution count [2.25e+00]
        testl     %r12d, %r12d                                  #54.9
        je        ..B1.14       # Prob 50%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm9 xmm10 xmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.13:                        # Preds ..B1.12
                                # Execution count [2.50e+01]
        negl      %r12d                                         #54.9
        addl      $64, %r12d                                    #54.9
        shrl      $2, %r12d                                     #54.9
        cmpl      %r12d, %r13d                                  #54.9
        cmovl     %r13d, %r12d                                  #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm9 xmm10 xmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.14:                        # Preds ..B1.11 ..B1.13 ..B1.12
                                # Execution count [5.00e+00]
        movl      %r13d, %r11d                                  #54.9
        subl      %r12d, %r11d                                  #54.9
        andl      $15, %r11d                                    #54.9
        negl      %r11d                                         #54.9
        addl      %r13d, %r11d                                  #54.9
        cmpl      $1, %r12d                                     #54.9
        jb        ..B1.18       # Prob 50%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r13d xmm9 xmm10 xmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.15:                        # Preds ..B1.14
                                # Execution count [4.50e+00]
        vmovaps   %zmm20, %zmm8                                 #54.9
        xorl      %r15d, %r15d                                  #54.9
        vpbroadcastd %r12d, %zmm7                               #54.9
        vbroadcastss %xmm11, %zmm6                              #43.23
        vbroadcastss %xmm9, %zmm5                               #44.23
        vbroadcastss %xmm10, %zmm4                              #45.23
        movslq    %r12d, %r14                                   #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r15 r11d r12d r13d xmm9 xmm10 xmm11 zmm4 zmm5 zmm6 zmm7 zmm8 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.16:                        # Preds ..B1.16 ..B1.15
                                # Execution count [2.50e+01]
        vpcmpgtd  %zmm8, %zmm7, %k5                             #54.9
        vpaddd    %zmm19, %zmm8, %zmm8                          #54.9
        vmovdqu32 (%r10,%r15,4), %zmm21{%k5}{z}                 #55.21
        vpaddd    %zmm21, %zmm21, %zmm22                        #56.36
        addq      $16, %r15                                     #54.9
        vpaddd    %zmm22, %zmm21, %zmm23                        #56.36
        kmovw     %k5, %k2                                      #56.36
        kmovw     %k5, %k3                                      #56.36
        kmovw     %k5, %k1                                      #56.36
        vpxord    %zmm25, %zmm25, %zmm25                        #56.36
        vpxord    %zmm24, %zmm24, %zmm24                        #56.36
        vpxord    %zmm26, %zmm26, %zmm26                        #56.36
        vgatherdps 4(%rbx,%zmm23,4), %zmm25{%k2}                #56.36
        vgatherdps (%rbx,%zmm23,4), %zmm24{%k3}                 #56.36
        vgatherdps 8(%rbx,%zmm23,4), %zmm26{%k1}                #56.36
        vsubps    %zmm25, %zmm5, %zmm2                          #57.36
        vsubps    %zmm24, %zmm6, %zmm3                          #56.36
        vsubps    %zmm26, %zmm4, %zmm1                          #58.36
        vmulps    %zmm2, %zmm2, %zmm0                           #59.49
        vfmadd231ps %zmm3, %zmm3, %zmm0                         #59.49
        vfmadd231ps %zmm1, %zmm1, %zmm0                         #59.63
        vrcp14ps  %zmm0, %zmm30                                 #70.38
        vcmpps    $1, %zmm18, %zmm0, %k6{%k5}                   #69.22
        #vfpclassps $30, %zmm30, %k0                             #70.38
        #vmovaps   %zmm0, %zmm27                                 #70.38
        #vfnmadd213ps .L_2il0floatpacket.5(%rip){1to16}, %zmm30, %zmm27 #70.38
        #knotw     %k0, %k4                                      #70.38
        #vfmadd213ps %zmm30, %zmm27, %zmm30{%k4}                 #70.38
        vmulps    %zmm17, %zmm30, %zmm28                        #71.38
        vcvtps2pd %ymm30, %zmm21                                #72.61
        vextractf64x4 $1, %zmm30, %ymm31                        #72.61
        vmulps    %zmm28, %zmm30, %zmm29                        #71.44
        vmulpd    %zmm21, %zmm16, %zmm24                        #72.54
        vmulps    %zmm29, %zmm30, %zmm22                        #71.50
        vextractf64x4 $1, %zmm22, %ymm23                        #72.41
        vcvtps2pd %ymm22, %zmm26                                #72.41
        vmulpd    %zmm26, %zmm24, %zmm28                        #72.61
        vsubpd    %zmm13, %zmm26, %zmm29                        #72.54
        vcvtps2pd %ymm31, %zmm30                                #72.61
        vmulpd    %zmm30, %zmm16, %zmm25                        #72.54
        vcvtps2pd %ymm23, %zmm27                                #72.41
        vmulpd    %zmm29, %zmm28, %zmm23                        #72.67
        vmulpd    %zmm27, %zmm25, %zmm21                        #72.61
        vcvtpd2ps %zmm23, %ymm26                                #72.67
        vsubpd    %zmm13, %zmm27, %zmm22                        #72.54
        vmulpd    %zmm22, %zmm21, %zmm24                        #72.67
        vcvtpd2ps %zmm24, %ymm25                                #72.67
        vinsertf64x4 $1, %ymm25, %zmm26, %zmm27                 #72.67
        vfmadd231ps %zmm3, %zmm27, %zmm15{%k6}                  #73.17
        vfmadd231ps %zmm2, %zmm27, %zmm14{%k6}                  #74.17
        vfmadd231ps %zmm1, %zmm27, %zmm12{%k6}                  #75.17
        cmpq      %r14, %r15                                    #54.9
        jb        ..B1.16       # Prob 82%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r15 r11d r12d r13d xmm9 xmm10 xmm11 zmm4 zmm5 zmm6 zmm7 zmm8 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.17:                        # Preds ..B1.16
                                # Execution count [4.50e+00]
        cmpl      %r12d, %r13d                                  #54.9
        je        ..B1.24       # Prob 10%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r12d r13d xmm9 xmm10 xmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.18:                        # Preds ..B1.17 ..B1.14 ..B1.32
                                # Execution count [2.50e+01]
        lea       16(%r12), %r10d                               #54.9
        cmpl      %r10d, %r11d                                  #54.9
        jl        ..B1.22       # Prob 50%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r12d r13d xmm9 xmm10 xmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.19:                        # Preds ..B1.18
                                # Execution count [4.50e+00]
        movq      %r8, %r10                                     #41.43
        imulq     %rsi, %r10                                    #41.43
        vbroadcastss %xmm11, %zmm5                              #43.23
        vbroadcastss %xmm9, %zmm4                               #44.23
        vbroadcastss %xmm10, %zmm3                              #45.23
        movslq    %r12d, %r14                                   #54.9
        addq      %r9, %r10                                     #23.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r11d r12d r13d xmm9 xmm10 xmm11 zmm3 zmm4 zmm5 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.20:                        # Preds ..B1.20 ..B1.19
                                # Execution count [2.50e+01]
        vmovups   (%r10,%r14,4), %zmm6                          #55.21
        addl      $16, %r12d                                    #54.9
        vpcmpeqb  %xmm0, %xmm0, %k2                             #56.36
        vpcmpeqb  %xmm0, %xmm0, %k3                             #56.36
        vpcmpeqb  %xmm0, %xmm0, %k1                             #56.36
        vpaddd    %zmm6, %zmm6, %zmm7                           #56.36
        vpaddd    %zmm7, %zmm6, %zmm8                           #56.36
        addq      $16, %r14                                     #54.9
        vpxord    %zmm22, %zmm22, %zmm22                        #56.36
        vpxord    %zmm21, %zmm21, %zmm21                        #56.36
        vpxord    %zmm23, %zmm23, %zmm23                        #56.36
        vgatherdps 4(%rbx,%zmm8,4), %zmm22{%k2}                 #56.36
        vgatherdps (%rbx,%zmm8,4), %zmm21{%k3}                  #56.36
        vgatherdps 8(%rbx,%zmm8,4), %zmm23{%k1}                 #56.36
        vsubps    %zmm22, %zmm4, %zmm1                          #57.36
        vsubps    %zmm21, %zmm5, %zmm2                          #56.36
        vsubps    %zmm23, %zmm3, %zmm0                          #58.36
        vmulps    %zmm1, %zmm1, %zmm24                          #59.49
        vfmadd231ps %zmm2, %zmm2, %zmm24                        #59.49
        vfmadd231ps %zmm0, %zmm0, %zmm24                        #59.63
        vrcp14ps  %zmm24, %zmm27                                #70.38
        vcmpps    $1, %zmm18, %zmm24, %k5                       #69.22
        #vfpclassps $30, %zmm27, %k0                             #70.38
        #vfnmadd213ps .L_2il0floatpacket.5(%rip){1to16}, %zmm27, %zmm24 #70.38
        #knotw     %k0, %k4                                      #70.38
        #vfmadd213ps %zmm27, %zmm24, %zmm27{%k4}                 #70.38
        vmulps    %zmm17, %zmm27, %zmm25                        #71.38
        vcvtps2pd %ymm27, %zmm29                                #72.61
        vextractf64x4 $1, %zmm27, %ymm28                        #72.61
        vmulps    %zmm25, %zmm27, %zmm26                        #71.44
        vmulpd    %zmm29, %zmm16, %zmm6                         #72.54
        vmulps    %zmm26, %zmm27, %zmm31                        #71.50
        vcvtps2pd %ymm31, %zmm8                                 #72.41
        vextractf64x4 $1, %zmm31, %ymm31                        #72.41
        vmulpd    %zmm8, %zmm6, %zmm22                          #72.61
        vsubpd    %zmm13, %zmm8, %zmm23                         #72.54
        vmulpd    %zmm23, %zmm22, %zmm26                        #72.67
        vcvtpd2ps %zmm26, %ymm29                                #72.67
        vcvtps2pd %ymm28, %zmm30                                #72.61
        vmulpd    %zmm30, %zmm16, %zmm7                         #72.54
        vcvtps2pd %ymm31, %zmm21                                #72.41
        vmulpd    %zmm21, %zmm7, %zmm24                         #72.61
        vsubpd    %zmm13, %zmm21, %zmm25                        #72.54
        vmulpd    %zmm25, %zmm24, %zmm27                        #72.67
        vcvtpd2ps %zmm27, %ymm28                                #72.67
        vinsertf64x4 $1, %ymm28, %zmm29, %zmm30                 #72.67
        vfmadd231ps %zmm2, %zmm30, %zmm15{%k5}                  #73.17
        vfmadd231ps %zmm1, %zmm30, %zmm14{%k5}                  #74.17
        vfmadd231ps %zmm0, %zmm30, %zmm12{%k5}                  #75.17
        cmpl      %r11d, %r12d                                  #54.9
        jb        ..B1.20       # Prob 82%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r11d r12d r13d xmm9 xmm10 xmm11 zmm3 zmm4 zmm5 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.22:                        # Preds ..B1.20 ..B1.18 ..B1.33
                                # Execution count [5.00e+00]
        lea       1(%r11), %r10d                                #54.9
        cmpl      %r13d, %r10d                                  #54.9
        ja        ..B1.24       # Prob 50%                      #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r13d xmm9 xmm10 xmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.23:                        # Preds ..B1.22
                                # Execution count [2.50e+01]
        imulq     %r8, %rsi                                     #41.43
        vbroadcastss %xmm10, %zmm21                             #45.23
        vbroadcastss %xmm9, %zmm8                               #44.23
        vbroadcastss %xmm11, %zmm6                              #43.23
        movl      %r13d, %r10d                                  #54.9
        addq      %r9, %rsi                                     #23.5
        subl      %r11d, %r10d                                  #54.9
        vpbroadcastd %r10d, %zmm10                              #54.9
        vpcmpgtd  %zmm20, %zmm10, %k5                           #54.9
        movslq    %r11d, %r11                                   #54.9
        kmovw     %k5, %k2                                      #56.36
        kmovw     %k5, %k3                                      #56.36
        kmovw     %k5, %k1                                      #56.36
        vmovdqu32 (%rsi,%r11,4), %zmm9{%k5}{z}                  #55.21
        vpaddd    %zmm9, %zmm9, %zmm4                           #56.36
        vpaddd    %zmm4, %zmm9, %zmm5                           #56.36
        vpxord    %zmm11, %zmm11, %zmm11                        #56.36
        vpxord    %zmm7, %zmm7, %zmm7                           #56.36
        vpxord    %zmm22, %zmm22, %zmm22                        #56.36
        vgatherdps 4(%rbx,%zmm5,4), %zmm11{%k2}                 #56.36
        vgatherdps (%rbx,%zmm5,4), %zmm7{%k3}                   #56.36
        vgatherdps 8(%rbx,%zmm5,4), %zmm22{%k1}                 #56.36
        vsubps    %zmm11, %zmm8, %zmm2                          #57.36
        vsubps    %zmm7, %zmm6, %zmm3                           #56.36
        vsubps    %zmm22, %zmm21, %zmm1                         #58.36
        vmulps    %zmm2, %zmm2, %zmm0                           #59.49
        vfmadd231ps %zmm3, %zmm3, %zmm0                         #59.49
        vfmadd231ps %zmm1, %zmm1, %zmm0                         #59.63
        vrcp14ps  %zmm0, %zmm26                                 #70.38
        vcmpps    $1, %zmm18, %zmm0, %k6{%k5}                   #69.22
        #vfpclassps $30, %zmm26, %k0                             #70.38
        #vmovaps   %zmm0, %zmm23                                 #70.38
        #vfnmadd213ps .L_2il0floatpacket.5(%rip){1to16}, %zmm26, %zmm23 #70.38
        #knotw     %k0, %k4                                      #70.38
        #vfmadd213ps %zmm26, %zmm23, %zmm26{%k4}                 #70.38
        vmulps    %zmm17, %zmm26, %zmm24                        #71.38
        vcvtps2pd %ymm26, %zmm28                                #72.61
        vextractf64x4 $1, %zmm26, %ymm27                        #72.61
        vmulps    %zmm24, %zmm26, %zmm25                        #71.44
        vmulpd    %zmm28, %zmm16, %zmm4                         #72.54
        vmulps    %zmm25, %zmm26, %zmm30                        #71.50
        vextractf64x4 $1, %zmm30, %ymm31                        #72.41
        vcvtps2pd %ymm30, %zmm6                                 #72.41
        vmulpd    %zmm6, %zmm4, %zmm8                           #72.61
        vsubpd    %zmm13, %zmm6, %zmm9                          #72.54
        vmulpd    %zmm9, %zmm8, %zmm21                          #72.67
        vcvtpd2ps %zmm21, %ymm24                                #72.67
        vcvtps2pd %ymm27, %zmm29                                #72.61
        vmulpd    %zmm29, %zmm16, %zmm5                         #72.54
        vcvtps2pd %ymm31, %zmm7                                 #72.41
        vmulpd    %zmm7, %zmm5, %zmm10                          #72.61
        vsubpd    %zmm13, %zmm7, %zmm11                         #72.54
        vmulpd    %zmm11, %zmm10, %zmm22                        #72.67
        vcvtpd2ps %zmm22, %ymm23                                #72.67
        vinsertf64x4 $1, %ymm23, %zmm24, %zmm25                 #72.67
        vfmadd231ps %zmm3, %zmm25, %zmm15{%k6}                  #73.17
        vfmadd231ps %zmm2, %zmm25, %zmm14{%k6}                  #74.17
        vfmadd231ps %zmm1, %zmm25, %zmm12{%k6}                  #75.17
                                # LOE rax rdx rcx rbx rdi r8 r9 r13d zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.24:                        # Preds ..B1.17 ..B1.23 ..B1.22
                                # Execution count [4.50e+00]
        vmovups   .L_2il0floatpacket.6(%rip), %zmm22            #48.22
        vmovups   .L_2il0floatpacket.7(%rip), %zmm24            #48.22
        vpermd    %zmm12, %zmm22, %zmm0                         #48.22
        vpermd    %zmm14, %zmm22, %zmm6                         #47.22
        vpermd    %zmm15, %zmm22, %zmm23                        #46.22
        vaddps    %zmm12, %zmm0, %zmm1                          #48.22
        vaddps    %zmm14, %zmm6, %zmm7                          #47.22
        vaddps    %zmm15, %zmm23, %zmm25                        #46.22
        vpermd    %zmm1, %zmm24, %zmm12                         #48.22
        vpermd    %zmm7, %zmm24, %zmm14                         #47.22
        vpermd    %zmm25, %zmm24, %zmm15                        #46.22
        vaddps    %zmm1, %zmm12, %zmm2                          #48.22
        vaddps    %zmm7, %zmm14, %zmm8                          #47.22
        vaddps    %zmm25, %zmm15, %zmm26                        #46.22
        vpshufd   $78, %zmm2, %zmm3                             #48.22
        vpshufd   $78, %zmm8, %zmm9                             #47.22
        vpshufd   $78, %zmm26, %zmm27                           #46.22
        vaddps    %zmm3, %zmm2, %zmm4                           #48.22
        vaddps    %zmm9, %zmm8, %zmm10                          #47.22
        vaddps    %zmm27, %zmm26, %zmm28                        #46.22
        vpshufd   $177, %zmm4, %zmm5                            #48.22
        vpshufd   $177, %zmm10, %zmm11                          #47.22
        vpshufd   $177, %zmm28, %zmm29                          #46.22
        vaddps    %zmm5, %zmm4, %zmm0                           #48.22
        vaddps    %zmm11, %zmm10, %zmm21                        #47.22
        vaddps    %zmm29, %zmm28, %zmm30                        #46.22
                                # LOE rax rdx rcx rbx rdi r8 r9 r13d xmm0 xmm21 xmm30 zmm13 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.25:                        # Preds ..B1.24 ..B1.7
                                # Execution count [5.00e+00]
        movslq    %r13d, %r13                                   #88.9
        movq      48(%rsp), %rsi                                #84.9[spill]
        lea       15(%r13), %r10d                               #89.9
        sarl      $3, %r10d                                     #89.9
        addq      %r13, %rdx                                    #88.9
        shrl      $28, %r10d                                    #89.9
        vaddss    (%rax,%rsi), %xmm30, %xmm1                    #84.9
        vaddss    4(%rax,%rsi), %xmm21, %xmm2                   #85.9
        vaddss    8(%rax,%rsi), %xmm0, %xmm0                    #86.9
        vmovss    %xmm1, (%rax,%rsi)                            #84.9
        lea       15(%r10,%r13), %r11d                          #89.9
        sarl      $4, %r11d                                     #89.9
        vmovss    %xmm2, 4(%rax,%rsi)                           #85.9
        vmovss    %xmm0, 8(%rax,%rsi)                           #86.9
        addq      $12, %rax                                     #40.5
        movslq    %r11d, %r11                                   #89.9
        movslq    %edi, %rsi                                    #40.32
        incq      %rdi                                          #40.5
        addq      %r11, %rcx                                    #89.9
        incq      %rsi                                          #40.32
        cmpq      64(%rsp), %rdi                                #40.5[spill]
        jb        ..B1.7        # Prob 82%                      #40.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 zmm13 zmm16 zmm17 zmm18 zmm19 zmm20
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
        andl      $-16, %r11d                                   #54.9
        jmp       ..B1.18       # Prob 100%                     #54.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r12d r13d xmm9 xmm10 xmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.33:                        # Preds ..B1.8
                                # Execution count [4.50e-01]: Infreq
        xorl      %r11d, %r11d                                  #54.9
        jmp       ..B1.22       # Prob 100%                     #54.9
	.cfi_restore 12
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r13d xmm9 xmm10 xmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20
..B1.34:                        # Preds ..B1.2
                                # Execution count [1.00e+00]: Infreq
        cmpl      $16, %esi                                     #30.5
        jl        ..B1.40       # Prob 10%                      #30.5
                                # LOE rbx rdi r12 r13 r14 esi r15d
..B1.35:                        # Preds ..B1.34
                                # Execution count [1.00e+00]: Infreq
        movl      %esi, %eax                                    #30.5
        xorl      %ecx, %ecx                                    #30.5
        andl      $-16, %eax                                    #30.5
        movslq    %eax, %rdx                                    #30.5
        vpxord    %zmm0, %zmm0, %zmm0                           #31.22
                                # LOE rdx rcx rbx rdi r12 r13 r14 eax esi r15d zmm0
..B1.36:                        # Preds ..B1.36 ..B1.35
                                # Execution count [5.56e+00]: Infreq
        vmovups   %zmm0, (%rdi,%rcx,4)                          #31.9
        addq      $16, %rcx                                     #30.5
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
        vpbroadcastd %esi, %zmm0                                #30.5
        vpcmpgtd  .L_2il0floatpacket.4(%rip), %zmm0, %k1        #30.5
        movslq    %eax, %rax                                    #30.5
        movslq    %r15d, %r15                                   #30.5
        vpxord    %zmm1, %zmm1, %zmm1                           #31.22
        vmovups   %zmm1, (%rdi,%rax,4){%k1}                     #31.9
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
        vmovss    108(%rdi), %xmm0                              #101.27
        movq      %rcx, %r15                                    #97.96
        vmovss    48(%rdi), %xmm1                               #102.23
        movq      %rdx, %r12                                    #97.96
        vmovss    40(%rdi), %xmm2                               #103.24
        movl      4(%r13), %ebx                                 #98.18
        vmovss    %xmm0, 24(%rsp)                               #101.27[spill]
        vmovss    %xmm1, 8(%rsp)                                #102.23[spill]
        vmovss    %xmm2, 16(%rsp)                               #103.24[spill]
        testl     %ebx, %ebx                                    #106.24
        jle       ..B2.30       # Prob 50%                      #106.24
                                # LOE r12 r13 r15 ebx
..B2.2:                         # Preds ..B2.1
                                # Execution count [5.00e-03]
        movq      64(%r13), %rdi                                #107.9
        lea       (%rbx,%rbx,2), %esi                           #98.18
        cmpl      $24, %esi                                     #106.5
        jle       ..B2.37       # Prob 0%                       #106.5
                                # LOE rdi r12 r13 r15 ebx esi
..B2.3:                         # Preds ..B2.2
                                # Execution count [1.00e+00]
        movslq    %ebx, %r14                                    #106.5
        xorl      %esi, %esi                                    #106.5
        lea       (%r14,%r14,2), %rdx                           #106.5
        shlq      $2, %rdx                                      #106.5
        call      __intel_skx_avx512_memset                     #106.5
                                # LOE r12 r13 r14 r15 ebx
..B2.4:                         # Preds ..B2.3 ..B2.49 ..B2.42
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #112.16
        vzeroupper                                              #112.16
..___tag_value_computeForceLJHalfNeigh.71:
#       getTimeStamp()
        call      getTimeStamp                                  #112.16
..___tag_value_computeForceLJHalfNeigh.72:
                                # LOE r12 r13 r14 r15 ebx xmm0
..B2.46:                        # Preds ..B2.4
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 32(%rsp)                               #112.16[spill]
                                # LOE r12 r13 r14 r15 ebx
..B2.5:                         # Preds ..B2.46
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.1, %edi                         #113.5
..___tag_value_computeForceLJHalfNeigh.74:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #113.5
..___tag_value_computeForceLJHalfNeigh.75:
                                # LOE r12 r13 r14 r15 ebx
..B2.6:                         # Preds ..B2.5
                                # Execution count [9.00e-01]
        vxorpd    %xmm0, %xmm0, %xmm0                           #151.67
        xorl      %ecx, %ecx                                    #115.15
        vcvtss2sd 16(%rsp), %xmm0, %xmm0                        #151.67[spill]
        vmovdqu32 .L_2il0floatpacket.4(%rip), %zmm20            #133.9
        vmovups   .L_2il0floatpacket.0(%rip), %zmm21            #133.9
        vmovups   .L_2il0floatpacket.8(%rip), %zmm22            #136.36
        vmovups   .L_2il0floatpacket.9(%rip), %zmm23            #137.36
        vmovss    24(%rsp), %xmm24                              #101.45[spill]
        vmulss    %xmm24, %xmm24, %xmm26                        #101.45
        vmulsd    .L_2il0floatpacket.2(%rip), %xmm0, %xmm1      #151.41
        vmovups   .L_2il0floatpacket.3(%rip), %zmm29            #151.54
        vpbroadcastd %ebx, %zmm19                               #98.18
        vbroadcastss %xmm26, %zmm24                             #101.25
        vbroadcastss 8(%rsp), %zmm26                            #102.21[spill]
        vbroadcastsd %xmm1, %zmm27                              #151.41
        movslq    8(%r12), %rbx                                 #116.43
        xorl      %esi, %esi                                    #115.5
        movq      16(%r12), %rdi                                #116.19
        xorl      %r10d, %r10d                                  #115.5
        shlq      $2, %rbx                                      #99.5
        movq      24(%r12), %rdx                                #117.25
        movq      16(%r13), %rax                                #118.25
        movq      64(%r13), %r11                                #158.21
        movq      (%r15), %r12                                  #169.9
        movq      8(%r15), %r13                                 #170.9
        movq      %rbx, 40(%rsp)                                #115.5[spill]
        movq      %rdi, 48(%rsp)                                #115.5[spill]
        movq      %r14, 56(%rsp)                                #115.5[spill]
        movq      %r15, (%rsp)                                  #115.5[spill]
        vpxord    %zmm30, %zmm30, %zmm30                        #115.5
                                # LOE rax rdx rcx rsi r10 r11 r12 r13 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm26 zmm27 zmm29 zmm30
..B2.7:                         # Preds ..B2.28 ..B2.6
                                # Execution count [5.00e+00]
        movl      (%rdx,%rsi,4), %r9d                           #117.25
        vxorps    %xmm3, %xmm3, %xmm3                           #121.22
        vmovaps   %xmm3, %xmm25                                 #122.22
        vmovss    (%r10,%rax), %xmm15                           #118.25
        vmovaps   %xmm25, %xmm1                                 #123.22
        vmovss    4(%r10,%rax), %xmm16                          #119.25
        vmovss    8(%r10,%rax), %xmm17                          #120.25
        testl     %r9d, %r9d                                    #133.9
        jle       ..B2.28       # Prob 50%                      #133.9
                                # LOE rax rdx rcx rsi r10 r11 r12 r13 r9d xmm1 xmm3 xmm15 xmm16 xmm17 xmm25 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm26 zmm27 zmm29 zmm30
..B2.8:                         # Preds ..B2.7
                                # Execution count [2.50e+00]
        jbe       ..B2.28       # Prob 50%                      #133.9
                                # LOE rax rdx rcx rsi r10 r11 r12 r13 r9d xmm1 xmm3 xmm15 xmm16 xmm17 xmm25 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm26 zmm27 zmm29 zmm30
..B2.9:                         # Preds ..B2.8
                                # Execution count [2.25e+00]
        vmovaps   %zmm30, %zmm28                                #121.22
        vmovaps   %zmm28, %zmm25                                #122.22
        vmovaps   %zmm25, %zmm18                                #123.22
        cmpl      $16, %r9d                                     #133.9
        jb        ..B2.36       # Prob 10%                      #133.9
                                # LOE rax rdx rcx rsi r10 r11 r12 r13 r9d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.10:                        # Preds ..B2.9
                                # Execution count [2.25e+00]
        cmpl      $2400, %r9d                                   #133.9
        jb        ..B2.35       # Prob 10%                      #133.9
                                # LOE rax rdx rcx rsi r10 r11 r12 r13 r9d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.11:                        # Preds ..B2.10
                                # Execution count [2.25e+00]
        movq      40(%rsp), %rbx                                #116.43[spill]
        imulq     %rcx, %rbx                                    #116.43
        addq      48(%rsp), %rbx                                #99.5[spill]
        movq      %rbx, %r8                                     #133.9
        andq      $63, %r8                                      #133.9
        testl     $3, %r8d                                      #133.9
        je        ..B2.13       # Prob 50%                      #133.9
                                # LOE rax rdx rcx rbx rsi r10 r11 r12 r13 r8d r9d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.12:                        # Preds ..B2.11
                                # Execution count [1.12e+00]
        movl      %r9d, %edi                                    #133.9
        xorl      %r8d, %r8d                                    #133.9
        andl      $15, %edi                                     #133.9
        negl      %edi                                          #133.9
        addl      %r9d, %edi                                    #133.9
        jmp       ..B2.19       # Prob 100%                     #133.9
                                # LOE rax rdx rcx rsi r10 r11 r12 r13 edi r8d r9d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.13:                        # Preds ..B2.11
                                # Execution count [1.12e+00]
        testl     %r8d, %r8d                                    #133.9
        je        ..B2.18       # Prob 50%                      #133.9
                                # LOE rax rdx rcx rbx rsi r10 r11 r12 r13 r8d r9d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.14:                        # Preds ..B2.13
                                # Execution count [1.25e+01]
        negl      %r8d                                          #133.9
        movl      %r9d, %edi                                    #133.9
        addl      $64, %r8d                                     #133.9
        shrl      $2, %r8d                                      #133.9
        cmpl      %r8d, %r9d                                    #133.9
        cmovb     %r9d, %r8d                                    #133.9
        subl      %r8d, %edi                                    #133.9
        andl      $15, %edi                                     #133.9
        negl      %edi                                          #133.9
        addl      %r9d, %edi                                    #133.9
        cmpl      $1, %r8d                                      #133.9
        jb        ..B2.19       # Prob 50%                      #133.9
                                # LOE rax rdx rcx rbx rsi r10 r11 r12 r13 edi r8d r9d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.15:                        # Preds ..B2.14
                                # Execution count [2.25e+00]
        vmovaps   %zmm20, %zmm14                                #133.9
        xorl      %r15d, %r15d                                  #133.9
        vpbroadcastd %r8d, %zmm13                               #133.9
        vbroadcastss %xmm15, %zmm12                             #118.23
        vbroadcastss %xmm16, %zmm11                             #119.23
        vbroadcastss %xmm17, %zmm3                              #120.23
        movslq    %r8d, %r14                                    #133.9
                                # LOE rax rdx rcx rbx rsi r10 r11 r12 r13 r14 r15 edi r8d r9d xmm15 xmm16 xmm17 zmm3 zmm11 zmm12 zmm13 zmm14 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.16:                        # Preds ..B2.16 ..B2.15
                                # Execution count [1.25e+01]
        vpcmpud   $1, %zmm13, %zmm14, %k5                       #133.9
        vpaddd    %zmm21, %zmm14, %zmm14                        #133.9
        vmovdqu32 (%rbx,%r15,4), %zmm1{%k5}{z}                  #134.21
        vpaddd    %zmm1, %zmm1, %zmm10                          #135.36
        addq      $16, %r15                                     #133.9
        vpaddd    %zmm10, %zmm1, %zmm5                          #135.36
        kmovw     %k5, %k3                                      #135.36
        kmovw     %k5, %k4                                      #135.36
        kmovw     %k5, %k2                                      #135.36
        vpaddd    %zmm22, %zmm5, %zmm7                          #136.36
        vpaddd    %zmm23, %zmm5, %zmm10                         #137.36
        vpxord    %zmm8, %zmm8, %zmm8                           #135.36
        vpxord    %zmm9, %zmm9, %zmm9                           #135.36
        vpxord    %zmm4, %zmm4, %zmm4                           #135.36
        vgatherdps 4(%rax,%zmm5,4), %zmm8{%k3}                  #135.36
        vgatherdps (%rax,%zmm5,4), %zmm9{%k4}                   #135.36
        vgatherdps 8(%rax,%zmm5,4), %zmm4{%k2}                  #135.36
        vsubps    %zmm8, %zmm11, %zmm8                          #136.36
        vsubps    %zmm9, %zmm12, %zmm6                          #135.36
        vsubps    %zmm4, %zmm3, %zmm9                           #137.36
        vmulps    %zmm8, %zmm8, %zmm31                          #138.49
        vfmadd231ps %zmm6, %zmm6, %zmm31                        #138.49
        vfmadd231ps %zmm9, %zmm9, %zmm31                        #138.63
        vrcp14ps  %zmm31, %zmm2                                 #149.38
        vcmpps    $1, %zmm24, %zmm31, %k7{%k5}                  #148.22
        vfpclassps $30, %zmm2, %k0                              #149.38
        vfnmadd213ps .L_2il0floatpacket.5(%rip){1to16}, %zmm2, %zmm31 #149.38
        vpcmpgtd  %zmm1, %zmm19, %k1{%k7}                       #157.24
        knotw     %k0, %k6                                      #149.38
        vfmadd213ps %zmm2, %zmm31, %zmm2{%k6}                   #149.38
        vmulps    %zmm26, %zmm2, %zmm0                          #150.38
        vcvtps2pd %ymm2, %zmm31                                 #151.61
        vmulps    %zmm0, %zmm2, %zmm1                           #150.44
        vmulpd    %zmm31, %zmm27, %zmm31                        #151.54
        vmulps    %zmm1, %zmm2, %zmm0                           #150.50
        vextractf64x4 $1, %zmm2, %ymm2                          #151.61
        kmovw     %k1, %k2                                      #158.21
        kmovw     %k1, %k3                                      #158.21
        kmovw     %k1, %k4                                      #159.21
        kmovw     %k1, %k5                                      #159.21
        kmovw     %k1, %k6                                      #160.21
        vcvtps2pd %ymm2, %zmm4                                  #151.61
        vmulpd    %zmm4, %zmm27, %zmm1                          #151.54
        vcvtps2pd %ymm0, %zmm4                                  #151.41
        vextractf64x4 $1, %zmm0, %ymm0                          #151.41
        vcvtps2pd %ymm0, %zmm2                                  #151.41
        vmulpd    %zmm4, %zmm31, %zmm0                          #151.61
        vmulpd    %zmm2, %zmm1, %zmm31                          #151.61
        vsubpd    %zmm29, %zmm4, %zmm1                          #151.54
        vsubpd    %zmm29, %zmm2, %zmm2                          #151.54
        vmulpd    %zmm1, %zmm0, %zmm4                           #151.67
        vmulpd    %zmm2, %zmm31, %zmm31                         #151.67
        vcvtpd2ps %zmm4, %ymm0                                  #151.67
        vcvtpd2ps %zmm31, %ymm31                                #151.67
        vmovaps   %zmm30, %zmm1                                 #158.21
        vgatherdps (%r11,%zmm5,4), %zmm1{%k2}                   #158.21
        vinsertf64x4 $1, %ymm31, %zmm0, %zmm2                   #151.67
        vfmadd231ps %zmm6, %zmm2, %zmm28{%k7}                   #152.17
        vfnmadd213ps %zmm1, %zmm2, %zmm6                        #158.21
        vfmadd231ps %zmm8, %zmm2, %zmm25{%k7}                   #153.17
        vfmadd231ps %zmm9, %zmm2, %zmm18{%k7}                   #154.17
        vscatterdps %zmm6, (%r11,%zmm5,4){%k3}                  #158.21
        vmovaps   %zmm30, %zmm5                                 #159.21
        vmovaps   %zmm30, %zmm6                                 #160.21
        vgatherdps (%r11,%zmm7,4), %zmm5{%k4}                   #159.21
        vfnmadd213ps %zmm5, %zmm2, %zmm8                        #159.21
        vscatterdps %zmm8, (%r11,%zmm7,4){%k5}                  #159.21
        vgatherdps (%r11,%zmm10,4), %zmm6{%k6}                  #160.21
        vfnmadd213ps %zmm6, %zmm2, %zmm9                        #160.21
        vscatterdps %zmm9, (%r11,%zmm10,4){%k1}                 #160.21
        cmpq      %r14, %r15                                    #133.9
        jb        ..B2.16       # Prob 82%                      #133.9
                                # LOE rax rdx rcx rbx rsi r10 r11 r12 r13 r14 r15 edi r8d r9d xmm15 xmm16 xmm17 zmm3 zmm11 zmm12 zmm13 zmm14 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.17:                        # Preds ..B2.16
                                # Execution count [2.25e+00]
        cmpl      %r8d, %r9d                                    #133.9
        je        ..B2.27       # Prob 10%                      #133.9
        jmp       ..B2.19       # Prob 100%                     #133.9
                                # LOE rax rdx rcx rsi r10 r11 r12 r13 edi r8d r9d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.18:                        # Preds ..B2.13
                                # Execution count [5.62e-01]
        movl      %r9d, %edi                                    #133.9
        andl      $15, %edi                                     #133.9
        negl      %edi                                          #133.9
        addl      %r9d, %edi                                    #133.9
                                # LOE rax rdx rcx rsi r10 r11 r12 r13 edi r8d r9d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.19:                        # Preds ..B2.12 ..B2.18 ..B2.17 ..B2.14 ..B2.35
                                #      
                                # Execution count [1.25e+01]
        lea       16(%r8), %ebx                                 #133.9
        cmpl      %ebx, %edi                                    #133.9
        jb        ..B2.23       # Prob 50%                      #133.9
                                # LOE rax rdx rcx rsi r10 r11 r12 r13 edi r8d r9d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.20:                        # Preds ..B2.19
                                # Execution count [2.25e+00]
        movq      40(%rsp), %rbx                                #116.43[spill]
        imulq     %rcx, %rbx                                    #116.43
        vbroadcastss %xmm15, %zmm13                             #118.23
        vbroadcastss %xmm16, %zmm12                             #119.23
        vbroadcastss %xmm17, %zmm14                             #120.23
        addq      48(%rsp), %rbx                                #99.5[spill]
        movslq    %r8d, %r14                                    #133.9
                                # LOE rax rdx rcx rbx rsi r10 r11 r12 r13 r14 edi r8d r9d xmm15 xmm16 xmm17 zmm12 zmm13 zmm14 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.21:                        # Preds ..B2.21 ..B2.20
                                # Execution count [1.25e+01]
        vmovups   (%rbx,%r14,4), %zmm5                          #134.21
        addl      $16, %r8d                                     #133.9
        vpaddd    %zmm5, %zmm5, %zmm31                          #135.36
        addq      $16, %r14                                     #133.9
        vpaddd    %zmm31, %zmm5, %zmm11                         #135.36
        vpaddd    %zmm11, %zmm22, %zmm10                        #136.36
        vpxord    %zmm0, %zmm0, %zmm0                           #135.36
        vpcmpeqb  %xmm0, %xmm0, %k1                             #135.36
        vgatherdps 8(%rax,%zmm11,4), %zmm0{%k1}                 #135.36
        vpcmpeqb  %xmm0, %xmm0, %k2                             #135.36
        vpcmpeqb  %xmm0, %xmm0, %k3                             #135.36
        vpxord    %zmm6, %zmm6, %zmm6                           #135.36
        vpxord    %zmm8, %zmm8, %zmm8                           #135.36
        vgatherdps 4(%rax,%zmm11,4), %zmm6{%k2}                 #135.36
        vgatherdps (%rax,%zmm11,4), %zmm8{%k3}                  #135.36
        vsubps    %zmm6, %zmm12, %zmm7                          #136.36
        vsubps    %zmm8, %zmm13, %zmm9                          #135.36
        vsubps    %zmm0, %zmm14, %zmm6                          #137.36
        vpaddd    %zmm11, %zmm23, %zmm8                         #137.36
        vmulps    %zmm7, %zmm7, %zmm2                           #138.49
        vfmadd231ps %zmm9, %zmm9, %zmm2                         #138.49
        vfmadd231ps %zmm6, %zmm6, %zmm2                         #138.63
        vrcp14ps  %zmm2, %zmm0                                  #149.38
        vcmpps    $1, %zmm24, %zmm2, %k5                        #148.22
        vfpclassps $30, %zmm0, %k0                              #149.38
        vfnmadd213ps .L_2il0floatpacket.5(%rip){1to16}, %zmm0, %zmm2 #149.38
        vpcmpgtd  %zmm5, %zmm19, %k2{%k5}                       #157.24
        knotw     %k0, %k4                                      #149.38
        vfmadd213ps %zmm0, %zmm2, %zmm0{%k4}                    #149.38
        vmulps    %zmm26, %zmm0, %zmm1                          #150.38
        vcvtps2pd %ymm0, %zmm31                                 #151.61
        vextractf64x4 $1, %zmm0, %ymm5                          #151.61
        vmulps    %zmm1, %zmm0, %zmm3                           #150.44
        vmulps    %zmm3, %zmm0, %zmm4                           #150.50
        vmulpd    %zmm31, %zmm27, %zmm3                         #151.54
        vcvtps2pd %ymm4, %zmm2                                  #151.41
        vextractf64x4 $1, %zmm4, %ymm4                          #151.41
        vmulpd    %zmm2, %zmm3, %zmm3                           #151.61
        vsubpd    %zmm29, %zmm2, %zmm2                          #151.54
        kmovw     %k2, %k6                                      #158.21
        kmovw     %k2, %k7                                      #158.21
        kmovw     %k2, %k1                                      #160.21
        vcvtps2pd %ymm5, %zmm0                                  #151.61
        vmulpd    %zmm2, %zmm3, %zmm5                           #151.67
        vmulpd    %zmm0, %zmm27, %zmm1                          #151.54
        vcvtps2pd %ymm4, %zmm0                                  #151.41
        vmulpd    %zmm0, %zmm1, %zmm1                           #151.61
        vsubpd    %zmm29, %zmm0, %zmm0                          #151.54
        vmulpd    %zmm0, %zmm1, %zmm31                          #151.67
        vcvtpd2ps %zmm5, %ymm0                                  #151.67
        vcvtpd2ps %zmm31, %ymm31                                #151.67
        vmovaps   %zmm30, %zmm1                                 #158.21
        vgatherdps (%r11,%zmm11,4), %zmm1{%k6}                  #158.21
        kmovw     %k2, %k6                                      #159.21
        vinsertf64x4 $1, %ymm31, %zmm0, %zmm2                   #151.67
        vfmadd231ps %zmm9, %zmm2, %zmm28{%k5}                   #152.17
        vfnmadd213ps %zmm1, %zmm2, %zmm9                        #158.21
        vfmadd231ps %zmm7, %zmm2, %zmm25{%k5}                   #153.17
        vfmadd231ps %zmm6, %zmm2, %zmm18{%k5}                   #154.17
        vscatterdps %zmm9, (%r11,%zmm11,4){%k7}                 #158.21
        vmovaps   %zmm30, %zmm9                                 #159.21
        kmovw     %k2, %k5                                      #159.21
        vgatherdps (%r11,%zmm10,4), %zmm9{%k5}                  #159.21
        vfnmadd213ps %zmm9, %zmm2, %zmm7                        #159.21
        vscatterdps %zmm7, (%r11,%zmm10,4){%k6}                 #159.21
        vmovaps   %zmm30, %zmm7                                 #160.21
        vgatherdps (%r11,%zmm8,4), %zmm7{%k1}                   #160.21
        vfnmadd213ps %zmm7, %zmm2, %zmm6                        #160.21
        vscatterdps %zmm6, (%r11,%zmm8,4){%k2}                  #160.21
        cmpl      %edi, %r8d                                    #133.9
        jb        ..B2.21       # Prob 82%                      #133.9
                                # LOE rax rdx rcx rbx rsi r10 r11 r12 r13 r14 edi r8d r9d xmm15 xmm16 xmm17 zmm12 zmm13 zmm14 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.23:                        # Preds ..B2.21 ..B2.19 ..B2.36
                                # Execution count [2.50e+00]
        lea       1(%rdi), %ebx                                 #133.9
        cmpl      %r9d, %ebx                                    #133.9
        ja        ..B2.27       # Prob 50%                      #133.9
                                # LOE rax rdx rcx rsi r10 r11 r12 r13 edi r9d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.24:                        # Preds ..B2.23
                                # Execution count [2.25e+00]
        imulq     40(%rsp), %rcx                                #116.43[spill]
        vbroadcastss %xmm15, %zmm14                             #118.23
        vbroadcastss %xmm16, %zmm13                             #119.23
        vbroadcastss %xmm17, %zmm11                             #120.23
        movl      %r9d, %ebx                                    #133.9
        xorl      %r8d, %r8d                                    #133.9
        subl      %edi, %ebx                                    #133.9
        addq      48(%rsp), %rcx                                #99.5[spill]
        vmovaps   %zmm20, %zmm31                                #133.9
        vpbroadcastd %ebx, %zmm12                               #133.9
        movslq    %edi, %rdi                                    #133.9
                                # LOE rax rdx rcx rsi rdi r10 r11 r12 r13 ebx r8d r9d zmm11 zmm12 zmm13 zmm14 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30 zmm31
..B2.25:                        # Preds ..B2.25 ..B2.24
                                # Execution count [1.25e+01]
        vpcmpud   $1, %zmm12, %zmm31, %k5                       #133.9
        addl      $16, %r8d                                     #133.9
        vpaddd    %zmm21, %zmm31, %zmm31                        #133.9
        vmovdqu32 (%rcx,%rdi,4), %zmm10{%k5}{z}                 #134.21
        vpaddd    %zmm10, %zmm10, %zmm15                        #135.36
        addq      $16, %rdi                                     #133.9
        vpaddd    %zmm15, %zmm10, %zmm9                         #135.36
        kmovw     %k5, %k2                                      #135.36
        kmovw     %k5, %k3                                      #135.36
        kmovw     %k5, %k1                                      #135.36
        vpaddd    %zmm9, %zmm22, %zmm8                          #136.36
        vpaddd    %zmm9, %zmm23, %zmm6                          #137.36
        vpxord    %zmm17, %zmm17, %zmm17                        #135.36
        vpxord    %zmm16, %zmm16, %zmm16                        #135.36
        vpxord    %zmm4, %zmm4, %zmm4                           #135.36
        vgatherdps 4(%rax,%zmm9,4), %zmm17{%k2}                 #135.36
        vgatherdps (%rax,%zmm9,4), %zmm16{%k3}                  #135.36
        vgatherdps 8(%rax,%zmm9,4), %zmm4{%k1}                  #135.36
        vsubps    %zmm17, %zmm13, %zmm5                         #136.36
        vsubps    %zmm16, %zmm14, %zmm7                         #135.36
        vsubps    %zmm4, %zmm11, %zmm4                          #137.36
        vmulps    %zmm5, %zmm5, %zmm15                          #138.49
        vfmadd231ps %zmm7, %zmm7, %zmm15                        #138.49
        vfmadd231ps %zmm4, %zmm4, %zmm15                        #138.63
        vrcp14ps  %zmm15, %zmm16                                #149.38
        vcmpps    $1, %zmm24, %zmm15, %k6{%k5}                  #148.22
        vfpclassps $30, %zmm16, %k0                             #149.38
        vmovaps   %zmm15, %zmm0                                 #149.38
        vfnmadd213ps .L_2il0floatpacket.5(%rip){1to16}, %zmm16, %zmm0 #149.38
        knotw     %k0, %k4                                      #149.38
        vfmadd213ps %zmm16, %zmm0, %zmm16{%k4}                  #149.38
        vpcmpgtd  %zmm10, %zmm19, %k4{%k6}                      #157.24
        vmulps    %zmm26, %zmm16, %zmm1                         #150.38
        vcvtps2pd %ymm16, %zmm0                                 #151.61
        vextractf64x4 $1, %zmm16, %ymm17                        #151.61
        vmulps    %zmm1, %zmm16, %zmm2                          #150.44
        vmulps    %zmm2, %zmm16, %zmm3                          #150.50
        vmulpd    %zmm0, %zmm27, %zmm2                          #151.54
        vcvtps2pd %ymm3, %zmm0                                  #151.41
        vextractf64x4 $1, %zmm3, %ymm3                          #151.41
        vmulpd    %zmm0, %zmm2, %zmm2                           #151.61
        vsubpd    %zmm29, %zmm0, %zmm0                          #151.54
        kmovw     %k4, %k7                                      #158.21
        kmovw     %k4, %k1                                      #159.21
        kmovw     %k4, %k2                                      #159.21
        kmovw     %k4, %k3                                      #160.21
        vcvtps2pd %ymm17, %zmm1                                 #151.61
        vmulpd    %zmm1, %zmm27, %zmm1                          #151.54
        vcvtps2pd %ymm3, %zmm10                                 #151.41
        vmulpd    %zmm10, %zmm1, %zmm1                          #151.61
        vsubpd    %zmm29, %zmm10, %zmm3                         #151.54
        vmulpd    %zmm0, %zmm2, %zmm10                          #151.67
        vmulpd    %zmm3, %zmm1, %zmm15                          #151.67
        vcvtpd2ps %zmm10, %ymm17                                #151.67
        vcvtpd2ps %zmm15, %ymm16                                #151.67
        vmovaps   %zmm30, %zmm0                                 #158.21
        vgatherdps (%r11,%zmm9,4), %zmm0{%k7}                   #158.21
        vinsertf64x4 $1, %ymm16, %zmm17, %zmm1                  #151.67
        vfmadd231ps %zmm7, %zmm1, %zmm28{%k6}                   #152.17
        vfnmadd213ps %zmm0, %zmm1, %zmm7                        #158.21
        vfmadd231ps %zmm5, %zmm1, %zmm25{%k6}                   #153.17
        vfmadd231ps %zmm4, %zmm1, %zmm18{%k6}                   #154.17
        kmovw     %k4, %k6                                      #158.21
        vscatterdps %zmm7, (%r11,%zmm9,4){%k6}                  #158.21
        vmovaps   %zmm30, %zmm7                                 #159.21
        vgatherdps (%r11,%zmm8,4), %zmm7{%k1}                   #159.21
        vfnmadd213ps %zmm7, %zmm1, %zmm5                        #159.21
        vscatterdps %zmm5, (%r11,%zmm8,4){%k2}                  #159.21
        vmovaps   %zmm30, %zmm5                                 #160.21
        vgatherdps (%r11,%zmm6,4), %zmm5{%k3}                   #160.21
        vfnmadd213ps %zmm5, %zmm1, %zmm4                        #160.21
        vscatterdps %zmm4, (%r11,%zmm6,4){%k4}                  #160.21
        cmpl      %ebx, %r8d                                    #133.9
        jb        ..B2.25       # Prob 82%                      #133.9
                                # LOE rax rdx rcx rsi rdi r10 r11 r12 r13 ebx r8d r9d zmm11 zmm12 zmm13 zmm14 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30 zmm31
..B2.27:                        # Preds ..B2.25 ..B2.17 ..B2.23
                                # Execution count [2.25e+00]
        vmovups   .L_2il0floatpacket.6(%rip), %zmm0             #123.22
        vpermd    %zmm18, %zmm0, %zmm1                          #123.22
        vpermd    %zmm25, %zmm0, %zmm8                          #122.22
        vpermd    %zmm28, %zmm0, %zmm15                         #121.22
        vaddps    %zmm18, %zmm1, %zmm3                          #123.22
        vaddps    %zmm25, %zmm8, %zmm10                         #122.22
        vaddps    %zmm28, %zmm15, %zmm17                        #121.22
        vmovups   .L_2il0floatpacket.7(%rip), %zmm18            #123.22
        vpermd    %zmm3, %zmm18, %zmm2                          #123.22
        vpermd    %zmm10, %zmm18, %zmm9                         #122.22
        vpermd    %zmm17, %zmm18, %zmm16                        #121.22
        vaddps    %zmm3, %zmm2, %zmm4                           #123.22
        vaddps    %zmm10, %zmm9, %zmm11                         #122.22
        vaddps    %zmm17, %zmm16, %zmm28                        #121.22
        vpshufd   $78, %zmm4, %zmm5                             #123.22
        vpshufd   $78, %zmm11, %zmm12                           #122.22
        vpshufd   $78, %zmm28, %zmm31                           #121.22
        vaddps    %zmm5, %zmm4, %zmm6                           #123.22
        vaddps    %zmm12, %zmm11, %zmm13                        #122.22
        vaddps    %zmm31, %zmm28, %zmm0                         #121.22
        vpshufd   $177, %zmm6, %zmm7                            #123.22
        vpshufd   $177, %zmm13, %zmm14                          #122.22
        vpshufd   $177, %zmm0, %zmm2                            #121.22
        vaddps    %zmm7, %zmm6, %zmm1                           #123.22
        vaddps    %zmm14, %zmm13, %zmm25                        #122.22
        vaddps    %zmm2, %zmm0, %zmm3                           #121.22
                                # LOE rax rdx rsi r10 r11 r12 r13 r9d xmm1 xmm3 xmm25 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm26 zmm27 zmm29 zmm30
..B2.28:                        # Preds ..B2.27 ..B2.8 ..B2.7
                                # Execution count [5.00e+00]
        movslq    %r9d, %r9                                     #169.9
        vaddss    (%r10,%r11), %xmm3, %xmm0                     #165.9
        vaddss    4(%r10,%r11), %xmm25, %xmm2                   #166.9
        vaddss    8(%r10,%r11), %xmm1, %xmm1                    #167.9
        vmovss    %xmm0, (%r10,%r11)                            #165.9
        lea       15(%r9), %ecx                                 #170.9
        sarl      $3, %ecx                                      #170.9
        addq      %r9, %r12                                     #169.9
        shrl      $28, %ecx                                     #170.9
        vmovss    %xmm2, 4(%r10,%r11)                           #166.9
        vmovss    %xmm1, 8(%r10,%r11)                           #167.9
        addq      $12, %r10                                     #115.5
        lea       15(%rcx,%r9), %ebx                            #170.9
        movslq    %esi, %rcx                                    #115.32
        sarl      $4, %ebx                                      #170.9
        incq      %rsi                                          #115.5
        movslq    %ebx, %rbx                                    #170.9
        incq      %rcx                                          #115.32
        addq      %rbx, %r13                                    #170.9
        cmpq      56(%rsp), %rsi                                #115.5[spill]
        jb        ..B2.7        # Prob 82%                      #115.5
                                # LOE rax rdx rcx rsi r10 r11 r12 r13 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm26 zmm27 zmm29 zmm30
..B2.29:                        # Preds ..B2.28
                                # Execution count [9.00e-01]
        movq      (%rsp), %r15                                  #[spill]
        movq      %r12, (%r15)                                  #169.9
        movq      %r13, 8(%r15)                                 #170.9
        jmp       ..B2.32       # Prob 100%                     #170.9
                                # LOE
..B2.30:                        # Preds ..B2.1
                                # Execution count [5.00e-01]
        xorl      %eax, %eax                                    #112.16
..___tag_value_computeForceLJHalfNeigh.91:
#       getTimeStamp()
        call      getTimeStamp                                  #112.16
..___tag_value_computeForceLJHalfNeigh.92:
                                # LOE xmm0
..B2.47:                        # Preds ..B2.30
                                # Execution count [5.00e-01]
        vmovsd    %xmm0, 32(%rsp)                               #112.16[spill]
                                # LOE
..B2.31:                        # Preds ..B2.47
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.1, %edi                         #113.5
..___tag_value_computeForceLJHalfNeigh.94:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #113.5
..___tag_value_computeForceLJHalfNeigh.95:
                                # LOE
..B2.32:                        # Preds ..B2.29 ..B2.31
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.1, %edi                         #173.5
        vzeroupper                                              #173.5
..___tag_value_computeForceLJHalfNeigh.96:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #173.5
..___tag_value_computeForceLJHalfNeigh.97:
                                # LOE
..B2.33:                        # Preds ..B2.32
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #174.16
..___tag_value_computeForceLJHalfNeigh.98:
#       getTimeStamp()
        call      getTimeStamp                                  #174.16
..___tag_value_computeForceLJHalfNeigh.99:
                                # LOE xmm0
..B2.34:                        # Preds ..B2.33
                                # Execution count [1.00e+00]
        vsubsd    32(%rsp), %xmm0, %xmm0                        #175.14[spill]
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
..B2.35:                        # Preds ..B2.10
                                # Execution count [2.25e-01]: Infreq
        movl      %r9d, %edi                                    #133.9
        xorl      %r8d, %r8d                                    #133.9
        andl      $-16, %edi                                    #133.9
        jmp       ..B2.19       # Prob 100%                     #133.9
                                # LOE rax rdx rcx rsi r10 r11 r12 r13 edi r8d r9d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.36:                        # Preds ..B2.9
                                # Execution count [2.25e-01]: Infreq
        xorl      %edi, %edi                                    #133.9
        jmp       ..B2.23       # Prob 100%                     #133.9
                                # LOE rax rdx rcx rsi r10 r11 r12 r13 edi r9d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.37:                        # Preds ..B2.2
                                # Execution count [1.00e+00]: Infreq
        cmpl      $16, %esi                                     #106.5
        jl        ..B2.43       # Prob 10%                      #106.5
                                # LOE rdi r12 r13 r15 ebx esi
..B2.38:                        # Preds ..B2.37
                                # Execution count [1.00e+00]: Infreq
        movl      %esi, %eax                                    #106.5
        xorl      %ecx, %ecx                                    #106.5
        andl      $-16, %eax                                    #106.5
        movslq    %eax, %rdx                                    #106.5
        vpxord    %zmm0, %zmm0, %zmm0                           #106.5
                                # LOE rdx rcx rdi r12 r13 r15 eax ebx esi zmm0
..B2.39:                        # Preds ..B2.39 ..B2.38
                                # Execution count [5.56e+00]: Infreq
        vmovups   %zmm0, (%rdi,%rcx,4)                          #107.9
        addq      $16, %rcx                                     #106.5
        cmpq      %rdx, %rcx                                    #106.5
        jb        ..B2.39       # Prob 82%                      #106.5
                                # LOE rdx rcx rdi r12 r13 r15 eax ebx esi zmm0
..B2.41:                        # Preds ..B2.39 ..B2.43
                                # Execution count [1.11e+00]: Infreq
        lea       1(%rax), %edx                                 #106.5
        cmpl      %esi, %edx                                    #106.5
        ja        ..B2.49       # Prob 50%                      #106.5
                                # LOE rdi r12 r13 r15 eax ebx esi
..B2.42:                        # Preds ..B2.41
                                # Execution count [5.56e+00]: Infreq
        subl      %eax, %esi                                    #106.5
        vpbroadcastd %esi, %zmm0                                #106.5
        vpcmpgtd  .L_2il0floatpacket.4(%rip), %zmm0, %k1        #106.5
        movslq    %eax, %rax                                    #106.5
        movslq    %ebx, %r14                                    #106.5
        vpxord    %zmm1, %zmm1, %zmm1                           #107.9
        vmovups   %zmm1, (%rdi,%rax,4){%k1}                     #107.9
        jmp       ..B2.4        # Prob 100%                     #107.9
                                # LOE r12 r13 r14 r15 ebx
..B2.43:                        # Preds ..B2.37
                                # Execution count [1.00e-01]: Infreq
        xorl      %eax, %eax                                    #106.5
        jmp       ..B2.41       # Prob 100%                     #106.5
                                # LOE rdi r12 r13 r15 eax ebx esi
..B2.49:                        # Preds ..B2.41
                                # Execution count [5.56e-01]: Infreq
        movslq    %ebx, %r14                                    #106.5
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
..___tag_value_computeForceLJFullNeigh_simd.116:
..L117:
                                                        #178.101
        pushq     %rbp                                          #178.101
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #178.101
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #178.101
        movl      4(%rsi), %eax                                 #179.18
        testl     %eax, %eax                                    #185.24
        jle       ..B3.4        # Prob 50%                      #185.24
                                # LOE rbx rsi r12 r13 r14 r15 eax
..B3.2:                         # Preds ..B3.1
                                # Execution count [5.00e-03]
        movq      64(%rsi), %rdi                                #186.9
        lea       (%rax,%rax,2), %esi                           #179.18
        cmpl      $24, %esi                                     #185.5
        jle       ..B3.8        # Prob 0%                       #185.5
                                # LOE rbx rdi r12 r13 r14 r15 eax esi
..B3.3:                         # Preds ..B3.2
                                # Execution count [1.00e+00]
        movslq    %eax, %rax                                    #185.5
        xorl      %esi, %esi                                    #185.5
        lea       (%rax,%rax,2), %rdx                           #185.5
        shlq      $2, %rdx                                      #185.5
        call      __intel_skx_avx512_memset                     #185.5
                                # LOE rbx r12 r13 r14 r15
..B3.4:                         # Preds ..B3.12 ..B3.1 ..B3.3 ..B3.13
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #191.16
        vzeroupper                                              #191.16
..___tag_value_computeForceLJFullNeigh_simd.121:
#       getTimeStamp()
        call      getTimeStamp                                  #191.16
..___tag_value_computeForceLJFullNeigh_simd.122:
                                # LOE rbx r12 r13 r14 r15
..B3.5:                         # Preds ..B3.4
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.0, %edi                         #192.5
..___tag_value_computeForceLJFullNeigh_simd.123:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #192.5
..___tag_value_computeForceLJFullNeigh_simd.124:
                                # LOE
..B3.6:                         # Preds ..B3.5
                                # Execution count [1.00e+00]
        movl      $il0_peep_printf_format_0, %edi               #195.5
        movq      stderr(%rip), %rsi                            #195.5
        call      fputs                                         #195.5
                                # LOE
..B3.7:                         # Preds ..B3.6
                                # Execution count [1.00e+00]
        movl      $-1, %edi                                     #196.5
#       exit(int)
        call      exit                                          #196.5
                                # LOE
..B3.8:                         # Preds ..B3.2
                                # Execution count [1.00e+00]: Infreq
        cmpl      $16, %esi                                     #185.5
        jl        ..B3.14       # Prob 10%                      #185.5
                                # LOE rbx rdi r12 r13 r14 r15 esi
..B3.9:                         # Preds ..B3.8
                                # Execution count [1.00e+00]: Infreq
        movl      %esi, %eax                                    #185.5
        xorl      %ecx, %ecx                                    #185.5
        andl      $-16, %eax                                    #185.5
        movslq    %eax, %rdx                                    #185.5
        vpxord    %zmm0, %zmm0, %zmm0                           #186.22
                                # LOE rdx rcx rbx rdi r12 r13 r14 r15 eax esi zmm0
..B3.10:                        # Preds ..B3.10 ..B3.9
                                # Execution count [5.56e+00]: Infreq
        vmovups   %zmm0, (%rdi,%rcx,4)                          #186.9
        addq      $16, %rcx                                     #185.5
        cmpq      %rdx, %rcx                                    #185.5
        jb        ..B3.10       # Prob 82%                      #185.5
                                # LOE rdx rcx rbx rdi r12 r13 r14 r15 eax esi zmm0
..B3.12:                        # Preds ..B3.10 ..B3.14
                                # Execution count [1.11e+00]: Infreq
        lea       1(%rax), %edx                                 #185.5
        cmpl      %esi, %edx                                    #185.5
        ja        ..B3.4        # Prob 50%                      #185.5
                                # LOE rbx rdi r12 r13 r14 r15 eax esi
..B3.13:                        # Preds ..B3.12
                                # Execution count [5.56e+00]: Infreq
        subl      %eax, %esi                                    #185.5
        vpbroadcastd %esi, %zmm0                                #185.5
        vpcmpgtd  .L_2il0floatpacket.4(%rip), %zmm0, %k1        #185.5
        movslq    %eax, %rax                                    #185.5
        vpxord    %zmm1, %zmm1, %zmm1                           #186.22
        vmovups   %zmm1, (%rdi,%rax,4){%k1}                     #186.9
        jmp       ..B3.4        # Prob 100%                     #186.9
                                # LOE rbx r12 r13 r14 r15
..B3.14:                        # Preds ..B3.8
                                # Execution count [1.00e-01]: Infreq
        xorl      %eax, %eax                                    #185.5
        jmp       ..B3.12       # Prob 100%                     #185.5
        .align    16,0x90
                                # LOE rbx rdi r12 r13 r14 r15 eax esi
	.cfi_endproc
# mark_end;
	.type	computeForceLJFullNeigh_simd,@function
	.size	computeForceLJFullNeigh_simd,.-computeForceLJFullNeigh_simd
..LNcomputeForceLJFullNeigh_simd.2:
	.section .rodata.str1.32, "aMS",@progbits,1
	.align 32
	.align 32
il0_peep_printf_format_0:
	.long	1869771333
	.long	1394621042
	.long	541347145
	.long	1852990827
	.long	1847618661
	.long	1763734639
	.long	1701605485
	.long	1953391981
	.long	1713398885
	.long	1931506287
	.long	1768121712
	.long	1684367718
	.long	1936615712
	.long	1668641396
	.long	1852795252
	.long	1952805664
	.word	33
	.data
# -- End  computeForceLJFullNeigh_simd
	.section .rodata, "a"
	.align 64
	.align 64
.L_2il0floatpacket.0:
	.long	0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010
	.type	.L_2il0floatpacket.0,@object
	.size	.L_2il0floatpacket.0,64
	.align 64
.L_2il0floatpacket.1:
	.long	0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000
	.type	.L_2il0floatpacket.1,@object
	.size	.L_2il0floatpacket.1,64
	.align 64
.L_2il0floatpacket.3:
	.long	0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000
	.type	.L_2il0floatpacket.3,@object
	.size	.L_2il0floatpacket.3,64
	.align 64
.L_2il0floatpacket.4:
	.long	0x00000000,0x00000001,0x00000002,0x00000003,0x00000004,0x00000005,0x00000006,0x00000007,0x00000008,0x00000009,0x0000000a,0x0000000b,0x0000000c,0x0000000d,0x0000000e,0x0000000f
	.type	.L_2il0floatpacket.4,@object
	.size	.L_2il0floatpacket.4,64
	.align 64
.L_2il0floatpacket.6:
	.long	0x00000008,0x00000009,0x0000000a,0x0000000b,0x0000000c,0x0000000d,0x0000000e,0x0000000f,0x00000008,0x00000009,0x0000000a,0x0000000b,0x0000000c,0x0000000d,0x0000000e,0x0000000f
	.type	.L_2il0floatpacket.6,@object
	.size	.L_2il0floatpacket.6,64
	.align 64
.L_2il0floatpacket.7:
	.long	0x00000004,0x00000005,0x00000006,0x00000007,0x00000004,0x00000005,0x00000006,0x00000007,0x00000004,0x00000005,0x00000006,0x00000007,0x00000004,0x00000005,0x00000006,0x00000007
	.type	.L_2il0floatpacket.7,@object
	.size	.L_2il0floatpacket.7,64
	.align 64
.L_2il0floatpacket.8:
	.long	0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001
	.type	.L_2il0floatpacket.8,@object
	.size	.L_2il0floatpacket.8,64
	.align 64
.L_2il0floatpacket.9:
	.long	0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002
	.type	.L_2il0floatpacket.9,@object
	.size	.L_2il0floatpacket.9,64
	.align 8
.L_2il0floatpacket.2:
	.long	0x00000000,0x40480000
	.type	.L_2il0floatpacket.2,@object
	.size	.L_2il0floatpacket.2,8
	.align 4
.L_2il0floatpacket.5:
	.long	0x3f800000
	.type	.L_2il0floatpacket.5,@object
	.size	.L_2il0floatpacket.5,4
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
