# mark_description "Intel(R) C Intel(R) 64 Compiler Classic for applications running on Intel(R) 64, Version 2021.6.0 Build 2022";
# mark_description "0226_000000";
# mark_description "-I/apps/likwid/5.2.2/include -I././gromacs/includes -I././common/includes -S -std=c11 -pedantic-errors -D_GN";
# mark_description "U_SOURCE -DLIKWID_PERFMON -DAOS -DPRECISION=1 -DCOMPUTE_STATS -DVECTOR_WIDTH=16 -D__ISA_AVX512__ -DENABLE_OM";
# mark_description "P_SIMD -DALIGNMENT=64 -restrict -Ofast -xCORE-AVX512 -qopt-zmm-usage=high -o build-gromacs-ICC-AVX512-SP/for";
# mark_description "ce_lj.s";
	.file "force_lj.c"
	.text
..TXTST0:
.L_2__routine_start_computeForceLJ_ref_0:
# -- Begin  computeForceLJ_ref
	.text
# mark_begin;
       .align    16,0x90
	.globl computeForceLJ_ref
# --- computeForceLJ_ref(Parameter *, Atom *, Neighbor *, Stats *)
computeForceLJ_ref:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %rcx
..B1.1:                         # Preds ..B1.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForceLJ_ref.1:
..L2:
                                                          #19.91
        pushq     %rbp                                          #19.91
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #19.91
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #19.91
        pushq     %r12                                          #19.91
        pushq     %r13                                          #19.91
        pushq     %r14                                          #19.91
        pushq     %r15                                          #19.91
        pushq     %rbx                                          #19.91
        subq      $152, %rsp                                    #19.91
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
        movq      %rdi, %r15                                    #19.91
        movl      $.L_2__STRING.1, %edi                         #20.5
        xorl      %eax, %eax                                    #20.5
        movq      %rcx, %rbx                                    #19.91
        movq      %rdx, %r13                                    #19.91
        movq      %rsi, %r14                                    #19.91
..___tag_value_computeForceLJ_ref.11:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #20.5
..___tag_value_computeForceLJ_ref.12:
                                # LOE rbx r12 r13 r14 r15
..B1.2:                         # Preds ..B1.1
                                # Execution count [1.00e+00]
        vmovss    108(%r15), %xmm16                             #23.27
        xorl      %ecx, %ecx                                    #30.5
        vmulss    %xmm16, %xmm16, %xmm0                         #23.45
        xorl      %esi, %esi                                    #32.27
        vmovss    48(%r15), %xmm1                               #24.23
        vmovss    40(%r15), %xmm2                               #25.24
        movl      20(%r14), %edx                                #30.26
        vmovss    %xmm0, 16(%rsp)                               #23.45[spill]
        vmovss    %xmm1, 8(%rsp)                                #24.23[spill]
        vmovss    %xmm2, 24(%rsp)                               #25.24[spill]
        testl     %edx, %edx                                    #30.26
        jle       ..B1.23       # Prob 9%                       #30.26
                                # LOE rbx rsi r12 r13 r14 edx ecx
..B1.3:                         # Preds ..B1.2
                                # Execution count [9.00e-01]
        movq      176(%r14), %rdi                               #32.27
        xorl      %r12d, %r12d                                  #33.32
        movq      192(%r14), %rax                               #33.32
        vxorps    %xmm2, %xmm2, %xmm2                           #34.39
        vmovdqu   .L_2il0floatpacket.0(%rip), %xmm1             #33.9
        vmovdqu   .L_2il0floatpacket.1(%rip), %xmm0             #33.9
                                # LOE rax rbx rsi rdi r13 r14 edx ecx r12d xmm0 xmm1 xmm2
..B1.4:                         # Preds ..B1.21 ..B1.3
                                # Execution count [5.00e+00]
        movl      %ecx, %r8d                                    #31.27
        movl      %ecx, %r9d                                    #31.27
        sarl      $1, %r8d                                      #31.27
        andl      $1, %r9d                                      #31.27
        shll      $2, %r9d                                      #31.27
        lea       (%r8,%r8,2), %r10d                            #31.27
        lea       (%r9,%r10,8), %r11d                           #31.27
        movslq    %r11d, %r11                                   #32.27
        lea       (%rdi,%r11,4), %r15                           #32.27
        movl      (%rsi,%rax), %r11d                            #33.32
        testl     %r11d, %r11d                                  #33.32
        jle       ..B1.21       # Prob 50%                      #33.32
                                # LOE rax rbx rsi rdi r13 r14 r15 edx ecx r11d r12d xmm0 xmm1 xmm2
..B1.5:                         # Preds ..B1.4
                                # Execution count [4.50e+00]
        cmpl      $8, %r11d                                     #33.9
        jl        ..B1.152      # Prob 10%                      #33.9
                                # LOE rax rbx rsi rdi r13 r14 r15 edx ecx r11d r12d xmm0 xmm1 xmm2
..B1.6:                         # Preds ..B1.5
                                # Execution count [4.50e+00]
        lea       64(%r15), %r8                                 #36.13
        andq      $15, %r8                                      #33.9
        testl     $3, %r8d                                      #33.9
        je        ..B1.8        # Prob 50%                      #33.9
                                # LOE rax rbx rsi rdi r13 r14 r15 edx ecx r8d r11d r12d xmm0 xmm1 xmm2
..B1.7:                         # Preds ..B1.6
                                # Execution count [2.25e+00]
        movl      %r12d, %r8d                                   #33.9
        jmp       ..B1.9        # Prob 100%                     #33.9
                                # LOE rax rbx rsi rdi r8 r13 r14 r15 edx ecx r11d r12d xmm0 xmm1 xmm2
..B1.8:                         # Preds ..B1.6
                                # Execution count [2.25e+00]
        movl      %r8d, %r9d                                    #33.9
        negl      %r9d                                          #33.9
        addl      $16, %r9d                                     #33.9
        shrl      $2, %r9d                                      #33.9
        testl     %r8d, %r8d                                    #33.9
        cmovne    %r9d, %r8d                                    #33.9
                                # LOE rax rbx rsi rdi r8 r13 r14 r15 edx ecx r11d r12d xmm0 xmm1 xmm2
..B1.9:                         # Preds ..B1.7 ..B1.8
                                # Execution count [4.50e+00]
        lea       8(%r8), %r9d                                  #33.9
        cmpl      %r9d, %r11d                                   #33.9
        jl        ..B1.152      # Prob 10%                      #33.9
                                # LOE rax rbx rsi rdi r8 r13 r14 r15 edx ecx r11d r12d xmm0 xmm1 xmm2
..B1.10:                        # Preds ..B1.9
                                # Execution count [5.00e+00]
        movl      %r11d, %r10d                                  #33.9
        xorl      %r9d, %r9d                                    #33.9
        subl      %r8d, %r10d                                   #33.9
        andl      $7, %r10d                                     #33.9
        negl      %r10d                                         #33.9
        addl      %r11d, %r10d                                  #33.9
        cmpl      $1, %r8d                                      #33.9
        jb        ..B1.14       # Prob 10%                      #33.9
                                # LOE rax rbx rsi rdi r8 r9 r13 r14 r15 edx ecx r10d r11d r12d xmm0 xmm1 xmm2
..B1.12:                        # Preds ..B1.10 ..B1.12
                                # Execution count [2.50e+01]
        movl      %r12d, (%r15,%r9,4)                           #34.13
        movl      %r12d, 32(%r15,%r9,4)                         #35.13
        movl      %r12d, 64(%r15,%r9,4)                         #36.13
        incq      %r9                                           #33.9
        cmpq      %r8, %r9                                      #33.9
        jb        ..B1.12       # Prob 82%                      #33.9
                                # LOE rax rbx rsi rdi r8 r9 r13 r14 r15 edx ecx r10d r11d r12d xmm0 xmm1 xmm2
..B1.14:                        # Preds ..B1.12 ..B1.10
                                # Execution count [4.50e+00]
        movslq    %r10d, %r9                                    #33.9
                                # LOE rax rbx rsi rdi r8 r9 r13 r14 r15 edx ecx r10d r11d r12d xmm0 xmm1 xmm2
..B1.15:                        # Preds ..B1.15 ..B1.14
                                # Execution count [2.50e+01]
        vmovups   %xmm2, (%r15,%r8,4)                           #34.13
        vmovups   %xmm2, 32(%r15,%r8,4)                         #35.13
        vmovups   %xmm2, 64(%r15,%r8,4)                         #36.13
        vmovups   %xmm2, 16(%r15,%r8,4)                         #34.13
        vmovups   %xmm2, 48(%r15,%r8,4)                         #35.13
        vmovups   %xmm2, 80(%r15,%r8,4)                         #36.13
        addq      $8, %r8                                       #33.9
        cmpq      %r9, %r8                                      #33.9
        jb        ..B1.15       # Prob 82%                      #33.9
                                # LOE rax rbx rsi rdi r8 r9 r13 r14 r15 edx ecx r10d r11d r12d xmm0 xmm1 xmm2
..B1.17:                        # Preds ..B1.15 ..B1.152
                                # Execution count [5.00e+00]
        lea       1(%r10), %r8d                                 #33.9
        cmpl      %r11d, %r8d                                   #33.9
        ja        ..B1.21       # Prob 50%                      #33.9
                                # LOE rax rbx rsi rdi r13 r14 r15 edx ecx r10d r11d r12d xmm0 xmm1 xmm2
..B1.18:                        # Preds ..B1.17
                                # Execution count [4.50e+00]
        movslq    %r10d, %r9                                    #34.13
        negl      %r10d                                         #33.9
        addl      %r11d, %r10d                                  #33.9
        xorl      %r8d, %r8d                                    #33.9
        movslq    %r11d, %r11                                   #33.9
        vmovdqa   %xmm0, %xmm4                                  #33.9
        vpbroadcastd %r10d, %xmm3                               #33.9
        subq      %r9, %r11                                     #33.9
        lea       (%r15,%r9,4), %r15                            #34.13
                                # LOE rax rbx rsi rdi r8 r11 r13 r14 r15 edx ecx r12d xmm0 xmm1 xmm2 xmm3 xmm4
..B1.19:                        # Preds ..B1.19 ..B1.18
                                # Execution count [2.50e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #33.9
        vpaddd    %xmm1, %xmm4, %xmm4                           #33.9
        vmovups   %xmm2, (%r15,%r8,4){%k1}                      #34.13
        vmovups   %xmm2, 32(%r15,%r8,4){%k1}                    #35.13
        vmovups   %xmm2, 64(%r15,%r8,4){%k1}                    #36.13
        addq      $4, %r8                                       #33.9
        cmpq      %r11, %r8                                     #33.9
        jb        ..B1.19       # Prob 82%                      #33.9
                                # LOE rax rbx rsi rdi r8 r11 r13 r14 r15 edx ecx r12d xmm0 xmm1 xmm2 xmm3 xmm4
..B1.21:                        # Preds ..B1.19 ..B1.4 ..B1.17
                                # Execution count [5.00e+00]
        incl      %ecx                                          #30.5
        addq      $28, %rsi                                     #30.5
        cmpl      %edx, %ecx                                    #30.5
        jb        ..B1.4        # Prob 82%                      #30.5
                                # LOE rax rbx rsi rdi r13 r14 edx ecx r12d xmm0 xmm1 xmm2
..B1.23:                        # Preds ..B1.21 ..B1.2
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #40.16
..___tag_value_computeForceLJ_ref.16:
#       getTimeStamp()
        call      getTimeStamp                                  #40.16
..___tag_value_computeForceLJ_ref.17:
                                # LOE rbx r12 r13 r14 xmm0
..B1.156:                       # Preds ..B1.23
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, (%rsp)                                 #40.16[spill]
                                # LOE rbx r12 r13 r14
..B1.24:                        # Preds ..B1.156
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.2, %edi                         #44.5
..___tag_value_computeForceLJ_ref.19:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #44.5
..___tag_value_computeForceLJ_ref.20:
                                # LOE rbx r12 r13 r14
..B1.25:                        # Preds ..B1.24
                                # Execution count [9.00e-01]
        movl      20(%r14), %eax                                #47.26
        movl      %eax, 56(%rsp)                                #47.26[spill]
        testl     %eax, %eax                                    #47.26
        jle       ..B1.148      # Prob 0%                       #47.26
                                # LOE rbx r12 r13 r14
..B1.26:                        # Preds ..B1.25
                                # Execution count [9.00e-01]
        xorl      %edx, %edx                                    #47.5
        movq      160(%r14), %r10                               #51.27
        movq      176(%r14), %r9                                #52.27
        movq      8(%r13), %rdi                                 #53.19
        movslq    16(%r13), %r8                                 #53.44
        movq      24(%r13), %r14                                #54.25
        movl      32(%r13), %r11d                               #77.28
        movq      (%rbx), %rcx                                  #122.9
        movq      8(%rbx), %rsi                                 #123.9
        movq      16(%rbx), %rax                                #124.9
        movl      56(%rsp), %r13d                               #47.5[spill]
                                # LOE rax rcx rbx rsi rdi r8 r9 r10 r12 r14 edx r11d r13d
..B1.27:                        # Preds ..B1.27 ..B1.26
                                # Execution count [5.00e+00]
        incl      %edx                                          #47.5
        incq      %rcx                                          #122.9
        cmpl      %r13d, %edx                                   #47.5
        jb        ..B1.27       # Prob 82%                      #47.5
                                # LOE rax rcx rbx rsi rdi r8 r9 r10 r12 r14 edx r11d r13d
..B1.28:                        # Preds ..B1.27
                                # Execution count [9.00e-01]
        movq      %rcx, (%rbx)                                  #122.9
        xorl      %ecx, %ecx                                    #47.5
        vmovss    24(%rsp), %xmm0                               #91.54[spill]
        xorl      %edx, %edx                                    #48.22
        vmovss    8(%rsp), %xmm8                                #48.22[spill]
        vmovss    16(%rsp), %xmm11                              #48.22[spill]
        vmovsd    .L_2il0floatpacket.2(%rip), %xmm9             #124.9
        vmovss    .L_2il0floatpacket.5(%rip), %xmm10            #89.44
        vmulss    .L_2il0floatpacket.3(%rip), %xmm0, %xmm7      #91.54
        vmovss    .L_2il0floatpacket.4(%rip), %xmm3             #91.67
        movl      %r11d, 32(%rsp)                               #48.22[spill]
        movq      %r14, 64(%rsp)                                #48.22[spill]
        movq      %rbx, 72(%rsp)                                #48.22[spill]
                                # LOE rax rdx rsi rdi r8 r9 r10 ecx xmm3 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.29:                        # Preds ..B1.146 ..B1.28
                                # Execution count [5.00e+00]
        movl      %ecx, %r13d                                   #48.22
        movl      %ecx, %r15d                                   #50.27
        sarl      $1, %r13d                                     #48.22
        andl      $1, %r15d                                     #50.27
        shll      $2, %r15d                                     #50.27
        movq      64(%rsp), %rbx                                #54.25[spill]
        lea       (%r13,%r13,2), %r11d                          #50.27
        movslq    (%rbx,%rdx,4), %r12                           #54.25
        lea       (%r15,%r11,8), %r14d                          #50.27
        movslq    %r14d, %r14                                   #50.27
        xorl      %ebx, %ebx                                    #56.9
        lea       (%r10,%r14,4), %r11                           #51.27
        lea       (%r9,%r14,4), %r14                            #52.27
        testq     %r12, %r12                                    #56.28
        jle       ..B1.146      # Prob 10%                      #56.28
                                # LOE rax rdx rbx rsi rdi r8 r9 r10 r11 r12 r14 ecx r13d r15d xmm3 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.30:                        # Preds ..B1.29
                                # Execution count [4.50e+00]
        movq      %rax, 24(%rsp)                                #[spill]
        movq      %rdx, 48(%rsp)                                #[spill]
        movl      %ecx, 40(%rsp)                                #[spill]
        movq      %rsi, 16(%rsp)                                #[spill]
        movq      %r8, 8(%rsp)                                  #[spill]
        movq      %r9, 80(%rsp)                                 #[spill]
        movq      %r10, 88(%rsp)                                #[spill]
        movl      32(%rsp), %eax                                #[spill]
                                # LOE rbx rdi r11 r12 r14 eax r13d r15d xmm3 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.31:                        # Preds ..B1.144 ..B1.30
                                # Execution count [2.50e+01]
        movl      (%rdi,%rbx,4), %r10d                          #57.22
        xorb      %dl, %dl                                      #59.21
        movslq    %r10d, %r10                                   #58.31
        xorb      %cl, %cl                                      #63.13
        movq      %rbx, 112(%rsp)                               #63.13[spill]
        movl      %r15d, %r9d                                   #63.13
        movq      %r12, 104(%rsp)                               #63.13[spill]
        xorl      %esi, %esi                                    #63.13
        movq      %rdi, 96(%rsp)                                #63.13[spill]
        movq      80(%rsp), %rbx                                #63.13[spill]
        lea       (%r10,%r10,2), %r8                            #60.28
        movq      88(%rsp), %rdi                                #63.13[spill]
        movq      72(%rsp), %r12                                #63.13[spill]
        shlq      $5, %r8                                       #60.28
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm3 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.32:                        # Preds ..B1.143 ..B1.31
                                # Execution count [1.00e+02]
        vmovss    (%r11,%rsi,4), %xmm6                          #64.33
        vxorps    %xmm2, %xmm2, %xmm2                           #67.30
        vmovaps   %xmm2, %xmm1                                  #68.30
        vmovss    32(%r11,%rsi,4), %xmm5                        #65.33
        vmovaps   %xmm1, %xmm0                                  #69.30
        vmovss    64(%r11,%rsi,4), %xmm4                        #66.33
        testl     %eax, %eax                                    #77.28
        je        ..B1.37       # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.33:                        # Preds ..B1.32
                                # Execution count [5.00e+01]
        cmpl      %r10d, %r13d                                  #77.62
        jne       ..B1.39       # Prob 50%                      #77.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.34:                        # Preds ..B1.33
                                # Execution count [2.50e+01]
        testl     %r9d, %r9d                                    #77.99
        jl        ..B1.39       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.35:                        # Preds ..B1.34
                                # Execution count [6.25e+00]
        jle       ..B1.53       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.36:                        # Preds ..B1.35
                                # Execution count [3.12e+00]
        cmpl      $2, %r9d                                      #77.99
        jl        ..B1.69       # Prob 50%                      #77.99
        jmp       ..B1.48       # Prob 100%                     #77.99
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.37:                        # Preds ..B1.32
                                # Execution count [5.00e+01]
        cmpl      %r10d, %r13d                                  #78.62
        jne       ..B1.39       # Prob 50%                      #78.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.38:                        # Preds ..B1.37
                                # Execution count [2.50e+01]
        testl     %r9d, %r9d                                    #78.100
        je        ..B1.53       # Prob 50%                      #78.100
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.39:                        # Preds ..B1.37 ..B1.38 ..B1.33 ..B1.34
                                # Execution count [5.00e+01]
        vsubss    32(%r8,%rdi), %xmm5, %xmm17                   #85.48
        vsubss    (%r8,%rdi), %xmm6, %xmm16                     #84.48
        vsubss    64(%r8,%rdi), %xmm4, %xmm18                   #86.48
        vmulss    %xmm17, %xmm17, %xmm12                        #87.61
        vfmadd231ss %xmm16, %xmm16, %xmm12                      #87.75
        vfmadd231ss %xmm18, %xmm18, %xmm12                      #87.75
        vcomiss   %xmm12, %xmm11                                #88.34
        jbe       ..B1.43       # Prob 50%                      #88.34
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm16 xmm17 xmm18
..B1.40:                        # Preds ..B1.39
                                # Execution count [2.50e+01]
        vdivss    %xmm12, %xmm10, %xmm2                         #89.51
        vmulss    %xmm2, %xmm8, %xmm0                           #90.50
        vmulss    %xmm7, %xmm2, %xmm12                          #91.67
        vmulss    %xmm2, %xmm0, %xmm1                           #90.56
        vmulss    %xmm2, %xmm1, %xmm13                          #90.62
        vmulss    %xmm13, %xmm12, %xmm14                        #91.76
        vsubss    %xmm3, %xmm13, %xmm15                         #91.67
        vmulss    %xmm15, %xmm14, %xmm14                        #91.82
        vmulss    %xmm14, %xmm16, %xmm2                         #94.67
        testl     %eax, %eax                                    #93.32
        je        ..B1.42       # Prob 50%                      #93.32
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm14 xmm17 xmm18
..B1.41:                        # Preds ..B1.40
                                # Execution count [1.25e+01]
        vmovss    (%r8,%rbx), %xmm1                             #94.33
        movb      $1, %dl                                       #102.29
        vmovss    32(%r8,%rbx), %xmm12                          #95.33
        vsubss    %xmm2, %xmm1, %xmm0                           #94.33
        vmulss    %xmm14, %xmm17, %xmm1                         #95.67
        vfnmadd213ss %xmm12, %xmm14, %xmm17                     #95.33
        vmovss    64(%r8,%rbx), %xmm13                          #96.33
        vmovss    %xmm0, (%r8,%rbx)                             #94.33
        vmulss    %xmm14, %xmm18, %xmm0                         #96.67
        vfnmadd213ss %xmm13, %xmm18, %xmm14                     #96.33
        vmovss    %xmm17, 32(%r8,%rbx)                          #95.33
        vmovss    %xmm14, 64(%r8,%rbx)                          #96.33
        incq      24(%r12)                                      #103.29
        jmp       ..B1.44       # Prob 100%                     #103.29
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.42:                        # Preds ..B1.40
                                # Execution count [1.25e+01]
        vmulss    %xmm14, %xmm17, %xmm1                         #100.43
        movb      $1, %dl                                       #102.29
        vmulss    %xmm14, %xmm18, %xmm0                         #101.43
        incq      24(%r12)                                      #103.29
        jmp       ..B1.51       # Prob 100%                     #103.29
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.43:                        # Preds ..B1.39
                                # Execution count [2.50e+01]
        incq      32(%r12)                                      #105.29
        testl     %eax, %eax                                    #77.28
        je        ..B1.51       # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.44:                        # Preds ..B1.41 ..B1.43
                                # Execution count [3.75e+01]
        cmpl      %r10d, %r13d                                  #77.62
        jne       ..B1.53       # Prob 50%                      #77.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.45:                        # Preds ..B1.44
                                # Execution count [1.88e+01]
        testl     %r9d, %r9d                                    #77.99
        jle       ..B1.53       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.46:                        # Preds ..B1.45
                                # Execution count [0.00e+00]
        cmpl      $2, %r9d                                      #77.99
        jl        ..B1.69       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.47:                        # Preds ..B1.46
                                # Execution count [0.00e+00]
        testl     %eax, %eax                                    #77.28
        je        ..B1.81       # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.48:                        # Preds ..B1.36 ..B1.47
                                # Execution count [0.00e+00]
        cmpl      $3, %r9d                                      #77.99
        jl        ..B1.82       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.49:                        # Preds ..B1.48
                                # Execution count [6.25e+00]
        cmpl      %r10d, %r13d                                  #77.62
        jne       ..B1.95       # Prob 50%                      #77.62
        jmp       ..B1.63       # Prob 100%                     #77.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.51:                        # Preds ..B1.42 ..B1.43
                                # Execution count [3.75e+01]
        cmpl      %r10d, %r13d                                  #78.62
        jne       ..B1.53       # Prob 50%                      #78.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.52:                        # Preds ..B1.51
                                # Execution count [1.88e+01]
        cmpl      $1, %r9d                                      #78.100
        je        ..B1.69       # Prob 50%                      #78.100
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.53:                        # Preds ..B1.52 ..B1.45 ..B1.44 ..B1.51 ..B1.35
                                #       ..B1.38
                                # Execution count [5.00e+01]
        vsubss    36(%r8,%rdi), %xmm5, %xmm20                   #85.48
        vsubss    4(%r8,%rdi), %xmm6, %xmm19                    #84.48
        vsubss    68(%r8,%rdi), %xmm4, %xmm21                   #86.48
        vmulss    %xmm20, %xmm20, %xmm12                        #87.61
        vfmadd231ss %xmm19, %xmm19, %xmm12                      #87.75
        vfmadd231ss %xmm21, %xmm21, %xmm12                      #87.75
        vcomiss   %xmm12, %xmm11                                #88.34
        jbe       ..B1.58       # Prob 50%                      #88.34
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm19 xmm20 xmm21
..B1.54:                        # Preds ..B1.53
                                # Execution count [2.50e+01]
        vdivss    %xmm12, %xmm10, %xmm14                        #89.51
        vmulss    %xmm14, %xmm8, %xmm12                         #90.50
        vmulss    %xmm7, %xmm14, %xmm15                         #91.67
        vmulss    %xmm14, %xmm12, %xmm13                        #90.56
        vmulss    %xmm14, %xmm13, %xmm16                        #90.62
        vmulss    %xmm16, %xmm15, %xmm17                        #91.76
        vsubss    %xmm3, %xmm16, %xmm18                         #91.67
        vmulss    %xmm18, %xmm17, %xmm16                        #91.82
        vmulss    %xmm16, %xmm19, %xmm18                        #94.67
        testl     %eax, %eax                                    #93.32
        je        ..B1.56       # Prob 50%                      #93.32
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm16 xmm18 xmm20 xmm21
..B1.55:                        # Preds ..B1.54
                                # Execution count [1.25e+01]
        vmovss    4(%r8,%rbx), %xmm12                           #94.33
        vmovss    36(%r8,%rbx), %xmm14                          #95.33
        vsubss    %xmm18, %xmm12, %xmm13                        #94.33
        vmulss    %xmm16, %xmm20, %xmm12                        #95.67
        vmovss    %xmm13, 4(%r8,%rbx)                           #94.33
        vsubss    %xmm12, %xmm14, %xmm15                        #95.33
        vmulss    %xmm16, %xmm21, %xmm13                        #96.67
        vmovss    68(%r8,%rbx), %xmm16                          #96.33
        vmovss    %xmm15, 36(%r8,%rbx)                          #95.33
        vsubss    %xmm13, %xmm16, %xmm17                        #96.33
        vmovss    %xmm17, 68(%r8,%rbx)                          #96.33
        jmp       ..B1.57       # Prob 100%                     #96.33
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm18
..B1.56:                        # Preds ..B1.54
                                # Execution count [1.25e+01]
        vmulss    %xmm16, %xmm20, %xmm12                        #100.43
        vmulss    %xmm16, %xmm21, %xmm13                        #101.43
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm18
..B1.57:                        # Preds ..B1.55 ..B1.56
                                # Execution count [2.50e+01]
        incq      24(%r12)                                      #103.29
        movb      $1, %dl                                       #102.29
        vaddss    %xmm18, %xmm2, %xmm2                          #99.29
        vaddss    %xmm12, %xmm1, %xmm1                          #100.29
        vaddss    %xmm13, %xmm0, %xmm0                          #101.29
        jmp       ..B1.59       # Prob 100%                     #101.29
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.58:                        # Preds ..B1.53
                                # Execution count [2.50e+01]
        incq      32(%r12)                                      #105.29
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.59:                        # Preds ..B1.57 ..B1.58
                                # Execution count [7.50e+01]
        testl     %eax, %eax                                    #77.28
        je        ..B1.67       # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.60:                        # Preds ..B1.59
                                # Execution count [3.75e+01]
        cmpl      %r10d, %r13d                                  #77.62
        jne       ..B1.69       # Prob 50%                      #77.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.61:                        # Preds ..B1.60
                                # Execution count [1.88e+01]
        cmpl      $2, %r9d                                      #77.99
        jl        ..B1.69       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.62:                        # Preds ..B1.61
                                # Execution count [6.25e+00]
        cmpl      $3, %r9d                                      #77.99
        jl        ..B1.82       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.63:                        # Preds ..B1.62 ..B1.49
                                # Execution count [3.91e+00]
        cmpl      $4, %r9d                                      #77.99
        jl        ..B1.95       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.64:                        # Preds ..B1.63
                                # Execution count [0.00e+00]
        testl     %eax, %eax                                    #77.28
        jne       ..B1.79       # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.65:                        # Preds ..B1.64
                                # Execution count [7.81e+00]
        cmpl      %r10d, %r13d                                  #78.62
        jne       ..B1.109      # Prob 50%                      #78.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.66:                        # Preds ..B1.65
                                # Execution count [3.91e+00]
        cmpl      $5, %r9d                                      #78.100
        jne       ..B1.109      # Prob 50%                      #78.100
        jmp       ..B1.106      # Prob 100%                     #78.100
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.67:                        # Preds ..B1.59
                                # Execution count [3.75e+01]
        cmpl      %r10d, %r13d                                  #78.62
        jne       ..B1.69       # Prob 50%                      #78.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.68:                        # Preds ..B1.67
                                # Execution count [1.88e+01]
        cmpl      $2, %r9d                                      #78.100
        je        ..B1.82       # Prob 50%                      #78.100
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.69:                        # Preds ..B1.36 ..B1.61 ..B1.68 ..B1.60 ..B1.67
                                #       ..B1.46 ..B1.52
                                # Execution count [5.00e+01]
        vsubss    40(%r8,%rdi), %xmm5, %xmm20                   #85.48
        vsubss    8(%r8,%rdi), %xmm6, %xmm19                    #84.48
        vsubss    72(%r8,%rdi), %xmm4, %xmm21                   #86.48
        vmulss    %xmm20, %xmm20, %xmm12                        #87.61
        vfmadd231ss %xmm19, %xmm19, %xmm12                      #87.75
        vfmadd231ss %xmm21, %xmm21, %xmm12                      #87.75
        vcomiss   %xmm12, %xmm11                                #88.34
        jbe       ..B1.74       # Prob 50%                      #88.34
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm19 xmm20 xmm21
..B1.70:                        # Preds ..B1.69
                                # Execution count [2.50e+01]
        vdivss    %xmm12, %xmm10, %xmm14                        #89.51
        vmulss    %xmm14, %xmm8, %xmm12                         #90.50
        vmulss    %xmm7, %xmm14, %xmm15                         #91.67
        vmulss    %xmm14, %xmm12, %xmm13                        #90.56
        vmulss    %xmm14, %xmm13, %xmm16                        #90.62
        vmulss    %xmm16, %xmm15, %xmm17                        #91.76
        vsubss    %xmm3, %xmm16, %xmm18                         #91.67
        vmulss    %xmm18, %xmm17, %xmm16                        #91.82
        vmulss    %xmm16, %xmm19, %xmm18                        #94.67
        testl     %eax, %eax                                    #93.32
        je        ..B1.72       # Prob 50%                      #93.32
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm16 xmm18 xmm20 xmm21
..B1.71:                        # Preds ..B1.70
                                # Execution count [1.25e+01]
        vmovss    8(%r8,%rbx), %xmm12                           #94.33
        vmovss    40(%r8,%rbx), %xmm14                          #95.33
        vsubss    %xmm18, %xmm12, %xmm13                        #94.33
        vmulss    %xmm16, %xmm20, %xmm12                        #95.67
        vmovss    %xmm13, 8(%r8,%rbx)                           #94.33
        vsubss    %xmm12, %xmm14, %xmm15                        #95.33
        vmulss    %xmm16, %xmm21, %xmm13                        #96.67
        vmovss    72(%r8,%rbx), %xmm16                          #96.33
        vmovss    %xmm15, 40(%r8,%rbx)                          #95.33
        vsubss    %xmm13, %xmm16, %xmm17                        #96.33
        vmovss    %xmm17, 72(%r8,%rbx)                          #96.33
        jmp       ..B1.73       # Prob 100%                     #96.33
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm18
..B1.72:                        # Preds ..B1.70
                                # Execution count [1.25e+01]
        vmulss    %xmm16, %xmm20, %xmm12                        #100.43
        vmulss    %xmm16, %xmm21, %xmm13                        #101.43
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm18
..B1.73:                        # Preds ..B1.71 ..B1.72
                                # Execution count [2.50e+01]
        incq      24(%r12)                                      #103.29
        movb      $1, %dl                                       #102.29
        vaddss    %xmm18, %xmm2, %xmm2                          #99.29
        vaddss    %xmm12, %xmm1, %xmm1                          #100.29
        vaddss    %xmm13, %xmm0, %xmm0                          #101.29
        jmp       ..B1.75       # Prob 100%                     #101.29
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.74:                        # Preds ..B1.69
                                # Execution count [2.50e+01]
        incq      32(%r12)                                      #105.29
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.75:                        # Preds ..B1.73 ..B1.74
                                # Execution count [7.50e+01]
        testl     %eax, %eax                                    #77.28
        je        ..B1.80       # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.76:                        # Preds ..B1.75
                                # Execution count [3.75e+01]
        cmpl      %r10d, %r13d                                  #77.62
        jne       ..B1.82       # Prob 50%                      #77.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.77:                        # Preds ..B1.76
                                # Execution count [1.88e+01]
        cmpl      $3, %r9d                                      #77.99
        jl        ..B1.82       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.78:                        # Preds ..B1.77
                                # Execution count [2.34e+00]
        cmpl      $4, %r9d                                      #77.99
        jl        ..B1.95       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.79:                        # Preds ..B1.78 ..B1.64
                                # Execution count [7.81e+00]
        cmpl      %r10d, %r13d                                  #77.62
        jne       ..B1.109      # Prob 50%                      #77.62
        jmp       ..B1.91       # Prob 100%                     #77.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.80:                        # Preds ..B1.75
                                # Execution count [3.75e+01]
        cmpl      %r10d, %r13d                                  #78.62
        jne       ..B1.82       # Prob 50%                      #78.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.81:                        # Preds ..B1.47 ..B1.80
                                # Execution count [1.88e+01]
        cmpl      $3, %r9d                                      #78.100
        je        ..B1.95       # Prob 50%                      #78.100
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.82:                        # Preds ..B1.48 ..B1.77 ..B1.81 ..B1.76 ..B1.80
                                #       ..B1.62 ..B1.68
                                # Execution count [5.00e+01]
        vsubss    44(%r8,%rdi), %xmm5, %xmm20                   #85.48
        vsubss    12(%r8,%rdi), %xmm6, %xmm19                   #84.48
        vsubss    76(%r8,%rdi), %xmm4, %xmm21                   #86.48
        vmulss    %xmm20, %xmm20, %xmm12                        #87.61
        vfmadd231ss %xmm19, %xmm19, %xmm12                      #87.75
        vfmadd231ss %xmm21, %xmm21, %xmm12                      #87.75
        vcomiss   %xmm12, %xmm11                                #88.34
        jbe       ..B1.87       # Prob 50%                      #88.34
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm19 xmm20 xmm21
..B1.83:                        # Preds ..B1.82
                                # Execution count [2.50e+01]
        vdivss    %xmm12, %xmm10, %xmm14                        #89.51
        vmulss    %xmm14, %xmm8, %xmm12                         #90.50
        vmulss    %xmm7, %xmm14, %xmm15                         #91.67
        vmulss    %xmm14, %xmm12, %xmm13                        #90.56
        vmulss    %xmm14, %xmm13, %xmm16                        #90.62
        vmulss    %xmm16, %xmm15, %xmm17                        #91.76
        vsubss    %xmm3, %xmm16, %xmm18                         #91.67
        vmulss    %xmm18, %xmm17, %xmm16                        #91.82
        vmulss    %xmm16, %xmm19, %xmm18                        #94.67
        testl     %eax, %eax                                    #93.32
        je        ..B1.85       # Prob 50%                      #93.32
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm16 xmm18 xmm20 xmm21
..B1.84:                        # Preds ..B1.83
                                # Execution count [1.25e+01]
        vmovss    12(%r8,%rbx), %xmm12                          #94.33
        vmovss    44(%r8,%rbx), %xmm14                          #95.33
        vsubss    %xmm18, %xmm12, %xmm13                        #94.33
        vmulss    %xmm16, %xmm20, %xmm12                        #95.67
        vmovss    %xmm13, 12(%r8,%rbx)                          #94.33
        vsubss    %xmm12, %xmm14, %xmm15                        #95.33
        vmulss    %xmm16, %xmm21, %xmm13                        #96.67
        vmovss    76(%r8,%rbx), %xmm16                          #96.33
        vmovss    %xmm15, 44(%r8,%rbx)                          #95.33
        vsubss    %xmm13, %xmm16, %xmm17                        #96.33
        vmovss    %xmm17, 76(%r8,%rbx)                          #96.33
        jmp       ..B1.86       # Prob 100%                     #96.33
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm18
..B1.85:                        # Preds ..B1.83
                                # Execution count [1.25e+01]
        vmulss    %xmm16, %xmm20, %xmm12                        #100.43
        vmulss    %xmm16, %xmm21, %xmm13                        #101.43
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm18
..B1.86:                        # Preds ..B1.84 ..B1.85
                                # Execution count [2.50e+01]
        incq      24(%r12)                                      #103.29
        movb      $1, %dl                                       #102.29
        vaddss    %xmm18, %xmm2, %xmm2                          #99.29
        vaddss    %xmm12, %xmm1, %xmm1                          #100.29
        vaddss    %xmm13, %xmm0, %xmm0                          #101.29
        jmp       ..B1.88       # Prob 100%                     #101.29
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.87:                        # Preds ..B1.82
                                # Execution count [2.50e+01]
        incq      32(%r12)                                      #105.29
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.88:                        # Preds ..B1.86 ..B1.87
                                # Execution count [7.50e+01]
        testl     %eax, %eax                                    #77.28
        je        ..B1.93       # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.89:                        # Preds ..B1.88
                                # Execution count [3.75e+01]
        cmpl      %r10d, %r13d                                  #77.62
        jne       ..B1.95       # Prob 50%                      #77.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.90:                        # Preds ..B1.89
                                # Execution count [1.88e+01]
        cmpl      $4, %r9d                                      #77.99
        jl        ..B1.95       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.91:                        # Preds ..B1.90 ..B1.79
                                # Execution count [6.25e+00]
        cmpl      $5, %r9d                                      #77.99
        jl        ..B1.109      # Prob 50%                      #77.99
        jmp       ..B1.106      # Prob 100%                     #77.99
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.93:                        # Preds ..B1.88
                                # Execution count [3.75e+01]
        cmpl      %r10d, %r13d                                  #78.62
        jne       ..B1.95       # Prob 50%                      #78.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.94:                        # Preds ..B1.93
                                # Execution count [1.88e+01]
        cmpl      $4, %r9d                                      #78.100
        je        ..B1.109      # Prob 50%                      #78.100
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.95:                        # Preds ..B1.81 ..B1.78 ..B1.90 ..B1.94 ..B1.89
                                #       ..B1.93 ..B1.49 ..B1.63
                                # Execution count [5.00e+01]
        vsubss    48(%r8,%rdi), %xmm5, %xmm20                   #85.48
        vsubss    16(%r8,%rdi), %xmm6, %xmm19                   #84.48
        vsubss    80(%r8,%rdi), %xmm4, %xmm21                   #86.48
        vmulss    %xmm20, %xmm20, %xmm12                        #87.61
        vfmadd231ss %xmm19, %xmm19, %xmm12                      #87.75
        vfmadd231ss %xmm21, %xmm21, %xmm12                      #87.75
        vcomiss   %xmm12, %xmm11                                #88.34
        jbe       ..B1.100      # Prob 50%                      #88.34
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm19 xmm20 xmm21
..B1.96:                        # Preds ..B1.95
                                # Execution count [2.50e+01]
        vdivss    %xmm12, %xmm10, %xmm14                        #89.51
        vmulss    %xmm14, %xmm8, %xmm12                         #90.50
        vmulss    %xmm7, %xmm14, %xmm15                         #91.67
        vmulss    %xmm14, %xmm12, %xmm13                        #90.56
        vmulss    %xmm14, %xmm13, %xmm16                        #90.62
        vmulss    %xmm16, %xmm15, %xmm17                        #91.76
        vsubss    %xmm3, %xmm16, %xmm18                         #91.67
        vmulss    %xmm18, %xmm17, %xmm16                        #91.82
        vmulss    %xmm16, %xmm19, %xmm18                        #94.67
        testl     %eax, %eax                                    #93.32
        je        ..B1.98       # Prob 50%                      #93.32
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm16 xmm18 xmm20 xmm21
..B1.97:                        # Preds ..B1.96
                                # Execution count [1.25e+01]
        vmovss    16(%r8,%rbx), %xmm12                          #94.33
        vmovss    48(%r8,%rbx), %xmm14                          #95.33
        vsubss    %xmm18, %xmm12, %xmm13                        #94.33
        vmulss    %xmm16, %xmm20, %xmm12                        #95.67
        vmovss    %xmm13, 16(%r8,%rbx)                          #94.33
        vsubss    %xmm12, %xmm14, %xmm15                        #95.33
        vmulss    %xmm16, %xmm21, %xmm13                        #96.67
        vmovss    80(%r8,%rbx), %xmm16                          #96.33
        vmovss    %xmm15, 48(%r8,%rbx)                          #95.33
        vsubss    %xmm13, %xmm16, %xmm17                        #96.33
        vmovss    %xmm17, 80(%r8,%rbx)                          #96.33
        jmp       ..B1.99       # Prob 100%                     #96.33
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm18
..B1.98:                        # Preds ..B1.96
                                # Execution count [1.25e+01]
        vmulss    %xmm16, %xmm20, %xmm12                        #100.43
        vmulss    %xmm16, %xmm21, %xmm13                        #101.43
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm18
..B1.99:                        # Preds ..B1.97 ..B1.98
                                # Execution count [2.50e+01]
        incq      24(%r12)                                      #103.29
        movb      $1, %dl                                       #102.29
        vaddss    %xmm18, %xmm2, %xmm2                          #99.29
        vaddss    %xmm12, %xmm1, %xmm1                          #100.29
        vaddss    %xmm13, %xmm0, %xmm0                          #101.29
        jmp       ..B1.101      # Prob 100%                     #101.29
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.100:                       # Preds ..B1.95
                                # Execution count [2.50e+01]
        incq      32(%r12)                                      #105.29
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.101:                       # Preds ..B1.99 ..B1.100
                                # Execution count [7.50e+01]
        testl     %eax, %eax                                    #77.28
        je        ..B1.104      # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.102:                       # Preds ..B1.101
                                # Execution count [3.75e+01]
        cmpl      %r10d, %r13d                                  #77.62
        jne       ..B1.109      # Prob 50%                      #77.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.103:                       # Preds ..B1.102
                                # Execution count [1.88e+01]
        cmpl      $5, %r9d                                      #77.99
        jl        ..B1.109      # Prob 50%                      #77.99
        jmp       ..B1.106      # Prob 100%                     #77.99
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.104:                       # Preds ..B1.101
                                # Execution count [3.75e+01]
        cmpl      %r10d, %r13d                                  #78.62
        jne       ..B1.109      # Prob 50%                      #78.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.105:                       # Preds ..B1.104
                                # Execution count [1.88e+01]
        cmpl      $5, %r9d                                      #78.100
        jne       ..B1.109      # Prob 50%                      #78.100
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.106:                       # Preds ..B1.91 ..B1.66 ..B1.105 ..B1.103
                                # Execution count [9.38e+00]
        testl     %eax, %eax                                    #77.28
        jne       ..B1.116      # Prob 50%                      #77.28
        jmp       ..B1.119      # Prob 100%                     #77.28
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.109:                       # Preds ..B1.94 ..B1.103 ..B1.105 ..B1.102 ..B1.104
                                #       ..B1.79 ..B1.91 ..B1.65 ..B1.66
                                # Execution count [5.00e+01]
        vsubss    52(%r8,%rdi), %xmm5, %xmm20                   #85.48
        vsubss    20(%r8,%rdi), %xmm6, %xmm19                   #84.48
        vsubss    84(%r8,%rdi), %xmm4, %xmm21                   #86.48
        vmulss    %xmm20, %xmm20, %xmm12                        #87.61
        vfmadd231ss %xmm19, %xmm19, %xmm12                      #87.75
        vfmadd231ss %xmm21, %xmm21, %xmm12                      #87.75
        vcomiss   %xmm12, %xmm11                                #88.34
        jbe       ..B1.114      # Prob 50%                      #88.34
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm19 xmm20 xmm21
..B1.110:                       # Preds ..B1.109
                                # Execution count [2.50e+01]
        vdivss    %xmm12, %xmm10, %xmm14                        #89.51
        vmulss    %xmm14, %xmm8, %xmm12                         #90.50
        vmulss    %xmm7, %xmm14, %xmm15                         #91.67
        vmulss    %xmm14, %xmm12, %xmm13                        #90.56
        vmulss    %xmm14, %xmm13, %xmm16                        #90.62
        vmulss    %xmm16, %xmm15, %xmm17                        #91.76
        vsubss    %xmm3, %xmm16, %xmm18                         #91.67
        vmulss    %xmm18, %xmm17, %xmm16                        #91.82
        vmulss    %xmm16, %xmm19, %xmm18                        #94.67
        testl     %eax, %eax                                    #93.32
        je        ..B1.112      # Prob 50%                      #93.32
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm16 xmm18 xmm20 xmm21
..B1.111:                       # Preds ..B1.110
                                # Execution count [1.25e+01]
        vmovss    20(%r8,%rbx), %xmm12                          #94.33
        vmovss    52(%r8,%rbx), %xmm14                          #95.33
        vsubss    %xmm18, %xmm12, %xmm13                        #94.33
        vmulss    %xmm16, %xmm20, %xmm12                        #95.67
        vmovss    %xmm13, 20(%r8,%rbx)                          #94.33
        vsubss    %xmm12, %xmm14, %xmm15                        #95.33
        vmulss    %xmm16, %xmm21, %xmm13                        #96.67
        vmovss    84(%r8,%rbx), %xmm16                          #96.33
        vmovss    %xmm15, 52(%r8,%rbx)                          #95.33
        vsubss    %xmm13, %xmm16, %xmm17                        #96.33
        vmovss    %xmm17, 84(%r8,%rbx)                          #96.33
        jmp       ..B1.113      # Prob 100%                     #96.33
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm18
..B1.112:                       # Preds ..B1.110
                                # Execution count [1.25e+01]
        vmulss    %xmm16, %xmm20, %xmm12                        #100.43
        vmulss    %xmm16, %xmm21, %xmm13                        #101.43
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm18
..B1.113:                       # Preds ..B1.111 ..B1.112
                                # Execution count [2.50e+01]
        incq      24(%r12)                                      #103.29
        movb      $1, %dl                                       #102.29
        vaddss    %xmm18, %xmm2, %xmm2                          #99.29
        vaddss    %xmm12, %xmm1, %xmm1                          #100.29
        vaddss    %xmm13, %xmm0, %xmm0                          #101.29
        jmp       ..B1.115      # Prob 100%                     #101.29
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.114:                       # Preds ..B1.109
                                # Execution count [2.50e+01]
        incq      32(%r12)                                      #105.29
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.115:                       # Preds ..B1.113 ..B1.114
                                # Execution count [7.50e+01]
        testl     %eax, %eax                                    #77.28
        je        ..B1.119      # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.116:                       # Preds ..B1.106 ..B1.115
                                # Execution count [3.75e+01]
        cmpl      %r10d, %r13d                                  #77.62
        jne       ..B1.122      # Prob 50%                      #77.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.118:                       # Preds ..B1.116
                                # Execution count [2.50e+01]
        cmpl      $6, %r9d                                      #77.99
        jl        ..B1.122      # Prob 50%                      #77.99
        jmp       ..B1.129      # Prob 100%                     #77.99
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.119:                       # Preds ..B1.106 ..B1.115
                                # Execution count [3.75e+01]
        cmpl      %r10d, %r13d                                  #78.62
        jne       ..B1.122      # Prob 50%                      #78.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.121:                       # Preds ..B1.119
                                # Execution count [2.50e+01]
        cmpl      $6, %r9d                                      #78.100
        je        ..B1.129      # Prob 50%                      #78.100
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.122:                       # Preds ..B1.116 ..B1.119 ..B1.118 ..B1.121
                                # Execution count [5.00e+01]
        vsubss    56(%r8,%rdi), %xmm5, %xmm20                   #85.48
        vsubss    24(%r8,%rdi), %xmm6, %xmm19                   #84.48
        vsubss    88(%r8,%rdi), %xmm4, %xmm21                   #86.48
        vmulss    %xmm20, %xmm20, %xmm12                        #87.61
        vfmadd231ss %xmm19, %xmm19, %xmm12                      #87.75
        vfmadd231ss %xmm21, %xmm21, %xmm12                      #87.75
        vcomiss   %xmm12, %xmm11                                #88.34
        jbe       ..B1.127      # Prob 50%                      #88.34
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm19 xmm20 xmm21
..B1.123:                       # Preds ..B1.122
                                # Execution count [2.50e+01]
        vdivss    %xmm12, %xmm10, %xmm14                        #89.51
        vmulss    %xmm14, %xmm8, %xmm12                         #90.50
        vmulss    %xmm7, %xmm14, %xmm15                         #91.67
        vmulss    %xmm14, %xmm12, %xmm13                        #90.56
        vmulss    %xmm14, %xmm13, %xmm16                        #90.62
        vmulss    %xmm16, %xmm15, %xmm17                        #91.76
        vsubss    %xmm3, %xmm16, %xmm18                         #91.67
        vmulss    %xmm18, %xmm17, %xmm16                        #91.82
        vmulss    %xmm16, %xmm19, %xmm18                        #94.67
        testl     %eax, %eax                                    #93.32
        je        ..B1.125      # Prob 50%                      #93.32
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm16 xmm18 xmm20 xmm21
..B1.124:                       # Preds ..B1.123
                                # Execution count [1.25e+01]
        vmovss    24(%r8,%rbx), %xmm12                          #94.33
        vmovss    56(%r8,%rbx), %xmm14                          #95.33
        vsubss    %xmm18, %xmm12, %xmm13                        #94.33
        vmulss    %xmm16, %xmm20, %xmm12                        #95.67
        vmovss    %xmm13, 24(%r8,%rbx)                          #94.33
        vsubss    %xmm12, %xmm14, %xmm15                        #95.33
        vmulss    %xmm16, %xmm21, %xmm13                        #96.67
        vmovss    88(%r8,%rbx), %xmm16                          #96.33
        vmovss    %xmm15, 56(%r8,%rbx)                          #95.33
        vsubss    %xmm13, %xmm16, %xmm17                        #96.33
        vmovss    %xmm17, 88(%r8,%rbx)                          #96.33
        jmp       ..B1.126      # Prob 100%                     #96.33
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm18
..B1.125:                       # Preds ..B1.123
                                # Execution count [1.25e+01]
        vmulss    %xmm16, %xmm20, %xmm12                        #100.43
        vmulss    %xmm16, %xmm21, %xmm13                        #101.43
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm18
..B1.126:                       # Preds ..B1.124 ..B1.125
                                # Execution count [2.50e+01]
        incq      24(%r12)                                      #103.29
        movb      $1, %dl                                       #102.29
        vaddss    %xmm18, %xmm2, %xmm2                          #99.29
        vaddss    %xmm12, %xmm1, %xmm1                          #100.29
        vaddss    %xmm13, %xmm0, %xmm0                          #101.29
        jmp       ..B1.129      # Prob 100%                     #101.29
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.127:                       # Preds ..B1.122
                                # Execution count [2.50e+01]
        incq      32(%r12)                                      #105.29
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.129:                       # Preds ..B1.127 ..B1.126 ..B1.121 ..B1.118
                                # Execution count [1.25e+01]
        testl     %eax, %eax                                    #77.28
        je        ..B1.132      # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.130:                       # Preds ..B1.129
                                # Execution count [5.00e+01]
        cmpl      %r10d, %r13d                                  #77.62
        jne       ..B1.134      # Prob 50%                      #77.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.131:                       # Preds ..B1.130
                                # Execution count [2.50e+01]
        cmpl      $7, %r9d                                      #77.99
        jl        ..B1.134      # Prob 50%                      #77.99
        jmp       ..B1.140      # Prob 100%                     #77.99
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.132:                       # Preds ..B1.129
                                # Execution count [5.00e+01]
        cmpl      %r10d, %r13d                                  #78.62
        jne       ..B1.134      # Prob 50%                      #78.62
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.133:                       # Preds ..B1.132
                                # Execution count [2.50e+01]
        cmpl      $7, %r9d                                      #78.100
        je        ..B1.140      # Prob 50%                      #78.100
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.134:                       # Preds ..B1.130 ..B1.131 ..B1.132 ..B1.133
                                # Execution count [5.00e+01]
        vsubss    60(%r8,%rdi), %xmm5, %xmm17                   #85.48
        vsubss    28(%r8,%rdi), %xmm6, %xmm16                   #84.48
        vsubss    92(%r8,%rdi), %xmm4, %xmm18                   #86.48
        vmulss    %xmm17, %xmm17, %xmm4                         #87.61
        vfmadd231ss %xmm16, %xmm16, %xmm4                       #87.75
        vfmadd231ss %xmm18, %xmm18, %xmm4                       #87.75
        vcomiss   %xmm4, %xmm11                                 #88.34
        jbe       ..B1.139      # Prob 50%                      #88.34
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm7 xmm8 xmm9 xmm10 xmm11 xmm16 xmm17 xmm18
..B1.135:                       # Preds ..B1.134
                                # Execution count [2.50e+01]
        vdivss    %xmm4, %xmm10, %xmm6                          #89.51
        vmulss    %xmm6, %xmm8, %xmm4                           #90.50
        vmulss    %xmm7, %xmm6, %xmm12                          #91.67
        vmulss    %xmm6, %xmm4, %xmm5                           #90.56
        vmulss    %xmm6, %xmm5, %xmm13                          #90.62
        vmulss    %xmm13, %xmm12, %xmm14                        #91.76
        vsubss    %xmm3, %xmm13, %xmm15                         #91.67
        vmulss    %xmm15, %xmm14, %xmm13                        #91.82
        vmulss    %xmm13, %xmm16, %xmm15                        #94.67
        testl     %eax, %eax                                    #93.32
        je        ..B1.137      # Prob 50%                      #93.32
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm15 xmm17 xmm18
..B1.136:                       # Preds ..B1.135
                                # Execution count [1.25e+01]
        vmovss    28(%r8,%rbx), %xmm4                           #94.33
        vmovss    60(%r8,%rbx), %xmm6                           #95.33
        vsubss    %xmm15, %xmm4, %xmm5                          #94.33
        vmulss    %xmm13, %xmm17, %xmm4                         #95.67
        vmovss    %xmm5, 28(%r8,%rbx)                           #94.33
        vsubss    %xmm4, %xmm6, %xmm12                          #95.33
        vmulss    %xmm13, %xmm18, %xmm5                         #96.67
        vmovss    92(%r8,%rbx), %xmm13                          #96.33
        vmovss    %xmm12, 60(%r8,%rbx)                          #95.33
        vsubss    %xmm5, %xmm13, %xmm14                         #96.33
        vmovss    %xmm14, 92(%r8,%rbx)                          #96.33
        jmp       ..B1.138      # Prob 100%                     #96.33
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm7 xmm8 xmm9 xmm10 xmm11 xmm15
..B1.137:                       # Preds ..B1.135
                                # Execution count [1.25e+01]
        vmulss    %xmm13, %xmm17, %xmm4                         #100.43
        vmulss    %xmm13, %xmm18, %xmm5                         #101.43
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm7 xmm8 xmm9 xmm10 xmm11 xmm15
..B1.138:                       # Preds ..B1.136 ..B1.137
                                # Execution count [2.50e+01]
        incq      24(%r12)                                      #103.29
        movb      $1, %dl                                       #102.29
        vaddss    %xmm15, %xmm2, %xmm2                          #99.29
        vaddss    %xmm4, %xmm1, %xmm1                           #100.29
        vaddss    %xmm5, %xmm0, %xmm0                           #101.29
        jmp       ..B1.141      # Prob 100%                     #101.29
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.139:                       # Preds ..B1.134
                                # Execution count [2.50e+01]
        incq      32(%r12)                                      #105.29
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.140:                       # Preds ..B1.131 ..B1.133 ..B1.139
                                # Execution count [7.50e+01]
        testb     %dl, %dl                                      #110.27
        je        ..B1.142      # Prob 50%                      #110.27
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.141:                       # Preds ..B1.138 ..B1.140
                                # Execution count [5.00e+01]
        incq      40(%r12)                                      #111.21
        jmp       ..B1.143      # Prob 100%                     #111.21
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.142:                       # Preds ..B1.140
                                # Execution count [5.00e+01]
        incq      48(%r12)                                      #113.21
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.143:                       # Preds ..B1.141 ..B1.142
                                # Execution count [1.00e+02]
        incb      %cl                                           #63.13
        incl      %r9d                                          #63.13
        vaddss    (%r14,%rsi,4), %xmm2, %xmm2                   #116.17
        vaddss    32(%r14,%rsi,4), %xmm1, %xmm1                 #117.17
        vaddss    64(%r14,%rsi,4), %xmm0, %xmm0                 #118.17
        vmovss    %xmm2, (%r14,%rsi,4)                          #116.17
        vmovss    %xmm1, 32(%r14,%rsi,4)                        #117.17
        vmovss    %xmm0, 64(%r14,%rsi,4)                        #118.17
        incq      %rsi                                          #63.13
        cmpb      $4, %cl                                       #63.13
        jb        ..B1.32       # Prob 75%                      #63.13
                                # LOE rbx rsi rdi r8 r11 r12 r14 eax r9d r10d r13d r15d dl cl xmm3 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.144:                       # Preds ..B1.143
                                # Execution count [2.50e+01]
        movq      112(%rsp), %rbx                               #[spill]
        incq      %rbx                                          #56.9
        movq      104(%rsp), %r12                               #[spill]
        movq      96(%rsp), %rdi                                #[spill]
        cmpq      %r12, %rbx                                    #56.9
        jb        ..B1.31       # Prob 82%                      #56.9
                                # LOE rbx rdi r11 r12 r14 eax r13d r15d xmm3 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.145:                       # Preds ..B1.144
                                # Execution count [4.50e+00]
        movq      48(%rsp), %rdx                                #[spill]
        movl      40(%rsp), %ecx                                #[spill]
        movq      24(%rsp), %rax                                #[spill]
        movq      16(%rsp), %rsi                                #[spill]
        movq      8(%rsp), %r8                                  #[spill]
        movq      80(%rsp), %r9                                 #[spill]
        movq      88(%rsp), %r10                                #[spill]
                                # LOE rax rdx rsi rdi r8 r9 r10 r12 ecx xmm3 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.146:                       # Preds ..B1.145 ..B1.29
                                # Execution count [5.00e+00]
        vxorpd    %xmm16, %xmm16, %xmm16                        #124.9
        addq      %r12, %rsi                                    #123.9
        vcvtsi2sd %r12d, %xmm16, %xmm16                         #124.9
        vmulsd    %xmm16, %xmm9, %xmm0                          #124.9
        incl      %ecx                                          #47.5
        vcvttsd2si %xmm0, %rbx                                  #124.9
        incq      %rdx                                          #47.5
        addq      %rbx, %rax                                    #124.9
        lea       (%rdi,%r8,4), %rdi                            #47.5
        cmpl      56(%rsp), %ecx                                #47.5[spill]
        jb        ..B1.29       # Prob 82%                      #47.5
                                # LOE rax rdx rsi rdi r8 r9 r10 ecx xmm3 xmm7 xmm8 xmm9 xmm10 xmm11
..B1.147:                       # Preds ..B1.146
                                # Execution count [9.00e-01]
        movq      72(%rsp), %rbx                                #[spill]
        movq      %rax, 16(%rbx)                                #124.9
        movq      %rsi, 8(%rbx)                                 #123.9
                                # LOE r12
..B1.148:                       # Preds ..B1.25 ..B1.147
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.2, %edi                         #127.5
..___tag_value_computeForceLJ_ref.56:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #127.5
..___tag_value_computeForceLJ_ref.57:
                                # LOE r12
..B1.149:                       # Preds ..B1.148
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #130.16
..___tag_value_computeForceLJ_ref.58:
#       getTimeStamp()
        call      getTimeStamp                                  #130.16
..___tag_value_computeForceLJ_ref.59:
                                # LOE r12 xmm0
..B1.157:                       # Preds ..B1.149
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 8(%rsp)                                #130.16[spill]
                                # LOE r12
..B1.150:                       # Preds ..B1.157
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.3, %edi                         #131.5
        xorl      %eax, %eax                                    #131.5
..___tag_value_computeForceLJ_ref.61:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #131.5
..___tag_value_computeForceLJ_ref.62:
                                # LOE r12
..B1.151:                       # Preds ..B1.150
                                # Execution count [1.00e+00]
        vmovsd    8(%rsp), %xmm0                                #132.14[spill]
        vsubsd    (%rsp), %xmm0, %xmm0                          #132.14[spill]
        addq      $152, %rsp                                    #132.14
	.cfi_restore 3
        popq      %rbx                                          #132.14
	.cfi_restore 15
        popq      %r15                                          #132.14
	.cfi_restore 14
        popq      %r14                                          #132.14
	.cfi_restore 13
        popq      %r13                                          #132.14
	.cfi_restore 12
        popq      %r12                                          #132.14
        movq      %rbp, %rsp                                    #132.14
        popq      %rbp                                          #132.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #132.14
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B1.152:                       # Preds ..B1.5 ..B1.9
                                # Execution count [4.50e-01]: Infreq
        movl      %r12d, %r10d                                  #33.9
        jmp       ..B1.17       # Prob 100%                     #33.9
        .align    16,0x90
                                # LOE rax rbx rsi rdi r13 r14 r15 edx ecx r10d r11d r12d xmm0 xmm1 xmm2
	.cfi_endproc
# mark_end;
	.type	computeForceLJ_ref,@function
	.size	computeForceLJ_ref,.-computeForceLJ_ref
..LNcomputeForceLJ_ref.0:
	.data
# -- End  computeForceLJ_ref
	.text
.L_2__routine_start_computeForceLJ_2xnn_full_1:
# -- Begin  computeForceLJ_2xnn_full
	.text
# mark_begin;
       .align    16,0x90
	.globl computeForceLJ_2xnn_full
# --- computeForceLJ_2xnn_full(Parameter *, Atom *, Neighbor *, Stats *)
computeForceLJ_2xnn_full:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %rcx
..B2.1:                         # Preds ..B2.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForceLJ_2xnn_full.80:
..L81:
                                                         #287.97
        pushq     %rbp                                          #287.97
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #287.97
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #287.97
        pushq     %r12                                          #287.97
        pushq     %r13                                          #287.97
        pushq     %r14                                          #287.97
        pushq     %r15                                          #287.97
        pushq     %rbx                                          #287.97
        subq      $216, %rsp                                    #287.97
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
        movq      %rdi, %rbx                                    #287.97
        movl      $.L_2__STRING.4, %edi                         #288.5
        xorl      %eax, %eax                                    #288.5
        movq      %rcx, %r15                                    #287.97
        movq      %rdx, %r14                                    #287.97
        movq      %rsi, %r13                                    #287.97
..___tag_value_computeForceLJ_2xnn_full.90:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #288.5
..___tag_value_computeForceLJ_2xnn_full.91:
                                # LOE rbx r12 r13 r14 r15
..B2.2:                         # Preds ..B2.1
                                # Execution count [1.00e+00]
        vmovss    108(%rbx), %xmm0                              #291.27
        xorl      %edi, %edi                                    #301.5
        vmulss    %xmm0, %xmm0, %xmm1                           #294.36
        xorl      %ecx, %ecx                                    #303.27
        vbroadcastss 48(%rbx), %zmm3                            #295.32
        vbroadcastss 40(%rbx), %zmm4                            #296.29
        vbroadcastss %xmm1, %zmm2                               #294.36
        vmovups   %zmm3, 128(%rsp)                              #295.32[spill]
        vmovups   %zmm4, 64(%rsp)                               #296.29[spill]
        vmovups   %zmm2, (%rsp)                                 #294.36[spill]
        movl      20(%r13), %edx                                #301.26
        xorl      %ebx, %ebx                                    #301.5
        testl     %edx, %edx                                    #301.26
        jle       ..B2.23       # Prob 9%                       #301.26
                                # LOE rcx r12 r13 r14 r15 edx ebx edi
..B2.3:                         # Preds ..B2.2
                                # Execution count [9.00e-01]
        movq      176(%r13), %rsi                               #303.27
        movq      192(%r13), %rax                               #304.32
        vxorps    %xmm2, %xmm2, %xmm2                           #305.39
        vmovdqu   .L_2il0floatpacket.0(%rip), %xmm1             #304.9
        vmovdqu   .L_2il0floatpacket.1(%rip), %xmm0             #304.9
                                # LOE rax rcx rsi r13 r14 r15 edx ebx edi xmm0 xmm1 xmm2
..B2.4:                         # Preds ..B2.21 ..B2.3
                                # Execution count [5.00e+00]
        movl      %edi, %r8d                                    #302.27
        movl      %edi, %r9d                                    #302.27
        sarl      $1, %r8d                                      #302.27
        andl      $1, %r9d                                      #302.27
        shll      $2, %r9d                                      #302.27
        lea       (%r8,%r8,2), %r10d                            #302.27
        lea       (%r9,%r10,8), %r11d                           #302.27
        movslq    %r11d, %r11                                   #303.27
        lea       (%rsi,%r11,4), %r12                           #303.27
        movl      (%rcx,%rax), %r11d                            #304.32
        testl     %r11d, %r11d                                  #304.32
        jle       ..B2.21       # Prob 50%                      #304.32
                                # LOE rax rcx rsi r12 r13 r14 r15 edx ebx edi r11d xmm0 xmm1 xmm2
..B2.5:                         # Preds ..B2.4
                                # Execution count [4.50e+00]
        cmpl      $8, %r11d                                     #304.9
        jl        ..B2.37       # Prob 10%                      #304.9
                                # LOE rax rcx rsi r12 r13 r14 r15 edx ebx edi r11d xmm0 xmm1 xmm2
..B2.6:                         # Preds ..B2.5
                                # Execution count [4.50e+00]
        lea       64(%r12), %r8                                 #307.13
        andq      $15, %r8                                      #304.9
        testl     $3, %r8d                                      #304.9
        je        ..B2.8        # Prob 50%                      #304.9
                                # LOE rax rcx rsi r12 r13 r14 r15 edx ebx edi r8d r11d xmm0 xmm1 xmm2
..B2.7:                         # Preds ..B2.6
                                # Execution count [2.25e+00]
        movl      %ebx, %r8d                                    #304.9
        jmp       ..B2.9        # Prob 100%                     #304.9
                                # LOE rax rcx rsi r8 r12 r13 r14 r15 edx ebx edi r11d xmm0 xmm1 xmm2
..B2.8:                         # Preds ..B2.6
                                # Execution count [2.25e+00]
        movl      %r8d, %r9d                                    #304.9
        negl      %r9d                                          #304.9
        addl      $16, %r9d                                     #304.9
        shrl      $2, %r9d                                      #304.9
        testl     %r8d, %r8d                                    #304.9
        cmovne    %r9d, %r8d                                    #304.9
                                # LOE rax rcx rsi r8 r12 r13 r14 r15 edx ebx edi r11d xmm0 xmm1 xmm2
..B2.9:                         # Preds ..B2.7 ..B2.8
                                # Execution count [4.50e+00]
        lea       8(%r8), %r9d                                  #304.9
        cmpl      %r9d, %r11d                                   #304.9
        jl        ..B2.37       # Prob 10%                      #304.9
                                # LOE rax rcx rsi r8 r12 r13 r14 r15 edx ebx edi r11d xmm0 xmm1 xmm2
..B2.10:                        # Preds ..B2.9
                                # Execution count [5.00e+00]
        movl      %r11d, %r10d                                  #304.9
        xorl      %r9d, %r9d                                    #304.9
        subl      %r8d, %r10d                                   #304.9
        andl      $7, %r10d                                     #304.9
        negl      %r10d                                         #304.9
        addl      %r11d, %r10d                                  #304.9
        cmpl      $1, %r8d                                      #304.9
        jb        ..B2.14       # Prob 10%                      #304.9
                                # LOE rax rcx rsi r8 r9 r12 r13 r14 r15 edx ebx edi r10d r11d xmm0 xmm1 xmm2
..B2.12:                        # Preds ..B2.10 ..B2.12
                                # Execution count [2.50e+01]
        movl      %ebx, (%r12,%r9,4)                            #305.13
        movl      %ebx, 32(%r12,%r9,4)                          #306.13
        movl      %ebx, 64(%r12,%r9,4)                          #307.13
        incq      %r9                                           #304.9
        cmpq      %r8, %r9                                      #304.9
        jb        ..B2.12       # Prob 82%                      #304.9
                                # LOE rax rcx rsi r8 r9 r12 r13 r14 r15 edx ebx edi r10d r11d xmm0 xmm1 xmm2
..B2.14:                        # Preds ..B2.12 ..B2.10
                                # Execution count [4.50e+00]
        movslq    %r10d, %r9                                    #304.9
                                # LOE rax rcx rsi r8 r9 r12 r13 r14 r15 edx ebx edi r10d r11d xmm0 xmm1 xmm2
..B2.15:                        # Preds ..B2.15 ..B2.14
                                # Execution count [2.50e+01]
        vmovups   %xmm2, (%r12,%r8,4)                           #305.13
        vmovups   %xmm2, 32(%r12,%r8,4)                         #306.13
        vmovups   %xmm2, 64(%r12,%r8,4)                         #307.13
        vmovups   %xmm2, 16(%r12,%r8,4)                         #305.13
        vmovups   %xmm2, 48(%r12,%r8,4)                         #306.13
        vmovups   %xmm2, 80(%r12,%r8,4)                         #307.13
        addq      $8, %r8                                       #304.9
        cmpq      %r9, %r8                                      #304.9
        jb        ..B2.15       # Prob 82%                      #304.9
                                # LOE rax rcx rsi r8 r9 r12 r13 r14 r15 edx ebx edi r10d r11d xmm0 xmm1 xmm2
..B2.17:                        # Preds ..B2.15 ..B2.37
                                # Execution count [5.00e+00]
        lea       1(%r10), %r8d                                 #304.9
        cmpl      %r11d, %r8d                                   #304.9
        ja        ..B2.21       # Prob 50%                      #304.9
                                # LOE rax rcx rsi r12 r13 r14 r15 edx ebx edi r10d r11d xmm0 xmm1 xmm2
..B2.18:                        # Preds ..B2.17
                                # Execution count [4.50e+00]
        movslq    %r10d, %r9                                    #305.13
        negl      %r10d                                         #304.9
        addl      %r11d, %r10d                                  #304.9
        xorl      %r8d, %r8d                                    #304.9
        movslq    %r11d, %r11                                   #304.9
        vmovdqa   %xmm0, %xmm4                                  #304.9
        vpbroadcastd %r10d, %xmm3                               #304.9
        subq      %r9, %r11                                     #304.9
        lea       (%r12,%r9,4), %r12                            #305.13
                                # LOE rax rcx rsi r8 r11 r12 r13 r14 r15 edx ebx edi xmm0 xmm1 xmm2 xmm3 xmm4
..B2.19:                        # Preds ..B2.19 ..B2.18
                                # Execution count [2.50e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #304.9
        vpaddd    %xmm1, %xmm4, %xmm4                           #304.9
        vmovups   %xmm2, (%r12,%r8,4){%k1}                      #305.13
        vmovups   %xmm2, 32(%r12,%r8,4){%k1}                    #306.13
        vmovups   %xmm2, 64(%r12,%r8,4){%k1}                    #307.13
        addq      $4, %r8                                       #304.9
        cmpq      %r11, %r8                                     #304.9
        jb        ..B2.19       # Prob 82%                      #304.9
                                # LOE rax rcx rsi r8 r11 r12 r13 r14 r15 edx ebx edi xmm0 xmm1 xmm2 xmm3 xmm4
..B2.21:                        # Preds ..B2.19 ..B2.4 ..B2.17
                                # Execution count [5.00e+00]
        incl      %edi                                          #301.5
        addq      $28, %rcx                                     #301.5
        cmpl      %edx, %edi                                    #301.5
        jb        ..B2.4        # Prob 82%                      #301.5
                                # LOE rax rcx rsi r13 r14 r15 edx ebx edi xmm0 xmm1 xmm2
..B2.23:                        # Preds ..B2.21 ..B2.2
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #311.16
        vzeroupper                                              #311.16
..___tag_value_computeForceLJ_2xnn_full.95:
#       getTimeStamp()
        call      getTimeStamp                                  #311.16
..___tag_value_computeForceLJ_2xnn_full.96:
                                # LOE r12 r13 r14 r15 ebx xmm0
..B2.41:                        # Preds ..B2.23
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 192(%rsp)                              #311.16[spill]
                                # LOE r12 r13 r14 r15 ebx
..B2.24:                        # Preds ..B2.41
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.2, %edi                         #315.5
..___tag_value_computeForceLJ_2xnn_full.98:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #315.5
..___tag_value_computeForceLJ_2xnn_full.99:
                                # LOE r12 r13 r14 r15 ebx
..B2.25:                        # Preds ..B2.24
                                # Execution count [1.00e+00]
        movl      %ebx, %r9d                                    #318.16
        xorl      %r10d, %r10d                                  #318.16
        cmpl      $0, 20(%r13)                                  #318.26
        jle       ..B2.33       # Prob 10%                      #318.26
                                # LOE r10 r12 r13 r14 r15 ebx r9d
..B2.26:                        # Preds ..B2.25
                                # Execution count [9.00e-01]
        movl      $4369, %eax                                   #406.9
        kmovw     %eax, %k1                                     #406.9
        vmovups   .L_2il0floatpacket.7(%rip), %zmm28            #406.9
        vmovups   .L_2il0floatpacket.6(%rip), %zmm24            #406.9
        vmovups   64(%rsp), %zmm25                              #406.9[spill]
        vmovups   128(%rsp), %zmm26                             #406.9[spill]
        vmovups   (%rsp), %zmm27                                #406.9[spill]
        vpxord    %zmm8, %zmm8, %zmm8                           #335.30
                                # LOE r10 r13 r14 r15 ebx r9d zmm8 zmm24 zmm25 zmm26 zmm27 zmm28 k1
..B2.27:                        # Preds ..B2.31 ..B2.26
                                # Execution count [5.00e+00]
        movl      %r9d, %eax                                    #323.27
        movl      %r9d, %ecx                                    #323.27
        sarl      $1, %eax                                      #323.27
        andl      $1, %ecx                                      #323.27
        shll      $2, %ecx                                      #323.27
        movl      16(%r14), %edi                                #326.44
        imull     %r9d, %edi                                    #326.44
        movq      160(%r13), %rsi                               #324.27
        lea       (%rax,%rax,2), %edx                           #323.27
        vmovaps   %zmm8, %zmm16                                 #335.30
        lea       (%rcx,%rdx,8), %eax                           #323.27
        movslq    %eax, %rax                                    #323.27
        vmovaps   %zmm16, %zmm15                                #336.30
        movslq    %edi, %rdi                                    #326.19
        vmovaps   %zmm15, %zmm14                                #337.30
        movq      8(%r14), %r8                                  #326.19
        movq      24(%r14), %r11                                #327.25
        vbroadcastss 4(%rsi,%rax,4), %zmm21                     #329.33
        vbroadcastss 12(%rsi,%rax,4), %zmm19                    #330.33
        vbroadcastss 36(%rsi,%rax,4), %zmm17                    #331.33
        vbroadcastss 44(%rsi,%rax,4), %zmm1                     #332.33
        vbroadcastss 68(%rsi,%rax,4), %zmm3                     #333.33
        vbroadcastss 76(%rsi,%rax,4), %zmm5                     #334.33
        vbroadcastss 32(%rsi,%rax,4), %zmm0                     #331.33
        vbroadcastss (%rsi,%rax,4), %zmm20                      #329.33
        vbroadcastss 8(%rsi,%rax,4), %zmm18                     #330.33
        vbroadcastss 40(%rsi,%rax,4), %zmm2                     #332.33
        vbroadcastss 64(%rsi,%rax,4), %zmm4                     #333.33
        vbroadcastss 72(%rsi,%rax,4), %zmm6                     #334.33
        vmovaps   %zmm14, %zmm13                                #338.30
        lea       (%r8,%rdi,4), %rdx                            #326.19
        vmovaps   %zmm13, %zmm12                                #339.30
        xorl      %r8d, %r8d                                    #342.19
        movslq    (%r11,%r10,4), %rdi                           #327.25
        vmovaps   %zmm12, %zmm22                                #340.30
        movq      176(%r13), %rcx                               #325.27
        vinsertf64x4 $1, %ymm21, %zmm20, %zmm21                 #329.33
        vinsertf64x4 $1, %ymm19, %zmm18, %zmm20                 #330.33
        vinsertf64x4 $1, %ymm17, %zmm0, %zmm19                  #331.33
        vinsertf64x4 $1, %ymm1, %zmm2, %zmm18                   #332.33
        vinsertf64x4 $1, %ymm3, %zmm4, %zmm17                   #333.33
        vinsertf64x4 $1, %ymm5, %zmm6, %zmm23                   #334.33
        testq     %rdi, %rdi                                    #342.28
        jle       ..B2.31       # Prob 10%                      #342.28
                                # LOE rax rdx rcx rsi rdi r8 r10 r13 r14 r15 ebx r9d zmm8 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 k1
..B2.28:                        # Preds ..B2.27
                                # Execution count [4.50e+00]
        movq      %r13, 16(%rsp)                                #[spill]
        movq      %r14, 8(%rsp)                                 #[spill]
        movq      %r15, (%rsp)                                  #[spill]
                                # LOE rax rdx rcx rsi rdi r8 r10 ebx r9d zmm8 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 k1
..B2.29:                        # Preds ..B2.29 ..B2.28
                                # Execution count [2.50e+01]
        movl      (%rdx,%r8,4), %r13d                           #343.22
        incq      %r8                                           #342.39
        lea       (%r13,%r13,2), %r14d                          #344.31
        shll      $3, %r14d                                     #344.31
        lea       (%r13,%r13), %r15d                            #365.56
        movslq    %r14d, %r14                                   #345.31
        cmpl      %r9d, %r15d                                   #365.66
        lea       1(%r13,%r13), %r11d                           #366.61
        movl      %ebx, %r13d                                   #365.66
        sete      %r13b                                         #365.66
        cmpl      %r9d, %r11d                                   #366.66
        movl      %ebx, %r11d                                   #366.66
        vbroadcastf64x4 64(%rsi,%r14,4), %zmm31                 #350.36
        sete      %r11b                                         #366.66
        vbroadcastf64x4 32(%rsi,%r14,4), %zmm30                 #349.36
        vbroadcastf64x4 (%rsi,%r14,4), %zmm29                   #348.36
        vsubps    %zmm31, %zmm17, %zmm10                        #353.35
        vsubps    %zmm31, %zmm23, %zmm5                         #356.35
        vsubps    %zmm30, %zmm19, %zmm9                         #352.35
        vsubps    %zmm30, %zmm18, %zmm6                         #355.35
        vsubps    %zmm29, %zmm21, %zmm11                        #351.35
        vsubps    %zmm29, %zmm20, %zmm7                         #354.35
        vmulps    %zmm10, %zmm10, %zmm0                         #383.80
        vmulps    %zmm5, %zmm5, %zmm1                           #384.80
        vfmadd231ps %zmm9, %zmm9, %zmm0                         #383.57
        vfmadd231ps %zmm6, %zmm6, %zmm1                         #384.57
        vfmadd231ps %zmm11, %zmm11, %zmm0                       #383.34
        vfmadd231ps %zmm7, %zmm7, %zmm1                         #384.34
        vrcp14ps  %zmm0, %zmm4                                  #389.35
        vrcp14ps  %zmm1, %zmm3                                  #390.35
        vcmpps    $17, %zmm27, %zmm1, %k5                       #387.67
        vcmpps    $17, %zmm27, %zmm0, %k2                       #386.67
        vmulps    %zmm26, %zmm4, %zmm2                          #392.67
        vmulps    %zmm26, %zmm3, %zmm29                         #393.67
        vmulps    %zmm2, %zmm4, %zmm30                          #392.51
        vmulps    %zmm29, %zmm3, %zmm1                          #393.51
        vmulps    %zmm30, %zmm4, %zmm2                          #392.35
        vmulps    %zmm1, %zmm3, %zmm0                           #393.35
        vfmsub213ps %zmm28, %zmm4, %zmm30                       #395.79
        vfmsub213ps %zmm28, %zmm3, %zmm1                        #396.79
        vmulps    %zmm25, %zmm4, %zmm4                          #395.105
        vmulps    %zmm25, %zmm3, %zmm3                          #396.105
        vmulps    %zmm4, %zmm30, %zmm31                         #395.70
        vmulps    %zmm3, %zmm1, %zmm1                           #396.70
        vmulps    %zmm31, %zmm2, %zmm2                          #395.54
        vmulps    %zmm1, %zmm0, %zmm0                           #396.54
        vmulps    %zmm2, %zmm24, %zmm4                          #395.36
        vmulps    %zmm0, %zmm24, %zmm2                          #396.36
        movl      %r11d, %r14d                                  #380.39
        lea       (%r13,%r13), %r12d                            #380.39
        shll      $5, %r14d                                     #380.39
        negl      %r12d                                         #380.39
        subl      %r14d, %r12d                                  #380.39
        movl      %r13d, %r14d                                  #380.39
        movl      %r11d, %r15d                                  #380.39
        negl      %r14d                                         #380.39
        shll      $4, %r15d                                     #380.39
        shll      $8, %r12d                                     #380.39
        subl      %r15d, %r14d                                  #380.39
        addl      $-256, %r12d                                  #380.39
        addl      $255, %r14d                                   #380.39
        orl       %r14d, %r12d                                  #380.39
        lea       (,%r13,8), %r14d                              #381.39
        kmovw     %r12d, %k0                                    #386.41
        movl      %r11d, %r12d                                  #381.39
        shll      $2, %r13d                                     #381.39
        negl      %r14d                                         #381.39
        shll      $7, %r12d                                     #381.39
        negl      %r13d                                         #381.39
        shll      $6, %r11d                                     #381.39
        subl      %r12d, %r14d                                  #381.39
        shll      $8, %r14d                                     #381.39
        subl      %r11d, %r13d                                  #381.39
        addl      $-256, %r14d                                  #381.39
        addl      $255, %r13d                                   #381.39
        orl       %r13d, %r14d                                  #381.39
        kmovw     %r14d, %k4                                    #387.41
        kandw     %k2, %k0, %k3                                 #386.41
        kandw     %k5, %k4, %k6                                 #387.41
        vfmadd231ps %zmm11, %zmm4, %zmm16{%k3}                  #398.20
        vfmadd231ps %zmm9, %zmm4, %zmm15{%k3}                   #399.20
        vfmadd231ps %zmm10, %zmm4, %zmm14{%k3}                  #400.20
        vfmadd231ps %zmm7, %zmm2, %zmm13{%k6}                   #401.20
        vfmadd231ps %zmm6, %zmm2, %zmm12{%k6}                   #402.20
        vfmadd231ps %zmm5, %zmm2, %zmm22{%k6}                   #403.20
        cmpq      %rdi, %r8                                     #342.28
        jl        ..B2.29       # Prob 82%                      #342.28
                                # LOE rax rdx rcx rsi rdi r8 r10 ebx r9d zmm8 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 k1
..B2.30:                        # Preds ..B2.29
                                # Execution count [4.50e+00]
        movq      16(%rsp), %r13                                #[spill]
        movq      8(%rsp), %r14                                 #[spill]
        movq      (%rsp), %r15                                  #[spill]
                                # LOE rax rcx rdi r10 r13 r14 r15 ebx r9d zmm8 zmm12 zmm13 zmm14 zmm15 zmm16 zmm22 zmm24 zmm25 zmm26 zmm27 zmm28 k1
..B2.31:                        # Preds ..B2.30 ..B2.27
                                # Execution count [5.00e+00]
        vshuff32x4 $136, %zmm13, %zmm16, %zmm17                 #406.9
        incl      %r9d                                          #318.49
        vshuff32x4 $221, %zmm13, %zmm16, %zmm16                 #406.9
        vshuff32x4 $136, %zmm12, %zmm15, %zmm31                 #407.9
        vshuff32x4 $221, %zmm12, %zmm15, %zmm0                  #407.9
        vshuff32x4 $136, %zmm22, %zmm14, %zmm9                  #408.9
        vshuff32x4 $221, %zmm22, %zmm14, %zmm22                 #408.9
        vaddps    %zmm16, %zmm17, %zmm19                        #406.9
        vaddps    %zmm0, %zmm31, %zmm2                          #407.9
        vxorpd    %xmm0, %xmm0, %xmm0                           #412.9
        vaddps    %zmm22, %zmm9, %zmm11                         #408.9
        vpermilps $78, %zmm19, %zmm18                           #406.9
        incq      %r10                                          #318.49
        vpermilps $78, %zmm2, %zmm1                             #407.9
        vpermilps $78, %zmm11, %zmm10                           #408.9
        vaddps    %zmm19, %zmm18, %zmm21                        #406.9
        vaddps    %zmm2, %zmm1, %zmm4                           #407.9
        vaddps    %zmm11, %zmm10, %zmm13                        #408.9
        vpermilps $177, %zmm21, %zmm20                          #406.9
        vpermilps $177, %zmm4, %zmm3                            #407.9
        vpermilps $177, %zmm13, %zmm12                          #408.9
        vaddps    %zmm21, %zmm20, %zmm23                        #406.9
        vaddps    %zmm4, %zmm3, %zmm5                           #407.9
        vaddps    %zmm13, %zmm12, %zmm14                        #408.9
        vcompressps %zmm23, %zmm29{%k1}{z}                      #406.9
        vcompressps %zmm5, %zmm6{%k1}{z}                        #407.9
        vcompressps %zmm14, %zmm15{%k1}{z}                      #408.9
        vaddps    (%rcx,%rax,4), %xmm29, %xmm30                 #406.9
        vaddps    32(%rcx,%rax,4), %xmm6, %xmm7                 #407.9
        vaddps    64(%rcx,%rax,4), %xmm15, %xmm16               #408.9
        vmovups   %xmm30, (%rcx,%rax,4)                         #406.9
        vmovups   %xmm7, 32(%rcx,%rax,4)                        #407.9
        vmovups   %xmm16, 64(%rcx,%rax,4)                       #408.9
        addq      %rdi, 8(%r15)                                 #411.9
        vcvtsi2sd %edi, %xmm0, %xmm0                            #412.9
        vcvttsd2si %xmm0, %rax                                  #412.9
        incq      (%r15)                                        #410.9
        addq      %rax, 16(%r15)                                #412.9
        cmpl      20(%r13), %r9d                                #318.26
        jl        ..B2.27       # Prob 82%                      #318.26
                                # LOE r10 r13 r14 r15 ebx r9d zmm8 zmm24 zmm25 zmm26 zmm27 zmm28 k1
..B2.33:                        # Preds ..B2.31 ..B2.25
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.2, %edi                         #416.5
        vzeroupper                                              #416.5
..___tag_value_computeForceLJ_2xnn_full.109:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #416.5
..___tag_value_computeForceLJ_2xnn_full.110:
                                # LOE r12
..B2.34:                        # Preds ..B2.33
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #419.16
..___tag_value_computeForceLJ_2xnn_full.111:
#       getTimeStamp()
        call      getTimeStamp                                  #419.16
..___tag_value_computeForceLJ_2xnn_full.112:
                                # LOE r12 xmm0
..B2.42:                        # Preds ..B2.34
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, (%rsp)                                 #419.16[spill]
                                # LOE r12
..B2.35:                        # Preds ..B2.42
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.5, %edi                         #420.5
        xorl      %eax, %eax                                    #420.5
..___tag_value_computeForceLJ_2xnn_full.114:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #420.5
..___tag_value_computeForceLJ_2xnn_full.115:
                                # LOE r12
..B2.36:                        # Preds ..B2.35
                                # Execution count [1.00e+00]
        vmovsd    (%rsp), %xmm0                                 #421.14[spill]
        vsubsd    192(%rsp), %xmm0, %xmm0                       #421.14[spill]
        addq      $216, %rsp                                    #421.14
	.cfi_restore 3
        popq      %rbx                                          #421.14
	.cfi_restore 15
        popq      %r15                                          #421.14
	.cfi_restore 14
        popq      %r14                                          #421.14
	.cfi_restore 13
        popq      %r13                                          #421.14
	.cfi_restore 12
        popq      %r12                                          #421.14
        movq      %rbp, %rsp                                    #421.14
        popq      %rbp                                          #421.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #421.14
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B2.37:                        # Preds ..B2.5 ..B2.9
                                # Execution count [4.50e-01]: Infreq
        movl      %ebx, %r10d                                   #304.9
        jmp       ..B2.17       # Prob 100%                     #304.9
        .align    16,0x90
                                # LOE rax rcx rsi r12 r13 r14 r15 edx ebx edi r10d r11d xmm0 xmm1 xmm2
	.cfi_endproc
# mark_end;
	.type	computeForceLJ_2xnn_full,@function
	.size	computeForceLJ_2xnn_full,.-computeForceLJ_2xnn_full
..LNcomputeForceLJ_2xnn_full.1:
	.data
# -- End  computeForceLJ_2xnn_full
	.text
.L_2__routine_start_computeForceLJ_2xnn_2:
# -- Begin  computeForceLJ_2xnn
	.text
# mark_begin;
       .align    16,0x90
	.globl computeForceLJ_2xnn
# --- computeForceLJ_2xnn(Parameter *, Atom *, Neighbor *, Stats *)
computeForceLJ_2xnn:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %rcx
..B3.1:                         # Preds ..B3.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForceLJ_2xnn.133:
..L134:
                                                        #424.92
        pushq     %rbp                                          #424.92
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #424.92
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #424.92
        pushq     %r13                                          #424.92
        pushq     %r14                                          #424.92
        pushq     %r15                                          #424.92
        pushq     %rbx                                          #424.92
        subq      $224, %rsp                                    #424.92
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
        movq      %rdx, %r14                                    #424.92
        movq      %rcx, %r15                                    #424.92
        movq      %rsi, %r13                                    #424.92
        movq      %rdi, %rbx                                    #424.92
        cmpl      $0, 32(%r14)                                  #425.8
        je        ..B3.4        # Prob 50%                      #425.8
                                # LOE rbx r12 r13 r14 r15
..B3.2:                         # Preds ..B3.1
                                # Execution count [5.00e-01]
        movq      %rbx, %rdi                                    #426.16
        movq      %r13, %rsi                                    #426.16
        movq      %r14, %rdx                                    #426.16
        movq      %r15, %rcx                                    #426.16
        addq      $224, %rsp                                    #426.16
	.cfi_restore 3
        popq      %rbx                                          #426.16
	.cfi_restore 15
        popq      %r15                                          #426.16
	.cfi_restore 14
        popq      %r14                                          #426.16
	.cfi_restore 13
        popq      %r13                                          #426.16
        movq      %rbp, %rsp                                    #426.16
        popq      %rbp                                          #426.16
	.cfi_def_cfa 7, 8
	.cfi_restore 6
#       computeForceLJ_2xnn_half(Parameter *, Atom *, Neighbor *, Stats *)
        jmp       computeForceLJ_2xnn_half                      #426.16
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B3.4:                         # Preds ..B3.1
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.4, %edi                         #429.12
        xorl      %eax, %eax                                    #429.12
..___tag_value_computeForceLJ_2xnn.154:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #429.12
..___tag_value_computeForceLJ_2xnn.155:
                                # LOE rbx r12 r13 r14 r15
..B3.5:                         # Preds ..B3.4
                                # Execution count [5.00e-01]
        vmovss    108(%rbx), %xmm0                              #429.12
        xorl      %r10d, %r10d                                  #429.12
        vmulss    %xmm0, %xmm0, %xmm1                           #429.12
        xorl      %r8d, %r8d                                    #429.12
        vbroadcastss 48(%rbx), %zmm3                            #429.12
        vbroadcastss 40(%rbx), %zmm4                            #429.12
        vbroadcastss %xmm1, %zmm2                               #429.12
        vmovups   %zmm3, (%rsp)                                 #429.12[spill]
        vmovups   %zmm4, 128(%rsp)                              #429.12[spill]
        vmovups   %zmm2, 64(%rsp)                               #429.12[spill]
        movl      20(%r13), %edi                                #429.12
        xorl      %ebx, %ebx                                    #429.12
        testl     %edi, %edi                                    #429.12
        jle       ..B3.26       # Prob 9%                       #429.12
                                # LOE r8 r12 r13 r14 r15 ebx edi r10d
..B3.6:                         # Preds ..B3.5
                                # Execution count [4.50e-01]
        movq      176(%r13), %r9                                #429.12
        movq      192(%r13), %rax                               #429.12
        vxorps    %xmm2, %xmm2, %xmm2                           #429.12
        vmovdqu   .L_2il0floatpacket.0(%rip), %xmm1             #429.12
        vmovdqu   .L_2il0floatpacket.1(%rip), %xmm0             #429.12
        movq      %r12, 192(%rsp)                               #429.12[spill]
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x22
                                # LOE rax r8 r9 r13 r14 r15 ebx edi r10d xmm0 xmm1 xmm2
..B3.7:                         # Preds ..B3.24 ..B3.6
                                # Execution count [2.50e+00]
        movl      %r10d, %r11d                                  #429.12
        movl      %r10d, %r12d                                  #429.12
        sarl      $1, %r11d                                     #429.12
        andl      $1, %r12d                                     #429.12
        shll      $2, %r12d                                     #429.12
        movl      (%r8,%rax), %ecx                              #429.12
        lea       (%r11,%r11,2), %r11d                          #429.12
        lea       (%r12,%r11,8), %r11d                          #429.12
        movslq    %r11d, %r11                                   #429.12
        lea       (%r9,%r11,4), %rsi                            #429.12
        testl     %ecx, %ecx                                    #429.12
        jle       ..B3.24       # Prob 50%                      #429.12
                                # LOE rax rsi r8 r9 r13 r14 r15 ecx ebx edi r10d xmm0 xmm1 xmm2
..B3.8:                         # Preds ..B3.7
                                # Execution count [2.25e+00]
        cmpl      $8, %ecx                                      #429.12
        jl        ..B3.40       # Prob 10%                      #429.12
                                # LOE rax rsi r8 r9 r13 r14 r15 ecx ebx edi r10d xmm0 xmm1 xmm2
..B3.9:                         # Preds ..B3.8
                                # Execution count [2.25e+00]
        lea       64(%rsi), %r11                                #429.12
        andq      $15, %r11                                     #429.12
        testl     $3, %r11d                                     #429.12
        je        ..B3.11       # Prob 50%                      #429.12
                                # LOE rax rsi r8 r9 r13 r14 r15 ecx ebx edi r10d r11d xmm0 xmm1 xmm2
..B3.10:                        # Preds ..B3.9
                                # Execution count [1.12e+00]
        movl      %ebx, %r11d                                   #429.12
        jmp       ..B3.12       # Prob 100%                     #429.12
                                # LOE rax rsi r8 r9 r11 r13 r14 r15 ecx ebx edi r10d xmm0 xmm1 xmm2
..B3.11:                        # Preds ..B3.9
                                # Execution count [1.12e+00]
        movl      %r11d, %r12d                                  #429.12
        negl      %r12d                                         #429.12
        addl      $16, %r12d                                    #429.12
        shrl      $2, %r12d                                     #429.12
        testl     %r11d, %r11d                                  #429.12
        cmovne    %r12d, %r11d                                  #429.12
                                # LOE rax rsi r8 r9 r11 r13 r14 r15 ecx ebx edi r10d xmm0 xmm1 xmm2
..B3.12:                        # Preds ..B3.10 ..B3.11
                                # Execution count [2.25e+00]
        lea       8(%r11), %r12d                                #429.12
        cmpl      %r12d, %ecx                                   #429.12
        jl        ..B3.40       # Prob 10%                      #429.12
                                # LOE rax rsi r8 r9 r11 r13 r14 r15 ecx ebx edi r10d xmm0 xmm1 xmm2
..B3.13:                        # Preds ..B3.12
                                # Execution count [2.50e+00]
        movl      %ecx, %edx                                    #429.12
        xorl      %r12d, %r12d                                  #429.12
        subl      %r11d, %edx                                   #429.12
        andl      $7, %edx                                      #429.12
        negl      %edx                                          #429.12
        addl      %ecx, %edx                                    #429.12
        cmpl      $1, %r11d                                     #429.12
        jb        ..B3.17       # Prob 10%                      #429.12
                                # LOE rax rsi r8 r9 r11 r12 r13 r14 r15 edx ecx ebx edi r10d xmm0 xmm1 xmm2
..B3.15:                        # Preds ..B3.13 ..B3.15
                                # Execution count [1.25e+01]
        movl      %ebx, (%rsi,%r12,4)                           #429.12
        movl      %ebx, 32(%rsi,%r12,4)                         #429.12
        movl      %ebx, 64(%rsi,%r12,4)                         #429.12
        incq      %r12                                          #429.12
        cmpq      %r11, %r12                                    #429.12
        jb        ..B3.15       # Prob 82%                      #429.12
                                # LOE rax rsi r8 r9 r11 r12 r13 r14 r15 edx ecx ebx edi r10d xmm0 xmm1 xmm2
..B3.17:                        # Preds ..B3.15 ..B3.13
                                # Execution count [2.25e+00]
        movslq    %edx, %r12                                    #429.12
                                # LOE rax rsi r8 r9 r11 r12 r13 r14 r15 edx ecx ebx edi r10d xmm0 xmm1 xmm2
..B3.18:                        # Preds ..B3.18 ..B3.17
                                # Execution count [1.25e+01]
        vmovups   %xmm2, (%rsi,%r11,4)                          #429.12
        vmovups   %xmm2, 32(%rsi,%r11,4)                        #429.12
        vmovups   %xmm2, 64(%rsi,%r11,4)                        #429.12
        vmovups   %xmm2, 16(%rsi,%r11,4)                        #429.12
        vmovups   %xmm2, 48(%rsi,%r11,4)                        #429.12
        vmovups   %xmm2, 80(%rsi,%r11,4)                        #429.12
        addq      $8, %r11                                      #429.12
        cmpq      %r12, %r11                                    #429.12
        jb        ..B3.18       # Prob 82%                      #429.12
                                # LOE rax rsi r8 r9 r11 r12 r13 r14 r15 edx ecx ebx edi r10d xmm0 xmm1 xmm2
..B3.20:                        # Preds ..B3.18 ..B3.40
                                # Execution count [2.50e+00]
        lea       1(%rdx), %r11d                                #429.12
        cmpl      %ecx, %r11d                                   #429.12
        ja        ..B3.24       # Prob 50%                      #429.12
                                # LOE rax rsi r8 r9 r13 r14 r15 edx ecx ebx edi r10d xmm0 xmm1 xmm2
..B3.21:                        # Preds ..B3.20
                                # Execution count [2.25e+00]
        movslq    %edx, %r12                                    #429.12
        negl      %edx                                          #429.12
        addl      %ecx, %edx                                    #429.12
        xorl      %r11d, %r11d                                  #429.12
        movslq    %ecx, %rcx                                    #429.12
        vmovdqa   %xmm0, %xmm4                                  #429.12
        vpbroadcastd %edx, %xmm3                                #429.12
        subq      %r12, %rcx                                    #429.12
        lea       (%rsi,%r12,4), %rsi                           #429.12
                                # LOE rax rcx rsi r8 r9 r11 r13 r14 r15 ebx edi r10d xmm0 xmm1 xmm2 xmm3 xmm4
..B3.22:                        # Preds ..B3.22 ..B3.21
                                # Execution count [1.25e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #429.12
        vpaddd    %xmm1, %xmm4, %xmm4                           #429.12
        vmovups   %xmm2, (%rsi,%r11,4){%k1}                     #429.12
        vmovups   %xmm2, 32(%rsi,%r11,4){%k1}                   #429.12
        vmovups   %xmm2, 64(%rsi,%r11,4){%k1}                   #429.12
        addq      $4, %r11                                      #429.12
        cmpq      %rcx, %r11                                    #429.12
        jb        ..B3.22       # Prob 82%                      #429.12
                                # LOE rax rcx rsi r8 r9 r11 r13 r14 r15 ebx edi r10d xmm0 xmm1 xmm2 xmm3 xmm4
..B3.24:                        # Preds ..B3.22 ..B3.7 ..B3.20
                                # Execution count [2.50e+00]
        incl      %r10d                                         #429.12
        addq      $28, %r8                                      #429.12
        cmpl      %edi, %r10d                                   #429.12
        jb        ..B3.7        # Prob 82%                      #429.12
                                # LOE rax r8 r9 r13 r14 r15 ebx edi r10d xmm0 xmm1 xmm2
..B3.25:                        # Preds ..B3.24
                                # Execution count [4.50e-01]
        movq      192(%rsp), %r12                               #[spill]
	.cfi_restore 12
                                # LOE r12 r13 r14 r15 ebx
..B3.26:                        # Preds ..B3.5 ..B3.25
                                # Execution count [5.00e-01]
        xorl      %eax, %eax                                    #429.12
        vzeroupper                                              #429.12
..___tag_value_computeForceLJ_2xnn.162:
#       getTimeStamp()
        call      getTimeStamp                                  #429.12
..___tag_value_computeForceLJ_2xnn.163:
                                # LOE r12 r13 r14 r15 ebx xmm0
..B3.45:                        # Preds ..B3.26
                                # Execution count [5.00e-01]
        vmovsd    %xmm0, 200(%rsp)                              #429.12[spill]
                                # LOE r12 r13 r14 r15 ebx
..B3.27:                        # Preds ..B3.45
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.2, %edi                         #429.12
..___tag_value_computeForceLJ_2xnn.165:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #429.12
..___tag_value_computeForceLJ_2xnn.166:
                                # LOE r12 r13 r14 r15 ebx
..B3.28:                        # Preds ..B3.27
                                # Execution count [5.00e-01]
        movl      %ebx, %edx                                    #429.12
        xorl      %ecx, %ecx                                    #429.12
        cmpl      $0, 20(%r13)                                  #429.12
        jle       ..B3.36       # Prob 10%                      #429.12
                                # LOE rcx r12 r13 r14 r15 edx ebx
..B3.29:                        # Preds ..B3.28
                                # Execution count [4.50e-01]
        movl      $4369, %eax                                   #429.12
        kmovw     %eax, %k1                                     #429.12
        vmovups   .L_2il0floatpacket.7(%rip), %zmm28            #429.12
        vmovups   .L_2il0floatpacket.6(%rip), %zmm24            #429.12
        vmovups   128(%rsp), %zmm25                             #429.12[spill]
        vmovups   (%rsp), %zmm26                                #429.12[spill]
        vmovups   64(%rsp), %zmm27                              #429.12[spill]
        movq      %r12, 192(%rsp)                               #429.12[spill]
        vpxord    %zmm8, %zmm8, %zmm8                           #429.12
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x22
                                # LOE rcx r13 r14 r15 edx ebx zmm8 zmm24 zmm25 zmm26 zmm27 zmm28 k1
..B3.30:                        # Preds ..B3.34 ..B3.29
                                # Execution count [2.50e+00]
        movl      %edx, %eax                                    #429.12
        movl      %edx, %r8d                                    #429.12
        sarl      $1, %eax                                      #429.12
        andl      $1, %r8d                                      #429.12
        shll      $2, %r8d                                      #429.12
        movl      16(%r14), %r10d                               #429.12
        imull     %edx, %r10d                                   #429.12
        movq      160(%r13), %r9                                #429.12
        lea       (%rax,%rax,2), %edi                           #429.12
        vmovaps   %zmm8, %zmm16                                 #429.12
        lea       (%r8,%rdi,8), %eax                            #429.12
        movslq    %eax, %rax                                    #429.12
        vmovaps   %zmm16, %zmm15                                #429.12
        movslq    %r10d, %r10                                   #429.12
        vmovaps   %zmm15, %zmm14                                #429.12
        movq      8(%r14), %r11                                 #429.12
        movq      24(%r14), %r12                                #429.12
        vbroadcastss 4(%r9,%rax,4), %zmm21                      #429.12
        vbroadcastss 12(%r9,%rax,4), %zmm19                     #429.12
        vbroadcastss 36(%r9,%rax,4), %zmm17                     #429.12
        vbroadcastss 44(%r9,%rax,4), %zmm1                      #429.12
        vbroadcastss 68(%r9,%rax,4), %zmm3                      #429.12
        vbroadcastss 76(%r9,%rax,4), %zmm5                      #429.12
        vbroadcastss 32(%r9,%rax,4), %zmm0                      #429.12
        vbroadcastss (%r9,%rax,4), %zmm20                       #429.12
        vbroadcastss 8(%r9,%rax,4), %zmm18                      #429.12
        vbroadcastss 40(%r9,%rax,4), %zmm2                      #429.12
        vbroadcastss 64(%r9,%rax,4), %zmm4                      #429.12
        vbroadcastss 72(%r9,%rax,4), %zmm6                      #429.12
        vmovaps   %zmm14, %zmm13                                #429.12
        lea       (%r11,%r10,4), %rdi                           #429.12
        vmovaps   %zmm13, %zmm12                                #429.12
        xorl      %r11d, %r11d                                  #429.12
        movslq    (%r12,%rcx,4), %r10                           #429.12
        vmovaps   %zmm12, %zmm22                                #429.12
        movq      176(%r13), %r8                                #429.12
        vinsertf64x4 $1, %ymm21, %zmm20, %zmm21                 #429.12
        vinsertf64x4 $1, %ymm19, %zmm18, %zmm20                 #429.12
        vinsertf64x4 $1, %ymm17, %zmm0, %zmm19                  #429.12
        vinsertf64x4 $1, %ymm1, %zmm2, %zmm18                   #429.12
        vinsertf64x4 $1, %ymm3, %zmm4, %zmm17                   #429.12
        vinsertf64x4 $1, %ymm5, %zmm6, %zmm23                   #429.12
        testq     %r10, %r10                                    #429.12
        jle       ..B3.34       # Prob 10%                      #429.12
                                # LOE rax rcx rdi r8 r9 r10 r11 r13 r14 r15 edx ebx zmm8 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 k1
..B3.31:                        # Preds ..B3.30
                                # Execution count [2.25e+00]
        movq      %r13, 16(%rsp)                                #[spill]
        movq      %r14, 8(%rsp)                                 #[spill]
        movq      %r15, (%rsp)                                  #[spill]
                                # LOE rax rcx rdi r8 r9 r10 r11 edx ebx zmm8 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 k1
..B3.32:                        # Preds ..B3.32 ..B3.31
                                # Execution count [1.25e+01]
        movl      (%rdi,%r11,4), %r13d                          #429.12
        incq      %r11                                          #429.12
        lea       (%r13,%r13,2), %r14d                          #429.12
        shll      $3, %r14d                                     #429.12
        lea       (%r13,%r13), %r15d                            #429.12
        movslq    %r14d, %r14                                   #429.12
        cmpl      %edx, %r15d                                   #429.12
        lea       1(%r13,%r13), %esi                            #429.12
        movl      %ebx, %r13d                                   #429.12
        sete      %r13b                                         #429.12
        cmpl      %edx, %esi                                    #429.12
        movl      %ebx, %esi                                    #429.12
        vbroadcastf64x4 64(%r9,%r14,4), %zmm31                  #429.12
        sete      %sil                                          #429.12
        vbroadcastf64x4 32(%r9,%r14,4), %zmm30                  #429.12
        vbroadcastf64x4 (%r9,%r14,4), %zmm29                    #429.12
        vsubps    %zmm31, %zmm17, %zmm10                        #429.12
        vsubps    %zmm31, %zmm23, %zmm5                         #429.12
        vsubps    %zmm30, %zmm19, %zmm9                         #429.12
        vsubps    %zmm30, %zmm18, %zmm6                         #429.12
        vsubps    %zmm29, %zmm21, %zmm11                        #429.12
        vsubps    %zmm29, %zmm20, %zmm7                         #429.12
        vmulps    %zmm10, %zmm10, %zmm0                         #429.12
        vmulps    %zmm5, %zmm5, %zmm1                           #429.12
        vfmadd231ps %zmm9, %zmm9, %zmm0                         #429.12
        vfmadd231ps %zmm6, %zmm6, %zmm1                         #429.12
        vfmadd231ps %zmm11, %zmm11, %zmm0                       #429.12
        vfmadd231ps %zmm7, %zmm7, %zmm1                         #429.12
        vrcp14ps  %zmm0, %zmm4                                  #429.12
        vrcp14ps  %zmm1, %zmm3                                  #429.12
        vcmpps    $17, %zmm27, %zmm1, %k5                       #429.12
        vcmpps    $17, %zmm27, %zmm0, %k2                       #429.12
        vmulps    %zmm4, %zmm26, %zmm2                          #429.12
        vmulps    %zmm3, %zmm26, %zmm29                         #429.12
        vmulps    %zmm2, %zmm4, %zmm30                          #429.12
        vmulps    %zmm29, %zmm3, %zmm1                          #429.12
        vmulps    %zmm30, %zmm4, %zmm2                          #429.12
        vmulps    %zmm1, %zmm3, %zmm0                           #429.12
        vfmsub213ps %zmm28, %zmm4, %zmm30                       #429.12
        vfmsub213ps %zmm28, %zmm3, %zmm1                        #429.12
        vmulps    %zmm4, %zmm25, %zmm4                          #429.12
        vmulps    %zmm3, %zmm25, %zmm3                          #429.12
        vmulps    %zmm4, %zmm30, %zmm31                         #429.12
        vmulps    %zmm3, %zmm1, %zmm1                           #429.12
        vmulps    %zmm31, %zmm2, %zmm2                          #429.12
        vmulps    %zmm1, %zmm0, %zmm0                           #429.12
        vmulps    %zmm2, %zmm24, %zmm4                          #429.12
        vmulps    %zmm0, %zmm24, %zmm2                          #429.12
        movl      %esi, %r14d                                   #429.12
        lea       (%r13,%r13), %r12d                            #429.12
        shll      $5, %r14d                                     #429.12
        negl      %r12d                                         #429.12
        subl      %r14d, %r12d                                  #429.12
        movl      %r13d, %r14d                                  #429.12
        movl      %esi, %r15d                                   #429.12
        negl      %r14d                                         #429.12
        shll      $4, %r15d                                     #429.12
        shll      $8, %r12d                                     #429.12
        subl      %r15d, %r14d                                  #429.12
        addl      $-256, %r12d                                  #429.12
        addl      $255, %r14d                                   #429.12
        orl       %r14d, %r12d                                  #429.12
        lea       (,%r13,8), %r14d                              #429.12
        kmovw     %r12d, %k0                                    #429.12
        movl      %esi, %r12d                                   #429.12
        shll      $2, %r13d                                     #429.12
        negl      %r14d                                         #429.12
        shll      $7, %r12d                                     #429.12
        negl      %r13d                                         #429.12
        shll      $6, %esi                                      #429.12
        subl      %r12d, %r14d                                  #429.12
        shll      $8, %r14d                                     #429.12
        subl      %esi, %r13d                                   #429.12
        addl      $-256, %r14d                                  #429.12
        addl      $255, %r13d                                   #429.12
        orl       %r13d, %r14d                                  #429.12
        kmovw     %r14d, %k4                                    #429.12
        kandw     %k2, %k0, %k3                                 #429.12
        kandw     %k5, %k4, %k6                                 #429.12
        vfmadd231ps %zmm11, %zmm4, %zmm16{%k3}                  #429.12
        vfmadd231ps %zmm9, %zmm4, %zmm15{%k3}                   #429.12
        vfmadd231ps %zmm10, %zmm4, %zmm14{%k3}                  #429.12
        vfmadd231ps %zmm7, %zmm2, %zmm13{%k6}                   #429.12
        vfmadd231ps %zmm6, %zmm2, %zmm12{%k6}                   #429.12
        vfmadd231ps %zmm5, %zmm2, %zmm22{%k6}                   #429.12
        cmpq      %r10, %r11                                    #429.12
        jl        ..B3.32       # Prob 82%                      #429.12
                                # LOE rax rcx rdi r8 r9 r10 r11 edx ebx zmm8 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 k1
..B3.33:                        # Preds ..B3.32
                                # Execution count [2.25e+00]
        movq      16(%rsp), %r13                                #[spill]
        movq      8(%rsp), %r14                                 #[spill]
        movq      (%rsp), %r15                                  #[spill]
                                # LOE rax rcx r8 r10 r13 r14 r15 edx ebx zmm8 zmm12 zmm13 zmm14 zmm15 zmm16 zmm22 zmm24 zmm25 zmm26 zmm27 zmm28 k1
..B3.34:                        # Preds ..B3.33 ..B3.30
                                # Execution count [2.50e+00]
        vshuff32x4 $136, %zmm13, %zmm16, %zmm17                 #429.12
        incl      %edx                                          #429.12
        vshuff32x4 $221, %zmm13, %zmm16, %zmm16                 #429.12
        vshuff32x4 $136, %zmm12, %zmm15, %zmm31                 #429.12
        vshuff32x4 $221, %zmm12, %zmm15, %zmm0                  #429.12
        vshuff32x4 $136, %zmm22, %zmm14, %zmm9                  #429.12
        vshuff32x4 $221, %zmm22, %zmm14, %zmm22                 #429.12
        vaddps    %zmm16, %zmm17, %zmm19                        #429.12
        vaddps    %zmm0, %zmm31, %zmm2                          #429.12
        vxorpd    %xmm0, %xmm0, %xmm0                           #429.12
        vaddps    %zmm22, %zmm9, %zmm11                         #429.12
        vpermilps $78, %zmm19, %zmm18                           #429.12
        incq      %rcx                                          #429.12
        vpermilps $78, %zmm2, %zmm1                             #429.12
        vpermilps $78, %zmm11, %zmm10                           #429.12
        vaddps    %zmm19, %zmm18, %zmm21                        #429.12
        vaddps    %zmm2, %zmm1, %zmm4                           #429.12
        vaddps    %zmm11, %zmm10, %zmm13                        #429.12
        vpermilps $177, %zmm21, %zmm20                          #429.12
        vpermilps $177, %zmm4, %zmm3                            #429.12
        vpermilps $177, %zmm13, %zmm12                          #429.12
        vaddps    %zmm21, %zmm20, %zmm23                        #429.12
        vaddps    %zmm4, %zmm3, %zmm5                           #429.12
        vaddps    %zmm13, %zmm12, %zmm14                        #429.12
        vcompressps %zmm23, %zmm29{%k1}{z}                      #429.12
        vcompressps %zmm5, %zmm6{%k1}{z}                        #429.12
        vcompressps %zmm14, %zmm15{%k1}{z}                      #429.12
        vaddps    (%r8,%rax,4), %xmm29, %xmm30                  #429.12
        vaddps    32(%r8,%rax,4), %xmm6, %xmm7                  #429.12
        vaddps    64(%r8,%rax,4), %xmm15, %xmm16                #429.12
        vmovups   %xmm30, (%r8,%rax,4)                          #429.12
        vmovups   %xmm7, 32(%r8,%rax,4)                         #429.12
        vmovups   %xmm16, 64(%r8,%rax,4)                        #429.12
        addq      %r10, 8(%r15)                                 #429.12
        vcvtsi2sd %r10d, %xmm0, %xmm0                           #429.12
        vcvttsd2si %xmm0, %rax                                  #429.12
        incq      (%r15)                                        #429.12
        addq      %rax, 16(%r15)                                #429.12
        cmpl      20(%r13), %edx                                #429.12
        jl        ..B3.30       # Prob 82%                      #429.12
                                # LOE rcx r13 r14 r15 edx ebx zmm8 zmm24 zmm25 zmm26 zmm27 zmm28 k1
..B3.35:                        # Preds ..B3.34
                                # Execution count [4.50e-01]
        movq      192(%rsp), %r12                               #[spill]
	.cfi_restore 12
                                # LOE r12
..B3.36:                        # Preds ..B3.35 ..B3.28
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.2, %edi                         #429.12
        vzeroupper                                              #429.12
..___tag_value_computeForceLJ_2xnn.179:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #429.12
..___tag_value_computeForceLJ_2xnn.180:
                                # LOE r12
..B3.37:                        # Preds ..B3.36
                                # Execution count [5.00e-01]
        xorl      %eax, %eax                                    #429.12
..___tag_value_computeForceLJ_2xnn.181:
#       getTimeStamp()
        call      getTimeStamp                                  #429.12
..___tag_value_computeForceLJ_2xnn.182:
                                # LOE r12 xmm0
..B3.46:                        # Preds ..B3.37
                                # Execution count [5.00e-01]
        vmovsd    %xmm0, (%rsp)                                 #429.12[spill]
                                # LOE r12
..B3.38:                        # Preds ..B3.46
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.5, %edi                         #429.12
        xorl      %eax, %eax                                    #429.12
..___tag_value_computeForceLJ_2xnn.184:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #429.12
..___tag_value_computeForceLJ_2xnn.185:
                                # LOE r12
..B3.39:                        # Preds ..B3.38
                                # Execution count [5.00e-01]
        vmovsd    (%rsp), %xmm0                                 #429.12[spill]
        vsubsd    200(%rsp), %xmm0, %xmm0                       #429.12[spill]
        addq      $224, %rsp                                    #429.12
	.cfi_restore 3
        popq      %rbx                                          #429.12
	.cfi_restore 15
        popq      %r15                                          #429.12
	.cfi_restore 14
        popq      %r14                                          #429.12
	.cfi_restore 13
        popq      %r13                                          #429.12
        movq      %rbp, %rsp                                    #429.12
        popq      %rbp                                          #429.12
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #429.12
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B3.40:                        # Preds ..B3.8 ..B3.12
                                # Execution count [2.25e-01]: Infreq
        movl      %ebx, %edx                                    #429.12
        jmp       ..B3.20       # Prob 100%                     #429.12
        .align    16,0x90
                                # LOE rax rsi r8 r9 r13 r14 r15 edx ecx ebx edi r10d xmm0 xmm1 xmm2
	.cfi_endproc
# mark_end;
	.type	computeForceLJ_2xnn,@function
	.size	computeForceLJ_2xnn,.-computeForceLJ_2xnn
..LNcomputeForceLJ_2xnn.2:
	.data
# -- End  computeForceLJ_2xnn
	.text
.L_2__routine_start_computeForceLJ_2xnn_half_3:
# -- Begin  computeForceLJ_2xnn_half
	.text
# mark_begin;
       .align    16,0x90
	.globl computeForceLJ_2xnn_half
# --- computeForceLJ_2xnn_half(Parameter *, Atom *, Neighbor *, Stats *)
computeForceLJ_2xnn_half:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %rcx
..B4.1:                         # Preds ..B4.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForceLJ_2xnn_half.202:
..L203:
                                                        #135.97
        pushq     %rbp                                          #135.97
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #135.97
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #135.97
        pushq     %r12                                          #135.97
        pushq     %r13                                          #135.97
        pushq     %r14                                          #135.97
        pushq     %r15                                          #135.97
        pushq     %rbx                                          #135.97
        subq      $216, %rsp                                    #135.97
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
        movq      %rdi, %rbx                                    #135.97
        movl      $.L_2__STRING.4, %edi                         #136.5
        xorl      %eax, %eax                                    #136.5
        movq      %rcx, %r15                                    #135.97
        movq      %rdx, %r14                                    #135.97
        movq      %rsi, %r13                                    #135.97
..___tag_value_computeForceLJ_2xnn_half.212:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #136.5
..___tag_value_computeForceLJ_2xnn_half.213:
                                # LOE rbx r12 r13 r14 r15
..B4.2:                         # Preds ..B4.1
                                # Execution count [1.00e+00]
        vmovss    108(%rbx), %xmm0                              #139.27
        xorl      %edi, %edi                                    #149.5
        vmulss    %xmm0, %xmm0, %xmm1                           #142.36
        xorl      %ecx, %ecx                                    #151.27
        vbroadcastss 48(%rbx), %zmm3                            #143.32
        vbroadcastss 40(%rbx), %zmm4                            #144.29
        vbroadcastss %xmm1, %zmm2                               #142.36
        vmovups   %zmm3, (%rsp)                                 #143.32[spill]
        vmovups   %zmm4, 128(%rsp)                              #144.29[spill]
        vmovups   %zmm2, 64(%rsp)                               #142.36[spill]
        movl      20(%r13), %edx                                #149.26
        xorl      %ebx, %ebx                                    #149.5
        testl     %edx, %edx                                    #149.26
        jle       ..B4.23       # Prob 9%                       #149.26
                                # LOE rcx r12 r13 r14 r15 edx ebx edi
..B4.3:                         # Preds ..B4.2
                                # Execution count [9.00e-01]
        movq      176(%r13), %rsi                               #151.27
        movq      192(%r13), %rax                               #152.32
        vxorps    %xmm2, %xmm2, %xmm2                           #153.39
        vmovdqu   .L_2il0floatpacket.0(%rip), %xmm1             #152.9
        vmovdqu   .L_2il0floatpacket.1(%rip), %xmm0             #152.9
                                # LOE rax rcx rsi r13 r14 r15 edx ebx edi xmm0 xmm1 xmm2
..B4.4:                         # Preds ..B4.21 ..B4.3
                                # Execution count [5.00e+00]
        movl      %edi, %r8d                                    #150.27
        movl      %edi, %r9d                                    #150.27
        sarl      $1, %r8d                                      #150.27
        andl      $1, %r9d                                      #150.27
        shll      $2, %r9d                                      #150.27
        lea       (%r8,%r8,2), %r10d                            #150.27
        lea       (%r9,%r10,8), %r11d                           #150.27
        movslq    %r11d, %r11                                   #151.27
        lea       (%rsi,%r11,4), %r12                           #151.27
        movl      (%rcx,%rax), %r11d                            #152.32
        testl     %r11d, %r11d                                  #152.32
        jle       ..B4.21       # Prob 50%                      #152.32
                                # LOE rax rcx rsi r12 r13 r14 r15 edx ebx edi r11d xmm0 xmm1 xmm2
..B4.5:                         # Preds ..B4.4
                                # Execution count [4.50e+00]
        cmpl      $8, %r11d                                     #152.9
        jl        ..B4.37       # Prob 10%                      #152.9
                                # LOE rax rcx rsi r12 r13 r14 r15 edx ebx edi r11d xmm0 xmm1 xmm2
..B4.6:                         # Preds ..B4.5
                                # Execution count [4.50e+00]
        lea       64(%r12), %r8                                 #155.13
        andq      $15, %r8                                      #152.9
        testl     $3, %r8d                                      #152.9
        je        ..B4.8        # Prob 50%                      #152.9
                                # LOE rax rcx rsi r12 r13 r14 r15 edx ebx edi r8d r11d xmm0 xmm1 xmm2
..B4.7:                         # Preds ..B4.6
                                # Execution count [2.25e+00]
        movl      %ebx, %r8d                                    #152.9
        jmp       ..B4.9        # Prob 100%                     #152.9
                                # LOE rax rcx rsi r8 r12 r13 r14 r15 edx ebx edi r11d xmm0 xmm1 xmm2
..B4.8:                         # Preds ..B4.6
                                # Execution count [2.25e+00]
        movl      %r8d, %r9d                                    #152.9
        negl      %r9d                                          #152.9
        addl      $16, %r9d                                     #152.9
        shrl      $2, %r9d                                      #152.9
        testl     %r8d, %r8d                                    #152.9
        cmovne    %r9d, %r8d                                    #152.9
                                # LOE rax rcx rsi r8 r12 r13 r14 r15 edx ebx edi r11d xmm0 xmm1 xmm2
..B4.9:                         # Preds ..B4.7 ..B4.8
                                # Execution count [4.50e+00]
        lea       8(%r8), %r9d                                  #152.9
        cmpl      %r9d, %r11d                                   #152.9
        jl        ..B4.37       # Prob 10%                      #152.9
                                # LOE rax rcx rsi r8 r12 r13 r14 r15 edx ebx edi r11d xmm0 xmm1 xmm2
..B4.10:                        # Preds ..B4.9
                                # Execution count [5.00e+00]
        movl      %r11d, %r10d                                  #152.9
        xorl      %r9d, %r9d                                    #152.9
        subl      %r8d, %r10d                                   #152.9
        andl      $7, %r10d                                     #152.9
        negl      %r10d                                         #152.9
        addl      %r11d, %r10d                                  #152.9
        cmpl      $1, %r8d                                      #152.9
        jb        ..B4.14       # Prob 10%                      #152.9
                                # LOE rax rcx rsi r8 r9 r12 r13 r14 r15 edx ebx edi r10d r11d xmm0 xmm1 xmm2
..B4.12:                        # Preds ..B4.10 ..B4.12
                                # Execution count [2.50e+01]
        movl      %ebx, (%r12,%r9,4)                            #153.13
        movl      %ebx, 32(%r12,%r9,4)                          #154.13
        movl      %ebx, 64(%r12,%r9,4)                          #155.13
        incq      %r9                                           #152.9
        cmpq      %r8, %r9                                      #152.9
        jb        ..B4.12       # Prob 82%                      #152.9
                                # LOE rax rcx rsi r8 r9 r12 r13 r14 r15 edx ebx edi r10d r11d xmm0 xmm1 xmm2
..B4.14:                        # Preds ..B4.12 ..B4.10
                                # Execution count [4.50e+00]
        movslq    %r10d, %r9                                    #152.9
                                # LOE rax rcx rsi r8 r9 r12 r13 r14 r15 edx ebx edi r10d r11d xmm0 xmm1 xmm2
..B4.15:                        # Preds ..B4.15 ..B4.14
                                # Execution count [2.50e+01]
        vmovups   %xmm2, (%r12,%r8,4)                           #153.13
        vmovups   %xmm2, 32(%r12,%r8,4)                         #154.13
        vmovups   %xmm2, 64(%r12,%r8,4)                         #155.13
        vmovups   %xmm2, 16(%r12,%r8,4)                         #153.13
        vmovups   %xmm2, 48(%r12,%r8,4)                         #154.13
        vmovups   %xmm2, 80(%r12,%r8,4)                         #155.13
        addq      $8, %r8                                       #152.9
        cmpq      %r9, %r8                                      #152.9
        jb        ..B4.15       # Prob 82%                      #152.9
                                # LOE rax rcx rsi r8 r9 r12 r13 r14 r15 edx ebx edi r10d r11d xmm0 xmm1 xmm2
..B4.17:                        # Preds ..B4.15 ..B4.37
                                # Execution count [5.00e+00]
        lea       1(%r10), %r8d                                 #152.9
        cmpl      %r11d, %r8d                                   #152.9
        ja        ..B4.21       # Prob 50%                      #152.9
                                # LOE rax rcx rsi r12 r13 r14 r15 edx ebx edi r10d r11d xmm0 xmm1 xmm2
..B4.18:                        # Preds ..B4.17
                                # Execution count [4.50e+00]
        movslq    %r10d, %r9                                    #153.13
        negl      %r10d                                         #152.9
        addl      %r11d, %r10d                                  #152.9
        xorl      %r8d, %r8d                                    #152.9
        movslq    %r11d, %r11                                   #152.9
        vmovdqa   %xmm0, %xmm4                                  #152.9
        vpbroadcastd %r10d, %xmm3                               #152.9
        subq      %r9, %r11                                     #152.9
        lea       (%r12,%r9,4), %r12                            #153.13
                                # LOE rax rcx rsi r8 r11 r12 r13 r14 r15 edx ebx edi xmm0 xmm1 xmm2 xmm3 xmm4
..B4.19:                        # Preds ..B4.19 ..B4.18
                                # Execution count [2.50e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #152.9
        vpaddd    %xmm1, %xmm4, %xmm4                           #152.9
        vmovups   %xmm2, (%r12,%r8,4){%k1}                      #153.13
        vmovups   %xmm2, 32(%r12,%r8,4){%k1}                    #154.13
        vmovups   %xmm2, 64(%r12,%r8,4){%k1}                    #155.13
        addq      $4, %r8                                       #152.9
        cmpq      %r11, %r8                                     #152.9
        jb        ..B4.19       # Prob 82%                      #152.9
                                # LOE rax rcx rsi r8 r11 r12 r13 r14 r15 edx ebx edi xmm0 xmm1 xmm2 xmm3 xmm4
..B4.21:                        # Preds ..B4.19 ..B4.4 ..B4.17
                                # Execution count [5.00e+00]
        incl      %edi                                          #149.5
        addq      $28, %rcx                                     #149.5
        cmpl      %edx, %edi                                    #149.5
        jb        ..B4.4        # Prob 82%                      #149.5
                                # LOE rax rcx rsi r13 r14 r15 edx ebx edi xmm0 xmm1 xmm2
..B4.23:                        # Preds ..B4.21 ..B4.2
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #159.16
        vzeroupper                                              #159.16
..___tag_value_computeForceLJ_2xnn_half.217:
#       getTimeStamp()
        call      getTimeStamp                                  #159.16
..___tag_value_computeForceLJ_2xnn_half.218:
                                # LOE r12 r13 r14 r15 ebx xmm0
..B4.41:                        # Preds ..B4.23
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 192(%rsp)                              #159.16[spill]
                                # LOE r12 r13 r14 r15 ebx
..B4.24:                        # Preds ..B4.41
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.2, %edi                         #163.5
..___tag_value_computeForceLJ_2xnn_half.220:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #163.5
..___tag_value_computeForceLJ_2xnn_half.221:
                                # LOE r12 r13 r14 r15 ebx
..B4.25:                        # Preds ..B4.24
                                # Execution count [1.00e+00]
        movl      %ebx, %r8d                                    #166.16
        xorl      %r10d, %r10d                                  #166.16
        cmpl      $0, 20(%r13)                                  #166.26
        jle       ..B4.33       # Prob 10%                      #166.26
                                # LOE r10 r12 r13 r14 r15 ebx r8d
..B4.26:                        # Preds ..B4.25
                                # Execution count [9.00e-01]
        movl      $4369, %eax                                   #270.9
        vmovsd    .L_2il0floatpacket.2(%rip), %xmm21            #276.9
        kmovw     %eax, %k1                                     #270.9
        vmovups   .L_2il0floatpacket.7(%rip), %zmm20            #270.9
        vmovups   .L_2il0floatpacket.6(%rip), %zmm16            #270.9
        vmovups   128(%rsp), %zmm17                             #270.9[spill]
        vmovups   (%rsp), %zmm18                                #270.9[spill]
        vmovups   64(%rsp), %zmm19                              #270.9[spill]
        vpxord    %zmm1, %zmm1, %zmm1                           #183.30
                                # LOE r10 r13 r14 r15 ebx r8d xmm21 zmm1 zmm16 zmm17 zmm18 zmm19 zmm20 k1
..B4.27:                        # Preds ..B4.31 ..B4.26
                                # Execution count [5.00e+00]
        movl      %r8d, %ecx                                    #171.27
        movl      %r8d, %edi                                    #171.27
        sarl      $1, %ecx                                      #171.27
        andl      $1, %edi                                      #171.27
        shll      $2, %edi                                      #171.27
        movl      16(%r14), %edx                                #174.44
        imull     %r8d, %edx                                    #174.44
        movq      160(%r13), %r11                               #172.27
        lea       (%rcx,%rcx,2), %r9d                           #171.27
        vmovaps   %zmm1, %zmm22                                 #183.30
        lea       (%rdi,%r9,8), %r9d                            #171.27
        movslq    %r9d, %r9                                     #171.27
        vmovaps   %zmm22, %zmm23                                #184.30
        movslq    %edx, %rdx                                    #174.19
        vmovaps   %zmm23, %zmm24                                #185.30
        movq      24(%r14), %rsi                                #175.25
        vbroadcastss 4(%r11,%r9,4), %zmm13                      #177.33
        vbroadcastss 12(%r11,%r9,4), %zmm11                     #178.33
        vbroadcastss 36(%r11,%r9,4), %zmm9                      #179.33
        vbroadcastss 44(%r11,%r9,4), %zmm2                      #180.33
        vbroadcastss 68(%r11,%r9,4), %zmm4                      #181.33
        vbroadcastss 76(%r11,%r9,4), %zmm6                      #182.33
        vbroadcastss 32(%r11,%r9,4), %zmm0                      #179.33
        vbroadcastss (%r11,%r9,4), %zmm12                       #177.33
        vbroadcastss 8(%r11,%r9,4), %zmm10                      #178.33
        vbroadcastss 40(%r11,%r9,4), %zmm3                      #180.33
        vbroadcastss 64(%r11,%r9,4), %zmm5                      #181.33
        vbroadcastss 72(%r11,%r9,4), %zmm7                      #182.33
        movq      8(%r14), %rax                                 #174.19
        vmovaps   %zmm24, %zmm25                                #186.30
        vmovaps   %zmm25, %zmm26                                #187.30
        movslq    (%rsi,%r10,4), %rsi                           #175.25
        lea       (%rax,%rdx,4), %rdx                           #174.19
        movq      176(%r13), %rcx                               #173.27
        movq      %rcx, %rdi                                    #173.27
        vmovaps   %zmm26, %zmm14                                #188.30
        xorl      %eax, %eax                                    #190.19
        vinsertf64x4 $1, %ymm13, %zmm12, %zmm13                 #177.33
        vinsertf64x4 $1, %ymm11, %zmm10, %zmm12                 #178.33
        vinsertf64x4 $1, %ymm9, %zmm0, %zmm11                   #179.33
        vinsertf64x4 $1, %ymm2, %zmm3, %zmm10                   #180.33
        vinsertf64x4 $1, %ymm4, %zmm5, %zmm9                    #181.33
        vinsertf64x4 $1, %ymm6, %zmm7, %zmm6                    #182.33
        testq     %rsi, %rsi                                    #190.28
        jle       ..B4.31       # Prob 10%                      #190.28
                                # LOE rax rdx rcx rsi rdi r9 r10 r11 r13 r14 r15 ebx r8d xmm21 zmm1 zmm6 zmm9 zmm10 zmm11 zmm12 zmm13 zmm14 zmm16 zmm17 zmm18 zmm19 zmm20 zmm22 zmm23 zmm24 zmm25 zmm26 k1
..B4.28:                        # Preds ..B4.27
                                # Execution count [4.50e+00]
        vmovups   .L_2il0floatpacket.8(%rip), %zmm15            #266.13
        movq      %r9, 24(%rsp)                                 #266.13[spill]
        movq      %r10, 16(%rsp)                                #266.13[spill]
        movq      %r14, 8(%rsp)                                 #266.13[spill]
        movq      %r15, (%rsp)                                  #266.13[spill]
                                # LOE rax rdx rcx rsi rdi r11 r13 ebx r8d xmm21 zmm1 zmm6 zmm9 zmm10 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm22 zmm23 zmm24 zmm25 zmm26 k1
..B4.29:                        # Preds ..B4.43 ..B4.28
                                # Execution count [2.50e+01]
        movl      (%rdx,%rax,4), %r15d                          #191.22
        movl      %ebx, %r12d                                   #214.66
        movslq    %r15d, %r15                                   #192.31
        incq      %rax                                          #190.39
        lea       (%r15,%r15), %r9d                             #214.56
        cmpl      %r8d, %r9d                                    #214.66
        sete      %r12b                                         #214.66
        lea       (%r15,%r15,2), %r14                           #193.31
        shlq      $5, %r14                                      #193.31
        lea       (%r12,%r12,2), %r10d                          #229.39
        vbroadcastf64x4 64(%r14,%r11), %zmm28                   #199.36
        negl      %r10d                                         #229.39
        vbroadcastf64x4 (%r14,%r11), %zmm3                      #197.36
        vbroadcastf64x4 32(%r14,%r11), %zmm27                   #198.36
        vsubps    %zmm28, %zmm9, %zmm5                          #202.35
        vsubps    %zmm28, %zmm6, %zmm4                          #205.35
        vsubps    %zmm3, %zmm13, %zmm0                          #200.35
        vsubps    %zmm27, %zmm11, %zmm7                         #201.35
        vsubps    %zmm3, %zmm12, %zmm8                          #203.35
        vsubps    %zmm27, %zmm10, %zmm3                         #204.35
        vmulps    %zmm5, %zmm5, %zmm31                          #232.80
        vmulps    %zmm4, %zmm4, %zmm30                          #233.80
        vfmadd231ps %zmm7, %zmm7, %zmm31                        #232.57
        vfmadd231ps %zmm3, %zmm3, %zmm30                        #233.57
        vfmadd231ps %zmm0, %zmm0, %zmm31                        #232.34
        vfmadd231ps %zmm8, %zmm8, %zmm30                        #233.34
        vrcp14ps  %zmm31, %zmm29                                #238.35
        vrcp14ps  %zmm30, %zmm27                                #239.35
        vcmpps    $17, %zmm19, %zmm30, %k5                      #236.67
        vcmpps    $17, %zmm19, %zmm31, %k2                      #235.67
        vmulps    %zmm18, %zmm29, %zmm2                         #241.67
        vmulps    %zmm18, %zmm27, %zmm28                        #242.67
        vmulps    %zmm2, %zmm29, %zmm30                         #241.51
        vmulps    %zmm28, %zmm27, %zmm28                        #242.51
        vmulps    %zmm30, %zmm29, %zmm2                         #241.35
        vmulps    %zmm28, %zmm27, %zmm31                        #242.35
        vfmsub213ps %zmm20, %zmm29, %zmm30                      #244.79
        vfmsub213ps %zmm20, %zmm27, %zmm28                      #245.79
        vmulps    %zmm17, %zmm29, %zmm29                        #244.105
        vmulps    %zmm17, %zmm27, %zmm27                        #245.105
        vmulps    %zmm29, %zmm30, %zmm30                        #244.70
        vmulps    %zmm27, %zmm28, %zmm27                        #245.70
        vmovups   32(%r14,%rdi), %ymm28                         #266.13
        vmulps    %zmm30, %zmm2, %zmm2                          #244.54
        vmulps    %zmm27, %zmm31, %zmm31                        #245.54
        vmovups   64(%r14,%rdi), %ymm27                         #266.13
        vmulps    %zmm2, %zmm16, %zmm2                          #244.36
        vmulps    %zmm31, %zmm16, %zmm30                        #245.36
        vmovups   (%r14,%rdi), %ymm31                           #266.13
        lea       1(%r15,%r15), %r11d                           #215.61
        movl      %r12d, %r15d                                  #229.39
        cmpl      %r8d, %r11d                                   #215.66
        movl      %ebx, %r11d                                   #215.66
        sete      %r11b                                         #215.66
        negl      %r15d                                         #229.39
        movl      %r11d, %r9d                                   #229.39
        shll      $6, %r9d                                      #229.39
        negl      %r9d                                          #229.39
        addl      %r11d, %r9d                                   #229.39
        addl      %r9d, %r10d                                   #229.39
        movl      %r11d, %r9d                                   #229.39
        shll      $5, %r9d                                      #229.39
        negl      %r9d                                          #229.39
        addl      %r11d, %r9d                                   #229.39
        shll      $8, %r10d                                     #229.39
        addl      $-256, %r10d                                  #229.39
        lea       255(%r15,%r9), %r15d                          #229.39
        movl      %r12d, %r9d                                   #230.39
        orl       %r15d, %r10d                                  #229.39
        movl      %r11d, %r15d                                  #230.39
        kmovw     %r10d, %k0                                    #235.41
        movl      %r11d, %r10d                                  #230.39
        shll      $4, %r9d                                      #230.39
        shll      $8, %r10d                                     #230.39
        negl      %r9d                                          #230.39
        negl      %r10d                                         #230.39
        addl      %r12d, %r9d                                   #230.39
        addl      %r11d, %r10d                                  #230.39
        shll      $7, %r15d                                     #230.39
        addl      %r10d, %r9d                                   #230.39
        subl      %r15d, %r11d                                  #230.39
        lea       (,%r12,8), %r10d                              #230.39
        subl      %r10d, %r12d                                  #230.39
        shll      $8, %r9d                                      #230.39
        addl      $-256, %r9d                                   #230.39
        kandw     %k2, %k0, %k3                                 #235.41
        vmulps    %zmm2, %zmm0, %zmm29{%k3}{z}                  #247.33
        lea       255(%r12,%r11), %r12d                         #230.39
        vmulps    %zmm2, %zmm7, %zmm0{%k3}{z}                   #248.33
        vmulps    %zmm2, %zmm5, %zmm5{%k3}{z}                   #249.33
        vaddps    %zmm22, %zmm29, %zmm22                        #254.20
        vaddps    %zmm23, %zmm0, %zmm23                         #255.20
        vaddps    %zmm24, %zmm5, %zmm24                         #256.20
        orl       %r12d, %r9d                                   #230.39
        kmovw     %r9d, %k4                                     #236.41
        kandw     %k5, %k4, %k6                                 #236.41
        vmulps    %zmm30, %zmm8, %zmm7{%k6}{z}                  #250.33
        vmulps    %zmm30, %zmm3, %zmm8{%k6}{z}                  #251.33
        vmulps    %zmm30, %zmm4, %zmm2{%k6}{z}                  #252.33
        vaddps    %zmm7, %zmm29, %zmm3                          #266.38
        vaddps    %zmm8, %zmm0, %zmm4                           #266.49
        vaddps    %zmm2, %zmm5, %zmm29                          #266.60
        vaddps    %zmm26, %zmm8, %zmm26                         #258.20
        vaddps    %zmm25, %zmm7, %zmm25                         #257.20
        vaddps    %zmm14, %zmm2, %zmm14                         #259.20
        vpermd    %zmm3, %zmm15, %zmm0                          #266.13
        vpermd    %zmm4, %zmm15, %zmm8                          #266.13
        vpermd    %zmm29, %zmm15, %zmm30                        #266.13
        vaddps    %zmm3, %zmm0, %zmm5                           #266.13
        vaddps    %zmm4, %zmm8, %zmm4                           #266.13
        vaddps    %zmm29, %zmm30, %zmm29                        #266.13
        vsubps    %ymm5, %ymm31, %ymm7                          #266.13
        vsubps    %ymm4, %ymm28, %ymm28                         #266.13
        vsubps    %ymm29, %ymm27, %ymm27                        #266.13
        vmovups   %ymm7, (%r14,%rdi)                            #266.13
        vmovups   %ymm28, 32(%r14,%rdi)                         #266.13
        vmovups   %ymm27, 64(%r14,%rdi)                         #266.13
        cmpq      %rsi, %rax                                    #190.28
        jge       ..B4.30       # Prob 18%                      #190.28
                                # LOE rax rdx rcx rsi r13 ebx r8d xmm21 zmm1 zmm6 zmm9 zmm10 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm22 zmm23 zmm24 zmm25 zmm26 k1
..B4.43:                        # Preds ..B4.29
                                # Execution count [2.05e+01]
        movq      176(%r13), %rdi                               #151.27
        movq      160(%r13), %r11                               #172.27
        jmp       ..B4.29       # Prob 100%                     #172.27
                                # LOE rax rdx rcx rsi rdi r11 r13 ebx r8d xmm21 zmm1 zmm6 zmm9 zmm10 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm22 zmm23 zmm24 zmm25 zmm26 k1
..B4.30:                        # Preds ..B4.29
                                # Execution count [4.50e+00]
        movq      24(%rsp), %r9                                 #[spill]
        movq      16(%rsp), %r10                                #[spill]
        movq      8(%rsp), %r14                                 #[spill]
        movq      (%rsp), %r15                                  #[spill]
                                # LOE rcx rsi r9 r10 r13 r14 r15 ebx r8d xmm21 zmm1 zmm14 zmm16 zmm17 zmm18 zmm19 zmm20 zmm22 zmm23 zmm24 zmm25 zmm26 k1
..B4.31:                        # Preds ..B4.30 ..B4.27
                                # Execution count [5.00e+00]
        vshuff32x4 $136, %zmm25, %zmm22, %zmm27                 #270.9
        incl      %r8d                                          #166.49
        vshuff32x4 $221, %zmm25, %zmm22, %zmm22                 #270.9
        vshuff32x4 $136, %zmm26, %zmm23, %zmm3                  #271.9
        vshuff32x4 $221, %zmm26, %zmm23, %zmm23                 #271.9
        vshuff32x4 $136, %zmm14, %zmm24, %zmm10                 #272.9
        vshuff32x4 $221, %zmm14, %zmm24, %zmm24                 #272.9
        vaddps    %zmm22, %zmm27, %zmm28                        #270.9
        vaddps    %zmm23, %zmm3, %zmm4                          #271.9
        vaddps    %zmm24, %zmm10, %zmm12                        #272.9
        vxorpd    %xmm24, %xmm24, %xmm24                        #276.9
        vpermilps $78, %zmm28, %zmm25                           #270.9
        incq      %r10                                          #166.49
        vpermilps $78, %zmm4, %zmm26                            #271.9
        vpermilps $78, %zmm12, %zmm11                           #272.9
        vaddps    %zmm28, %zmm25, %zmm30                        #270.9
        vaddps    %zmm4, %zmm26, %zmm6                          #271.9
        vaddps    %zmm12, %zmm11, %zmm14                        #272.9
        vpermilps $177, %zmm30, %zmm29                          #270.9
        vpermilps $177, %zmm6, %zmm5                            #271.9
        vpermilps $177, %zmm14, %zmm13                          #272.9
        vaddps    %zmm30, %zmm29, %zmm31                        #270.9
        vaddps    %zmm6, %zmm5, %zmm7                           #271.9
        vaddps    %zmm14, %zmm13, %zmm15                        #272.9
        vcompressps %zmm31, %zmm0{%k1}{z}                       #270.9
        vcompressps %zmm7, %zmm8{%k1}{z}                        #271.9
        vcompressps %zmm15, %zmm22{%k1}{z}                      #272.9
        vaddps    (%rcx,%r9,4), %xmm0, %xmm2                    #270.9
        vaddps    32(%rcx,%r9,4), %xmm8, %xmm9                  #271.9
        vaddps    64(%rcx,%r9,4), %xmm22, %xmm23                #272.9
        vmovups   %xmm2, (%rcx,%r9,4)                           #270.9
        vmovups   %xmm9, 32(%rcx,%r9,4)                         #271.9
        vmovups   %xmm23, 64(%rcx,%r9,4)                        #272.9
        addq      %rsi, 8(%r15)                                 #275.9
        vcvtsi2sd %esi, %xmm24, %xmm24                          #276.9
        vmulsd    %xmm24, %xmm21, %xmm0                         #276.9
        vcvttsd2si %xmm0, %rax                                  #276.9
        incq      (%r15)                                        #274.9
        addq      %rax, 16(%r15)                                #276.9
        cmpl      20(%r13), %r8d                                #166.26
        jl        ..B4.27       # Prob 82%                      #166.26
                                # LOE r10 r13 r14 r15 ebx r8d xmm21 zmm1 zmm16 zmm17 zmm18 zmm19 zmm20 k1
..B4.33:                        # Preds ..B4.31 ..B4.25
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.2, %edi                         #279.5
        vzeroupper                                              #279.5
..___tag_value_computeForceLJ_2xnn_half.233:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #279.5
..___tag_value_computeForceLJ_2xnn_half.234:
                                # LOE r12
..B4.34:                        # Preds ..B4.33
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #282.16
..___tag_value_computeForceLJ_2xnn_half.235:
#       getTimeStamp()
        call      getTimeStamp                                  #282.16
..___tag_value_computeForceLJ_2xnn_half.236:
                                # LOE r12 xmm0
..B4.42:                        # Preds ..B4.34
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, (%rsp)                                 #282.16[spill]
                                # LOE r12
..B4.35:                        # Preds ..B4.42
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.5, %edi                         #283.5
        xorl      %eax, %eax                                    #283.5
..___tag_value_computeForceLJ_2xnn_half.238:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #283.5
..___tag_value_computeForceLJ_2xnn_half.239:
                                # LOE r12
..B4.36:                        # Preds ..B4.35
                                # Execution count [1.00e+00]
        vmovsd    (%rsp), %xmm0                                 #284.14[spill]
        vsubsd    192(%rsp), %xmm0, %xmm0                       #284.14[spill]
        addq      $216, %rsp                                    #284.14
	.cfi_restore 3
        popq      %rbx                                          #284.14
	.cfi_restore 15
        popq      %r15                                          #284.14
	.cfi_restore 14
        popq      %r14                                          #284.14
	.cfi_restore 13
        popq      %r13                                          #284.14
	.cfi_restore 12
        popq      %r12                                          #284.14
        movq      %rbp, %rsp                                    #284.14
        popq      %rbp                                          #284.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #284.14
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B4.37:                        # Preds ..B4.5 ..B4.9
                                # Execution count [4.50e-01]: Infreq
        movl      %ebx, %r10d                                   #152.9
        jmp       ..B4.17       # Prob 100%                     #152.9
        .align    16,0x90
                                # LOE rax rcx rsi r12 r13 r14 r15 edx ebx edi r10d r11d xmm0 xmm1 xmm2
	.cfi_endproc
# mark_end;
	.type	computeForceLJ_2xnn_half,@function
	.size	computeForceLJ_2xnn_half,.-computeForceLJ_2xnn_half
..LNcomputeForceLJ_2xnn_half.3:
	.data
# -- End  computeForceLJ_2xnn_half
	.text
.L_2__routine_start_computeForceLJ_4xn_full_4:
# -- Begin  computeForceLJ_4xn_full
	.text
# mark_begin;
       .align    16,0x90
	.globl computeForceLJ_4xn_full
# --- computeForceLJ_4xn_full(Parameter *, Atom *, Neighbor *, Stats *)
computeForceLJ_4xn_full:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %rcx
..B5.1:                         # Preds ..B5.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForceLJ_4xn_full.257:
..L258:
                                                        #622.96
        pushq     %rbp                                          #622.96
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #622.96
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #622.96
        pushq     %rbx                                          #622.96
        subq      $56, %rsp                                     #622.96
        movl      $.L_2__STRING.6, %edi                         #623.5
        xorl      %eax, %eax                                    #623.5
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
        movq      %rsi, %rbx                                    #622.96
..___tag_value_computeForceLJ_4xn_full.263:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #623.5
..___tag_value_computeForceLJ_4xn_full.264:
                                # LOE rbx r12 r13 r14 r15
..B5.2:                         # Preds ..B5.1
                                # Execution count [1.00e+00]
        xorl      %r8d, %r8d                                    #635.5
        xorl      %esi, %esi                                    #637.27
        xorl      %ecx, %ecx                                    #635.5
        movl      20(%rbx), %edx                                #635.26
        testl     %edx, %edx                                    #635.26
        jle       ..B5.23       # Prob 9%                       #635.26
                                # LOE rbx rsi r12 r13 r14 r15 edx ecx r8d
..B5.3:                         # Preds ..B5.2
                                # Execution count [9.00e-01]
        movq      176(%rbx), %rdi                               #637.27
        movq      192(%rbx), %rax                               #638.32
        vxorps    %xmm2, %xmm2, %xmm2                           #639.39
        vmovdqu   .L_2il0floatpacket.0(%rip), %xmm1             #638.9
        vmovdqu   .L_2il0floatpacket.1(%rip), %xmm0             #638.9
        movq      %r14, (%rsp)                                  #638.9[spill]
        movq      %r15, 8(%rsp)                                 #638.9[spill]
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xc8, 0xff, 0xff, 0xff, 0x22
                                # LOE rax rbx rsi rdi r12 r13 edx ecx r8d xmm0 xmm1 xmm2
..B5.4:                         # Preds ..B5.21 ..B5.3
                                # Execution count [5.00e+00]
        movl      %r8d, %r9d                                    #636.27
        movl      %r8d, %r10d                                   #636.27
        sarl      $1, %r9d                                      #636.27
        andl      $1, %r10d                                     #636.27
        shll      $2, %r10d                                     #636.27
        lea       (%r9,%r9,2), %r11d                            #636.27
        lea       (%r10,%r11,8), %r14d                          #636.27
        movl      (%rsi,%rax), %r11d                            #638.32
        movslq    %r14d, %r14                                   #637.27
        lea       (%rdi,%r14,4), %r15                           #637.27
        testl     %r11d, %r11d                                  #638.32
        jle       ..B5.21       # Prob 50%                      #638.32
                                # LOE rax rbx rsi rdi r12 r13 r15 edx ecx r8d r11d xmm0 xmm1 xmm2
..B5.5:                         # Preds ..B5.4
                                # Execution count [4.50e+00]
        cmpl      $8, %r11d                                     #638.9
        jl        ..B5.32       # Prob 10%                      #638.9
                                # LOE rax rbx rsi rdi r12 r13 r15 edx ecx r8d r11d xmm0 xmm1 xmm2
..B5.6:                         # Preds ..B5.5
                                # Execution count [4.50e+00]
        lea       64(%r15), %r9                                 #641.13
        andq      $15, %r9                                      #638.9
        testl     $3, %r9d                                      #638.9
        je        ..B5.8        # Prob 50%                      #638.9
                                # LOE rax rbx rsi rdi r12 r13 r15 edx ecx r8d r9d r11d xmm0 xmm1 xmm2
..B5.7:                         # Preds ..B5.6
                                # Execution count [2.25e+00]
        movl      %ecx, %r9d                                    #638.9
        jmp       ..B5.9        # Prob 100%                     #638.9
                                # LOE rax rbx rsi rdi r9 r12 r13 r15 edx ecx r8d r11d xmm0 xmm1 xmm2
..B5.8:                         # Preds ..B5.6
                                # Execution count [2.25e+00]
        movl      %r9d, %r10d                                   #638.9
        negl      %r10d                                         #638.9
        addl      $16, %r10d                                    #638.9
        shrl      $2, %r10d                                     #638.9
        testl     %r9d, %r9d                                    #638.9
        cmovne    %r10d, %r9d                                   #638.9
                                # LOE rax rbx rsi rdi r9 r12 r13 r15 edx ecx r8d r11d xmm0 xmm1 xmm2
..B5.9:                         # Preds ..B5.7 ..B5.8
                                # Execution count [4.50e+00]
        lea       8(%r9), %r10d                                 #638.9
        cmpl      %r10d, %r11d                                  #638.9
        jl        ..B5.32       # Prob 10%                      #638.9
                                # LOE rax rbx rsi rdi r9 r12 r13 r15 edx ecx r8d r11d xmm0 xmm1 xmm2
..B5.10:                        # Preds ..B5.9
                                # Execution count [5.00e+00]
        movl      %r11d, %r14d                                  #638.9
        xorl      %r10d, %r10d                                  #638.9
        subl      %r9d, %r14d                                   #638.9
        andl      $7, %r14d                                     #638.9
        negl      %r14d                                         #638.9
        addl      %r11d, %r14d                                  #638.9
        cmpl      $1, %r9d                                      #638.9
        jb        ..B5.14       # Prob 10%                      #638.9
                                # LOE rax rbx rsi rdi r9 r10 r12 r13 r15 edx ecx r8d r11d r14d xmm0 xmm1 xmm2
..B5.12:                        # Preds ..B5.10 ..B5.12
                                # Execution count [2.50e+01]
        movl      %ecx, (%r15,%r10,4)                           #639.13
        movl      %ecx, 32(%r15,%r10,4)                         #640.13
        movl      %ecx, 64(%r15,%r10,4)                         #641.13
        incq      %r10                                          #638.9
        cmpq      %r9, %r10                                     #638.9
        jb        ..B5.12       # Prob 82%                      #638.9
                                # LOE rax rbx rsi rdi r9 r10 r12 r13 r15 edx ecx r8d r11d r14d xmm0 xmm1 xmm2
..B5.14:                        # Preds ..B5.12 ..B5.10
                                # Execution count [4.50e+00]
        movslq    %r14d, %r10                                   #638.9
                                # LOE rax rbx rsi rdi r9 r10 r12 r13 r15 edx ecx r8d r11d r14d xmm0 xmm1 xmm2
..B5.15:                        # Preds ..B5.15 ..B5.14
                                # Execution count [2.50e+01]
        vmovups   %xmm2, (%r15,%r9,4)                           #639.13
        vmovups   %xmm2, 32(%r15,%r9,4)                         #640.13
        vmovups   %xmm2, 64(%r15,%r9,4)                         #641.13
        vmovups   %xmm2, 16(%r15,%r9,4)                         #639.13
        vmovups   %xmm2, 48(%r15,%r9,4)                         #640.13
        vmovups   %xmm2, 80(%r15,%r9,4)                         #641.13
        addq      $8, %r9                                       #638.9
        cmpq      %r10, %r9                                     #638.9
        jb        ..B5.15       # Prob 82%                      #638.9
                                # LOE rax rbx rsi rdi r9 r10 r12 r13 r15 edx ecx r8d r11d r14d xmm0 xmm1 xmm2
..B5.17:                        # Preds ..B5.15 ..B5.32
                                # Execution count [5.00e+00]
        lea       1(%r14), %r9d                                 #638.9
        cmpl      %r11d, %r9d                                   #638.9
        ja        ..B5.21       # Prob 50%                      #638.9
                                # LOE rax rbx rsi rdi r12 r13 r15 edx ecx r8d r11d r14d xmm0 xmm1 xmm2
..B5.18:                        # Preds ..B5.17
                                # Execution count [4.50e+00]
        movslq    %r14d, %r10                                   #639.13
        negl      %r14d                                         #638.9
        addl      %r11d, %r14d                                  #638.9
        xorl      %r9d, %r9d                                    #638.9
        movslq    %r11d, %r11                                   #638.9
        vmovdqa   %xmm0, %xmm4                                  #638.9
        vpbroadcastd %r14d, %xmm3                               #638.9
        subq      %r10, %r11                                    #638.9
        lea       (%r15,%r10,4), %r15                           #639.13
                                # LOE rax rbx rsi rdi r9 r11 r12 r13 r15 edx ecx r8d xmm0 xmm1 xmm2 xmm3 xmm4
..B5.19:                        # Preds ..B5.19 ..B5.18
                                # Execution count [2.50e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #638.9
        vpaddd    %xmm1, %xmm4, %xmm4                           #638.9
        vmovups   %xmm2, (%r15,%r9,4){%k1}                      #639.13
        vmovups   %xmm2, 32(%r15,%r9,4){%k1}                    #640.13
        vmovups   %xmm2, 64(%r15,%r9,4){%k1}                    #641.13
        addq      $4, %r9                                       #638.9
        cmpq      %r11, %r9                                     #638.9
        jb        ..B5.19       # Prob 82%                      #638.9
                                # LOE rax rbx rsi rdi r9 r11 r12 r13 r15 edx ecx r8d xmm0 xmm1 xmm2 xmm3 xmm4
..B5.21:                        # Preds ..B5.19 ..B5.4 ..B5.17
                                # Execution count [5.00e+00]
        incl      %r8d                                          #635.5
        addq      $28, %rsi                                     #635.5
        cmpl      %edx, %r8d                                    #635.5
        jb        ..B5.4        # Prob 82%                      #635.5
                                # LOE rax rbx rsi rdi r12 r13 edx ecx r8d xmm0 xmm1 xmm2
..B5.22:                        # Preds ..B5.21
                                # Execution count [9.00e-01]
        movq      (%rsp), %r14                                  #[spill]
	.cfi_restore 14
        movq      8(%rsp), %r15                                 #[spill]
	.cfi_restore 15
                                # LOE rbx r12 r13 r14 r15
..B5.23:                        # Preds ..B5.2 ..B5.22
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #645.16
..___tag_value_computeForceLJ_4xn_full.272:
#       getTimeStamp()
        call      getTimeStamp                                  #645.16
..___tag_value_computeForceLJ_4xn_full.273:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B5.36:                        # Preds ..B5.23
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 16(%rsp)                               #645.16[spill]
                                # LOE rbx r12 r13 r14 r15
..B5.24:                        # Preds ..B5.36
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.2, %edi                         #649.5
..___tag_value_computeForceLJ_4xn_full.275:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #649.5
..___tag_value_computeForceLJ_4xn_full.276:
                                # LOE rbx r12 r13 r14 r15
..B5.25:                        # Preds ..B5.24
                                # Execution count [1.00e+00]
        cmpl      $0, 20(%rbx)                                  #652.26
        jle       ..B5.28       # Prob 10%                      #652.26
                                # LOE r12 r13 r14 r15
..B5.26:                        # Preds ..B5.25
                                # Execution count [5.00e+00]
        movl      $il0_peep_printf_format_0, %edi               #769.9
        movq      stderr(%rip), %rsi                            #769.9
        call      fputs                                         #769.9
                                # LOE
..B5.27:                        # Preds ..B5.26
                                # Execution count [5.00e+00]
        movl      $-1, %edi                                     #769.9
#       exit(int)
        call      exit                                          #769.9
                                # LOE
..B5.28:                        # Preds ..B5.25
                                # Execution count [1.00e+00]: Infreq
        movl      $.L_2__STRING.2, %edi                         #779.5
..___tag_value_computeForceLJ_4xn_full.277:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #779.5
..___tag_value_computeForceLJ_4xn_full.278:
                                # LOE r12 r13 r14 r15
..B5.29:                        # Preds ..B5.28
                                # Execution count [1.00e+00]: Infreq
        xorl      %eax, %eax                                    #782.16
..___tag_value_computeForceLJ_4xn_full.279:
#       getTimeStamp()
        call      getTimeStamp                                  #782.16
..___tag_value_computeForceLJ_4xn_full.280:
                                # LOE r12 r13 r14 r15 xmm0
..B5.37:                        # Preds ..B5.29
                                # Execution count [1.00e+00]: Infreq
        vmovsd    %xmm0, 24(%rsp)                               #782.16[spill]
                                # LOE r12 r13 r14 r15
..B5.30:                        # Preds ..B5.37
                                # Execution count [1.00e+00]: Infreq
        movl      $.L_2__STRING.7, %edi                         #783.5
        xorl      %eax, %eax                                    #783.5
..___tag_value_computeForceLJ_4xn_full.282:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #783.5
..___tag_value_computeForceLJ_4xn_full.283:
                                # LOE r12 r13 r14 r15
..B5.31:                        # Preds ..B5.30
                                # Execution count [1.00e+00]: Infreq
        vmovsd    24(%rsp), %xmm0                               #784.14[spill]
        vsubsd    16(%rsp), %xmm0, %xmm0                        #784.14[spill]
        addq      $56, %rsp                                     #784.14
	.cfi_restore 3
        popq      %rbx                                          #784.14
        movq      %rbp, %rsp                                    #784.14
        popq      %rbp                                          #784.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #784.14
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xc8, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B5.32:                        # Preds ..B5.5 ..B5.9
                                # Execution count [4.50e-01]: Infreq
        movl      %ecx, %r14d                                   #638.9
        jmp       ..B5.17       # Prob 100%                     #638.9
        .align    16,0x90
                                # LOE rax rbx rsi rdi r12 r13 r15 edx ecx r8d r11d r14d xmm0 xmm1 xmm2
	.cfi_endproc
# mark_end;
	.type	computeForceLJ_4xn_full,@function
	.size	computeForceLJ_4xn_full,.-computeForceLJ_4xn_full
..LNcomputeForceLJ_4xn_full.4:
	.section .rodata.str1.32, "aMS",@progbits,1
	.align 32
	.align 32
il0_peep_printf_format_0:
	.long	1684892019
	.long	1918855263
	.long	1668637797
	.long	1970495333
	.long	975775853
	.long	1818313504
	.long	543450476
	.long	1752459639
	.long	1482047776
	.long	540160309
	.long	1920233065
	.long	1769172585
	.long	1629516643
	.long	1931502702
	.long	1818717801
	.long	1919954277
	.long	1936286565
	.long	544108393
	.long	1667852407
	.long	1936269416
	.long	1953459744
	.long	1818326560
	.long	169960553
	.byte	0
	.data
# -- End  computeForceLJ_4xn_full
	.text
.L_2__routine_start_computeForceLJ_4xn_5:
# -- Begin  computeForceLJ_4xn
	.text
# mark_begin;
       .align    16,0x90
	.globl computeForceLJ_4xn
# --- computeForceLJ_4xn(Parameter *, Atom *, Neighbor *, Stats *)
computeForceLJ_4xn:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %rcx
..B6.1:                         # Preds ..B6.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForceLJ_4xn.295:
..L296:
                                                        #787.91
        pushq     %rbp                                          #787.91
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #787.91
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #787.91
        pushq     %rbx                                          #787.91
        subq      $56, %rsp                                     #787.91
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
        movq      %rsi, %rbx                                    #787.91
        cmpl      $0, 32(%rdx)                                  #788.8
        je        ..B6.4        # Prob 50%                      #788.8
                                # LOE rdx rcx rbx rdi r12 r13 r14 r15
..B6.2:                         # Preds ..B6.1
                                # Execution count [5.00e-01]
        movq      %rbx, %rsi                                    #789.16
        addq      $56, %rsp                                     #789.16
	.cfi_restore 3
        popq      %rbx                                          #789.16
        movq      %rbp, %rsp                                    #789.16
        popq      %rbp                                          #789.16
	.cfi_def_cfa 7, 8
	.cfi_restore 6
#       computeForceLJ_4xn_half(Parameter *, Atom *, Neighbor *, Stats *)
        jmp       computeForceLJ_4xn_half                       #789.16
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
                                # LOE
..B6.4:                         # Preds ..B6.1
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.6, %edi                         #792.12
        xorl      %eax, %eax                                    #792.12
..___tag_value_computeForceLJ_4xn.307:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #792.12
..___tag_value_computeForceLJ_4xn.308:
                                # LOE rbx r12 r13 r14 r15
..B6.5:                         # Preds ..B6.4
                                # Execution count [5.00e-01]
        xorl      %r9d, %r9d                                    #792.12
        xorl      %edi, %edi                                    #792.12
        movl      20(%rbx), %edx                                #792.12
        xorl      %ecx, %ecx                                    #792.12
        testl     %edx, %edx                                    #792.12
        jle       ..B6.26       # Prob 9%                       #792.12
                                # LOE rbx rdi r12 r13 r14 r15 edx ecx r9d
..B6.6:                         # Preds ..B6.5
                                # Execution count [4.50e-01]
        movq      176(%rbx), %r8                                #792.12
        movq      192(%rbx), %rax                               #792.12
        vxorps    %xmm2, %xmm2, %xmm2                           #792.12
        vmovdqu   .L_2il0floatpacket.0(%rip), %xmm1             #792.12
        vmovdqu   .L_2il0floatpacket.1(%rip), %xmm0             #792.12
        movq      %r14, (%rsp)                                  #792.12[spill]
        movq      %r15, 8(%rsp)                                 #792.12[spill]
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xc8, 0xff, 0xff, 0xff, 0x22
                                # LOE rax rbx rdi r8 r12 r13 edx ecx r9d xmm0 xmm1 xmm2
..B6.7:                         # Preds ..B6.24 ..B6.6
                                # Execution count [2.50e+00]
        movl      %r9d, %r10d                                   #792.12
        movl      %r9d, %r11d                                   #792.12
        sarl      $1, %r10d                                     #792.12
        andl      $1, %r11d                                     #792.12
        shll      $2, %r11d                                     #792.12
        lea       (%r10,%r10,2), %r14d                          #792.12
        lea       (%r11,%r14,8), %r15d                          #792.12
        movl      (%rdi,%rax), %r14d                            #792.12
        movslq    %r15d, %r15                                   #792.12
        lea       (%r8,%r15,4), %rsi                            #792.12
        testl     %r14d, %r14d                                  #792.12
        jle       ..B6.24       # Prob 50%                      #792.12
                                # LOE rax rbx rsi rdi r8 r12 r13 edx ecx r9d r14d xmm0 xmm1 xmm2
..B6.8:                         # Preds ..B6.7
                                # Execution count [2.25e+00]
        cmpl      $8, %r14d                                     #792.12
        jl        ..B6.35       # Prob 10%                      #792.12
                                # LOE rax rbx rsi rdi r8 r12 r13 edx ecx r9d r14d xmm0 xmm1 xmm2
..B6.9:                         # Preds ..B6.8
                                # Execution count [2.25e+00]
        lea       64(%rsi), %r10                                #792.12
        andq      $15, %r10                                     #792.12
        testl     $3, %r10d                                     #792.12
        je        ..B6.11       # Prob 50%                      #792.12
                                # LOE rax rbx rsi rdi r8 r12 r13 edx ecx r9d r10d r14d xmm0 xmm1 xmm2
..B6.10:                        # Preds ..B6.9
                                # Execution count [1.12e+00]
        movl      %ecx, %r10d                                   #792.12
        jmp       ..B6.12       # Prob 100%                     #792.12
                                # LOE rax rbx rsi rdi r8 r10 r12 r13 edx ecx r9d r14d xmm0 xmm1 xmm2
..B6.11:                        # Preds ..B6.9
                                # Execution count [1.12e+00]
        movl      %r10d, %r11d                                  #792.12
        negl      %r11d                                         #792.12
        addl      $16, %r11d                                    #792.12
        shrl      $2, %r11d                                     #792.12
        testl     %r10d, %r10d                                  #792.12
        cmovne    %r11d, %r10d                                  #792.12
                                # LOE rax rbx rsi rdi r8 r10 r12 r13 edx ecx r9d r14d xmm0 xmm1 xmm2
..B6.12:                        # Preds ..B6.10 ..B6.11
                                # Execution count [2.25e+00]
        lea       8(%r10), %r11d                                #792.12
        cmpl      %r11d, %r14d                                  #792.12
        jl        ..B6.35       # Prob 10%                      #792.12
                                # LOE rax rbx rsi rdi r8 r10 r12 r13 edx ecx r9d r14d xmm0 xmm1 xmm2
..B6.13:                        # Preds ..B6.12
                                # Execution count [2.50e+00]
        movl      %r14d, %r15d                                  #792.12
        xorl      %r11d, %r11d                                  #792.12
        subl      %r10d, %r15d                                  #792.12
        andl      $7, %r15d                                     #792.12
        negl      %r15d                                         #792.12
        addl      %r14d, %r15d                                  #792.12
        cmpl      $1, %r10d                                     #792.12
        jb        ..B6.17       # Prob 10%                      #792.12
                                # LOE rax rbx rsi rdi r8 r10 r11 r12 r13 edx ecx r9d r14d r15d xmm0 xmm1 xmm2
..B6.15:                        # Preds ..B6.13 ..B6.15
                                # Execution count [1.25e+01]
        movl      %ecx, (%rsi,%r11,4)                           #792.12
        movl      %ecx, 32(%rsi,%r11,4)                         #792.12
        movl      %ecx, 64(%rsi,%r11,4)                         #792.12
        incq      %r11                                          #792.12
        cmpq      %r10, %r11                                    #792.12
        jb        ..B6.15       # Prob 82%                      #792.12
                                # LOE rax rbx rsi rdi r8 r10 r11 r12 r13 edx ecx r9d r14d r15d xmm0 xmm1 xmm2
..B6.17:                        # Preds ..B6.15 ..B6.13
                                # Execution count [2.25e+00]
        movslq    %r15d, %r11                                   #792.12
                                # LOE rax rbx rsi rdi r8 r10 r11 r12 r13 edx ecx r9d r14d r15d xmm0 xmm1 xmm2
..B6.18:                        # Preds ..B6.18 ..B6.17
                                # Execution count [1.25e+01]
        vmovups   %xmm2, (%rsi,%r10,4)                          #792.12
        vmovups   %xmm2, 32(%rsi,%r10,4)                        #792.12
        vmovups   %xmm2, 64(%rsi,%r10,4)                        #792.12
        vmovups   %xmm2, 16(%rsi,%r10,4)                        #792.12
        vmovups   %xmm2, 48(%rsi,%r10,4)                        #792.12
        vmovups   %xmm2, 80(%rsi,%r10,4)                        #792.12
        addq      $8, %r10                                      #792.12
        cmpq      %r11, %r10                                    #792.12
        jb        ..B6.18       # Prob 82%                      #792.12
                                # LOE rax rbx rsi rdi r8 r10 r11 r12 r13 edx ecx r9d r14d r15d xmm0 xmm1 xmm2
..B6.20:                        # Preds ..B6.18 ..B6.35
                                # Execution count [2.50e+00]
        lea       1(%r15), %r10d                                #792.12
        cmpl      %r14d, %r10d                                  #792.12
        ja        ..B6.24       # Prob 50%                      #792.12
                                # LOE rax rbx rsi rdi r8 r12 r13 edx ecx r9d r14d r15d xmm0 xmm1 xmm2
..B6.21:                        # Preds ..B6.20
                                # Execution count [2.25e+00]
        movslq    %r15d, %r11                                   #792.12
        negl      %r15d                                         #792.12
        addl      %r14d, %r15d                                  #792.12
        xorl      %r10d, %r10d                                  #792.12
        movslq    %r14d, %r14                                   #792.12
        vmovdqa   %xmm0, %xmm4                                  #792.12
        vpbroadcastd %r15d, %xmm3                               #792.12
        subq      %r11, %r14                                    #792.12
        lea       (%rsi,%r11,4), %rsi                           #792.12
                                # LOE rax rbx rsi rdi r8 r10 r12 r13 r14 edx ecx r9d xmm0 xmm1 xmm2 xmm3 xmm4
..B6.22:                        # Preds ..B6.22 ..B6.21
                                # Execution count [1.25e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #792.12
        vpaddd    %xmm1, %xmm4, %xmm4                           #792.12
        vmovups   %xmm2, (%rsi,%r10,4){%k1}                     #792.12
        vmovups   %xmm2, 32(%rsi,%r10,4){%k1}                   #792.12
        vmovups   %xmm2, 64(%rsi,%r10,4){%k1}                   #792.12
        addq      $4, %r10                                      #792.12
        cmpq      %r14, %r10                                    #792.12
        jb        ..B6.22       # Prob 82%                      #792.12
                                # LOE rax rbx rsi rdi r8 r10 r12 r13 r14 edx ecx r9d xmm0 xmm1 xmm2 xmm3 xmm4
..B6.24:                        # Preds ..B6.22 ..B6.7 ..B6.20
                                # Execution count [2.50e+00]
        incl      %r9d                                          #792.12
        addq      $28, %rdi                                     #792.12
        cmpl      %edx, %r9d                                    #792.12
        jb        ..B6.7        # Prob 82%                      #792.12
                                # LOE rax rbx rdi r8 r12 r13 edx ecx r9d xmm0 xmm1 xmm2
..B6.25:                        # Preds ..B6.24
                                # Execution count [4.50e-01]
        movq      (%rsp), %r14                                  #[spill]
	.cfi_restore 14
        movq      8(%rsp), %r15                                 #[spill]
	.cfi_restore 15
                                # LOE rbx r12 r13 r14 r15
..B6.26:                        # Preds ..B6.5 ..B6.25
                                # Execution count [5.00e-01]
        xorl      %eax, %eax                                    #792.12
..___tag_value_computeForceLJ_4xn.316:
#       getTimeStamp()
        call      getTimeStamp                                  #792.12
..___tag_value_computeForceLJ_4xn.317:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B6.40:                        # Preds ..B6.26
                                # Execution count [5.00e-01]
        vmovsd    %xmm0, 16(%rsp)                               #792.12[spill]
                                # LOE rbx r12 r13 r14 r15
..B6.27:                        # Preds ..B6.40
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.2, %edi                         #792.12
..___tag_value_computeForceLJ_4xn.319:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #792.12
..___tag_value_computeForceLJ_4xn.320:
                                # LOE rbx r12 r13 r14 r15
..B6.28:                        # Preds ..B6.27
                                # Execution count [5.00e-01]
        cmpl      $0, 20(%rbx)                                  #792.12
        jle       ..B6.31       # Prob 10%                      #792.12
                                # LOE r12 r13 r14 r15
..B6.29:                        # Preds ..B6.28
                                # Execution count [2.50e+00]
        movl      $il0_peep_printf_format_1, %edi               #792.12
        movq      stderr(%rip), %rsi                            #792.12
        call      fputs                                         #792.12
                                # LOE
..B6.30:                        # Preds ..B6.29
                                # Execution count [2.50e+00]
        movl      $-1, %edi                                     #792.12
#       exit(int)
        call      exit                                          #792.12
                                # LOE
..B6.31:                        # Preds ..B6.28
                                # Execution count [5.00e-01]: Infreq
        movl      $.L_2__STRING.2, %edi                         #792.12
..___tag_value_computeForceLJ_4xn.321:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #792.12
..___tag_value_computeForceLJ_4xn.322:
                                # LOE r12 r13 r14 r15
..B6.32:                        # Preds ..B6.31
                                # Execution count [5.00e-01]: Infreq
        xorl      %eax, %eax                                    #792.12
..___tag_value_computeForceLJ_4xn.323:
#       getTimeStamp()
        call      getTimeStamp                                  #792.12
..___tag_value_computeForceLJ_4xn.324:
                                # LOE r12 r13 r14 r15 xmm0
..B6.41:                        # Preds ..B6.32
                                # Execution count [5.00e-01]: Infreq
        vmovsd    %xmm0, 24(%rsp)                               #792.12[spill]
                                # LOE r12 r13 r14 r15
..B6.33:                        # Preds ..B6.41
                                # Execution count [5.00e-01]: Infreq
        movl      $.L_2__STRING.7, %edi                         #792.12
        xorl      %eax, %eax                                    #792.12
..___tag_value_computeForceLJ_4xn.326:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #792.12
..___tag_value_computeForceLJ_4xn.327:
                                # LOE r12 r13 r14 r15
..B6.34:                        # Preds ..B6.33
                                # Execution count [5.00e-01]: Infreq
        vmovsd    24(%rsp), %xmm0                               #792.12[spill]
        vsubsd    16(%rsp), %xmm0, %xmm0                        #792.12[spill]
        addq      $56, %rsp                                     #792.12
	.cfi_restore 3
        popq      %rbx                                          #792.12
        movq      %rbp, %rsp                                    #792.12
        popq      %rbp                                          #792.12
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #792.12
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xc8, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B6.35:                        # Preds ..B6.8 ..B6.12
                                # Execution count [2.25e-01]: Infreq
        movl      %ecx, %r15d                                   #792.12
        jmp       ..B6.20       # Prob 100%                     #792.12
        .align    16,0x90
                                # LOE rax rbx rsi rdi r8 r12 r13 edx ecx r9d r14d r15d xmm0 xmm1 xmm2
	.cfi_endproc
# mark_end;
	.type	computeForceLJ_4xn,@function
	.size	computeForceLJ_4xn,.-computeForceLJ_4xn
..LNcomputeForceLJ_4xn.5:
	.section .rodata.str1.32, "aMS",@progbits,1
	.space 3, 0x00 	# pad
	.align 32
il0_peep_printf_format_1:
	.long	1684892019
	.long	1918855263
	.long	1668637797
	.long	1970495333
	.long	975775853
	.long	1818313504
	.long	543450476
	.long	1752459639
	.long	1482047776
	.long	540160309
	.long	1920233065
	.long	1769172585
	.long	1629516643
	.long	1931502702
	.long	1818717801
	.long	1919954277
	.long	1936286565
	.long	544108393
	.long	1667852407
	.long	1936269416
	.long	1953459744
	.long	1818326560
	.long	169960553
	.byte	0
	.data
# -- End  computeForceLJ_4xn
	.text
.L_2__routine_start_computeForceLJ_4xn_half_6:
# -- Begin  computeForceLJ_4xn_half
	.text
# mark_begin;
       .align    16,0x90
	.globl computeForceLJ_4xn_half
# --- computeForceLJ_4xn_half(Parameter *, Atom *, Neighbor *, Stats *)
computeForceLJ_4xn_half:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %rcx
..B7.1:                         # Preds ..B7.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForceLJ_4xn_half.339:
..L340:
                                                        #432.96
        pushq     %rbp                                          #432.96
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #432.96
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #432.96
        pushq     %r13                                          #432.96
        pushq     %r14                                          #432.96
        pushq     %r15                                          #432.96
        subq      $424, %rsp                                    #432.96
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
        movq      %rdi, %r13                                    #432.96
        movl      $.L_2__STRING.6, %edi                         #433.5
        xorl      %eax, %eax                                    #433.5
        movq      %rdx, %r15                                    #432.96
        movq      %rsi, %r14                                    #432.96
..___tag_value_computeForceLJ_4xn_half.347:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #433.5
..___tag_value_computeForceLJ_4xn_half.348:
                                # LOE rbx r12 r13 r14 r15
..B7.2:                         # Preds ..B7.1
                                # Execution count [1.00e+00]
        vmovss    108(%r13), %xmm0                              #436.27
        xorl      %edi, %edi                                    #445.5
        vmulss    %xmm0, %xmm0, %xmm1                           #439.36
        xorl      %ecx, %ecx                                    #447.27
        vbroadcastss 48(%r13), %zmm3                            #440.32
        vbroadcastss 40(%r13), %zmm4                            #441.29
        vbroadcastss %xmm1, %zmm2                               #439.36
        vmovups   %zmm3, 64(%rsp)                               #440.32[spill]
        vmovups   %zmm4, (%rsp)                                 #441.29[spill]
        vmovups   %zmm2, 128(%rsp)                              #439.36[spill]
        movl      20(%r14), %edx                                #445.26
        xorl      %r13d, %r13d                                  #445.5
        testl     %edx, %edx                                    #445.26
        jle       ..B7.23       # Prob 9%                       #445.26
                                # LOE rcx rbx r12 r14 r15 edx edi r13d
..B7.3:                         # Preds ..B7.2
                                # Execution count [9.00e-01]
        movq      176(%r14), %rsi                               #447.27
        movq      192(%r14), %rax                               #448.32
        vxorps    %xmm2, %xmm2, %xmm2                           #449.39
        vmovdqu   .L_2il0floatpacket.0(%rip), %xmm1             #448.9
        vmovdqu   .L_2il0floatpacket.1(%rip), %xmm0             #448.9
        movq      %rbx, 192(%rsp)                               #448.9[spill]
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0x00, 0xff, 0xff, 0xff, 0x22
                                # LOE rax rcx rsi r12 r14 r15 edx edi r13d xmm0 xmm1 xmm2
..B7.4:                         # Preds ..B7.21 ..B7.3
                                # Execution count [5.00e+00]
        movl      %edi, %ebx                                    #446.27
        movl      %edi, %r8d                                    #446.27
        sarl      $1, %ebx                                      #446.27
        andl      $1, %r8d                                      #446.27
        shll      $2, %r8d                                      #446.27
        lea       (%rbx,%rbx,2), %r9d                           #446.27
        lea       (%r8,%r9,8), %r10d                            #446.27
        movslq    %r10d, %r10                                   #447.27
        lea       (%rsi,%r10,4), %r11                           #447.27
        movl      (%rcx,%rax), %r10d                            #448.32
        testl     %r10d, %r10d                                  #448.32
        jle       ..B7.21       # Prob 50%                      #448.32
                                # LOE rax rcx rsi r11 r12 r14 r15 edx edi r10d r13d xmm0 xmm1 xmm2
..B7.5:                         # Preds ..B7.4
                                # Execution count [4.50e+00]
        cmpl      $8, %r10d                                     #448.9
        jl        ..B7.36       # Prob 10%                      #448.9
                                # LOE rax rcx rsi r11 r12 r14 r15 edx edi r10d r13d xmm0 xmm1 xmm2
..B7.6:                         # Preds ..B7.5
                                # Execution count [4.50e+00]
        lea       64(%r11), %rbx                                #451.13
        andq      $15, %rbx                                     #448.9
        testb     $3, %bl                                       #448.9
        je        ..B7.8        # Prob 50%                      #448.9
                                # LOE rax rcx rsi r11 r12 r14 r15 edx ebx edi r10d r13d xmm0 xmm1 xmm2
..B7.7:                         # Preds ..B7.6
                                # Execution count [2.25e+00]
        movl      %r13d, %ebx                                   #448.9
        jmp       ..B7.9        # Prob 100%                     #448.9
                                # LOE rax rcx rbx rsi r11 r12 r14 r15 edx edi r10d r13d xmm0 xmm1 xmm2
..B7.8:                         # Preds ..B7.6
                                # Execution count [2.25e+00]
        movl      %ebx, %r8d                                    #448.9
        negl      %r8d                                          #448.9
        addl      $16, %r8d                                     #448.9
        shrl      $2, %r8d                                      #448.9
        testl     %ebx, %ebx                                    #448.9
        cmovne    %r8d, %ebx                                    #448.9
                                # LOE rax rcx rbx rsi r11 r12 r14 r15 edx edi r10d r13d xmm0 xmm1 xmm2
..B7.9:                         # Preds ..B7.7 ..B7.8
                                # Execution count [4.50e+00]
        lea       8(%rbx), %r8d                                 #448.9
        cmpl      %r8d, %r10d                                   #448.9
        jl        ..B7.36       # Prob 10%                      #448.9
                                # LOE rax rcx rbx rsi r11 r12 r14 r15 edx edi r10d r13d xmm0 xmm1 xmm2
..B7.10:                        # Preds ..B7.9
                                # Execution count [5.00e+00]
        movl      %r10d, %r9d                                   #448.9
        xorl      %r8d, %r8d                                    #448.9
        subl      %ebx, %r9d                                    #448.9
        andl      $7, %r9d                                      #448.9
        negl      %r9d                                          #448.9
        addl      %r10d, %r9d                                   #448.9
        cmpl      $1, %ebx                                      #448.9
        jb        ..B7.14       # Prob 10%                      #448.9
                                # LOE rax rcx rbx rsi r8 r11 r12 r14 r15 edx edi r9d r10d r13d xmm0 xmm1 xmm2
..B7.12:                        # Preds ..B7.10 ..B7.12
                                # Execution count [2.50e+01]
        movl      %r13d, (%r11,%r8,4)                           #449.13
        movl      %r13d, 32(%r11,%r8,4)                         #450.13
        movl      %r13d, 64(%r11,%r8,4)                         #451.13
        incq      %r8                                           #448.9
        cmpq      %rbx, %r8                                     #448.9
        jb        ..B7.12       # Prob 82%                      #448.9
                                # LOE rax rcx rbx rsi r8 r11 r12 r14 r15 edx edi r9d r10d r13d xmm0 xmm1 xmm2
..B7.14:                        # Preds ..B7.12 ..B7.10
                                # Execution count [4.50e+00]
        movslq    %r9d, %r8                                     #448.9
                                # LOE rax rcx rbx rsi r8 r11 r12 r14 r15 edx edi r9d r10d r13d xmm0 xmm1 xmm2
..B7.15:                        # Preds ..B7.15 ..B7.14
                                # Execution count [2.50e+01]
        vmovups   %xmm2, (%r11,%rbx,4)                          #449.13
        vmovups   %xmm2, 32(%r11,%rbx,4)                        #450.13
        vmovups   %xmm2, 64(%r11,%rbx,4)                        #451.13
        vmovups   %xmm2, 16(%r11,%rbx,4)                        #449.13
        vmovups   %xmm2, 48(%r11,%rbx,4)                        #450.13
        vmovups   %xmm2, 80(%r11,%rbx,4)                        #451.13
        addq      $8, %rbx                                      #448.9
        cmpq      %r8, %rbx                                     #448.9
        jb        ..B7.15       # Prob 82%                      #448.9
                                # LOE rax rcx rbx rsi r8 r11 r12 r14 r15 edx edi r9d r10d r13d xmm0 xmm1 xmm2
..B7.17:                        # Preds ..B7.15 ..B7.36
                                # Execution count [5.00e+00]
        lea       1(%r9), %ebx                                  #448.9
        cmpl      %r10d, %ebx                                   #448.9
        ja        ..B7.21       # Prob 50%                      #448.9
                                # LOE rax rcx rsi r11 r12 r14 r15 edx edi r9d r10d r13d xmm0 xmm1 xmm2
..B7.18:                        # Preds ..B7.17
                                # Execution count [4.50e+00]
        movslq    %r9d, %r8                                     #449.13
        negl      %r9d                                          #448.9
        addl      %r10d, %r9d                                   #448.9
        xorl      %ebx, %ebx                                    #448.9
        movslq    %r10d, %r10                                   #448.9
        vmovdqa   %xmm0, %xmm4                                  #448.9
        vpbroadcastd %r9d, %xmm3                                #448.9
        subq      %r8, %r10                                     #448.9
        lea       (%r11,%r8,4), %r11                            #449.13
                                # LOE rax rcx rbx rsi r10 r11 r12 r14 r15 edx edi r13d xmm0 xmm1 xmm2 xmm3 xmm4
..B7.19:                        # Preds ..B7.19 ..B7.18
                                # Execution count [2.50e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #448.9
        vpaddd    %xmm1, %xmm4, %xmm4                           #448.9
        vmovups   %xmm2, (%r11,%rbx,4){%k1}                     #449.13
        vmovups   %xmm2, 32(%r11,%rbx,4){%k1}                   #450.13
        vmovups   %xmm2, 64(%r11,%rbx,4){%k1}                   #451.13
        addq      $4, %rbx                                      #448.9
        cmpq      %r10, %rbx                                    #448.9
        jb        ..B7.19       # Prob 82%                      #448.9
                                # LOE rax rcx rbx rsi r10 r11 r12 r14 r15 edx edi r13d xmm0 xmm1 xmm2 xmm3 xmm4
..B7.21:                        # Preds ..B7.19 ..B7.4 ..B7.17
                                # Execution count [5.00e+00]
        incl      %edi                                          #445.5
        addq      $28, %rcx                                     #445.5
        cmpl      %edx, %edi                                    #445.5
        jb        ..B7.4        # Prob 82%                      #445.5
                                # LOE rax rcx rsi r12 r14 r15 edx edi r13d xmm0 xmm1 xmm2
..B7.22:                        # Preds ..B7.21
                                # Execution count [9.00e-01]
        movq      192(%rsp), %rbx                               #[spill]
	.cfi_restore 3
                                # LOE rbx r12 r14 r15 r13d
..B7.23:                        # Preds ..B7.2 ..B7.22
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #455.16
        vzeroupper                                              #455.16
..___tag_value_computeForceLJ_4xn_half.355:
#       getTimeStamp()
        call      getTimeStamp                                  #455.16
..___tag_value_computeForceLJ_4xn_half.356:
                                # LOE rbx r12 r14 r15 r13d xmm0
..B7.40:                        # Preds ..B7.23
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 200(%rsp)                              #455.16[spill]
                                # LOE rbx r12 r14 r15 r13d
..B7.24:                        # Preds ..B7.40
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.2, %edi                         #459.5
..___tag_value_computeForceLJ_4xn_half.358:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #459.5
..___tag_value_computeForceLJ_4xn_half.359:
                                # LOE rbx r12 r14 r15 r13d
..B7.25:                        # Preds ..B7.24
                                # Execution count [1.00e+00]
        cmpl      $0, 20(%r14)                                  #462.26
        jle       ..B7.32       # Prob 10%                      #462.26
                                # LOE rbx r12 r14 r15 r13d
..B7.26:                        # Preds ..B7.25
                                # Execution count [5.00e+00]
        movq      24(%r15), %rax                                #471.25
        movq      160(%r14), %rbx                               #468.27
        movq      8(%r15), %rcx                                 #470.19
        movslq    (%rax), %rdx                                  #471.25
        xorl      %eax, %eax                                    #498.9
        vbroadcastss (%rbx), %zmm19                             #473.33
        vbroadcastss 4(%rbx), %zmm18                            #474.33
        vbroadcastss 8(%rbx), %zmm3                             #475.33
        vbroadcastss 12(%rbx), %zmm2                            #476.33
        vbroadcastss 32(%rbx), %zmm17                           #477.33
        vbroadcastss 36(%rbx), %zmm16                           #478.33
        vbroadcastss 40(%rbx), %zmm15                           #479.33
        vbroadcastss 44(%rbx), %zmm14                           #480.33
        vbroadcastss 64(%rbx), %zmm13                           #481.33
        vbroadcastss 68(%rbx), %zmm12                           #482.33
        vbroadcastss 72(%rbx), %zmm1                            #483.33
        vbroadcastss 76(%rbx), %zmm0                            #484.33
        testq     %rdx, %rdx                                    #498.28
        jle       ..B7.30       # Prob 10%                      #498.28
                                # LOE rax rdx rcx rbx r14 r13d zmm0 zmm1 zmm2 zmm3 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19
..B7.27:                        # Preds ..B7.26
                                # Execution count [4.50e+00]
        movq      176(%r14), %rsi                               #502.31
        vmovups   %zmm1, 256(%rsp)                              #502.31[spill]
        vmovups   %zmm2, 192(%rsp)                              #502.31[spill]
        vmovups   %zmm3, 320(%rsp)                              #502.31[spill]
        vmovups   .L_2il0floatpacket.7(%rip), %zmm20            #502.31
        vmovups   .L_2il0floatpacket.6(%rip), %zmm21            #502.31
        vmovups   (%rsp), %zmm22                                #502.31[spill]
        vmovups   64(%rsp), %zmm23                              #502.31[spill]
        vmovups   128(%rsp), %zmm24                             #502.31[spill]
                                # LOE rax rdx rcx rbx rsi r13d zmm0 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24
movl      $111, %ebx # OSACA START MARKER
.byte     100        # OSACA START MARKER
.byte     103        # OSACA START MARKER
.byte     144        # OSACA START MARKER
# pointer_increment=64 7fb3a6c85239682e1bd1d29c30267e79
# LLVM-MCA-BEGIN
..B7.28:                        # Preds ..B7.28 ..B7.27
                                # Execution count [2.50e+01]
        movl      (%rcx,%rax,4), %edi                           #499.22
        movl      %r13d, %r12d                                  #528.39
        movslq    %edi, %rdi                                    #500.31
        incq      %rax                                          #498.9
        vmovups   320(%rsp), %zmm10                             #512.35[spill]
        testl     $2147483647, %edi                             #526.56
        vmovups   256(%rsp), %zmm11                             #514.35[spill]
        vmovups   192(%rsp), %zmm9                              #515.35[spill]
        sete      %r12b                                         #528.39
        lea       (%rdi,%rdi,2), %r14                           #501.31
        shlq      $5, %r14                                      #501.31
        movl      %r12d, %r8d                                   #528.39
        negl      %r8d                                          #528.39
        movl      %r12d, %r11d                                  #531.39
        addl      $255, %r8d                                    #528.39
        kmovw     %r8d, %k0                                     #546.41
        lea       (%r12,%r12,2), %r9d                           #529.39
        vsubps    64(%r14,%rbx), %zmm13, %zmm3                  #508.35
        vsubps    (%r14,%rbx), %zmm10, %zmm4                    #512.35
        vsubps    64(%r14,%rbx), %zmm11, %zmm10                 #514.35
        vsubps    32(%r14,%rbx), %zmm17, %zmm5                  #507.35
        vsubps    (%r14,%rbx), %zmm19, %zmm27                   #506.35
        vsubps    32(%r14,%rbx), %zmm15, %zmm8                  #513.35
        vsubps    64(%r14,%rbx), %zmm0, %zmm11                  #517.35
        vsubps    (%r14,%rbx), %zmm9, %zmm7                     #515.35
        vsubps    32(%r14,%rbx), %zmm14, %zmm9                  #516.35
        vsubps    64(%r14,%rbx), %zmm12, %zmm29                 #511.35
        vsubps    32(%r14,%rbx), %zmm16, %zmm28                 #510.35
        vsubps    (%r14,%rbx), %zmm18, %zmm25                   #509.35
        vmulps    %zmm3, %zmm3, %zmm2                           #541.80
        vmulps    %zmm10, %zmm10, %zmm30                        #543.80
        vmulps    %zmm11, %zmm11, %zmm1                         #544.80
        vmulps    %zmm29, %zmm29, %zmm26                        #542.80
        vfmadd231ps %zmm5, %zmm5, %zmm2                         #541.57
        vfmadd231ps %zmm8, %zmm8, %zmm30                        #543.57
        vfmadd231ps %zmm9, %zmm9, %zmm1                         #544.57
        vfmadd231ps %zmm28, %zmm28, %zmm26                      #542.57
        vfmadd231ps %zmm27, %zmm27, %zmm2                       #541.34
        vfmadd231ps %zmm4, %zmm4, %zmm30                        #543.34
        vfmadd231ps %zmm7, %zmm7, %zmm1                         #544.34
        vfmadd231ps %zmm25, %zmm25, %zmm26                      #542.34
        vrcp14ps  %zmm2, %zmm31                                 #551.35
        vcmpps    $17, %zmm24, %zmm30, %k7                      #548.67
        vrcp14ps  %zmm30, %zmm6                                 #553.35
        vcmpps    $17, %zmm24, %zmm2, %k3                       #546.67
        vrcp14ps  %zmm1, %zmm2                                  #554.35
        vcmpps    $17, %zmm24, %zmm26, %k5                      #547.67
        vrcp14ps  %zmm26, %zmm26                                #552.35
        vmulps    %zmm23, %zmm31, %zmm30                        #556.67
        kandw     %k3, %k0, %k2                                 #546.41
        vcmpps    $17, %zmm24, %zmm1, %k3                       #549.67
        vmulps    %zmm30, %zmm31, %zmm1                         #556.51
        vmulps    %zmm1, %zmm31, %zmm30                         #556.35
        negl      %r9d                                          #529.39
        vfmsub213ps %zmm20, %zmm31, %zmm1                       #561.79
        vmulps    %zmm22, %zmm31, %zmm31                        #561.105
        vmulps    %zmm31, %zmm1, %zmm31                         #561.70
        addl      $255, %r9d                                    #529.39
        kmovw     %r9d, %k4                                     #547.41
        vmulps    %zmm31, %zmm30, %zmm30                        #561.54
        kandw     %k5, %k4, %k1                                 #547.41
        vmulps    %zmm30, %zmm21, %zmm1                         #561.36
        vmulps    %zmm23, %zmm26, %zmm30                        #557.67
        vmulps    %zmm30, %zmm26, %zmm31                        #557.51
        lea       (,%r12,8), %r10d                              #530.39
        vmulps    %zmm31, %zmm26, %zmm30                        #557.35
        negl      %r10d                                         #530.39
        vfmsub213ps %zmm20, %zmm26, %zmm31                      #562.79
        vmulps    %zmm22, %zmm26, %zmm26                        #562.105
        vmulps    %zmm26, %zmm31, %zmm31                        #562.70
        addl      %r12d, %r10d                                  #530.39
        vmulps    %zmm31, %zmm30, %zmm30                        #562.54
        addl      $255, %r10d                                   #530.39
        kmovw     %r10d, %k6                                    #548.41
        vmulps    %zmm30, %zmm21, %zmm26                        #562.36
        kandw     %k7, %k6, %k4                                 #548.41
        vmulps    %zmm26, %zmm25, %zmm25{%k1}{z}                #569.33
        vmulps    %zmm26, %zmm28, %zmm31{%k1}{z}                #570.33
        vmulps    %zmm23, %zmm6, %zmm28                         #558.67
        vmulps    %zmm26, %zmm29, %zmm30{%k1}{z}                #571.33
        vmulps    %zmm23, %zmm2, %zmm29                         #559.67
        vfmadd231ps %zmm1, %zmm27, %zmm25{%k2}                  #599.83
        vfmadd231ps %zmm1, %zmm5, %zmm31{%k2}                   #600.83
        vmulps    %zmm28, %zmm6, %zmm27                         #558.51
        vfmadd231ps %zmm1, %zmm3, %zmm30{%k2}                   #601.83
        vmulps    %zmm29, %zmm2, %zmm1                          #559.51
        vmulps    %zmm27, %zmm6, %zmm5                          #558.35
        vfmsub213ps %zmm20, %zmm6, %zmm27                       #563.79
        vmulps    %zmm22, %zmm6, %zmm6                          #563.105
        vmulps    %zmm1, %zmm2, %zmm3                           #559.35
        vfmsub213ps %zmm20, %zmm2, %zmm1                        #564.79
        vmulps    %zmm22, %zmm2, %zmm2                          #564.105
        vmulps    %zmm6, %zmm27, %zmm26                         #563.70
        vmulps    %zmm2, %zmm1, %zmm1                           #564.70
        vmulps    %zmm26, %zmm5, %zmm5                          #563.54
        vmulps    %zmm1, %zmm3, %zmm3                           #564.54
        vmulps    %zmm5, %zmm21, %zmm6                          #563.36
        vmulps    %zmm3, %zmm21, %zmm27                         #564.36
        vfmadd231ps %zmm6, %zmm4, %zmm25{%k4}                   #599.89
        vmovups   (%r14,%rsi), %zmm4                            #599.44
        vfmadd231ps %zmm6, %zmm8, %zmm31{%k4}                   #600.89
        vfmadd231ps %zmm6, %zmm10, %zmm30{%k4}                  #601.89
        shll      $4, %r11d                                     #531.39
        subl      %r11d, %r12d                                  #531.39
        addl      $255, %r12d                                   #531.39
        kmovw     %r12d, %k0                                    #549.41
        kandw     %k3, %k0, %k5                                 #549.41
        vfmadd231ps %zmm27, %zmm7, %zmm25{%k5}                  #599.95
        vfmadd231ps %zmm27, %zmm9, %zmm31{%k5}                  #600.95
        vfmadd231ps %zmm27, %zmm11, %zmm30{%k5}                 #601.95
        vsubps    %zmm25, %zmm4, %zmm7                          #599.95
        vmovups   %zmm7, (%r14,%rsi)                            #599.13
        vmovups   32(%r14,%rsi), %zmm8                          #600.44
        vsubps    %zmm31, %zmm8, %zmm4                          #600.95
        vmovups   %zmm4, 32(%r14,%rsi)                          #600.13
        vmovups   64(%r14,%rsi), %zmm1                          #601.44
        vsubps    %zmm30, %zmm1, %zmm2                          #601.95
        vmovups   %zmm2, 64(%r14,%rsi)                          #601.13
        cmpq      %rdx, %rax                                    #498.9
        jb        ..B7.28       # Prob 82%                      #498.9
# LLVM-MCA-END
movl      $222, %ebx # OSACA END MARKER
.byte     100        # OSACA END MARKER
.byte     103        # OSACA END MARKER
.byte     144        # OSACA END MARKER
                                # LOE rax rdx rcx rbx rsi r13d zmm0 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24
..B7.30:                        # Preds ..B7.28 ..B7.26
                                # Execution count [5.00e+00]
        movl      $il0_peep_printf_format_2, %edi               #605.9
        movq      stderr(%rip), %rsi                            #605.9
        vzeroupper                                              #605.9
        call      fputs                                         #605.9
                                # LOE
..B7.31:                        # Preds ..B7.30
                                # Execution count [5.00e+00]
        movl      $-1, %edi                                     #605.9
#       exit(int)
        call      exit                                          #605.9
                                # LOE
..B7.32:                        # Preds ..B7.25
                                # Execution count [1.00e+00]: Infreq
        movl      $.L_2__STRING.2, %edi                         #614.5
..___tag_value_computeForceLJ_4xn_half.369:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #614.5
..___tag_value_computeForceLJ_4xn_half.370:
                                # LOE rbx r12
..B7.33:                        # Preds ..B7.32
                                # Execution count [1.00e+00]: Infreq
        xorl      %eax, %eax                                    #617.16
..___tag_value_computeForceLJ_4xn_half.371:
#       getTimeStamp()
        call      getTimeStamp                                  #617.16
..___tag_value_computeForceLJ_4xn_half.372:
                                # LOE rbx r12 xmm0
..B7.41:                        # Preds ..B7.33
                                # Execution count [1.00e+00]: Infreq
        vmovsd    %xmm0, (%rsp)                                 #617.16[spill]
                                # LOE rbx r12
..B7.34:                        # Preds ..B7.41
                                # Execution count [1.00e+00]: Infreq
        movl      $.L_2__STRING.7, %edi                         #618.5
        xorl      %eax, %eax                                    #618.5
..___tag_value_computeForceLJ_4xn_half.374:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #618.5
..___tag_value_computeForceLJ_4xn_half.375:
                                # LOE rbx r12
..B7.35:                        # Preds ..B7.34
                                # Execution count [1.00e+00]: Infreq
        vmovsd    (%rsp), %xmm0                                 #619.14[spill]
        vsubsd    200(%rsp), %xmm0, %xmm0                       #619.14[spill]
        addq      $424, %rsp                                    #619.14
	.cfi_restore 15
        popq      %r15                                          #619.14
	.cfi_restore 14
        popq      %r14                                          #619.14
	.cfi_restore 13
        popq      %r13                                          #619.14
        movq      %rbp, %rsp                                    #619.14
        popq      %rbp                                          #619.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #619.14
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0x00, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B7.36:                        # Preds ..B7.5 ..B7.9
                                # Execution count [4.50e-01]: Infreq
        movl      %r13d, %r9d                                   #448.9
        jmp       ..B7.17       # Prob 100%                     #448.9
        .align    16,0x90
                                # LOE rax rcx rsi r11 r12 r14 r15 edx edi r9d r10d r13d xmm0 xmm1 xmm2
	.cfi_endproc
# mark_end;
	.type	computeForceLJ_4xn_half,@function
	.size	computeForceLJ_4xn_half,.-computeForceLJ_4xn_half
..LNcomputeForceLJ_4xn_half.6:
	.section .rodata.str1.32, "aMS",@progbits,1
	.space 3, 0x00 	# pad
	.align 32
il0_peep_printf_format_2:
	.long	1684892019
	.long	1918855263
	.long	1668637797
	.long	1970495333
	.long	975775853
	.long	1818313504
	.long	543450476
	.long	1752459639
	.long	1482047776
	.long	540160309
	.long	1920233065
	.long	1769172585
	.long	1629516643
	.long	1931502702
	.long	1818717801
	.long	1919954277
	.long	1936286565
	.long	544108393
	.long	1667852407
	.long	1936269416
	.long	1953459744
	.long	1818326560
	.long	169960553
	.byte	0
	.data
# -- End  computeForceLJ_4xn_half
	.section .rodata, "a"
	.align 64
	.align 64
.L_2il0floatpacket.6:
	.long	0x42400000,0x42400000,0x42400000,0x42400000,0x42400000,0x42400000,0x42400000,0x42400000,0x42400000,0x42400000,0x42400000,0x42400000,0x42400000,0x42400000,0x42400000,0x42400000
	.type	.L_2il0floatpacket.6,@object
	.size	.L_2il0floatpacket.6,64
	.align 64
.L_2il0floatpacket.7:
	.long	0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000
	.type	.L_2il0floatpacket.7,@object
	.size	.L_2il0floatpacket.7,64
	.align 64
.L_2il0floatpacket.8:
	.long	0x00000008,0x00000009,0x0000000a,0x0000000b,0x0000000c,0x0000000d,0x0000000e,0x0000000f,0x00000008,0x00000009,0x0000000a,0x0000000b,0x0000000c,0x0000000d,0x0000000e,0x0000000f
	.type	.L_2il0floatpacket.8,@object
	.size	.L_2il0floatpacket.8,64
	.align 16
.L_2il0floatpacket.0:
	.long	0x00000004,0x00000004,0x00000004,0x00000004
	.type	.L_2il0floatpacket.0,@object
	.size	.L_2il0floatpacket.0,16
	.align 16
.L_2il0floatpacket.1:
	.long	0x00000000,0x00000001,0x00000002,0x00000003
	.type	.L_2il0floatpacket.1,@object
	.size	.L_2il0floatpacket.1,16
	.align 8
.L_2il0floatpacket.2:
	.long	0x00000000,0x3fe00000
	.type	.L_2il0floatpacket.2,@object
	.size	.L_2il0floatpacket.2,8
	.align 4
.L_2il0floatpacket.3:
	.long	0x42400000
	.type	.L_2il0floatpacket.3,@object
	.size	.L_2il0floatpacket.3,4
	.align 4
.L_2il0floatpacket.4:
	.long	0x3f000000
	.type	.L_2il0floatpacket.4,@object
	.size	.L_2il0floatpacket.4,4
	.align 4
.L_2il0floatpacket.5:
	.long	0x3f800000
	.type	.L_2il0floatpacket.5,@object
	.size	.L_2il0floatpacket.5,4
	.section .rodata.str1.4, "aMS",@progbits,1
	.align 4
	.align 4
.L_2__STRING.1:
	.long	1886220131
	.long	1181054069
	.long	1701016175
	.long	1646283340
	.long	1852401509
	.word	10
	.type	.L_2__STRING.1,@object
	.size	.L_2__STRING.1,22
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.2:
	.long	1668444006
	.word	101
	.type	.L_2__STRING.2,@object
	.size	.L_2__STRING.2,6
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.3:
	.long	1886220131
	.long	1181054069
	.long	1701016175
	.long	1696614988
	.long	681070
	.type	.L_2__STRING.3,@object
	.size	.L_2__STRING.3,20
	.align 4
.L_2__STRING.4:
	.long	1886220131
	.long	1181054069
	.long	1701016175
	.long	845105740
	.long	544108152
	.long	1768383842
	.word	2670
	.byte	0
	.type	.L_2__STRING.4,@object
	.size	.L_2__STRING.4,27
	.space 1, 0x00 	# pad
	.align 4
.L_2__STRING.5:
	.long	1886220131
	.long	1181054069
	.long	1701016175
	.long	845105740
	.long	544108152
	.long	174354021
	.byte	0
	.type	.L_2__STRING.5,@object
	.size	.L_2__STRING.5,25
	.space 3, 0x00 	# pad
	.align 4
.L_2__STRING.6:
	.long	1886220131
	.long	1181054069
	.long	1701016175
	.long	878660172
	.long	1646292600
	.long	1852401509
	.word	10
	.type	.L_2__STRING.6,@object
	.size	.L_2__STRING.6,26
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.7:
	.long	1886220131
	.long	1181054069
	.long	1701016175
	.long	878660172
	.long	1696624248
	.long	681070
	.type	.L_2__STRING.7,@object
	.size	.L_2__STRING.7,24
	.data
	.section .note.GNU-stack, ""
# End
