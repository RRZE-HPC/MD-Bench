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
                                                          #21.104
        pushq     %rbp                                          #21.104
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #21.104
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-32, %rsp                                    #21.104
        pushq     %r13                                          #21.104
        pushq     %r14                                          #21.104
        pushq     %r15                                          #21.104
        pushq     %rbx                                          #21.104
        subq      $224, %rsp                                    #21.104
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
        movq      %rsi, %r15                                    #21.104
        vmovsd    144(%rdi), %xmm0                              #25.27
        movq      %rcx, %r13                                    #21.104
        vmulsd    %xmm0, %xmm0, %xmm1                           #25.45
        movq      %rdx, %r14                                    #21.104
        vmovsd    56(%rdi), %xmm2                               #26.23
        vmovsd    40(%rdi), %xmm3                               #27.24
        movl      4(%r15), %eax                                 #22.18
        vmovsd    %xmm1, 128(%rsp)                              #25.45[spill]
        vmovsd    %xmm2, 136(%rsp)                              #26.23[spill]
        vmovsd    %xmm3, 24(%rsp)                               #27.24[spill]
        testl     %eax, %eax                                    #33.24
        jle       ..B1.34       # Prob 50%                      #33.24
                                # LOE r12 r13 r14 r15 eax
..B1.2:                         # Preds ..B1.1
                                # Execution count [5.00e-03]
        movslq    %eax, %rbx                                    #22.18
        lea       (%rax,%rax,2), %eax                           #22.18
        movq      64(%r15), %rdi                                #34.9
        cmpl      $12, %eax                                     #33.5
        jle       ..B1.43       # Prob 0%                       #33.5
                                # LOE rbx rdi r12 r13 r14 r15
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
        xorl      %esi, %esi                                    #33.5
        lea       (%rbx,%rbx,2), %rdx                           #33.5
        shlq      $3, %rdx                                      #33.5
        call      __intel_avx_rep_memset                        #33.5
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
        movl      $.L_2__STRING.0, %edi                         #42.5
..___tag_value_computeForceLJFullNeigh_plain_c.16:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #42.5
..___tag_value_computeForceLJFullNeigh_plain_c.17:
                                # LOE rbx r12 r13 r14 r15
..B1.7:                         # Preds ..B1.6
                                # Execution count [9.00e-01]
        vmovsd    24(%rsp), %xmm0                               #77.42[spill]
        xorl      %eax, %eax                                    #45.15
        vmulsd    .L_2il0floatpacket.0(%rip), %xmm0, %xmm4      #77.42
        xorl      %ecx, %ecx                                    #45.5
        vbroadcastsd 128(%rsp), %ymm6                           #25.25[spill]
        vbroadcastsd %xmm4, %ymm7                               #77.42
        vbroadcastsd 136(%rsp), %ymm2                           #26.21[spill]
        vmovsd    .L_2il0floatpacket.4(%rip), %xmm5             #75.32
        vmovsd    .L_2il0floatpacket.1(%rip), %xmm0             #77.55
        vmovupd   %ymm6, 32(%rsp)                               #45.5[spill]
        vmovupd   %ymm7, 64(%rsp)                               #45.5[spill]
        vmovsd    136(%rsp), %xmm6                              #45.5[spill]
        vmovsd    128(%rsp), %xmm7                              #45.5[spill]
        vmovupd   %ymm2, 96(%rsp)                               #45.5[spill]
        movslq    8(%r14), %rsi                                 #46.43
        xorl      %edi, %edi                                    #45.5
        movq      16(%r14), %rdx                                #46.19
        shlq      $2, %rsi                                      #23.5
        movq      24(%r14), %r14                                #47.25
        movq      16(%r15), %r11                                #48.25
        movq      64(%r15), %r8                                 #89.9
        movq      (%r13), %r9                                   #93.9
        movq      8(%r13), %r10                                 #94.9
        movq      %rsi, 144(%rsp)                               #45.5[spill]
        movq      %rdx, 152(%rsp)                               #45.5[spill]
        movq      %rbx, 208(%rsp)                               #45.5[spill]
        movq      %r13, (%rsp)                                  #45.5[spill]
        movq      %r12, 8(%rsp)                                 #45.5[spill]
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0x08, 0xff, 0xff, 0xff, 0x22
                                # LOE rax rcx rdi r8 r9 r10 r11 r14 xmm0 xmm4 xmm5 xmm6 xmm7
..B1.8:                         # Preds ..B1.32 ..B1.7
                                # Execution count [5.00e+00]
        movl      (%r14,%rcx,4), %r13d                          #47.25
        testl     %r13d, %r13d                                  #59.28
        vxorpd    %xmm8, %xmm8, %xmm8                           #51.22
        vmovapd   %xmm8, %xmm9                                  #52.22
        vmovsd    (%rdi,%r11), %xmm3                            #48.25
        vmovapd   %xmm9, %xmm10                                 #53.22
        vmovsd    8(%rdi,%r11), %xmm2                           #49.25
        vmovsd    16(%rdi,%r11), %xmm1                          #50.25
        movslq    %r13d, %r12                                   #59.9
        jle       ..B1.32       # Prob 50%                      #59.28
                                # LOE rax rcx rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.9:                         # Preds ..B1.8
                                # Execution count [4.50e+00]
        cmpq      $4, %r12                                      #59.9
        jl        ..B1.39       # Prob 10%                      #59.9
                                # LOE rax rcx rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.10:                        # Preds ..B1.9
                                # Execution count [4.50e+00]
        movq      144(%rsp), %rbx                               #46.43[spill]
        imulq     %rax, %rbx                                    #46.43
        addq      152(%rsp), %rbx                               #23.5[spill]
        cmpq      $600, %r12                                    #59.9
        jl        ..B1.41       # Prob 10%                      #59.9
                                # LOE rax rcx rbx rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.11:                        # Preds ..B1.10
                                # Execution count [4.50e+00]
        movq      %rbx, %r15                                    #59.9
        andq      $31, %r15                                     #59.9
        testl     %r15d, %r15d                                  #59.9
        je        ..B1.14       # Prob 50%                      #59.9
                                # LOE rax rcx rbx rdi r8 r9 r10 r11 r12 r14 r13d r15d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.12:                        # Preds ..B1.11
                                # Execution count [4.50e+00]
        testl     $3, %r15d                                     #59.9
        jne       ..B1.39       # Prob 10%                      #59.9
                                # LOE rax rcx rbx rdi r8 r9 r10 r11 r12 r14 r13d r15d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.13:                        # Preds ..B1.12
                                # Execution count [2.25e+00]
        negl      %r15d                                         #59.9
        addl      $32, %r15d                                    #59.9
        shrl      $2, %r15d                                     #59.9
                                # LOE rax rcx rbx rdi r8 r9 r10 r11 r12 r14 r13d r15d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.14:                        # Preds ..B1.13 ..B1.11
                                # Execution count [4.50e+00]
        movl      %r15d, %edx                                   #59.9
        lea       4(%rdx), %rsi                                 #59.9
        cmpq      %rsi, %r12                                    #59.9
        jl        ..B1.39       # Prob 10%                      #59.9
                                # LOE rax rdx rcx rbx rdi r8 r9 r10 r11 r12 r14 r13d r15d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.15:                        # Preds ..B1.14
                                # Execution count [5.00e+00]
        movl      %r13d, %esi                                   #59.9
        subl      %r15d, %esi                                   #59.9
        andl      $3, %esi                                      #59.9
        negl      %esi                                          #59.9
        addl      %r13d, %esi                                   #59.9
        movslq    %esi, %rsi                                    #59.9
        testl     %r15d, %r15d                                  #59.9
        movl      $0, %r15d                                     #59.9
        jbe       ..B1.21       # Prob 10%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r14 r15 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.16:                        # Preds ..B1.15
                                # Execution count [4.50e+00]
        movq      %rcx, 24(%rsp)                                #[spill]
                                # LOE rax rdx rbx rsi rdi r8 r9 r10 r11 r12 r14 r15 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.17:                        # Preds ..B1.19 ..B1.16
                                # Execution count [2.50e+01]
        movl      (%rbx,%r15,4), %ecx                           #60.21
        lea       (%rcx,%rcx,2), %ecx                           #61.36
        movslq    %ecx, %rcx                                    #61.36
        vsubsd    8(%r11,%rcx,8), %xmm2, %xmm13                 #62.36
        vsubsd    (%r11,%rcx,8), %xmm3, %xmm12                  #61.36
        vsubsd    16(%r11,%rcx,8), %xmm1, %xmm11                #63.36
        vmulsd    %xmm13, %xmm13, %xmm14                        #64.49
        vfmadd231sd %xmm12, %xmm12, %xmm14                      #64.63
        vfmadd231sd %xmm11, %xmm11, %xmm14                      #64.63
        vcomisd   %xmm14, %xmm7                                 #74.22
        jbe       ..B1.19       # Prob 50%                      #74.22
                                # LOE rax rdx rbx rsi rdi r8 r9 r10 r11 r12 r14 r15 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B1.18:                        # Preds ..B1.17
                                # Execution count [1.25e+01]
        vdivsd    %xmm14, %xmm5, %xmm15                         #75.39
        vmulsd    %xmm15, %xmm6, %xmm14                         #76.38
        vmulsd    %xmm15, %xmm14, %xmm14                        #76.44
        vmulsd    %xmm15, %xmm14, %xmm14                        #76.50
        vmulsd    %xmm4, %xmm15, %xmm15                         #77.55
        vmulsd    %xmm14, %xmm15, %xmm15                        #77.64
        vsubsd    %xmm0, %xmm14, %xmm14                         #77.55
        vmulsd    %xmm14, %xmm15, %xmm15                        #77.70
        vfmadd231sd %xmm12, %xmm15, %xmm8                       #78.17
        vfmadd231sd %xmm15, %xmm13, %xmm9                       #79.17
        vfmadd231sd %xmm15, %xmm11, %xmm10                      #80.17
                                # LOE rax rdx rbx rsi rdi r8 r9 r10 r11 r12 r14 r15 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.19:                        # Preds ..B1.18 ..B1.17
                                # Execution count [2.50e+01]
        incq      %r15                                          #59.9
        cmpq      %rdx, %r15                                    #59.9
        jb        ..B1.17       # Prob 82%                      #59.9
                                # LOE rax rdx rbx rsi rdi r8 r9 r10 r11 r12 r14 r15 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.20:                        # Preds ..B1.19
                                # Execution count [4.50e+00]
        movq      24(%rsp), %rcx                                #[spill]
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.21:                        # Preds ..B1.20 ..B1.15 ..B1.41
                                # Execution count [4.50e+00]
        vmovsd    %xmm3, 192(%rsp)                              #74.22[spill]
        vxorpd    %xmm11, %xmm11, %xmm11                        #51.22
        vmovsd    %xmm8, %xmm11, %xmm13                         #51.22
        vmovsd    %xmm9, %xmm11, %xmm12                         #52.22
        vmovsd    %xmm10, %xmm11, %xmm11                        #53.22
        vmovsd    %xmm4, 200(%rsp)                              #74.22[spill]
        vbroadcastsd %xmm3, %ymm10                              #48.23
        vmovsd    %xmm1, 176(%rsp)                              #74.22[spill]
        vmovsd    %xmm2, 184(%rsp)                              #74.22[spill]
        vmovupd   .L_2il0floatpacket.3(%rip), %ymm3             #74.22
        vmovupd   .L_2il0floatpacket.2(%rip), %ymm4             #74.22
        vmovupd   32(%rsp), %ymm5                               #74.22[spill]
        vbroadcastsd %xmm2, %ymm9                               #49.23
        vbroadcastsd %xmm1, %ymm8                               #50.23
        movq      %r8, 160(%rsp)                                #74.22[spill]
        movq      %r14, 168(%rsp)                               #74.22[spill]
        movq      %rcx, 24(%rsp)                                #74.22[spill]
        vmovaps   %xmm13, %xmm13                                #51.22
        vmovaps   %xmm12, %xmm12                                #52.22
        vmovaps   %xmm11, %xmm11                                #53.22
                                # LOE rax rdx rbx rsi rdi r9 r10 r11 r12 r13d ymm3 ymm4 ymm5 ymm8 ymm9 ymm10 ymm11 ymm12 ymm13
movl      $111, %ebx # OSACA START MARKER
.byte     100        # OSACA START MARKER
.byte     103        # OSACA START MARKER
.byte     144        # OSACA START MARKER
# pointer_increment=32 724d27eafcb27eabca1528ddfdbdba3e
# LLVM-MCA-BEGIN
..B1.22:                        # Preds ..B1.24 ..B1.21
                                # Execution count [2.50e+01]
        vmovdqu   (%rbx,%rdx,4), %xmm0                          #60.21
        vmovq     %xmm0, %rcx                                   #60.21
        vpunpckhqdq %xmm0, %xmm0, %xmm2                         #60.21
        vmovq     %xmm2, %r15                                   #60.21
        movl      %ecx, %r8d                                    #60.21
        shrq      $32, %rcx                                     #60.21
        lea       (%rcx,%rcx,2), %r14d                          #61.36
        lea       (%r8,%r8,2), %r8d                             #61.36
        movslq    %r8d, %rcx                                    #61.36
        movslq    %r14d, %r8                                    #61.36
        movl      %r15d, %r14d                                  #60.21
        shrq      $32, %r15                                     #60.21
        vmovups   (%r11,%rcx,8), %xmm7                          #61.36
        vmovups   (%r11,%r8,8), %xmm6                           #61.36
        vmovq     16(%r11,%rcx,8), %xmm14                       #61.36
        lea       (%r14,%r14,2), %r14d                          #61.36
        movslq    %r14d, %r14                                   #61.36
        lea       (%r15,%r15,2), %r15d                          #61.36
        movslq    %r15d, %r15                                   #61.36
        vmovhpd   16(%r11,%r8,8), %xmm14, %xmm15                #61.36
        vinsertf128 $1, (%r11,%r14,8), %ymm7, %ymm1             #61.36
        vmovq     16(%r11,%r14,8), %xmm0                        #61.36
        vinsertf128 $1, (%r11,%r15,8), %ymm6, %ymm6             #61.36
        vmovhpd   16(%r11,%r15,8), %xmm0, %xmm2                 #61.36
        vunpcklpd %ymm6, %ymm1, %ymm14                          #61.36
        vunpckhpd %ymm6, %ymm1, %ymm1                           #61.36
        vsubpd    %ymm14, %ymm10, %ymm6                         #61.36
        vinsertf128 $1, %xmm2, %ymm15, %ymm7                    #61.36
        vsubpd    %ymm1, %ymm9, %ymm2                           #62.36
        vsubpd    %ymm7, %ymm8, %ymm0                           #63.36
        vmulpd    %ymm2, %ymm2, %ymm14                          #64.49
        vfmadd231pd %ymm6, %ymm6, %ymm14                        #64.49
        vfmadd231pd %ymm0, %ymm0, %ymm14                        #64.63
        vcmpltpd  %ymm5, %ymm14, %ymm1                          #74.22
        vpcmpeqd  %ymm7, %ymm7, %ymm7                           #74.22
        vptest    %ymm7, %ymm1                                  #74.22
        #je        ..B1.24       # Prob 50%                      #74.22
                                # LOE rax rdx rbx rsi rdi r9 r10 r11 r12 r13d ymm0 ymm1 ymm2 ymm3 ymm4 ymm5 ymm6 ymm8 ymm9 ymm10 ymm11 ymm12 ymm13 ymm14
..B1.23:                        # Preds ..B1.22
                                # Execution count [1.25e+01]
        vdivpd    %ymm14, %ymm4, %ymm7                          #75.39
        vmulpd    96(%rsp), %ymm7, %ymm14                       #76.38[spill]
        vmulpd    %ymm14, %ymm7, %ymm14                         #76.44
        vmulpd    %ymm14, %ymm7, %ymm15                         #76.50
        vfmsub213pd %ymm3, %ymm7, %ymm14                        #77.55
        vmulpd    64(%rsp), %ymm7, %ymm7                        #77.55[spill]
        vmulpd    %ymm7, %ymm15, %ymm15                         #77.64
        vmulpd    %ymm14, %ymm15, %ymm7                         #77.70
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
        addq      $4, %rdx                                      #59.9
        cmpq      %rsi, %rdx                                    #59.9
        jb        ..B1.22       # Prob 82%                      #59.9
# LLVM-MCA-END
movl      $222, %ebx # OSACA END MARKER
.byte     100        # OSACA END MARKER
.byte     103        # OSACA END MARKER
.byte     144        # OSACA END MARKER
                                # LOE rax rdx rbx rsi rdi r9 r10 r11 r12 r13d ymm3 ymm4 ymm5 ymm8 ymm9 ymm10 ymm11 ymm12 ymm13
..B1.25:                        # Preds ..B1.24
                                # Execution count [4.50e+00]
        vextractf128 $1, %ymm11, %xmm10                         #53.22
        vmovsd    176(%rsp), %xmm1                              #[spill]
        vmovsd    184(%rsp), %xmm2                              #[spill]
        vaddpd    %xmm10, %xmm11, %xmm9                         #53.22
        vunpckhpd %xmm9, %xmm9, %xmm8                           #53.22
        vmovsd    192(%rsp), %xmm3                              #[spill]
        vaddsd    %xmm8, %xmm9, %xmm10                          #53.22
        vmovsd    200(%rsp), %xmm4                              #[spill]
        vmovsd    136(%rsp), %xmm6                              #[spill]
        vmovsd    128(%rsp), %xmm7                              #[spill]
        movq      160(%rsp), %r8                                #[spill]
        movq      168(%rsp), %r14                               #[spill]
        movq      24(%rsp), %rcx                                #[spill]
        vmovsd    .L_2il0floatpacket.1(%rip), %xmm0             #
        vmovsd    .L_2il0floatpacket.4(%rip), %xmm5             #
        vextractf128 $1, %ymm12, %xmm14                         #52.22
        vextractf128 $1, %ymm13, %xmm8                          #51.22
        vaddpd    %xmm14, %xmm12, %xmm15                        #52.22
        vaddpd    %xmm8, %xmm13, %xmm11                         #51.22
        vunpckhpd %xmm15, %xmm15, %xmm9                         #52.22
        vunpckhpd %xmm11, %xmm11, %xmm12                        #51.22
        vaddsd    %xmm9, %xmm15, %xmm9                          #52.22
        vaddsd    %xmm12, %xmm11, %xmm8                         #51.22
                                # LOE rax rcx rsi rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.26:                        # Preds ..B1.25 ..B1.39
                                # Execution count [5.00e+00]
        cmpq      %r12, %rsi                                    #59.9
        jae       ..B1.32       # Prob 10%                      #59.9
                                # LOE rax rcx rsi rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.27:                        # Preds ..B1.26
                                # Execution count [4.50e+00]
        imulq     144(%rsp), %rax                               #46.43[spill]
        addq      152(%rsp), %rax                               #23.5[spill]
                                # LOE rax rcx rsi rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.28:                        # Preds ..B1.30 ..B1.27
                                # Execution count [2.50e+01]
        movl      (%rax,%rsi,4), %edx                           #60.21
        lea       (%rdx,%rdx,2), %ebx                           #61.36
        movslq    %ebx, %rbx                                    #61.36
        vsubsd    8(%r11,%rbx,8), %xmm2, %xmm13                 #62.36
        vsubsd    (%r11,%rbx,8), %xmm3, %xmm12                  #61.36
        vsubsd    16(%r11,%rbx,8), %xmm1, %xmm11                #63.36
        vmulsd    %xmm13, %xmm13, %xmm14                        #64.49
        vfmadd231sd %xmm12, %xmm12, %xmm14                      #64.63
        vfmadd231sd %xmm11, %xmm11, %xmm14                      #64.63
        vcomisd   %xmm14, %xmm7                                 #74.22
        jbe       ..B1.30       # Prob 50%                      #74.22
                                # LOE rax rcx rsi rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B1.29:                        # Preds ..B1.28
                                # Execution count [1.25e+01]
        vdivsd    %xmm14, %xmm5, %xmm15                         #75.39
        vmulsd    %xmm15, %xmm6, %xmm14                         #76.38
        vmulsd    %xmm15, %xmm14, %xmm14                        #76.44
        vmulsd    %xmm15, %xmm14, %xmm14                        #76.50
        vmulsd    %xmm4, %xmm15, %xmm15                         #77.55
        vmulsd    %xmm14, %xmm15, %xmm15                        #77.64
        vsubsd    %xmm0, %xmm14, %xmm14                         #77.55
        vmulsd    %xmm14, %xmm15, %xmm15                        #77.70
        vfmadd231sd %xmm12, %xmm15, %xmm8                       #78.17
        vfmadd231sd %xmm15, %xmm13, %xmm9                       #79.17
        vfmadd231sd %xmm15, %xmm11, %xmm10                      #80.17
                                # LOE rax rcx rsi rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.30:                        # Preds ..B1.29 ..B1.28
                                # Execution count [2.50e+01]
        incq      %rsi                                          #59.9
        cmpq      %r12, %rsi                                    #59.9
        jb        ..B1.28       # Prob 82%                      #59.9
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
        addq      $24, %rdi                                     #45.5
        lea       3(%rax,%r13), %edx                            #94.9
        movslq    %ecx, %rax                                    #45.32
        sarl      $2, %edx                                      #94.9
        incq      %rcx                                          #45.5
        movslq    %edx, %rdx                                    #94.9
        incq      %rax                                          #45.32
        addq      %rdx, %r10                                    #94.9
        cmpq      208(%rsp), %rcx                               #45.5[spill]
        jb        ..B1.8        # Prob 82%                      #45.5
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
        movl      $.L_2__STRING.0, %edi                         #42.5
..___tag_value_computeForceLJFullNeigh_plain_c.64:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #42.5
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
        xorl      %eax, %eax                                    #100.16
..___tag_value_computeForceLJFullNeigh_plain_c.68:
#       getTimeStamp()
        call      getTimeStamp                                  #100.16
..___tag_value_computeForceLJFullNeigh_plain_c.69:
                                # LOE r12 xmm0
..B1.38:                        # Preds ..B1.37
                                # Execution count [1.00e+00]
        vsubsd    16(%rsp), %xmm0, %xmm0                        #101.14[spill]
        addq      $224, %rsp                                    #101.14
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
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0x08, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B1.39:                        # Preds ..B1.9 ..B1.12 ..B1.14
                                # Execution count [4.50e-01]: Infreq
        xorl      %esi, %esi                                    #59.9
        jmp       ..B1.26       # Prob 100%                     #59.9
                                # LOE rax rcx rsi rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.41:                        # Preds ..B1.10
                                # Execution count [4.50e-01]: Infreq
        movl      %r13d, %esi                                   #59.9
        xorl      %edx, %edx                                    #59.9
        andl      $-4, %esi                                     #59.9
        movslq    %esi, %rsi                                    #59.9
        jmp       ..B1.21       # Prob 100%                     #59.9
	.cfi_restore 12
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r14 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.43:                        # Preds ..B1.2
                                # Execution count [1.00e+00]: Infreq
        lea       (%rbx,%rbx,2), %rcx                           #22.18
        cmpq      $8, %rcx                                      #33.5
        jl        ..B1.51       # Prob 10%                      #33.5
                                # LOE rcx rbx rdi r12 r13 r14 r15
..B1.44:                        # Preds ..B1.43
                                # Execution count [1.00e+00]: Infreq
        movl      %ecx, %eax                                    #33.5
        xorl      %edx, %edx                                    #33.5
        andl      $-8, %eax                                     #33.5
        movslq    %eax, %rax                                    #33.5
        vxorpd    %ymm0, %ymm0, %ymm0                           #34.22
                                # LOE rax rdx rcx rbx rdi r12 r13 r14 r15 ymm0
..B1.45:                        # Preds ..B1.45 ..B1.44
                                # Execution count [5.56e+00]: Infreq
        vmovupd   %ymm0, (%rdi,%rdx,8)                          #34.9
        vmovupd   %ymm0, 32(%rdi,%rdx,8)                        #34.9
        addq      $8, %rdx                                      #33.5
        cmpq      %rax, %rdx                                    #33.5
        jb        ..B1.45       # Prob 82%                      #33.5
                                # LOE rax rdx rcx rbx rdi r12 r13 r14 r15 ymm0
..B1.47:                        # Preds ..B1.45 ..B1.51
                                # Execution count [1.11e+00]: Infreq
        cmpq      %rcx, %rax                                    #33.5
        jae       ..B1.5        # Prob 10%                      #33.5
                                # LOE rax rcx rbx rdi r12 r13 r14 r15
..B1.48:                        # Preds ..B1.47
                                # Execution count [1.00e+00]: Infreq
        xorl      %edx, %edx                                    #
                                # LOE rax rdx rcx rbx rdi r12 r13 r14 r15
..B1.49:                        # Preds ..B1.48 ..B1.49
                                # Execution count [5.56e+00]: Infreq
        movq      %rdx, (%rdi,%rax,8)                           #34.9
        incq      %rax                                          #33.5
        cmpq      %rcx, %rax                                    #33.5
        jb        ..B1.49       # Prob 82%                      #33.5
        jmp       ..B1.5        # Prob 100%                     #33.5
                                # LOE rax rdx rcx rbx rdi r12 r13 r14 r15
..B1.51:                        # Preds ..B1.43
                                # Execution count [1.00e-01]: Infreq
        xorl      %eax, %eax                                    #33.5
        jmp       ..B1.47       # Prob 100%                     #33.5
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
                                                         #104.96
        pushq     %rbp                                          #104.96
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #104.96
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-32, %rsp                                    #104.96
        pushq     %r12                                          #104.96
        pushq     %r13                                          #104.96
        pushq     %r14                                          #104.96
        pushq     %r15                                          #104.96
        pushq     %rbx                                          #104.96
        subq      $216, %rsp                                    #104.96
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
        movq      %rsi, %r13                                    #104.96
        vmovsd    144(%rdi), %xmm0                              #108.27
        movq      %rcx, %r12                                    #104.96
        vmulsd    %xmm0, %xmm0, %xmm1                           #108.45
        movq      %rdx, %r14                                    #104.96
        vmovsd    56(%rdi), %xmm2                               #109.23
        vmovsd    40(%rdi), %xmm3                               #110.24
        movl      4(%r13), %r15d                                #105.18
        vmovsd    %xmm1, 32(%rsp)                               #108.45[spill]
        vmovsd    %xmm2, 24(%rsp)                               #109.23[spill]
        vmovsd    %xmm3, 16(%rsp)                               #110.24[spill]
        testl     %r15d, %r15d                                  #116.24
        jle       ..B2.51       # Prob 50%                      #116.24
                                # LOE r12 r13 r14 r15d
..B2.2:                         # Preds ..B2.1
                                # Execution count [5.00e-03]
        movq      64(%r13), %rdi                                #117.9
        lea       (%r15,%r15,2), %eax                           #105.18
        movslq    %r15d, %rbx                                   #105.18
        cmpl      $12, %eax                                     #116.5
        jle       ..B2.57       # Prob 0%                       #116.5
                                # LOE rbx rdi r12 r13 r14 r15d
..B2.3:                         # Preds ..B2.2
                                # Execution count [1.00e+00]
        xorl      %esi, %esi                                    #116.5
        lea       (%rbx,%rbx,2), %rdx                           #116.5
        shlq      $3, %rdx                                      #116.5
        call      __intel_avx_rep_memset                        #116.5
                                # LOE rbx r12 r13 r14 r15d
..B2.5:                         # Preds ..B2.63 ..B2.3 ..B2.61
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #122.16
        vzeroupper                                              #122.16
..___tag_value_computeForceLJHalfNeigh.99:
#       getTimeStamp()
        call      getTimeStamp                                  #122.16
..___tag_value_computeForceLJHalfNeigh.100:
                                # LOE rbx r12 r13 r14 r15d xmm0
..B2.68:                        # Preds ..B2.5
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 8(%rsp)                                #122.16[spill]
                                # LOE rbx r12 r13 r14 r15d
..B2.6:                         # Preds ..B2.68
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.1, %edi                         #126.5
..___tag_value_computeForceLJHalfNeigh.102:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #126.5
..___tag_value_computeForceLJHalfNeigh.103:
                                # LOE rbx r12 r13 r14 r15d
..B2.7:                         # Preds ..B2.6
                                # Execution count [9.00e-01]
        vmovsd    16(%rsp), %xmm6                               #165.42[spill]
        vmovd     %r15d, %xmm0                                  #105.18
        vmulsd    .L_2il0floatpacket.0(%rip), %xmm6, %xmm6      #165.42
        xorl      %eax, %eax                                    #129.15
        vmovddup  32(%rsp), %xmm8                               #108.25[spill]
        xorl      %ecx, %ecx                                    #129.5
        vmovddup  24(%rsp), %xmm4                               #109.21[spill]
        xorl      %r9d, %r9d                                    #129.5
        vmovddup  %xmm6, %xmm3                                  #165.42
        vpbroadcastd %xmm0, %xmm1                               #105.18
        movq      16(%r14), %rdx                                #130.19
        movslq    8(%r14), %rsi                                 #130.43
        movq      24(%r14), %r11                                #131.25
        vmovdqu   .L_2il0floatpacket.6(%rip), %xmm9             #151.36
        vmovsd    .L_2il0floatpacket.4(%rip), %xmm5             #163.32
        vmovsd    .L_2il0floatpacket.1(%rip), %xmm0             #165.55
        shlq      $2, %rsi                                      #106.5
        movq      16(%r13), %r14                                #132.25
        movq      64(%r13), %rdi                                #172.21
        movq      (%r12), %r10                                  #183.9
        movq      8(%r12), %r8                                  #184.9
        vmovdqu   %xmm1, 176(%rsp)                              #129.5[spill]
        vmovupd   %xmm3, 160(%rsp)                              #129.5[spill]
        vmovupd   %xmm4, 144(%rsp)                              #129.5[spill]
        vmovupd   %xmm8, 192(%rsp)                              #129.5[spill]
        movq      %rdx, 40(%rsp)                                #129.5[spill]
        movl      %r15d, 48(%rsp)                               #129.5[spill]
        movq      %r12, (%rsp)                                  #129.5[spill]
        vmovsd    24(%rsp), %xmm7                               #129.5[spill]
        vmovsd    32(%rsp), %xmm2                               #129.5[spill]
                                # LOE rax rcx rbx rsi rdi r8 r9 r10 r11 r14 xmm0 xmm2 xmm5 xmm6 xmm7
..B2.8:                         # Preds ..B2.49 ..B2.7
                                # Execution count [5.00e+00]
        movl      (%r11,%rcx,4), %edx                           #131.25
        testl     %edx, %edx                                    #147.9
        vxorpd    %xmm10, %xmm10, %xmm10                        #135.22
        vmovapd   %xmm10, %xmm11                                #136.22
        vmovsd    (%r9,%r14), %xmm4                             #132.25
        vmovapd   %xmm11, %xmm12                                #137.22
        vmovsd    8(%r9,%r14), %xmm3                            #133.25
        vmovsd    16(%r9,%r14), %xmm1                           #134.25
        jle       ..B2.48       # Prob 50%                      #147.9
                                # LOE rax rcx rbx rsi rdi r8 r9 r10 r11 r14 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.9:                         # Preds ..B2.8
                                # Execution count [2.50e+00]
        jbe       ..B2.48       # Prob 50%                      #147.9
                                # LOE rax rcx rbx rsi rdi r8 r9 r10 r11 r14 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.10:                        # Preds ..B2.9
                                # Execution count [2.25e+00]
        cmpl      $2, %edx                                      #147.9
        jb        ..B2.56       # Prob 10%                      #147.9
                                # LOE rax rcx rbx rsi rdi r8 r9 r10 r11 r14 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.11:                        # Preds ..B2.10
                                # Execution count [2.25e+00]
        movq      %rsi, %r13                                    #130.43
        movl      %edx, %r12d                                   #147.9
        imulq     %rax, %r13                                    #130.43
        vxorpd    %xmm14, %xmm14, %xmm14                        #135.22
        andl      $-2, %r12d                                    #147.9
        vmovapd   %xmm14, %xmm13                                #136.22
        vmovsd    %xmm6, 136(%rsp)                              #147.9[spill]
        vmovapd   %xmm13, %xmm11                                #137.22
        addq      40(%rsp), %r13                                #106.5[spill]
        xorl      %r15d, %r15d                                  #147.9
        vmovddup  %xmm4, %xmm10                                 #132.23
        vmovddup  %xmm3, %xmm9                                  #133.23
        vmovddup  %xmm1, %xmm8                                  #134.23
        movslq    %r12d, %r12                                   #147.9
        vmovsd    %xmm1, 112(%rsp)                              #147.9[spill]
        vmovsd    %xmm3, 120(%rsp)                              #147.9[spill]
        vmovsd    %xmm4, 128(%rsp)                              #147.9[spill]
        movl      %edx, 16(%rsp)                                #147.9[spill]
        movq      %r9, 56(%rsp)                                 #147.9[spill]
        movq      %rsi, 64(%rsp)                                #147.9[spill]
        movq      %r8, 72(%rsp)                                 #147.9[spill]
        movq      %r10, 80(%rsp)                                #147.9[spill]
        movq      %r11, 88(%rsp)                                #147.9[spill]
        movq      %rcx, 96(%rsp)                                #147.9[spill]
        movq      %rbx, 104(%rsp)                               #147.9[spill]
        vmovdqu   .L_2il0floatpacket.6(%rip), %xmm6             #147.9
        vmovdqu   .L_2il0floatpacket.5(%rip), %xmm7             #147.9
                                # LOE rax rdi r12 r13 r14 r15 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.12:                        # Preds ..B2.38 ..B2.11
                                # Execution count [1.25e+01]
        vmovq     (%r13,%r15,4), %xmm4                          #148.21
        vpaddd    %xmm4, %xmm4, %xmm0                           #149.36
        vpaddd    %xmm0, %xmm4, %xmm1                           #149.36
        vmovd     %xmm1, %r8d                                   #149.36
        vpaddd    %xmm7, %xmm1, %xmm12                          #150.36
        vpshufd   $57, %xmm1, %xmm2                             #149.36
        vpshufd   $57, %xmm12, %xmm15                           #150.36
        vmovd     %xmm2, %esi                                   #149.36
        vmovd     %xmm12, %ebx                                  #150.36
        vmovd     %xmm15, %ecx                                  #150.36
        movslq    %r8d, %r8                                     #149.36
        movslq    %esi, %rsi                                    #149.36
        movslq    %ebx, %rbx                                    #150.36
        movslq    %ecx, %rcx                                    #150.36
        vmovsd    (%r14,%r8,8), %xmm3                           #149.36
        vmovhpd   (%r14,%rsi,8), %xmm3, %xmm5                   #149.36
        vsubpd    %xmm5, %xmm10, %xmm0                          #149.36
        vpaddd    %xmm6, %xmm1, %xmm5                           #151.36
        vmovd     %xmm5, %edx                                   #151.36
        vpshufd   $57, %xmm5, %xmm1                             #151.36
        vmovsd    (%r14,%rbx,8), %xmm2                          #150.36
        vmovd     %xmm1, %r9d                                   #151.36
        vmovhpd   (%r14,%rcx,8), %xmm2, %xmm3                   #150.36
        vpcmpeqd  %xmm1, %xmm1, %xmm1                           #162.22
        vsubpd    %xmm3, %xmm9, %xmm2                           #150.36
        movslq    %edx, %rdx                                    #151.36
        movslq    %r9d, %r9                                     #151.36
        vmovsd    (%r14,%rdx,8), %xmm12                         #151.36
        vmovhpd   (%r14,%r9,8), %xmm12, %xmm15                  #151.36
        vsubpd    %xmm15, %xmm8, %xmm3                          #151.36
        vmulpd    %xmm2, %xmm2, %xmm15                          #152.49
        vfmadd231pd %xmm0, %xmm0, %xmm15                        #152.49
        vfmadd231pd %xmm3, %xmm3, %xmm15                        #152.63
        vcmpltpd  192(%rsp), %xmm15, %xmm5                      #162.22[spill]
        vptest    %xmm1, %xmm5                                  #162.22
        je        ..B2.38       # Prob 50%                      #162.22
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r12 r13 r14 r15 xmm0 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14 xmm15
..B2.13:                        # Preds ..B2.12
                                # Execution count [6.25e+00]
        vmovupd   .L_2il0floatpacket.7(%rip), %xmm12            #163.39
        vdivpd    %xmm15, %xmm12, %xmm1                         #163.39
        vmovdqu   176(%rsp), %xmm12                             #171.24[spill]
        vpcmpeqd  %xmm15, %xmm15, %xmm15                        #171.24
        vpcmpgtd  %xmm4, %xmm12, %xmm4                          #171.24
        vmulpd    144(%rsp), %xmm1, %xmm12                      #164.38[spill]
        vmulpd    %xmm12, %xmm1, %xmm12                         #164.44
        vpmovsxdq %xmm4, %xmm4                                  #171.24
        vandpd    %xmm4, %xmm5, %xmm4                           #171.24
        vptest    %xmm15, %xmm4                                 #171.24
        vmulpd    %xmm12, %xmm1, %xmm15                         #164.50
        vfmsub213pd .L_2il0floatpacket.8(%rip), %xmm1, %xmm12   #165.55
        vmulpd    160(%rsp), %xmm1, %xmm1                       #165.55[spill]
        vmulpd    %xmm1, %xmm15, %xmm1                          #165.64
        vmulpd    %xmm12, %xmm1, %xmm15                         #165.70
        vmulpd    %xmm15, %xmm0, %xmm12                         #166.31
        vmulpd    %xmm15, %xmm2, %xmm1                          #167.31
        vmulpd    %xmm15, %xmm3, %xmm0                          #168.31
        vandpd    %xmm12, %xmm5, %xmm2                          #166.31
        vandpd    %xmm1, %xmm5, %xmm3                           #167.31
        vandpd    %xmm0, %xmm5, %xmm5                           #168.31
        vaddpd    %xmm2, %xmm14, %xmm14                         #166.17
        vaddpd    %xmm3, %xmm13, %xmm13                         #167.17
        vaddpd    %xmm5, %xmm11, %xmm11                         #168.17
        je        ..B2.38       # Prob 50%                      #171.24
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r12 r13 r14 r15 xmm0 xmm1 xmm4 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B2.14:                        # Preds ..B2.13
                                # Execution count [3.12e+00]
        vmovmskpd %xmm4, %r11d                                  #172.21
        movl      %r11d, %r10d                                  #172.21
        andl      $2, %r10d                                     #172.21
        andl      $1, %r11d                                     #172.21
        je        ..B2.17       # Prob 40%                      #172.21
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r12 r13 r14 r15 r10d r11d xmm0 xmm1 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B2.15:                        # Preds ..B2.14
                                # Execution count [3.12e+00]
        vmovsd    (%rdi,%r8,8), %xmm2                           #172.21
        testl     %r10d, %r10d                                  #172.21
        jne       ..B2.18       # Prob 60%                      #172.21
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r12 r13 r14 r15 r10d r11d xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B2.16:                        # Preds ..B2.15
                                # Execution count [1.25e+00]
        vxorpd    %xmm3, %xmm3, %xmm3                           #172.21
        vunpcklpd %xmm3, %xmm2, %xmm4                           #172.21
        vsubpd    %xmm12, %xmm4, %xmm2                          #172.21
        jmp       ..B2.31       # Prob 100%                     #172.21
                                # LOE rax rdx rbx rdi r8 r12 r13 r14 r15 xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.17:                        # Preds ..B2.14
                                # Execution count [3.12e+00]
        testl     %r10d, %r10d                                  #172.21
        vxorpd    %xmm2, %xmm2, %xmm2                           #172.21
        je        ..B2.30       # Prob 40%                      #172.21
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r12 r13 r14 r15 r10d r11d xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B2.18:                        # Preds ..B2.15 ..B2.17
                                # Execution count [3.12e+00]
        vmovhpd   (%rdi,%rsi,8), %xmm2, %xmm3                   #172.21
        testl     %r11d, %r11d                                  #172.21
        vsubpd    %xmm12, %xmm3, %xmm2                          #172.21
        je        ..B2.20       # Prob 40%                      #172.21
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r12 r13 r14 r15 r10d r11d xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.19:                        # Preds ..B2.18
                                # Execution count [1.88e+00]
        vpshufd   $14, %xmm2, %xmm3                             #172.21
        vmovsd    %xmm2, (%rdi,%r8,8)                           #172.21
        vmovsd    %xmm3, (%rdi,%rsi,8)                          #172.21
        vmovsd    (%rdi,%rbx,8), %xmm2                          #173.21
        jmp       ..B2.21       # Prob 100%                     #173.21
                                # LOE rax rdx rcx rbx rdi r9 r12 r13 r14 r15 r10d r11d xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.20:                        # Preds ..B2.18
                                # Execution count [1.25e+00]
        vpshufd   $14, %xmm2, %xmm2                             #172.21
        vmovsd    %xmm2, (%rdi,%rsi,8)                          #172.21
        vxorpd    %xmm2, %xmm2, %xmm2                           #173.21
                                # LOE rax rdx rcx rbx rdi r9 r12 r13 r14 r15 r10d r11d xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.21:                        # Preds ..B2.19 ..B2.20
                                # Execution count [1.88e+00]
        testl     %r10d, %r10d                                  #173.21
        je        ..B2.72       # Prob 40%                      #173.21
                                # LOE rax rdx rcx rbx rdi r9 r12 r13 r14 r15 r10d r11d xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.22:                        # Preds ..B2.21
                                # Execution count [3.12e+00]
        vmovhpd   (%rdi,%rcx,8), %xmm2, %xmm3                   #173.21
        testl     %r11d, %r11d                                  #173.21
        vsubpd    %xmm1, %xmm3, %xmm1                           #173.21
        je        ..B2.24       # Prob 40%                      #173.21
                                # LOE rax rdx rcx rbx rdi r9 r12 r13 r14 r15 r10d r11d xmm0 xmm1 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.23:                        # Preds ..B2.22
                                # Execution count [1.88e+00]
        vpshufd   $14, %xmm1, %xmm2                             #173.21
        vmovsd    %xmm1, (%rdi,%rbx,8)                          #173.21
        vmovsd    %xmm2, (%rdi,%rcx,8)                          #173.21
        vmovsd    (%rdi,%rdx,8), %xmm1                          #174.21
        jmp       ..B2.25       # Prob 100%                     #174.21
                                # LOE rax rdx rdi r9 r12 r13 r14 r15 r10d r11d xmm0 xmm1 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.24:                        # Preds ..B2.22
                                # Execution count [1.25e+00]
        vpshufd   $14, %xmm1, %xmm1                             #173.21
        vmovsd    %xmm1, (%rdi,%rcx,8)                          #173.21
        vxorpd    %xmm1, %xmm1, %xmm1                           #174.21
                                # LOE rax rdx rdi r9 r12 r13 r14 r15 r10d r11d xmm0 xmm1 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.25:                        # Preds ..B2.23 ..B2.24
                                # Execution count [1.88e+00]
        testl     %r10d, %r10d                                  #174.21
        je        ..B2.71       # Prob 40%                      #174.21
                                # LOE rax rdx rdi r9 r12 r13 r14 r15 r11d xmm0 xmm1 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.26:                        # Preds ..B2.25
                                # Execution count [3.12e+00]
        vmovhpd   (%rdi,%r9,8), %xmm1, %xmm2                    #174.21
        testl     %r11d, %r11d                                  #174.21
        vsubpd    %xmm0, %xmm2, %xmm0                           #174.21
        je        ..B2.28       # Prob 40%                      #174.21
                                # LOE rax rdx rdi r9 r12 r13 r14 r15 xmm0 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.27:                        # Preds ..B2.26
                                # Execution count [1.88e+00]
        vmovsd    %xmm0, (%rdi,%rdx,8)                          #174.21
        vpshufd   $14, %xmm0, %xmm0                             #174.21
        jmp       ..B2.29       # Prob 100%                     #174.21
                                # LOE rax rdi r9 r12 r13 r14 r15 xmm0 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.28:                        # Preds ..B2.26
                                # Execution count [1.25e+00]
        vpshufd   $14, %xmm0, %xmm0                             #174.21
                                # LOE rax rdi r9 r12 r13 r14 r15 xmm0 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.29:                        # Preds ..B2.27 ..B2.28
                                # Execution count [3.12e+00]
        vmovsd    %xmm0, (%rdi,%r9,8)                           #174.21
        jmp       ..B2.38       # Prob 100%                     #174.21
                                # LOE rax rdi r12 r13 r14 r15 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.30:                        # Preds ..B2.17
                                # Execution count [1.88e+00]
        testl     %r11d, %r11d                                  #172.21
        vxorpd    %xmm2, %xmm2, %xmm2                           #172.21
        vsubpd    %xmm12, %xmm2, %xmm2                          #172.21
        je        ..B2.32       # Prob 40%                      #172.21
                                # LOE rax rdx rbx rdi r8 r12 r13 r14 r15 xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.31:                        # Preds ..B2.16 ..B2.30
                                # Execution count [1.25e+00]
        vmovsd    %xmm2, (%rdi,%r8,8)                           #172.21
        vmovsd    (%rdi,%rbx,8), %xmm3                          #173.21
        vxorpd    %xmm4, %xmm4, %xmm4                           #173.21
        vunpcklpd %xmm4, %xmm3, %xmm5                           #173.21
        vsubpd    %xmm1, %xmm5, %xmm1                           #173.21
        jmp       ..B2.34       # Prob 100%                     #173.21
                                # LOE rax rdx rbx rdi r12 r13 r14 r15 xmm0 xmm1 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.32:                        # Preds ..B2.30
                                # Execution count [0.00e+00]
        vxorpd    %xmm2, %xmm2, %xmm2                           #173.21
        jmp       ..B2.33       # Prob 100%                     #173.21
                                # LOE rax rdx rbx rdi r12 r13 r14 r15 xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.72:                        # Preds ..B2.21
                                # Execution count [7.50e-01]
        testl     %r11d, %r11d                                  #172.21
                                # LOE rax rdx rbx rdi r12 r13 r14 r15 xmm0 xmm1 xmm2 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.33:                        # Preds ..B2.32 ..B2.72
                                # Execution count [2.67e+00]
        vxorpd    %xmm3, %xmm3, %xmm3                           #173.21
        vunpcklpd %xmm3, %xmm2, %xmm4                           #173.21
        vsubpd    %xmm1, %xmm4, %xmm1                           #173.21
        je        ..B2.35       # Prob 40%                      #173.21
                                # LOE rax rdx rbx rdi r12 r13 r14 r15 xmm0 xmm1 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.34:                        # Preds ..B2.31 ..B2.33
                                # Execution count [1.25e+00]
        vmovsd    %xmm1, (%rdi,%rbx,8)                          #173.21
        vmovsd    (%rdi,%rdx,8), %xmm2                          #174.21
        vxorpd    %xmm3, %xmm3, %xmm3                           #174.21
        vunpcklpd %xmm3, %xmm2, %xmm4                           #174.21
        vsubpd    %xmm0, %xmm4, %xmm0                           #174.21
        jmp       ..B2.37       # Prob 100%                     #174.21
                                # LOE rax rdx rdi r12 r13 r14 r15 xmm0 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.35:                        # Preds ..B2.33
                                # Execution count [0.00e+00]
        vxorpd    %xmm1, %xmm1, %xmm1                           #174.21
        jmp       ..B2.36       # Prob 100%                     #174.21
                                # LOE rax rdx rdi r12 r13 r14 r15 xmm0 xmm1 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.71:                        # Preds ..B2.25
                                # Execution count [7.50e-01]
        testl     %r11d, %r11d                                  #172.21
                                # LOE rax rdx rdi r12 r13 r14 r15 xmm0 xmm1 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.36:                        # Preds ..B2.35 ..B2.71
                                # Execution count [2.67e+00]
        vxorpd    %xmm2, %xmm2, %xmm2                           #174.21
        vunpcklpd %xmm2, %xmm1, %xmm3                           #174.21
        vsubpd    %xmm0, %xmm3, %xmm0                           #174.21
        je        ..B2.38       # Prob 40%                      #174.21
                                # LOE rax rdx rdi r12 r13 r14 r15 xmm0 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.37:                        # Preds ..B2.34 ..B2.36
                                # Execution count [1.25e+00]
        vmovsd    %xmm0, (%rdi,%rdx,8)                          #174.21
                                # LOE rax rdi r12 r13 r14 r15 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.38:                        # Preds ..B2.36 ..B2.29 ..B2.37 ..B2.13 ..B2.12
                                #      
                                # Execution count [1.25e+01]
        addq      $2, %r15                                      #147.9
        cmpq      %r12, %r15                                    #147.9
        jb        ..B2.12       # Prob 82%                      #147.9
                                # LOE rax rdi r12 r13 r14 r15 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14
..B2.39:                        # Preds ..B2.38
                                # Execution count [2.25e+00]
        vunpckhpd %xmm11, %xmm11, %xmm12                        #137.22
        vunpckhpd %xmm14, %xmm14, %xmm8                         #135.22
        vaddsd    %xmm12, %xmm11, %xmm12                        #137.22
        vaddsd    %xmm8, %xmm14, %xmm10                         #135.22
        vunpckhpd %xmm13, %xmm13, %xmm11                        #136.22
        vmovsd    112(%rsp), %xmm1                              #[spill]
        vaddsd    %xmm11, %xmm13, %xmm11                        #136.22
        vmovsd    120(%rsp), %xmm3                              #[spill]
        vmovsd    128(%rsp), %xmm4                              #[spill]
        vmovsd    136(%rsp), %xmm6                              #[spill]
        vmovsd    24(%rsp), %xmm7                               #[spill]
        vmovsd    32(%rsp), %xmm2                               #[spill]
        movl      16(%rsp), %edx                                #[spill]
        movq      56(%rsp), %r9                                 #[spill]
        movq      64(%rsp), %rsi                                #[spill]
        movq      72(%rsp), %r8                                 #[spill]
        movq      80(%rsp), %r10                                #[spill]
        movq      88(%rsp), %r11                                #[spill]
        movq      96(%rsp), %rcx                                #[spill]
        movq      104(%rsp), %rbx                               #[spill]
        vmovsd    .L_2il0floatpacket.1(%rip), %xmm0             #
        vmovsd    .L_2il0floatpacket.4(%rip), %xmm5             #
                                # LOE rax rcx rbx rsi rdi r8 r9 r10 r11 r12 r14 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.40:                        # Preds ..B2.39 ..B2.56
                                # Execution count [2.50e+00]
        movslq    %edx, %r13                                    #147.9
        cmpq      %r13, %r12                                    #147.9
        jae       ..B2.49       # Prob 10%                      #147.9
                                # LOE rax rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 r14 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.41:                        # Preds ..B2.40
                                # Execution count [2.25e+00]
        imulq     %rsi, %rax                                    #130.43
        movq      %rcx, 96(%rsp)                                #106.5[spill]
        addq      40(%rsp), %rax                                #106.5[spill]
        movl      48(%rsp), %ecx                                #106.5[spill]
        movq      %rbx, 104(%rsp)                               #106.5[spill]
                                # LOE rax rsi rdi r8 r9 r10 r11 r12 r13 r14 edx ecx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.42:                        # Preds ..B2.45 ..B2.41
                                # Execution count [1.25e+01]
        movl      (%rax,%r12,4), %ebx                           #148.21
        lea       (%rbx,%rbx,2), %r15d                          #149.36
        movslq    %r15d, %r15                                   #149.36
        vsubsd    8(%r14,%r15,8), %xmm3, %xmm9                  #150.36
        vsubsd    (%r14,%r15,8), %xmm4, %xmm14                  #149.36
        vsubsd    16(%r14,%r15,8), %xmm1, %xmm8                 #151.36
        vmulsd    %xmm9, %xmm9, %xmm13                          #152.49
        vfmadd231sd %xmm14, %xmm14, %xmm13                      #152.63
        vfmadd231sd %xmm8, %xmm8, %xmm13                        #152.63
        vcomisd   %xmm13, %xmm2                                 #162.22
        jbe       ..B2.45       # Prob 50%                      #162.22
                                # LOE rax rsi rdi r8 r9 r10 r11 r12 r13 r14 r15 edx ecx ebx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B2.43:                        # Preds ..B2.42
                                # Execution count [6.25e+00]
        vdivsd    %xmm13, %xmm5, %xmm15                         #163.39
        vmulsd    %xmm15, %xmm7, %xmm13                         #164.38
        vmulsd    %xmm15, %xmm13, %xmm13                        #164.44
        vmulsd    %xmm15, %xmm13, %xmm13                        #164.50
        vmulsd    %xmm6, %xmm15, %xmm15                         #165.55
        vmulsd    %xmm13, %xmm15, %xmm15                        #165.64
        vsubsd    %xmm0, %xmm13, %xmm13                         #165.55
        vmulsd    %xmm13, %xmm15, %xmm15                        #165.70
        vmulsd    %xmm15, %xmm14, %xmm13                        #166.31
        vmulsd    %xmm15, %xmm9, %xmm9                          #167.31
        vmulsd    %xmm15, %xmm8, %xmm8                          #168.31
        vaddsd    %xmm13, %xmm10, %xmm10                        #166.17
        vaddsd    %xmm9, %xmm11, %xmm11                         #167.17
        vaddsd    %xmm8, %xmm12, %xmm12                         #168.17
        cmpl      %ecx, %ebx                                    #171.24
        jge       ..B2.45       # Prob 50%                      #171.24
                                # LOE rax rsi rdi r8 r9 r10 r11 r12 r13 r14 r15 edx ecx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B2.44:                        # Preds ..B2.43
                                # Execution count [3.12e+00]
        vmovsd    8(%rdi,%r15,8), %xmm15                        #173.21
        vmovsd    (%rdi,%r15,8), %xmm14                         #172.21
        vsubsd    %xmm9, %xmm15, %xmm9                          #173.21
        vsubsd    %xmm13, %xmm14, %xmm13                        #172.21
        vmovsd    %xmm9, 8(%rdi,%r15,8)                         #173.21
        vmovsd    16(%rdi,%r15,8), %xmm9                        #174.21
        vmovsd    %xmm13, (%rdi,%r15,8)                         #172.21
        vsubsd    %xmm8, %xmm9, %xmm8                           #174.21
        vmovsd    %xmm8, 16(%rdi,%r15,8)                        #174.21
                                # LOE rax rsi rdi r8 r9 r10 r11 r12 r13 r14 edx ecx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.45:                        # Preds ..B2.44 ..B2.43 ..B2.42
                                # Execution count [1.25e+01]
        incq      %r12                                          #147.9
        cmpq      %r13, %r12                                    #147.9
        jb        ..B2.42       # Prob 82%                      #147.9
                                # LOE rax rsi rdi r8 r9 r10 r11 r12 r13 r14 edx ecx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.46:                        # Preds ..B2.45
                                # Execution count [2.25e+00]
        movq      96(%rsp), %rcx                                #[spill]
        movq      104(%rsp), %rbx                               #[spill]
        jmp       ..B2.49       # Prob 100%                     #
                                # LOE rcx rbx rsi rdi r8 r9 r10 r11 r13 r14 edx xmm0 xmm2 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.48:                        # Preds ..B2.9 ..B2.8
                                # Execution count [2.50e+00]
        movslq    %edx, %r13                                    #183.9
                                # LOE rcx rbx rsi rdi r8 r9 r10 r11 r13 r14 edx xmm0 xmm2 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.49:                        # Preds ..B2.46 ..B2.40 ..B2.48
                                # Execution count [5.00e+00]
        addq      %r13, %r10                                    #183.9
        lea       3(%rdx), %eax                                 #184.9
        sarl      $1, %eax                                      #184.9
        vaddsd    (%r9,%rdi), %xmm10, %xmm1                     #179.9
        vaddsd    8(%r9,%rdi), %xmm11, %xmm3                    #180.9
        vaddsd    16(%r9,%rdi), %xmm12, %xmm4                   #181.9
        shrl      $30, %eax                                     #184.9
        vmovsd    %xmm1, (%r9,%rdi)                             #179.9
        vmovsd    %xmm3, 8(%r9,%rdi)                            #180.9
        vmovsd    %xmm4, 16(%r9,%rdi)                           #181.9
        addq      $24, %r9                                      #129.5
        lea       3(%rax,%rdx), %edx                            #184.9
        movslq    %ecx, %rax                                    #129.32
        sarl      $2, %edx                                      #184.9
        incq      %rcx                                          #129.5
        movslq    %edx, %rdx                                    #184.9
        incq      %rax                                          #129.32
        addq      %rdx, %r8                                     #184.9
        cmpq      %rbx, %rcx                                    #129.5
        jb        ..B2.8        # Prob 82%                      #129.5
                                # LOE rax rcx rbx rsi rdi r8 r9 r10 r11 r14 xmm0 xmm2 xmm5 xmm6 xmm7
..B2.50:                        # Preds ..B2.49
                                # Execution count [9.00e-01]
        movq      (%rsp), %r12                                  #[spill]
        movq      %r10, (%r12)                                  #183.9
        movq      %r8, 8(%r12)                                  #184.9
        jmp       ..B2.53       # Prob 100%                     #184.9
                                # LOE
..B2.51:                        # Preds ..B2.1
                                # Execution count [5.00e-01]
        xorl      %eax, %eax                                    #122.16
..___tag_value_computeForceLJHalfNeigh.154:
#       getTimeStamp()
        call      getTimeStamp                                  #122.16
..___tag_value_computeForceLJHalfNeigh.155:
                                # LOE xmm0
..B2.69:                        # Preds ..B2.51
                                # Execution count [5.00e-01]
        vmovsd    %xmm0, 8(%rsp)                                #122.16[spill]
                                # LOE
..B2.52:                        # Preds ..B2.69
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.1, %edi                         #126.5
..___tag_value_computeForceLJHalfNeigh.157:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #126.5
..___tag_value_computeForceLJHalfNeigh.158:
                                # LOE
..B2.53:                        # Preds ..B2.50 ..B2.52
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.1, %edi                         #187.5
..___tag_value_computeForceLJHalfNeigh.159:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #187.5
..___tag_value_computeForceLJHalfNeigh.160:
                                # LOE
..B2.54:                        # Preds ..B2.53
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #190.16
..___tag_value_computeForceLJHalfNeigh.161:
#       getTimeStamp()
        call      getTimeStamp                                  #190.16
..___tag_value_computeForceLJHalfNeigh.162:
                                # LOE xmm0
..B2.55:                        # Preds ..B2.54
                                # Execution count [1.00e+00]
        vsubsd    8(%rsp), %xmm0, %xmm0                         #191.14[spill]
        addq      $216, %rsp                                    #191.14
	.cfi_restore 3
        popq      %rbx                                          #191.14
	.cfi_restore 15
        popq      %r15                                          #191.14
	.cfi_restore 14
        popq      %r14                                          #191.14
	.cfi_restore 13
        popq      %r13                                          #191.14
	.cfi_restore 12
        popq      %r12                                          #191.14
        movq      %rbp, %rsp                                    #191.14
        popq      %rbp                                          #191.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #191.14
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B2.56:                        # Preds ..B2.10
                                # Execution count [2.25e-01]: Infreq
        xorl      %r12d, %r12d                                  #147.9
        jmp       ..B2.40       # Prob 100%                     #147.9
                                # LOE rax rcx rbx rsi rdi r8 r9 r10 r11 r12 r14 edx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm10 xmm11 xmm12
..B2.57:                        # Preds ..B2.2
                                # Execution count [1.00e+00]: Infreq
        lea       (%rbx,%rbx,2), %rcx                           #105.18
        cmpq      $8, %rcx                                      #116.5
        jl        ..B2.65       # Prob 10%                      #116.5
                                # LOE rcx rbx rdi r12 r13 r14 r15d
..B2.58:                        # Preds ..B2.57
                                # Execution count [1.00e+00]: Infreq
        movl      %ecx, %eax                                    #116.5
        xorl      %edx, %edx                                    #116.5
        andl      $-8, %eax                                     #116.5
        movslq    %eax, %rax                                    #116.5
        vxorpd    %ymm0, %ymm0, %ymm0                           #117.22
                                # LOE rax rdx rcx rbx rdi r12 r13 r14 r15d ymm0
..B2.59:                        # Preds ..B2.59 ..B2.58
                                # Execution count [5.56e+00]: Infreq
        vmovupd   %ymm0, (%rdi,%rdx,8)                          #117.9
        vmovupd   %ymm0, 32(%rdi,%rdx,8)                        #117.9
        addq      $8, %rdx                                      #116.5
        cmpq      %rax, %rdx                                    #116.5
        jb        ..B2.59       # Prob 82%                      #116.5
                                # LOE rax rdx rcx rbx rdi r12 r13 r14 r15d ymm0
..B2.61:                        # Preds ..B2.59 ..B2.65
                                # Execution count [1.11e+00]: Infreq
        cmpq      %rcx, %rax                                    #116.5
        jae       ..B2.5        # Prob 10%                      #116.5
                                # LOE rax rcx rbx rdi r12 r13 r14 r15d
..B2.62:                        # Preds ..B2.61
                                # Execution count [1.00e+00]: Infreq
        xorl      %edx, %edx                                    #
                                # LOE rax rdx rcx rbx rdi r12 r13 r14 r15d
..B2.63:                        # Preds ..B2.62 ..B2.63
                                # Execution count [5.56e+00]: Infreq
        movq      %rdx, (%rdi,%rax,8)                           #117.9
        incq      %rax                                          #116.5
        cmpq      %rcx, %rax                                    #116.5
        jb        ..B2.63       # Prob 82%                      #116.5
        jmp       ..B2.5        # Prob 100%                     #116.5
                                # LOE rax rdx rcx rbx rdi r12 r13 r14 r15d
..B2.65:                        # Preds ..B2.57
                                # Execution count [1.00e-01]: Infreq
        xorl      %eax, %eax                                    #116.5
        jmp       ..B2.61       # Prob 100%                     #116.5
        .align    16,0x90
                                # LOE rax rcx rbx rdi r12 r13 r14 r15d
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
..___tag_value_computeForceLJFullNeigh_simd.179:
..L180:
                                                        #194.101
        pushq     %rbp                                          #194.101
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #194.101
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-32, %rsp                                    #194.101
        movl      4(%rsi), %edx                                 #195.18
        testl     %edx, %edx                                    #201.24
        jle       ..B3.4        # Prob 50%                      #201.24
                                # LOE rbx rsi r12 r13 r14 r15 edx
..B3.2:                         # Preds ..B3.1
                                # Execution count [5.00e-03]
        movq      64(%rsi), %rdi                                #202.9
        lea       (%rdx,%rdx,2), %eax                           #195.18
        cmpl      $12, %eax                                     #201.5
        jle       ..B3.7        # Prob 0%                       #201.5
                                # LOE rbx rdi r12 r13 r14 r15 edx
..B3.3:                         # Preds ..B3.2
                                # Execution count [1.00e+00]
        movslq    %edx, %rdx                                    #201.5
        xorl      %esi, %esi                                    #201.5
        lea       (%rdx,%rdx,2), %rdx                           #201.5
        shlq      $3, %rdx                                      #201.5
        call      __intel_avx_rep_memset                        #201.5
                                # LOE rbx r12 r13 r14 r15
..B3.4:                         # Preds ..B3.13 ..B3.1 ..B3.11 ..B3.3
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #207.16
        vzeroupper                                              #207.16
..___tag_value_computeForceLJFullNeigh_simd.184:
#       getTimeStamp()
        call      getTimeStamp                                  #207.16
..___tag_value_computeForceLJFullNeigh_simd.185:
                                # LOE
..B3.5:                         # Preds ..B3.4
                                # Execution count [1.00e+00]
        movl      $il0_peep_printf_format_0, %edi               #210.5
        movq      stderr(%rip), %rsi                            #210.5
        call      fputs                                         #210.5
                                # LOE
..B3.6:                         # Preds ..B3.5
                                # Execution count [1.00e+00]
        movl      $-1, %edi                                     #211.5
#       exit(int)
        call      exit                                          #211.5
                                # LOE
..B3.7:                         # Preds ..B3.2
                                # Execution count [1.00e+00]: Infreq
        movslq    %edx, %rdx                                    #201.5
        lea       (%rdx,%rdx,2), %rsi                           #195.18
        cmpq      $8, %rsi                                      #201.5
        jl        ..B3.15       # Prob 10%                      #201.5
                                # LOE rbx rsi rdi r12 r13 r14 r15
..B3.8:                         # Preds ..B3.7
                                # Execution count [1.00e+00]: Infreq
        movl      %esi, %edx                                    #201.5
        xorl      %ecx, %ecx                                    #201.5
        andl      $-8, %edx                                     #201.5
        xorl      %eax, %eax                                    #201.5
        movslq    %edx, %rdx                                    #201.5
        vxorpd    %ymm0, %ymm0, %ymm0                           #202.22
                                # LOE rax rdx rcx rbx rsi rdi r12 r13 r14 r15 ymm0
..B3.9:                         # Preds ..B3.9 ..B3.8
                                # Execution count [5.56e+00]: Infreq
        vmovupd   %ymm0, (%rdi,%rcx,8)                          #202.9
        vmovupd   %ymm0, 32(%rdi,%rcx,8)                        #202.9
        addq      $8, %rcx                                      #201.5
        cmpq      %rdx, %rcx                                    #201.5
        jb        ..B3.9        # Prob 82%                      #201.5
                                # LOE rax rdx rcx rbx rsi rdi r12 r13 r14 r15 ymm0
..B3.11:                        # Preds ..B3.9 ..B3.15
                                # Execution count [1.11e+00]: Infreq
        cmpq      %rsi, %rdx                                    #201.5
        jae       ..B3.4        # Prob 10%                      #201.5
                                # LOE rax rdx rbx rsi rdi r12 r13 r14 r15
..B3.13:                        # Preds ..B3.11 ..B3.13
                                # Execution count [5.56e+00]: Infreq
        movq      %rax, (%rdi,%rdx,8)                           #202.9
        incq      %rdx                                          #201.5
        cmpq      %rsi, %rdx                                    #201.5
        jb        ..B3.13       # Prob 82%                      #201.5
        jmp       ..B3.4        # Prob 100%                     #201.5
                                # LOE rax rdx rbx rsi rdi r12 r13 r14 r15
..B3.15:                        # Preds ..B3.7
                                # Execution count [1.00e-01]: Infreq
        xorl      %edx, %edx                                    #201.5
        xorl      %eax, %eax                                    #201.5
        jmp       ..B3.11       # Prob 100%                     #201.5
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
