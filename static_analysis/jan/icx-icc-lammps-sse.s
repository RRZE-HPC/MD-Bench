# mark_description "Intel(R) C Intel(R) 64 Compiler Classic for applications running on Intel(R) 64, Version 2021.6.0 Build 2022";
# mark_description "0226_000000";
# mark_description "-I/apps/likwid/5.2.2/include -I././lammps/includes -I././common/includes -S -std=c11 -pedantic-errors -D_GNU";
# mark_description "_SOURCE -DLIKWID_PERFMON -DAOS -DPRECISION=2 -DCOMPUTE_STATS -DVECTOR_WIDTH=2 -DENABLE_OMP_SIMD -DALIGNMENT=";
# mark_description "64 -restrict -Ofast -xSSE4.2 -o build-lammps-ICC-SSE-DP/force_lj.s";
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
        pushq     %r14                                          #23.104
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
        pushq     %r15                                          #23.104
	.cfi_def_cfa_offset 24
	.cfi_offset 15, -24
        pushq     %rbx                                          #23.104
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
        pushq     %rbp                                          #23.104
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
        subq      $136, %rsp                                    #23.104
	.cfi_def_cfa_offset 176
        movq      %rsi, %r14                                    #23.104
        movsd     144(%rdi), %xmm0                              #27.27
        movq      %rcx, %rbp                                    #23.104
        mulsd     %xmm0, %xmm0                                  #27.45
        movq      %rdx, %r15                                    #23.104
        movsd     56(%rdi), %xmm1                               #28.23
        movsd     40(%rdi), %xmm2                               #29.24
        movl      4(%r14), %eax                                 #24.18
        movsd     %xmm0, 64(%rsp)                               #27.45[spill]
        movsd     %xmm1, 40(%rsp)                               #28.23[spill]
        movsd     %xmm2, 32(%rsp)                               #29.24[spill]
        testl     %eax, %eax                                    #32.24
        jle       ..B1.23       # Prob 50%                      #32.24
                                # LOE rbp r12 r13 r14 r15 eax
..B1.2:                         # Preds ..B1.1
                                # Execution count [5.00e-03]
        movslq    %eax, %rbx                                    #24.18
        lea       (%rax,%rax,2), %eax                           #24.18
        movq      64(%r14), %rdi                                #33.9
        cmpl      $12, %eax                                     #32.5
        jle       ..B1.29       # Prob 0%                       #32.5
                                # LOE rbx rbp rdi r12 r13 r14 r15
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
        xorl      %esi, %esi                                    #32.5
        lea       (%rbx,%rbx,2), %rdx                           #32.5
        shlq      $3, %rdx                                      #32.5
        call      _intel_fast_memset                            #32.5
                                # LOE rbx rbp r12 r13 r14 r15
..B1.5:                         # Preds ..B1.43 ..B1.3 ..B1.41
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #38.16
..___tag_value_computeForceLJFullNeigh_plain_c.15:
#       getTimeStamp()
        call      getTimeStamp                                  #38.16
..___tag_value_computeForceLJFullNeigh_plain_c.16:
                                # LOE rbx rbp r12 r13 r14 r15 xmm0
..B1.50:                        # Preds ..B1.5
                                # Execution count [1.00e+00]
        movsd     %xmm0, 24(%rsp)                               #38.16[spill]
                                # LOE rbx rbp r12 r13 r14 r15
..B1.6:                         # Preds ..B1.50
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.0, %edi                         #39.5
..___tag_value_computeForceLJFullNeigh_plain_c.18:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #39.5
..___tag_value_computeForceLJFullNeigh_plain_c.19:
                                # LOE rbx rbp r12 r13 r14 r15
..B1.7:                         # Preds ..B1.6
                                # Execution count [9.00e-01]
        movsd     .L_2il0floatpacket.3(%rip), %xmm13            #77.41
        xorl      %eax, %eax                                    #41.15
        mulsd     32(%rsp), %xmm13                              #77.41[spill]
        xorl      %ecx, %ecx                                    #41.5
        movddup   64(%rsp), %xmm3                               #27.25[spill]
        xorl      %edi, %edi                                    #41.5
        movddup   %xmm13, %xmm1                                 #77.41
        movq      16(%r15), %rdx                                #42.19
        movslq    8(%r15), %rsi                                 #42.43
        movq      24(%r15), %r15                                #43.25
        movups    .L_2il0floatpacket.2(%rip), %xmm2             #75.32
        movddup   40(%rsp), %xmm5                               #28.21[spill]
        movsd     40(%rsp), %xmm10                              #41.5[spill]
        movsd     64(%rsp), %xmm12                              #41.5[spill]
        movsd     .L_2il0floatpacket.5(%rip), %xmm7             #77.54
        shlq      $2, %rsi                                      #25.5
        movq      16(%r14), %r11                                #44.25
        movq      64(%r14), %r8                                 #89.9
        movq      (%rbp), %r9                                   #93.9
        movq      8(%rbp), %r10                                 #94.9
        movups    %xmm1, 112(%rsp)                              #41.5[spill]
        movups    %xmm3, 48(%rsp)                               #41.5[spill]
        movq      %rbx, 104(%rsp)                               #41.5[spill]
        movq      %rbp, (%rsp)                                  #41.5[spill]
        movq      %r12, 8(%rsp)                                 #41.5[spill]
        movq      %r13, 16(%rsp)                                #41.5[spill]
	.cfi_offset 12, -168
	.cfi_offset 13, -160
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r11 r15 xmm5 xmm7 xmm10 xmm12 xmm13
..B1.8:                         # Preds ..B1.21 ..B1.7
                                # Execution count [5.00e+00]
        movl      (%r15,%rcx,4), %ebx                           #43.25
        xorps     %xmm6, %xmm6                                  #47.22
        movaps    %xmm6, %xmm4                                  #48.22
        movsd     (%rdi,%r11), %xmm9                            #44.25
        movaps    %xmm4, %xmm0                                  #49.22
        movsd     8(%rdi,%r11), %xmm8                           #45.25
        movsd     16(%rdi,%r11), %xmm11                         #46.25
        movslq    %ebx, %r13                                    #56.9
        testl     %ebx, %ebx                                    #56.28
        jle       ..B1.21       # Prob 50%                      #56.28
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r11 r13 r15 ebx xmm0 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B1.9:                         # Preds ..B1.8
                                # Execution count [4.50e+00]
        cmpq      $2, %r13                                      #56.9
        jl        ..B1.28       # Prob 10%                      #56.9
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r11 r13 r15 ebx xmm0 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B1.10:                        # Preds ..B1.9
                                # Execution count [4.50e+00]
        movq      %rsi, %r14                                    #42.43
        movl      %ebx, %ebp                                    #56.9
        imulq     %rax, %r14                                    #42.43
        xorps     %xmm6, %xmm6                                  #47.22
        andl      $-2, %ebp                                     #56.9
        movaps    %xmm6, %xmm4                                  #48.22
        movsd     %xmm8, 80(%rsp)                               #71.22[spill]
        movaps    %xmm4, %xmm0                                  #49.22
        movsd     %xmm9, 88(%rsp)                               #71.22[spill]
        xorl      %r12d, %r12d                                  #56.9
        movslq    %ebp, %rbp                                    #56.9
        addq      %rdx, %r14                                    #25.5
        movddup   %xmm9, %xmm1                                  #44.23
        movddup   %xmm8, %xmm2                                  #45.23
        movddup   %xmm11, %xmm3                                 #46.23
        movsd     %xmm11, 72(%rsp)                              #71.22[spill]
        movsd     %xmm13, 96(%rsp)                              #71.22[spill]
        movq      %rcx, 32(%rsp)                                #71.22[spill]
        movups    48(%rsp), %xmm8                               #71.22[spill]
        movdqu    .L_2il0floatpacket.1(%rip), %xmm9             #71.22
        movdqu    .L_2il0floatpacket.0(%rip), %xmm10            #71.22
                                # LOE rax rdx rbp rsi rdi r8 r9 r10 r11 r12 r13 r14 r15 ebx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm9 xmm10
# LLVM-MCA-BEGIN
# OSACA-BEGIN
..B1.11:                        # Preds ..B1.13 ..B1.10
                                # Execution count [2.50e+01]
        movq      (%r14,%r12,4), %xmm15                         #57.21
        movdqa    %xmm10, %xmm13                                #59.36
        movdqa    %xmm15, %xmm7                                 #58.36
        paddd     %xmm15, %xmm7                                 #58.36
        paddd     %xmm7, %xmm15                                 #58.36
        movaps    %xmm1, %xmm7                                  #58.36
        movd      %xmm15, %ecx                                  #58.36
        paddd     %xmm15, %xmm13                                #59.36
        pshufd    $57, %xmm15, %xmm11                           #58.36
        paddd     %xmm9, %xmm15                                 #60.36
        pshufd    $57, %xmm13, %xmm12                           #59.36
        movslq    %ecx, %rcx                                    #58.36
        movsd     (%r11,%rcx,8), %xmm14                         #58.36
        movd      %xmm11, %ecx                                  #58.36
        movaps    %xmm2, %xmm11                                 #59.36
        movslq    %ecx, %rcx                                    #58.36
        movhpd    (%r11,%rcx,8), %xmm14                         #58.36
        movd      %xmm13, %ecx                                  #59.36
        subpd     %xmm14, %xmm7                                 #58.36
        movslq    %ecx, %rcx                                    #59.36
        movsd     (%r11,%rcx,8), %xmm14                         #59.36
        movd      %xmm12, %ecx                                  #59.36
        movslq    %ecx, %rcx                                    #59.36
        movhpd    (%r11,%rcx,8), %xmm14                         #59.36
        movd      %xmm15, %ecx                                  #60.36
        pshufd    $57, %xmm15, %xmm15                           #60.36
        subpd     %xmm14, %xmm11                                #59.36
        movslq    %ecx, %rcx                                    #60.36
        movaps    %xmm7, %xmm14                                 #61.35
        movaps    %xmm11, %xmm12                                #61.49
        mulpd     %xmm7, %xmm14                                 #61.35
        mulpd     %xmm11, %xmm12                                #61.49
        movsd     (%r11,%rcx,8), %xmm13                         #60.36
        movd      %xmm15, %ecx                                  #60.36
        movaps    %xmm3, %xmm15                                 #60.36
        addpd     %xmm12, %xmm14                                #61.49
        movslq    %ecx, %rcx                                    #60.36
        pcmpeqd   %xmm12, %xmm12                                #71.22
        movhpd    (%r11,%rcx,8), %xmm13                         #60.36
        subpd     %xmm13, %xmm15                                #60.36
        movaps    %xmm15, %xmm13                                #61.63
        mulpd     %xmm15, %xmm13                                #61.63
        addpd     %xmm13, %xmm14                                #61.63
        movaps    %xmm14, %xmm13                                #71.22
        cmpltpd   %xmm8, %xmm13                                 #71.22
        ptest     %xmm12, %xmm13                                #71.22
        je        ..B1.13       # Prob 50%                      #71.22
                                # LOE rax rdx rbp rsi rdi r8 r9 r10 r11 r12 r13 r14 r15 ebx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm13 xmm14 xmm15
..B1.12:                        # Preds ..B1.11
                                # Execution count [1.25e+01]
        movups    .L_2il0floatpacket.2(%rip), %xmm12            #75.38
        divpd     %xmm14, %xmm12                                #75.38
        movaps    %xmm5, %xmm14                                 #76.38
        mulpd     %xmm12, %xmm14                                #76.38
        mulpd     %xmm12, %xmm14                                #76.44
        mulpd     %xmm12, %xmm14                                #76.50
        mulpd     112(%rsp), %xmm12                             #77.54[spill]
        mulpd     %xmm14, %xmm12                                #77.61
        subpd     .L_2il0floatpacket.4(%rip), %xmm14            #77.54
        mulpd     %xmm14, %xmm12                                #77.67
        mulpd     %xmm12, %xmm7                                 #78.31
        mulpd     %xmm12, %xmm11                                #79.31
        mulpd     %xmm12, %xmm15                                #80.31
        andps     %xmm13, %xmm7                                 #78.31
        andps     %xmm13, %xmm11                                #79.31
        andps     %xmm15, %xmm13                                #80.31
        addpd     %xmm7, %xmm6                                  #78.17
        addpd     %xmm11, %xmm4                                 #79.17
        addpd     %xmm13, %xmm0                                 #80.17
                                # LOE rax rdx rbp rsi rdi r8 r9 r10 r11 r12 r13 r14 r15 ebx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm9 xmm10
..B1.13:                        # Preds ..B1.12 ..B1.11
                                # Execution count [2.50e+01]
        addq      $2, %r12                                      #56.9
        cmpq      %rbp, %r12                                    #56.9
        jb        ..B1.11       # Prob 82%                      #56.9
# OSACA-END
# LLVM-MCA-END
                                # LOE rax rdx rbp rsi rdi r8 r9 r10 r11 r12 r13 r14 r15 ebx xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm9 xmm10
..B1.14:                        # Preds ..B1.13
                                # Execution count [4.50e+00]
        movaps    %xmm0, %xmm1                                  #49.22
        movaps    %xmm4, %xmm2                                  #48.22
        movaps    %xmm6, %xmm3                                  #47.22
        unpckhpd  %xmm0, %xmm1                                  #49.22
        unpckhpd  %xmm4, %xmm2                                  #48.22
        addsd     %xmm1, %xmm0                                  #49.22
        addsd     %xmm2, %xmm4                                  #48.22
        unpckhpd  %xmm6, %xmm3                                  #47.22
        movsd     72(%rsp), %xmm11                              #[spill]
        addsd     %xmm3, %xmm6                                  #47.22
        movsd     80(%rsp), %xmm8                               #[spill]
        movsd     88(%rsp), %xmm9                               #[spill]
        movsd     96(%rsp), %xmm13                              #[spill]
        movsd     40(%rsp), %xmm10                              #[spill]
        movsd     64(%rsp), %xmm12                              #[spill]
        movq      32(%rsp), %rcx                                #[spill]
        movsd     .L_2il0floatpacket.5(%rip), %xmm7             #
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11 r13 r15 ebx xmm0 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B1.15:                        # Preds ..B1.14 ..B1.28
                                # Execution count [5.00e+00]
        cmpq      %r13, %rbp                                    #56.9
        jae       ..B1.21       # Prob 10%                      #56.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11 r13 r15 ebx xmm0 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B1.16:                        # Preds ..B1.15
                                # Execution count [4.50e+00]
        imulq     %rsi, %rax                                    #42.43
        addq      %rdx, %rax                                    #25.5
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11 r13 r15 ebx xmm0 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B1.17:                        # Preds ..B1.19 ..B1.16
                                # Execution count [2.50e+01]
        movl      (%rax,%rbp,4), %r12d                          #57.21
        movaps    %xmm9, %xmm14                                 #58.36
        movaps    %xmm8, %xmm3                                  #59.36
        movaps    %xmm11, %xmm2                                 #60.36
        lea       (%r12,%r12,2), %r14d                          #58.36
        movslq    %r14d, %r14                                   #58.36
        subsd     (%r11,%r14,8), %xmm14                         #58.36
        subsd     8(%r11,%r14,8), %xmm3                         #59.36
        subsd     16(%r11,%r14,8), %xmm2                        #60.36
        movaps    %xmm14, %xmm15                                #61.35
        movaps    %xmm3, %xmm1                                  #61.49
        mulsd     %xmm14, %xmm15                                #61.35
        mulsd     %xmm3, %xmm1                                  #61.49
        addsd     %xmm1, %xmm15                                 #61.49
        movaps    %xmm2, %xmm1                                  #61.63
        mulsd     %xmm2, %xmm1                                  #61.63
        addsd     %xmm1, %xmm15                                 #61.63
        comisd    %xmm15, %xmm12                                #71.22
        jbe       ..B1.19       # Prob 50%                      #71.22
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11 r13 r15 ebx xmm0 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14 xmm15
..B1.18:                        # Preds ..B1.17
                                # Execution count [1.25e+01]
        movsd     .L_2il0floatpacket.6(%rip), %xmm1             #75.38
        divsd     %xmm15, %xmm1                                 #75.38
        movaps    %xmm10, %xmm15                                #76.38
        mulsd     %xmm1, %xmm15                                 #76.38
        mulsd     %xmm1, %xmm15                                 #76.44
        mulsd     %xmm1, %xmm15                                 #76.50
        mulsd     %xmm13, %xmm1                                 #77.54
        mulsd     %xmm15, %xmm1                                 #77.61
        subsd     %xmm7, %xmm15                                 #77.54
        mulsd     %xmm15, %xmm1                                 #77.67
        mulsd     %xmm1, %xmm14                                 #78.31
        mulsd     %xmm1, %xmm3                                  #79.31
        mulsd     %xmm1, %xmm2                                  #80.31
        addsd     %xmm14, %xmm6                                 #78.17
        addsd     %xmm3, %xmm4                                  #79.17
        addsd     %xmm2, %xmm0                                  #80.17
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11 r13 r15 ebx xmm0 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B1.19:                        # Preds ..B1.18 ..B1.17
                                # Execution count [2.50e+01]
        incq      %rbp                                          #56.9
        cmpq      %r13, %rbp                                    #56.9
        jb        ..B1.17       # Prob 82%                      #56.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11 r13 r15 ebx xmm0 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B1.21:                        # Preds ..B1.19 ..B1.8 ..B1.15
                                # Execution count [5.00e+00]
        addq      %r13, %r9                                     #93.9
        lea       1(%rbx), %eax                                 #94.9
        shrl      $31, %eax                                     #94.9
        addsd     (%rdi,%r8), %xmm6                             #89.9
        addsd     8(%rdi,%r8), %xmm4                            #90.9
        addsd     16(%rdi,%r8), %xmm0                           #91.9
        movsd     %xmm6, (%rdi,%r8)                             #89.9
        lea       1(%rbx,%rax), %ebx                            #94.9
        sarl      $1, %ebx                                      #94.9
        movslq    %ebx, %rbx                                    #94.9
        movslq    %ecx, %rax                                    #41.32
        incq      %rcx                                          #41.5
        movsd     %xmm4, 8(%rdi,%r8)                            #90.9
        addq      %rbx, %r10                                    #94.9
        movsd     %xmm0, 16(%rdi,%r8)                           #91.9
        addq      $24, %rdi                                     #41.5
        incq      %rax                                          #41.32
        cmpq      104(%rsp), %rcx                               #41.5[spill]
        jb        ..B1.8        # Prob 82%                      #41.5
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r11 r15 xmm5 xmm7 xmm10 xmm12 xmm13
..B1.22:                        # Preds ..B1.21
                                # Execution count [9.00e-01]
        movq      (%rsp), %rbp                                  #[spill]
        movq      8(%rsp), %r12                                 #[spill]
	.cfi_restore 12
        movq      16(%rsp), %r13                                #[spill]
	.cfi_restore 13
        movq      %r9, (%rbp)                                   #93.9
        movq      %r10, 8(%rbp)                                 #94.9
        jmp       ..B1.25       # Prob 100%                     #94.9
                                # LOE r12 r13
..B1.23:                        # Preds ..B1.1
                                # Execution count [5.00e-01]
        xorl      %eax, %eax                                    #38.16
..___tag_value_computeForceLJFullNeigh_plain_c.53:
#       getTimeStamp()
        call      getTimeStamp                                  #38.16
..___tag_value_computeForceLJFullNeigh_plain_c.54:
                                # LOE r12 r13 xmm0
..B1.51:                        # Preds ..B1.23
                                # Execution count [5.00e-01]
        movsd     %xmm0, 24(%rsp)                               #38.16[spill]
                                # LOE r12 r13
..B1.24:                        # Preds ..B1.51
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.0, %edi                         #39.5
..___tag_value_computeForceLJFullNeigh_plain_c.56:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #39.5
..___tag_value_computeForceLJFullNeigh_plain_c.57:
                                # LOE r12 r13
..B1.25:                        # Preds ..B1.22 ..B1.24
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.0, %edi                         #97.5
..___tag_value_computeForceLJFullNeigh_plain_c.58:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #97.5
..___tag_value_computeForceLJFullNeigh_plain_c.59:
                                # LOE r12 r13
..B1.26:                        # Preds ..B1.25
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #98.16
..___tag_value_computeForceLJFullNeigh_plain_c.60:
#       getTimeStamp()
        call      getTimeStamp                                  #98.16
..___tag_value_computeForceLJFullNeigh_plain_c.61:
                                # LOE r12 r13 xmm0
..B1.27:                        # Preds ..B1.26
                                # Execution count [1.00e+00]
        subsd     24(%rsp), %xmm0                               #102.14[spill]
        addq      $136, %rsp                                    #102.14
	.cfi_def_cfa_offset 40
	.cfi_restore 6
        popq      %rbp                                          #102.14
	.cfi_def_cfa_offset 32
	.cfi_restore 3
        popq      %rbx                                          #102.14
	.cfi_def_cfa_offset 24
	.cfi_restore 15
        popq      %r15                                          #102.14
	.cfi_def_cfa_offset 16
	.cfi_restore 14
        popq      %r14                                          #102.14
	.cfi_def_cfa_offset 8
        ret                                                     #102.14
	.cfi_def_cfa_offset 176
	.cfi_offset 3, -32
	.cfi_offset 6, -40
	.cfi_offset 12, -168
	.cfi_offset 13, -160
	.cfi_offset 14, -16
	.cfi_offset 15, -24
                                # LOE
..B1.28:                        # Preds ..B1.9
                                # Execution count [4.50e-01]: Infreq
        xorl      %ebp, %ebp                                    #56.9
        jmp       ..B1.15       # Prob 100%                     #56.9
	.cfi_restore 12
	.cfi_restore 13
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11 r13 r15 ebx xmm0 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B1.29:                        # Preds ..B1.2
                                # Execution count [1.00e+00]: Infreq
        lea       (%rbx,%rbx,2), %rdx                           #24.18
        cmpq      $4, %rdx                                      #32.5
        jl        ..B1.45       # Prob 10%                      #32.5
                                # LOE rdx rbx rbp rdi r12 r13 r14 r15
..B1.30:                        # Preds ..B1.29
                                # Execution count [1.00e+00]: Infreq
        movq      %rdi, %rcx                                    #32.5
        andq      $15, %rcx                                     #32.5
        testl     %ecx, %ecx                                    #32.5
        je        ..B1.33       # Prob 50%                      #32.5
                                # LOE rdx rbx rbp rdi r12 r13 r14 r15 ecx
..B1.31:                        # Preds ..B1.30
                                # Execution count [1.00e+00]: Infreq
        testb     $7, %cl                                       #32.5
        jne       ..B1.45       # Prob 10%                      #32.5
                                # LOE rdx rbx rbp rdi r12 r13 r14 r15
..B1.32:                        # Preds ..B1.31
                                # Execution count [5.00e-01]: Infreq
        movl      $1, %ecx                                      #32.5
                                # LOE rdx rbx rbp rdi r12 r13 r14 r15 ecx
..B1.33:                        # Preds ..B1.32 ..B1.30
                                # Execution count [1.00e+00]: Infreq
        movl      %ecx, %eax                                    #32.5
        lea       4(%rax), %rsi                                 #32.5
        cmpq      %rsi, %rdx                                    #32.5
        jl        ..B1.45       # Prob 10%                      #32.5
                                # LOE rax rdx rbx rbp rdi r12 r13 r14 r15 ecx
..B1.34:                        # Preds ..B1.33
                                # Execution count [1.11e+00]: Infreq
        movl      %edx, %r9d                                    #32.5
        movl      %r9d, %esi                                    #32.5
        subl      %ecx, %esi                                    #32.5
        andl      $3, %esi                                      #32.5
        subl      %esi, %r9d                                    #32.5
        xorl      %esi, %esi                                    #32.5
        xorl      %r8d, %r8d                                    #33.22
        testl     %ecx, %ecx                                    #32.5
        movslq    %r9d, %rcx                                    #32.5
        jbe       ..B1.38       # Prob 10%                      #32.5
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r12 r13 r14 r15
..B1.36:                        # Preds ..B1.34 ..B1.36
                                # Execution count [5.56e+00]: Infreq
        movq      %r8, (%rdi,%rsi,8)                            #33.9
        incq      %rsi                                          #32.5
        cmpq      %rax, %rsi                                    #32.5
        jb        ..B1.36       # Prob 82%                      #32.5
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r12 r13 r14 r15
..B1.38:                        # Preds ..B1.36 ..B1.34
                                # Execution count [1.00e+00]: Infreq
        xorps     %xmm0, %xmm0                                  #33.22
                                # LOE rax rdx rcx rbx rbp rdi r12 r13 r14 r15 xmm0
..B1.39:                        # Preds ..B1.39 ..B1.38
                                # Execution count [5.56e+00]: Infreq
        movups    %xmm0, (%rdi,%rax,8)                          #33.9
        movups    %xmm0, 16(%rdi,%rax,8)                        #33.9
        addq      $4, %rax                                      #32.5
        cmpq      %rcx, %rax                                    #32.5
        jb        ..B1.39       # Prob 82%                      #32.5
                                # LOE rax rdx rcx rbx rbp rdi r12 r13 r14 r15 xmm0
..B1.41:                        # Preds ..B1.39 ..B1.45
                                # Execution count [1.11e+00]: Infreq
        cmpq      %rdx, %rcx                                    #32.5
        jae       ..B1.5        # Prob 10%                      #32.5
                                # LOE rdx rcx rbx rbp rdi r12 r13 r14 r15
..B1.43:                        # Preds ..B1.41 ..B1.43
                                # Execution count [5.56e+00]: Infreq
        movq      $0, (%rdi,%rcx,8)                             #33.9
        incq      %rcx                                          #32.5
        cmpq      %rdx, %rcx                                    #32.5
        jb        ..B1.43       # Prob 82%                      #32.5
        jmp       ..B1.5        # Prob 100%                     #32.5
                                # LOE rdx rcx rbx rbp rdi r12 r13 r14 r15
..B1.45:                        # Preds ..B1.29 ..B1.31 ..B1.33
                                # Execution count [1.00e-01]: Infreq
        xorl      %ecx, %ecx                                    #32.5
        jmp       ..B1.41       # Prob 100%                     #32.5
        .align    16,0x90
                                # LOE rdx rcx rbx rbp rdi r12 r13 r14 r15
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
..___tag_value_computeForceLJHalfNeigh.82:
..L83:
                                                         #105.96
        pushq     %r12                                          #105.96
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
        pushq     %r13                                          #105.96
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
        pushq     %r14                                          #105.96
	.cfi_def_cfa_offset 32
	.cfi_offset 14, -32
        pushq     %r15                                          #105.96
	.cfi_def_cfa_offset 40
	.cfi_offset 15, -40
        pushq     %rbx                                          #105.96
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
        pushq     %rbp                                          #105.96
	.cfi_def_cfa_offset 56
	.cfi_offset 6, -56
        subq      $216, %rsp                                    #105.96
	.cfi_def_cfa_offset 272
        movq      %rdi, %r15                                    #105.96
        movq      %rsi, %r12                                    #105.96
        movq      %rcx, %r14                                    #105.96
        movq      %rdx, %r13                                    #105.96
        movsd     144(%r15), %xmm0                              #109.27
        mulsd     %xmm0, %xmm0                                  #109.45
        movsd     56(%r15), %xmm1                               #110.23
        movsd     40(%r15), %xmm2                               #111.24
        movl      4(%r12), %ebp                                 #106.18
        movsd     %xmm0, 48(%rsp)                               #109.45[spill]
        movsd     %xmm1, 40(%rsp)                               #110.23[spill]
        movsd     %xmm2, 24(%rsp)                               #111.24[spill]
        testl     %ebp, %ebp                                    #114.24
        jle       ..B2.51       # Prob 50%                      #114.24
                                # LOE r12 r13 r14 r15 ebp
..B2.2:                         # Preds ..B2.1
                                # Execution count [5.00e-03]
        movslq    %ebp, %rbp                                    #106.18
        movq      64(%r12), %rdi                                #115.9
        lea       (%rbp,%rbp,2), %eax                           #106.18
        movq      %rbp, 32(%rsp)                                #106.18[spill]
        cmpl      $12, %eax                                     #114.5
        jle       ..B2.59       # Prob 0%                       #114.5
                                # LOE rbp rdi r12 r13 r14 r15 ebp
..B2.3:                         # Preds ..B2.2
                                # Execution count [1.00e+00]
        movq      %rbp, %rax                                    #114.5
        xorl      %esi, %esi                                    #114.5
        lea       (%rax,%rax,2), %rdx                           #114.5
        shlq      $3, %rdx                                      #114.5
        call      _intel_fast_memset                            #114.5
                                # LOE r12 r13 r14 r15 ebp
..B2.5:                         # Preds ..B2.73 ..B2.3 ..B2.71
                                # Execution count [1.00e+00]
        xorl      %ebx, %ebx                                    #120.22
        xorl      %eax, %eax                                    #121.16
..___tag_value_computeForceLJHalfNeigh.101:
#       getTimeStamp()
        call      getTimeStamp                                  #121.16
..___tag_value_computeForceLJHalfNeigh.102:
                                # LOE r12 r13 r14 r15 ebx ebp xmm0
..B2.80:                        # Preds ..B2.5
                                # Execution count [1.00e+00]
        movsd     %xmm0, 16(%rsp)                               #121.16[spill]
                                # LOE r12 r13 r14 r15 ebx ebp
..B2.6:                         # Preds ..B2.80
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.1, %edi                         #122.5
..___tag_value_computeForceLJHalfNeigh.104:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #122.5
..___tag_value_computeForceLJHalfNeigh.105:
                                # LOE r12 r13 r14 r15 ebx ebp
..B2.7:                         # Preds ..B2.6
                                # Execution count [9.00e-01]
        movsd     .L_2il0floatpacket.3(%rip), %xmm10            #161.41
        movd      %ebp, %xmm0                                   #106.18
        mulsd     24(%rsp), %xmm10                              #161.41[spill]
        xorl      %eax, %eax                                    #124.15
        movslq    8(%r13), %rdx                                 #125.43
        xorl      %edi, %edi                                    #124.5
        shlq      $2, %rdx                                      #107.5
        xorl      %r11d, %r11d                                  #124.5
        movddup   40(%rsp), %xmm3                               #110.21[spill]
        movddup   %xmm10, %xmm2                                 #161.41
        pshufd    $0, %xmm0, %xmm0                              #106.18
        movq      16(%r13), %rcx                                #125.19
        movq      %rdx, 56(%rsp)                                #124.5[spill]
        movddup   48(%rsp), %xmm6                               #109.25[spill]
        movsd     40(%rsp), %xmm8                               #124.5[spill]
        movsd     48(%rsp), %xmm13                              #124.5[spill]
        movq      32(%rsp), %rdx                                #124.5[spill]
        movups    .L_2il0floatpacket.4(%rip), %xmm1             #161.54
        movsd     .L_2il0floatpacket.5(%rip), %xmm7             #161.54
        movq      24(%r13), %r13                                #126.25
        movq      16(%r12), %rsi                                #127.25
        movq      64(%r12), %r8                                 #168.21
        movq      (%r14), %r9                                   #179.9
        movq      8(%r14), %r10                                 #180.9
        movdqu    %xmm0, 160(%rsp)                              #124.5[spill]
        movups    %xmm2, 192(%rsp)                              #124.5[spill]
        movups    %xmm3, 176(%rsp)                              #124.5[spill]
        movl      %ebp, 64(%rsp)                                #124.5[spill]
        movq      %r15, (%rsp)                                  #124.5[spill]
        movq      %r14, 8(%rsp)                                 #124.5[spill]
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r11 r13 ebx xmm6 xmm7 xmm8 xmm10 xmm13
..B2.8:                         # Preds ..B2.49 ..B2.7
                                # Execution count [5.00e+00]
        movl      (%r13,%rdi,4), %ebp                           #126.25
        addl      %ebp, %ebx                                    #138.9
        xorps     %xmm5, %xmm5                                  #130.22
        movaps    %xmm5, %xmm4                                  #131.22
        movsd     (%r11,%rsi), %xmm12                           #127.25
        movaps    %xmm4, %xmm2                                  #132.22
        movsd     8(%r11,%rsi), %xmm11                          #128.25
        movsd     16(%r11,%rsi), %xmm9                          #129.25
        testl     %ebp, %ebp                                    #143.9
        jle       ..B2.48       # Prob 50%                      #143.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r13 ebp xmm2 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B2.9:                         # Preds ..B2.8
                                # Execution count [2.50e+00]
        jbe       ..B2.48       # Prob 50%                      #143.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r13 ebp xmm2 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B2.10:                        # Preds ..B2.9
                                # Execution count [2.25e+00]
        cmpl      $2, %ebp                                      #143.9
        jb        ..B2.58       # Prob 10%                      #143.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r13 ebp xmm2 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B2.11:                        # Preds ..B2.10
                                # Execution count [2.25e+00]
        movq      56(%rsp), %r14                                #125.43[spill]
        movl      %ebp, %r12d                                   #143.9
        imulq     %rax, %r14                                    #125.43
        xorps     %xmm5, %xmm5                                  #130.22
        andl      $-2, %r12d                                    #143.9
        movaps    %xmm5, %xmm4                                  #131.22
        movsd     %xmm11, 128(%rsp)                             #143.9[spill]
        movaps    %xmm4, %xmm2                                  #132.22
        movsd     %xmm12, 136(%rsp)                             #143.9[spill]
        movddup   %xmm12, %xmm1                                 #127.23
        xorl      %r15d, %r15d                                  #143.9
        movddup   %xmm11, %xmm0                                 #128.23
        addq      %rcx, %r14                                    #107.5
        movddup   %xmm9, %xmm3                                  #129.23
        movslq    %r12d, %r12                                   #143.9
        movsd     %xmm9, 120(%rsp)                              #143.9[spill]
        movsd     %xmm10, 144(%rsp)                             #143.9[spill]
        movl      %ebp, 24(%rsp)                                #143.9[spill]
        movq      %r11, 72(%rsp)                                #143.9[spill]
        movq      %r10, 80(%rsp)                                #143.9[spill]
        movq      %r9, 88(%rsp)                                 #143.9[spill]
        movq      %r13, 96(%rsp)                                #143.9[spill]
        movq      %rcx, 104(%rsp)                               #143.9[spill]
        movq      %rdi, 112(%rsp)                               #143.9[spill]
        movdqu    .L_2il0floatpacket.1(%rip), %xmm11            #143.9
        movdqu    .L_2il0floatpacket.0(%rip), %xmm12            #143.9
                                # LOE rax rbx rsi r8 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm11 xmm12
..B2.12:                        # Preds ..B2.38 ..B2.11
                                # Execution count [1.25e+01]
        movq      (%r14,%r15,4), %xmm7                          #144.21
        movdqa    %xmm12, %xmm15                                #146.36
        movdqa    %xmm7, %xmm8                                  #145.36
        paddd     %xmm7, %xmm8                                  #145.36
        paddd     %xmm7, %xmm8                                  #145.36
        movd      %xmm8, %r9d                                   #145.36
        paddd     %xmm8, %xmm15                                 #146.36
        pshufd    $57, %xmm8, %xmm10                            #145.36
        paddd     %xmm11, %xmm8                                 #147.36
        pshufd    $57, %xmm15, %xmm13                           #146.36
        movd      %xmm10, %edi                                  #145.36
        movaps    %xmm1, %xmm10                                 #145.36
        movd      %xmm15, %ebp                                  #146.36
        movd      %xmm13, %ecx                                  #146.36
        movd      %xmm8, %edx                                   #147.36
        pshufd    $57, %xmm8, %xmm8                             #147.36
        movd      %xmm8, %r10d                                  #147.36
        movaps    %xmm3, %xmm8                                  #147.36
        movslq    %r9d, %r9                                     #145.36
        movslq    %edi, %rdi                                    #145.36
        movslq    %ebp, %rbp                                    #146.36
        movslq    %ecx, %rcx                                    #146.36
        movsd     (%rsi,%r9,8), %xmm9                           #145.36
        movhpd    (%rsi,%rdi,8), %xmm9                          #145.36
        movsd     (%rsi,%rbp,8), %xmm14                         #146.36
        subpd     %xmm9, %xmm10                                 #145.36
        movhpd    (%rsi,%rcx,8), %xmm14                         #146.36
        movaps    %xmm0, %xmm9                                  #146.36
        movslq    %edx, %rdx                                    #147.36
        subpd     %xmm14, %xmm9                                 #146.36
        movslq    %r10d, %r10                                   #147.36
        movaps    %xmm9, %xmm13                                 #148.49
        movsd     (%rsi,%rdx,8), %xmm15                         #147.36
        mulpd     %xmm9, %xmm13                                 #148.49
        movhpd    (%rsi,%r10,8), %xmm15                         #147.36
        subpd     %xmm15, %xmm8                                 #147.36
        movaps    %xmm10, %xmm15                                #148.35
        movaps    %xmm8, %xmm14                                 #148.63
        mulpd     %xmm10, %xmm15                                #148.35
        mulpd     %xmm8, %xmm14                                 #148.63
        addpd     %xmm13, %xmm15                                #148.49
        addpd     %xmm14, %xmm15                                #148.63
        movaps    %xmm15, %xmm13                                #158.22
        pcmpeqd   %xmm14, %xmm14                                #158.22
        cmpltpd   %xmm6, %xmm13                                 #158.22
        ptest     %xmm14, %xmm13                                #158.22
        je        ..B2.38       # Prob 50%                      #158.22
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r9 r10 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm15
..B2.13:                        # Preds ..B2.12
                                # Execution count [6.25e+00]
        movups    .L_2il0floatpacket.2(%rip), %xmm14            #159.38
        divpd     %xmm15, %xmm14                                #159.38
        movdqu    160(%rsp), %xmm15                             #167.24[spill]
        pcmpgtd   %xmm7, %xmm15                                 #167.24
        pmovsxdq  %xmm15, %xmm15                                #167.24
        pcmpeqd   %xmm7, %xmm7                                  #167.24
        andps     %xmm13, %xmm15                                #167.24
        ptest     %xmm7, %xmm15                                 #167.24
        movups    176(%rsp), %xmm7                              #160.38[spill]
        mulpd     %xmm14, %xmm7                                 #160.38
        mulpd     %xmm14, %xmm7                                 #160.44
        mulpd     %xmm14, %xmm7                                 #160.50
        mulpd     192(%rsp), %xmm14                             #161.54[spill]
        mulpd     %xmm7, %xmm14                                 #161.61
        subpd     .L_2il0floatpacket.4(%rip), %xmm7             #161.54
        mulpd     %xmm7, %xmm14                                 #161.67
        mulpd     %xmm14, %xmm10                                #162.31
        mulpd     %xmm14, %xmm9                                 #163.31
        mulpd     %xmm14, %xmm8                                 #164.31
        movaps    %xmm13, %xmm14                                #162.31
        movaps    %xmm13, %xmm7                                 #163.31
        andps     %xmm10, %xmm14                                #162.31
        andps     %xmm9, %xmm7                                  #163.31
        andps     %xmm8, %xmm13                                 #164.31
        addpd     %xmm14, %xmm5                                 #162.17
        addpd     %xmm7, %xmm4                                  #163.17
        addpd     %xmm13, %xmm2                                 #164.17
        je        ..B2.38       # Prob 50%                      #167.24
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r9 r10 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm9 xmm10 xmm11 xmm12 xmm15
..B2.14:                        # Preds ..B2.13
                                # Execution count [3.12e+00]
        movmskpd  %xmm15, %r13d                                 #168.21
        movl      %r13d, %r11d                                  #168.21
        andl      $2, %r11d                                     #168.21
        andl      $1, %r13d                                     #168.21
        je        ..B2.17       # Prob 40%                      #168.21
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r9 r10 r12 r14 r15 r11d r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm9 xmm10 xmm11 xmm12
..B2.15:                        # Preds ..B2.14
                                # Execution count [3.12e+00]
        movsd     (%r8,%r9,8), %xmm7                            #168.21
        testl     %r11d, %r11d                                  #168.21
        jne       ..B2.18       # Prob 60%                      #168.21
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r9 r10 r12 r14 r15 r11d r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12
..B2.16:                        # Preds ..B2.15
                                # Execution count [1.25e+00]
        xorps     %xmm13, %xmm13                                #168.21
        unpcklpd  %xmm13, %xmm7                                 #168.21
        subpd     %xmm10, %xmm7                                 #168.21
        jmp       ..B2.31       # Prob 100%                     #168.21
                                # LOE rax rdx rbx rbp rsi r8 r9 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm11 xmm12
..B2.17:                        # Preds ..B2.14
                                # Execution count [3.12e+00]
        testl     %r11d, %r11d                                  #168.21
        xorps     %xmm7, %xmm7                                  #168.21
        je        ..B2.30       # Prob 40%                      #168.21
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r9 r10 r12 r14 r15 r11d r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12
..B2.18:                        # Preds ..B2.15 ..B2.17
                                # Execution count [3.12e+00]
        testl     %r13d, %r13d                                  #168.21
        movhpd    (%r8,%rdi,8), %xmm7                           #168.21
        subpd     %xmm10, %xmm7                                 #168.21
        je        ..B2.20       # Prob 40%                      #168.21
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r9 r10 r12 r14 r15 r11d r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm11 xmm12
..B2.19:                        # Preds ..B2.18
                                # Execution count [1.88e+00]
        pshufd    $14, %xmm7, %xmm10                            #168.21
        movsd     %xmm7, (%r8,%r9,8)                            #168.21
        movsd     %xmm10, (%r8,%rdi,8)                          #168.21
        movsd     (%r8,%rbp,8), %xmm13                          #169.21
        jmp       ..B2.21       # Prob 100%                     #169.21
                                # LOE rax rdx rcx rbx rbp rsi r8 r10 r12 r14 r15 r11d r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm9 xmm11 xmm12 xmm13
..B2.20:                        # Preds ..B2.18
                                # Execution count [1.25e+00]
        pshufd    $14, %xmm7, %xmm7                             #168.21
        movsd     %xmm7, (%r8,%rdi,8)                           #168.21
        xorps     %xmm13, %xmm13                                #169.21
                                # LOE rax rdx rcx rbx rbp rsi r8 r10 r12 r14 r15 r11d r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm9 xmm11 xmm12 xmm13
..B2.21:                        # Preds ..B2.19 ..B2.20
                                # Execution count [1.88e+00]
        testl     %r11d, %r11d                                  #169.21
        je        ..B2.84       # Prob 40%                      #169.21
                                # LOE rax rdx rcx rbx rbp rsi r8 r10 r12 r14 r15 r11d r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm9 xmm11 xmm12 xmm13
..B2.22:                        # Preds ..B2.21
                                # Execution count [3.12e+00]
        testl     %r13d, %r13d                                  #169.21
        movhpd    (%r8,%rcx,8), %xmm13                          #169.21
        subpd     %xmm9, %xmm13                                 #169.21
        je        ..B2.24       # Prob 40%                      #169.21
                                # LOE rax rdx rcx rbx rbp rsi r8 r10 r12 r14 r15 r11d r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm11 xmm12 xmm13
..B2.23:                        # Preds ..B2.22
                                # Execution count [1.88e+00]
        pshufd    $14, %xmm13, %xmm7                            #169.21
        movsd     %xmm13, (%r8,%rbp,8)                          #169.21
        movsd     %xmm7, (%r8,%rcx,8)                           #169.21
        movsd     (%r8,%rdx,8), %xmm9                           #170.21
        jmp       ..B2.25       # Prob 100%                     #170.21
                                # LOE rax rdx rbx rsi r8 r10 r12 r14 r15 r11d r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm9 xmm11 xmm12
..B2.24:                        # Preds ..B2.22
                                # Execution count [1.25e+00]
        pshufd    $14, %xmm13, %xmm7                            #169.21
        movsd     %xmm7, (%r8,%rcx,8)                           #169.21
        xorps     %xmm9, %xmm9                                  #170.21
                                # LOE rax rdx rbx rsi r8 r10 r12 r14 r15 r11d r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm9 xmm11 xmm12
..B2.25:                        # Preds ..B2.23 ..B2.24
                                # Execution count [1.88e+00]
        testl     %r11d, %r11d                                  #170.21
        je        ..B2.83       # Prob 40%                      #170.21
                                # LOE rax rdx rbx rsi r8 r10 r12 r14 r15 r13d xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm9 xmm11 xmm12
..B2.26:                        # Preds ..B2.25
                                # Execution count [3.12e+00]
        testl     %r13d, %r13d                                  #170.21
        movhpd    (%r8,%r10,8), %xmm9                           #170.21
        subpd     %xmm8, %xmm9                                  #170.21
        je        ..B2.28       # Prob 40%                      #170.21
                                # LOE rax rdx rbx rsi r8 r10 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm9 xmm11 xmm12
..B2.27:                        # Preds ..B2.26
                                # Execution count [1.88e+00]
        movsd     %xmm9, (%r8,%rdx,8)                           #170.21
        pshufd    $14, %xmm9, %xmm7                             #170.21
        jmp       ..B2.29       # Prob 100%                     #170.21
                                # LOE rax rbx rsi r8 r10 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm11 xmm12
..B2.28:                        # Preds ..B2.26
                                # Execution count [1.25e+00]
        pshufd    $14, %xmm9, %xmm7                             #170.21
                                # LOE rax rbx rsi r8 r10 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm11 xmm12
..B2.29:                        # Preds ..B2.27 ..B2.28
                                # Execution count [3.12e+00]
        movsd     %xmm7, (%r8,%r10,8)                           #170.21
        jmp       ..B2.38       # Prob 100%                     #170.21
                                # LOE rax rbx rsi r8 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm11 xmm12
..B2.30:                        # Preds ..B2.17
                                # Execution count [1.88e+00]
        testl     %r13d, %r13d                                  #168.21
        xorps     %xmm7, %xmm7                                  #168.21
        subpd     %xmm10, %xmm7                                 #168.21
        je        ..B2.32       # Prob 40%                      #168.21
                                # LOE rax rdx rbx rbp rsi r8 r9 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm11 xmm12
..B2.31:                        # Preds ..B2.16 ..B2.30
                                # Execution count [1.25e+00]
        movsd     %xmm7, (%r8,%r9,8)                            #168.21
        movsd     (%r8,%rbp,8), %xmm13                          #169.21
        xorps     %xmm10, %xmm10                                #169.21
        unpcklpd  %xmm10, %xmm13                                #169.21
        subpd     %xmm9, %xmm13                                 #169.21
        jmp       ..B2.34       # Prob 100%                     #169.21
                                # LOE rax rdx rbx rbp rsi r8 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm11 xmm12 xmm13
..B2.32:                        # Preds ..B2.30
                                # Execution count [0.00e+00]
        xorps     %xmm13, %xmm13                                #169.21
        jmp       ..B2.33       # Prob 100%                     #169.21
                                # LOE rax rdx rbx rbp rsi r8 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm9 xmm11 xmm12 xmm13
..B2.84:                        # Preds ..B2.21
                                # Execution count [7.50e-01]
        testl     %r13d, %r13d                                  #168.21
                                # LOE rax rdx rbx rbp rsi r8 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm9 xmm11 xmm12 xmm13
..B2.33:                        # Preds ..B2.32 ..B2.84
                                # Execution count [2.67e+00]
        xorps     %xmm7, %xmm7                                  #169.21
        unpcklpd  %xmm7, %xmm13                                 #169.21
        subpd     %xmm9, %xmm13                                 #169.21
        je        ..B2.35       # Prob 40%                      #169.21
                                # LOE rax rdx rbx rbp rsi r8 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm11 xmm12 xmm13
..B2.34:                        # Preds ..B2.31 ..B2.33
                                # Execution count [1.25e+00]
        movsd     %xmm13, (%r8,%rbp,8)                          #169.21
        movsd     (%r8,%rdx,8), %xmm9                           #170.21
        xorps     %xmm7, %xmm7                                  #170.21
        unpcklpd  %xmm7, %xmm9                                  #170.21
        subpd     %xmm8, %xmm9                                  #170.21
        jmp       ..B2.37       # Prob 100%                     #170.21
                                # LOE rax rdx rbx rsi r8 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm9 xmm11 xmm12
..B2.35:                        # Preds ..B2.33
                                # Execution count [0.00e+00]
        xorps     %xmm9, %xmm9                                  #170.21
        jmp       ..B2.36       # Prob 100%                     #170.21
                                # LOE rax rdx rbx rsi r8 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm9 xmm11 xmm12
..B2.83:                        # Preds ..B2.25
                                # Execution count [7.50e-01]
        testl     %r13d, %r13d                                  #168.21
                                # LOE rax rdx rbx rsi r8 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm8 xmm9 xmm11 xmm12
..B2.36:                        # Preds ..B2.35 ..B2.83
                                # Execution count [2.67e+00]
        xorps     %xmm7, %xmm7                                  #170.21
        unpcklpd  %xmm7, %xmm9                                  #170.21
        subpd     %xmm8, %xmm9                                  #170.21
        je        ..B2.38       # Prob 40%                      #170.21
                                # LOE rax rdx rbx rsi r8 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm9 xmm11 xmm12
..B2.37:                        # Preds ..B2.34 ..B2.36
                                # Execution count [1.25e+00]
        movsd     %xmm9, (%r8,%rdx,8)                           #170.21
                                # LOE rax rbx rsi r8 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm11 xmm12
..B2.38:                        # Preds ..B2.36 ..B2.29 ..B2.37 ..B2.13 ..B2.12
                                #      
                                # Execution count [1.25e+01]
        addq      $2, %r15                                      #143.9
        cmpq      %r12, %r15                                    #143.9
        jb        ..B2.12       # Prob 82%                      #143.9
                                # LOE rax rbx rsi r8 r12 r14 r15 xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm11 xmm12
..B2.39:                        # Preds ..B2.38
                                # Execution count [2.25e+00]
        movaps    %xmm2, %xmm0                                  #132.22
        movaps    %xmm4, %xmm1                                  #131.22
        movaps    %xmm5, %xmm3                                  #130.22
        unpckhpd  %xmm2, %xmm0                                  #132.22
        unpckhpd  %xmm4, %xmm1                                  #131.22
        addsd     %xmm0, %xmm2                                  #132.22
        addsd     %xmm1, %xmm4                                  #131.22
        unpckhpd  %xmm5, %xmm3                                  #130.22
        movsd     120(%rsp), %xmm9                              #[spill]
        addsd     %xmm3, %xmm5                                  #130.22
        movsd     128(%rsp), %xmm11                             #[spill]
        movsd     136(%rsp), %xmm12                             #[spill]
        movsd     144(%rsp), %xmm10                             #[spill]
        movsd     40(%rsp), %xmm8                               #[spill]
        movsd     48(%rsp), %xmm13                              #[spill]
        movl      24(%rsp), %ebp                                #[spill]
        movq      72(%rsp), %r11                                #[spill]
        movq      80(%rsp), %r10                                #[spill]
        movq      88(%rsp), %r9                                 #[spill]
        movq      96(%rsp), %r13                                #[spill]
        movq      104(%rsp), %rcx                               #[spill]
        movq      112(%rsp), %rdi                               #[spill]
        movq      32(%rsp), %rdx                                #[spill]
        movsd     .L_2il0floatpacket.5(%rip), %xmm7             #
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 ebp xmm2 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B2.40:                        # Preds ..B2.39 ..B2.58
                                # Execution count [2.50e+00]
        movslq    %ebp, %r14                                    #143.9
        cmpq      %r14, %r12                                    #143.9
        jae       ..B2.49       # Prob 10%                      #143.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 r14 ebp xmm2 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B2.41:                        # Preds ..B2.40
                                # Execution count [2.25e+00]
        imulq     56(%rsp), %rax                                #125.43[spill]
        movl      64(%rsp), %edx                                #107.5[spill]
        addq      %rcx, %rax                                    #107.5
        movq      %rdi, 112(%rsp)                               #107.5[spill]
                                # LOE rax rcx rbx rsi r8 r9 r10 r11 r12 r13 r14 edx ebp xmm2 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B2.42:                        # Preds ..B2.45 ..B2.41
                                # Execution count [1.25e+01]
        movl      (%rax,%r12,4), %edi                           #144.21
        movaps    %xmm12, %xmm14                                #145.36
        movaps    %xmm11, %xmm3                                 #146.36
        movaps    %xmm9, %xmm1                                  #147.36
        lea       (%rdi,%rdi,2), %r15d                          #145.36
        movslq    %r15d, %r15                                   #145.36
        subsd     (%rsi,%r15,8), %xmm14                         #145.36
        subsd     8(%rsi,%r15,8), %xmm3                         #146.36
        subsd     16(%rsi,%r15,8), %xmm1                        #147.36
        movaps    %xmm14, %xmm15                                #148.35
        movaps    %xmm3, %xmm0                                  #148.49
        mulsd     %xmm14, %xmm15                                #148.35
        mulsd     %xmm3, %xmm0                                  #148.49
        addsd     %xmm0, %xmm15                                 #148.49
        movaps    %xmm1, %xmm0                                  #148.63
        mulsd     %xmm1, %xmm0                                  #148.63
        addsd     %xmm0, %xmm15                                 #148.63
        comisd    %xmm15, %xmm13                                #158.22
        jbe       ..B2.45       # Prob 50%                      #158.22
                                # LOE rax rcx rbx rsi r8 r9 r10 r11 r12 r13 r14 r15 edx ebp edi xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14 xmm15
..B2.43:                        # Preds ..B2.42
                                # Execution count [6.25e+00]
        movsd     .L_2il0floatpacket.6(%rip), %xmm0             #159.38
        divsd     %xmm15, %xmm0                                 #159.38
        movaps    %xmm8, %xmm15                                 #160.38
        mulsd     %xmm0, %xmm15                                 #160.38
        mulsd     %xmm0, %xmm15                                 #160.44
        mulsd     %xmm0, %xmm15                                 #160.50
        mulsd     %xmm10, %xmm0                                 #161.54
        mulsd     %xmm15, %xmm0                                 #161.61
        subsd     %xmm7, %xmm15                                 #161.54
        mulsd     %xmm15, %xmm0                                 #161.67
        mulsd     %xmm0, %xmm14                                 #162.31
        mulsd     %xmm0, %xmm3                                  #163.31
        mulsd     %xmm0, %xmm1                                  #164.31
        addsd     %xmm14, %xmm5                                 #162.17
        addsd     %xmm3, %xmm4                                  #163.17
        addsd     %xmm1, %xmm2                                  #164.17
        cmpl      %edx, %edi                                    #167.24
        jge       ..B2.45       # Prob 50%                      #167.24
                                # LOE rax rcx rbx rsi r8 r9 r10 r11 r12 r13 r14 r15 edx ebp xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13 xmm14
..B2.44:                        # Preds ..B2.43
                                # Execution count [3.12e+00]
        movsd     (%r8,%r15,8), %xmm0                           #168.21
        subsd     %xmm14, %xmm0                                 #168.21
        movsd     8(%r8,%r15,8), %xmm14                         #169.21
        subsd     %xmm3, %xmm14                                 #169.21
        movsd     16(%r8,%r15,8), %xmm3                         #170.21
        movsd     %xmm0, (%r8,%r15,8)                           #168.21
        subsd     %xmm1, %xmm3                                  #170.21
        movsd     %xmm14, 8(%r8,%r15,8)                         #169.21
        movsd     %xmm3, 16(%r8,%r15,8)                         #170.21
                                # LOE rax rcx rbx rsi r8 r9 r10 r11 r12 r13 r14 edx ebp xmm2 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B2.45:                        # Preds ..B2.44 ..B2.43 ..B2.42
                                # Execution count [1.25e+01]
        incq      %r12                                          #143.9
        cmpq      %r14, %r12                                    #143.9
        jb        ..B2.42       # Prob 82%                      #143.9
                                # LOE rax rcx rbx rsi r8 r9 r10 r11 r12 r13 r14 edx ebp xmm2 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B2.46:                        # Preds ..B2.45
                                # Execution count [2.25e+00]
        movq      112(%rsp), %rdi                               #[spill]
        movq      32(%rsp), %rdx                                #[spill]
        jmp       ..B2.49       # Prob 100%                     #
                                # LOE rdx rcx rbx rsi rdi r8 r9 r10 r11 r13 r14 ebp xmm2 xmm4 xmm5 xmm6 xmm7 xmm8 xmm10 xmm13
..B2.48:                        # Preds ..B2.9 ..B2.8
                                # Execution count [2.50e+00]
        movslq    %ebp, %r14                                    #179.9
                                # LOE rdx rcx rbx rsi rdi r8 r9 r10 r11 r13 r14 ebp xmm2 xmm4 xmm5 xmm6 xmm7 xmm8 xmm10 xmm13
..B2.49:                        # Preds ..B2.46 ..B2.40 ..B2.48
                                # Execution count [5.00e+00]
        addq      %r14, %r9                                     #179.9
        lea       1(%rbp), %eax                                 #180.9
        shrl      $31, %eax                                     #180.9
        addsd     (%r11,%r8), %xmm5                             #175.9
        addsd     8(%r11,%r8), %xmm4                            #176.9
        addsd     16(%r11,%r8), %xmm2                           #177.9
        movsd     %xmm5, (%r11,%r8)                             #175.9
        lea       1(%rbp,%rax), %ebp                            #180.9
        sarl      $1, %ebp                                      #180.9
        movslq    %ebp, %rbp                                    #180.9
        movslq    %edi, %rax                                    #124.32
        incq      %rdi                                          #124.5
        movsd     %xmm4, 8(%r11,%r8)                            #176.9
        addq      %rbp, %r10                                    #180.9
        movsd     %xmm2, 16(%r11,%r8)                           #177.9
        addq      $24, %r11                                     #124.5
        incq      %rax                                          #124.32
        cmpq      %rdx, %rdi                                    #124.5
        jb        ..B2.8        # Prob 82%                      #124.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r13 xmm6 xmm7 xmm8 xmm10 xmm13
..B2.50:                        # Preds ..B2.49
                                # Execution count [9.00e-01]
        movq      8(%rsp), %r14                                 #[spill]
        movq      (%rsp), %r15                                  #[spill]
        movq      %r9, (%r14)                                   #179.9
        movq      %r10, 8(%r14)                                 #180.9
        jmp       ..B2.54       # Prob 100%                     #180.9
                                # LOE rbx r15
..B2.51:                        # Preds ..B2.1
                                # Execution count [5.00e-01]
        xorl      %ebx, %ebx                                    #120.22
        xorl      %eax, %eax                                    #121.16
..___tag_value_computeForceLJHalfNeigh.155:
#       getTimeStamp()
        call      getTimeStamp                                  #121.16
..___tag_value_computeForceLJHalfNeigh.156:
                                # LOE rbx r15 xmm0
..B2.81:                        # Preds ..B2.51
                                # Execution count [5.00e-01]
        movsd     %xmm0, 16(%rsp)                               #121.16[spill]
                                # LOE rbx r15
..B2.52:                        # Preds ..B2.81
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.1, %edi                         #122.5
..___tag_value_computeForceLJHalfNeigh.158:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #122.5
..___tag_value_computeForceLJHalfNeigh.159:
                                # LOE rbx r15
..B2.54:                        # Preds ..B2.52 ..B2.50
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.1, %edi                         #183.5
..___tag_value_computeForceLJHalfNeigh.160:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #183.5
..___tag_value_computeForceLJHalfNeigh.161:
                                # LOE rbx r15
..B2.55:                        # Preds ..B2.54
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #184.16
..___tag_value_computeForceLJHalfNeigh.162:
#       getTimeStamp()
        call      getTimeStamp                                  #184.16
..___tag_value_computeForceLJHalfNeigh.163:
                                # LOE rbx r15 xmm0
..B2.82:                        # Preds ..B2.55
                                # Execution count [1.00e+00]
        movaps    %xmm0, %xmm1                                  #184.16
                                # LOE rbx r15 xmm1
..B2.56:                        # Preds ..B2.82
                                # Execution count [1.00e+00]
        xorps     %xmm3, %xmm3                                  #185.5
        cvtsi2sdq %rbx, %xmm3                                   #185.5
        subsd     16(%rsp), %xmm1                               #185.94[spill]
        movsd     .L_2il0floatpacket.7(%rip), %xmm2             #185.5
        movl      $.L_2__STRING.2, %edi                         #185.5
        divsd     %xmm3, %xmm2                                  #185.5
        mulsd     %xmm1, %xmm2                                  #185.5
        movl      %ebx, %esi                                    #185.5
        movsd     264(%r15), %xmm0                              #185.74
        movl      $3, %eax                                      #185.5
        mulsd     %xmm0, %xmm2                                  #185.5
        movsd     %xmm1, (%rsp)                                 #185.5[spill]
..___tag_value_computeForceLJHalfNeigh.165:
#       printf(const char *__restrict__, ...)
        call      printf                                        #185.5
..___tag_value_computeForceLJHalfNeigh.166:
                                # LOE
..B2.57:                        # Preds ..B2.56
                                # Execution count [1.00e+00]
        movsd     (%rsp), %xmm1                                 #[spill]
        movaps    %xmm1, %xmm0                                  #186.14
        addq      $216, %rsp                                    #186.14
	.cfi_def_cfa_offset 56
	.cfi_restore 6
        popq      %rbp                                          #186.14
	.cfi_def_cfa_offset 48
	.cfi_restore 3
        popq      %rbx                                          #186.14
	.cfi_def_cfa_offset 40
	.cfi_restore 15
        popq      %r15                                          #186.14
	.cfi_def_cfa_offset 32
	.cfi_restore 14
        popq      %r14                                          #186.14
	.cfi_def_cfa_offset 24
	.cfi_restore 13
        popq      %r13                                          #186.14
	.cfi_def_cfa_offset 16
	.cfi_restore 12
        popq      %r12                                          #186.14
	.cfi_def_cfa_offset 8
        ret                                                     #186.14
	.cfi_def_cfa_offset 272
	.cfi_offset 3, -48
	.cfi_offset 6, -56
	.cfi_offset 12, -16
	.cfi_offset 13, -24
	.cfi_offset 14, -32
	.cfi_offset 15, -40
                                # LOE
..B2.58:                        # Preds ..B2.10
                                # Execution count [2.25e-01]: Infreq
        xorl      %r12d, %r12d                                  #143.9
        jmp       ..B2.40       # Prob 100%                     #143.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11 r12 r13 ebp xmm2 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm13
..B2.59:                        # Preds ..B2.2
                                # Execution count [1.00e+00]: Infreq
        movq      %rbp, %rax                                    #106.18
        lea       (%rax,%rax,2), %rax                           #106.18
        cmpq      $4, %rax                                      #114.5
        jl        ..B2.75       # Prob 10%                      #114.5
                                # LOE rax rdi r12 r13 r14 r15 ebp
..B2.60:                        # Preds ..B2.59
                                # Execution count [1.00e+00]: Infreq
        movq      %rdi, %rdx                                    #114.5
        andq      $15, %rdx                                     #114.5
        testl     %edx, %edx                                    #114.5
        je        ..B2.63       # Prob 50%                      #114.5
                                # LOE rax rdi r12 r13 r14 r15 edx ebp
..B2.61:                        # Preds ..B2.60
                                # Execution count [1.00e+00]: Infreq
        testb     $7, %dl                                       #114.5
        jne       ..B2.75       # Prob 10%                      #114.5
                                # LOE rax rdi r12 r13 r14 r15 ebp
..B2.62:                        # Preds ..B2.61
                                # Execution count [5.00e-01]: Infreq
        movl      $1, %edx                                      #114.5
                                # LOE rax rdi r12 r13 r14 r15 edx ebp
..B2.63:                        # Preds ..B2.62 ..B2.60
                                # Execution count [1.00e+00]: Infreq
        movl      %edx, %esi                                    #114.5
        lea       4(%rsi), %rcx                                 #114.5
        cmpq      %rcx, %rax                                    #114.5
        jl        ..B2.75       # Prob 10%                      #114.5
                                # LOE rax rsi rdi r12 r13 r14 r15 edx ebp
..B2.64:                        # Preds ..B2.63
                                # Execution count [1.11e+00]: Infreq
        movl      %eax, %r8d                                    #114.5
        movl      %r8d, %ecx                                    #114.5
        subl      %edx, %ecx                                    #114.5
        andl      $3, %ecx                                      #114.5
        subl      %ecx, %r8d                                    #114.5
        xorl      %ecx, %ecx                                    #114.5
        xorl      %ebx, %ebx                                    #115.22
        testl     %edx, %edx                                    #114.5
        movslq    %r8d, %rdx                                    #114.5
        jbe       ..B2.68       # Prob 10%                      #114.5
                                # LOE rax rdx rcx rbx rsi rdi r12 r13 r14 r15 ebp
..B2.66:                        # Preds ..B2.64 ..B2.66
                                # Execution count [5.56e+00]: Infreq
        movq      %rbx, (%rdi,%rcx,8)                           #115.9
        incq      %rcx                                          #114.5
        cmpq      %rsi, %rcx                                    #114.5
        jb        ..B2.66       # Prob 82%                      #114.5
                                # LOE rax rdx rcx rbx rsi rdi r12 r13 r14 r15 ebp
..B2.68:                        # Preds ..B2.66 ..B2.64
                                # Execution count [1.00e+00]: Infreq
        xorps     %xmm0, %xmm0                                  #115.22
                                # LOE rax rdx rsi rdi r12 r13 r14 r15 ebp xmm0
..B2.69:                        # Preds ..B2.69 ..B2.68
                                # Execution count [5.56e+00]: Infreq
        movups    %xmm0, (%rdi,%rsi,8)                          #115.9
        movups    %xmm0, 16(%rdi,%rsi,8)                        #115.9
        addq      $4, %rsi                                      #114.5
        cmpq      %rdx, %rsi                                    #114.5
        jb        ..B2.69       # Prob 82%                      #114.5
                                # LOE rax rdx rsi rdi r12 r13 r14 r15 ebp xmm0
..B2.71:                        # Preds ..B2.69 ..B2.75
                                # Execution count [1.11e+00]: Infreq
        cmpq      %rax, %rdx                                    #114.5
        jae       ..B2.5        # Prob 10%                      #114.5
                                # LOE rax rdx rdi r12 r13 r14 r15 ebp
..B2.73:                        # Preds ..B2.71 ..B2.73
                                # Execution count [5.56e+00]: Infreq
        movq      $0, (%rdi,%rdx,8)                             #115.9
        incq      %rdx                                          #114.5
        cmpq      %rax, %rdx                                    #114.5
        jb        ..B2.73       # Prob 82%                      #114.5
        jmp       ..B2.5        # Prob 100%                     #114.5
                                # LOE rax rdx rdi r12 r13 r14 r15 ebp
..B2.75:                        # Preds ..B2.59 ..B2.61 ..B2.63
                                # Execution count [1.00e-01]: Infreq
        xorl      %edx, %edx                                    #114.5
        jmp       ..B2.71       # Prob 100%                     #114.5
        .align    16,0x90
                                # LOE rax rdx rdi r12 r13 r14 r15 ebp
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
        pushq     %rsi                                          #189.101
	.cfi_def_cfa_offset 16
        movl      4(%rsi), %edx                                 #190.18
        testl     %edx, %edx                                    #196.24
        jle       ..B3.4        # Prob 50%                      #196.24
                                # LOE rbx rbp rsi r12 r13 r14 r15 edx
..B3.2:                         # Preds ..B3.1
                                # Execution count [5.00e-03]
        movq      64(%rsi), %rdi                                #197.9
        lea       (%rdx,%rdx,2), %eax                           #190.18
        cmpl      $12, %eax                                     #196.5
        jle       ..B3.8        # Prob 0%                       #196.5
                                # LOE rbx rbp rdi r12 r13 r14 r15 edx
..B3.3:                         # Preds ..B3.2
                                # Execution count [1.00e+00]
        movslq    %edx, %rdx                                    #196.5
        xorl      %esi, %esi                                    #196.5
        lea       (%rdx,%rdx,2), %rdx                           #196.5
        shlq      $3, %rdx                                      #196.5
        call      _intel_fast_memset                            #196.5
                                # LOE rbx rbp r12 r13 r14 r15
..B3.4:                         # Preds ..B3.22 ..B3.1 ..B3.20 ..B3.3
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #203.16
..___tag_value_computeForceLJFullNeigh_simd.193:
#       getTimeStamp()
        call      getTimeStamp                                  #203.16
..___tag_value_computeForceLJFullNeigh_simd.194:
                                # LOE rbx rbp r12 r13 r14 r15
..B3.5:                         # Preds ..B3.4
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.0, %edi                         #204.5
..___tag_value_computeForceLJFullNeigh_simd.195:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #204.5
..___tag_value_computeForceLJFullNeigh_simd.196:
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
        lea       (%rdx,%rdx,2), %rcx                           #190.18
        cmpq      $4, %rcx                                      #196.5
        jl        ..B3.24       # Prob 10%                      #196.5
                                # LOE rcx rbx rbp rdi r12 r13 r14 r15
..B3.9:                         # Preds ..B3.8
                                # Execution count [1.00e+00]: Infreq
        movq      %rdi, %rdx                                    #196.5
        andq      $15, %rdx                                     #196.5
        testl     %edx, %edx                                    #196.5
        je        ..B3.12       # Prob 50%                      #196.5
                                # LOE rcx rbx rbp rdi r12 r13 r14 r15 edx
..B3.10:                        # Preds ..B3.9
                                # Execution count [1.00e+00]: Infreq
        testb     $7, %dl                                       #196.5
        jne       ..B3.24       # Prob 10%                      #196.5
                                # LOE rcx rbx rbp rdi r12 r13 r14 r15
..B3.11:                        # Preds ..B3.10
                                # Execution count [5.00e-01]: Infreq
        movl      $1, %edx                                      #196.5
                                # LOE rcx rbx rbp rdi r12 r13 r14 r15 edx
..B3.12:                        # Preds ..B3.11 ..B3.9
                                # Execution count [1.00e+00]: Infreq
        movl      %edx, %eax                                    #196.5
        lea       4(%rax), %rsi                                 #196.5
        cmpq      %rsi, %rcx                                    #196.5
        jl        ..B3.24       # Prob 10%                      #196.5
                                # LOE rax rcx rbx rbp rdi r12 r13 r14 r15 edx
..B3.13:                        # Preds ..B3.12
                                # Execution count [1.11e+00]: Infreq
        movl      %ecx, %r8d                                    #196.5
        xorl      %r9d, %r9d                                    #196.5
        movl      %r8d, %esi                                    #196.5
        subl      %edx, %esi                                    #196.5
        andl      $3, %esi                                      #196.5
        subl      %esi, %r8d                                    #196.5
        xorl      %esi, %esi                                    #196.5
        movslq    %r8d, %r8                                     #196.5
        testl     %edx, %edx                                    #196.5
        jbe       ..B3.17       # Prob 10%                      #196.5
                                # LOE rax rcx rbx rbp rsi rdi r8 r9 r12 r13 r14 r15
..B3.15:                        # Preds ..B3.13 ..B3.15
                                # Execution count [5.56e+00]: Infreq
        movq      %rsi, (%rdi,%r9,8)                            #197.9
        incq      %r9                                           #196.5
        cmpq      %rax, %r9                                     #196.5
        jb        ..B3.15       # Prob 82%                      #196.5
                                # LOE rax rcx rbx rbp rsi rdi r8 r9 r12 r13 r14 r15
..B3.17:                        # Preds ..B3.15 ..B3.13
                                # Execution count [1.00e+00]: Infreq
        xorps     %xmm0, %xmm0                                  #197.22
                                # LOE rax rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 xmm0
..B3.18:                        # Preds ..B3.18 ..B3.17
                                # Execution count [5.56e+00]: Infreq
        movups    %xmm0, (%rdi,%rax,8)                          #197.9
        movups    %xmm0, 16(%rdi,%rax,8)                        #197.9
        addq      $4, %rax                                      #196.5
        cmpq      %r8, %rax                                     #196.5
        jb        ..B3.18       # Prob 82%                      #196.5
                                # LOE rax rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 xmm0
..B3.20:                        # Preds ..B3.18 ..B3.24
                                # Execution count [1.11e+00]: Infreq
        cmpq      %rcx, %r8                                     #196.5
        jae       ..B3.4        # Prob 10%                      #196.5
                                # LOE rcx rbx rbp rsi rdi r8 r12 r13 r14 r15
..B3.22:                        # Preds ..B3.20 ..B3.22
                                # Execution count [5.56e+00]: Infreq
        movq      %rsi, (%rdi,%r8,8)                            #197.9
        incq      %r8                                           #196.5
        cmpq      %rcx, %r8                                     #196.5
        jb        ..B3.22       # Prob 82%                      #196.5
        jmp       ..B3.4        # Prob 100%                     #196.5
                                # LOE rcx rbx rbp rsi rdi r8 r12 r13 r14 r15
..B3.24:                        # Preds ..B3.8 ..B3.10 ..B3.12
                                # Execution count [1.00e-01]: Infreq
        xorl      %r8d, %r8d                                    #196.5
        xorl      %esi, %esi                                    #196.5
        jmp       ..B3.20       # Prob 100%                     #196.5
        .align    16,0x90
                                # LOE rcx rbx rbp rsi rdi r8 r12 r13 r14 r15
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
	.align 16
	.align 16
.L_2il0floatpacket.0:
	.long	0x00000001,0x00000001,0x00000001,0x00000001
	.type	.L_2il0floatpacket.0,@object
	.size	.L_2il0floatpacket.0,16
	.align 16
.L_2il0floatpacket.1:
	.long	0x00000002,0x00000002,0x00000002,0x00000002
	.type	.L_2il0floatpacket.1,@object
	.size	.L_2il0floatpacket.1,16
	.align 16
.L_2il0floatpacket.2:
	.long	0x00000000,0x3ff00000,0x00000000,0x3ff00000
	.type	.L_2il0floatpacket.2,@object
	.size	.L_2il0floatpacket.2,16
	.align 16
.L_2il0floatpacket.4:
	.long	0x00000000,0x3fe00000,0x00000000,0x3fe00000
	.type	.L_2il0floatpacket.4,@object
	.size	.L_2il0floatpacket.4,16
	.align 8
.L_2il0floatpacket.3:
	.long	0x00000000,0x40480000
	.type	.L_2il0floatpacket.3,@object
	.size	.L_2il0floatpacket.3,8
	.align 8
.L_2il0floatpacket.5:
	.long	0x00000000,0x3fe00000
	.type	.L_2il0floatpacket.5,@object
	.size	.L_2il0floatpacket.5,8
	.align 8
.L_2il0floatpacket.6:
	.long	0x00000000,0x3ff00000
	.type	.L_2il0floatpacket.6,@object
	.size	.L_2il0floatpacket.6,8
	.align 8
.L_2il0floatpacket.7:
	.long	0x00000000,0x41cdcd65
	.type	.L_2il0floatpacket.7,@object
	.size	.L_2il0floatpacket.7,8
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
