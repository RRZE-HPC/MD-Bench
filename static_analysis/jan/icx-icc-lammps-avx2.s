# mark_description "Intel(R) C Intel(R) 64 Compiler Classic for applications running on Intel(R) 64, Version 2021.6.0 Build 2022";
# mark_description "0226_000000";
# mark_description "-I/apps/likwid/5.2.2/include -I././lammps/includes -I././common/includes -S -std=c11 -pedantic-errors -D_GNU";
# mark_description "_SOURCE -DLIKWID_PERFMON -DAOS -DPRECISION=2 -DCOMPUTE_STATS -DVECTOR_WIDTH=4 -D__ISA_AVX2__ -DENABLE_OMP_SI";
# mark_description "MD -DALIGNMENT=64 -restrict -Ofast -xCORE-AVX2 -o build-lammps-ICC-AVX2-DP/force_lj.s";
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
        andq      $-32, %rsp                                    #23.104
        pushq     %r13                                          #23.104
        pushq     %r14                                          #23.104
        pushq     %r15                                          #23.104
        pushq     %rbx                                          #23.104
        subq      $224, %rsp                                    #23.104
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
        movq      %rsi, %r15                                    #23.104
        vmovsd    144(%rdi), %xmm0                              #27.27
        movq      %rcx, %r13                                    #23.104
        vmulsd    %xmm0, %xmm0, %xmm1                           #27.45
        movq      %rdx, %r14                                    #23.104
        vmovsd    56(%rdi), %xmm2                               #28.23
        vmovsd    40(%rdi), %xmm3                               #29.24
        movl      4(%r15), %eax                                 #24.18
        vmovsd    %xmm1, 128(%rsp)                              #27.45[spill]
        vmovsd    %xmm2, 136(%rsp)                              #28.23[spill]
        vmovsd    %xmm3, 24(%rsp)                               #29.24[spill]
        testl     %eax, %eax                                    #32.24
        jle       ..B1.34       # Prob 50%                      #32.24
                                # LOE r12 r13 r14 r15 eax
..B1.2:                         # Preds ..B1.1
                                # Execution count [5.00e-03]
        movslq    %eax, %rbx                                    #24.18
        lea       (%rax,%rax,2), %eax                           #24.18
        movq      64(%r15), %rdi                                #33.9
        cmpl      $12, %eax                                     #32.5
        jle       ..B1.43       # Prob 0%                       #32.5
                                # LOE rbx rdi r12 r13 r14 r15
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
        xorl      %esi, %esi                                    #32.5
        lea       (%rbx,%rbx,2), %rdx                           #32.5
        shlq      $3, %rdx                                      #32.5
        call      __intel_avx_rep_memset                        #32.5
                                # LOE rbx r12 r13 r14 r15
..B1.5:                         # Preds ..B1.49 ..B1.3 ..B1.47
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #38.16
        vzeroupper                                              #38.16
..___tag_value_computeForceLJFullNeigh_plain_c.13:
#       getTimeStamp()
        call      getTimeStamp                                  #38.16
..___tag_value_computeForceLJFullNeigh_plain_c.14:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.54:                        # Preds ..B1.5
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 16(%rsp)                               #38.16[spill]
                                # LOE rbx r12 r13 r14 r15
..B1.6:                         # Preds ..B1.54
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.0, %edi                         #39.5
..___tag_value_computeForceLJFullNeigh_plain_c.16:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #39.5
..___tag_value_computeForceLJFullNeigh_plain_c.17:
                                # LOE rbx r12 r13 r14 r15
..B1.7:                         # Preds ..B1.6
                                # Execution count [9.00e-01]
        vmovsd    24(%rsp), %xmm0                               #77.41[spill]
        xorl      %eax, %eax                                    #41.15
        vmulsd    .L_2il0floatpacket.0(%rip), %xmm0, %xmm4      #77.41
        xorl      %ecx, %ecx                                    #41.5
        vbroadcastsd 128(%rsp), %ymm6                           #27.25[spill]
        vbroadcastsd %xmm4, %ymm7                               #77.41
        vbroadcastsd 136(%rsp), %ymm2                           #28.21[spill]
        vmovsd    .L_2il0floatpacket.4(%rip), %xmm5             #75.32
        vmovsd    .L_2il0floatpacket.1(%rip), %xmm0             #77.54
        vmovupd   %ymm6, 32(%rsp)                               #41.5[spill]
        vmovupd   %ymm7, 64(%rsp)                               #41.5[spill]
        vmovsd    136(%rsp), %xmm6                              #41.5[spill]
        vmovsd    128(%rsp), %xmm7                              #41.5[spill]
        vmovupd   %ymm2, 96(%rsp)                               #41.5[spill]
        movslq    8(%r14), %rsi                                 #42.43
        xorl      %edi, %edi                                    #41.5
        movq      16(%r14), %rdx                                #42.19
        shlq      $2, %rsi                                      #25.5
        movq      24(%r14), %r14                                #43.25
        movq      16(%r15), %r11                                #44.25
        movq      64(%r15), %r8                                 #89.9
        movq      (%r13), %r9                                   #93.9
        movq      8(%r13), %r10                                 #94.9
        movq      %rsi, 144(%rsp)                               #41.5[spill]
        movq      %rdx, 152(%rsp)                               #41.5[spill]
        movq      %rbx, 208(%rsp)                               #41.5[spill]
        movq      %r13, (%rsp)                                  #41.5[spill]
        movq      %r12, 8(%rsp)                                 #41.5[spill]
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0x08, 0xff, 0xff, 0xff, 0x22
                                # LOE rax rcx rdi r8 r9 r10 r11 r14 xmm0 xmm4 xmm5 xmm6 xmm7
..B1.8:                         # Preds ..B1.32 ..B1.7
                                # Execution count [5.00e+00]
        movl      (%r14,%rcx,4), %r13d                          #43.25
        testl     %r13d, %r13d                                  #56.28
        vxorpd    %xmm8, %xmm8, %xmm8                           #47.22
        vmovapd   %xmm8, %xmm9                                  #48.22
        vmovsd    (%rdi,%r11), %xmm3                            #44.25
        vmovapd   %xmm9, %xmm10                                 #49.22
        vmovsd    8(%rdi,%r11), %xmm2                           #45.25
        vmovsd    16(%rdi,%r11), %xmm1                          #46.25
        movslq    %r13d, %r12                                   #56.9
        jle       ..B1.32       # Prob 50%                      #56.28
                                # LOE rax rcx rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.9:                         # Preds ..B1.8
                                # Execution count [4.50e+00]
        cmpq      $4, %r12                                      #56.9
        jl        ..B1.39       # Prob 10%                      #56.9
                                # LOE rax rcx rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.10:                        # Preds ..B1.9
                                # Execution count [4.50e+00]
        movq      144(%rsp), %rbx                               #42.43[spill]
        imulq     %rax, %rbx                                    #42.43
        addq      152(%rsp), %rbx                               #25.5[spill]
        cmpq      $600, %r12                                    #56.9
        jl        ..B1.41       # Prob 10%                      #56.9
                                # LOE rax rcx rbx rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.11:                        # Preds ..B1.10
                                # Execution count [4.50e+00]
        movq      %rbx, %r15                                    #56.9
        andq      $31, %r15                                     #56.9
        testl     %r15d, %r15d                                  #56.9
        je        ..B1.14       # Prob 50%                      #56.9
                                # LOE rax rcx rbx rdi r8 r9 r10 r11 r12 r14 r13d r15d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.12:                        # Preds ..B1.11
                                # Execution count [4.50e+00]
        testl     $3, %r15d                                     #56.9
        jne       ..B1.39       # Prob 10%                      #56.9
                                # LOE rax rcx rbx rdi r8 r9 r10 r11 r12 r14 r13d r15d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.13:                        # Preds ..B1.12
                                # Execution count [2.25e+00]
        negl      %r15d                                         #56.9
        addl      $32, %r15d                                    #56.9
        shrl      $2, %r15d                                     #56.9
                                # LOE rax rcx rbx rdi r8 r9 r10 r11 r12 r14 r13d r15d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.14:                        # Preds ..B1.13 ..B1.11
                                # Execution count [4.50e+00]
        movl      %r15d, %edx                                   #56.9
        lea       4(%rdx), %rsi                                 #56.9
        cmpq      %rsi, %r12                                    #56.9
        jl        ..B1.39       # Prob 10%                      #56.9
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r11 r12 r14 r13d r15d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.15:                        # Preds ..B1.14
                                # Execution count [5.00e+00]
        movl      %r13d, %esi                                   #56.9
        subl      %r15d, %esi                                   #56.9
        andl      $3, %esi                                      #56.9
        negl      %esi                                          #56.9
        addl      %r13d, %esi                                   #56.9
        movslq    %esi, %rsi                                    #56.9
        testl     %r15d, %r15d                                  #56.9
        movl      $0, %r15d                                     #56.9
        jbe       ..B1.21       # Prob 10%                      #56.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r14 r15 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.16:                        # Preds ..B1.15
                                # Execution count [4.50e+00]
        movq      %rcx, 24(%rsp)                                #[spill]
                                # LOE rax rdx rbx rsi rdi r8 r9 r10 r11 r12 r14 r15 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.17:                        # Preds ..B1.19 ..B1.16
                                # Execution count [2.50e+01]
        movl      (%rbx,%r15,4), %ecx                           #57.21
        lea       (%rcx,%rcx,2), %ecx                           #58.36
        movslq    %ecx, %rcx                                    #58.36
        vsubsd    8(%r11,%rcx,8), %xmm2, %xmm13                 #59.36
        vsubsd    (%r11,%rcx,8), %xmm3, %xmm12                  #58.36
        vsubsd    16(%r11,%rcx,8), %xmm1, %xmm11                #60.36
        vmulsd    %xmm13, %xmm13, %xmm14                        #61.49
        vfmadd231sd %xmm12, %xmm12, %xmm14                      #61.63
        vfmadd231sd %xmm11, %xmm11, %xmm14                      #61.63
        vcomisd   %xmm14, %xmm7                                 #71.22
        jbe       ..B1.19       # Prob 50%                      #71.22
                                # LOE rax rdx rbx rsi rdi r8 r9 r10 r11 r12 r14 r15 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B1.18:                        # Preds ..B1.17
                                # Execution count [1.25e+01]
        vdivsd    %xmm14, %xmm5, %xmm15                         #75.38
        vmulsd    %xmm15, %xmm6, %xmm14                         #76.38
        vmulsd    %xmm15, %xmm14, %xmm14                        #76.44
        vmulsd    %xmm15, %xmm14, %xmm14                        #76.50
        vmulsd    %xmm4, %xmm15, %xmm15                         #77.54
        vmulsd    %xmm14, %xmm15, %xmm15                        #77.61
        vsubsd    %xmm0, %xmm14, %xmm14                         #77.54
        vmulsd    %xmm14, %xmm15, %xmm15                        #77.67
        vfmadd231sd %xmm12, %xmm15, %xmm8                       #78.17
        vfmadd231sd %xmm15, %xmm13, %xmm9                       #79.17
        vfmadd231sd %xmm15, %xmm11, %xmm10                      #80.17
                                # LOE rax rdx rbx rsi rdi r8 r9 r10 r11 r12 r14 r15 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.19:                        # Preds ..B1.18 ..B1.17
                                # Execution count [2.50e+01]
        incq      %r15                                          #56.9
        cmpq      %rdx, %r15                                    #56.9
        jb        ..B1.17       # Prob 82%                      #56.9
                                # LOE rax rdx rbx rsi rdi r8 r9 r10 r11 r12 r14 r15 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.20:                        # Preds ..B1.19
                                # Execution count [4.50e+00]
        movq      24(%rsp), %rcx                                #[spill]
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.21:                        # Preds ..B1.20 ..B1.15 ..B1.41
                                # Execution count [4.50e+00]
        vmovsd    %xmm3, 192(%rsp)                              #71.22[spill]
        vxorpd    %xmm11, %xmm11, %xmm11                        #47.22
        vmovsd    %xmm8, %xmm11, %xmm13                         #47.22
        vmovsd    %xmm9, %xmm11, %xmm12                         #48.22
        vmovsd    %xmm10, %xmm11, %xmm11                        #49.22
        vmovsd    %xmm4, 200(%rsp)                              #71.22[spill]
        vbroadcastsd %xmm3, %ymm10                              #44.23
        vmovsd    %xmm1, 176(%rsp)                              #71.22[spill]
        vmovsd    %xmm2, 184(%rsp)                              #71.22[spill]
        vmovupd   .L_2il0floatpacket.3(%rip), %ymm3             #71.22
        vmovupd   .L_2il0floatpacket.2(%rip), %ymm4             #71.22
        vmovupd   32(%rsp), %ymm5                               #71.22[spill]
        vbroadcastsd %xmm2, %ymm9                               #45.23
        vbroadcastsd %xmm1, %ymm8                               #46.23
        movq      %r8, 160(%rsp)                                #71.22[spill]
        movq      %r14, 168(%rsp)                               #71.22[spill]
        movq      %rcx, 24(%rsp)                                #71.22[spill]
        vmovaps   %xmm13, %xmm13                                #47.22
        vmovaps   %xmm12, %xmm12                                #48.22
        vmovaps   %xmm11, %xmm11                                #49.22
                                # LOE rax rdx rbx rsi rdi r9 r10 r11 r12 r13d ymm3 ymm4 ymm5 ymm8 ymm9 ymm10 ymm11 ymm12 ymm13
# LLVM-MCA-BEGIN
# OSACA-BEGIN
..B1.22:                        # Preds ..B1.24 ..B1.21
                                # Execution count [2.50e+01]
        vmovdqu   (%rbx,%rdx,4), %xmm0                          #57.21
        vmovq     %xmm0, %rcx                                   #57.21
        vpunpckhqdq %xmm0, %xmm0, %xmm2                         #57.21
        vmovq     %xmm2, %r15                                   #57.21
        movl      %ecx, %r8d                                    #57.21
        shrq      $32, %rcx                                     #57.21
        lea       (%rcx,%rcx,2), %r14d                          #58.36
        lea       (%r8,%r8,2), %r8d                             #58.36
        movslq    %r8d, %rcx                                    #58.36
        movslq    %r14d, %r8                                    #58.36
        movl      %r15d, %r14d                                  #57.21
        shrq      $32, %r15                                     #57.21
        vmovups   (%r11,%rcx,8), %xmm7                          #58.36
        vmovups   (%r11,%r8,8), %xmm6                           #58.36
        vmovq     16(%r11,%rcx,8), %xmm14                       #58.36
        lea       (%r14,%r14,2), %r14d                          #58.36
        movslq    %r14d, %r14                                   #58.36
        lea       (%r15,%r15,2), %r15d                          #58.36
        movslq    %r15d, %r15                                   #58.36
        vmovhpd   16(%r11,%r8,8), %xmm14, %xmm15                #58.36
        vinsertf128 $1, (%r11,%r14,8), %ymm7, %ymm1             #58.36
        vmovq     16(%r11,%r14,8), %xmm0                        #58.36
        vinsertf128 $1, (%r11,%r15,8), %ymm6, %ymm6             #58.36
        vmovhpd   16(%r11,%r15,8), %xmm0, %xmm2                 #58.36
        vunpcklpd %ymm6, %ymm1, %ymm14                          #58.36
        vunpckhpd %ymm6, %ymm1, %ymm1                           #58.36
        vsubpd    %ymm14, %ymm10, %ymm6                         #58.36
        vinsertf128 $1, %xmm2, %ymm15, %ymm7                    #58.36
        vsubpd    %ymm1, %ymm9, %ymm2                           #59.36
        vsubpd    %ymm7, %ymm8, %ymm0                           #60.36
        vmulpd    %ymm2, %ymm2, %ymm14                          #61.49
        vfmadd231pd %ymm6, %ymm6, %ymm14                        #61.49
        vfmadd231pd %ymm0, %ymm0, %ymm14                        #61.63
        vcmpltpd  %ymm5, %ymm14, %ymm1                          #71.22
        vpcmpeqd  %ymm7, %ymm7, %ymm7                           #71.22
        vptest    %ymm7, %ymm1                                  #71.22
        je        ..B1.24       # Prob 50%                      #71.22
                                # LOE rax rdx rbx rsi rdi r9 r10 r11 r12 r13d ymm0 ymm1 ymm2 ymm3 ymm4 ymm5 ymm6 ymm8 ymm9 ymm10 ymm11 ymm12 ymm13 ymm14
..B1.23:                        # Preds ..B1.22
                                # Execution count [1.25e+01]
        vdivpd    %ymm14, %ymm4, %ymm7                          #75.38
        vmulpd    96(%rsp), %ymm7, %ymm14                       #76.38[spill]
        vmulpd    %ymm14, %ymm7, %ymm14                         #76.44
        vmulpd    %ymm14, %ymm7, %ymm15                         #76.50
        vfmsub213pd %ymm3, %ymm7, %ymm14                        #77.54
        vmulpd    64(%rsp), %ymm7, %ymm7                        #77.54[spill]
        vmulpd    %ymm7, %ymm15, %ymm15                         #77.61
        vmulpd    %ymm14, %ymm15, %ymm7                         #77.67
        vmulpd    %ymm7, %ymm6, %ymm6                           #78.31
        vmulpd    %ymm7, %ymm2, %ymm2                           #79.31
        vandpd    %ymm6, %ymm1, %ymm6                           #78.31
        vaddpd    %ymm6, %ymm13, %ymm13                         #78.17
        vmulpd    %ymm7, %ymm0, %ymm6                           #80.31
        vandpd    %ymm2, %ymm1, %ymm0                           #79.31
        vandpd    %ymm6, %ymm1, %ymm1                           #80.31
        vaddpd    %ymm0, %ymm12, %ymm12                         #79.17
        vaddpd    %ymm1, %ymm11, %ymm11                         #80.17
                                # LOE rax rdx rbx rsi rdi r9 r10 r11 r12 r13d ymm3 ymm4 ymm5 ymm8 ymm9 ymm10 ymm11 ymm12 ymm13
..B1.24:                        # Preds ..B1.23 ..B1.22
                                # Execution count [2.50e+01]
        addq      $4, %rdx                                      #56.9
        cmpq      %rsi, %rdx                                    #56.9
        jb        ..B1.22       # Prob 82%                      #56.9
# OSACA-END
# LLVM-MCA-END
                                # LOE rax rdx rbx rsi rdi r9 r10 r11 r12 r13d ymm3 ymm4 ymm5 ymm8 ymm9 ymm10 ymm11 ymm12 ymm13
..B1.25:                        # Preds ..B1.24
                                # Execution count [4.50e+00]
        vextractf128 $1, %ymm11, %xmm10                         #49.22
        vmovsd    176(%rsp), %xmm1                              #[spill]
        vmovsd    184(%rsp), %xmm2                              #[spill]
        vaddpd    %xmm10, %xmm11, %xmm9                         #49.22
        vunpckhpd %xmm9, %xmm9, %xmm8                           #49.22
        vmovsd    192(%rsp), %xmm3                              #[spill]
        vaddsd    %xmm8, %xmm9, %xmm10                          #49.22
        vmovsd    200(%rsp), %xmm4                              #[spill]
        vmovsd    136(%rsp), %xmm6                              #[spill]
        vmovsd    128(%rsp), %xmm7                              #[spill]
        movq      160(%rsp), %r8                                #[spill]
        movq      168(%rsp), %r14                               #[spill]
        movq      24(%rsp), %rcx                                #[spill]
        vmovsd    .L_2il0floatpacket.1(%rip), %xmm0             #
        vmovsd    .L_2il0floatpacket.4(%rip), %xmm5             #
        vextractf128 $1, %ymm12, %xmm14                         #48.22
        vextractf128 $1, %ymm13, %xmm8                          #47.22
        vaddpd    %xmm14, %xmm12, %xmm15                        #48.22
        vaddpd    %xmm8, %xmm13, %xmm11                         #47.22
        vunpckhpd %xmm15, %xmm15, %xmm9                         #48.22
        vunpckhpd %xmm11, %xmm11, %xmm12                        #47.22
        vaddsd    %xmm9, %xmm15, %xmm9                          #48.22
        vaddsd    %xmm12, %xmm11, %xmm8                         #47.22
                                # LOE rax rcx rsi rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.26:                        # Preds ..B1.25 ..B1.39
                                # Execution count [5.00e+00]
        cmpq      %r12, %rsi                                    #56.9
        jae       ..B1.32       # Prob 10%                      #56.9
                                # LOE rax rcx rsi rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.27:                        # Preds ..B1.26
                                # Execution count [4.50e+00]
        imulq     144(%rsp), %rax                               #42.43[spill]
        addq      152(%rsp), %rax                               #25.5[spill]
                                # LOE rax rcx rsi rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.28:                        # Preds ..B1.30 ..B1.27
                                # Execution count [2.50e+01]
        movl      (%rax,%rsi,4), %edx                           #57.21
        lea       (%rdx,%rdx,2), %ebx                           #58.36
        movslq    %ebx, %rbx                                    #58.36
        vsubsd    8(%r11,%rbx,8), %xmm2, %xmm13                 #59.36
        vsubsd    (%r11,%rbx,8), %xmm3, %xmm12                  #58.36
        vsubsd    16(%r11,%rbx,8), %xmm1, %xmm11                #60.36
        vmulsd    %xmm13, %xmm13, %xmm14                        #61.49
        vfmadd231sd %xmm12, %xmm12, %xmm14                      #61.63
        vfmadd231sd %xmm11, %xmm11, %xmm14                      #61.63
        vcomisd   %xmm14, %xmm7                                 #71.22
        jbe       ..B1.30       # Prob 50%                      #71.22
                                # LOE rax rcx rsi rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B1.29:                        # Preds ..B1.28
                                # Execution count [1.25e+01]
        vdivsd    %xmm14, %xmm5, %xmm15                         #75.38
        vmulsd    %xmm15, %xmm6, %xmm14                         #76.38
        vmulsd    %xmm15, %xmm14, %xmm14                        #76.44
        vmulsd    %xmm15, %xmm14, %xmm14                        #76.50
        vmulsd    %xmm4, %xmm15, %xmm15                         #77.54
        vmulsd    %xmm14, %xmm15, %xmm15                        #77.61
        vsubsd    %xmm0, %xmm14, %xmm14                         #77.54
        vmulsd    %xmm14, %xmm15, %xmm15                        #77.67
        vfmadd231sd %xmm12, %xmm15, %xmm8                       #78.17
        vfmadd231sd %xmm15, %xmm13, %xmm9                       #79.17
        vfmadd231sd %xmm15, %xmm11, %xmm10                      #80.17
                                # LOE rax rcx rsi rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.30:                        # Preds ..B1.29 ..B1.28
                                # Execution count [2.50e+01]
        incq      %rsi                                          #56.9
        cmpq      %r12, %rsi                                    #56.9
        jb        ..B1.28       # Prob 82%                      #56.9
                                # LOE rax rcx rsi rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.32:                        # Preds ..B1.30 ..B1.8 ..B1.26
                                # Execution count [5.00e+00]
        addq      %r12, %r9                                     #93.9
        lea       3(%r13), %eax                                 #94.9
        sarl      $1, %eax                                      #94.9
        vaddsd    (%rdi,%r8), %xmm8, %xmm1                      #89.9
        vaddsd    8(%rdi,%r8), %xmm9, %xmm2                     #90.9
        vaddsd    16(%rdi,%r8), %xmm10, %xmm3                   #91.9
        shrl      $30, %eax                                     #94.9
        vmovsd    %xmm1, (%rdi,%r8)                             #89.9
        vmovsd    %xmm2, 8(%rdi,%r8)                            #90.9
        vmovsd    %xmm3, 16(%rdi,%r8)                           #91.9
        addq      $24, %rdi                                     #41.5
        lea       3(%rax,%r13), %edx                            #94.9
        movslq    %ecx, %rax                                    #41.32
        sarl      $2, %edx                                      #94.9
        incq      %rcx                                          #41.5
        movslq    %edx, %rdx                                    #94.9
        incq      %rax                                          #41.32
        addq      %rdx, %r10                                    #94.9
        cmpq      208(%rsp), %rcx                               #41.5[spill]
        jb        ..B1.8        # Prob 82%                      #41.5
                                # LOE rax rcx rdi r8 r9 r10 r11 r14 xmm0 xmm4 xmm5 xmm6 xmm7
..B1.33:                        # Preds ..B1.32
                                # Execution count [9.00e-01]
        movq      (%rsp), %r13                                  #[spill]
        movq      8(%rsp), %r12                                 #[spill]
	.cfi_restore 12
        movq      %r9, (%r13)                                   #93.9
        movq      %r10, 8(%r13)                                 #94.9
        jmp       ..B1.36       # Prob 100%                     #94.9
                                # LOE r12
..B1.34:                        # Preds ..B1.1
                                # Execution count [5.00e-01]
        xorl      %eax, %eax                                    #38.16
..___tag_value_computeForceLJFullNeigh_plain_c.61:
#       getTimeStamp()
        call      getTimeStamp                                  #38.16
..___tag_value_computeForceLJFullNeigh_plain_c.62:
                                # LOE r12 xmm0
..B1.55:                        # Preds ..B1.34
                                # Execution count [5.00e-01]
        vmovsd    %xmm0, 16(%rsp)                               #38.16[spill]
                                # LOE r12
..B1.35:                        # Preds ..B1.55
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.0, %edi                         #39.5
..___tag_value_computeForceLJFullNeigh_plain_c.64:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #39.5
..___tag_value_computeForceLJFullNeigh_plain_c.65:
                                # LOE r12
..B1.36:                        # Preds ..B1.33 ..B1.35
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.0, %edi                         #97.5
        vzeroupper                                              #97.5
..___tag_value_computeForceLJFullNeigh_plain_c.66:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #97.5
..___tag_value_computeForceLJFullNeigh_plain_c.67:
                                # LOE r12
..B1.37:                        # Preds ..B1.36
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #98.16
..___tag_value_computeForceLJFullNeigh_plain_c.68:
#       getTimeStamp()
        call      getTimeStamp                                  #98.16
..___tag_value_computeForceLJFullNeigh_plain_c.69:
                                # LOE r12 xmm0
..B1.38:                        # Preds ..B1.37
                                # Execution count [1.00e+00]
        vsubsd    16(%rsp), %xmm0, %xmm0                        #102.14[spill]
        addq      $224, %rsp                                    #102.14
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
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0x08, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B1.39:                        # Preds ..B1.9 ..B1.12 ..B1.14
                                # Execution count [4.50e-01]: Infreq
        xorl      %esi, %esi                                    #56.9
        jmp       ..B1.26       # Prob 100%                     #56.9
                                # LOE rax rcx rsi rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.41:                        # Preds ..B1.10
                                # Execution count [4.50e-01]: Infreq
        movl      %r13d, %esi                                   #56.9
        xorl      %edx, %edx                                    #56.9
        andl      $-4, %esi                                     #56.9
        movslq    %esi, %rsi                                    #56.9
        jmp       ..B1.21       # Prob 100%                     #56.9
	.cfi_restore 12
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.43:                        # Preds ..B1.2
                                # Execution count [1.00e+00]: Infreq
        lea       (%rbx,%rbx,2), %rcx                           #24.18
        cmpq      $8, %rcx                                      #32.5
        jl        ..B1.51       # Prob 10%                      #32.5
                                # LOE rcx rbx rdi r12 r13 r14 r15
..B1.44:                        # Preds ..B1.43
                                # Execution count [1.00e+00]: Infreq
        movl      %ecx, %eax                                    #32.5
        xorl      %edx, %edx                                    #32.5
        andl      $-8, %eax                                     #32.5
        movslq    %eax, %rax                                    #32.5
        vxorpd    %ymm0, %ymm0, %ymm0                           #33.22
                                # LOE rax rdx rcx rbx rdi r12 r13 r14 r15 ymm0
..B1.45:                        # Preds ..B1.45 ..B1.44
                                # Execution count [5.56e+00]: Infreq
        vmovupd   %ymm0, (%rdi,%rdx,8)                          #33.9
        vmovupd   %ymm0, 32(%rdi,%rdx,8)                        #33.9
        addq      $8, %rdx                                      #32.5
        cmpq      %rax, %rdx                                    #32.5
        jb        ..B1.45       # Prob 82%                      #32.5
                                # LOE rax rdx rcx rbx rdi r12 r13 r14 r15 ymm0
..B1.47:                        # Preds ..B1.45 ..B1.51
                                # Execution count [1.11e+00]: Infreq
        cmpq      %rcx, %rax                                    #32.5
        jae       ..B1.5        # Prob 10%                      #32.5
                                # LOE rax rcx rbx rdi r12 r13 r14 r15
..B1.48:                        # Preds ..B1.47
                                # Execution count [1.00e+00]: Infreq
        xorl      %edx, %edx                                    #
                                # LOE rax rdx rcx rbx rdi r12 r13 r14 r15
..B1.49:                        # Preds ..B1.48 ..B1.49
                                # Execution count [5.56e+00]: Infreq
        movq      %rdx, (%rdi,%rax,8)                           #33.9
        incq      %rax                                          #32.5
        cmpq      %rcx, %rax                                    #32.5
        jb        ..B1.49       # Prob 82%                      #32.5
        jmp       ..B1.5        # Prob 100%                     #32.5
                                # LOE rax rdx rcx rbx rdi r12 r13 r14 r15
..B1.51:                        # Preds ..B1.43
                                # Execution count [1.00e-01]: Infreq
        xorl      %eax, %eax                                    #32.5
        jmp       ..B1.47       # Prob 100%                     #32.5
        .align    16,0x90
                                # LOE rax rcx rbx rdi r12 r13 r14 r15
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
..___tag_value_computeForceLJHalfNeigh.86:
..L87:
                                                         #105.96
        pushq     %rbp                                          #105.96
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #105.96
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-32, %rsp                                    #105.96
        pushq     %r12                                          #105.96
        pushq     %r13                                          #105.96
        pushq     %r14                                          #105.96
        pushq     %r15                                          #105.96
        pushq     %rbx                                          #105.96
        subq      $248, %rsp                                    #105.96
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
        movq      %rdi, %r12                                    #105.96
        movq      %rsi, %r14                                    #105.96
        movq      %rcx, %r15                                    #105.96
        movq      %rdx, 32(%rsp)                                #105.96[spill]
        vmovsd    144(%r12), %xmm0                              #109.27
        vmulsd    %xmm0, %xmm0, %xmm1                           #109.45
        vmovsd    56(%r12), %xmm2                               #110.23
        vmovsd    40(%r12), %xmm3                               #111.24
        movl      4(%r14), %r13d                                #106.18
        vmovsd    %xmm1, 56(%rsp)                               #109.45[spill]
        vmovsd    %xmm2, 48(%rsp)                               #110.23[spill]
        vmovsd    %xmm3, 24(%rsp)                               #111.24[spill]
        testl     %r13d, %r13d                                  #114.24
        jle       ..B2.51       # Prob 50%                      #114.24
                                # LOE r12 r14 r15 r13d
..B2.2:                         # Preds ..B2.1
                                # Execution count [5.00e-03]
        movslq    %r13d, %r13                                   #106.18
        movq      64(%r14), %rdi                                #115.9
        lea       (%r13,%r13,2), %eax                           #106.18
        movq      %r13, 40(%rsp)                                #106.18[spill]
        cmpl      $12, %eax                                     #114.5
        jle       ..B2.59       # Prob 0%                       #114.5
                                # LOE rdi r12 r13 r14 r15 r13d
..B2.3:                         # Preds ..B2.2
                                # Execution count [1.00e+00]
        movq      %r13, %rax                                    #114.5
        xorl      %esi, %esi                                    #114.5
        lea       (%rax,%rax,2), %rdx                           #114.5
        shlq      $3, %rdx                                      #114.5
        call      __intel_avx_rep_memset                        #114.5
                                # LOE r12 r14 r15 r13d
..B2.5:                         # Preds ..B2.65 ..B2.3 ..B2.63
                                # Execution count [1.00e+00]
        xorl      %ebx, %ebx                                    #120.22
        xorl      %eax, %eax                                    #121.16
        vzeroupper                                              #121.16
..___tag_value_computeForceLJHalfNeigh.101:
#       getTimeStamp()
        call      getTimeStamp                                  #121.16
..___tag_value_computeForceLJHalfNeigh.102:
                                # LOE r12 r14 r15 ebx r13d xmm0
..B2.70:                        # Preds ..B2.5
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 16(%rsp)                               #121.16[spill]
                                # LOE r12 r14 r15 ebx r13d
..B2.6:                         # Preds ..B2.70
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.1, %edi                         #122.5
..___tag_value_computeForceLJHalfNeigh.104:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #122.5
..___tag_value_computeForceLJHalfNeigh.105:
                                # LOE r12 r14 r15 ebx r13d
..B2.7:                         # Preds ..B2.6
                                # Execution count [9.00e-01]
        vmovsd    24(%rsp), %xmm5                               #161.41[spill]
        vmovd     %r13d, %xmm0                                  #106.18
        vmulsd    .L_2il0floatpacket.0(%rip), %xmm5, %xmm5      #161.41
        xorl      %r9d, %r9d                                    #124.15
        movq      32(%rsp), %rdx                                #125.19[spill]
        xorl      %r8d, %r8d                                    #124.5
        vmovddup  56(%rsp), %xmm8                               #109.25[spill]
        xorl      %esi, %esi                                    #124.5
        vmovddup  48(%rsp), %xmm4                               #110.21[spill]
        movslq    8(%rdx), %rax                                 #125.43
        shlq      $2, %rax                                      #107.5
        movq      16(%rdx), %rdi                                #125.19
        vmovddup  %xmm5, %xmm3                                  #161.41
        vpbroadcastd %xmm0, %xmm1                               #106.18
        movq      24(%rdx), %rcx                                #126.25
        movq      16(%r14), %rdx                                #127.25
        movq      %rax, 64(%rsp)                                #124.5[spill]
        vmovsd    .L_2il0floatpacket.4(%rip), %xmm7             #159.32
        vmovdqu   .L_2il0floatpacket.6(%rip), %xmm9             #147.36
        vmovsd    .L_2il0floatpacket.1(%rip), %xmm0             #161.54
        movq      64(%r14), %r14                                #168.21
        movq      (%r15), %r11                                  #179.9
        movq      8(%r15), %r10                                 #180.9
        vmovdqu   %xmm1, 192(%rsp)                              #124.5[spill]
        vmovupd   %xmm3, 176(%rsp)                              #124.5[spill]
        vmovupd   %xmm4, 160(%rsp)                              #124.5[spill]
        vmovupd   %xmm8, 208(%rsp)                              #124.5[spill]
        movq      %rdi, 72(%rsp)                                #124.5[spill]
        movl      %r13d, 80(%rsp)                               #124.5[spill]
        movq      %r12, (%rsp)                                  #124.5[spill]
        movq      %r15, 8(%rsp)                                 #124.5[spill]
        vmovsd    48(%rsp), %xmm6                               #124.5[spill]
        vmovsd    56(%rsp), %xmm2                               #124.5[spill]
        movq      40(%rsp), %rax                                #124.5[spill]
                                # LOE rax rdx rcx rsi r8 r9 r10 r11 r14 ebx xmm0 xmm2 xmm5 xmm6 xmm7
..B2.8:                         # Preds ..B2.49 ..B2.7
                                # Execution count [5.00e+00]
        movl      (%rcx,%r8,4), %edi                            #126.25
        addl      %edi, %ebx                                    #138.9
        vxorpd    %xmm10, %xmm10, %xmm10                        #130.22
        testl     %edi, %edi                                    #143.9
        vmovapd   %xmm10, %xmm11                                #131.22
        vmovsd    (%rsi,%rdx), %xmm4                            #127.25
        vmovapd   %xmm11, %xmm12                                #132.22
        vmovsd    8(%rsi,%rdx), %xmm3                           #128.25
        vmovsd    16(%rsi,%rdx), %xmm1                          #129.25
        jle       ..B2.48       # Prob 50%                      #143.9
                                # LOE rax rdx rcx rbx rsi r8 r9 r10 r11 r14 edi xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.9:                         # Preds ..B2.8
                                # Execution count [2.50e+00]
        jbe       ..B2.48       # Prob 50%                      #143.9
                                # LOE rax rdx rcx rbx rsi r8 r9 r10 r11 r14 edi xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.10:                        # Preds ..B2.9
                                # Execution count [2.25e+00]
        cmpl      $2, %edi                                      #143.9
        jb        ..B2.58       # Prob 10%                      #143.9
                                # LOE rax rdx rcx rbx rsi r8 r9 r10 r11 r14 edi xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.11:                        # Preds ..B2.10
                                # Execution count [2.25e+00]
        movq      64(%rsp), %r13                                #125.43[spill]
        movl      %edi, %r12d                                   #143.9
        imulq     %r9, %r13                                     #125.43
        vxorpd    %xmm14, %xmm14, %xmm14                        #130.22
        andl      $-2, %r12d                                    #143.9
        vmovapd   %xmm14, %xmm13                                #131.22
        addq      72(%rsp), %r13                                #107.5[spill]
        xorl      %r15d, %r15d                                  #143.9
        vmovddup  %xmm4, %xmm10                                 #127.23
        vmovapd   %xmm13, %xmm11                                #132.22
        vmovddup  %xmm3, %xmm9                                  #128.23
        vmovddup  %xmm1, %xmm8                                  #129.23
        movslq    %r12d, %r12                                   #143.9
        vmovsd    %xmm1, 128(%rsp)                              #143.9[spill]
        vmovsd    %xmm3, 136(%rsp)                              #143.9[spill]
        vmovsd    %xmm4, 144(%rsp)                              #143.9[spill]
        vmovsd    %xmm5, 152(%rsp)                              #143.9[spill]
        movq      %r9, 24(%rsp)                                 #143.9[spill]
        movl      %edi, 32(%rsp)                                #143.9[spill]
        movq      %rsi, 88(%rsp)                                #143.9[spill]
        movq      %r10, 96(%rsp)                                #143.9[spill]
        movq      %r11, 104(%rsp)                               #143.9[spill]
        movq      %rcx, 112(%rsp)                               #143.9[spill]
        movq      %r8, 120(%rsp)                                #143.9[spill]
        vmovdqu   .L_2il0floatpacket.6(%rip), %xmm6             #143.9
        vmovdqu   .L_2il0floatpacket.5(%rip), %xmm7             #143.9
                                # LOE rdx rbx r12 r13 r14 r15 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.12:                        # Preds ..B2.38 ..B2.11
                                # Execution count [1.25e+01]
        vmovq     (%r13,%r15,4), %xmm4                          #144.21
        vpaddd    %xmm4, %xmm4, %xmm0                           #145.36
        vpaddd    %xmm0, %xmm4, %xmm1                           #145.36
        vmovd     %xmm1, %r9d                                   #145.36
        vpaddd    %xmm7, %xmm1, %xmm12                          #146.36
        vpshufd   $57, %xmm1, %xmm2                             #145.36
        vpshufd   $57, %xmm12, %xmm15                           #146.36
        vmovd     %xmm2, %r8d                                   #145.36
        vmovd     %xmm12, %edi                                  #146.36
        vmovd     %xmm15, %ecx                                  #146.36
        movslq    %r9d, %r9                                     #145.36
        movslq    %r8d, %r8                                     #145.36
        movslq    %edi, %rdi                                    #146.36
        movslq    %ecx, %rcx                                    #146.36
        vmovsd    (%rdx,%r9,8), %xmm3                           #145.36
        vmovhpd   (%rdx,%r8,8), %xmm3, %xmm5                    #145.36
        vsubpd    %xmm5, %xmm10, %xmm0                          #145.36
        vpaddd    %xmm6, %xmm1, %xmm5                           #147.36
        vmovd     %xmm5, %eax                                   #147.36
        vpshufd   $57, %xmm5, %xmm1                             #147.36
        vmovsd    (%rdx,%rdi,8), %xmm2                          #146.36
        vmovd     %xmm1, %r10d                                  #147.36
        vmovhpd   (%rdx,%rcx,8), %xmm2, %xmm3                   #146.36
        vpcmpeqd  %xmm1, %xmm1, %xmm1                           #158.22
        vsubpd    %xmm3, %xmm9, %xmm2                           #146.36
        movslq    %eax, %rax                                    #147.36
        movslq    %r10d, %r10                                   #147.36
        vmovsd    (%rdx,%rax,8), %xmm12                         #147.36
        vmovhpd   (%rdx,%r10,8), %xmm12, %xmm15                 #147.36
        vsubpd    %xmm15, %xmm8, %xmm3                          #147.36
        vmulpd    %xmm2, %xmm2, %xmm15                          #148.49
        vfmadd231pd %xmm0, %xmm0, %xmm15                        #148.49
        vfmadd231pd %xmm3, %xmm3, %xmm15                        #148.63
        vcmpltpd  208(%rsp), %xmm15, %xmm5                      #158.22[spill]
        vptest    %xmm1, %xmm5                                  #158.22
        je        ..B2.38       # Prob 50%                      #158.22
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r12 r13 r14 r15 xmm0 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14 xmm15
..B2.13:                        # Preds ..B2.12
                                # Execution count [6.25e+00]
        vmovupd   .L_2il0floatpacket.7(%rip), %xmm12            #159.38
        vdivpd    %xmm15, %xmm12, %xmm1                         #159.38
        vmovdqu   192(%rsp), %xmm12                             #167.24[spill]
        vpcmpeqd  %xmm15, %xmm15, %xmm15                        #167.24
        vpcmpgtd  %xmm4, %xmm12, %xmm4                          #167.24
        vmulpd    160(%rsp), %xmm1, %xmm12                      #160.38[spill]
        vmulpd    %xmm12, %xmm1, %xmm12                         #160.44
        vpmovsxdq %xmm4, %xmm4                                  #167.24
        vandpd    %xmm4, %xmm5, %xmm4                           #167.24
        vptest    %xmm15, %xmm4                                 #167.24
        vmulpd    %xmm12, %xmm1, %xmm15                         #160.50
        vfmsub213pd .L_2il0floatpacket.8(%rip), %xmm1, %xmm12   #161.54
        vmulpd    176(%rsp), %xmm1, %xmm1                       #161.54[spill]
        vmulpd    %xmm1, %xmm15, %xmm1                          #161.61
        vmulpd    %xmm12, %xmm1, %xmm15                         #161.67
        vmulpd    %xmm15, %xmm0, %xmm12                         #162.31
        vmulpd    %xmm15, %xmm2, %xmm1                          #163.31
        vmulpd    %xmm15, %xmm3, %xmm0                          #164.31
        vandpd    %xmm12, %xmm5, %xmm2                          #162.31
        vandpd    %xmm1, %xmm5, %xmm3                           #163.31
        vandpd    %xmm0, %xmm5, %xmm5                           #164.31
        vaddpd    %xmm2, %xmm14, %xmm14                         #162.17
        vaddpd    %xmm3, %xmm13, %xmm13                         #163.17
        vaddpd    %xmm5, %xmm11, %xmm11                         #164.17
        je        ..B2.38       # Prob 50%                      #167.24
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r12 r13 r14 r15 xmm0 xmm1 xmm4 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B2.14:                        # Preds ..B2.13
                                # Execution count [3.12e+00]
        vmovmskpd %xmm4, %esi                                   #168.21
        movl      %esi, %r11d                                   #168.21
        andl      $2, %r11d                                     #168.21
        andl      $1, %esi                                      #168.21
        je        ..B2.17       # Prob 40%                      #168.21
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r12 r13 r14 r15 esi r11d xmm0 xmm1 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B2.15:                        # Preds ..B2.14
                                # Execution count [3.12e+00]
        vmovsd    (%r14,%r9,8), %xmm2                           #168.21
        testl     %r11d, %r11d                                  #168.21
        jne       ..B2.18       # Prob 60%                      #168.21
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r12 r13 r14 r15 esi r11d xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B2.16:                        # Preds ..B2.15
                                # Execution count [1.25e+00]
        vxorpd    %xmm3, %xmm3, %xmm3                           #168.21
        vunpcklpd %xmm3, %xmm2, %xmm4                           #168.21
        vsubpd    %xmm12, %xmm4, %xmm2                          #168.21
        jmp       ..B2.31       # Prob 100%                     #168.21
                                # LOE rax rdx rbx rdi r9 r12 r13 r14 r15 xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.17:                        # Preds ..B2.14
                                # Execution count [3.12e+00]
        testl     %r11d, %r11d                                  #168.21
        vxorpd    %xmm2, %xmm2, %xmm2                           #168.21
        je        ..B2.30       # Prob 40%                      #168.21
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r12 r13 r14 r15 esi r11d xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B2.18:                        # Preds ..B2.15 ..B2.17
                                # Execution count [3.12e+00]
        vmovhpd   (%r14,%r8,8), %xmm2, %xmm3                    #168.21
        testl     %esi, %esi                                    #168.21
        vsubpd    %xmm12, %xmm3, %xmm2                          #168.21
        je        ..B2.20       # Prob 40%                      #168.21
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r12 r13 r14 r15 esi r11d xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.19:                        # Preds ..B2.18
                                # Execution count [1.88e+00]
        vpshufd   $14, %xmm2, %xmm3                             #168.21
        vmovsd    %xmm2, (%r14,%r9,8)                           #168.21
        vmovsd    %xmm3, (%r14,%r8,8)                           #168.21
        vmovsd    (%r14,%rdi,8), %xmm2                          #169.21
        jmp       ..B2.21       # Prob 100%                     #169.21
                                # LOE rax rdx rcx rbx rdi r10 r12 r13 r14 r15 esi r11d xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.20:                        # Preds ..B2.18
                                # Execution count [1.25e+00]
        vpshufd   $14, %xmm2, %xmm2                             #168.21
        vmovsd    %xmm2, (%r14,%r8,8)                           #168.21
        vxorpd    %xmm2, %xmm2, %xmm2                           #169.21
                                # LOE rax rdx rcx rbx rdi r10 r12 r13 r14 r15 esi r11d xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.21:                        # Preds ..B2.19 ..B2.20
                                # Execution count [1.88e+00]
        testl     %r11d, %r11d                                  #169.21
        je        ..B2.74       # Prob 40%                      #169.21
                                # LOE rax rdx rcx rbx rdi r10 r12 r13 r14 r15 esi r11d xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.22:                        # Preds ..B2.21
                                # Execution count [3.12e+00]
        vmovhpd   (%r14,%rcx,8), %xmm2, %xmm3                   #169.21
        testl     %esi, %esi                                    #169.21
        vsubpd    %xmm1, %xmm3, %xmm1                           #169.21
        je        ..B2.24       # Prob 40%                      #169.21
                                # LOE rax rdx rcx rbx rdi r10 r12 r13 r14 r15 esi r11d xmm0 xmm1 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.23:                        # Preds ..B2.22
                                # Execution count [1.88e+00]
        vpshufd   $14, %xmm1, %xmm2                             #169.21
        vmovsd    %xmm1, (%r14,%rdi,8)                          #169.21
        vmovsd    %xmm2, (%r14,%rcx,8)                          #169.21
        vmovsd    (%r14,%rax,8), %xmm1                          #170.21
        jmp       ..B2.25       # Prob 100%                     #170.21
                                # LOE rax rdx rbx r10 r12 r13 r14 r15 esi r11d xmm0 xmm1 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.24:                        # Preds ..B2.22
                                # Execution count [1.25e+00]
        vpshufd   $14, %xmm1, %xmm1                             #169.21
        vmovsd    %xmm1, (%r14,%rcx,8)                          #169.21
        vxorpd    %xmm1, %xmm1, %xmm1                           #170.21
                                # LOE rax rdx rbx r10 r12 r13 r14 r15 esi r11d xmm0 xmm1 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.25:                        # Preds ..B2.23 ..B2.24
                                # Execution count [1.88e+00]
        testl     %r11d, %r11d                                  #170.21
        je        ..B2.73       # Prob 40%                      #170.21
                                # LOE rax rdx rbx r10 r12 r13 r14 r15 esi xmm0 xmm1 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.26:                        # Preds ..B2.25
                                # Execution count [3.12e+00]
        vmovhpd   (%r14,%r10,8), %xmm1, %xmm2                   #170.21
        testl     %esi, %esi                                    #170.21
        vsubpd    %xmm0, %xmm2, %xmm0                           #170.21
        je        ..B2.28       # Prob 40%                      #170.21
                                # LOE rax rdx rbx r10 r12 r13 r14 r15 xmm0 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.27:                        # Preds ..B2.26
                                # Execution count [1.88e+00]
        vmovsd    %xmm0, (%r14,%rax,8)                          #170.21
        vpshufd   $14, %xmm0, %xmm0                             #170.21
        jmp       ..B2.29       # Prob 100%                     #170.21
                                # LOE rdx rbx r10 r12 r13 r14 r15 xmm0 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.28:                        # Preds ..B2.26
                                # Execution count [1.25e+00]
        vpshufd   $14, %xmm0, %xmm0                             #170.21
                                # LOE rdx rbx r10 r12 r13 r14 r15 xmm0 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.29:                        # Preds ..B2.27 ..B2.28
                                # Execution count [3.12e+00]
        vmovsd    %xmm0, (%r14,%r10,8)                          #170.21
        jmp       ..B2.38       # Prob 100%                     #170.21
                                # LOE rdx rbx r12 r13 r14 r15 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.30:                        # Preds ..B2.17
                                # Execution count [1.88e+00]
        testl     %esi, %esi                                    #168.21
        vxorpd    %xmm2, %xmm2, %xmm2                           #168.21
        vsubpd    %xmm12, %xmm2, %xmm2                          #168.21
        je        ..B2.32       # Prob 40%                      #168.21
                                # LOE rax rdx rbx rdi r9 r12 r13 r14 r15 xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.31:                        # Preds ..B2.16 ..B2.30
                                # Execution count [1.25e+00]
        vmovsd    %xmm2, (%r14,%r9,8)                           #168.21
        vmovsd    (%r14,%rdi,8), %xmm3                          #169.21
        vxorpd    %xmm4, %xmm4, %xmm4                           #169.21
        vunpcklpd %xmm4, %xmm3, %xmm5                           #169.21
        vsubpd    %xmm1, %xmm5, %xmm1                           #169.21
        jmp       ..B2.34       # Prob 100%                     #169.21
                                # LOE rax rdx rbx rdi r12 r13 r14 r15 xmm0 xmm1 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.32:                        # Preds ..B2.30
                                # Execution count [0.00e+00]
        vxorpd    %xmm2, %xmm2, %xmm2                           #169.21
        jmp       ..B2.33       # Prob 100%                     #169.21
                                # LOE rax rdx rbx rdi r12 r13 r14 r15 xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.74:                        # Preds ..B2.21
                                # Execution count [7.50e-01]
        testl     %esi, %esi                                    #168.21
                                # LOE rax rdx rbx rdi r12 r13 r14 r15 xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.33:                        # Preds ..B2.32 ..B2.74
                                # Execution count [2.67e+00]
        vxorpd    %xmm3, %xmm3, %xmm3                           #169.21
        vunpcklpd %xmm3, %xmm2, %xmm4                           #169.21
        vsubpd    %xmm1, %xmm4, %xmm1                           #169.21
        je        ..B2.35       # Prob 40%                      #169.21
                                # LOE rax rdx rbx rdi r12 r13 r14 r15 xmm0 xmm1 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.34:                        # Preds ..B2.31 ..B2.33
                                # Execution count [1.25e+00]
        vmovsd    %xmm1, (%r14,%rdi,8)                          #169.21
        vmovsd    (%r14,%rax,8), %xmm2                          #170.21
        vxorpd    %xmm3, %xmm3, %xmm3                           #170.21
        vunpcklpd %xmm3, %xmm2, %xmm4                           #170.21
        vsubpd    %xmm0, %xmm4, %xmm0                           #170.21
        jmp       ..B2.37       # Prob 100%                     #170.21
                                # LOE rax rdx rbx r12 r13 r14 r15 xmm0 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.35:                        # Preds ..B2.33
                                # Execution count [0.00e+00]
        vxorpd    %xmm1, %xmm1, %xmm1                           #170.21
        jmp       ..B2.36       # Prob 100%                     #170.21
                                # LOE rax rdx rbx r12 r13 r14 r15 xmm0 xmm1 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.73:                        # Preds ..B2.25
                                # Execution count [7.50e-01]
        testl     %esi, %esi                                    #168.21
                                # LOE rax rdx rbx r12 r13 r14 r15 xmm0 xmm1 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.36:                        # Preds ..B2.35 ..B2.73
                                # Execution count [2.67e+00]
        vxorpd    %xmm2, %xmm2, %xmm2                           #170.21
        vunpcklpd %xmm2, %xmm1, %xmm3                           #170.21
        vsubpd    %xmm0, %xmm3, %xmm0                           #170.21
        je        ..B2.38       # Prob 40%                      #170.21
                                # LOE rax rdx rbx r12 r13 r14 r15 xmm0 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.37:                        # Preds ..B2.34 ..B2.36
                                # Execution count [1.25e+00]
        vmovsd    %xmm0, (%r14,%rax,8)                          #170.21
                                # LOE rdx rbx r12 r13 r14 r15 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.38:                        # Preds ..B2.36 ..B2.29 ..B2.37 ..B2.13 ..B2.12
                                #      
                                # Execution count [1.25e+01]
        addq      $2, %r15                                      #143.9
        cmpq      %r12, %r15                                    #143.9
        jb        ..B2.12       # Prob 82%                      #143.9
                                # LOE rdx rbx r12 r13 r14 r15 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.39:                        # Preds ..B2.38
                                # Execution count [2.25e+00]
        vunpckhpd %xmm11, %xmm11, %xmm12                        #132.22
        vunpckhpd %xmm14, %xmm14, %xmm8                         #130.22
        vaddsd    %xmm12, %xmm11, %xmm12                        #132.22
        vaddsd    %xmm8, %xmm14, %xmm10                         #130.22
        vunpckhpd %xmm13, %xmm13, %xmm11                        #131.22
        vmovsd    128(%rsp), %xmm1                              #[spill]
        vaddsd    %xmm11, %xmm13, %xmm11                        #131.22
        vmovsd    136(%rsp), %xmm3                              #[spill]
        vmovsd    144(%rsp), %xmm4                              #[spill]
        vmovsd    152(%rsp), %xmm5                              #[spill]
        vmovsd    48(%rsp), %xmm6                               #[spill]
        vmovsd    56(%rsp), %xmm2                               #[spill]
        movq      24(%rsp), %r9                                 #[spill]
        movl      32(%rsp), %edi                                #[spill]
        movq      88(%rsp), %rsi                                #[spill]
        movq      96(%rsp), %r10                                #[spill]
        movq      104(%rsp), %r11                               #[spill]
        movq      112(%rsp), %rcx                               #[spill]
        movq      120(%rsp), %r8                                #[spill]
        movq      40(%rsp), %rax                                #[spill]
        vmovsd    .L_2il0floatpacket.1(%rip), %xmm0             #
        vmovsd    .L_2il0floatpacket.4(%rip), %xmm7             #
                                # LOE rax rdx rcx rbx rsi r8 r9 r10 r11 r12 r14 edi xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.40:                        # Preds ..B2.39 ..B2.58
                                # Execution count [2.50e+00]
        movslq    %edi, %r13                                    #143.9
        cmpq      %r13, %r12                                    #143.9
        jae       ..B2.49       # Prob 10%                      #143.9
                                # LOE rax rdx rcx rbx rsi r8 r9 r10 r11 r12 r13 r14 edi xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.41:                        # Preds ..B2.40
                                # Execution count [2.25e+00]
        imulq     64(%rsp), %r9                                 #125.43[spill]
        addq      72(%rsp), %r9                                 #107.5[spill]
        movl      80(%rsp), %eax                                #107.5[spill]
        movq      %r8, 120(%rsp)                                #107.5[spill]
                                # LOE rdx rcx rbx rsi r9 r10 r11 r12 r13 r14 eax edi xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.42:                        # Preds ..B2.45 ..B2.41
                                # Execution count [1.25e+01]
        movl      (%r9,%r12,4), %r8d                            #144.21
        lea       (%r8,%r8,2), %r15d                            #145.36
        movslq    %r15d, %r15                                   #145.36
        vsubsd    8(%rdx,%r15,8), %xmm3, %xmm9                  #146.36
        vsubsd    (%rdx,%r15,8), %xmm4, %xmm14                  #145.36
        vsubsd    16(%rdx,%r15,8), %xmm1, %xmm8                 #147.36
        vmulsd    %xmm9, %xmm9, %xmm13                          #148.49
        vfmadd231sd %xmm14, %xmm14, %xmm13                      #148.63
        vfmadd231sd %xmm8, %xmm8, %xmm13                        #148.63
        vcomisd   %xmm13, %xmm2                                 #158.22
        jbe       ..B2.45       # Prob 50%                      #158.22
                                # LOE rdx rcx rbx rsi r9 r10 r11 r12 r13 r14 r15 eax edi r8d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B2.43:                        # Preds ..B2.42
                                # Execution count [6.25e+00]
        vdivsd    %xmm13, %xmm7, %xmm15                         #159.38
        vmulsd    %xmm15, %xmm6, %xmm13                         #160.38
        vmulsd    %xmm15, %xmm13, %xmm13                        #160.44
        vmulsd    %xmm15, %xmm13, %xmm13                        #160.50
        vmulsd    %xmm5, %xmm15, %xmm15                         #161.54
        vmulsd    %xmm13, %xmm15, %xmm15                        #161.61
        vsubsd    %xmm0, %xmm13, %xmm13                         #161.54
        vmulsd    %xmm13, %xmm15, %xmm15                        #161.67
        vmulsd    %xmm15, %xmm14, %xmm13                        #162.31
        vmulsd    %xmm15, %xmm9, %xmm9                          #163.31
        vmulsd    %xmm15, %xmm8, %xmm8                          #164.31
        vaddsd    %xmm13, %xmm10, %xmm10                        #162.17
        vaddsd    %xmm9, %xmm11, %xmm11                         #163.17
        vaddsd    %xmm8, %xmm12, %xmm12                         #164.17
        cmpl      %eax, %r8d                                    #167.24
        jge       ..B2.45       # Prob 50%                      #167.24
                                # LOE rdx rcx rbx rsi r9 r10 r11 r12 r13 r14 r15 eax edi xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B2.44:                        # Preds ..B2.43
                                # Execution count [3.12e+00]
        vmovsd    8(%r14,%r15,8), %xmm15                        #169.21
        vmovsd    (%r14,%r15,8), %xmm14                         #168.21
        vsubsd    %xmm9, %xmm15, %xmm9                          #169.21
        vsubsd    %xmm13, %xmm14, %xmm13                        #168.21
        vmovsd    %xmm9, 8(%r14,%r15,8)                         #169.21
        vmovsd    16(%r14,%r15,8), %xmm9                        #170.21
        vmovsd    %xmm13, (%r14,%r15,8)                         #168.21
        vsubsd    %xmm8, %xmm9, %xmm8                           #170.21
        vmovsd    %xmm8, 16(%r14,%r15,8)                        #170.21
                                # LOE rdx rcx rbx rsi r9 r10 r11 r12 r13 r14 eax edi xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.45:                        # Preds ..B2.44 ..B2.43 ..B2.42
                                # Execution count [1.25e+01]
        incq      %r12                                          #143.9
        cmpq      %r13, %r12                                    #143.9
        jb        ..B2.42       # Prob 82%                      #143.9
                                # LOE rdx rcx rbx rsi r9 r10 r11 r12 r13 r14 eax edi xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.46:                        # Preds ..B2.45
                                # Execution count [2.25e+00]
        movq      120(%rsp), %r8                                #[spill]
        movq      40(%rsp), %rax                                #[spill]
        jmp       ..B2.49       # Prob 100%                     #
                                # LOE rax rdx rcx rbx rsi r8 r10 r11 r13 r14 edi xmm0 xmm2 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.48:                        # Preds ..B2.9 ..B2.8
                                # Execution count [2.50e+00]
        movslq    %edi, %r13                                    #179.9
                                # LOE rax rdx rcx rbx rsi r8 r10 r11 r13 r14 edi xmm0 xmm2 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.49:                        # Preds ..B2.46 ..B2.40 ..B2.48
                                # Execution count [5.00e+00]
        addq      %r13, %r11                                    #179.9
        lea       3(%rdi), %r9d                                 #180.9
        sarl      $1, %r9d                                      #180.9
        vaddsd    (%rsi,%r14), %xmm10, %xmm1                    #175.9
        vaddsd    8(%rsi,%r14), %xmm11, %xmm3                   #176.9
        vaddsd    16(%rsi,%r14), %xmm12, %xmm4                  #177.9
        shrl      $30, %r9d                                     #180.9
        vmovsd    %xmm1, (%rsi,%r14)                            #175.9
        vmovsd    %xmm3, 8(%rsi,%r14)                           #176.9
        vmovsd    %xmm4, 16(%rsi,%r14)                          #177.9
        addq      $24, %rsi                                     #124.5
        lea       3(%r9,%rdi), %edi                             #180.9
        movslq    %r8d, %r9                                     #124.32
        sarl      $2, %edi                                      #180.9
        incq      %r8                                           #124.5
        movslq    %edi, %rdi                                    #180.9
        incq      %r9                                           #124.32
        addq      %rdi, %r10                                    #180.9
        cmpq      %rax, %r8                                     #124.5
        jb        ..B2.8        # Prob 82%                      #124.5
                                # LOE rax rdx rcx rbx rsi r8 r9 r10 r11 r14 xmm0 xmm2 xmm5 xmm6 xmm7
..B2.50:                        # Preds ..B2.49
                                # Execution count [9.00e-01]
        movq      8(%rsp), %r15                                 #[spill]
        movq      (%rsp), %r12                                  #[spill]
        movq      %r11, (%r15)                                  #179.9
        movq      %r10, 8(%r15)                                 #180.9
        jmp       ..B2.54       # Prob 100%                     #180.9
                                # LOE rbx r12
..B2.51:                        # Preds ..B2.1
                                # Execution count [5.00e-01]
        xorl      %ebx, %ebx                                    #120.22
        xorl      %eax, %eax                                    #121.16
..___tag_value_computeForceLJHalfNeigh.161:
#       getTimeStamp()
        call      getTimeStamp                                  #121.16
..___tag_value_computeForceLJHalfNeigh.162:
                                # LOE rbx r12 xmm0
..B2.71:                        # Preds ..B2.51
                                # Execution count [5.00e-01]
        vmovsd    %xmm0, 16(%rsp)                               #121.16[spill]
                                # LOE rbx r12
..B2.52:                        # Preds ..B2.71
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.1, %edi                         #122.5
..___tag_value_computeForceLJHalfNeigh.164:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #122.5
..___tag_value_computeForceLJHalfNeigh.165:
                                # LOE rbx r12
..B2.54:                        # Preds ..B2.52 ..B2.50
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.1, %edi                         #183.5
..___tag_value_computeForceLJHalfNeigh.166:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #183.5
..___tag_value_computeForceLJHalfNeigh.167:
                                # LOE rbx r12
..B2.55:                        # Preds ..B2.54
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #184.16
..___tag_value_computeForceLJHalfNeigh.168:
#       getTimeStamp()
        call      getTimeStamp                                  #184.16
..___tag_value_computeForceLJHalfNeigh.169:
                                # LOE rbx r12 xmm0
..B2.56:                        # Preds ..B2.55
                                # Execution count [1.00e+00]
        vxorpd    %xmm4, %xmm4, %xmm4                           #185.5
        vcvtsi2sdq %rbx, %xmm4, %xmm4                           #185.5
        vsubsd    16(%rsp), %xmm0, %xmm1                        #185.94[spill]
        vmovsd    .L_2il0floatpacket.9(%rip), %xmm3             #185.5
        movl      $.L_2__STRING.2, %edi                         #185.5
        vdivsd    %xmm4, %xmm3, %xmm5                           #185.5
        vmulsd    %xmm1, %xmm5, %xmm6                           #185.5
        movl      %ebx, %esi                                    #185.5
        vmovsd    264(%r12), %xmm7                              #185.74
        movl      $3, %eax                                      #185.5
        vmulsd    %xmm7, %xmm6, %xmm2                           #185.5
        vmovapd   %xmm7, %xmm0                                  #185.5
        vmovsd    %xmm1, (%rsp)                                 #185.5[spill]
..___tag_value_computeForceLJHalfNeigh.171:
#       printf(const char *__restrict__, ...)
        call      printf                                        #185.5
..___tag_value_computeForceLJHalfNeigh.172:
                                # LOE
..B2.57:                        # Preds ..B2.56
                                # Execution count [1.00e+00]
        vmovsd    (%rsp), %xmm1                                 #[spill]
        vmovapd   %xmm1, %xmm0                                  #186.14
        addq      $248, %rsp                                    #186.14
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
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B2.58:                        # Preds ..B2.10
                                # Execution count [2.25e-01]: Infreq
        xorl      %r12d, %r12d                                  #143.9
        jmp       ..B2.40       # Prob 100%                     #143.9
                                # LOE rax rdx rcx rbx rsi r8 r9 r10 r11 r12 r14 edi xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.59:                        # Preds ..B2.2
                                # Execution count [1.00e+00]: Infreq
        movq      %r13, %rax                                    #106.18
        lea       (%rax,%rax,2), %rcx                           #106.18
        cmpq      $8, %rcx                                      #114.5
        jl        ..B2.67       # Prob 10%                      #114.5
                                # LOE rcx rdi r12 r14 r15 r13d
..B2.60:                        # Preds ..B2.59
                                # Execution count [1.00e+00]: Infreq
        movl      %ecx, %eax                                    #114.5
        xorl      %edx, %edx                                    #114.5
        andl      $-8, %eax                                     #114.5
        movslq    %eax, %rax                                    #114.5
        vxorpd    %ymm0, %ymm0, %ymm0                           #115.22
                                # LOE rax rdx rcx rdi r12 r14 r15 r13d ymm0
..B2.61:                        # Preds ..B2.61 ..B2.60
                                # Execution count [5.56e+00]: Infreq
        vmovupd   %ymm0, (%rdi,%rdx,8)                          #115.9
        vmovupd   %ymm0, 32(%rdi,%rdx,8)                        #115.9
        addq      $8, %rdx                                      #114.5
        cmpq      %rax, %rdx                                    #114.5
        jb        ..B2.61       # Prob 82%                      #114.5
                                # LOE rax rdx rcx rdi r12 r14 r15 r13d ymm0
..B2.63:                        # Preds ..B2.61 ..B2.67
                                # Execution count [1.11e+00]: Infreq
        cmpq      %rcx, %rax                                    #114.5
        jae       ..B2.5        # Prob 10%                      #114.5
                                # LOE rax rcx rdi r12 r14 r15 r13d
..B2.64:                        # Preds ..B2.63
                                # Execution count [1.00e+00]: Infreq
        xorl      %edx, %edx                                    #
                                # LOE rax rdx rcx rdi r12 r14 r15 r13d
..B2.65:                        # Preds ..B2.64 ..B2.65
                                # Execution count [5.56e+00]: Infreq
        movq      %rdx, (%rdi,%rax,8)                           #115.9
        incq      %rax                                          #114.5
        cmpq      %rcx, %rax                                    #114.5
        jb        ..B2.65       # Prob 82%                      #114.5
        jmp       ..B2.5        # Prob 100%                     #114.5
                                # LOE rax rdx rcx rdi r12 r14 r15 r13d
..B2.67:                        # Preds ..B2.59
                                # Execution count [1.00e-01]: Infreq
        xorl      %eax, %eax                                    #114.5
        jmp       ..B2.63       # Prob 100%                     #114.5
        .align    16,0x90
                                # LOE rax rcx rdi r12 r14 r15 r13d
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
..___tag_value_computeForceLJFullNeigh_simd.190:
..L191:
                                                        #189.101
        pushq     %rbp                                          #189.101
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #189.101
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-32, %rsp                                    #189.101
        movl      4(%rsi), %edx                                 #190.18
        testl     %edx, %edx                                    #196.24
        jle       ..B3.4        # Prob 50%                      #196.24
                                # LOE rbx rsi r12 r13 r14 r15 edx
..B3.2:                         # Preds ..B3.1
                                # Execution count [5.00e-03]
        movq      64(%rsi), %rdi                                #197.9
        lea       (%rdx,%rdx,2), %eax                           #190.18
        cmpl      $12, %eax                                     #196.5
        jle       ..B3.8        # Prob 0%                       #196.5
                                # LOE rbx rdi r12 r13 r14 r15 edx
..B3.3:                         # Preds ..B3.2
                                # Execution count [1.00e+00]
        movslq    %edx, %rdx                                    #196.5
        xorl      %esi, %esi                                    #196.5
        lea       (%rdx,%rdx,2), %rdx                           #196.5
        shlq      $3, %rdx                                      #196.5
        call      __intel_avx_rep_memset                        #196.5
                                # LOE rbx r12 r13 r14 r15
..B3.4:                         # Preds ..B3.14 ..B3.1 ..B3.12 ..B3.3
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #203.16
        vzeroupper                                              #203.16
..___tag_value_computeForceLJFullNeigh_simd.195:
#       getTimeStamp()
        call      getTimeStamp                                  #203.16
..___tag_value_computeForceLJFullNeigh_simd.196:
                                # LOE rbx r12 r13 r14 r15
..B3.5:                         # Preds ..B3.4
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.0, %edi                         #204.5
..___tag_value_computeForceLJFullNeigh_simd.197:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #204.5
..___tag_value_computeForceLJFullNeigh_simd.198:
                                # LOE
..B3.6:                         # Preds ..B3.5
                                # Execution count [1.00e+00]
        movl      $il0_peep_printf_format_0, %edi               #207.5
        movq      stderr(%rip), %rsi                            #207.5
        call      fputs                                         #207.5
                                # LOE
..B3.7:                         # Preds ..B3.6
                                # Execution count [1.00e+00]
        movl      $-1, %edi                                     #208.5
#       exit(int)
        call      exit                                          #208.5
                                # LOE
..B3.8:                         # Preds ..B3.2
                                # Execution count [1.00e+00]: Infreq
        movslq    %edx, %rdx                                    #196.5
        lea       (%rdx,%rdx,2), %rsi                           #190.18
        cmpq      $8, %rsi                                      #196.5
        jl        ..B3.16       # Prob 10%                      #196.5
                                # LOE rbx rsi rdi r12 r13 r14 r15
..B3.9:                         # Preds ..B3.8
                                # Execution count [1.00e+00]: Infreq
        movl      %esi, %edx                                    #196.5
        xorl      %ecx, %ecx                                    #196.5
        andl      $-8, %edx                                     #196.5
        xorl      %eax, %eax                                    #196.5
        movslq    %edx, %rdx                                    #196.5
        vxorpd    %ymm0, %ymm0, %ymm0                           #197.22
                                # LOE rax rdx rcx rbx rsi rdi r12 r13 r14 r15 ymm0
..B3.10:                        # Preds ..B3.10 ..B3.9
                                # Execution count [5.56e+00]: Infreq
        vmovupd   %ymm0, (%rdi,%rcx,8)                          #197.9
        vmovupd   %ymm0, 32(%rdi,%rcx,8)                        #197.9
        addq      $8, %rcx                                      #196.5
        cmpq      %rdx, %rcx                                    #196.5
        jb        ..B3.10       # Prob 82%                      #196.5
                                # LOE rax rdx rcx rbx rsi rdi r12 r13 r14 r15 ymm0
..B3.12:                        # Preds ..B3.10 ..B3.16
                                # Execution count [1.11e+00]: Infreq
        cmpq      %rsi, %rdx                                    #196.5
        jae       ..B3.4        # Prob 10%                      #196.5
                                # LOE rax rdx rbx rsi rdi r12 r13 r14 r15
..B3.14:                        # Preds ..B3.12 ..B3.14
                                # Execution count [5.56e+00]: Infreq
        movq      %rax, (%rdi,%rdx,8)                           #197.9
        incq      %rdx                                          #196.5
        cmpq      %rsi, %rdx                                    #196.5
        jb        ..B3.14       # Prob 82%                      #196.5
        jmp       ..B3.4        # Prob 100%                     #196.5
                                # LOE rax rdx rbx rsi rdi r12 r13 r14 r15
..B3.16:                        # Preds ..B3.8
                                # Execution count [1.00e-01]: Infreq
        xorl      %edx, %edx                                    #196.5
        xorl      %eax, %eax                                    #196.5
        jmp       ..B3.12       # Prob 100%                     #196.5
        .align    16,0x90
                                # LOE rax rdx rbx rsi rdi r12 r13 r14 r15
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
	.align 32
	.align 32
.L_2il0floatpacket.2:
	.long	0x00000000,0x3ff00000,0x00000000,0x3ff00000,0x00000000,0x3ff00000,0x00000000,0x3ff00000
	.type	.L_2il0floatpacket.2,@object
	.size	.L_2il0floatpacket.2,32
	.align 32
.L_2il0floatpacket.3:
	.long	0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000
	.type	.L_2il0floatpacket.3,@object
	.size	.L_2il0floatpacket.3,32
	.align 16
.L_2il0floatpacket.5:
	.long	0x00000001,0x00000001,0x00000001,0x00000001
	.type	.L_2il0floatpacket.5,@object
	.size	.L_2il0floatpacket.5,16
	.align 16
.L_2il0floatpacket.6:
	.long	0x00000002,0x00000002,0x00000002,0x00000002
	.type	.L_2il0floatpacket.6,@object
	.size	.L_2il0floatpacket.6,16
	.align 16
.L_2il0floatpacket.7:
	.long	0x00000000,0x3ff00000,0x00000000,0x3ff00000
	.type	.L_2il0floatpacket.7,@object
	.size	.L_2il0floatpacket.7,16
	.align 16
.L_2il0floatpacket.8:
	.long	0x00000000,0x3fe00000,0x00000000,0x3fe00000
	.type	.L_2il0floatpacket.8,@object
	.size	.L_2il0floatpacket.8,16
	.align 8
.L_2il0floatpacket.0:
	.long	0x00000000,0x40480000
	.type	.L_2il0floatpacket.0,@object
	.size	.L_2il0floatpacket.0,8
	.align 8
.L_2il0floatpacket.1:
	.long	0x00000000,0x3fe00000
	.type	.L_2il0floatpacket.1,@object
	.size	.L_2il0floatpacket.1,8
	.align 8
.L_2il0floatpacket.4:
	.long	0x00000000,0x3ff00000
	.type	.L_2il0floatpacket.4,@object
	.size	.L_2il0floatpacket.4,8
	.align 8
.L_2il0floatpacket.9:
	.long	0x00000000,0x41cdcd65
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
	.data
	.section .note.GNU-stack, ""
# End
