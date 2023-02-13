# mark_description "Intel(R) C Intel(R) 64 Compiler Classic for applications running on Intel(R) 64, Version 2021.6.0 Build 2022";
# mark_description "0226_000000";
# mark_description "-I/apps/likwid/5.2.2/include -I././gromacs/includes -I././common/includes -S -std=c11 -pedantic-errors -D_GN";
# mark_description "U_SOURCE -DLIKWID_PERFMON -DAOS -DPRECISION=2 -DCOMPUTE_STATS -DVECTOR_WIDTH=8 -D__SIMD_KERNEL__ -D__ISA_AVX";
# mark_description "512__ -DENABLE_OMP_SIMD -DALIGNMENT=64 -restrict -Ofast -xCORE-AVX512 -qopt-zmm-usage=high -o build-gromacs-";
# mark_description "ICC-AVX512-DP/force_lj.s";
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
        movl      $.L_2__STRING.0, %edi                         #20.5
        xorl      %eax, %eax                                    #20.5
        movq      %rcx, %r13                                    #19.91
        movq      %rdx, %rbx                                    #19.91
        movq      %rsi, %r14                                    #19.91
..___tag_value_computeForceLJ_ref.11:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #20.5
..___tag_value_computeForceLJ_ref.12:
                                # LOE rbx r12 r13 r14 r15
..B1.2:                         # Preds ..B1.1
                                # Execution count [1.00e+00]
        vmovsd    144(%r15), %xmm16                             #23.27
        xorl      %ecx, %ecx                                    #30.5
        vmulsd    %xmm16, %xmm16, %xmm0                         #23.45
        xorl      %esi, %esi                                    #32.27
        vmovsd    56(%r15), %xmm1                               #24.23
        vmovsd    40(%r15), %xmm2                               #25.24
        movl      20(%r14), %edx                                #30.26
        vmovsd    %xmm0, 8(%rsp)                                #23.45[spill]
        vmovsd    %xmm1, 16(%rsp)                               #24.23[spill]
        vmovsd    %xmm2, 24(%rsp)                               #25.24[spill]
        testl     %edx, %edx                                    #30.26
        jle       ..B1.24       # Prob 9%                       #30.26
                                # LOE rbx rsi r12 r13 r14 edx ecx
..B1.3:                         # Preds ..B1.2
                                # Execution count [9.00e-01]
        movq      176(%r14), %rdi                               #32.27
        movq      192(%r14), %rax                               #33.32
        vxorpd    %ymm2, %ymm2, %ymm2                           #34.39
        vmovdqu   .L_2il0floatpacket.0(%rip), %xmm1             #33.9
        vmovdqu   .L_2il0floatpacket.1(%rip), %xmm0             #33.9
                                # LOE rax rbx rsi rdi r13 r14 edx ecx xmm0 xmm1 ymm2
..B1.4:                         # Preds ..B1.22 ..B1.3
                                # Execution count [5.00e+00]
        movl      %ecx, %r8d                                    #31.27
        movl      %ecx, %r9d                                    #31.27
        sarl      $1, %r8d                                      #31.27
        andl      $1, %r9d                                      #31.27
        shll      $2, %r9d                                      #31.27
        lea       (%r8,%r8,2), %r10d                            #31.27
        lea       (%r9,%r10,8), %r11d                           #31.27
        movslq    %r11d, %r11                                   #32.27
        lea       (%rdi,%r11,8), %r12                           #32.27
        movl      (%rsi,%rax), %r11d                            #33.32
        testl     %r11d, %r11d                                  #33.32
        jle       ..B1.22       # Prob 50%                      #33.32
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r11d xmm0 xmm1 ymm2
..B1.5:                         # Preds ..B1.4
                                # Execution count [4.50e+00]
        cmpl      $16, %r11d                                    #33.9
        jl        ..B1.153      # Prob 10%                      #33.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r11d xmm0 xmm1 ymm2
..B1.6:                         # Preds ..B1.5
                                # Execution count [4.50e+00]
        lea       128(%r12), %r8                                #36.13
        andq      $63, %r8                                      #33.9
        testl     $7, %r8d                                      #33.9
        je        ..B1.8        # Prob 50%                      #33.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B1.7:                         # Preds ..B1.6
                                # Execution count [2.25e+00]
        xorl      %r8d, %r8d                                    #33.9
        jmp       ..B1.10       # Prob 100%                     #33.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B1.8:                         # Preds ..B1.6
                                # Execution count [2.25e+00]
        testl     %r8d, %r8d                                    #33.9
        je        ..B1.10       # Prob 50%                      #33.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B1.9:                         # Preds ..B1.8
                                # Execution count [2.50e+01]
        negl      %r8d                                          #33.9
        addl      $64, %r8d                                     #33.9
        shrl      $3, %r8d                                      #33.9
        cmpl      %r8d, %r11d                                   #33.9
        cmovl     %r11d, %r8d                                   #33.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B1.10:                        # Preds ..B1.7 ..B1.9 ..B1.8
                                # Execution count [5.00e+00]
        movl      %r11d, %r10d                                  #33.9
        subl      %r8d, %r10d                                   #33.9
        andl      $15, %r10d                                    #33.9
        negl      %r10d                                         #33.9
        addl      %r11d, %r10d                                  #33.9
        cmpl      $1, %r8d                                      #33.9
        jb        ..B1.14       # Prob 50%                      #33.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r10d r11d xmm0 xmm1 ymm2
..B1.11:                        # Preds ..B1.10
                                # Execution count [4.50e+00]
        vpbroadcastd %r8d, %xmm3                                #33.9
        xorl      %r15d, %r15d                                  #33.9
        vmovdqa   %xmm0, %xmm4                                  #33.9
        movslq    %r8d, %r9                                     #33.9
                                # LOE rax rbx rsi rdi r9 r12 r13 r14 r15 edx ecx r8d r10d r11d xmm0 xmm1 xmm3 xmm4 ymm2
..B1.12:                        # Preds ..B1.12 ..B1.11
                                # Execution count [2.50e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #33.9
        vpaddd    %xmm1, %xmm4, %xmm4                           #33.9
        vmovupd   %ymm2, (%r12,%r15,8){%k1}                     #34.13
        vmovupd   %ymm2, 64(%r12,%r15,8){%k1}                   #35.13
        vmovupd   %ymm2, 128(%r12,%r15,8){%k1}                  #36.13
        addq      $4, %r15                                      #33.9
        cmpq      %r9, %r15                                     #33.9
        jb        ..B1.12       # Prob 82%                      #33.9
                                # LOE rax rbx rsi rdi r9 r12 r13 r14 r15 edx ecx r8d r10d r11d xmm0 xmm1 xmm3 xmm4 ymm2
..B1.13:                        # Preds ..B1.12
                                # Execution count [4.50e+00]
        cmpl      %r8d, %r11d                                   #33.9
        je        ..B1.22       # Prob 10%                      #33.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r10d r11d xmm0 xmm1 ymm2
..B1.14:                        # Preds ..B1.13 ..B1.10
                                # Execution count [2.50e+01]
        lea       16(%r8), %r9d                                 #33.9
        cmpl      %r9d, %r10d                                   #33.9
        jl        ..B1.18       # Prob 50%                      #33.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r10d r11d xmm0 xmm1 ymm2
..B1.15:                        # Preds ..B1.14
                                # Execution count [4.50e+00]
        movslq    %r8d, %r8                                     #33.9
        movslq    %r10d, %r9                                    #33.9
        .align    16,0x90
                                # LOE rax rbx rsi rdi r8 r9 r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
..B1.16:                        # Preds ..B1.16 ..B1.15
                                # Execution count [2.50e+01]
        vmovupd   %ymm2, (%r12,%r8,8)                           #34.13
        vmovupd   %ymm2, 32(%r12,%r8,8)                         #34.13
        vmovupd   %ymm2, 64(%r12,%r8,8)                         #34.13
        vmovupd   %ymm2, 128(%r12,%r8,8)                        #35.13
        vmovupd   %ymm2, 192(%r12,%r8,8)                        #36.13
        vmovupd   %ymm2, 96(%r12,%r8,8)                         #34.13
        vmovupd   %ymm2, 160(%r12,%r8,8)                        #35.13
        vmovupd   %ymm2, 224(%r12,%r8,8)                        #36.13
        addq      $16, %r8                                      #33.9
        cmpq      %r9, %r8                                      #33.9
        jb        ..B1.16       # Prob 82%                      #33.9
                                # LOE rax rbx rsi rdi r8 r9 r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
..B1.18:                        # Preds ..B1.16 ..B1.14 ..B1.153
                                # Execution count [5.00e+00]
        lea       1(%r10), %r8d                                 #33.9
        cmpl      %r11d, %r8d                                   #33.9
        ja        ..B1.22       # Prob 50%                      #33.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
..B1.19:                        # Preds ..B1.18
                                # Execution count [4.50e+00]
        movslq    %r10d, %r9                                    #34.13
        negl      %r10d                                         #33.9
        addl      %r11d, %r10d                                  #33.9
        xorl      %r8d, %r8d                                    #33.9
        movslq    %r11d, %r11                                   #33.9
        vmovdqa   %xmm0, %xmm4                                  #33.9
        vpbroadcastd %r10d, %xmm3                               #33.9
        subq      %r9, %r11                                     #33.9
        lea       (%r12,%r9,8), %r12                            #34.13
                                # LOE rax rbx rsi rdi r8 r11 r12 r13 r14 edx ecx xmm0 xmm1 xmm3 xmm4 ymm2
..B1.20:                        # Preds ..B1.20 ..B1.19
                                # Execution count [2.50e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #33.9
        vpaddd    %xmm1, %xmm4, %xmm4                           #33.9
        vmovupd   %ymm2, (%r12,%r8,8){%k1}                      #34.13
        vmovupd   %ymm2, 64(%r12,%r8,8){%k1}                    #35.13
        vmovupd   %ymm2, 128(%r12,%r8,8){%k1}                   #36.13
        addq      $4, %r8                                       #33.9
        cmpq      %r11, %r8                                     #33.9
        jb        ..B1.20       # Prob 82%                      #33.9
                                # LOE rax rbx rsi rdi r8 r11 r12 r13 r14 edx ecx xmm0 xmm1 xmm3 xmm4 ymm2
..B1.22:                        # Preds ..B1.20 ..B1.4 ..B1.13 ..B1.18
                                # Execution count [5.00e+00]
        incl      %ecx                                          #30.5
        addq      $56, %rsi                                     #30.5
        cmpl      %edx, %ecx                                    #30.5
        jb        ..B1.4        # Prob 82%                      #30.5
                                # LOE rax rbx rsi rdi r13 r14 edx ecx xmm0 xmm1 ymm2
..B1.24:                        # Preds ..B1.22 ..B1.2
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #40.16
        vzeroupper                                              #40.16
..___tag_value_computeForceLJ_ref.16:
#       getTimeStamp()
        call      getTimeStamp                                  #40.16
..___tag_value_computeForceLJ_ref.17:
                                # LOE rbx r12 r13 r14 xmm0
..B1.156:                       # Preds ..B1.24
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, (%rsp)                                 #40.16[spill]
                                # LOE rbx r12 r13 r14
..B1.25:                        # Preds ..B1.156
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.1, %edi                         #44.5
..___tag_value_computeForceLJ_ref.19:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #44.5
..___tag_value_computeForceLJ_ref.20:
                                # LOE rbx r12 r13 r14
..B1.26:                        # Preds ..B1.25
                                # Execution count [9.00e-01]
        movl      20(%r14), %eax                                #47.26
        movl      %eax, 56(%rsp)                                #47.26[spill]
        testl     %eax, %eax                                    #47.26
        jle       ..B1.149      # Prob 0%                       #47.26
                                # LOE rbx r12 r13 r14
..B1.27:                        # Preds ..B1.26
                                # Execution count [9.00e-01]
        movq      160(%r14), %r9                                #51.27
        xorl      %edx, %edx                                    #47.5
        movq      176(%r14), %r8                                #52.27
        movq      8(%rbx), %rsi                                 #53.19
        movslq    16(%rbx), %rdi                                #53.44
        movq      24(%rbx), %r11                                #54.25
        movl      32(%rbx), %r10d                               #77.28
        movq      (%r13), %rcx                                  #122.9
        movq      8(%r13), %rbx                                 #123.9
        movq      16(%r13), %rax                                #124.9
        movl      56(%rsp), %r14d                               #47.5[spill]
                                # LOE rax rcx rbx rsi rdi r8 r9 r11 r12 r13 edx r10d r14d
..B1.28:                        # Preds ..B1.28 ..B1.27
                                # Execution count [5.00e+00]
        incl      %edx                                          #47.5
        incq      %rcx                                          #122.9
        cmpl      %r14d, %edx                                   #47.5
        jb        ..B1.28       # Prob 82%                      #47.5
                                # LOE rax rcx rbx rsi rdi r8 r9 r11 r12 r13 edx r10d r14d
..B1.29:                        # Preds ..B1.28
                                # Execution count [9.00e-01]
        vmovsd    24(%rsp), %xmm0                               #91.54[spill]
        xorl      %edx, %edx                                    #48.22
        vmovsd    16(%rsp), %xmm7                               #48.22[spill]
        vmovsd    8(%rsp), %xmm10                               #48.22[spill]
        movq      %rcx, (%r13)                                  #122.9
        xorl      %ecx, %ecx                                    #47.5
        vmovsd    .L_2il0floatpacket.2(%rip), %xmm9             #91.67
        vmovsd    .L_2il0floatpacket.4(%rip), %xmm8             #89.44
        vmulsd    .L_2il0floatpacket.3(%rip), %xmm0, %xmm3      #91.54
        movl      %r10d, 32(%rsp)                               #48.22[spill]
        movq      %r11, 64(%rsp)                                #48.22[spill]
        movq      %r13, 72(%rsp)                                #48.22[spill]
                                # LOE rax rdx rbx rsi rdi r8 r9 ecx xmm3 xmm7 xmm8 xmm9 xmm10
..B1.30:                        # Preds ..B1.147 ..B1.29
                                # Execution count [5.00e+00]
        movl      %ecx, %r13d                                   #48.22
        movl      %ecx, %r15d                                   #50.27
        sarl      $1, %r13d                                     #48.22
        andl      $1, %r15d                                     #50.27
        shll      $2, %r15d                                     #50.27
        movq      64(%rsp), %r10                                #54.25[spill]
        lea       (%r13,%r13,2), %r11d                          #50.27
        movslq    (%r10,%rdx,4), %r12                           #54.25
        lea       (%r15,%r11,8), %r14d                          #50.27
        movslq    %r14d, %r14                                   #50.27
        xorl      %r10d, %r10d                                  #56.9
        lea       (%r9,%r14,8), %r11                            #51.27
        lea       (%r8,%r14,8), %r14                            #52.27
        testq     %r12, %r12                                    #56.28
        jle       ..B1.147      # Prob 10%                      #56.28
                                # LOE rax rdx rbx rsi rdi r8 r9 r10 r11 r12 r14 ecx r13d r15d xmm3 xmm7 xmm8 xmm9 xmm10
..B1.31:                        # Preds ..B1.30
                                # Execution count [4.50e+00]
        movq      %rax, 24(%rsp)                                #[spill]
        movq      %rdx, 48(%rsp)                                #[spill]
        movl      %ecx, 40(%rsp)                                #[spill]
        movq      %rbx, 16(%rsp)                                #[spill]
        movq      %rdi, 8(%rsp)                                 #[spill]
        movq      %r8, 80(%rsp)                                 #[spill]
        movq      %r9, 88(%rsp)                                 #[spill]
        movl      32(%rsp), %eax                                #[spill]
                                # LOE rsi r10 r11 r12 r14 eax r13d r15d xmm3 xmm7 xmm8 xmm9 xmm10
..B1.32:                        # Preds ..B1.145 ..B1.31
                                # Execution count [2.50e+01]
        movl      (%rsi,%r10,4), %r9d                           #57.22
        xorb      %dl, %dl                                      #59.21
        movslq    %r9d, %r9                                     #58.31
        xorb      %cl, %cl                                      #63.13
        movq      %r10, 112(%rsp)                               #63.13[spill]
        movl      %r15d, %r8d                                   #63.13
        movq      %r12, 104(%rsp)                               #63.13[spill]
        xorl      %ebx, %ebx                                    #63.13
        movq      %rsi, 96(%rsp)                                #63.13[spill]
        movq      80(%rsp), %rsi                                #63.13[spill]
        lea       (%r9,%r9,2), %rdi                             #60.28
        movq      88(%rsp), %r10                                #63.13[spill]
        movq      72(%rsp), %r12                                #63.13[spill]
        shlq      $6, %rdi                                      #60.28
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm3 xmm7 xmm8 xmm9 xmm10
..B1.33:                        # Preds ..B1.144 ..B1.32
                                # Execution count [1.00e+02]
        vmovsd    (%r11,%rbx,8), %xmm6                          #64.33
        vxorpd    %xmm2, %xmm2, %xmm2                           #67.30
        vmovapd   %xmm2, %xmm1                                  #68.30
        vmovsd    64(%r11,%rbx,8), %xmm5                        #65.33
        vmovapd   %xmm1, %xmm0                                  #69.30
        vmovsd    128(%r11,%rbx,8), %xmm4                       #66.33
        testl     %eax, %eax                                    #77.28
        je        ..B1.38       # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.34:                        # Preds ..B1.33
                                # Execution count [5.00e+01]
        cmpl      %r9d, %r13d                                   #77.62
        jne       ..B1.40       # Prob 50%                      #77.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.35:                        # Preds ..B1.34
                                # Execution count [2.50e+01]
        testl     %r8d, %r8d                                    #77.99
        jl        ..B1.40       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.36:                        # Preds ..B1.35
                                # Execution count [6.25e+00]
        jle       ..B1.54       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.37:                        # Preds ..B1.36
                                # Execution count [3.12e+00]
        cmpl      $2, %r8d                                      #77.99
        jl        ..B1.70       # Prob 50%                      #77.99
        jmp       ..B1.49       # Prob 100%                     #77.99
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.38:                        # Preds ..B1.33
                                # Execution count [5.00e+01]
        cmpl      %r9d, %r13d                                   #78.62
        jne       ..B1.40       # Prob 50%                      #78.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.39:                        # Preds ..B1.38
                                # Execution count [2.50e+01]
        testl     %r8d, %r8d                                    #78.100
        je        ..B1.54       # Prob 50%                      #78.100
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.40:                        # Preds ..B1.38 ..B1.39 ..B1.34 ..B1.35
                                # Execution count [5.00e+01]
        vsubsd    64(%rdi,%r10), %xmm5, %xmm16                  #85.48
        vsubsd    (%rdi,%r10), %xmm6, %xmm15                    #84.48
        vsubsd    128(%rdi,%r10), %xmm4, %xmm17                 #86.48
        vmulsd    %xmm16, %xmm16, %xmm11                        #87.61
        vfmadd231sd %xmm15, %xmm15, %xmm11                      #87.75
        vfmadd231sd %xmm17, %xmm17, %xmm11                      #87.75
        vcomisd   %xmm11, %xmm10                                #88.34
        jbe       ..B1.44       # Prob 50%                      #88.34
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm15 xmm16 xmm17
..B1.41:                        # Preds ..B1.40
                                # Execution count [2.50e+01]
        vdivsd    %xmm11, %xmm8, %xmm2                          #89.51
        vmulsd    %xmm2, %xmm7, %xmm0                           #90.50
        vmulsd    %xmm3, %xmm2, %xmm11                          #91.67
        vmulsd    %xmm2, %xmm0, %xmm1                           #90.56
        vmulsd    %xmm2, %xmm1, %xmm12                          #90.62
        vmulsd    %xmm12, %xmm11, %xmm13                        #91.76
        vsubsd    %xmm9, %xmm12, %xmm14                         #91.67
        vmulsd    %xmm14, %xmm13, %xmm13                        #91.82
        vmulsd    %xmm13, %xmm15, %xmm2                         #94.67
        testl     %eax, %eax                                    #93.32
        je        ..B1.43       # Prob 50%                      #93.32
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm13 xmm16 xmm17
..B1.42:                        # Preds ..B1.41
                                # Execution count [1.25e+01]
        vmovsd    (%rdi,%rsi), %xmm1                            #94.33
        movb      $1, %dl                                       #102.29
        vmovsd    64(%rdi,%rsi), %xmm11                         #95.33
        vsubsd    %xmm2, %xmm1, %xmm0                           #94.33
        vmulsd    %xmm13, %xmm16, %xmm1                         #95.67
        vfnmadd213sd %xmm11, %xmm13, %xmm16                     #95.33
        vmovsd    128(%rdi,%rsi), %xmm12                        #96.33
        vmovsd    %xmm0, (%rdi,%rsi)                            #94.33
        vmulsd    %xmm13, %xmm17, %xmm0                         #96.67
        vfnmadd213sd %xmm12, %xmm17, %xmm13                     #96.33
        vmovsd    %xmm16, 64(%rdi,%rsi)                         #95.33
        vmovsd    %xmm13, 128(%rdi,%rsi)                        #96.33
        incq      24(%r12)                                      #103.29
        jmp       ..B1.45       # Prob 100%                     #103.29
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.43:                        # Preds ..B1.41
                                # Execution count [1.25e+01]
        vmulsd    %xmm13, %xmm16, %xmm1                         #100.43
        movb      $1, %dl                                       #102.29
        vmulsd    %xmm13, %xmm17, %xmm0                         #101.43
        incq      24(%r12)                                      #103.29
        jmp       ..B1.52       # Prob 100%                     #103.29
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.44:                        # Preds ..B1.40
                                # Execution count [2.50e+01]
        incq      32(%r12)                                      #105.29
        testl     %eax, %eax                                    #77.28
        je        ..B1.52       # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.45:                        # Preds ..B1.42 ..B1.44
                                # Execution count [3.75e+01]
        cmpl      %r9d, %r13d                                   #77.62
        jne       ..B1.54       # Prob 50%                      #77.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.46:                        # Preds ..B1.45
                                # Execution count [1.88e+01]
        testl     %r8d, %r8d                                    #77.99
        jle       ..B1.54       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.47:                        # Preds ..B1.46
                                # Execution count [0.00e+00]
        cmpl      $2, %r8d                                      #77.99
        jl        ..B1.70       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.48:                        # Preds ..B1.47
                                # Execution count [0.00e+00]
        testl     %eax, %eax                                    #77.28
        je        ..B1.82       # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.49:                        # Preds ..B1.37 ..B1.48
                                # Execution count [0.00e+00]
        cmpl      $3, %r8d                                      #77.99
        jl        ..B1.83       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.50:                        # Preds ..B1.49
                                # Execution count [6.25e+00]
        cmpl      %r9d, %r13d                                   #77.62
        jne       ..B1.96       # Prob 50%                      #77.62
        jmp       ..B1.64       # Prob 100%                     #77.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.52:                        # Preds ..B1.43 ..B1.44
                                # Execution count [3.75e+01]
        cmpl      %r9d, %r13d                                   #78.62
        jne       ..B1.54       # Prob 50%                      #78.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.53:                        # Preds ..B1.52
                                # Execution count [1.88e+01]
        cmpl      $1, %r8d                                      #78.100
        je        ..B1.70       # Prob 50%                      #78.100
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.54:                        # Preds ..B1.53 ..B1.46 ..B1.45 ..B1.52 ..B1.36
                                #       ..B1.39
                                # Execution count [5.00e+01]
        vsubsd    72(%rdi,%r10), %xmm5, %xmm19                  #85.48
        vsubsd    8(%rdi,%r10), %xmm6, %xmm18                   #84.48
        vsubsd    136(%rdi,%r10), %xmm4, %xmm20                 #86.48
        vmulsd    %xmm19, %xmm19, %xmm11                        #87.61
        vfmadd231sd %xmm18, %xmm18, %xmm11                      #87.75
        vfmadd231sd %xmm20, %xmm20, %xmm11                      #87.75
        vcomisd   %xmm11, %xmm10                                #88.34
        jbe       ..B1.59       # Prob 50%                      #88.34
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm18 xmm19 xmm20
..B1.55:                        # Preds ..B1.54
                                # Execution count [2.50e+01]
        vdivsd    %xmm11, %xmm8, %xmm13                         #89.51
        vmulsd    %xmm13, %xmm7, %xmm11                         #90.50
        vmulsd    %xmm3, %xmm13, %xmm14                         #91.67
        vmulsd    %xmm13, %xmm11, %xmm12                        #90.56
        vmulsd    %xmm13, %xmm12, %xmm15                        #90.62
        vmulsd    %xmm15, %xmm14, %xmm16                        #91.76
        vsubsd    %xmm9, %xmm15, %xmm17                         #91.67
        vmulsd    %xmm17, %xmm16, %xmm15                        #91.82
        vmulsd    %xmm15, %xmm18, %xmm17                        #94.67
        testl     %eax, %eax                                    #93.32
        je        ..B1.57       # Prob 50%                      #93.32
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm15 xmm17 xmm19 xmm20
..B1.56:                        # Preds ..B1.55
                                # Execution count [1.25e+01]
        vmovsd    8(%rdi,%rsi), %xmm11                          #94.33
        vmovsd    72(%rdi,%rsi), %xmm13                         #95.33
        vsubsd    %xmm17, %xmm11, %xmm12                        #94.33
        vmulsd    %xmm15, %xmm19, %xmm11                        #95.67
        vmovsd    %xmm12, 8(%rdi,%rsi)                          #94.33
        vsubsd    %xmm11, %xmm13, %xmm14                        #95.33
        vmulsd    %xmm15, %xmm20, %xmm12                        #96.67
        vmovsd    136(%rdi,%rsi), %xmm15                        #96.33
        vmovsd    %xmm14, 72(%rdi,%rsi)                         #95.33
        vsubsd    %xmm12, %xmm15, %xmm16                        #96.33
        vmovsd    %xmm16, 136(%rdi,%rsi)                        #96.33
        jmp       ..B1.58       # Prob 100%                     #96.33
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm17
..B1.57:                        # Preds ..B1.55
                                # Execution count [1.25e+01]
        vmulsd    %xmm15, %xmm19, %xmm11                        #100.43
        vmulsd    %xmm15, %xmm20, %xmm12                        #101.43
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm17
..B1.58:                        # Preds ..B1.56 ..B1.57
                                # Execution count [2.50e+01]
        incq      24(%r12)                                      #103.29
        movb      $1, %dl                                       #102.29
        vaddsd    %xmm17, %xmm2, %xmm2                          #99.29
        vaddsd    %xmm11, %xmm1, %xmm1                          #100.29
        vaddsd    %xmm12, %xmm0, %xmm0                          #101.29
        jmp       ..B1.60       # Prob 100%                     #101.29
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.59:                        # Preds ..B1.54
                                # Execution count [2.50e+01]
        incq      32(%r12)                                      #105.29
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.60:                        # Preds ..B1.58 ..B1.59
                                # Execution count [7.50e+01]
        testl     %eax, %eax                                    #77.28
        je        ..B1.68       # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.61:                        # Preds ..B1.60
                                # Execution count [3.75e+01]
        cmpl      %r9d, %r13d                                   #77.62
        jne       ..B1.70       # Prob 50%                      #77.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.62:                        # Preds ..B1.61
                                # Execution count [1.88e+01]
        cmpl      $2, %r8d                                      #77.99
        jl        ..B1.70       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.63:                        # Preds ..B1.62
                                # Execution count [6.25e+00]
        cmpl      $3, %r8d                                      #77.99
        jl        ..B1.83       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.64:                        # Preds ..B1.63 ..B1.50
                                # Execution count [3.91e+00]
        cmpl      $4, %r8d                                      #77.99
        jl        ..B1.96       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.65:                        # Preds ..B1.64
                                # Execution count [0.00e+00]
        testl     %eax, %eax                                    #77.28
        jne       ..B1.80       # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.66:                        # Preds ..B1.65
                                # Execution count [7.81e+00]
        cmpl      %r9d, %r13d                                   #78.62
        jne       ..B1.110      # Prob 50%                      #78.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.67:                        # Preds ..B1.66
                                # Execution count [3.91e+00]
        cmpl      $5, %r8d                                      #78.100
        jne       ..B1.110      # Prob 50%                      #78.100
        jmp       ..B1.107      # Prob 100%                     #78.100
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.68:                        # Preds ..B1.60
                                # Execution count [3.75e+01]
        cmpl      %r9d, %r13d                                   #78.62
        jne       ..B1.70       # Prob 50%                      #78.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.69:                        # Preds ..B1.68
                                # Execution count [1.88e+01]
        cmpl      $2, %r8d                                      #78.100
        je        ..B1.83       # Prob 50%                      #78.100
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.70:                        # Preds ..B1.37 ..B1.62 ..B1.69 ..B1.61 ..B1.68
                                #       ..B1.47 ..B1.53
                                # Execution count [5.00e+01]
        vsubsd    80(%rdi,%r10), %xmm5, %xmm19                  #85.48
        vsubsd    16(%rdi,%r10), %xmm6, %xmm18                  #84.48
        vsubsd    144(%rdi,%r10), %xmm4, %xmm20                 #86.48
        vmulsd    %xmm19, %xmm19, %xmm11                        #87.61
        vfmadd231sd %xmm18, %xmm18, %xmm11                      #87.75
        vfmadd231sd %xmm20, %xmm20, %xmm11                      #87.75
        vcomisd   %xmm11, %xmm10                                #88.34
        jbe       ..B1.75       # Prob 50%                      #88.34
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm18 xmm19 xmm20
..B1.71:                        # Preds ..B1.70
                                # Execution count [2.50e+01]
        vdivsd    %xmm11, %xmm8, %xmm13                         #89.51
        vmulsd    %xmm13, %xmm7, %xmm11                         #90.50
        vmulsd    %xmm3, %xmm13, %xmm14                         #91.67
        vmulsd    %xmm13, %xmm11, %xmm12                        #90.56
        vmulsd    %xmm13, %xmm12, %xmm15                        #90.62
        vmulsd    %xmm15, %xmm14, %xmm16                        #91.76
        vsubsd    %xmm9, %xmm15, %xmm17                         #91.67
        vmulsd    %xmm17, %xmm16, %xmm15                        #91.82
        vmulsd    %xmm15, %xmm18, %xmm17                        #94.67
        testl     %eax, %eax                                    #93.32
        je        ..B1.73       # Prob 50%                      #93.32
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm15 xmm17 xmm19 xmm20
..B1.72:                        # Preds ..B1.71
                                # Execution count [1.25e+01]
        vmovsd    16(%rdi,%rsi), %xmm11                         #94.33
        vmovsd    80(%rdi,%rsi), %xmm13                         #95.33
        vsubsd    %xmm17, %xmm11, %xmm12                        #94.33
        vmulsd    %xmm15, %xmm19, %xmm11                        #95.67
        vmovsd    %xmm12, 16(%rdi,%rsi)                         #94.33
        vsubsd    %xmm11, %xmm13, %xmm14                        #95.33
        vmulsd    %xmm15, %xmm20, %xmm12                        #96.67
        vmovsd    144(%rdi,%rsi), %xmm15                        #96.33
        vmovsd    %xmm14, 80(%rdi,%rsi)                         #95.33
        vsubsd    %xmm12, %xmm15, %xmm16                        #96.33
        vmovsd    %xmm16, 144(%rdi,%rsi)                        #96.33
        jmp       ..B1.74       # Prob 100%                     #96.33
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm17
..B1.73:                        # Preds ..B1.71
                                # Execution count [1.25e+01]
        vmulsd    %xmm15, %xmm19, %xmm11                        #100.43
        vmulsd    %xmm15, %xmm20, %xmm12                        #101.43
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm17
..B1.74:                        # Preds ..B1.72 ..B1.73
                                # Execution count [2.50e+01]
        incq      24(%r12)                                      #103.29
        movb      $1, %dl                                       #102.29
        vaddsd    %xmm17, %xmm2, %xmm2                          #99.29
        vaddsd    %xmm11, %xmm1, %xmm1                          #100.29
        vaddsd    %xmm12, %xmm0, %xmm0                          #101.29
        jmp       ..B1.76       # Prob 100%                     #101.29
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.75:                        # Preds ..B1.70
                                # Execution count [2.50e+01]
        incq      32(%r12)                                      #105.29
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.76:                        # Preds ..B1.74 ..B1.75
                                # Execution count [7.50e+01]
        testl     %eax, %eax                                    #77.28
        je        ..B1.81       # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.77:                        # Preds ..B1.76
                                # Execution count [3.75e+01]
        cmpl      %r9d, %r13d                                   #77.62
        jne       ..B1.83       # Prob 50%                      #77.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.78:                        # Preds ..B1.77
                                # Execution count [1.88e+01]
        cmpl      $3, %r8d                                      #77.99
        jl        ..B1.83       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.79:                        # Preds ..B1.78
                                # Execution count [2.34e+00]
        cmpl      $4, %r8d                                      #77.99
        jl        ..B1.96       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.80:                        # Preds ..B1.79 ..B1.65
                                # Execution count [7.81e+00]
        cmpl      %r9d, %r13d                                   #77.62
        jne       ..B1.110      # Prob 50%                      #77.62
        jmp       ..B1.92       # Prob 100%                     #77.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.81:                        # Preds ..B1.76
                                # Execution count [3.75e+01]
        cmpl      %r9d, %r13d                                   #78.62
        jne       ..B1.83       # Prob 50%                      #78.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.82:                        # Preds ..B1.48 ..B1.81
                                # Execution count [1.88e+01]
        cmpl      $3, %r8d                                      #78.100
        je        ..B1.96       # Prob 50%                      #78.100
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.83:                        # Preds ..B1.49 ..B1.78 ..B1.82 ..B1.77 ..B1.81
                                #       ..B1.63 ..B1.69
                                # Execution count [5.00e+01]
        vsubsd    88(%rdi,%r10), %xmm5, %xmm19                  #85.48
        vsubsd    24(%rdi,%r10), %xmm6, %xmm18                  #84.48
        vsubsd    152(%rdi,%r10), %xmm4, %xmm20                 #86.48
        vmulsd    %xmm19, %xmm19, %xmm11                        #87.61
        vfmadd231sd %xmm18, %xmm18, %xmm11                      #87.75
        vfmadd231sd %xmm20, %xmm20, %xmm11                      #87.75
        vcomisd   %xmm11, %xmm10                                #88.34
        jbe       ..B1.88       # Prob 50%                      #88.34
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm18 xmm19 xmm20
..B1.84:                        # Preds ..B1.83
                                # Execution count [2.50e+01]
        vdivsd    %xmm11, %xmm8, %xmm13                         #89.51
        vmulsd    %xmm13, %xmm7, %xmm11                         #90.50
        vmulsd    %xmm3, %xmm13, %xmm14                         #91.67
        vmulsd    %xmm13, %xmm11, %xmm12                        #90.56
        vmulsd    %xmm13, %xmm12, %xmm15                        #90.62
        vmulsd    %xmm15, %xmm14, %xmm16                        #91.76
        vsubsd    %xmm9, %xmm15, %xmm17                         #91.67
        vmulsd    %xmm17, %xmm16, %xmm15                        #91.82
        vmulsd    %xmm15, %xmm18, %xmm17                        #94.67
        testl     %eax, %eax                                    #93.32
        je        ..B1.86       # Prob 50%                      #93.32
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm15 xmm17 xmm19 xmm20
..B1.85:                        # Preds ..B1.84
                                # Execution count [1.25e+01]
        vmovsd    24(%rdi,%rsi), %xmm11                         #94.33
        vmovsd    88(%rdi,%rsi), %xmm13                         #95.33
        vsubsd    %xmm17, %xmm11, %xmm12                        #94.33
        vmulsd    %xmm15, %xmm19, %xmm11                        #95.67
        vmovsd    %xmm12, 24(%rdi,%rsi)                         #94.33
        vsubsd    %xmm11, %xmm13, %xmm14                        #95.33
        vmulsd    %xmm15, %xmm20, %xmm12                        #96.67
        vmovsd    152(%rdi,%rsi), %xmm15                        #96.33
        vmovsd    %xmm14, 88(%rdi,%rsi)                         #95.33
        vsubsd    %xmm12, %xmm15, %xmm16                        #96.33
        vmovsd    %xmm16, 152(%rdi,%rsi)                        #96.33
        jmp       ..B1.87       # Prob 100%                     #96.33
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm17
..B1.86:                        # Preds ..B1.84
                                # Execution count [1.25e+01]
        vmulsd    %xmm15, %xmm19, %xmm11                        #100.43
        vmulsd    %xmm15, %xmm20, %xmm12                        #101.43
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm17
..B1.87:                        # Preds ..B1.85 ..B1.86
                                # Execution count [2.50e+01]
        incq      24(%r12)                                      #103.29
        movb      $1, %dl                                       #102.29
        vaddsd    %xmm17, %xmm2, %xmm2                          #99.29
        vaddsd    %xmm11, %xmm1, %xmm1                          #100.29
        vaddsd    %xmm12, %xmm0, %xmm0                          #101.29
        jmp       ..B1.89       # Prob 100%                     #101.29
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.88:                        # Preds ..B1.83
                                # Execution count [2.50e+01]
        incq      32(%r12)                                      #105.29
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.89:                        # Preds ..B1.87 ..B1.88
                                # Execution count [7.50e+01]
        testl     %eax, %eax                                    #77.28
        je        ..B1.94       # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.90:                        # Preds ..B1.89
                                # Execution count [3.75e+01]
        cmpl      %r9d, %r13d                                   #77.62
        jne       ..B1.96       # Prob 50%                      #77.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.91:                        # Preds ..B1.90
                                # Execution count [1.88e+01]
        cmpl      $4, %r8d                                      #77.99
        jl        ..B1.96       # Prob 50%                      #77.99
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.92:                        # Preds ..B1.91 ..B1.80
                                # Execution count [6.25e+00]
        cmpl      $5, %r8d                                      #77.99
        jl        ..B1.110      # Prob 50%                      #77.99
        jmp       ..B1.107      # Prob 100%                     #77.99
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.94:                        # Preds ..B1.89
                                # Execution count [3.75e+01]
        cmpl      %r9d, %r13d                                   #78.62
        jne       ..B1.96       # Prob 50%                      #78.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.95:                        # Preds ..B1.94
                                # Execution count [1.88e+01]
        cmpl      $4, %r8d                                      #78.100
        je        ..B1.110      # Prob 50%                      #78.100
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.96:                        # Preds ..B1.82 ..B1.79 ..B1.91 ..B1.95 ..B1.90
                                #       ..B1.94 ..B1.50 ..B1.64
                                # Execution count [5.00e+01]
        vsubsd    96(%rdi,%r10), %xmm5, %xmm19                  #85.48
        vsubsd    32(%rdi,%r10), %xmm6, %xmm18                  #84.48
        vsubsd    160(%rdi,%r10), %xmm4, %xmm20                 #86.48
        vmulsd    %xmm19, %xmm19, %xmm11                        #87.61
        vfmadd231sd %xmm18, %xmm18, %xmm11                      #87.75
        vfmadd231sd %xmm20, %xmm20, %xmm11                      #87.75
        vcomisd   %xmm11, %xmm10                                #88.34
        jbe       ..B1.101      # Prob 50%                      #88.34
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm18 xmm19 xmm20
..B1.97:                        # Preds ..B1.96
                                # Execution count [2.50e+01]
        vdivsd    %xmm11, %xmm8, %xmm13                         #89.51
        vmulsd    %xmm13, %xmm7, %xmm11                         #90.50
        vmulsd    %xmm3, %xmm13, %xmm14                         #91.67
        vmulsd    %xmm13, %xmm11, %xmm12                        #90.56
        vmulsd    %xmm13, %xmm12, %xmm15                        #90.62
        vmulsd    %xmm15, %xmm14, %xmm16                        #91.76
        vsubsd    %xmm9, %xmm15, %xmm17                         #91.67
        vmulsd    %xmm17, %xmm16, %xmm15                        #91.82
        vmulsd    %xmm15, %xmm18, %xmm17                        #94.67
        testl     %eax, %eax                                    #93.32
        je        ..B1.99       # Prob 50%                      #93.32
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm15 xmm17 xmm19 xmm20
..B1.98:                        # Preds ..B1.97
                                # Execution count [1.25e+01]
        vmovsd    32(%rdi,%rsi), %xmm11                         #94.33
        vmovsd    96(%rdi,%rsi), %xmm13                         #95.33
        vsubsd    %xmm17, %xmm11, %xmm12                        #94.33
        vmulsd    %xmm15, %xmm19, %xmm11                        #95.67
        vmovsd    %xmm12, 32(%rdi,%rsi)                         #94.33
        vsubsd    %xmm11, %xmm13, %xmm14                        #95.33
        vmulsd    %xmm15, %xmm20, %xmm12                        #96.67
        vmovsd    160(%rdi,%rsi), %xmm15                        #96.33
        vmovsd    %xmm14, 96(%rdi,%rsi)                         #95.33
        vsubsd    %xmm12, %xmm15, %xmm16                        #96.33
        vmovsd    %xmm16, 160(%rdi,%rsi)                        #96.33
        jmp       ..B1.100      # Prob 100%                     #96.33
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm17
..B1.99:                        # Preds ..B1.97
                                # Execution count [1.25e+01]
        vmulsd    %xmm15, %xmm19, %xmm11                        #100.43
        vmulsd    %xmm15, %xmm20, %xmm12                        #101.43
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm17
..B1.100:                       # Preds ..B1.98 ..B1.99
                                # Execution count [2.50e+01]
        incq      24(%r12)                                      #103.29
        movb      $1, %dl                                       #102.29
        vaddsd    %xmm17, %xmm2, %xmm2                          #99.29
        vaddsd    %xmm11, %xmm1, %xmm1                          #100.29
        vaddsd    %xmm12, %xmm0, %xmm0                          #101.29
        jmp       ..B1.102      # Prob 100%                     #101.29
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.101:                       # Preds ..B1.96
                                # Execution count [2.50e+01]
        incq      32(%r12)                                      #105.29
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.102:                       # Preds ..B1.100 ..B1.101
                                # Execution count [7.50e+01]
        testl     %eax, %eax                                    #77.28
        je        ..B1.105      # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.103:                       # Preds ..B1.102
                                # Execution count [3.75e+01]
        cmpl      %r9d, %r13d                                   #77.62
        jne       ..B1.110      # Prob 50%                      #77.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.104:                       # Preds ..B1.103
                                # Execution count [1.88e+01]
        cmpl      $5, %r8d                                      #77.99
        jl        ..B1.110      # Prob 50%                      #77.99
        jmp       ..B1.107      # Prob 100%                     #77.99
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.105:                       # Preds ..B1.102
                                # Execution count [3.75e+01]
        cmpl      %r9d, %r13d                                   #78.62
        jne       ..B1.110      # Prob 50%                      #78.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.106:                       # Preds ..B1.105
                                # Execution count [1.88e+01]
        cmpl      $5, %r8d                                      #78.100
        jne       ..B1.110      # Prob 50%                      #78.100
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.107:                       # Preds ..B1.92 ..B1.67 ..B1.106 ..B1.104
                                # Execution count [9.38e+00]
        testl     %eax, %eax                                    #77.28
        jne       ..B1.117      # Prob 50%                      #77.28
        jmp       ..B1.120      # Prob 100%                     #77.28
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.110:                       # Preds ..B1.95 ..B1.104 ..B1.106 ..B1.103 ..B1.105
                                #       ..B1.80 ..B1.92 ..B1.66 ..B1.67
                                # Execution count [5.00e+01]
        vsubsd    104(%rdi,%r10), %xmm5, %xmm19                 #85.48
        vsubsd    40(%rdi,%r10), %xmm6, %xmm18                  #84.48
        vsubsd    168(%rdi,%r10), %xmm4, %xmm20                 #86.48
        vmulsd    %xmm19, %xmm19, %xmm11                        #87.61
        vfmadd231sd %xmm18, %xmm18, %xmm11                      #87.75
        vfmadd231sd %xmm20, %xmm20, %xmm11                      #87.75
        vcomisd   %xmm11, %xmm10                                #88.34
        jbe       ..B1.115      # Prob 50%                      #88.34
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm18 xmm19 xmm20
..B1.111:                       # Preds ..B1.110
                                # Execution count [2.50e+01]
        vdivsd    %xmm11, %xmm8, %xmm13                         #89.51
        vmulsd    %xmm13, %xmm7, %xmm11                         #90.50
        vmulsd    %xmm3, %xmm13, %xmm14                         #91.67
        vmulsd    %xmm13, %xmm11, %xmm12                        #90.56
        vmulsd    %xmm13, %xmm12, %xmm15                        #90.62
        vmulsd    %xmm15, %xmm14, %xmm16                        #91.76
        vsubsd    %xmm9, %xmm15, %xmm17                         #91.67
        vmulsd    %xmm17, %xmm16, %xmm15                        #91.82
        vmulsd    %xmm15, %xmm18, %xmm17                        #94.67
        testl     %eax, %eax                                    #93.32
        je        ..B1.113      # Prob 50%                      #93.32
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm15 xmm17 xmm19 xmm20
..B1.112:                       # Preds ..B1.111
                                # Execution count [1.25e+01]
        vmovsd    40(%rdi,%rsi), %xmm11                         #94.33
        vmovsd    104(%rdi,%rsi), %xmm13                        #95.33
        vsubsd    %xmm17, %xmm11, %xmm12                        #94.33
        vmulsd    %xmm15, %xmm19, %xmm11                        #95.67
        vmovsd    %xmm12, 40(%rdi,%rsi)                         #94.33
        vsubsd    %xmm11, %xmm13, %xmm14                        #95.33
        vmulsd    %xmm15, %xmm20, %xmm12                        #96.67
        vmovsd    168(%rdi,%rsi), %xmm15                        #96.33
        vmovsd    %xmm14, 104(%rdi,%rsi)                        #95.33
        vsubsd    %xmm12, %xmm15, %xmm16                        #96.33
        vmovsd    %xmm16, 168(%rdi,%rsi)                        #96.33
        jmp       ..B1.114      # Prob 100%                     #96.33
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm17
..B1.113:                       # Preds ..B1.111
                                # Execution count [1.25e+01]
        vmulsd    %xmm15, %xmm19, %xmm11                        #100.43
        vmulsd    %xmm15, %xmm20, %xmm12                        #101.43
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm17
..B1.114:                       # Preds ..B1.112 ..B1.113
                                # Execution count [2.50e+01]
        incq      24(%r12)                                      #103.29
        movb      $1, %dl                                       #102.29
        vaddsd    %xmm17, %xmm2, %xmm2                          #99.29
        vaddsd    %xmm11, %xmm1, %xmm1                          #100.29
        vaddsd    %xmm12, %xmm0, %xmm0                          #101.29
        jmp       ..B1.116      # Prob 100%                     #101.29
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.115:                       # Preds ..B1.110
                                # Execution count [2.50e+01]
        incq      32(%r12)                                      #105.29
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.116:                       # Preds ..B1.114 ..B1.115
                                # Execution count [7.50e+01]
        testl     %eax, %eax                                    #77.28
        je        ..B1.120      # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.117:                       # Preds ..B1.107 ..B1.116
                                # Execution count [3.75e+01]
        cmpl      %r9d, %r13d                                   #77.62
        jne       ..B1.123      # Prob 50%                      #77.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.119:                       # Preds ..B1.117
                                # Execution count [2.50e+01]
        cmpl      $6, %r8d                                      #77.99
        jl        ..B1.123      # Prob 50%                      #77.99
        jmp       ..B1.130      # Prob 100%                     #77.99
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.120:                       # Preds ..B1.107 ..B1.116
                                # Execution count [3.75e+01]
        cmpl      %r9d, %r13d                                   #78.62
        jne       ..B1.123      # Prob 50%                      #78.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.122:                       # Preds ..B1.120
                                # Execution count [2.50e+01]
        cmpl      $6, %r8d                                      #78.100
        je        ..B1.130      # Prob 50%                      #78.100
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.123:                       # Preds ..B1.117 ..B1.120 ..B1.119 ..B1.122
                                # Execution count [5.00e+01]
        vsubsd    112(%rdi,%r10), %xmm5, %xmm19                 #85.48
        vsubsd    48(%rdi,%r10), %xmm6, %xmm18                  #84.48
        vsubsd    176(%rdi,%r10), %xmm4, %xmm20                 #86.48
        vmulsd    %xmm19, %xmm19, %xmm11                        #87.61
        vfmadd231sd %xmm18, %xmm18, %xmm11                      #87.75
        vfmadd231sd %xmm20, %xmm20, %xmm11                      #87.75
        vcomisd   %xmm11, %xmm10                                #88.34
        jbe       ..B1.128      # Prob 50%                      #88.34
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm18 xmm19 xmm20
..B1.124:                       # Preds ..B1.123
                                # Execution count [2.50e+01]
        vdivsd    %xmm11, %xmm8, %xmm13                         #89.51
        vmulsd    %xmm13, %xmm7, %xmm11                         #90.50
        vmulsd    %xmm3, %xmm13, %xmm14                         #91.67
        vmulsd    %xmm13, %xmm11, %xmm12                        #90.56
        vmulsd    %xmm13, %xmm12, %xmm15                        #90.62
        vmulsd    %xmm15, %xmm14, %xmm16                        #91.76
        vsubsd    %xmm9, %xmm15, %xmm17                         #91.67
        vmulsd    %xmm17, %xmm16, %xmm15                        #91.82
        vmulsd    %xmm15, %xmm18, %xmm17                        #94.67
        testl     %eax, %eax                                    #93.32
        je        ..B1.126      # Prob 50%                      #93.32
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm15 xmm17 xmm19 xmm20
..B1.125:                       # Preds ..B1.124
                                # Execution count [1.25e+01]
        vmovsd    48(%rdi,%rsi), %xmm11                         #94.33
        vmovsd    112(%rdi,%rsi), %xmm13                        #95.33
        vsubsd    %xmm17, %xmm11, %xmm12                        #94.33
        vmulsd    %xmm15, %xmm19, %xmm11                        #95.67
        vmovsd    %xmm12, 48(%rdi,%rsi)                         #94.33
        vsubsd    %xmm11, %xmm13, %xmm14                        #95.33
        vmulsd    %xmm15, %xmm20, %xmm12                        #96.67
        vmovsd    176(%rdi,%rsi), %xmm15                        #96.33
        vmovsd    %xmm14, 112(%rdi,%rsi)                        #95.33
        vsubsd    %xmm12, %xmm15, %xmm16                        #96.33
        vmovsd    %xmm16, 176(%rdi,%rsi)                        #96.33
        jmp       ..B1.127      # Prob 100%                     #96.33
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm17
..B1.126:                       # Preds ..B1.124
                                # Execution count [1.25e+01]
        vmulsd    %xmm15, %xmm19, %xmm11                        #100.43
        vmulsd    %xmm15, %xmm20, %xmm12                        #101.43
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10 xmm11 xmm12 xmm17
..B1.127:                       # Preds ..B1.125 ..B1.126
                                # Execution count [2.50e+01]
        incq      24(%r12)                                      #103.29
        movb      $1, %dl                                       #102.29
        vaddsd    %xmm17, %xmm2, %xmm2                          #99.29
        vaddsd    %xmm11, %xmm1, %xmm1                          #100.29
        vaddsd    %xmm12, %xmm0, %xmm0                          #101.29
        jmp       ..B1.130      # Prob 100%                     #101.29
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.128:                       # Preds ..B1.123
                                # Execution count [2.50e+01]
        incq      32(%r12)                                      #105.29
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.130:                       # Preds ..B1.128 ..B1.127 ..B1.122 ..B1.119
                                # Execution count [1.25e+01]
        testl     %eax, %eax                                    #77.28
        je        ..B1.133      # Prob 50%                      #77.28
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.131:                       # Preds ..B1.130
                                # Execution count [5.00e+01]
        cmpl      %r9d, %r13d                                   #77.62
        jne       ..B1.135      # Prob 50%                      #77.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.132:                       # Preds ..B1.131
                                # Execution count [2.50e+01]
        cmpl      $7, %r8d                                      #77.99
        jl        ..B1.135      # Prob 50%                      #77.99
        jmp       ..B1.141      # Prob 100%                     #77.99
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.133:                       # Preds ..B1.130
                                # Execution count [5.00e+01]
        cmpl      %r9d, %r13d                                   #78.62
        jne       ..B1.135      # Prob 50%                      #78.62
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.134:                       # Preds ..B1.133
                                # Execution count [2.50e+01]
        cmpl      $7, %r8d                                      #78.100
        je        ..B1.141      # Prob 50%                      #78.100
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm6 xmm7 xmm8 xmm9 xmm10
..B1.135:                       # Preds ..B1.131 ..B1.132 ..B1.133 ..B1.134
                                # Execution count [5.00e+01]
        vsubsd    120(%rdi,%r10), %xmm5, %xmm16                 #85.48
        vsubsd    56(%rdi,%r10), %xmm6, %xmm15                  #84.48
        vsubsd    184(%rdi,%r10), %xmm4, %xmm17                 #86.48
        vmulsd    %xmm16, %xmm16, %xmm4                         #87.61
        vfmadd231sd %xmm15, %xmm15, %xmm4                       #87.75
        vfmadd231sd %xmm17, %xmm17, %xmm4                       #87.75
        vcomisd   %xmm4, %xmm10                                 #88.34
        jbe       ..B1.140      # Prob 50%                      #88.34
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm7 xmm8 xmm9 xmm10 xmm15 xmm16 xmm17
..B1.136:                       # Preds ..B1.135
                                # Execution count [2.50e+01]
        vdivsd    %xmm4, %xmm8, %xmm6                           #89.51
        vmulsd    %xmm6, %xmm7, %xmm4                           #90.50
        vmulsd    %xmm3, %xmm6, %xmm11                          #91.67
        vmulsd    %xmm6, %xmm4, %xmm5                           #90.56
        vmulsd    %xmm6, %xmm5, %xmm12                          #90.62
        vmulsd    %xmm12, %xmm11, %xmm13                        #91.76
        vsubsd    %xmm9, %xmm12, %xmm14                         #91.67
        vmulsd    %xmm14, %xmm13, %xmm12                        #91.82
        vmulsd    %xmm12, %xmm15, %xmm14                        #94.67
        testl     %eax, %eax                                    #93.32
        je        ..B1.138      # Prob 50%                      #93.32
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm7 xmm8 xmm9 xmm10 xmm12 xmm14 xmm16 xmm17
..B1.137:                       # Preds ..B1.136
                                # Execution count [1.25e+01]
        vmovsd    56(%rdi,%rsi), %xmm4                          #94.33
        vmovsd    120(%rdi,%rsi), %xmm6                         #95.33
        vsubsd    %xmm14, %xmm4, %xmm5                          #94.33
        vmulsd    %xmm12, %xmm16, %xmm4                         #95.67
        vmovsd    %xmm5, 56(%rdi,%rsi)                          #94.33
        vsubsd    %xmm4, %xmm6, %xmm11                          #95.33
        vmulsd    %xmm12, %xmm17, %xmm5                         #96.67
        vmovsd    184(%rdi,%rsi), %xmm12                        #96.33
        vmovsd    %xmm11, 120(%rdi,%rsi)                        #95.33
        vsubsd    %xmm5, %xmm12, %xmm13                         #96.33
        vmovsd    %xmm13, 184(%rdi,%rsi)                        #96.33
        jmp       ..B1.139      # Prob 100%                     #96.33
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm7 xmm8 xmm9 xmm10 xmm14
..B1.138:                       # Preds ..B1.136
                                # Execution count [1.25e+01]
        vmulsd    %xmm12, %xmm16, %xmm4                         #100.43
        vmulsd    %xmm12, %xmm17, %xmm5                         #101.43
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d cl xmm0 xmm1 xmm2 xmm3 xmm4 xmm5 xmm7 xmm8 xmm9 xmm10 xmm14
..B1.139:                       # Preds ..B1.137 ..B1.138
                                # Execution count [2.50e+01]
        incq      24(%r12)                                      #103.29
        movb      $1, %dl                                       #102.29
        vaddsd    %xmm14, %xmm2, %xmm2                          #99.29
        vaddsd    %xmm4, %xmm1, %xmm1                           #100.29
        vaddsd    %xmm5, %xmm0, %xmm0                           #101.29
        jmp       ..B1.142      # Prob 100%                     #101.29
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm7 xmm8 xmm9 xmm10
..B1.140:                       # Preds ..B1.135
                                # Execution count [2.50e+01]
        incq      32(%r12)                                      #105.29
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm7 xmm8 xmm9 xmm10
..B1.141:                       # Preds ..B1.132 ..B1.134 ..B1.140
                                # Execution count [7.50e+01]
        testb     %dl, %dl                                      #110.27
        je        ..B1.143      # Prob 50%                      #110.27
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm7 xmm8 xmm9 xmm10
..B1.142:                       # Preds ..B1.139 ..B1.141
                                # Execution count [5.00e+01]
        incq      40(%r12)                                      #111.21
        jmp       ..B1.144      # Prob 100%                     #111.21
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm7 xmm8 xmm9 xmm10
..B1.143:                       # Preds ..B1.141
                                # Execution count [5.00e+01]
        incq      48(%r12)                                      #113.21
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm0 xmm1 xmm2 xmm3 xmm7 xmm8 xmm9 xmm10
..B1.144:                       # Preds ..B1.142 ..B1.143
                                # Execution count [1.00e+02]
        incb      %cl                                           #63.13
        incl      %r8d                                          #63.13
        vaddsd    (%r14,%rbx,8), %xmm2, %xmm2                   #116.17
        vaddsd    64(%r14,%rbx,8), %xmm1, %xmm1                 #117.17
        vaddsd    128(%r14,%rbx,8), %xmm0, %xmm0                #118.17
        vmovsd    %xmm2, (%r14,%rbx,8)                          #116.17
        vmovsd    %xmm1, 64(%r14,%rbx,8)                        #117.17
        vmovsd    %xmm0, 128(%r14,%rbx,8)                       #118.17
        incq      %rbx                                          #63.13
        cmpb      $4, %cl                                       #63.13
        jb        ..B1.33       # Prob 75%                      #63.13
                                # LOE rbx rsi rdi r10 r11 r12 r14 eax r8d r9d r13d r15d dl cl xmm3 xmm7 xmm8 xmm9 xmm10
..B1.145:                       # Preds ..B1.144
                                # Execution count [2.50e+01]
        movq      112(%rsp), %r10                               #[spill]
        incq      %r10                                          #56.9
        movq      104(%rsp), %r12                               #[spill]
        movq      96(%rsp), %rsi                                #[spill]
        cmpq      %r12, %r10                                    #56.9
        jb        ..B1.32       # Prob 82%                      #56.9
                                # LOE rsi r10 r11 r12 r14 eax r13d r15d xmm3 xmm7 xmm8 xmm9 xmm10
..B1.146:                       # Preds ..B1.145
                                # Execution count [4.50e+00]
        movq      48(%rsp), %rdx                                #[spill]
        movl      40(%rsp), %ecx                                #[spill]
        movq      24(%rsp), %rax                                #[spill]
        movq      16(%rsp), %rbx                                #[spill]
        movq      8(%rsp), %rdi                                 #[spill]
        movq      80(%rsp), %r8                                 #[spill]
        movq      88(%rsp), %r9                                 #[spill]
                                # LOE rax rdx rbx rsi rdi r8 r9 r12 ecx xmm3 xmm7 xmm8 xmm9 xmm10
..B1.147:                       # Preds ..B1.146 ..B1.30
                                # Execution count [5.00e+00]
        vxorpd    %xmm16, %xmm16, %xmm16                        #124.9
        addq      %r12, %rbx                                    #123.9
        vcvtsi2sd %r12d, %xmm16, %xmm16                         #124.9
        vmulsd    %xmm16, %xmm9, %xmm0                          #124.9
        incl      %ecx                                          #47.5
        vcvttsd2si %xmm0, %r10                                  #124.9
        incq      %rdx                                          #47.5
        addq      %r10, %rax                                    #124.9
        lea       (%rsi,%rdi,4), %rsi                           #47.5
        cmpl      56(%rsp), %ecx                                #47.5[spill]
        jb        ..B1.30       # Prob 82%                      #47.5
                                # LOE rax rdx rbx rsi rdi r8 r9 ecx xmm3 xmm7 xmm8 xmm9 xmm10
..B1.148:                       # Preds ..B1.147
                                # Execution count [9.00e-01]
        movq      72(%rsp), %r13                                #[spill]
        movq      %rax, 16(%r13)                                #124.9
        movq      %rbx, 8(%r13)                                 #123.9
                                # LOE r12
..B1.149:                       # Preds ..B1.26 ..B1.148
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.1, %edi                         #127.5
..___tag_value_computeForceLJ_ref.56:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #127.5
..___tag_value_computeForceLJ_ref.57:
                                # LOE r12
..B1.150:                       # Preds ..B1.149
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #130.16
..___tag_value_computeForceLJ_ref.58:
#       getTimeStamp()
        call      getTimeStamp                                  #130.16
..___tag_value_computeForceLJ_ref.59:
                                # LOE r12 xmm0
..B1.157:                       # Preds ..B1.150
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 8(%rsp)                                #130.16[spill]
                                # LOE r12
..B1.151:                       # Preds ..B1.157
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.2, %edi                         #131.5
        xorl      %eax, %eax                                    #131.5
..___tag_value_computeForceLJ_ref.61:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #131.5
..___tag_value_computeForceLJ_ref.62:
                                # LOE r12
..B1.152:                       # Preds ..B1.151
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
..B1.153:                       # Preds ..B1.5
                                # Execution count [4.50e-01]: Infreq
        xorl      %r10d, %r10d                                  #33.9
        jmp       ..B1.18       # Prob 100%                     #33.9
        .align    16,0x90
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
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
        movq      %rdi, %r15                                    #287.97
        movl      $.L_2__STRING.3, %edi                         #288.5
        xorl      %eax, %eax                                    #288.5
        movq      %rcx, %r14                                    #287.97
        movq      %rdx, %r13                                    #287.97
        movq      %rsi, %rbx                                    #287.97
..___tag_value_computeForceLJ_2xnn_full.90:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #288.5
..___tag_value_computeForceLJ_2xnn_full.91:
                                # LOE rbx r12 r13 r14 r15
..B2.2:                         # Preds ..B2.1
                                # Execution count [1.00e+00]
        vmovsd    144(%r15), %xmm0                              #291.27
        xorl      %ecx, %ecx                                    #301.5
        vmulsd    %xmm0, %xmm0, %xmm1                           #294.36
        xorl      %esi, %esi                                    #303.27
        vbroadcastsd 56(%r15), %zmm3                            #295.32
        vbroadcastsd 40(%r15), %zmm4                            #296.29
        vbroadcastsd %xmm1, %zmm2                               #294.36
        vmovups   %zmm3, 128(%rsp)                              #295.32[spill]
        vmovups   %zmm4, (%rsp)                                 #296.29[spill]
        vmovups   %zmm2, 64(%rsp)                               #294.36[spill]
        movl      20(%rbx), %edx                                #301.26
        testl     %edx, %edx                                    #301.26
        jle       ..B2.24       # Prob 9%                       #301.26
                                # LOE rbx rsi r12 r13 r14 edx ecx
..B2.3:                         # Preds ..B2.2
                                # Execution count [9.00e-01]
        movq      176(%rbx), %rdi                               #303.27
        movq      192(%rbx), %rax                               #304.32
        vxorpd    %ymm2, %ymm2, %ymm2                           #305.39
        vmovdqu   .L_2il0floatpacket.0(%rip), %xmm1             #304.9
        vmovdqu   .L_2il0floatpacket.1(%rip), %xmm0             #304.9
                                # LOE rax rbx rsi rdi r13 r14 edx ecx xmm0 xmm1 ymm2
..B2.4:                         # Preds ..B2.22 ..B2.3
                                # Execution count [5.00e+00]
        movl      %ecx, %r8d                                    #302.27
        movl      %ecx, %r9d                                    #302.27
        sarl      $1, %r8d                                      #302.27
        andl      $1, %r9d                                      #302.27
        shll      $2, %r9d                                      #302.27
        lea       (%r8,%r8,2), %r10d                            #302.27
        lea       (%r9,%r10,8), %r11d                           #302.27
        movslq    %r11d, %r11                                   #303.27
        lea       (%rdi,%r11,8), %r12                           #303.27
        movl      (%rsi,%rax), %r11d                            #304.32
        testl     %r11d, %r11d                                  #304.32
        jle       ..B2.22       # Prob 50%                      #304.32
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r11d xmm0 xmm1 ymm2
..B2.5:                         # Preds ..B2.4
                                # Execution count [4.50e+00]
        cmpl      $16, %r11d                                    #304.9
        jl        ..B2.38       # Prob 10%                      #304.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r11d xmm0 xmm1 ymm2
..B2.6:                         # Preds ..B2.5
                                # Execution count [4.50e+00]
        lea       128(%r12), %r8                                #307.13
        andq      $63, %r8                                      #304.9
        testl     $7, %r8d                                      #304.9
        je        ..B2.8        # Prob 50%                      #304.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B2.7:                         # Preds ..B2.6
                                # Execution count [2.25e+00]
        xorl      %r8d, %r8d                                    #304.9
        jmp       ..B2.10       # Prob 100%                     #304.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B2.8:                         # Preds ..B2.6
                                # Execution count [2.25e+00]
        testl     %r8d, %r8d                                    #304.9
        je        ..B2.10       # Prob 50%                      #304.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B2.9:                         # Preds ..B2.8
                                # Execution count [2.50e+01]
        negl      %r8d                                          #304.9
        addl      $64, %r8d                                     #304.9
        shrl      $3, %r8d                                      #304.9
        cmpl      %r8d, %r11d                                   #304.9
        cmovl     %r11d, %r8d                                   #304.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B2.10:                        # Preds ..B2.7 ..B2.9 ..B2.8
                                # Execution count [5.00e+00]
        movl      %r11d, %r10d                                  #304.9
        subl      %r8d, %r10d                                   #304.9
        andl      $15, %r10d                                    #304.9
        negl      %r10d                                         #304.9
        addl      %r11d, %r10d                                  #304.9
        cmpl      $1, %r8d                                      #304.9
        jb        ..B2.14       # Prob 50%                      #304.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r10d r11d xmm0 xmm1 ymm2
..B2.11:                        # Preds ..B2.10
                                # Execution count [4.50e+00]
        vpbroadcastd %r8d, %xmm3                                #304.9
        xorl      %r15d, %r15d                                  #304.9
        vmovdqa   %xmm0, %xmm4                                  #304.9
        movslq    %r8d, %r9                                     #304.9
                                # LOE rax rbx rsi rdi r9 r12 r13 r14 r15 edx ecx r8d r10d r11d xmm0 xmm1 xmm3 xmm4 ymm2
..B2.12:                        # Preds ..B2.12 ..B2.11
                                # Execution count [2.50e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #304.9
        vpaddd    %xmm1, %xmm4, %xmm4                           #304.9
        vmovupd   %ymm2, (%r12,%r15,8){%k1}                     #305.13
        vmovupd   %ymm2, 64(%r12,%r15,8){%k1}                   #306.13
        vmovupd   %ymm2, 128(%r12,%r15,8){%k1}                  #307.13
        addq      $4, %r15                                      #304.9
        cmpq      %r9, %r15                                     #304.9
        jb        ..B2.12       # Prob 82%                      #304.9
                                # LOE rax rbx rsi rdi r9 r12 r13 r14 r15 edx ecx r8d r10d r11d xmm0 xmm1 xmm3 xmm4 ymm2
..B2.13:                        # Preds ..B2.12
                                # Execution count [4.50e+00]
        cmpl      %r8d, %r11d                                   #304.9
        je        ..B2.22       # Prob 10%                      #304.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r10d r11d xmm0 xmm1 ymm2
..B2.14:                        # Preds ..B2.10 ..B2.13
                                # Execution count [2.50e+01]
        lea       16(%r8), %r9d                                 #304.9
        cmpl      %r9d, %r10d                                   #304.9
        jl        ..B2.18       # Prob 50%                      #304.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r10d r11d xmm0 xmm1 ymm2
..B2.15:                        # Preds ..B2.14
                                # Execution count [4.50e+00]
        movslq    %r8d, %r8                                     #304.9
        movslq    %r10d, %r9                                    #304.9
        .align    16,0x90
                                # LOE rax rbx rsi rdi r8 r9 r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
..B2.16:                        # Preds ..B2.16 ..B2.15
                                # Execution count [2.50e+01]
        vmovupd   %ymm2, (%r12,%r8,8)                           #305.13
        vmovupd   %ymm2, 32(%r12,%r8,8)                         #305.13
        vmovupd   %ymm2, 64(%r12,%r8,8)                         #305.13
        vmovupd   %ymm2, 128(%r12,%r8,8)                        #306.13
        vmovupd   %ymm2, 192(%r12,%r8,8)                        #307.13
        vmovupd   %ymm2, 96(%r12,%r8,8)                         #305.13
        vmovupd   %ymm2, 160(%r12,%r8,8)                        #306.13
        vmovupd   %ymm2, 224(%r12,%r8,8)                        #307.13
        addq      $16, %r8                                      #304.9
        cmpq      %r9, %r8                                      #304.9
        jb        ..B2.16       # Prob 82%                      #304.9
                                # LOE rax rbx rsi rdi r8 r9 r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
..B2.18:                        # Preds ..B2.16 ..B2.14 ..B2.38
                                # Execution count [5.00e+00]
        lea       1(%r10), %r8d                                 #304.9
        cmpl      %r11d, %r8d                                   #304.9
        ja        ..B2.22       # Prob 50%                      #304.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
..B2.19:                        # Preds ..B2.18
                                # Execution count [4.50e+00]
        movslq    %r10d, %r9                                    #305.13
        negl      %r10d                                         #304.9
        addl      %r11d, %r10d                                  #304.9
        xorl      %r8d, %r8d                                    #304.9
        movslq    %r11d, %r11                                   #304.9
        vmovdqa   %xmm0, %xmm4                                  #304.9
        vpbroadcastd %r10d, %xmm3                               #304.9
        subq      %r9, %r11                                     #304.9
        lea       (%r12,%r9,8), %r12                            #305.13
                                # LOE rax rbx rsi rdi r8 r11 r12 r13 r14 edx ecx xmm0 xmm1 xmm3 xmm4 ymm2
..B2.20:                        # Preds ..B2.20 ..B2.19
                                # Execution count [2.50e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #304.9
        vpaddd    %xmm1, %xmm4, %xmm4                           #304.9
        vmovupd   %ymm2, (%r12,%r8,8){%k1}                      #305.13
        vmovupd   %ymm2, 64(%r12,%r8,8){%k1}                    #306.13
        vmovupd   %ymm2, 128(%r12,%r8,8){%k1}                   #307.13
        addq      $4, %r8                                       #304.9
        cmpq      %r11, %r8                                     #304.9
        jb        ..B2.20       # Prob 82%                      #304.9
                                # LOE rax rbx rsi rdi r8 r11 r12 r13 r14 edx ecx xmm0 xmm1 xmm3 xmm4 ymm2
..B2.22:                        # Preds ..B2.20 ..B2.4 ..B2.13 ..B2.18
                                # Execution count [5.00e+00]
        incl      %ecx                                          #301.5
        addq      $56, %rsi                                     #301.5
        cmpl      %edx, %ecx                                    #301.5
        jb        ..B2.4        # Prob 82%                      #301.5
                                # LOE rax rbx rsi rdi r13 r14 edx ecx xmm0 xmm1 ymm2
..B2.24:                        # Preds ..B2.22 ..B2.2
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #311.16
        vzeroupper                                              #311.16
..___tag_value_computeForceLJ_2xnn_full.95:
#       getTimeStamp()
        call      getTimeStamp                                  #311.16
..___tag_value_computeForceLJ_2xnn_full.96:
                                # LOE rbx r12 r13 r14 xmm0
..B2.41:                        # Preds ..B2.24
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 192(%rsp)                              #311.16[spill]
                                # LOE rbx r12 r13 r14
..B2.25:                        # Preds ..B2.41
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.1, %edi                         #315.5
..___tag_value_computeForceLJ_2xnn_full.98:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #315.5
..___tag_value_computeForceLJ_2xnn_full.99:
                                # LOE rbx r12 r13 r14
..B2.26:                        # Preds ..B2.25
                                # Execution count [1.00e+00]
        xorl      %edx, %edx                                    #318.16
        xorl      %eax, %eax                                    #318.16
        cmpl      $0, 20(%rbx)                                  #318.26
        jle       ..B2.34       # Prob 10%                      #318.26
                                # LOE rax rbx r12 r13 r14 edx
..B2.27:                        # Preds ..B2.26
                                # Execution count [9.00e-01]
        movl      $65484, %ecx                                  #406.9
        kmovw     %ecx, %k2                                     #406.9
        movl      $65450, %ecx                                  #406.9
        kmovw     %ecx, %k1                                     #406.9
        vmovups   (%rsp), %zmm25                                #406.9[spill]
        vmovups   128(%rsp), %zmm26                             #406.9[spill]
        vmovups   64(%rsp), %zmm27                              #406.9[spill]
        vbroadcastsd .L_2il0floatpacket.2(%rip), %zmm28         #406.9
        vbroadcastsd .L_2il0floatpacket.3(%rip), %zmm24         #406.9
        vpxord    %zmm8, %zmm8, %zmm8                           #335.30
                                # LOE rax rbx r13 r14 edx zmm8 zmm24 zmm25 zmm26 zmm27 zmm28 k1 k2
..B2.28:                        # Preds ..B2.32 ..B2.27
                                # Execution count [5.00e+00]
        movl      %edx, %r8d                                    #323.27
        movl      %edx, %r12d                                   #323.27
        sarl      $1, %r8d                                      #323.27
        andl      $1, %r12d                                     #323.27
        shll      $2, %r12d                                     #323.27
        xorl      %r9d, %r9d                                    #342.19
        movl      16(%r13), %ecx                                #326.44
        imull     %edx, %ecx                                    #326.44
        movq      160(%rbx), %r11                               #324.27
        lea       (%r8,%r8,2), %r15d                            #323.27
        vmovaps   %zmm8, %zmm16                                 #335.30
        lea       (%r12,%r15,8), %r8d                           #323.27
        movslq    %r8d, %r8                                     #323.27
        vmovaps   %zmm16, %zmm15                                #336.30
        movslq    %ecx, %rcx                                    #326.19
        vmovaps   %zmm15, %zmm14                                #337.30
        vbroadcastsd 8(%r11,%r8,8), %ymm20                      #329.33
        vbroadcastsd 24(%r11,%r8,8), %ymm18                     #330.33
        vbroadcastsd 72(%r11,%r8,8), %ymm0                      #331.33
        vbroadcastsd 88(%r11,%r8,8), %ymm2                      #332.33
        vbroadcastsd 136(%r11,%r8,8), %ymm4                     #333.33
        vbroadcastsd 152(%r11,%r8,8), %ymm6                     #334.33
        vbroadcastsd 128(%r11,%r8,8), %zmm3                     #333.33
        vbroadcastsd 64(%r11,%r8,8), %zmm17                     #331.33
        vbroadcastsd (%r11,%r8,8), %zmm21                       #329.33
        vbroadcastsd 16(%r11,%r8,8), %zmm19                     #330.33
        vbroadcastsd 80(%r11,%r8,8), %zmm1                      #332.33
        vbroadcastsd 144(%r11,%r8,8), %zmm5                     #334.33
        vinsertf64x4 $1, %ymm20, %zmm21, %zmm21                 #329.33
        vinsertf64x4 $1, %ymm18, %zmm19, %zmm20                 #330.33
        vinsertf64x4 $1, %ymm0, %zmm17, %zmm19                  #331.33
        vinsertf64x4 $1, %ymm2, %zmm1, %zmm18                   #332.33
        vinsertf64x4 $1, %ymm4, %zmm3, %zmm17                   #333.33
        vinsertf64x4 $1, %ymm6, %zmm5, %zmm23                   #334.33
        movq      24(%r13), %rdi                                #327.25
        movq      8(%r13), %rsi                                 #326.19
        vmovaps   %zmm14, %zmm13                                #338.30
        vmovaps   %zmm13, %zmm12                                #339.30
        movslq    (%rdi,%rax,4), %r10                           #327.25
        lea       (%rsi,%rcx,4), %r15                           #326.19
        vmovaps   %zmm12, %zmm22                                #340.30
        movq      176(%rbx), %r12                               #325.27
        testq     %r10, %r10                                    #342.28
        jle       ..B2.32       # Prob 10%                      #342.28
                                # LOE rax rbx r8 r9 r10 r11 r12 r13 r14 r15 edx zmm8 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 k1 k2
..B2.29:                        # Preds ..B2.28
                                # Execution count [4.50e+00]
        movq      %r13, 8(%rsp)                                 #[spill]
        movq      %r14, (%rsp)                                  #[spill]
                                # LOE rax rbx r8 r9 r10 r11 r12 r15 edx zmm8 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 k1 k2
..B2.30:                        # Preds ..B2.30 ..B2.29
                                # Execution count [2.50e+01]
        movl      (%r15,%r9,4), %edi                            #343.22
        incq      %r9                                           #342.39
        lea       (%rdi,%rdi,2), %r13d                          #344.31
        shll      $3, %r13d                                     #344.31
        lea       (%rdi,%rdi), %r14d                            #365.56
        movslq    %r13d, %r13                                   #345.31
        cmpl      %edx, %r14d                                   #365.66
        lea       1(%rdi,%rdi), %ecx                            #366.61
        movl      $0, %edi                                      #365.66
        sete      %dil                                          #365.66
        cmpl      %edx, %ecx                                    #366.66
        movl      $0, %ecx                                      #366.66
        vbroadcastf64x4 128(%r11,%r13,8), %zmm31                #350.36
        sete      %cl                                           #366.66
        vbroadcastf64x4 64(%r11,%r13,8), %zmm30                 #349.36
        vbroadcastf64x4 (%r11,%r13,8), %zmm29                   #348.36
        vsubpd    %zmm31, %zmm17, %zmm10                        #353.35
        vsubpd    %zmm31, %zmm23, %zmm5                         #356.35
        vsubpd    %zmm30, %zmm19, %zmm9                         #352.35
        vsubpd    %zmm30, %zmm18, %zmm6                         #355.35
        vsubpd    %zmm29, %zmm21, %zmm11                        #351.35
        vsubpd    %zmm29, %zmm20, %zmm7                         #354.35
        vmulpd    %zmm10, %zmm10, %zmm0                         #383.80
        vmulpd    %zmm5, %zmm5, %zmm1                           #384.80
        vfmadd231pd %zmm9, %zmm9, %zmm0                         #383.57
        vfmadd231pd %zmm6, %zmm6, %zmm1                         #384.57
        vfmadd231pd %zmm11, %zmm11, %zmm0                       #383.34
        vfmadd231pd %zmm7, %zmm7, %zmm1                         #384.34
        vrcp14pd  %zmm0, %zmm4                                  #389.35
        vrcp14pd  %zmm1, %zmm3                                  #390.35
        vcmppd    $17, %zmm27, %zmm1, %k0                       #387.67
        vcmppd    $17, %zmm27, %zmm0, %k4                       #386.67
        vmulpd    %zmm26, %zmm4, %zmm2                          #392.67
        vmulpd    %zmm26, %zmm3, %zmm29                         #393.67
        vmulpd    %zmm2, %zmm4, %zmm30                          #392.51
        vmulpd    %zmm29, %zmm3, %zmm1                          #393.51
        vmulpd    %zmm30, %zmm4, %zmm2                          #392.35
        vmulpd    %zmm1, %zmm3, %zmm0                           #393.35
        vfmsub213pd %zmm28, %zmm4, %zmm30                       #395.79
        vfmsub213pd %zmm28, %zmm3, %zmm1                        #396.79
        vmulpd    %zmm25, %zmm4, %zmm4                          #395.105
        vmulpd    %zmm25, %zmm3, %zmm3                          #396.105
        vmulpd    %zmm4, %zmm30, %zmm31                         #395.70
        vmulpd    %zmm3, %zmm1, %zmm1                           #396.70
        vmulpd    %zmm31, %zmm2, %zmm2                          #395.54
        vmulpd    %zmm1, %zmm0, %zmm0                           #396.54
        vmulpd    %zmm2, %zmm24, %zmm4                          #395.36
        vmulpd    %zmm0, %zmm24, %zmm2                          #396.36
        movl      %ecx, %r13d                                   #380.39
        lea       (%rdi,%rdi), %esi                             #380.39
        shll      $5, %r13d                                     #380.39
        negl      %esi                                          #380.39
        subl      %r13d, %esi                                   #380.39
        movl      %edi, %r13d                                   #380.39
        movl      %ecx, %r14d                                   #380.39
        negl      %r13d                                         #380.39
        shll      $4, %r14d                                     #380.39
        shll      $4, %esi                                      #380.39
        subl      %r14d, %r13d                                  #380.39
        addl      $4080, %esi                                   #380.39
        addl      $255, %r13d                                   #380.39
        orl       %r13d, %esi                                   #380.39
        movl      %ecx, %r14d                                   #381.39
        kmovb     %esi, %k3                                     #380.39
        kmovb     %k3, %esi                                     #380.39
        kmovb     %esi, %k5                                     #386.41
        kmovw     %k4, %esi                                     #386.67
        kmovb     %esi, %k6                                     #386.41
        lea       (,%rdi,8), %esi                               #381.39
        shll      $2, %edi                                      #381.39
        negl      %esi                                          #381.39
        shll      $7, %r14d                                     #381.39
        negl      %edi                                          #381.39
        shll      $6, %ecx                                      #381.39
        subl      %r14d, %esi                                   #381.39
        shll      $4, %esi                                      #381.39
        subl      %ecx, %edi                                    #381.39
        addl      $4080, %esi                                   #381.39
        addl      $255, %edi                                    #381.39
        orl       %edi, %esi                                    #381.39
        kmovb     %esi, %k4                                     #381.39
        kmovw     %k0, %edi                                     #387.67
        kmovb     %k4, %ecx                                     #381.39
        kandb     %k6, %k5, %k7                                 #386.41
        kmovb     %ecx, %k5                                     #387.41
        kmovb     %edi, %k0                                     #387.41
        kandb     %k0, %k5, %k6                                 #387.41
        kmovb     %k7, %r13d                                    #386.41
        kmovb     %k6, %ecx                                     #387.41
        kmovw     %r13d, %k3                                    #398.20
        kmovw     %ecx, %k7                                     #401.20
        vfmadd231pd %zmm11, %zmm4, %zmm16{%k3}                  #398.20
        vfmadd231pd %zmm9, %zmm4, %zmm15{%k3}                   #399.20
        vfmadd231pd %zmm10, %zmm4, %zmm14{%k3}                  #400.20
        vfmadd231pd %zmm7, %zmm2, %zmm13{%k7}                   #401.20
        vfmadd231pd %zmm6, %zmm2, %zmm12{%k7}                   #402.20
        vfmadd231pd %zmm5, %zmm2, %zmm22{%k7}                   #403.20
        cmpq      %r10, %r9                                     #342.28
        jl        ..B2.30       # Prob 82%                      #342.28
                                # LOE rax rbx r8 r9 r10 r11 r12 r15 edx zmm8 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 k1 k2
..B2.31:                        # Preds ..B2.30
                                # Execution count [4.50e+00]
        movq      8(%rsp), %r13                                 #[spill]
        movq      (%rsp), %r14                                  #[spill]
                                # LOE rax rbx r8 r10 r12 r13 r14 edx zmm8 zmm12 zmm13 zmm14 zmm15 zmm16 zmm22 zmm24 zmm25 zmm26 zmm27 zmm28 k1 k2
..B2.32:                        # Preds ..B2.31 ..B2.28
                                # Execution count [5.00e+00]
        vpermpd   $78, %zmm16, %zmm17                           #406.9
        vxorpd    %xmm7, %xmm7, %xmm7                           #412.9
        vpermpd   $78, %zmm15, %zmm23                           #407.9
        vpermpd   $78, %zmm14, %zmm2                            #408.9
        vaddpd    %zmm16, %zmm17, %zmm18                        #406.9
        vpermpd   $78, %zmm13, %zmm16                           #406.9
        vaddpd    %zmm15, %zmm23, %zmm30                        #407.9
        vpermpd   $78, %zmm12, %zmm29                           #407.9
        vaddpd    %zmm14, %zmm2, %zmm4                          #408.9
        vpermpd   $78, %zmm22, %zmm3                            #408.9
        vaddpd    %zmm16, %zmm13, %zmm18{%k2}                   #406.9
        vaddpd    %zmm29, %zmm12, %zmm30{%k2}                   #407.9
        vaddpd    %zmm3, %zmm22, %zmm4{%k2}                     #408.9
        vpermpd   $177, %zmm18, %zmm19                          #406.9
        vpermpd   $177, %zmm30, %zmm31                          #407.9
        vpermpd   $177, %zmm4, %zmm22                           #408.9
        vaddpd    %zmm19, %zmm18, %zmm20                        #406.9
        vaddpd    %zmm31, %zmm30, %zmm0                         #407.9
        vaddpd    %zmm22, %zmm4, %zmm5                          #408.9
        vshuff64x2 $238, %zmm20, %zmm20, %zmm20{%k1}            #406.9
        vshuff64x2 $238, %zmm0, %zmm0, %zmm0{%k1}               #407.9
        vshuff64x2 $238, %zmm5, %zmm5, %zmm5{%k1}               #408.9
        incl      %edx                                          #318.49
        incq      %rax                                          #318.49
        vaddpd    (%r12,%r8,8), %ymm20, %ymm21                  #406.9
        vaddpd    64(%r12,%r8,8), %ymm0, %ymm1                  #407.9
        vaddpd    128(%r12,%r8,8), %ymm5, %ymm6                 #408.9
        vmovupd   %ymm21, (%r12,%r8,8)                          #406.9
        vmovupd   %ymm1, 64(%r12,%r8,8)                         #407.9
        vmovupd   %ymm6, 128(%r12,%r8,8)                        #408.9
        addq      %r10, 8(%r14)                                 #411.9
        vcvtsi2sd %r10d, %xmm7, %xmm7                           #412.9
        vcvttsd2si %xmm7, %rcx                                  #412.9
        incq      (%r14)                                        #410.9
        addq      %rcx, 16(%r14)                                #412.9
        cmpl      20(%rbx), %edx                                #318.26
        jl        ..B2.28       # Prob 82%                      #318.26
                                # LOE rax rbx r13 r14 edx zmm8 zmm24 zmm25 zmm26 zmm27 zmm28 k1 k2
..B2.34:                        # Preds ..B2.32 ..B2.26
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.1, %edi                         #416.5
        vzeroupper                                              #416.5
..___tag_value_computeForceLJ_2xnn_full.107:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #416.5
..___tag_value_computeForceLJ_2xnn_full.108:
                                # LOE r12
..B2.35:                        # Preds ..B2.34
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #419.16
..___tag_value_computeForceLJ_2xnn_full.109:
#       getTimeStamp()
        call      getTimeStamp                                  #419.16
..___tag_value_computeForceLJ_2xnn_full.110:
                                # LOE r12 xmm0
..B2.42:                        # Preds ..B2.35
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, (%rsp)                                 #419.16[spill]
                                # LOE r12
..B2.36:                        # Preds ..B2.42
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.4, %edi                         #420.5
        xorl      %eax, %eax                                    #420.5
..___tag_value_computeForceLJ_2xnn_full.112:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #420.5
..___tag_value_computeForceLJ_2xnn_full.113:
                                # LOE r12
..B2.37:                        # Preds ..B2.36
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
..B2.38:                        # Preds ..B2.5
                                # Execution count [4.50e-01]: Infreq
        xorl      %r10d, %r10d                                  #304.9
        jmp       ..B2.18       # Prob 100%                     #304.9
        .align    16,0x90
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
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
..___tag_value_computeForceLJ_2xnn.131:
..L132:
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
        movq      %rdx, %r13                                    #424.92
        movq      %rcx, %r14                                    #424.92
        movq      %rsi, %rbx                                    #424.92
        movq      %rdi, %r15                                    #424.92
        cmpl      $0, 32(%r13)                                  #425.8
        je        ..B3.4        # Prob 50%                      #425.8
                                # LOE rbx r12 r13 r14 r15
..B3.2:                         # Preds ..B3.1
                                # Execution count [5.00e-01]
        movq      %r15, %rdi                                    #426.16
        movq      %rbx, %rsi                                    #426.16
        movq      %r13, %rdx                                    #426.16
        movq      %r14, %rcx                                    #426.16
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
        movl      $.L_2__STRING.3, %edi                         #429.12
        xorl      %eax, %eax                                    #429.12
..___tag_value_computeForceLJ_2xnn.152:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #429.12
..___tag_value_computeForceLJ_2xnn.153:
                                # LOE rbx r12 r13 r14 r15
..B3.5:                         # Preds ..B3.4
                                # Execution count [5.00e-01]
        vmovsd    144(%r15), %xmm0                              #429.12
        xorl      %r8d, %r8d                                    #429.12
        vmulsd    %xmm0, %xmm0, %xmm1                           #429.12
        xorl      %r9d, %r9d                                    #429.12
        vbroadcastsd 56(%r15), %zmm3                            #429.12
        vbroadcastsd 40(%r15), %zmm4                            #429.12
        vbroadcastsd %xmm1, %zmm2                               #429.12
        vmovups   %zmm3, (%rsp)                                 #429.12[spill]
        vmovups   %zmm4, 64(%rsp)                               #429.12[spill]
        vmovups   %zmm2, 128(%rsp)                              #429.12[spill]
        movl      20(%rbx), %edi                                #429.12
        testl     %edi, %edi                                    #429.12
        jle       ..B3.27       # Prob 9%                       #429.12
                                # LOE rbx r9 r12 r13 r14 edi r8d
..B3.6:                         # Preds ..B3.5
                                # Execution count [4.50e-01]
        movq      176(%rbx), %r10                               #429.12
        movq      192(%rbx), %rax                               #429.12
        vxorpd    %ymm2, %ymm2, %ymm2                           #429.12
        vmovdqu   .L_2il0floatpacket.0(%rip), %xmm1             #429.12
        vmovdqu   .L_2il0floatpacket.1(%rip), %xmm0             #429.12
        movq      %r12, 192(%rsp)                               #429.12[spill]
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x22
                                # LOE rax rbx r9 r10 r13 r14 edi r8d xmm0 xmm1 ymm2
..B3.7:                         # Preds ..B3.25 ..B3.6
                                # Execution count [2.50e+00]
        movl      %r8d, %r11d                                   #429.12
        movl      %r8d, %r12d                                   #429.12
        sarl      $1, %r11d                                     #429.12
        andl      $1, %r12d                                     #429.12
        shll      $2, %r12d                                     #429.12
        movl      (%r9,%rax), %edx                              #429.12
        lea       (%r11,%r11,2), %r15d                          #429.12
        lea       (%r12,%r15,8), %r11d                          #429.12
        movslq    %r11d, %r11                                   #429.12
        lea       (%r10,%r11,8), %rcx                           #429.12
        testl     %edx, %edx                                    #429.12
        jle       ..B3.25       # Prob 50%                      #429.12
                                # LOE rax rcx rbx r9 r10 r13 r14 edx edi r8d xmm0 xmm1 ymm2
..B3.8:                         # Preds ..B3.7
                                # Execution count [2.25e+00]
        cmpl      $16, %edx                                     #429.12
        jl        ..B3.41       # Prob 10%                      #429.12
                                # LOE rax rcx rbx r9 r10 r13 r14 edx edi r8d xmm0 xmm1 ymm2
..B3.9:                         # Preds ..B3.8
                                # Execution count [2.25e+00]
        lea       128(%rcx), %r11                               #429.12
        andq      $63, %r11                                     #429.12
        testl     $7, %r11d                                     #429.12
        je        ..B3.11       # Prob 50%                      #429.12
                                # LOE rax rcx rbx r9 r10 r13 r14 edx edi r8d r11d xmm0 xmm1 ymm2
..B3.10:                        # Preds ..B3.9
                                # Execution count [1.12e+00]
        xorl      %r11d, %r11d                                  #429.12
        jmp       ..B3.13       # Prob 100%                     #429.12
                                # LOE rax rcx rbx r9 r10 r13 r14 edx edi r8d r11d xmm0 xmm1 ymm2
..B3.11:                        # Preds ..B3.9
                                # Execution count [1.12e+00]
        testl     %r11d, %r11d                                  #429.12
        je        ..B3.13       # Prob 50%                      #429.12
                                # LOE rax rcx rbx r9 r10 r13 r14 edx edi r8d r11d xmm0 xmm1 ymm2
..B3.12:                        # Preds ..B3.11
                                # Execution count [1.25e+01]
        negl      %r11d                                         #429.12
        addl      $64, %r11d                                    #429.12
        shrl      $3, %r11d                                     #429.12
        cmpl      %r11d, %edx                                   #429.12
        cmovl     %edx, %r11d                                   #429.12
                                # LOE rax rcx rbx r9 r10 r13 r14 edx edi r8d r11d xmm0 xmm1 ymm2
..B3.13:                        # Preds ..B3.10 ..B3.12 ..B3.11
                                # Execution count [2.50e+00]
        movl      %edx, %r15d                                   #429.12
        subl      %r11d, %r15d                                  #429.12
        andl      $15, %r15d                                    #429.12
        negl      %r15d                                         #429.12
        addl      %edx, %r15d                                   #429.12
        cmpl      $1, %r11d                                     #429.12
        jb        ..B3.17       # Prob 50%                      #429.12
                                # LOE rax rcx rbx r9 r10 r13 r14 edx edi r8d r11d r15d xmm0 xmm1 ymm2
..B3.14:                        # Preds ..B3.13
                                # Execution count [2.25e+00]
        vpbroadcastd %r11d, %xmm3                               #429.12
        xorl      %esi, %esi                                    #429.12
        vmovdqa   %xmm0, %xmm4                                  #429.12
        movslq    %r11d, %r12                                   #429.12
                                # LOE rax rcx rbx rsi r9 r10 r12 r13 r14 edx edi r8d r11d r15d xmm0 xmm1 xmm3 xmm4 ymm2
..B3.15:                        # Preds ..B3.15 ..B3.14
                                # Execution count [1.25e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #429.12
        vpaddd    %xmm1, %xmm4, %xmm4                           #429.12
        vmovupd   %ymm2, (%rcx,%rsi,8){%k1}                     #429.12
        vmovupd   %ymm2, 64(%rcx,%rsi,8){%k1}                   #429.12
        vmovupd   %ymm2, 128(%rcx,%rsi,8){%k1}                  #429.12
        addq      $4, %rsi                                      #429.12
        cmpq      %r12, %rsi                                    #429.12
        jb        ..B3.15       # Prob 82%                      #429.12
                                # LOE rax rcx rbx rsi r9 r10 r12 r13 r14 edx edi r8d r11d r15d xmm0 xmm1 xmm3 xmm4 ymm2
..B3.16:                        # Preds ..B3.15
                                # Execution count [2.25e+00]
        cmpl      %r11d, %edx                                   #429.12
        je        ..B3.25       # Prob 10%                      #429.12
                                # LOE rax rcx rbx r9 r10 r13 r14 edx edi r8d r11d r15d xmm0 xmm1 ymm2
..B3.17:                        # Preds ..B3.13 ..B3.16
                                # Execution count [1.25e+01]
        lea       16(%r11), %r12d                               #429.12
        cmpl      %r12d, %r15d                                  #429.12
        jl        ..B3.21       # Prob 50%                      #429.12
                                # LOE rax rcx rbx r9 r10 r13 r14 edx edi r8d r11d r15d xmm0 xmm1 ymm2
..B3.18:                        # Preds ..B3.17
                                # Execution count [2.25e+00]
        movslq    %r11d, %r11                                   #429.12
        movslq    %r15d, %r12                                   #429.12
        .align    16,0x90
                                # LOE rax rcx rbx r9 r10 r11 r12 r13 r14 edx edi r8d r15d xmm0 xmm1 ymm2
..B3.19:                        # Preds ..B3.19 ..B3.18
                                # Execution count [1.25e+01]
        vmovupd   %ymm2, (%rcx,%r11,8)                          #429.12
        vmovupd   %ymm2, 32(%rcx,%r11,8)                        #429.12
        vmovupd   %ymm2, 64(%rcx,%r11,8)                        #429.12
        vmovupd   %ymm2, 128(%rcx,%r11,8)                       #429.12
        vmovupd   %ymm2, 192(%rcx,%r11,8)                       #429.12
        vmovupd   %ymm2, 96(%rcx,%r11,8)                        #429.12
        vmovupd   %ymm2, 160(%rcx,%r11,8)                       #429.12
        vmovupd   %ymm2, 224(%rcx,%r11,8)                       #429.12
        addq      $16, %r11                                     #429.12
        cmpq      %r12, %r11                                    #429.12
        jb        ..B3.19       # Prob 82%                      #429.12
                                # LOE rax rcx rbx r9 r10 r11 r12 r13 r14 edx edi r8d r15d xmm0 xmm1 ymm2
..B3.21:                        # Preds ..B3.19 ..B3.17 ..B3.41
                                # Execution count [2.50e+00]
        lea       1(%r15), %r11d                                #429.12
        cmpl      %edx, %r11d                                   #429.12
        ja        ..B3.25       # Prob 50%                      #429.12
                                # LOE rax rcx rbx r9 r10 r13 r14 edx edi r8d r15d xmm0 xmm1 ymm2
..B3.22:                        # Preds ..B3.21
                                # Execution count [2.25e+00]
        movslq    %r15d, %r12                                   #429.12
        negl      %r15d                                         #429.12
        addl      %edx, %r15d                                   #429.12
        xorl      %r11d, %r11d                                  #429.12
        movslq    %edx, %rdx                                    #429.12
        vmovdqa   %xmm0, %xmm4                                  #429.12
        vpbroadcastd %r15d, %xmm3                               #429.12
        subq      %r12, %rdx                                    #429.12
        lea       (%rcx,%r12,8), %rcx                           #429.12
                                # LOE rax rdx rcx rbx r9 r10 r11 r13 r14 edi r8d xmm0 xmm1 xmm3 xmm4 ymm2
..B3.23:                        # Preds ..B3.23 ..B3.22
                                # Execution count [1.25e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #429.12
        vpaddd    %xmm1, %xmm4, %xmm4                           #429.12
        vmovupd   %ymm2, (%rcx,%r11,8){%k1}                     #429.12
        vmovupd   %ymm2, 64(%rcx,%r11,8){%k1}                   #429.12
        vmovupd   %ymm2, 128(%rcx,%r11,8){%k1}                  #429.12
        addq      $4, %r11                                      #429.12
        cmpq      %rdx, %r11                                    #429.12
        jb        ..B3.23       # Prob 82%                      #429.12
                                # LOE rax rdx rcx rbx r9 r10 r11 r13 r14 edi r8d xmm0 xmm1 xmm3 xmm4 ymm2
..B3.25:                        # Preds ..B3.23 ..B3.7 ..B3.16 ..B3.21
                                # Execution count [2.50e+00]
        incl      %r8d                                          #429.12
        addq      $56, %r9                                      #429.12
        cmpl      %edi, %r8d                                    #429.12
        jb        ..B3.7        # Prob 82%                      #429.12
                                # LOE rax rbx r9 r10 r13 r14 edi r8d xmm0 xmm1 ymm2
..B3.26:                        # Preds ..B3.25
                                # Execution count [4.50e-01]
        movq      192(%rsp), %r12                               #[spill]
	.cfi_restore 12
                                # LOE rbx r12 r13 r14
..B3.27:                        # Preds ..B3.5 ..B3.26
                                # Execution count [5.00e-01]
        xorl      %eax, %eax                                    #429.12
        vzeroupper                                              #429.12
..___tag_value_computeForceLJ_2xnn.160:
#       getTimeStamp()
        call      getTimeStamp                                  #429.12
..___tag_value_computeForceLJ_2xnn.161:
                                # LOE rbx r12 r13 r14 xmm0
..B3.45:                        # Preds ..B3.27
                                # Execution count [5.00e-01]
        vmovsd    %xmm0, 200(%rsp)                              #429.12[spill]
                                # LOE rbx r12 r13 r14
..B3.28:                        # Preds ..B3.45
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.1, %edi                         #429.12
..___tag_value_computeForceLJ_2xnn.163:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #429.12
..___tag_value_computeForceLJ_2xnn.164:
                                # LOE rbx r12 r13 r14
..B3.29:                        # Preds ..B3.28
                                # Execution count [5.00e-01]
        xorl      %edi, %edi                                    #429.12
        xorl      %eax, %eax                                    #429.12
        cmpl      $0, 20(%rbx)                                  #429.12
        jle       ..B3.37       # Prob 10%                      #429.12
                                # LOE rax rbx r12 r13 r14 edi
..B3.30:                        # Preds ..B3.29
                                # Execution count [4.50e-01]
        movl      $65484, %edx                                  #429.12
        kmovw     %edx, %k2                                     #429.12
        movl      $65450, %edx                                  #429.12
        kmovw     %edx, %k1                                     #429.12
        vmovups   64(%rsp), %zmm25                              #429.12[spill]
        vmovups   (%rsp), %zmm26                                #429.12[spill]
        vmovups   128(%rsp), %zmm27                             #429.12[spill]
        vbroadcastsd .L_2il0floatpacket.2(%rip), %zmm28         #429.12
        vbroadcastsd .L_2il0floatpacket.3(%rip), %zmm24         #429.12
        movq      %r12, 192(%rsp)                               #429.12[spill]
        vpxord    %zmm8, %zmm8, %zmm8                           #429.12
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x22
                                # LOE rax rbx r13 r14 edi zmm8 zmm24 zmm25 zmm26 zmm27 zmm28 k1 k2
..B3.31:                        # Preds ..B3.35 ..B3.30
                                # Execution count [2.50e+00]
        movl      %edi, %r9d                                    #429.12
        movl      %edi, %r15d                                   #429.12
        sarl      $1, %r9d                                      #429.12
        andl      $1, %r15d                                     #429.12
        shll      $2, %r15d                                     #429.12
        movl      16(%r13), %r10d                               #429.12
        imull     %edi, %r10d                                   #429.12
        movq      160(%rbx), %r12                               #429.12
        lea       (%r9,%r9,2), %r8d                             #429.12
        vmovaps   %zmm8, %zmm16                                 #429.12
        lea       (%r15,%r8,8), %r9d                            #429.12
        movslq    %r9d, %r9                                     #429.12
        vmovaps   %zmm16, %zmm15                                #429.12
        movslq    %r10d, %r10                                   #429.12
        vmovaps   %zmm15, %zmm14                                #429.12
        vbroadcastsd 8(%r12,%r9,8), %ymm20                      #429.12
        vbroadcastsd 24(%r12,%r9,8), %ymm18                     #429.12
        vbroadcastsd 72(%r12,%r9,8), %ymm0                      #429.12
        vbroadcastsd 88(%r12,%r9,8), %ymm2                      #429.12
        vbroadcastsd 136(%r12,%r9,8), %ymm4                     #429.12
        vbroadcastsd 152(%r12,%r9,8), %ymm6                     #429.12
        vbroadcastsd 128(%r12,%r9,8), %zmm3                     #429.12
        vbroadcastsd 64(%r12,%r9,8), %zmm17                     #429.12
        vbroadcastsd (%r12,%r9,8), %zmm21                       #429.12
        vbroadcastsd 16(%r12,%r9,8), %zmm19                     #429.12
        vbroadcastsd 80(%r12,%r9,8), %zmm1                      #429.12
        vbroadcastsd 144(%r12,%r9,8), %zmm5                     #429.12
        vinsertf64x4 $1, %ymm20, %zmm21, %zmm21                 #429.12
        vinsertf64x4 $1, %ymm18, %zmm19, %zmm20                 #429.12
        vinsertf64x4 $1, %ymm0, %zmm17, %zmm19                  #429.12
        vinsertf64x4 $1, %ymm2, %zmm1, %zmm18                   #429.12
        vinsertf64x4 $1, %ymm4, %zmm3, %zmm17                   #429.12
        vinsertf64x4 $1, %ymm6, %zmm5, %zmm23                   #429.12
        movq      8(%r13), %r11                                 #429.12
        movq      24(%r13), %r8                                 #429.12
        vmovaps   %zmm14, %zmm13                                #429.12
        vmovaps   %zmm13, %zmm12                                #429.12
        lea       (%r11,%r10,4), %rsi                           #429.12
        movslq    (%r8,%rax,4), %r11                            #429.12
        xorl      %r10d, %r10d                                  #429.12
        vmovaps   %zmm12, %zmm22                                #429.12
        movq      176(%rbx), %r15                               #429.12
        testq     %r11, %r11                                    #429.12
        jle       ..B3.35       # Prob 10%                      #429.12
                                # LOE rax rbx rsi r9 r10 r11 r12 r13 r14 r15 edi zmm8 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 k1 k2
..B3.32:                        # Preds ..B3.31
                                # Execution count [2.25e+00]
        movq      %r13, 8(%rsp)                                 #[spill]
        movq      %r14, (%rsp)                                  #[spill]
                                # LOE rax rbx rsi r9 r10 r11 r12 r15 edi zmm8 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 k1 k2
..B3.33:                        # Preds ..B3.33 ..B3.32
                                # Execution count [1.25e+01]
        movl      (%rsi,%r10,4), %r8d                           #429.12
        incq      %r10                                          #429.12
        lea       (%r8,%r8,2), %r13d                            #429.12
        shll      $3, %r13d                                     #429.12
        lea       (%r8,%r8), %r14d                              #429.12
        movslq    %r13d, %r13                                   #429.12
        cmpl      %edi, %r14d                                   #429.12
        lea       1(%r8,%r8), %edx                              #429.12
        movl      $0, %r8d                                      #429.12
        sete      %r8b                                          #429.12
        cmpl      %edi, %edx                                    #429.12
        movl      $0, %edx                                      #429.12
        vbroadcastf64x4 128(%r12,%r13,8), %zmm31                #429.12
        sete      %dl                                           #429.12
        vbroadcastf64x4 64(%r12,%r13,8), %zmm30                 #429.12
        vbroadcastf64x4 (%r12,%r13,8), %zmm29                   #429.12
        vsubpd    %zmm31, %zmm17, %zmm10                        #429.12
        vsubpd    %zmm31, %zmm23, %zmm5                         #429.12
        vsubpd    %zmm30, %zmm19, %zmm9                         #429.12
        vsubpd    %zmm30, %zmm18, %zmm6                         #429.12
        vsubpd    %zmm29, %zmm21, %zmm11                        #429.12
        vsubpd    %zmm29, %zmm20, %zmm7                         #429.12
        vmulpd    %zmm10, %zmm10, %zmm0                         #429.12
        vmulpd    %zmm5, %zmm5, %zmm1                           #429.12
        vfmadd231pd %zmm9, %zmm9, %zmm0                         #429.12
        vfmadd231pd %zmm6, %zmm6, %zmm1                         #429.12
        vfmadd231pd %zmm11, %zmm11, %zmm0                       #429.12
        vfmadd231pd %zmm7, %zmm7, %zmm1                         #429.12
        vrcp14pd  %zmm0, %zmm4                                  #429.12
        vrcp14pd  %zmm1, %zmm3                                  #429.12
        vcmppd    $17, %zmm27, %zmm1, %k0                       #429.12
        vcmppd    $17, %zmm27, %zmm0, %k4                       #429.12
        vmulpd    %zmm4, %zmm26, %zmm2                          #429.12
        vmulpd    %zmm3, %zmm26, %zmm29                         #429.12
        vmulpd    %zmm2, %zmm4, %zmm30                          #429.12
        vmulpd    %zmm29, %zmm3, %zmm1                          #429.12
        vmulpd    %zmm30, %zmm4, %zmm2                          #429.12
        vmulpd    %zmm1, %zmm3, %zmm0                           #429.12
        vfmsub213pd %zmm28, %zmm4, %zmm30                       #429.12
        vfmsub213pd %zmm28, %zmm3, %zmm1                        #429.12
        vmulpd    %zmm4, %zmm25, %zmm4                          #429.12
        vmulpd    %zmm3, %zmm25, %zmm3                          #429.12
        vmulpd    %zmm4, %zmm30, %zmm31                         #429.12
        vmulpd    %zmm3, %zmm1, %zmm1                           #429.12
        vmulpd    %zmm31, %zmm2, %zmm2                          #429.12
        vmulpd    %zmm1, %zmm0, %zmm0                           #429.12
        vmulpd    %zmm2, %zmm24, %zmm4                          #429.12
        vmulpd    %zmm0, %zmm24, %zmm2                          #429.12
        movl      %edx, %r13d                                   #429.12
        lea       (%r8,%r8), %ecx                               #429.12
        shll      $5, %r13d                                     #429.12
        negl      %ecx                                          #429.12
        subl      %r13d, %ecx                                   #429.12
        movl      %r8d, %r13d                                   #429.12
        movl      %edx, %r14d                                   #429.12
        negl      %r13d                                         #429.12
        shll      $4, %r14d                                     #429.12
        shll      $4, %ecx                                      #429.12
        subl      %r14d, %r13d                                  #429.12
        addl      $4080, %ecx                                   #429.12
        addl      $255, %r13d                                   #429.12
        orl       %r13d, %ecx                                   #429.12
        movl      %edx, %r14d                                   #429.12
        kmovb     %ecx, %k3                                     #429.12
        kmovb     %k3, %ecx                                     #429.12
        kmovb     %ecx, %k5                                     #429.12
        kmovw     %k4, %ecx                                     #429.12
        kmovb     %ecx, %k6                                     #429.12
        lea       (,%r8,8), %ecx                                #429.12
        shll      $2, %r8d                                      #429.12
        negl      %ecx                                          #429.12
        shll      $7, %r14d                                     #429.12
        negl      %r8d                                          #429.12
        shll      $6, %edx                                      #429.12
        subl      %r14d, %ecx                                   #429.12
        shll      $4, %ecx                                      #429.12
        subl      %edx, %r8d                                    #429.12
        addl      $4080, %ecx                                   #429.12
        addl      $255, %r8d                                    #429.12
        orl       %r8d, %ecx                                    #429.12
        kmovb     %ecx, %k4                                     #429.12
        kmovw     %k0, %r8d                                     #429.12
        kmovb     %k4, %edx                                     #429.12
        kandb     %k6, %k5, %k7                                 #429.12
        kmovb     %edx, %k5                                     #429.12
        kmovb     %r8d, %k0                                     #429.12
        kandb     %k0, %k5, %k6                                 #429.12
        kmovb     %k7, %r13d                                    #429.12
        kmovb     %k6, %edx                                     #429.12
        kmovw     %r13d, %k3                                    #429.12
        kmovw     %edx, %k7                                     #429.12
        vfmadd231pd %zmm11, %zmm4, %zmm16{%k3}                  #429.12
        vfmadd231pd %zmm9, %zmm4, %zmm15{%k3}                   #429.12
        vfmadd231pd %zmm10, %zmm4, %zmm14{%k3}                  #429.12
        vfmadd231pd %zmm7, %zmm2, %zmm13{%k7}                   #429.12
        vfmadd231pd %zmm6, %zmm2, %zmm12{%k7}                   #429.12
        vfmadd231pd %zmm5, %zmm2, %zmm22{%k7}                   #429.12
        cmpq      %r11, %r10                                    #429.12
        jl        ..B3.33       # Prob 82%                      #429.12
                                # LOE rax rbx rsi r9 r10 r11 r12 r15 edi zmm8 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 k1 k2
..B3.34:                        # Preds ..B3.33
                                # Execution count [2.25e+00]
        movq      8(%rsp), %r13                                 #[spill]
        movq      (%rsp), %r14                                  #[spill]
                                # LOE rax rbx r9 r11 r13 r14 r15 edi zmm8 zmm12 zmm13 zmm14 zmm15 zmm16 zmm22 zmm24 zmm25 zmm26 zmm27 zmm28 k1 k2
..B3.35:                        # Preds ..B3.34 ..B3.31
                                # Execution count [2.50e+00]
        vpermpd   $78, %zmm16, %zmm17                           #429.12
        vxorpd    %xmm7, %xmm7, %xmm7                           #429.12
        vpermpd   $78, %zmm15, %zmm23                           #429.12
        vpermpd   $78, %zmm14, %zmm2                            #429.12
        vaddpd    %zmm16, %zmm17, %zmm18                        #429.12
        vpermpd   $78, %zmm13, %zmm16                           #429.12
        vaddpd    %zmm15, %zmm23, %zmm30                        #429.12
        vpermpd   $78, %zmm12, %zmm29                           #429.12
        vaddpd    %zmm14, %zmm2, %zmm4                          #429.12
        vpermpd   $78, %zmm22, %zmm3                            #429.12
        vaddpd    %zmm16, %zmm13, %zmm18{%k2}                   #429.12
        vaddpd    %zmm29, %zmm12, %zmm30{%k2}                   #429.12
        vaddpd    %zmm3, %zmm22, %zmm4{%k2}                     #429.12
        vpermpd   $177, %zmm18, %zmm19                          #429.12
        vpermpd   $177, %zmm30, %zmm31                          #429.12
        vpermpd   $177, %zmm4, %zmm22                           #429.12
        vaddpd    %zmm19, %zmm18, %zmm20                        #429.12
        vaddpd    %zmm31, %zmm30, %zmm0                         #429.12
        vaddpd    %zmm22, %zmm4, %zmm5                          #429.12
        vshuff64x2 $238, %zmm20, %zmm20, %zmm20{%k1}            #429.12
        vshuff64x2 $238, %zmm0, %zmm0, %zmm0{%k1}               #429.12
        vshuff64x2 $238, %zmm5, %zmm5, %zmm5{%k1}               #429.12
        incl      %edi                                          #429.12
        incq      %rax                                          #429.12
        vaddpd    (%r15,%r9,8), %ymm20, %ymm21                  #429.12
        vaddpd    64(%r15,%r9,8), %ymm0, %ymm1                  #429.12
        vaddpd    128(%r15,%r9,8), %ymm5, %ymm6                 #429.12
        vmovupd   %ymm21, (%r15,%r9,8)                          #429.12
        vmovupd   %ymm1, 64(%r15,%r9,8)                         #429.12
        vmovupd   %ymm6, 128(%r15,%r9,8)                        #429.12
        addq      %r11, 8(%r14)                                 #429.12
        vcvtsi2sd %r11d, %xmm7, %xmm7                           #429.12
        vcvttsd2si %xmm7, %r8                                   #429.12
        incq      (%r14)                                        #429.12
        addq      %r8, 16(%r14)                                 #429.12
        cmpl      20(%rbx), %edi                                #429.12
        jl        ..B3.31       # Prob 82%                      #429.12
                                # LOE rax rbx r13 r14 edi zmm8 zmm24 zmm25 zmm26 zmm27 zmm28 k1 k2
..B3.36:                        # Preds ..B3.35
                                # Execution count [4.50e-01]
        movq      192(%rsp), %r12                               #[spill]
	.cfi_restore 12
                                # LOE r12
..B3.37:                        # Preds ..B3.36 ..B3.29
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.1, %edi                         #429.12
        vzeroupper                                              #429.12
..___tag_value_computeForceLJ_2xnn.175:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #429.12
..___tag_value_computeForceLJ_2xnn.176:
                                # LOE r12
..B3.38:                        # Preds ..B3.37
                                # Execution count [5.00e-01]
        xorl      %eax, %eax                                    #429.12
..___tag_value_computeForceLJ_2xnn.177:
#       getTimeStamp()
        call      getTimeStamp                                  #429.12
..___tag_value_computeForceLJ_2xnn.178:
                                # LOE r12 xmm0
..B3.46:                        # Preds ..B3.38
                                # Execution count [5.00e-01]
        vmovsd    %xmm0, (%rsp)                                 #429.12[spill]
                                # LOE r12
..B3.39:                        # Preds ..B3.46
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.4, %edi                         #429.12
        xorl      %eax, %eax                                    #429.12
..___tag_value_computeForceLJ_2xnn.180:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #429.12
..___tag_value_computeForceLJ_2xnn.181:
                                # LOE r12
..B3.40:                        # Preds ..B3.39
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
..B3.41:                        # Preds ..B3.8
                                # Execution count [2.25e-01]: Infreq
        xorl      %r15d, %r15d                                  #429.12
        jmp       ..B3.21       # Prob 100%                     #429.12
        .align    16,0x90
                                # LOE rax rcx rbx r9 r10 r13 r14 edx edi r8d r15d xmm0 xmm1 ymm2
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
..___tag_value_computeForceLJ_2xnn_half.198:
..L199:
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
        subq      $280, %rsp                                    #135.97
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
        movq      %rdi, %r15                                    #135.97
        movl      $.L_2__STRING.3, %edi                         #136.5
        xorl      %eax, %eax                                    #136.5
        movq      %rcx, %r13                                    #135.97
        movq      %rdx, %r14                                    #135.97
        movq      %rsi, %rbx                                    #135.97
..___tag_value_computeForceLJ_2xnn_half.208:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #136.5
..___tag_value_computeForceLJ_2xnn_half.209:
                                # LOE rbx r12 r13 r14 r15
..B4.2:                         # Preds ..B4.1
                                # Execution count [1.00e+00]
        vmovsd    144(%r15), %xmm0                              #139.27
        xorl      %ecx, %ecx                                    #149.5
        vmulsd    %xmm0, %xmm0, %xmm1                           #142.36
        xorl      %esi, %esi                                    #151.27
        vbroadcastsd 56(%r15), %zmm3                            #143.32
        vbroadcastsd 40(%r15), %zmm4                            #144.29
        vbroadcastsd %xmm1, %zmm2                               #142.36
        vbroadcastsd .L_2il0floatpacket.2(%rip), %zmm5          #146.29
        vmovups   %zmm3, 128(%rsp)                              #143.32[spill]
        vmovups   %zmm2, 64(%rsp)                               #142.36[spill]
        vmovups   %zmm4, (%rsp)                                 #144.29[spill]
        vmovups   %zmm5, 192(%rsp)                              #146.29[spill]
        movl      20(%rbx), %edx                                #149.26
        testl     %edx, %edx                                    #149.26
        jle       ..B4.24       # Prob 9%                       #149.26
                                # LOE rbx rsi r12 r13 r14 edx ecx
..B4.3:                         # Preds ..B4.2
                                # Execution count [9.00e-01]
        movq      176(%rbx), %rdi                               #151.27
        movq      192(%rbx), %rax                               #152.32
        vxorpd    %ymm2, %ymm2, %ymm2                           #153.39
        vmovdqu   .L_2il0floatpacket.0(%rip), %xmm1             #152.9
        vmovdqu   .L_2il0floatpacket.1(%rip), %xmm0             #152.9
                                # LOE rax rbx rsi rdi r13 r14 edx ecx xmm0 xmm1 ymm2
..B4.4:                         # Preds ..B4.22 ..B4.3
                                # Execution count [5.00e+00]
        movl      %ecx, %r8d                                    #150.27
        movl      %ecx, %r9d                                    #150.27
        sarl      $1, %r8d                                      #150.27
        andl      $1, %r9d                                      #150.27
        shll      $2, %r9d                                      #150.27
        lea       (%r8,%r8,2), %r10d                            #150.27
        lea       (%r9,%r10,8), %r11d                           #150.27
        movslq    %r11d, %r11                                   #151.27
        lea       (%rdi,%r11,8), %r12                           #151.27
        movl      (%rsi,%rax), %r11d                            #152.32
        testl     %r11d, %r11d                                  #152.32
        jle       ..B4.22       # Prob 50%                      #152.32
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r11d xmm0 xmm1 ymm2
..B4.5:                         # Preds ..B4.4
                                # Execution count [4.50e+00]
        cmpl      $16, %r11d                                    #152.9
        jl        ..B4.38       # Prob 10%                      #152.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r11d xmm0 xmm1 ymm2
..B4.6:                         # Preds ..B4.5
                                # Execution count [4.50e+00]
        lea       128(%r12), %r8                                #155.13
        andq      $63, %r8                                      #152.9
        testl     $7, %r8d                                      #152.9
        je        ..B4.8        # Prob 50%                      #152.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B4.7:                         # Preds ..B4.6
                                # Execution count [2.25e+00]
        xorl      %r8d, %r8d                                    #152.9
        jmp       ..B4.10       # Prob 100%                     #152.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B4.8:                         # Preds ..B4.6
                                # Execution count [2.25e+00]
        testl     %r8d, %r8d                                    #152.9
        je        ..B4.10       # Prob 50%                      #152.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B4.9:                         # Preds ..B4.8
                                # Execution count [2.50e+01]
        negl      %r8d                                          #152.9
        addl      $64, %r8d                                     #152.9
        shrl      $3, %r8d                                      #152.9
        cmpl      %r8d, %r11d                                   #152.9
        cmovl     %r11d, %r8d                                   #152.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B4.10:                        # Preds ..B4.7 ..B4.9 ..B4.8
                                # Execution count [5.00e+00]
        movl      %r11d, %r10d                                  #152.9
        subl      %r8d, %r10d                                   #152.9
        andl      $15, %r10d                                    #152.9
        negl      %r10d                                         #152.9
        addl      %r11d, %r10d                                  #152.9
        cmpl      $1, %r8d                                      #152.9
        jb        ..B4.14       # Prob 50%                      #152.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r10d r11d xmm0 xmm1 ymm2
..B4.11:                        # Preds ..B4.10
                                # Execution count [4.50e+00]
        vpbroadcastd %r8d, %xmm3                                #152.9
        xorl      %r15d, %r15d                                  #152.9
        vmovdqa   %xmm0, %xmm4                                  #152.9
        movslq    %r8d, %r9                                     #152.9
                                # LOE rax rbx rsi rdi r9 r12 r13 r14 r15 edx ecx r8d r10d r11d xmm0 xmm1 xmm3 xmm4 ymm2
..B4.12:                        # Preds ..B4.12 ..B4.11
                                # Execution count [2.50e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #152.9
        vpaddd    %xmm1, %xmm4, %xmm4                           #152.9
        vmovupd   %ymm2, (%r12,%r15,8){%k1}                     #153.13
        vmovupd   %ymm2, 64(%r12,%r15,8){%k1}                   #154.13
        vmovupd   %ymm2, 128(%r12,%r15,8){%k1}                  #155.13
        addq      $4, %r15                                      #152.9
        cmpq      %r9, %r15                                     #152.9
        jb        ..B4.12       # Prob 82%                      #152.9
                                # LOE rax rbx rsi rdi r9 r12 r13 r14 r15 edx ecx r8d r10d r11d xmm0 xmm1 xmm3 xmm4 ymm2
..B4.13:                        # Preds ..B4.12
                                # Execution count [4.50e+00]
        cmpl      %r8d, %r11d                                   #152.9
        je        ..B4.22       # Prob 10%                      #152.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r10d r11d xmm0 xmm1 ymm2
..B4.14:                        # Preds ..B4.10 ..B4.13
                                # Execution count [2.50e+01]
        lea       16(%r8), %r9d                                 #152.9
        cmpl      %r9d, %r10d                                   #152.9
        jl        ..B4.18       # Prob 50%                      #152.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r10d r11d xmm0 xmm1 ymm2
..B4.15:                        # Preds ..B4.14
                                # Execution count [4.50e+00]
        movslq    %r8d, %r8                                     #152.9
        movslq    %r10d, %r9                                    #152.9
        .align    16,0x90
                                # LOE rax rbx rsi rdi r8 r9 r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
..B4.16:                        # Preds ..B4.16 ..B4.15
                                # Execution count [2.50e+01]
        vmovupd   %ymm2, (%r12,%r8,8)                           #153.13
        vmovupd   %ymm2, 32(%r12,%r8,8)                         #153.13
        vmovupd   %ymm2, 64(%r12,%r8,8)                         #153.13
        vmovupd   %ymm2, 128(%r12,%r8,8)                        #154.13
        vmovupd   %ymm2, 192(%r12,%r8,8)                        #155.13
        vmovupd   %ymm2, 96(%r12,%r8,8)                         #153.13
        vmovupd   %ymm2, 160(%r12,%r8,8)                        #154.13
        vmovupd   %ymm2, 224(%r12,%r8,8)                        #155.13
        addq      $16, %r8                                      #152.9
        cmpq      %r9, %r8                                      #152.9
        jb        ..B4.16       # Prob 82%                      #152.9
                                # LOE rax rbx rsi rdi r8 r9 r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
..B4.18:                        # Preds ..B4.16 ..B4.14 ..B4.38
                                # Execution count [5.00e+00]
        lea       1(%r10), %r8d                                 #152.9
        cmpl      %r11d, %r8d                                   #152.9
        ja        ..B4.22       # Prob 50%                      #152.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
..B4.19:                        # Preds ..B4.18
                                # Execution count [4.50e+00]
        movslq    %r10d, %r9                                    #153.13
        negl      %r10d                                         #152.9
        addl      %r11d, %r10d                                  #152.9
        xorl      %r8d, %r8d                                    #152.9
        movslq    %r11d, %r11                                   #152.9
        vmovdqa   %xmm0, %xmm4                                  #152.9
        vpbroadcastd %r10d, %xmm3                               #152.9
        subq      %r9, %r11                                     #152.9
        lea       (%r12,%r9,8), %r12                            #153.13
                                # LOE rax rbx rsi rdi r8 r11 r12 r13 r14 edx ecx xmm0 xmm1 xmm3 xmm4 ymm2
..B4.20:                        # Preds ..B4.20 ..B4.19
                                # Execution count [2.50e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #152.9
        vpaddd    %xmm1, %xmm4, %xmm4                           #152.9
        vmovupd   %ymm2, (%r12,%r8,8){%k1}                      #153.13
        vmovupd   %ymm2, 64(%r12,%r8,8){%k1}                    #154.13
        vmovupd   %ymm2, 128(%r12,%r8,8){%k1}                   #155.13
        addq      $4, %r8                                       #152.9
        cmpq      %r11, %r8                                     #152.9
        jb        ..B4.20       # Prob 82%                      #152.9
                                # LOE rax rbx rsi rdi r8 r11 r12 r13 r14 edx ecx xmm0 xmm1 xmm3 xmm4 ymm2
..B4.22:                        # Preds ..B4.20 ..B4.4 ..B4.13 ..B4.18
                                # Execution count [5.00e+00]
        incl      %ecx                                          #149.5
        addq      $56, %rsi                                     #149.5
        cmpl      %edx, %ecx                                    #149.5
        jb        ..B4.4        # Prob 82%                      #149.5
                                # LOE rax rbx rsi rdi r13 r14 edx ecx xmm0 xmm1 ymm2
..B4.24:                        # Preds ..B4.22 ..B4.2
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #159.16
        vzeroupper                                              #159.16
..___tag_value_computeForceLJ_2xnn_half.214:
#       getTimeStamp()
        call      getTimeStamp                                  #159.16
..___tag_value_computeForceLJ_2xnn_half.215:
                                # LOE rbx r12 r13 r14 xmm0
..B4.41:                        # Preds ..B4.24
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 256(%rsp)                              #159.16[spill]
                                # LOE rbx r12 r13 r14
..B4.25:                        # Preds ..B4.41
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.1, %edi                         #163.5
..___tag_value_computeForceLJ_2xnn_half.217:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #163.5
..___tag_value_computeForceLJ_2xnn_half.218:
                                # LOE rbx r12 r13 r14
..B4.26:                        # Preds ..B4.25
                                # Execution count [1.00e+00]
        xorl      %r9d, %r9d                                    #166.16
        xorl      %r10d, %r10d                                  #166.16
        cmpl      $0, 20(%rbx)                                  #166.26
        jle       ..B4.34       # Prob 10%                      #166.26
                                # LOE rbx r10 r12 r13 r14 r9d
..B4.27:                        # Preds ..B4.26
                                # Execution count [9.00e-01]
        movl      $65484, %eax                                  #270.9
        kmovw     %eax, %k2                                     #270.9
        movl      $65450, %eax                                  #270.9
        vmovsd    .L_2il0floatpacket.2(%rip), %xmm15            #270.9
        kmovw     %eax, %k1                                     #270.9
        vmovups   192(%rsp), %zmm21                             #270.9[spill]
        vmovups   (%rsp), %zmm17                                #270.9[spill]
        vmovups   128(%rsp), %zmm18                             #270.9[spill]
        vmovups   64(%rsp), %zmm19                              #270.9[spill]
        vbroadcastsd .L_2il0floatpacket.3(%rip), %zmm16         #270.9
        vpxord    %zmm1, %zmm1, %zmm1                           #183.30
                                # LOE rbx r10 r13 r14 r9d xmm15 zmm1 zmm16 zmm17 zmm18 zmm19 zmm21 k1 k2
..B4.28:                        # Preds ..B4.32 ..B4.27
                                # Execution count [5.00e+00]
        movl      %r9d, %ecx                                    #171.27
        movl      %r9d, %edi                                    #171.27
        sarl      $1, %ecx                                      #171.27
        andl      $1, %edi                                      #171.27
        shll      $2, %edi                                      #171.27
        movl      16(%r14), %edx                                #174.44
        imull     %r9d, %edx                                    #174.44
        movq      160(%rbx), %r11                               #172.27
        lea       (%rcx,%rcx,2), %r8d                           #171.27
        vmovaps   %zmm1, %zmm22                                 #183.30
        lea       (%rdi,%r8,8), %r8d                            #171.27
        movslq    %r8d, %r8                                     #171.27
        vmovaps   %zmm22, %zmm23                                #184.30
        movslq    %edx, %rdx                                    #174.19
        vmovaps   %zmm23, %zmm24                                #185.30
        vbroadcastsd 8(%r11,%r8,8), %ymm12                      #177.33
        vbroadcastsd 24(%r11,%r8,8), %ymm10                     #178.33
        vbroadcastsd 72(%r11,%r8,8), %ymm0                      #179.33
        vbroadcastsd 88(%r11,%r8,8), %ymm3                      #180.33
        vbroadcastsd 136(%r11,%r8,8), %ymm5                     #181.33
        vbroadcastsd 152(%r11,%r8,8), %ymm7                     #182.33
        vbroadcastsd 128(%r11,%r8,8), %zmm4                     #181.33
        vbroadcastsd 64(%r11,%r8,8), %zmm9                      #179.33
        vbroadcastsd (%r11,%r8,8), %zmm13                       #177.33
        vbroadcastsd 16(%r11,%r8,8), %zmm11                     #178.33
        vbroadcastsd 80(%r11,%r8,8), %zmm2                      #180.33
        vbroadcastsd 144(%r11,%r8,8), %zmm6                     #182.33
        vinsertf64x4 $1, %ymm12, %zmm13, %zmm13                 #177.33
        vinsertf64x4 $1, %ymm10, %zmm11, %zmm12                 #178.33
        vinsertf64x4 $1, %ymm0, %zmm9, %zmm11                   #179.33
        vinsertf64x4 $1, %ymm3, %zmm2, %zmm10                   #180.33
        vinsertf64x4 $1, %ymm5, %zmm4, %zmm9                    #181.33
        vinsertf64x4 $1, %ymm7, %zmm6, %zmm6                    #182.33
        movq      24(%r14), %rsi                                #175.25
        movq      8(%r14), %rax                                 #174.19
        vmovaps   %zmm24, %zmm25                                #186.30
        vmovaps   %zmm25, %zmm26                                #187.30
        movslq    (%rsi,%r10,4), %rsi                           #175.25
        lea       (%rax,%rdx,4), %rdx                           #174.19
        movq      176(%rbx), %rcx                               #173.27
        movq      %rcx, %rdi                                    #173.27
        vmovaps   %zmm26, %zmm14                                #188.30
        xorl      %eax, %eax                                    #190.19
        testq     %rsi, %rsi                                    #190.28
        jle       ..B4.32       # Prob 10%                      #190.28
                                # LOE rax rdx rcx rbx rsi rdi r8 r10 r11 r13 r14 r9d xmm15 zmm1 zmm6 zmm9 zmm10 zmm11 zmm12 zmm13 zmm14 zmm16 zmm17 zmm18 zmm19 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 k1 k2
..B4.29:                        # Preds ..B4.28
                                # Execution count [4.50e+00]
        vmovups   .L_2il0floatpacket.5(%rip), %zmm20            #266.13
        movq      %r10, 16(%rsp)                                #266.13[spill]
        movq      %r14, 8(%rsp)                                 #266.13[spill]
        movq      %r13, (%rsp)                                  #266.13[spill]
                                # LOE rax rdx rcx rbx rsi rdi r8 r11 r9d xmm15 zmm1 zmm6 zmm9 zmm10 zmm11 zmm12 zmm13 zmm14 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 k1 k2
..B4.30:                        # Preds ..B4.43 ..B4.29
                                # Execution count [2.50e+01]
        movl      (%rdx,%rax,4), %r15d                          #191.22
        xorl      %r13d, %r13d                                  #214.66
        movslq    %r15d, %r15                                   #192.31
        incq      %rax                                          #190.39
        lea       (%r15,%r15), %r10d                            #214.56
        cmpl      %r9d, %r10d                                   #214.66
        lea       1(%r15,%r15), %r12d                           #215.61
        sete      %r13b                                         #214.66
        lea       (%r15,%r15,2), %r14                           #193.31
        shlq      $6, %r14                                      #193.31
        cmpl      %r9d, %r12d                                   #215.66
        movl      $0, %r12d                                     #215.66
        movl      %r13d, %r15d                                  #229.39
        sete      %r12b                                         #215.66
        negl      %r15d                                         #229.39
        movl      %r12d, %r10d                                  #229.39
        vbroadcastf64x4 128(%r14,%r11), %zmm28                  #199.36
        vbroadcastf64x4 64(%r14,%r11), %zmm27                   #198.36
        vbroadcastf64x4 (%r14,%r11), %zmm3                      #197.36
        vsubpd    %zmm28, %zmm9, %zmm5                          #202.35
        vsubpd    %zmm28, %zmm6, %zmm4                          #205.35
        vsubpd    %zmm3, %zmm13, %zmm0                          #200.35
        vsubpd    %zmm27, %zmm11, %zmm7                         #201.35
        vsubpd    %zmm3, %zmm12, %zmm8                          #203.35
        vsubpd    %zmm27, %zmm10, %zmm3                         #204.35
        vmulpd    %zmm5, %zmm5, %zmm31                          #232.80
        vmulpd    %zmm4, %zmm4, %zmm30                          #233.80
        vfmadd231pd %zmm7, %zmm7, %zmm31                        #232.57
        vfmadd231pd %zmm3, %zmm3, %zmm30                        #233.57
        vfmadd231pd %zmm0, %zmm0, %zmm31                        #232.34
        vfmadd231pd %zmm8, %zmm8, %zmm30                        #233.34
        vrcp14pd  %zmm31, %zmm29                                #238.35
        vrcp14pd  %zmm30, %zmm27                                #239.35
        vcmppd    $17, %zmm19, %zmm30, %k0                      #236.67
        vcmppd    $17, %zmm19, %zmm31, %k4                      #235.67
        vmulpd    %zmm18, %zmm29, %zmm2                         #241.67
        vmulpd    %zmm18, %zmm27, %zmm28                        #242.67
        vmulpd    %zmm2, %zmm29, %zmm30                         #241.51
        vmulpd    %zmm28, %zmm27, %zmm28                        #242.51
        vmulpd    %zmm30, %zmm29, %zmm2                         #241.35
        vmulpd    %zmm28, %zmm27, %zmm31                        #242.35
        vfmsub213pd %zmm21, %zmm29, %zmm30                      #244.79
        vfmsub213pd %zmm21, %zmm27, %zmm28                      #245.79
        vmulpd    %zmm17, %zmm29, %zmm29                        #244.105
        vmulpd    %zmm17, %zmm27, %zmm27                        #245.105
        vmulpd    %zmm29, %zmm30, %zmm30                        #244.70
        vmulpd    %zmm27, %zmm28, %zmm27                        #245.70
        vmovupd   64(%r14,%rdi), %ymm28                         #266.13
        vmulpd    %zmm30, %zmm2, %zmm2                          #244.54
        vmulpd    %zmm27, %zmm31, %zmm31                        #245.54
        vmovupd   128(%r14,%rdi), %ymm27                        #266.13
        vmulpd    %zmm2, %zmm16, %zmm2                          #244.36
        vmulpd    %zmm31, %zmm16, %zmm30                        #245.36
        vmovupd   (%r14,%rdi), %ymm31                           #266.13
        shll      $6, %r10d                                     #229.39
        lea       (%r13,%r13,2), %r11d                          #229.39
        negl      %r10d                                         #229.39
        negl      %r11d                                         #229.39
        addl      %r12d, %r10d                                  #229.39
        addl      %r10d, %r11d                                  #229.39
        movl      %r12d, %r10d                                  #229.39
        shll      $5, %r10d                                     #229.39
        negl      %r10d                                         #229.39
        addl      %r12d, %r10d                                  #229.39
        shll      $4, %r11d                                     #229.39
        addl      $4080, %r11d                                  #229.39
        lea       255(%r15,%r10), %r15d                         #229.39
        kmovw     %k4, %r10d                                    #235.67
        orl       %r15d, %r11d                                  #229.39
        movl      %r12d, %r15d                                  #230.39
        kmovb     %r11d, %k3                                    #229.39
        kmovb     %r10d, %k6                                    #235.41
        movl      %r13d, %r10d                                  #230.39
        kmovb     %k3, %r11d                                    #229.39
        shll      $4, %r10d                                     #230.39
        shll      $8, %r15d                                     #230.39
        negl      %r10d                                         #230.39
        kmovb     %r11d, %k5                                    #235.41
        negl      %r15d                                         #230.39
        kandb     %k6, %k5, %k7                                 #235.41
        addl      %r13d, %r10d                                  #230.39
        addl      %r12d, %r15d                                  #230.39
        kmovb     %k7, %r11d                                    #235.41
        addl      %r15d, %r10d                                  #230.39
        movl      %r12d, %r15d                                  #230.39
        kmovw     %r11d, %k3                                    #247.33
        lea       (,%r13,8), %r11d                              #230.39
        shll      $7, %r15d                                     #230.39
        subl      %r11d, %r13d                                  #230.39
        subl      %r15d, %r12d                                  #230.39
        shll      $4, %r10d                                     #230.39
        addl      $4080, %r10d                                  #230.39
        kmovw     %k0, %r11d                                    #236.67
        vmulpd    %zmm2, %zmm0, %zmm29{%k3}{z}                  #247.33
        vmulpd    %zmm2, %zmm7, %zmm0{%k3}{z}                   #248.33
        vmulpd    %zmm2, %zmm5, %zmm5{%k3}{z}                   #249.33
        vaddpd    %zmm22, %zmm29, %zmm22                        #254.20
        vaddpd    %zmm23, %zmm0, %zmm23                         #255.20
        vaddpd    %zmm24, %zmm5, %zmm24                         #256.20
        kmovb     %r11d, %k0                                    #236.41
        lea       255(%r13,%r12), %r13d                         #230.39
        orl       %r13d, %r10d                                  #230.39
        kmovb     %r10d, %k4                                    #230.39
        kmovb     %k4, %r10d                                    #230.39
        kmovb     %r10d, %k5                                    #236.41
        kandb     %k0, %k5, %k6                                 #236.41
        kmovb     %k6, %r12d                                    #236.41
        kmovw     %r12d, %k7                                    #250.33
        vmulpd    %zmm30, %zmm8, %zmm7{%k7}{z}                  #250.33
        vmulpd    %zmm30, %zmm3, %zmm8{%k7}{z}                  #251.33
        vmulpd    %zmm30, %zmm4, %zmm2{%k7}{z}                  #252.33
        vaddpd    %zmm7, %zmm29, %zmm3                          #266.38
        vaddpd    %zmm8, %zmm0, %zmm4                           #266.49
        vaddpd    %zmm2, %zmm5, %zmm29                          #266.60
        vaddpd    %zmm26, %zmm8, %zmm26                         #258.20
        vaddpd    %zmm25, %zmm7, %zmm25                         #257.20
        vaddpd    %zmm14, %zmm2, %zmm14                         #259.20
        vpermd    %zmm3, %zmm20, %zmm0                          #266.13
        vpermd    %zmm4, %zmm20, %zmm8                          #266.13
        vpermd    %zmm29, %zmm20, %zmm30                        #266.13
        vaddpd    %zmm3, %zmm0, %zmm5                           #266.13
        vaddpd    %zmm4, %zmm8, %zmm4                           #266.13
        vaddpd    %zmm29, %zmm30, %zmm29                        #266.13
        vsubpd    %ymm5, %ymm31, %ymm7                          #266.13
        vsubpd    %ymm4, %ymm28, %ymm28                         #266.13
        vsubpd    %ymm29, %ymm27, %ymm27                        #266.13
        vmovupd   %ymm7, (%r14,%rdi)                            #266.13
        vmovupd   %ymm28, 64(%r14,%rdi)                         #266.13
        vmovupd   %ymm27, 128(%r14,%rdi)                        #266.13
        cmpq      %rsi, %rax                                    #190.28
        jge       ..B4.31       # Prob 18%                      #190.28
                                # LOE rax rdx rcx rbx rsi r8 r9d xmm15 zmm1 zmm6 zmm9 zmm10 zmm11 zmm12 zmm13 zmm14 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 k1 k2
..B4.43:                        # Preds ..B4.30
                                # Execution count [2.05e+01]
        movq      176(%rbx), %rdi                               #151.27
        movq      160(%rbx), %r11                               #172.27
        jmp       ..B4.30       # Prob 100%                     #172.27
                                # LOE rax rdx rcx rbx rsi rdi r8 r11 r9d xmm15 zmm1 zmm6 zmm9 zmm10 zmm11 zmm12 zmm13 zmm14 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 k1 k2
..B4.31:                        # Preds ..B4.30
                                # Execution count [4.50e+00]
        movq      16(%rsp), %r10                                #[spill]
        movq      8(%rsp), %r14                                 #[spill]
        movq      (%rsp), %r13                                  #[spill]
                                # LOE rcx rbx rsi r8 r10 r13 r14 r9d xmm15 zmm1 zmm14 zmm16 zmm17 zmm18 zmm19 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 k1 k2
..B4.32:                        # Preds ..B4.31 ..B4.28
                                # Execution count [5.00e+00]
        vpermpd   $78, %zmm22, %zmm20                           #270.9
        vxorpd    %xmm8, %xmm8, %xmm8                           #276.9
        vpermpd   $78, %zmm23, %zmm30                           #271.9
        vpermpd   $78, %zmm24, %zmm3                            #272.9
        vaddpd    %zmm22, %zmm20, %zmm27                        #270.9
        vpermpd   $78, %zmm25, %zmm22                           #270.9
        vaddpd    %zmm23, %zmm30, %zmm31                        #271.9
        vpermpd   $78, %zmm26, %zmm23                           #271.9
        vaddpd    %zmm24, %zmm3, %zmm4                          #272.9
        vpermpd   $78, %zmm14, %zmm24                           #272.9
        vaddpd    %zmm22, %zmm25, %zmm27{%k2}                   #270.9
        vaddpd    %zmm23, %zmm26, %zmm31{%k2}                   #271.9
        vaddpd    %zmm24, %zmm14, %zmm4{%k2}                    #272.9
        vpermpd   $177, %zmm27, %zmm25                          #270.9
        vpermpd   $177, %zmm31, %zmm26                          #271.9
        vpermpd   $177, %zmm4, %zmm5                            #272.9
        vaddpd    %zmm25, %zmm27, %zmm28                        #270.9
        vaddpd    %zmm26, %zmm31, %zmm0                         #271.9
        vaddpd    %zmm5, %zmm4, %zmm6                           #272.9
        vshuff64x2 $238, %zmm28, %zmm28, %zmm28{%k1}            #270.9
        vshuff64x2 $238, %zmm0, %zmm0, %zmm0{%k1}               #271.9
        vshuff64x2 $238, %zmm6, %zmm6, %zmm6{%k1}               #272.9
        incl      %r9d                                          #166.49
        incq      %r10                                          #166.49
        vaddpd    (%rcx,%r8,8), %ymm28, %ymm29                  #270.9
        vaddpd    64(%rcx,%r8,8), %ymm0, %ymm2                  #271.9
        vaddpd    128(%rcx,%r8,8), %ymm6, %ymm7                 #272.9
        vmovupd   %ymm29, (%rcx,%r8,8)                          #270.9
        vmovupd   %ymm2, 64(%rcx,%r8,8)                         #271.9
        vmovupd   %ymm7, 128(%rcx,%r8,8)                        #272.9
        addq      %rsi, 8(%r13)                                 #275.9
        vcvtsi2sd %esi, %xmm8, %xmm8                            #276.9
        vmulsd    %xmm8, %xmm15, %xmm9                          #276.9
        vcvttsd2si %xmm9, %rax                                  #276.9
        incq      (%r13)                                        #274.9
        addq      %rax, 16(%r13)                                #276.9
        cmpl      20(%rbx), %r9d                                #166.26
        jl        ..B4.28       # Prob 82%                      #166.26
                                # LOE rbx r10 r13 r14 r9d xmm15 zmm1 zmm16 zmm17 zmm18 zmm19 zmm21 k1 k2
..B4.34:                        # Preds ..B4.32 ..B4.26
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.1, %edi                         #279.5
        vzeroupper                                              #279.5
..___tag_value_computeForceLJ_2xnn_half.229:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #279.5
..___tag_value_computeForceLJ_2xnn_half.230:
                                # LOE r12
..B4.35:                        # Preds ..B4.34
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #282.16
..___tag_value_computeForceLJ_2xnn_half.231:
#       getTimeStamp()
        call      getTimeStamp                                  #282.16
..___tag_value_computeForceLJ_2xnn_half.232:
                                # LOE r12 xmm0
..B4.42:                        # Preds ..B4.35
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, (%rsp)                                 #282.16[spill]
                                # LOE r12
..B4.36:                        # Preds ..B4.42
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.4, %edi                         #283.5
        xorl      %eax, %eax                                    #283.5
..___tag_value_computeForceLJ_2xnn_half.234:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #283.5
..___tag_value_computeForceLJ_2xnn_half.235:
                                # LOE r12
..B4.37:                        # Preds ..B4.36
                                # Execution count [1.00e+00]
        vmovsd    (%rsp), %xmm0                                 #284.14[spill]
        vsubsd    256(%rsp), %xmm0, %xmm0                       #284.14[spill]
        addq      $280, %rsp                                    #284.14
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
..B4.38:                        # Preds ..B4.5
                                # Execution count [4.50e-01]: Infreq
        xorl      %r10d, %r10d                                  #152.9
        jmp       ..B4.18       # Prob 100%                     #152.9
        .align    16,0x90
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
	.cfi_endproc
# mark_end;
	.type	computeForceLJ_2xnn_half,@function
	.size	computeForceLJ_2xnn_half,.-computeForceLJ_2xnn_half
..LNcomputeForceLJ_2xnn_half.3:
	.data
# -- End  computeForceLJ_2xnn_half
	.text
.L_2__routine_start_computeForceLJ_4xn_4:
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
..B5.1:                         # Preds ..B5.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForceLJ_4xn.253:
..L254:
                                                        #787.91
        cmpl      $0, 32(%rdx)                                  #788.8
        je        ..B5.4        # Prob 50%                      #788.8
                                # LOE rdx rcx rbx rbp rsi rdi r12 r13 r14 r15
..B5.2:                         # Preds ..B5.1
                                # Execution count [5.00e-01]
#       computeForceLJ_4xn_half(Parameter *, Atom *, Neighbor *, Stats *)
        jmp       computeForceLJ_4xn_half                       #789.16
                                # LOE
..B5.4:                         # Preds ..B5.1
                                # Execution count [5.00e-01]
#       computeForceLJ_4xn_full(Parameter *, Atom *, Neighbor *, Stats *)
        jmp       computeForceLJ_4xn_full                       #792.12
        .align    16,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	computeForceLJ_4xn,@function
	.size	computeForceLJ_4xn,.-computeForceLJ_4xn
..LNcomputeForceLJ_4xn.4:
	.data
# -- End  computeForceLJ_4xn
	.text
.L_2__routine_start_computeForceLJ_4xn_half_5:
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
..B6.1:                         # Preds ..B6.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForceLJ_4xn_half.256:
..L257:
                                                        #432.96
        pushq     %rbp                                          #432.96
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #432.96
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #432.96
        pushq     %r12                                          #432.96
        pushq     %r13                                          #432.96
        pushq     %r14                                          #432.96
        pushq     %r15                                          #432.96
        pushq     %rbx                                          #432.96
        subq      $1176, %rsp                                   #432.96
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
        movq      %rdi, %r15                                    #432.96
        movl      $.L_2__STRING.5, %edi                         #433.5
        xorl      %eax, %eax                                    #433.5
        movq      %rcx, %r14                                    #432.96
        movq      %rdx, %r13                                    #432.96
        movq      %rsi, %rbx                                    #432.96
..___tag_value_computeForceLJ_4xn_half.266:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #433.5
..___tag_value_computeForceLJ_4xn_half.267:
                                # LOE rbx r12 r13 r14 r15
..B6.2:                         # Preds ..B6.1
                                # Execution count [1.00e+00]
        vmovsd    144(%r15), %xmm0                              #436.27
        xorl      %ecx, %ecx                                    #445.5
        vmulsd    %xmm0, %xmm0, %xmm1                           #439.36
        xorl      %esi, %esi                                    #447.27
        vbroadcastsd 56(%r15), %zmm3                            #440.32
        vbroadcastsd 40(%r15), %zmm4                            #441.29
        vbroadcastsd %xmm1, %zmm2                               #439.36
        vbroadcastsd .L_2il0floatpacket.2(%rip), %zmm5          #443.29
        vmovups   %zmm3, 256(%rsp)                              #440.32[spill]
        vmovups   %zmm2, 128(%rsp)                              #439.36[spill]
        vmovups   %zmm4, 192(%rsp)                              #441.29[spill]
        vmovups   %zmm5, (%rsp)                                 #443.29[spill]
        movl      20(%rbx), %edx                                #445.26
        testl     %edx, %edx                                    #445.26
        jle       ..B6.24       # Prob 9%                       #445.26
                                # LOE rbx rsi r12 r13 r14 edx ecx
..B6.3:                         # Preds ..B6.2
                                # Execution count [9.00e-01]
        movq      176(%rbx), %rdi                               #447.27
        movq      192(%rbx), %rax                               #448.32
        vxorpd    %ymm2, %ymm2, %ymm2                           #449.39
        vmovdqu   .L_2il0floatpacket.0(%rip), %xmm1             #448.9
        vmovdqu   .L_2il0floatpacket.1(%rip), %xmm0             #448.9
                                # LOE rax rbx rsi rdi r13 r14 edx ecx xmm0 xmm1 ymm2
..B6.4:                         # Preds ..B6.22 ..B6.3
                                # Execution count [5.00e+00]
        movl      %ecx, %r8d                                    #446.27
        movl      %ecx, %r9d                                    #446.27
        sarl      $1, %r8d                                      #446.27
        andl      $1, %r9d                                      #446.27
        shll      $2, %r9d                                      #446.27
        lea       (%r8,%r8,2), %r10d                            #446.27
        lea       (%r9,%r10,8), %r11d                           #446.27
        movslq    %r11d, %r11                                   #447.27
        lea       (%rdi,%r11,8), %r12                           #447.27
        movl      (%rsi,%rax), %r11d                            #448.32
        testl     %r11d, %r11d                                  #448.32
        jle       ..B6.22       # Prob 50%                      #448.32
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r11d xmm0 xmm1 ymm2
..B6.5:                         # Preds ..B6.4
                                # Execution count [4.50e+00]
        cmpl      $16, %r11d                                    #448.9
        jl        ..B6.38       # Prob 10%                      #448.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r11d xmm0 xmm1 ymm2
..B6.6:                         # Preds ..B6.5
                                # Execution count [4.50e+00]
        lea       128(%r12), %r8                                #451.13
        andq      $63, %r8                                      #448.9
        testl     $7, %r8d                                      #448.9
        je        ..B6.8        # Prob 50%                      #448.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B6.7:                         # Preds ..B6.6
                                # Execution count [2.25e+00]
        xorl      %r8d, %r8d                                    #448.9
        jmp       ..B6.10       # Prob 100%                     #448.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B6.8:                         # Preds ..B6.6
                                # Execution count [2.25e+00]
        testl     %r8d, %r8d                                    #448.9
        je        ..B6.10       # Prob 50%                      #448.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B6.9:                         # Preds ..B6.8
                                # Execution count [2.50e+01]
        negl      %r8d                                          #448.9
        addl      $64, %r8d                                     #448.9
        shrl      $3, %r8d                                      #448.9
        cmpl      %r8d, %r11d                                   #448.9
        cmovl     %r11d, %r8d                                   #448.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B6.10:                        # Preds ..B6.7 ..B6.9 ..B6.8
                                # Execution count [5.00e+00]
        movl      %r11d, %r10d                                  #448.9
        subl      %r8d, %r10d                                   #448.9
        andl      $15, %r10d                                    #448.9
        negl      %r10d                                         #448.9
        addl      %r11d, %r10d                                  #448.9
        cmpl      $1, %r8d                                      #448.9
        jb        ..B6.14       # Prob 50%                      #448.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r10d r11d xmm0 xmm1 ymm2
..B6.11:                        # Preds ..B6.10
                                # Execution count [4.50e+00]
        vpbroadcastd %r8d, %xmm3                                #448.9
        xorl      %r15d, %r15d                                  #448.9
        vmovdqa   %xmm0, %xmm4                                  #448.9
        movslq    %r8d, %r9                                     #448.9
                                # LOE rax rbx rsi rdi r9 r12 r13 r14 r15 edx ecx r8d r10d r11d xmm0 xmm1 xmm3 xmm4 ymm2
..B6.12:                        # Preds ..B6.12 ..B6.11
                                # Execution count [2.50e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #448.9
        vpaddd    %xmm1, %xmm4, %xmm4                           #448.9
        vmovupd   %ymm2, (%r12,%r15,8){%k1}                     #449.13
        vmovupd   %ymm2, 64(%r12,%r15,8){%k1}                   #450.13
        vmovupd   %ymm2, 128(%r12,%r15,8){%k1}                  #451.13
        addq      $4, %r15                                      #448.9
        cmpq      %r9, %r15                                     #448.9
        jb        ..B6.12       # Prob 82%                      #448.9
                                # LOE rax rbx rsi rdi r9 r12 r13 r14 r15 edx ecx r8d r10d r11d xmm0 xmm1 xmm3 xmm4 ymm2
..B6.13:                        # Preds ..B6.12
                                # Execution count [4.50e+00]
        cmpl      %r8d, %r11d                                   #448.9
        je        ..B6.22       # Prob 10%                      #448.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r10d r11d xmm0 xmm1 ymm2
..B6.14:                        # Preds ..B6.10 ..B6.13
                                # Execution count [2.50e+01]
        lea       16(%r8), %r9d                                 #448.9
        cmpl      %r9d, %r10d                                   #448.9
        jl        ..B6.18       # Prob 50%                      #448.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r10d r11d xmm0 xmm1 ymm2
..B6.15:                        # Preds ..B6.14
                                # Execution count [4.50e+00]
        movslq    %r8d, %r8                                     #448.9
        movslq    %r10d, %r9                                    #448.9
        .align    16,0x90
                                # LOE rax rbx rsi rdi r8 r9 r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
..B6.16:                        # Preds ..B6.16 ..B6.15
                                # Execution count [2.50e+01]
        vmovupd   %ymm2, (%r12,%r8,8)                           #449.13
        vmovupd   %ymm2, 32(%r12,%r8,8)                         #449.13
        vmovupd   %ymm2, 64(%r12,%r8,8)                         #449.13
        vmovupd   %ymm2, 128(%r12,%r8,8)                        #450.13
        vmovupd   %ymm2, 192(%r12,%r8,8)                        #451.13
        vmovupd   %ymm2, 96(%r12,%r8,8)                         #449.13
        vmovupd   %ymm2, 160(%r12,%r8,8)                        #450.13
        vmovupd   %ymm2, 224(%r12,%r8,8)                        #451.13
        addq      $16, %r8                                      #448.9
        cmpq      %r9, %r8                                      #448.9
        jb        ..B6.16       # Prob 82%                      #448.9
                                # LOE rax rbx rsi rdi r8 r9 r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
..B6.18:                        # Preds ..B6.16 ..B6.14 ..B6.38
                                # Execution count [5.00e+00]
        lea       1(%r10), %r8d                                 #448.9
        cmpl      %r11d, %r8d                                   #448.9
        ja        ..B6.22       # Prob 50%                      #448.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
..B6.19:                        # Preds ..B6.18
                                # Execution count [4.50e+00]
        movslq    %r10d, %r9                                    #449.13
        negl      %r10d                                         #448.9
        addl      %r11d, %r10d                                  #448.9
        xorl      %r8d, %r8d                                    #448.9
        movslq    %r11d, %r11                                   #448.9
        vmovdqa   %xmm0, %xmm4                                  #448.9
        vpbroadcastd %r10d, %xmm3                               #448.9
        subq      %r9, %r11                                     #448.9
        lea       (%r12,%r9,8), %r12                            #449.13
                                # LOE rax rbx rsi rdi r8 r11 r12 r13 r14 edx ecx xmm0 xmm1 xmm3 xmm4 ymm2
..B6.20:                        # Preds ..B6.20 ..B6.19
                                # Execution count [2.50e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #448.9
        vpaddd    %xmm1, %xmm4, %xmm4                           #448.9
        vmovupd   %ymm2, (%r12,%r8,8){%k1}                      #449.13
        vmovupd   %ymm2, 64(%r12,%r8,8){%k1}                    #450.13
        vmovupd   %ymm2, 128(%r12,%r8,8){%k1}                   #451.13
        addq      $4, %r8                                       #448.9
        cmpq      %r11, %r8                                     #448.9
        jb        ..B6.20       # Prob 82%                      #448.9
                                # LOE rax rbx rsi rdi r8 r11 r12 r13 r14 edx ecx xmm0 xmm1 xmm3 xmm4 ymm2
..B6.22:                        # Preds ..B6.20 ..B6.4 ..B6.13 ..B6.18
                                # Execution count [5.00e+00]
        incl      %ecx                                          #445.5
        addq      $56, %rsi                                     #445.5
        cmpl      %edx, %ecx                                    #445.5
        jb        ..B6.4        # Prob 82%                      #445.5
                                # LOE rax rbx rsi rdi r13 r14 edx ecx xmm0 xmm1 ymm2
..B6.24:                        # Preds ..B6.22 ..B6.2
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #455.16
        vzeroupper                                              #455.16
..___tag_value_computeForceLJ_4xn_half.272:
#       getTimeStamp()
        call      getTimeStamp                                  #455.16
..___tag_value_computeForceLJ_4xn_half.273:
                                # LOE rbx r12 r13 r14 xmm0
..B6.41:                        # Preds ..B6.24
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 64(%rsp)                               #455.16[spill]
                                # LOE rbx r12 r13 r14
..B6.25:                        # Preds ..B6.41
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.1, %edi                         #459.5
..___tag_value_computeForceLJ_4xn_half.275:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #459.5
..___tag_value_computeForceLJ_4xn_half.276:
                                # LOE rbx r12 r13 r14
..B6.26:                        # Preds ..B6.25
                                # Execution count [1.00e+00]
        xorl      %r10d, %r10d                                  #462.16
        xorl      %r9d, %r9d                                    #462.16
        cmpl      $0, 20(%rbx)                                  #462.26
        jle       ..B6.34       # Prob 10%                      #462.26
                                # LOE rbx r9 r12 r13 r14 r10d
..B6.27:                        # Preds ..B6.26
                                # Execution count [9.00e-01]
        movl      $65450, %eax                                  #605.9
        kmovw     %eax, %k3                                     #605.9
        movl      $65520, %eax                                  #605.9
        kmovw     %eax, %k4                                     #605.9
        vmovsd    .L_2il0floatpacket.2(%rip), %xmm3             #605.9
        movl      $12, %eax                                     #605.9
        kmovw     %eax, %k2                                     #605.9
        vmovups   (%rsp), %zmm23                                #605.9[spill]
        vbroadcastsd .L_2il0floatpacket.3(%rip), %zmm24         #605.9
        vpxord    %zmm1, %zmm1, %zmm1                           #485.30
                                # LOE rbx r9 r13 r14 r10d xmm3 zmm1 zmm23 zmm24 k2 k3 k4
..B6.28:                        # Preds ..B6.32 ..B6.27
                                # Execution count [5.00e+00]
        vmovaps   %zmm1, %zmm22                                 #485.30
        movl      %r10d, %eax                                   #467.27
        vmovaps   %zmm22, %zmm21                                #486.30
        movl      %r10d, %ecx                                   #467.27
        vmovaps   %zmm21, %zmm2                                 #487.30
        andl      $1, %ecx                                      #467.27
        sarl      $1, %eax                                      #467.27
        movl      16(%r13), %edi                                #470.44
        vmovaps   %zmm2, %zmm0                                  #488.30
        imull     %r10d, %edi                                   #470.44
        shll      $2, %ecx                                      #467.27
        lea       (%rax,%rax,2), %esi                           #467.27
        vmovaps   %zmm0, %zmm20                                 #489.30
        vmovaps   %zmm20, %zmm19                                #490.30
        vmovaps   %zmm19, %zmm18                                #491.30
        vmovaps   %zmm18, %zmm17                                #492.30
        lea       (%rcx,%rsi,8), %eax                           #467.27
        movslq    %edi, %rdi                                    #470.19
        movslq    %eax, %rax                                    #467.27
        movq      8(%r13), %rdx                                 #470.19
        movq      24(%r13), %r8                                 #471.25
        vmovaps   %zmm17, %zmm25                                #493.30
        movq      160(%rbx), %r11                               #468.27
        lea       (%rdx,%rdi,4), %rdi                           #470.19
        vmovaps   %zmm25, %zmm26                                #494.30
        vmovaps   %zmm26, %zmm27                                #495.30
        movslq    (%r8,%r9,4), %rdx                             #471.25
        xorl      %r8d, %r8d                                    #498.19
        movq      176(%rbx), %rsi                               #469.27
        movq      %rsi, %rcx                                    #469.27
        vmovaps   %zmm27, %zmm16                                #496.30
        vbroadcastsd (%r11,%rax,8), %zmm15                      #473.33
        vbroadcastsd 8(%r11,%rax,8), %zmm14                     #474.33
        vbroadcastsd 16(%r11,%rax,8), %zmm13                    #475.33
        vbroadcastsd 24(%r11,%rax,8), %zmm12                    #476.33
        vbroadcastsd 64(%r11,%rax,8), %zmm11                    #477.33
        vbroadcastsd 72(%r11,%rax,8), %zmm10                    #478.33
        vbroadcastsd 80(%r11,%rax,8), %zmm9                     #479.33
        vbroadcastsd 88(%r11,%rax,8), %zmm8                     #480.33
        vbroadcastsd 128(%r11,%rax,8), %zmm7                    #481.33
        vbroadcastsd 136(%r11,%rax,8), %zmm6                    #482.33
        vbroadcastsd 144(%r11,%rax,8), %zmm5                    #483.33
        vbroadcastsd 152(%r11,%rax,8), %zmm4                    #484.33
        testq     %rdx, %rdx                                    #498.28
        jle       ..B6.32       # Prob 10%                      #498.28
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11 r13 r14 r10d xmm3 zmm0 zmm1 zmm2 zmm4 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 k2 k3 k4
..B6.29:                        # Preds ..B6.28
                                # Execution count [4.50e+00]
        vmovups   %zmm0, 1024(%rsp)                             #[spill]
        vmovups   %zmm2, 1088(%rsp)                             #[spill]
        vmovups   %zmm4, 960(%rsp)                              #[spill]
        vmovups   %zmm5, 576(%rsp)                              #[spill]
        vmovups   %zmm6, 768(%rsp)                              #[spill]
        vmovups   %zmm7, 832(%rsp)                              #[spill]
        vmovups   %zmm8, 448(%rsp)                              #[spill]
        vmovups   %zmm9, 704(%rsp)                              #[spill]
        vmovups   %zmm10, 640(%rsp)                             #[spill]
        vmovups   %zmm11, 320(%rsp)                             #[spill]
        vmovups   %zmm12, 896(%rsp)                             #[spill]
        vmovups   %zmm13, (%rsp)                                #[spill]
        vmovups   %zmm14, 512(%rsp)                             #[spill]
        vmovups   %zmm15, 384(%rsp)                             #[spill]
        movq      %r13, 80(%rsp)                                #[spill]
        movq      %r14, 72(%rsp)                                #[spill]
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11 r10d zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 k2 k3 k4
..B6.30:                        # Preds ..B6.43 ..B6.29
                                # Execution count [2.50e+01]
        movl      (%rdi,%r8,4), %r14d                           #499.22
        xorl      %r12d, %r12d                                  #526.66
        movslq    %r14d, %r14                                   #500.31
        incq      %r8                                           #498.39
        vmovups   832(%rsp), %zmm12                             #508.35[spill]
        lea       (%r14,%r14), %r15d                            #526.56
        vmovups   (%rsp), %zmm8                                 #512.35[spill]
        vmovups   576(%rsp), %zmm7                              #514.35[spill]
        vmovups   512(%rsp), %zmm10                             #509.35[spill]
        vmovups   768(%rsp), %zmm13                             #511.35[spill]
        vmovups   640(%rsp), %zmm11                             #510.35[spill]
        vmovups   320(%rsp), %zmm15                             #507.35[spill]
        vmovups   704(%rsp), %zmm9                              #513.35[spill]
        vmovups   384(%rsp), %zmm14                             #506.35[spill]
        vmovups   960(%rsp), %zmm30                             #517.35[spill]
        vmovups   448(%rsp), %zmm29                             #516.35[spill]
        vmovups   896(%rsp), %zmm5                              #515.35[spill]
        cmpl      %r10d, %r15d                                  #526.66
        lea       (%r14,%r14,2), %r13                           #501.31
        sete      %r12b                                         #526.66
        shlq      $6, %r13                                      #501.31
        vsubpd    128(%r13,%r11), %zmm12, %zmm1                 #508.35
        vsubpd    (%r13,%r11), %zmm8, %zmm6                     #512.35
        vsubpd    128(%r13,%r11), %zmm7, %zmm8                  #514.35
        vsubpd    (%r13,%r11), %zmm10, %zmm2                    #509.35
        vsubpd    128(%r13,%r11), %zmm13, %zmm4                 #511.35
        vsubpd    64(%r13,%r11), %zmm11, %zmm3                  #510.35
        vsubpd    64(%r13,%r11), %zmm15, %zmm0                  #507.35
        vsubpd    64(%r13,%r11), %zmm9, %zmm9                   #513.35
        vsubpd    (%r13,%r11), %zmm14, %zmm28                   #506.35
        vsubpd    128(%r13,%r11), %zmm30, %zmm14                #517.35
        vsubpd    64(%r13,%r11), %zmm29, %zmm15                 #516.35
        vsubpd    (%r13,%r11), %zmm5, %zmm12                    #515.35
        vmulpd    %zmm1, %zmm1, %zmm10                          #541.80
        vmulpd    %zmm8, %zmm8, %zmm13                          #543.80
        vmulpd    %zmm4, %zmm4, %zmm11                          #542.80
        vmulpd    %zmm14, %zmm14, %zmm30                        #544.80
        vmovups   128(%rsp), %zmm29                             #546.67[spill]
        vfmadd231pd %zmm0, %zmm0, %zmm10                        #541.57
        vfmadd231pd %zmm9, %zmm9, %zmm13                        #543.57
        vfmadd231pd %zmm3, %zmm3, %zmm11                        #542.57
        vfmadd231pd %zmm15, %zmm15, %zmm30                      #544.57
        vfmadd231pd %zmm28, %zmm28, %zmm10                      #541.34
        vfmadd231pd %zmm6, %zmm6, %zmm13                        #543.34
        vfmadd231pd %zmm2, %zmm2, %zmm11                        #542.34
        vfmadd231pd %zmm12, %zmm12, %zmm30                      #544.34
        vrcp14pd  %zmm10, %zmm31                                #551.35
        vrcp14pd  %zmm13, %zmm7                                 #553.35
        vrcp14pd  %zmm11, %zmm5                                 #552.35
        vcmppd    $17, %zmm29, %zmm13, %k7                      #548.67
        vcmppd    $17, %zmm29, %zmm11, %k6                      #547.67
        vcmppd    $17, %zmm29, %zmm10, %k1                      #546.67
        vcmppd    $17, %zmm29, %zmm30, %k0                      #549.67
        vrcp14pd  %zmm30, %zmm10                                #554.35
        vmovups   256(%rsp), %zmm13                             #556.67[spill]
        vmulpd    %zmm13, %zmm31, %zmm11                        #556.67
        lea       1(%r14,%r14), %r11d                           #527.61
        vmulpd    %zmm11, %zmm31, %zmm29                        #556.51
        cmpl      %r10d, %r11d                                  #527.66
        vmovups   192(%rsp), %zmm11                             #561.105[spill]
        vmulpd    %zmm29, %zmm31, %zmm30                        #556.35
        vfmsub213pd %zmm23, %zmm31, %zmm29                      #561.79
        vmulpd    %zmm11, %zmm31, %zmm31                        #561.105
        vmulpd    %zmm31, %zmm29, %zmm29                        #561.70
        movl      $0, %r11d                                     #527.66
        vmulpd    %zmm29, %zmm30, %zmm30                        #561.54
        sete      %r11b                                         #527.66
        vmulpd    %zmm13, %zmm5, %zmm29                         #557.67
        vmulpd    %zmm30, %zmm24, %zmm31                        #561.36
        movl      %r11d, %r15d                                  #528.39
        movl      %r12d, %r14d                                  #528.39
        shll      $5, %r15d                                     #528.39
        negl      %r14d                                         #528.39
        negl      %r15d                                         #528.39
        addl      %r11d, %r15d                                  #528.39
        lea       255(%r15,%r14), %r15d                         #528.39
        kmovb     %r15d, %k5                                    #528.39
        kmovw     %k1, %r15d                                    #546.67
        kmovb     %k5, %r14d                                    #528.39
        kmovb     %r14d, %k5                                    #546.41
        kmovb     %r15d, %k1                                    #546.41
        movl      %r11d, %r15d                                  #529.39
        kandb     %k1, %k5, %k5                                 #546.41
        kmovb     %k5, %r14d                                    #546.41
        kmovw     %r14d, %k5                                    #566.33
        lea       (%r12,%r12,2), %r14d                          #529.39
        vmulpd    %zmm31, %zmm28, %zmm28{%k5}{z}                #566.33
        negl      %r14d                                         #529.39
        vmulpd    %zmm31, %zmm0, %zmm0{%k5}{z}                  #567.33
        vmulpd    %zmm31, %zmm1, %zmm31{%k5}{z}                 #568.33
        vaddpd    %zmm22, %zmm28, %zmm22                        #579.20
        vaddpd    %zmm21, %zmm0, %zmm21                         #580.20
        vaddpd    1088(%rsp), %zmm31, %zmm1                     #581.20[spill]
        vmovups   %zmm1, 1088(%rsp)                             #581.20[spill]
        vmulpd    %zmm29, %zmm5, %zmm1                          #557.51
        vmulpd    %zmm1, %zmm5, %zmm30                          #557.35
        vfmsub213pd %zmm23, %zmm5, %zmm1                        #562.79
        vmulpd    %zmm11, %zmm5, %zmm5                          #562.105
        vmulpd    %zmm5, %zmm1, %zmm29                          #562.70
        vmulpd    %zmm29, %zmm30, %zmm30                        #562.54
        shll      $6, %r15d                                     #529.39
        negl      %r15d                                         #529.39
        addl      %r11d, %r15d                                  #529.39
        vmulpd    %zmm30, %zmm24, %zmm29                        #562.36
        lea       255(%r15,%r14), %r15d                         #529.39
        kmovb     %r15d, %k1                                    #529.39
        kmovw     %k6, %r15d                                    #547.67
        kmovb     %k1, %r14d                                    #529.39
        kmovb     %r14d, %k1                                    #547.41
        kmovb     %r15d, %k6                                    #547.41
        movl      %r11d, %r15d                                  #530.39
        kandb     %k6, %k1, %k1                                 #547.41
        kmovb     %k1, %r14d                                    #547.41
        kmovw     %r14d, %k1                                    #569.33
        lea       (,%r12,8), %r14d                              #530.39
        vmulpd    %zmm29, %zmm2, %zmm2{%k1}{z}                  #569.33
        negl      %r14d                                         #530.39
        vmulpd    %zmm29, %zmm3, %zmm3{%k1}{z}                  #570.33
        vmulpd    %zmm29, %zmm4, %zmm30{%k1}{z}                 #571.33
        vaddpd    %zmm2, %zmm28, %zmm29                         #599.83
        vaddpd    %zmm3, %zmm0, %zmm28                          #600.83
        vaddpd    1024(%rsp), %zmm2, %zmm4                      #582.20[spill]
        vaddpd    %zmm20, %zmm3, %zmm20                         #583.20
        vaddpd    %zmm19, %zmm30, %zmm19                        #584.20
        vaddpd    %zmm30, %zmm31, %zmm31                        #601.83
        vmulpd    %zmm13, %zmm7, %zmm0                          #558.67
        vmovups   %zmm4, 1024(%rsp)                             #582.20[spill]
        vmulpd    %zmm0, %zmm7, %zmm1                           #558.51
        vmulpd    %zmm1, %zmm7, %zmm2                           #558.35
        addl      %r12d, %r14d                                  #530.39
        vfmsub213pd %zmm23, %zmm7, %zmm1                        #563.79
        vmulpd    %zmm11, %zmm7, %zmm7                          #563.105
        vmulpd    %zmm7, %zmm1, %zmm3                           #563.70
        vmulpd    %zmm3, %zmm2, %zmm4                           #563.54
        vmulpd    %zmm13, %zmm10, %zmm2                         #559.67
        vmulpd    %zmm4, %zmm24, %zmm5                          #563.36
        vmulpd    %zmm2, %zmm10, %zmm3                          #559.51
        shll      $7, %r15d                                     #530.39
        negl      %r15d                                         #530.39
        addl      %r11d, %r15d                                  #530.39
        vmulpd    %zmm3, %zmm10, %zmm4                          #559.35
        vfmsub213pd %zmm23, %zmm10, %zmm3                       #564.79
        vmulpd    %zmm11, %zmm10, %zmm10                        #564.105
        lea       255(%r15,%r14), %r15d                         #530.39
        kmovb     %r15d, %k6                                    #530.39
        kmovw     %k7, %r15d                                    #548.67
        kmovb     %k6, %r14d                                    #530.39
        kmovb     %r14d, %k6                                    #548.41
        kmovb     %r15d, %k7                                    #548.41
        movl      %r12d, %r15d                                  #531.39
        kandb     %k7, %k6, %k7                                 #548.41
        kmovb     %k7, %r14d                                    #548.41
        kmovw     %r14d, %k7                                    #572.33
        movl      %r11d, %r14d                                  #531.39
        vmulpd    %zmm5, %zmm6, %zmm6{%k7}{z}                   #572.33
        vmulpd    %zmm5, %zmm9, %zmm0{%k7}{z}                   #573.33
        vmulpd    %zmm5, %zmm8, %zmm1{%k7}{z}                   #574.33
        vmulpd    %zmm10, %zmm3, %zmm5                          #564.70
        vaddpd    %zmm18, %zmm6, %zmm18                         #585.20
        vaddpd    %zmm29, %zmm6, %zmm30                         #599.89
        vaddpd    %zmm28, %zmm0, %zmm29                         #600.89
        vaddpd    %zmm31, %zmm1, %zmm28                         #601.89
        vaddpd    %zmm17, %zmm0, %zmm17                         #586.20
        vaddpd    %zmm25, %zmm1, %zmm25                         #587.20
        vmulpd    %zmm5, %zmm4, %zmm6                           #564.54
        shll      $4, %r15d                                     #531.39
        shll      $8, %r14d                                     #531.39
        subl      %r15d, %r12d                                  #531.39
        subl      %r14d, %r11d                                  #531.39
        vmulpd    %zmm6, %zmm24, %zmm7                          #564.36
        lea       255(%r11,%r12), %r12d                         #531.39
        kmovb     %r12d, %k6                                    #531.39
        kmovw     %k0, %r12d                                    #549.67
        kmovb     %k6, %r11d                                    #531.39
        kmovb     %r11d, %k6                                    #549.41
        kmovb     %r12d, %k0                                    #549.41
        kandb     %k0, %k6, %k0                                 #549.41
        kmovb     %k0, %r14d                                    #549.41
        kmovw     %r14d, %k6                                    #575.33
        vmulpd    %zmm7, %zmm12, %zmm8{%k6}{z}                  #575.33
        vmulpd    %zmm7, %zmm14, %zmm11{%k6}{z}                 #577.33
        vmulpd    %zmm7, %zmm15, %zmm9{%k6}{z}                  #576.33
        vmovups   64(%r13,%rcx), %zmm14                         #600.44
        vaddpd    %zmm30, %zmm8, %zmm12                         #599.95
        vaddpd    %zmm28, %zmm11, %zmm31                        #601.95
        vaddpd    %zmm29, %zmm9, %zmm15                         #600.95
        vaddpd    %zmm26, %zmm8, %zmm26                         #588.20
        vaddpd    %zmm27, %zmm9, %zmm27                         #589.20
        vsubpd    %zmm15, %zmm14, %zmm29                        #600.95
        vaddpd    %zmm16, %zmm11, %zmm16                        #590.20
        vmovups   (%r13,%rcx), %zmm28                           #599.44
        vmovups   128(%r13,%rcx), %zmm30                        #601.44
        vmovups   %zmm29, 64(%r13,%rcx)                         #600.13
        vsubpd    %zmm12, %zmm28, %zmm13                        #599.95
        vsubpd    %zmm31, %zmm30, %zmm0                         #601.95
        vmovups   %zmm13, (%r13,%rcx)                           #599.13
        vmovups   %zmm0, 128(%r13,%rcx)                         #601.13
        cmpq      %rdx, %r8                                     #498.28
        jge       ..B6.31       # Prob 18%                      #498.28
                                # LOE rax rdx rbx rsi rdi r8 r9 r10d zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 k2 k3 k4
..B6.43:                        # Preds ..B6.30
                                # Execution count [2.05e+01]
        movq      176(%rbx), %rcx                               #447.27
        movq      160(%rbx), %r11                               #468.27
        jmp       ..B6.30       # Prob 100%                     #468.27
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11 r10d zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 k2 k3 k4
..B6.31:                        # Preds ..B6.30
                                # Execution count [4.50e+00]
        vmovups   1024(%rsp), %zmm0                             #[spill]
        vmovups   1088(%rsp), %zmm2                             #[spill]
        vmovsd    .L_2il0floatpacket.2(%rip), %xmm3             #
        movq      80(%rsp), %r13                                #[spill]
        movq      72(%rsp), %r14                                #[spill]
        vpxord    %zmm1, %zmm1, %zmm1                           #
                                # LOE rax rdx rbx rsi r9 r13 r14 r10d xmm3 zmm0 zmm1 zmm2 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 k2 k3 k4
..B6.32:                        # Preds ..B6.31 ..B6.28
                                # Execution count [5.00e+00]
        vpermilpd $85, %zmm21, %zmm8                            #606.9
        incl      %r10d                                         #462.49
        vaddpd    %zmm21, %zmm8, %zmm9                          #606.9
        incq      %r9                                           #462.49
        vpermilpd $85, %zmm17, %zmm21                           #606.9
        vpermilpd $85, %zmm22, %zmm28                           #605.9
        vaddpd    %zmm17, %zmm21, %zmm10                        #606.9
        vaddpd    %zmm22, %zmm28, %zmm30                        #605.9
        vpermilpd $85, %zmm20, %zmm17                           #606.9
        vaddpd    %zmm17, %zmm20, %zmm9{%k3}                    #606.9
        vpermilpd $85, %zmm2, %zmm17                            #607.9
        vpermilpd $85, %zmm18, %zmm22                           #605.9
        vaddpd    %zmm2, %zmm17, %zmm17                         #607.9
        vaddpd    %zmm18, %zmm22, %zmm31                        #605.9
        vxorpd    %xmm22, %xmm22, %xmm22                        #611.9
        vpermilpd $85, %zmm0, %zmm18                            #605.9
        vpermilpd $85, %zmm25, %zmm2                            #607.9
        vaddpd    %zmm18, %zmm0, %zmm30{%k3}                    #605.9
        vaddpd    %zmm25, %zmm2, %zmm18                         #607.9
        vpermilpd $85, %zmm19, %zmm25                           #607.9
        vaddpd    %zmm25, %zmm19, %zmm17{%k3}                   #607.9
        vpermilpd $85, %zmm26, %zmm29                           #605.9
        vpermilpd $85, %zmm27, %zmm20                           #606.9
        vpermilpd $85, %zmm16, %zmm19                           #607.9
        vaddpd    %zmm29, %zmm26, %zmm31{%k3}                   #605.9
        valignd   $8, %zmm30, %zmm30, %zmm26                    #605.9
        vaddpd    %zmm20, %zmm27, %zmm10{%k3}                   #606.9
        valignd   $8, %zmm9, %zmm9, %zmm27                      #606.9
        vaddpd    %zmm19, %zmm16, %zmm18{%k3}                   #607.9
        valignd   $8, %zmm17, %zmm17, %zmm16                    #607.9
        vaddpd    %zmm26, %zmm30, %zmm4                         #605.9
        valignd   $8, %zmm31, %zmm31, %zmm0                     #605.9
        vaddpd    %zmm27, %zmm9, %zmm12                         #606.9
        valignd   $8, %zmm10, %zmm10, %zmm11                    #606.9
        vaddpd    %zmm16, %zmm17, %zmm17                        #607.9
        valignd   $8, %zmm18, %zmm18, %zmm16                    #607.9
        vaddpd    %zmm0, %zmm31, %zmm4{%k4}                     #605.9
        vaddpd    %zmm11, %zmm10, %zmm12{%k4}                   #606.9
        vaddpd    %zmm16, %zmm18, %zmm17{%k4}                   #607.9
        vshuff64x2 $177, %zmm4, %zmm4, %zmm5                    #605.9
        vshuff64x2 $177, %zmm12, %zmm12, %zmm13                 #606.9
        vshuff64x2 $177, %zmm17, %zmm17, %zmm19                 #607.9
        vaddpd    %zmm5, %zmm4, %zmm6                           #605.9
        vaddpd    %zmm13, %zmm12, %zmm14                        #606.9
        vaddpd    %zmm19, %zmm17, %zmm20                        #607.9
        vshuff64x2 $238, %zmm6, %zmm6, %zmm6{%k2}               #605.9
        vshuff64x2 $238, %zmm14, %zmm14, %zmm14{%k2}            #606.9
        vshuff64x2 $238, %zmm20, %zmm20, %zmm20{%k2}            #607.9
        vaddpd    (%rsi,%rax,8), %ymm6, %ymm7                   #605.9
        vaddpd    64(%rsi,%rax,8), %ymm14, %ymm15               #606.9
        vaddpd    128(%rsi,%rax,8), %ymm20, %ymm21              #607.9
        vmovupd   %ymm7, (%rsi,%rax,8)                          #605.9
        vmovupd   %ymm15, 64(%rsi,%rax,8)                       #606.9
        vmovupd   %ymm21, 128(%rsi,%rax,8)                      #607.9
        addq      %rdx, 8(%r14)                                 #610.9
        vcvtsi2sd %edx, %xmm22, %xmm22                          #611.9
        vmulsd    %xmm22, %xmm3, %xmm0                          #611.9
        vcvttsd2si %xmm0, %rax                                  #611.9
        incq      (%r14)                                        #609.9
        addq      %rax, 16(%r14)                                #611.9
        cmpl      20(%rbx), %r10d                               #462.26
        jl        ..B6.28       # Prob 82%                      #462.26
                                # LOE rbx r9 r13 r14 r10d xmm3 zmm1 zmm23 zmm24 k2 k3 k4
..B6.34:                        # Preds ..B6.32 ..B6.26
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.1, %edi                         #614.5
        vzeroupper                                              #614.5
..___tag_value_computeForceLJ_4xn_half.317:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #614.5
..___tag_value_computeForceLJ_4xn_half.318:
                                # LOE r12
..B6.35:                        # Preds ..B6.34
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #617.16
..___tag_value_computeForceLJ_4xn_half.319:
#       getTimeStamp()
        call      getTimeStamp                                  #617.16
..___tag_value_computeForceLJ_4xn_half.320:
                                # LOE r12 xmm0
..B6.42:                        # Preds ..B6.35
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, (%rsp)                                 #617.16[spill]
                                # LOE r12
..B6.36:                        # Preds ..B6.42
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.6, %edi                         #618.5
        xorl      %eax, %eax                                    #618.5
..___tag_value_computeForceLJ_4xn_half.322:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #618.5
..___tag_value_computeForceLJ_4xn_half.323:
                                # LOE r12
..B6.37:                        # Preds ..B6.36
                                # Execution count [1.00e+00]
        vmovsd    (%rsp), %xmm0                                 #619.14[spill]
        vsubsd    64(%rsp), %xmm0, %xmm0                        #619.14[spill]
        addq      $1176, %rsp                                   #619.14
	.cfi_restore 3
        popq      %rbx                                          #619.14
	.cfi_restore 15
        popq      %r15                                          #619.14
	.cfi_restore 14
        popq      %r14                                          #619.14
	.cfi_restore 13
        popq      %r13                                          #619.14
	.cfi_restore 12
        popq      %r12                                          #619.14
        movq      %rbp, %rsp                                    #619.14
        popq      %rbp                                          #619.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #619.14
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B6.38:                        # Preds ..B6.5
                                # Execution count [4.50e-01]: Infreq
        xorl      %r10d, %r10d                                  #448.9
        jmp       ..B6.18       # Prob 100%                     #448.9
        .align    16,0x90
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
	.cfi_endproc
# mark_end;
	.type	computeForceLJ_4xn_half,@function
	.size	computeForceLJ_4xn_half,.-computeForceLJ_4xn_half
..LNcomputeForceLJ_4xn_half.5:
	.data
# -- End  computeForceLJ_4xn_half
	.text
.L_2__routine_start_computeForceLJ_4xn_full_6:
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
..B7.1:                         # Preds ..B7.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForceLJ_4xn_full.341:
..L342:
                                                        #622.96
        pushq     %rbp                                          #622.96
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #622.96
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #622.96
        pushq     %r12                                          #622.96
        pushq     %r13                                          #622.96
        pushq     %r14                                          #622.96
        pushq     %r15                                          #622.96
        pushq     %rbx                                          #622.96
        subq      $1176, %rsp                                   #622.96
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
        movq      %rdi, %r15                                    #622.96
        movl      $.L_2__STRING.5, %edi                         #623.5
        xorl      %eax, %eax                                    #623.5
        movq      %rcx, %r13                                    #622.96
        movq      %rdx, %r14                                    #622.96
        movq      %rsi, %rbx                                    #622.96
..___tag_value_computeForceLJ_4xn_full.351:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #623.5
..___tag_value_computeForceLJ_4xn_full.352:
                                # LOE rbx r12 r13 r14 r15
..B7.2:                         # Preds ..B7.1
                                # Execution count [1.00e+00]
        vmovsd    144(%r15), %xmm0                              #626.27
        xorl      %ecx, %ecx                                    #635.5
        vmulsd    %xmm0, %xmm0, %xmm1                           #629.36
        xorl      %esi, %esi                                    #637.27
        vbroadcastsd 56(%r15), %zmm3                            #630.32
        vbroadcastsd 40(%r15), %zmm4                            #631.29
        vbroadcastsd %xmm1, %zmm2                               #629.36
        vmovups   %zmm3, 64(%rsp)                               #630.32[spill]
        vmovups   %zmm4, 128(%rsp)                              #631.29[spill]
        vmovups   %zmm2, 192(%rsp)                              #629.36[spill]
        movl      20(%rbx), %edx                                #635.26
        testl     %edx, %edx                                    #635.26
        jle       ..B7.24       # Prob 9%                       #635.26
                                # LOE rbx rsi r12 r13 r14 edx ecx
..B7.3:                         # Preds ..B7.2
                                # Execution count [9.00e-01]
        movq      176(%rbx), %rdi                               #637.27
        movq      192(%rbx), %rax                               #638.32
        vxorpd    %ymm2, %ymm2, %ymm2                           #639.39
        vmovdqu   .L_2il0floatpacket.0(%rip), %xmm1             #638.9
        vmovdqu   .L_2il0floatpacket.1(%rip), %xmm0             #638.9
                                # LOE rax rbx rsi rdi r13 r14 edx ecx xmm0 xmm1 ymm2
..B7.4:                         # Preds ..B7.22 ..B7.3
                                # Execution count [5.00e+00]
        movl      %ecx, %r8d                                    #636.27
        movl      %ecx, %r9d                                    #636.27
        sarl      $1, %r8d                                      #636.27
        andl      $1, %r9d                                      #636.27
        shll      $2, %r9d                                      #636.27
        lea       (%r8,%r8,2), %r10d                            #636.27
        lea       (%r9,%r10,8), %r11d                           #636.27
        movslq    %r11d, %r11                                   #637.27
        lea       (%rdi,%r11,8), %r12                           #637.27
        movl      (%rsi,%rax), %r11d                            #638.32
        testl     %r11d, %r11d                                  #638.32
        jle       ..B7.22       # Prob 50%                      #638.32
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r11d xmm0 xmm1 ymm2
..B7.5:                         # Preds ..B7.4
                                # Execution count [4.50e+00]
        cmpl      $16, %r11d                                    #638.9
        jl        ..B7.38       # Prob 10%                      #638.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r11d xmm0 xmm1 ymm2
..B7.6:                         # Preds ..B7.5
                                # Execution count [4.50e+00]
        lea       128(%r12), %r8                                #641.13
        andq      $63, %r8                                      #638.9
        testl     $7, %r8d                                      #638.9
        je        ..B7.8        # Prob 50%                      #638.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B7.7:                         # Preds ..B7.6
                                # Execution count [2.25e+00]
        xorl      %r8d, %r8d                                    #638.9
        jmp       ..B7.10       # Prob 100%                     #638.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B7.8:                         # Preds ..B7.6
                                # Execution count [2.25e+00]
        testl     %r8d, %r8d                                    #638.9
        je        ..B7.10       # Prob 50%                      #638.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B7.9:                         # Preds ..B7.8
                                # Execution count [2.50e+01]
        negl      %r8d                                          #638.9
        addl      $64, %r8d                                     #638.9
        shrl      $3, %r8d                                      #638.9
        cmpl      %r8d, %r11d                                   #638.9
        cmovl     %r11d, %r8d                                   #638.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r11d xmm0 xmm1 ymm2
..B7.10:                        # Preds ..B7.7 ..B7.9 ..B7.8
                                # Execution count [5.00e+00]
        movl      %r11d, %r10d                                  #638.9
        subl      %r8d, %r10d                                   #638.9
        andl      $15, %r10d                                    #638.9
        negl      %r10d                                         #638.9
        addl      %r11d, %r10d                                  #638.9
        cmpl      $1, %r8d                                      #638.9
        jb        ..B7.14       # Prob 50%                      #638.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r10d r11d xmm0 xmm1 ymm2
..B7.11:                        # Preds ..B7.10
                                # Execution count [4.50e+00]
        vpbroadcastd %r8d, %xmm3                                #638.9
        xorl      %r15d, %r15d                                  #638.9
        vmovdqa   %xmm0, %xmm4                                  #638.9
        movslq    %r8d, %r9                                     #638.9
                                # LOE rax rbx rsi rdi r9 r12 r13 r14 r15 edx ecx r8d r10d r11d xmm0 xmm1 xmm3 xmm4 ymm2
..B7.12:                        # Preds ..B7.12 ..B7.11
                                # Execution count [2.50e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #638.9
        vpaddd    %xmm1, %xmm4, %xmm4                           #638.9
        vmovupd   %ymm2, (%r12,%r15,8){%k1}                     #639.13
        vmovupd   %ymm2, 64(%r12,%r15,8){%k1}                   #640.13
        vmovupd   %ymm2, 128(%r12,%r15,8){%k1}                  #641.13
        addq      $4, %r15                                      #638.9
        cmpq      %r9, %r15                                     #638.9
        jb        ..B7.12       # Prob 82%                      #638.9
                                # LOE rax rbx rsi rdi r9 r12 r13 r14 r15 edx ecx r8d r10d r11d xmm0 xmm1 xmm3 xmm4 ymm2
..B7.13:                        # Preds ..B7.12
                                # Execution count [4.50e+00]
        cmpl      %r8d, %r11d                                   #638.9
        je        ..B7.22       # Prob 10%                      #638.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r10d r11d xmm0 xmm1 ymm2
..B7.14:                        # Preds ..B7.10 ..B7.13
                                # Execution count [2.50e+01]
        lea       16(%r8), %r9d                                 #638.9
        cmpl      %r9d, %r10d                                   #638.9
        jl        ..B7.18       # Prob 50%                      #638.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r8d r10d r11d xmm0 xmm1 ymm2
..B7.15:                        # Preds ..B7.14
                                # Execution count [4.50e+00]
        movslq    %r8d, %r8                                     #638.9
        movslq    %r10d, %r9                                    #638.9
        .align    16,0x90
                                # LOE rax rbx rsi rdi r8 r9 r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
..B7.16:                        # Preds ..B7.16 ..B7.15
                                # Execution count [2.50e+01]
        vmovupd   %ymm2, (%r12,%r8,8)                           #639.13
        vmovupd   %ymm2, 32(%r12,%r8,8)                         #639.13
        vmovupd   %ymm2, 64(%r12,%r8,8)                         #639.13
        vmovupd   %ymm2, 128(%r12,%r8,8)                        #640.13
        vmovupd   %ymm2, 192(%r12,%r8,8)                        #641.13
        vmovupd   %ymm2, 96(%r12,%r8,8)                         #639.13
        vmovupd   %ymm2, 160(%r12,%r8,8)                        #640.13
        vmovupd   %ymm2, 224(%r12,%r8,8)                        #641.13
        addq      $16, %r8                                      #638.9
        cmpq      %r9, %r8                                      #638.9
        jb        ..B7.16       # Prob 82%                      #638.9
                                # LOE rax rbx rsi rdi r8 r9 r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
..B7.18:                        # Preds ..B7.16 ..B7.14 ..B7.38
                                # Execution count [5.00e+00]
        lea       1(%r10), %r8d                                 #638.9
        cmpl      %r11d, %r8d                                   #638.9
        ja        ..B7.22       # Prob 50%                      #638.9
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
..B7.19:                        # Preds ..B7.18
                                # Execution count [4.50e+00]
        movslq    %r10d, %r9                                    #639.13
        negl      %r10d                                         #638.9
        addl      %r11d, %r10d                                  #638.9
        xorl      %r8d, %r8d                                    #638.9
        movslq    %r11d, %r11                                   #638.9
        vmovdqa   %xmm0, %xmm4                                  #638.9
        vpbroadcastd %r10d, %xmm3                               #638.9
        subq      %r9, %r11                                     #638.9
        lea       (%r12,%r9,8), %r12                            #639.13
                                # LOE rax rbx rsi rdi r8 r11 r12 r13 r14 edx ecx xmm0 xmm1 xmm3 xmm4 ymm2
..B7.20:                        # Preds ..B7.20 ..B7.19
                                # Execution count [2.50e+01]
        vpcmpgtd  %xmm4, %xmm3, %k1                             #638.9
        vpaddd    %xmm1, %xmm4, %xmm4                           #638.9
        vmovupd   %ymm2, (%r12,%r8,8){%k1}                      #639.13
        vmovupd   %ymm2, 64(%r12,%r8,8){%k1}                    #640.13
        vmovupd   %ymm2, 128(%r12,%r8,8){%k1}                   #641.13
        addq      $4, %r8                                       #638.9
        cmpq      %r11, %r8                                     #638.9
        jb        ..B7.20       # Prob 82%                      #638.9
                                # LOE rax rbx rsi rdi r8 r11 r12 r13 r14 edx ecx xmm0 xmm1 xmm3 xmm4 ymm2
..B7.22:                        # Preds ..B7.20 ..B7.4 ..B7.13 ..B7.18
                                # Execution count [5.00e+00]
        incl      %ecx                                          #635.5
        addq      $56, %rsi                                     #635.5
        cmpl      %edx, %ecx                                    #635.5
        jb        ..B7.4        # Prob 82%                      #635.5
                                # LOE rax rbx rsi rdi r13 r14 edx ecx xmm0 xmm1 ymm2
..B7.24:                        # Preds ..B7.22 ..B7.2
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #645.16
        vzeroupper                                              #645.16
..___tag_value_computeForceLJ_4xn_full.356:
#       getTimeStamp()
        call      getTimeStamp                                  #645.16
..___tag_value_computeForceLJ_4xn_full.357:
                                # LOE rbx r12 r13 r14 xmm0
..B7.41:                        # Preds ..B7.24
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, (%rsp)                                 #645.16[spill]
                                # LOE rbx r12 r13 r14
..B7.25:                        # Preds ..B7.41
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.1, %edi                         #649.5
..___tag_value_computeForceLJ_4xn_full.359:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #649.5
..___tag_value_computeForceLJ_4xn_full.360:
                                # LOE rbx r12 r13 r14
..B7.26:                        # Preds ..B7.25
                                # Execution count [1.00e+00]
        xorl      %r11d, %r11d                                  #652.16
        xorl      %r15d, %r15d                                  #652.16
        cmpl      $0, 20(%rbx)                                  #652.26
        jle       ..B7.34       # Prob 10%                      #652.26
                                # LOE rbx r12 r13 r14 r15 r11d
..B7.27:                        # Preds ..B7.26
                                # Execution count [9.00e-01]
        movl      $65450, %eax                                  #769.9
        kmovw     %eax, %k3                                     #769.9
        movl      $65520, %eax                                  #769.9
        kmovw     %eax, %k4                                     #769.9
        vbroadcastsd .L_2il0floatpacket.2(%rip), %zmm1          #769.9
        vbroadcastsd .L_2il0floatpacket.3(%rip), %zmm10         #769.9
        movl      $12, %eax                                     #769.9
        kmovw     %eax, %k2                                     #769.9
        vpxord    %zmm13, %zmm13, %zmm13                        #675.30
                                # LOE rbx r13 r14 r15 r11d zmm1 zmm10 zmm13 k2 k3 k4
..B7.28:                        # Preds ..B7.32 ..B7.27
                                # Execution count [5.00e+00]
        vmovaps   %zmm13, %zmm26                                #675.30
        movl      %r11d, %ecx                                   #657.27
        vmovaps   %zmm26, %zmm12                                #676.30
        movl      %r11d, %r9d                                   #657.27
        vmovaps   %zmm12, %zmm9                                 #677.30
        andl      $1, %r9d                                      #657.27
        sarl      $1, %ecx                                      #657.27
        vmovaps   %zmm9, %zmm8                                  #678.30
        shll      $2, %r9d                                      #657.27
        movl      16(%r14), %eax                                #660.44
        imull     %r11d, %eax                                   #660.44
        lea       (%rcx,%rcx,2), %r10d                          #657.27
        vmovaps   %zmm8, %zmm7                                  #679.30
        lea       (%r9,%r10,8), %ecx                            #657.27
        vmovaps   %zmm7, %zmm6                                  #680.30
        vmovaps   %zmm6, %zmm5                                  #681.30
        vmovaps   %zmm5, %zmm4                                  #682.30
        movslq    %ecx, %rcx                                    #657.27
        movslq    %eax, %rax                                    #660.19
        movq      24(%r14), %rsi                                #661.25
        vmovaps   %zmm4, %zmm11                                 #683.30
        movq      8(%r14), %rdx                                 #660.19
        movq      160(%rbx), %r8                                #658.27
        vmovaps   %zmm11, %zmm3                                 #684.30
        vmovaps   %zmm3, %zmm2                                  #685.30
        lea       (%rdx,%rax,4), %r10                           #660.19
        movslq    (%rsi,%r15,4), %rdi                           #661.25
        xorl      %esi, %esi                                    #688.19
        vmovaps   %zmm2, %zmm0                                  #686.30
        vbroadcastsd (%r8,%rcx,8), %zmm25                       #663.33
        vbroadcastsd 8(%r8,%rcx,8), %zmm24                      #664.33
        vbroadcastsd 16(%r8,%rcx,8), %zmm23                     #665.33
        vbroadcastsd 24(%r8,%rcx,8), %zmm22                     #666.33
        vbroadcastsd 64(%r8,%rcx,8), %zmm21                     #667.33
        vbroadcastsd 72(%r8,%rcx,8), %zmm20                     #668.33
        vbroadcastsd 80(%r8,%rcx,8), %zmm19                     #669.33
        vbroadcastsd 88(%r8,%rcx,8), %zmm18                     #670.33
        vbroadcastsd 128(%r8,%rcx,8), %zmm17                    #671.33
        vbroadcastsd 136(%r8,%rcx,8), %zmm16                    #672.33
        vbroadcastsd 144(%r8,%rcx,8), %zmm15                    #673.33
        vbroadcastsd 152(%r8,%rcx,8), %zmm14                    #674.33
        movq      176(%rbx), %r9                                #659.27
        testq     %rdi, %rdi                                    #688.28
        jle       ..B7.32       # Prob 10%                      #688.28
                                # LOE rcx rbx rsi rdi r8 r9 r10 r13 r14 r15 r11d zmm0 zmm1 zmm2 zmm3 zmm4 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 k2 k3 k4
..B7.29:                        # Preds ..B7.28
                                # Execution count [4.50e+00]
        vmovups   %zmm12, 1088(%rsp)                            #[spill]
        vmovups   %zmm26, 1024(%rsp)                            #[spill]
        vmovups   %zmm14, 768(%rsp)                             #[spill]
        vmovups   %zmm15, 960(%rsp)                             #[spill]
        vmovups   %zmm16, 832(%rsp)                             #[spill]
        vmovups   %zmm17, 896(%rsp)                             #[spill]
        vmovups   %zmm18, 320(%rsp)                             #[spill]
        vmovups   %zmm19, 704(%rsp)                             #[spill]
        vmovups   %zmm20, 384(%rsp)                             #[spill]
        vmovups   %zmm21, 512(%rsp)                             #[spill]
        vmovups   %zmm22, 640(%rsp)                             #[spill]
        vmovups   %zmm23, 448(%rsp)                             #[spill]
        vmovups   %zmm24, 576(%rsp)                             #[spill]
        vmovups   %zmm25, 256(%rsp)                             #[spill]
        movq      %r13, 8(%rsp)                                 #[spill]
                                # LOE rcx rbx rsi rdi r8 r9 r10 r14 r15 r11d zmm0 zmm1 zmm2 zmm3 zmm4 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm11 k2 k3 k4
movl      $111, %ebx # OSACA START MARKER
.byte     100        # OSACA START MARKER
.byte     103        # OSACA START MARKER
.byte     144        # OSACA START MARKER
# pointer_increment=64 682a899d0c46457e098cba76bedab789
# LLVM-MCA-BEGIN
..B7.30:                        # Preds ..B7.30 ..B7.29
                                # Execution count [2.50e+01]
        movl      (%r10,%rsi,4), %edx                           #689.22
        incq      %rsi                                          #688.39
        vmovups   896(%rsp), %zmm20                             #697.35[spill]
        vmovups   832(%rsp), %zmm25                             #700.35[spill]
        vmovups   448(%rsp), %zmm24                             #701.35[spill]
        vmovups   704(%rsp), %zmm23                             #702.35[spill]
        vmovups   960(%rsp), %zmm16                             #703.35[spill]
        vmovups   768(%rsp), %zmm14                             #706.35[spill]
        vmovups   576(%rsp), %zmm15                             #698.35[spill]
        vmovups   384(%rsp), %zmm12                             #699.35[spill]
        vmovups   512(%rsp), %zmm21                             #696.35[spill]
        vmovups   320(%rsp), %zmm18                             #705.35[spill]
        vmovups   256(%rsp), %zmm22                             #695.35[spill]
        vmovups   640(%rsp), %zmm17                             #704.35[spill]
        lea       (%rdx,%rdx,2), %r12d                          #690.31
        shll      $3, %r12d                                     #690.31
        lea       (%rdx,%rdx), %r13d                            #715.56
        movslq    %r12d, %r12                                   #691.31
        cmpl      %r11d, %r13d                                  #715.66
        lea       1(%rdx,%rdx), %eax                            #716.61
        movl      $0, %edx                                      #715.66
        sete      %dl                                           #715.66
        cmpl      %r11d, %eax                                   #716.66
        movl      $0, %eax                                      #716.66
        movl      %edx, %r13d                                   #717.39
        vsubpd    128(%r8,%r12,8), %zmm20, %zmm29               #697.35
        sete      %al                                           #716.66
        vsubpd    128(%r8,%r12,8), %zmm25, %zmm26               #700.35
        vsubpd    (%r8,%r12,8), %zmm24, %zmm25                  #701.35
        vsubpd    64(%r8,%r12,8), %zmm23, %zmm24                #702.35
        vsubpd    128(%r8,%r12,8), %zmm16, %zmm23               #703.35
        vsubpd    128(%r8,%r12,8), %zmm14, %zmm20               #706.35
        vsubpd    64(%r8,%r12,8), %zmm12, %zmm27                #699.35
        vsubpd    (%r8,%r12,8), %zmm15, %zmm28                  #698.35
        vsubpd    64(%r8,%r12,8), %zmm21, %zmm30                #696.35
        vsubpd    64(%r8,%r12,8), %zmm18, %zmm21                #705.35
        vsubpd    (%r8,%r12,8), %zmm22, %zmm31                  #695.35
        vsubpd    (%r8,%r12,8), %zmm17, %zmm22                  #704.35
        vmulpd    %zmm29, %zmm29, %zmm13                        #730.80
        vmulpd    %zmm26, %zmm26, %zmm15                        #731.80
        vmulpd    %zmm23, %zmm23, %zmm12                        #732.80
        vmulpd    %zmm20, %zmm20, %zmm14                        #733.80
        vmovups   192(%rsp), %zmm16                             #735.67[spill]
        vfmadd231pd %zmm30, %zmm30, %zmm13                      #730.57
        vfmadd231pd %zmm27, %zmm27, %zmm15                      #731.57
        vfmadd231pd %zmm24, %zmm24, %zmm12                      #732.57
        vfmadd231pd %zmm21, %zmm21, %zmm14                      #733.57
        vfmadd231pd %zmm31, %zmm31, %zmm13                      #730.34
        vfmadd231pd %zmm28, %zmm28, %zmm15                      #731.34
        vfmadd231pd %zmm25, %zmm25, %zmm12                      #732.34
        vfmadd231pd %zmm22, %zmm22, %zmm14                      #733.34
        vrcp14pd  %zmm13, %zmm19                                #740.35
        vrcp14pd  %zmm15, %zmm18                                #741.35
        vrcp14pd  %zmm12, %zmm17                                #742.35
        vcmppd    $17, %zmm16, %zmm13, %k1                      #735.67
        vcmppd    $17, %zmm16, %zmm15, %k6                      #736.67
        vcmppd    $17, %zmm16, %zmm12, %k7                      #737.67
        vcmppd    $17, %zmm16, %zmm14, %k0                      #738.67
        vrcp14pd  %zmm14, %zmm15                                #743.35
        vmovups   64(%rsp), %zmm16                              #745.67[spill]
        vmovups   128(%rsp), %zmm12                             #750.105[spill]
        vmulpd    %zmm16, %zmm19, %zmm13                        #745.67
        vmulpd    %zmm13, %zmm19, %zmm13                        #745.51
        negl      %r13d                                         #717.39
        vmulpd    %zmm13, %zmm19, %zmm14                        #745.35
        movl      %eax, %r12d                                   #717.39
        vfmsub213pd %zmm1, %zmm19, %zmm13                       #750.79
        vmulpd    %zmm12, %zmm19, %zmm19                        #750.105
        vmulpd    %zmm19, %zmm13, %zmm13                        #750.70
        addl      $255, %r13d                                   #717.39
        vmulpd    %zmm13, %zmm14, %zmm14                        #750.54
        .byte     144                                           #755.20
        vmovups   1024(%rsp), %zmm13                            #755.20[spill]
        vmulpd    %zmm14, %zmm10, %zmm19                        #750.36
        shll      $4, %r12d                                     #717.39
        subl      %r12d, %r13d                                  #717.39
        kmovb     %r13d, %k5                                    #717.39
        kmovw     %k1, %r13d                                    #735.67
        kmovb     %k5, %r12d                                    #717.39
        kmovb     %r12d, %k5                                    #735.41
        kmovb     %r13d, %k1                                    #735.41
        movl      %eax, %r13d                                   #718.39
        kandb     %k1, %k5, %k5                                 #735.41
        kmovb     %k5, %r12d                                    #735.41
        kmovw     %r12d, %k5                                    #755.20
        lea       (%rdx,%rdx), %r12d                            #718.39
        vfmadd231pd %zmm29, %zmm19, %zmm9{%k5}                  #757.20
        negl      %r12d                                         #718.39
        vfmadd231pd %zmm31, %zmm19, %zmm13{%k5}                 #755.20
        vmovups   1088(%rsp), %zmm31                            #756.20[spill]
        vmulpd    %zmm16, %zmm18, %zmm29                        #746.67
        vfmadd231pd %zmm30, %zmm19, %zmm31{%k5}                 #756.20
        vmovups   %zmm13, 1024(%rsp)                            #755.20[spill]
        vmulpd    %zmm29, %zmm18, %zmm30                        #746.51
        vmovups   %zmm31, 1088(%rsp)                            #756.20[spill]
        vmulpd    %zmm30, %zmm18, %zmm13                        #746.35
        vfmsub213pd %zmm1, %zmm18, %zmm30                       #751.79
        vmulpd    %zmm12, %zmm18, %zmm18                        #751.105
        vmulpd    %zmm18, %zmm30, %zmm14                        #751.70
        addl      $255, %r12d                                   #718.39
        vmulpd    %zmm14, %zmm13, %zmm19                        #751.54
        vmulpd    %zmm19, %zmm10, %zmm29                        #751.36
        shll      $5, %r13d                                     #718.39
        subl      %r13d, %r12d                                  #718.39
        kmovb     %r12d, %k1                                    #718.39
        kmovw     %k6, %r12d                                    #736.67
        kmovb     %k1, %r13d                                    #718.39
        kmovb     %r13d, %k1                                    #736.41
        kmovb     %r12d, %k6                                    #736.41
        movl      %eax, %r12d                                   #719.39
        kandb     %k6, %k1, %k1                                 #736.41
        kmovb     %k1, %r13d                                    #736.41
        kmovw     %r13d, %k1                                    #758.20
        lea       (,%rdx,4), %r13d                              #719.39
        vfmadd231pd %zmm26, %zmm29, %zmm6{%k1}                  #760.20
        negl      %r13d                                         #719.39
        vfmadd231pd %zmm27, %zmm29, %zmm7{%k1}                  #759.20
        vfmadd231pd %zmm28, %zmm29, %zmm8{%k1}                  #758.20
        vmulpd    %zmm16, %zmm17, %zmm26                        #747.67
        vmulpd    %zmm12, %zmm17, %zmm28                        #752.105
        vmulpd    %zmm16, %zmm15, %zmm16                        #748.67
        vmulpd    %zmm12, %zmm15, %zmm12                        #753.105
        vmulpd    %zmm26, %zmm17, %zmm27                        #747.51
        vmulpd    %zmm16, %zmm15, %zmm19                        #748.51
        vmulpd    %zmm27, %zmm17, %zmm13                        #747.35
        vfmsub213pd %zmm1, %zmm17, %zmm27                       #752.79
        vmulpd    %zmm28, %zmm27, %zmm14                        #752.70
        addl      $255, %r13d                                   #719.39
        vmulpd    %zmm14, %zmm13, %zmm17                        #752.54
        shll      $3, %edx                                      #720.39
        shll      $6, %r12d                                     #719.39
        negl      %edx                                          #720.39
        vmulpd    %zmm17, %zmm10, %zmm18                        #752.36
        subl      %r12d, %r13d                                  #719.39
        kmovb     %r13d, %k6                                    #719.39
        addl      $255, %edx                                    #720.39
        shll      $7, %eax                                      #720.39
        subl      %eax, %edx                                    #720.39
        kmovb     %k6, %eax                                     #719.39
        kmovb     %eax, %k6                                     #737.41
        kmovw     %k7, %eax                                     #737.67
        kmovb     %eax, %k7                                     #737.41
        kandb     %k7, %k6, %k7                                 #737.41
        kmovb     %edx, %k6                                     #720.39
        kmovb     %k7, %edx                                     #737.41
        kmovw     %edx, %k7                                     #761.20
        kmovw     %k0, %edx                                     #738.67
        vfmadd231pd %zmm23, %zmm18, %zmm11{%k7}                 #763.20
        vfmadd231pd %zmm24, %zmm18, %zmm4{%k7}                  #762.20
        vfmadd231pd %zmm25, %zmm18, %zmm5{%k7}                  #761.20
        vmulpd    %zmm19, %zmm15, %zmm23                        #748.35
        vfmsub213pd %zmm1, %zmm15, %zmm19                       #753.79
        vmulpd    %zmm12, %zmm19, %zmm15                        #753.70
        vmulpd    %zmm15, %zmm23, %zmm24                        #753.54
        vmulpd    %zmm24, %zmm10, %zmm25                        #753.36
        kmovb     %k6, %eax                                     #720.39
        kmovb     %eax, %k6                                     #738.41
        kmovb     %edx, %k0                                     #738.41
        kandb     %k0, %k6, %k0                                 #738.41
        kmovb     %k0, %r12d                                    #738.41
        kmovw     %r12d, %k6                                    #764.20
        vfmadd231pd %zmm22, %zmm25, %zmm3{%k6}                  #764.20
        vfmadd231pd %zmm21, %zmm25, %zmm2{%k6}                  #765.20
        vfmadd231pd %zmm20, %zmm25, %zmm0{%k6}                  #766.20
        cmpq      %rdi, %rsi                                    #688.28
        jl        ..B7.30       # Prob 82%                      #688.28
# LLVM-MCA-END
movl      $222, %ebx # OSACA END MARKER
.byte     100        # OSACA END MARKER
.byte     103        # OSACA END MARKER
.byte     144        # OSACA END MARKER
                                # LOE rcx rbx rsi rdi r8 r9 r10 r14 r15 r11d zmm0 zmm1 zmm2 zmm3 zmm4 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm11 zmm31 k2 k3 k4
..B7.31:                        # Preds ..B7.30
                                # Execution count [4.50e+00]
        vmovaps   %zmm31, %zmm12                                #
        vmovups   1024(%rsp), %zmm26                            #[spill]
        movq      8(%rsp), %r13                                 #[spill]
        vpxord    %zmm13, %zmm13, %zmm13                        #
                                # LOE rcx rbx rdi r9 r13 r14 r15 r11d zmm0 zmm1 zmm2 zmm3 zmm4 zmm5 zmm6 zmm7 zmm8 zmm9 zmm10 zmm11 zmm12 zmm13 zmm26 k2 k3 k4
..B7.32:                        # Preds ..B7.31 ..B7.28
                                # Execution count [5.00e+00]
        vpermilpd $85, %zmm5, %zmm17                            #769.9
        incl      %r11d                                         #652.49
        vaddpd    %zmm5, %zmm17, %zmm22                         #769.9
        incq      %r15                                          #652.49
        vpermilpd $85, %zmm26, %zmm16                           #769.9
        vpermilpd $85, %zmm3, %zmm19                            #769.9
        vpermilpd $85, %zmm12, %zmm28                           #770.9
        vpermilpd $85, %zmm9, %zmm15                            #771.9
        vaddpd    %zmm26, %zmm16, %zmm20                        #769.9
        vaddpd    %zmm19, %zmm3, %zmm22{%k3}                    #769.9
        vaddpd    %zmm12, %zmm28, %zmm3                         #770.9
        vaddpd    %zmm9, %zmm15, %zmm16                         #771.9
        valignd   $8, %zmm22, %zmm22, %zmm23                    #769.9
        vpermilpd $85, %zmm11, %zmm9                            #771.9
        vpermilpd $85, %zmm8, %zmm18                            #769.9
        vpermilpd $85, %zmm4, %zmm29                            #770.9
        vpermilpd $85, %zmm7, %zmm30                            #770.9
        vaddpd    %zmm11, %zmm9, %zmm17                         #771.9
        vaddpd    %zmm18, %zmm8, %zmm20{%k3}                    #769.9
        vaddpd    %zmm4, %zmm29, %zmm4                          #770.9
        vaddpd    %zmm30, %zmm7, %zmm3{%k3}                     #770.9
        valignd   $8, %zmm20, %zmm20, %zmm21                    #769.9
        vpermilpd $85, %zmm6, %zmm11                            #771.9
        vaddpd    %zmm11, %zmm6, %zmm16{%k3}                    #771.9
        vaddpd    %zmm21, %zmm20, %zmm24                        #769.9
        vpermilpd $85, %zmm2, %zmm31                            #770.9
        vpermilpd $85, %zmm0, %zmm6                             #771.9
        vaddpd    %zmm31, %zmm2, %zmm4{%k3}                     #770.9
        valignd   $8, %zmm3, %zmm3, %zmm2                       #770.9
        vaddpd    %zmm6, %zmm0, %zmm17{%k3}                     #771.9
        valignd   $8, %zmm16, %zmm16, %zmm0                     #771.9
        vaddpd    %zmm2, %zmm3, %zmm7                           #770.9
        valignd   $8, %zmm4, %zmm4, %zmm5                       #770.9
        vaddpd    %zmm0, %zmm16, %zmm18                         #771.9
        vxorpd    %xmm0, %xmm0, %xmm0                           #775.9
        valignd   $8, %zmm17, %zmm17, %zmm16                    #771.9
        vaddpd    %zmm23, %zmm22, %zmm24{%k4}                   #769.9
        vaddpd    %zmm5, %zmm4, %zmm7{%k4}                      #770.9
        vaddpd    %zmm16, %zmm17, %zmm18{%k4}                   #771.9
        vshuff64x2 $177, %zmm24, %zmm24, %zmm25                 #769.9
        vshuff64x2 $177, %zmm7, %zmm7, %zmm8                    #770.9
        vshuff64x2 $177, %zmm18, %zmm18, %zmm19                 #771.9
        vaddpd    %zmm25, %zmm24, %zmm26                        #769.9
        vaddpd    %zmm8, %zmm7, %zmm12                          #770.9
        vaddpd    %zmm19, %zmm18, %zmm20                        #771.9
        vshuff64x2 $238, %zmm26, %zmm26, %zmm26{%k2}            #769.9
        vshuff64x2 $238, %zmm12, %zmm12, %zmm12{%k2}            #770.9
        vshuff64x2 $238, %zmm20, %zmm20, %zmm20{%k2}            #771.9
        vaddpd    (%r9,%rcx,8), %ymm26, %ymm27                  #769.9
        vaddpd    64(%r9,%rcx,8), %ymm12, %ymm14                #770.9
        vaddpd    128(%r9,%rcx,8), %ymm20, %ymm21               #771.9
        vmovupd   %ymm27, (%r9,%rcx,8)                          #769.9
        vmovupd   %ymm14, 64(%r9,%rcx,8)                        #770.9
        vmovupd   %ymm21, 128(%r9,%rcx,8)                       #771.9
        addq      %rdi, 8(%r13)                                 #774.9
        vcvtsi2sd %edi, %xmm0, %xmm0                            #775.9
        vcvttsd2si %xmm0, %rax                                  #775.9
        incq      (%r13)                                        #773.9
        addq      %rax, 16(%r13)                                #775.9
        cmpl      20(%rbx), %r11d                               #652.26
        jl        ..B7.28       # Prob 82%                      #652.26
                                # LOE rbx r13 r14 r15 r11d zmm1 zmm10 zmm13 k2 k3 k4
..B7.34:                        # Preds ..B7.32 ..B7.26
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.1, %edi                         #779.5
        vzeroupper                                              #779.5
..___tag_value_computeForceLJ_4xn_full.397:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #779.5
..___tag_value_computeForceLJ_4xn_full.398:
                                # LOE r12
..B7.35:                        # Preds ..B7.34
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #782.16
..___tag_value_computeForceLJ_4xn_full.399:
#       getTimeStamp()
        call      getTimeStamp                                  #782.16
..___tag_value_computeForceLJ_4xn_full.400:
                                # LOE r12 xmm0
..B7.42:                        # Preds ..B7.35
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 8(%rsp)                                #782.16[spill]
                                # LOE r12
..B7.36:                        # Preds ..B7.42
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.6, %edi                         #783.5
        xorl      %eax, %eax                                    #783.5
..___tag_value_computeForceLJ_4xn_full.402:
#       debug_printf(const char *, ...)
        call      debug_printf                                  #783.5
..___tag_value_computeForceLJ_4xn_full.403:
                                # LOE r12
..B7.37:                        # Preds ..B7.36
                                # Execution count [1.00e+00]
        vmovsd    8(%rsp), %xmm0                                #784.14[spill]
        vsubsd    (%rsp), %xmm0, %xmm0                          #784.14[spill]
        addq      $1176, %rsp                                   #784.14
	.cfi_restore 3
        popq      %rbx                                          #784.14
	.cfi_restore 15
        popq      %r15                                          #784.14
	.cfi_restore 14
        popq      %r14                                          #784.14
	.cfi_restore 13
        popq      %r13                                          #784.14
	.cfi_restore 12
        popq      %r12                                          #784.14
        movq      %rbp, %rsp                                    #784.14
        popq      %rbp                                          #784.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #784.14
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B7.38:                        # Preds ..B7.5
                                # Execution count [4.50e-01]: Infreq
        xorl      %r10d, %r10d                                  #638.9
        jmp       ..B7.18       # Prob 100%                     #638.9
        .align    16,0x90
                                # LOE rax rbx rsi rdi r12 r13 r14 edx ecx r10d r11d xmm0 xmm1 ymm2
	.cfi_endproc
# mark_end;
	.type	computeForceLJ_4xn_full,@function
	.size	computeForceLJ_4xn_full,.-computeForceLJ_4xn_full
..LNcomputeForceLJ_4xn_full.6:
	.data
# -- End  computeForceLJ_4xn_full
	.section .rodata, "a"
	.align 64
	.align 64
.L_2il0floatpacket.5:
	.long	0x00000008,0x00000009,0x0000000a,0x0000000b,0x0000000c,0x0000000d,0x0000000e,0x0000000f,0x00000008,0x00000009,0x0000000a,0x0000000b,0x0000000c,0x0000000d,0x0000000e,0x0000000f
	.type	.L_2il0floatpacket.5,@object
	.size	.L_2il0floatpacket.5,64
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
	.align 8
.L_2il0floatpacket.3:
	.long	0x00000000,0x40480000
	.type	.L_2il0floatpacket.3,@object
	.size	.L_2il0floatpacket.3,8
	.align 8
.L_2il0floatpacket.4:
	.long	0x00000000,0x3ff00000
	.type	.L_2il0floatpacket.4,@object
	.size	.L_2il0floatpacket.4,8
	.section .rodata.str1.4, "aMS",@progbits,1
	.align 4
	.align 4
.L_2__STRING.0:
	.long	1886220131
	.long	1181054069
	.long	1701016175
	.long	1646283340
	.long	1852401509
	.word	10
	.type	.L_2__STRING.0,@object
	.size	.L_2__STRING.0,22
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.1:
	.long	1668444006
	.word	101
	.type	.L_2__STRING.1,@object
	.size	.L_2__STRING.1,6
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.2:
	.long	1886220131
	.long	1181054069
	.long	1701016175
	.long	1696614988
	.long	681070
	.type	.L_2__STRING.2,@object
	.size	.L_2__STRING.2,20
	.align 4
.L_2__STRING.3:
	.long	1886220131
	.long	1181054069
	.long	1701016175
	.long	845105740
	.long	544108152
	.long	1768383842
	.word	2670
	.byte	0
	.type	.L_2__STRING.3,@object
	.size	.L_2__STRING.3,27
	.space 1, 0x00 	# pad
	.align 4
.L_2__STRING.4:
	.long	1886220131
	.long	1181054069
	.long	1701016175
	.long	845105740
	.long	544108152
	.long	174354021
	.byte	0
	.type	.L_2__STRING.4,@object
	.size	.L_2__STRING.4,25
	.space 3, 0x00 	# pad
	.align 4
.L_2__STRING.5:
	.long	1886220131
	.long	1181054069
	.long	1701016175
	.long	878660172
	.long	1646292600
	.long	1852401509
	.word	10
	.type	.L_2__STRING.5,@object
	.size	.L_2__STRING.5,26
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.6:
	.long	1886220131
	.long	1181054069
	.long	1701016175
	.long	878660172
	.long	1696624248
	.long	681070
	.type	.L_2__STRING.6,@object
	.size	.L_2__STRING.6,24
	.data
	.section .note.GNU-stack, ""
# End
