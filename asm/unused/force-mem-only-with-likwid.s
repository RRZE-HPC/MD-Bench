# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 19.0.5.281 Build 20190815";
# mark_description "-I/mnt/opt/likwid-5.1.1/include -I./src/includes -S -D_GNU_SOURCE -DLIKWID_PERFMON -DAOS -DPRECISION=2 -DNEI";
# mark_description "GHBORS_LOOP_RUNS=1 -DINDEX_TRACER -DVECTOR_WIDTH=8 -DALIGNMENT=64 -restrict -Ofast -xCORE-AVX512 -qopt-zmm-u";
# mark_description "sage=high -o ICC/force.s";
	.file "force.c"
	.text
..TXTST0:
.L_2__routine_start_computeForce_0:
# -- Begin  computeForce
	.text
# mark_begin;
       .align    16,0x90
	.globl computeForce
# --- computeForce(Parameter *, Atom *, Neighbor *, int, int, int)
computeForce:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %ecx
# parameter 5: %r8d
# parameter 6: %r9d
..B1.1:                         # Preds ..B1.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForce.1:
..L2:
                                                          #121.112
        pushq     %rbp                                          #121.112
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #121.112
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #121.112
        pushq     %r12                                          #121.112
        pushq     %r13                                          #121.112
        pushq     %r14                                          #121.112
        pushq     %r15                                          #121.112
        pushq     %rbx                                          #121.112
        subq      $536, %rsp                                    #121.112
        movl      %r8d, %eax                                    #123.5
        movq      %rdx, 384(%rsp)                               #121.112[spill]
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
        movq      %rsi, %r14                                    #121.112
        cltd                                                    #123.5
        idivl     %r9d                                          #123.5
        movl      %edx, %ebx                                    #123.5
        movq      %rdi, %r12                                    #121.112
        testl     %ebx, %ebx                                    #123.5
        jne       ..B1.5        # Prob 78%                      #123.5
                                # LOE r12 r13 r14 ebx r8d
..B1.2:                         # Preds ..B1.1
                                # Execution count [2.20e-01]
        movl      $128, %esi                                    #123.5
        lea       (%rsp), %rdi                                  #123.5
        movl      $.L_2__STRING.0, %edx                         #123.5
        movl      %r8d, %ecx                                    #123.5
        xorl      %eax, %eax                                    #123.5
#       snprintf(char *__restrict__, size_t, const char *__restrict__, ...)
        call      snprintf                                      #123.5
                                # LOE r12 r14 ebx
..B1.3:                         # Preds ..B1.2
                                # Execution count [2.20e-01]
        movl      $.L_2__STRING.1, %esi                         #123.5
        lea       (%rsp), %rdi                                  #123.5
#       fopen(const char *__restrict__, const char *__restrict__)
        call      fopen                                         #123.5
                                # LOE rax r12 r14 ebx
..B1.75:                        # Preds ..B1.3
                                # Execution count [2.20e-01]
        movq      %rax, %r13                                    #123.5
                                # LOE r12 r13 r14 ebx
..B1.5:                         # Preds ..B1.75 ..B1.1
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #124.16
..___tag_value_computeForce.12:
#       getTimeStamp()
        call      getTimeStamp                                  #124.16
..___tag_value_computeForce.13:
                                # LOE r12 r13 r14 ebx xmm0
..B1.76:                        # Preds ..B1.5
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 160(%rsp)                              #124.16[spill]
                                # LOE r12 r13 r14 ebx
..B1.6:                         # Preds ..B1.76
                                # Execution count [1.00e+00]
        movl      4(%r14), %edx                                 #125.18
        movq      64(%r14), %r15                                #127.20
        movq      72(%r14), %r10                                #127.45
        movq      80(%r14), %r9                                 #127.70
        vmovsd    72(%r12), %xmm2                               #129.27
        vmovsd    8(%r12), %xmm1                                #130.23
        vmovsd    (%r12), %xmm0                                 #131.24
        testl     %edx, %edx                                    #134.24
        jle       ..B1.15       # Prob 50%                      #134.24
                                # LOE r9 r10 r13 r14 r15 edx ebx xmm0 xmm1 xmm2
..B1.7:                         # Preds ..B1.6
                                # Execution count [1.00e+00]
        movl      %edx, %eax                                    #134.5
        xorl      %r8d, %r8d                                    #134.5
        movl      $1, %r11d                                     #134.5
        xorl      %esi, %esi                                    #134.5
        shrl      $1, %eax                                      #134.5
        je        ..B1.11       # Prob 9%                       #134.5
                                # LOE rax rsi r8 r9 r10 r13 r14 r15 edx ebx r11d xmm0 xmm1 xmm2
..B1.8:                         # Preds ..B1.7
                                # Execution count [9.00e-01]
        xorl      %r11d, %r11d                                  #134.5
                                # LOE rax rsi r8 r9 r10 r11 r13 r14 r15 edx ebx xmm0 xmm1 xmm2
..B1.9:                         # Preds ..B1.9 ..B1.8
                                # Execution count [2.50e+00]
        movq      %r11, (%rsi,%r15)                             #135.9
        incq      %r8                                           #134.5
        movq      %r11, (%rsi,%r10)                             #136.9
        movq      %r11, (%rsi,%r9)                              #137.9
        movq      %r11, 8(%rsi,%r15)                            #135.9
        movq      %r11, 8(%rsi,%r10)                            #136.9
        movq      %r11, 8(%rsi,%r9)                             #137.9
        addq      $16, %rsi                                     #134.5
        cmpq      %rax, %r8                                     #134.5
        jb        ..B1.9        # Prob 63%                      #134.5
                                # LOE rax rsi r8 r9 r10 r11 r13 r14 r15 edx ebx xmm0 xmm1 xmm2
..B1.10:                        # Preds ..B1.9
                                # Execution count [9.00e-01]
        lea       1(%r8,%r8), %r11d                             #135.9
                                # LOE r9 r10 r13 r14 r15 edx ebx r11d xmm0 xmm1 xmm2
..B1.11:                        # Preds ..B1.10 ..B1.7
                                # Execution count [1.00e+00]
        lea       -1(%r11), %eax                                #134.5
        cmpl      %edx, %eax                                    #134.5
        jae       ..B1.13       # Prob 9%                       #134.5
                                # LOE r9 r10 r13 r14 r15 edx ebx r11d xmm0 xmm1 xmm2
..B1.12:                        # Preds ..B1.11
                                # Execution count [9.00e-01]
        movslq    %r11d, %r11                                   #134.5
        xorl      %eax, %eax                                    #135.9
        movq      %rax, -8(%r15,%r11,8)                         #135.9
        movq      %rax, -8(%r10,%r11,8)                         #136.9
        movq      %rax, -8(%r9,%r11,8)                          #137.9
                                # LOE r9 r10 r13 r14 r15 edx ebx xmm0 xmm1 xmm2
..B1.13:                        # Preds ..B1.11 ..B1.12
                                # Execution count [5.00e-01]
        testl     %ebx, %ebx                                    #140.5
        je        ..B1.17       # Prob 22%                      #140.5
                                # LOE r9 r10 r13 r14 r15 edx ebx xmm0 xmm1 xmm2
..B1.14:                        # Preds ..B1.13
                                # Execution count [3.90e-01]
        movl      $.L_2__STRING.3, %edi                         #141.5
        movl      %edx, 128(%rsp)                               #141.5[spill]
        movq      %r9, 400(%rsp)                                #141.5[spill]
        movq      %r10, 392(%rsp)                               #141.5[spill]
        vmovsd    %xmm2, 136(%rsp)                              #141.5[spill]
        vmovsd    %xmm1, 144(%rsp)                              #141.5[spill]
        vmovsd    %xmm0, 152(%rsp)                              #141.5[spill]
..___tag_value_computeForce.20:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #141.5
..___tag_value_computeForce.21:
                                # LOE r13 r14 r15 ebx
..B1.79:                        # Preds ..B1.14
                                # Execution count [3.90e-01]
        movq      392(%rsp), %r10                               #[spill]
        movq      400(%rsp), %r9                                #[spill]
        vmovsd    152(%rsp), %xmm0                              #[spill]
        vmovsd    144(%rsp), %xmm1                              #[spill]
        vmovsd    136(%rsp), %xmm2                              #[spill]
        movl      128(%rsp), %edx                               #[spill]
        jmp       ..B1.20       # Prob 100%                     #
                                # LOE r9 r10 r13 r14 r15 edx ebx xmm0 xmm1 xmm2
..B1.15:                        # Preds ..B1.6
                                # Execution count [5.00e-01]
        testl     %ebx, %ebx                                    #140.5
        je        ..B1.17       # Prob 22%                      #140.5
                                # LOE r9 r10 r13 r14 r15 edx ebx xmm0 xmm1 xmm2
..B1.16:                        # Preds ..B1.15
                                # Execution count [3.90e-01]
        movl      $.L_2__STRING.3, %edi                         #141.5
..___tag_value_computeForce.29:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #141.5
..___tag_value_computeForce.30:
        jmp       ..B1.66       # Prob 100%                     #141.5
                                # LOE r13 ebx
..B1.17:                        # Preds ..B1.15 ..B1.13
                                # Execution count [2.20e-01]
        movq      384(%rsp), %r11                               #140.5[spill]
        movq      %r13, %rdi                                    #140.5
        movl      $.L_2__STRING.2, %esi                         #140.5
        xorl      %eax, %eax                                    #140.5
        movl      8(%r14), %ecx                                 #140.5
        movl      16(%r11), %r8d                                #140.5
        movl      %edx, 128(%rsp)                               #140.5[spill]
        movq      %r9, 400(%rsp)                                #140.5[spill]
        movq      %r10, 392(%rsp)                               #140.5[spill]
        vmovsd    %xmm2, 136(%rsp)                              #140.5[spill]
        vmovsd    %xmm1, 144(%rsp)                              #140.5[spill]
        vmovsd    %xmm0, 152(%rsp)                              #140.5[spill]
#       fprintf(FILE *__restrict__, const char *__restrict__, ...)
        call      fprintf                                       #140.5
                                # LOE r13 r14 r15 ebx
..B1.18:                        # Preds ..B1.17
                                # Execution count [2.20e-01]
        movl      $.L_2__STRING.3, %edi                         #141.5
        vmovsd    152(%rsp), %xmm0                              #[spill]
        vmovsd    144(%rsp), %xmm1                              #[spill]
        vmovsd    136(%rsp), %xmm2                              #[spill]
        vmovsd    %xmm2, 136(%rsp)                              #141.5[spill]
        vmovsd    %xmm1, 144(%rsp)                              #141.5[spill]
        vmovsd    %xmm0, 152(%rsp)                              #141.5[spill]
..___tag_value_computeForce.43:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #141.5
..___tag_value_computeForce.44:
                                # LOE r13 r14 r15 ebx
..B1.19:                        # Preds ..B1.18
                                # Execution count [2.20e-01]
        movl      128(%rsp), %edx                               #[spill]
        movq      392(%rsp), %r10                               #[spill]
        movq      400(%rsp), %r9                                #[spill]
        vmovsd    152(%rsp), %xmm0                              #[spill]
        vmovsd    144(%rsp), %xmm1                              #[spill]
        vmovsd    136(%rsp), %xmm2                              #[spill]
        testl     %edx, %edx                                    #143.24
        jle       ..B1.66       # Prob 9%                       #143.24
                                # LOE r9 r10 r13 r14 r15 edx ebx xmm0 xmm1 xmm2
..B1.20:                        # Preds ..B1.19 ..B1.79
                                # Execution count [9.00e-01]
        vmulsd    %xmm2, %xmm2, %xmm2                           #129.45
        movq      %r10, %rax                                    #140.5
        vmovdqu   .L_2il0floatpacket.0(%rip), %ymm5             #173.13
        vmulsd    .L_2il0floatpacket.3(%rip), %xmm0, %xmm0      #197.45
        vbroadcastsd %xmm2, %zmm3                               #129.25
        vbroadcastsd %xmm1, %zmm2                               #130.21
        vbroadcastsd %xmm0, %zmm1                               #197.45
        vmovups   .L_2il0floatpacket.4(%rip), %zmm0             #197.58
        vmovups   %zmm2, 256(%rsp)                              #140.5[spill]
        vmovups   %zmm1, 320(%rsp)                              #140.5[spill]
        vmovups   %zmm3, 192(%rsp)                              #140.5[spill]
        movslq    %edx, %rdx                                    #143.5
        xorl      %r12d, %r12d                                  #140.5
        movq      %rdx, 440(%rsp)                               #140.5[spill]
        movl      %ebx, %ecx                                    #140.5
        movq      %r13, 128(%rsp)                               #140.5[spill]
        movq      %r9, %rbx                                     #140.5
        movq      384(%rsp), %r9                                #140.5[spill]
        movq      %r14, %r10                                    #140.5
        movq      %rax, %r14                                    #140.5
                                # LOE rbx r9 r10 r12 r14 r15 ecx
..B1.21:                        # Preds ..B1.64 ..B1.20
                                # Execution count [5.00e+00]
        movl      %r12d, %edx                                   #144.9
        movl      16(%r9), %r8d                                 #144.43
        vxorpd    %xmm18, %xmm18, %xmm18                        #149.22
        imull     %edx, %r8d                                    #144.43
        vmovapd   %xmm18, %xmm12                                #150.22
        vmovapd   %xmm12, %xmm4                                 #151.22
        movslq    %r8d, %r8                                     #144.19
        lea       (%rdx,%rdx,2), %eax                           #146.25
        movq      8(%r9), %rdi                                  #144.19
        movslq    %eax, %rax                                    #146.25
        movq      24(%r9), %r13                                 #145.25
        lea       (%rdi,%r8,4), %r8                             #144.19
        movq      16(%r10), %rdi                                #146.25
        movl      (%r13,%r12,4), %r13d                          #145.25
        vmovsd    (%rdi,%rax,8), %xmm1                          #146.25
        vmovsd    8(%rdi,%rax,8), %xmm15                        #147.25
        vmovsd    16(%rdi,%rax,8), %xmm9                        #148.25
        testl     %ecx, %ecx                                    #156.9
        je        ..B1.23       # Prob 22%                      #156.9
                                # LOE rbx rdi r8 r9 r10 r12 r14 r15 edx ecx r13d xmm1 xmm4 xmm9 xmm12 xmm15 xmm18
..B1.22:                        # Preds ..B1.21
                                # Execution count [2.50e+00]
        testl     %r13d, %r13d                                  #173.32
        jg        ..B1.35       # Prob 50%                      #173.32
        jmp       ..B1.64       # Prob 100%                     #173.32
                                # LOE rbx rdi r8 r9 r10 r12 r14 r15 ecx r13d xmm1 xmm4 xmm9 xmm12 xmm15 xmm18
..B1.23:                        # Preds ..B1.21
                                # Execution count [1.10e+00]
        movl      $.L_2__STRING.4, %esi                         #156.9
        xorl      %eax, %eax                                    #156.9
        movq      128(%rsp), %rdi                               #156.9[spill]
        movq      %r8, 448(%rsp)                                #156.9[spill]
        movl      %ecx, 416(%rsp)                               #156.9[spill]
        movq      %r10, 408(%rsp)                               #156.9[spill]
        movq      %r9, 384(%rsp)                                #156.9[spill]
        vzeroupper                                              #156.9
        vmovsd    %xmm18, 168(%rsp)                             #156.9[spill]
        vmovsd    %xmm12, 176(%rsp)                             #156.9[spill]
        vmovsd    %xmm4, 184(%rsp)                              #156.9[spill]
        vmovsd    %xmm9, 152(%rsp)                              #156.9[spill]
        vmovsd    %xmm15, 144(%rsp)                             #156.9[spill]
        vmovsd    %xmm1, 136(%rsp)                              #156.9[spill]
#       fprintf(FILE *__restrict__, const char *__restrict__, ...)
        call      fprintf                                       #156.9
                                # LOE rbx r12 r14 r15 r13d
..B1.24:                        # Preds ..B1.23
                                # Execution count [2.50e+00]
        xorl      %edx, %edx                                    #170.13
        movq      384(%rsp), %r9                                #[spill]
        xorl      %eax, %eax                                    #170.13
        movq      408(%rsp), %r10                               #[spill]
        movl      416(%rsp), %ecx                               #[spill]
        movq      448(%rsp), %r8                                #[spill]
        vmovsd    136(%rsp), %xmm1                              #[spill]
        vmovsd    144(%rsp), %xmm15                             #[spill]
        vmovsd    152(%rsp), %xmm9                              #[spill]
        vmovsd    184(%rsp), %xmm4                              #[spill]
        vmovsd    176(%rsp), %xmm12                             #[spill]
        vmovsd    168(%rsp), %xmm18                             #[spill]
        testl     %r13d, %r13d                                  #170.13
        jle       ..B1.64       # Prob 10%                      #170.13
                                # LOE rax rdx rbx r8 r9 r10 r12 r14 r15 ecx r13d xmm1 xmm4 xmm9 xmm12 xmm15 xmm18
..B1.25:                        # Preds ..B1.24
                                # Execution count [2.25e+00]
        movq      %r15, 424(%rsp)                               #170.13[spill]
        lea       7(%r13), %esi                                 #145.25
        shrl      $3, %esi                                      #145.25
        vmovsd    %xmm9, 152(%rsp)                              #170.13[spill]
        vmovsd    %xmm15, 144(%rsp)                             #170.13[spill]
        vmovsd    %xmm1, 136(%rsp)                              #170.13[spill]
        movq      %rsi, 472(%rsp)                               #170.13[spill]
        movl      %r13d, 464(%rsp)                              #170.13[spill]
        movq      %r12, 432(%rsp)                               #170.13[spill]
        movq      %rdx, %r12                                    #170.13
        movq      %rbx, 400(%rsp)                               #170.13[spill]
        movq      %r8, %rbx                                     #170.13
        movq      %r14, 392(%rsp)                               #170.13[spill]
        movq      %rax, %r14                                    #170.13
        movl      %ecx, 416(%rsp)                               #170.13[spill]
        movq      %r10, 408(%rsp)                               #170.13[spill]
        movq      %r9, 384(%rsp)                                #170.13[spill]
        movq      128(%rsp), %r15                               #170.13[spill]
                                # LOE rbx r12 r14 r15
..B1.26:                        # Preds ..B1.33 ..B1.25
                                # Execution count [1.25e+01]
        movl      %r12d, %r13d                                  #170.13
        movl      $8, %ecx                                      #170.13
        shll      $3, %r13d                                     #170.13
        movl      $il0_peep_printf_format_0, %edi               #170.13
        negl      %r13d                                         #170.13
        movq      %r15, %rsi                                    #170.13
        addl      464(%rsp), %r13d                              #170.13[spill]
        cmpl      $8, %r13d                                     #170.13
        cmovge    %ecx, %r13d                                   #170.13
        movslq    %r13d, %r13                                   #170.13
        call      fputs                                         #170.13
                                # LOE rbx r12 r13 r14 r15
..B1.27:                        # Preds ..B1.26
                                # Execution count [1.25e+01]
        xorl      %edx, %edx                                    #170.13
        testq     %r13, %r13                                    #170.13
        jle       ..B1.32       # Prob 10%                      #170.13
                                # LOE rdx rbx r12 r13 r14 r15
..B1.28:                        # Preds ..B1.27
                                # Execution count [1.12e+01]
        movq      %r12, 456(%rsp)                               #170.13[spill]
        lea       (%rbx,%r14), %rax                             #170.13
        movq      %rbx, 448(%rsp)                               #170.13[spill]
        movq      %rax, %rbx                                    #170.13
        movq      %rdx, %r12                                    #170.13
                                # LOE rbx r12 r13 r14 r15
..B1.29:                        # Preds ..B1.30 ..B1.28
                                # Execution count [6.25e+01]
        movq      %r15, %rdi                                    #170.13
        movl      $.L_2__STRING.6, %esi                         #170.13
        xorl      %eax, %eax                                    #170.13
        movl      (%rbx,%r12,4), %edx                           #170.13
#       fprintf(FILE *__restrict__, const char *__restrict__, ...)
        call      fprintf                                       #170.13
                                # LOE rbx r12 r13 r14 r15
..B1.30:                        # Preds ..B1.29
                                # Execution count [6.25e+01]
        incq      %r12                                          #170.13
        cmpq      %r13, %r12                                    #170.13
        jb        ..B1.29       # Prob 82%                      #170.13
                                # LOE rbx r12 r13 r14 r15
..B1.31:                        # Preds ..B1.30
                                # Execution count [1.12e+01]
        movq      456(%rsp), %r12                               #[spill]
        movq      448(%rsp), %rbx                               #[spill]
                                # LOE rbx r12 r14 r15
..B1.32:                        # Preds ..B1.31 ..B1.27
                                # Execution count [1.25e+01]
        movl      $10, %edi                                     #170.13
        movq      %r15, %rsi                                    #170.13
        call      fputc                                         #170.13
                                # LOE rbx r12 r14 r15
..B1.33:                        # Preds ..B1.32
                                # Execution count [1.25e+01]
        incq      %r12                                          #170.13
        addq      $32, %r14                                     #170.13
        cmpq      472(%rsp), %r12                               #170.13[spill]
        jb        ..B1.26       # Prob 82%                      #170.13
                                # LOE rbx r12 r14 r15
..B1.34:                        # Preds ..B1.33
                                # Execution count [2.25e+00]
        movq      408(%rsp), %r10                               #[spill]
        movq      %rbx, %r8                                     #
        vmovsd    152(%rsp), %xmm9                              #[spill]
        vmovsd    144(%rsp), %xmm15                             #[spill]
        vmovsd    136(%rsp), %xmm1                              #[spill]
        movl      464(%rsp), %r13d                              #[spill]
        movq      432(%rsp), %r12                               #[spill]
        movq      400(%rsp), %rbx                               #[spill]
        movq      392(%rsp), %r14                               #[spill]
        movq      424(%rsp), %r15                               #[spill]
        movl      416(%rsp), %ecx                               #[spill]
        movq      384(%rsp), %r9                                #[spill]
        movq      16(%r10), %rdi                                #175.40
                                # LOE rbx rdi r8 r9 r10 r12 r14 r15 ecx r13d xmm1 xmm9 xmm15
..B1.35:                        # Preds ..B1.34 ..B1.22
                                # Execution count [4.50e+00]
        vpxord    %zmm8, %zmm8, %zmm8                           #149.22
        vmovaps   %zmm8, %zmm7                                  #150.22
        vmovaps   %zmm7, %zmm6                                  #151.22
        cmpl      $8, %r13d                                     #173.13
        jl        ..B1.72       # Prob 10%                      #173.13
                                # LOE rbx rdi r8 r9 r10 r12 r14 r15 ecx r13d xmm1 xmm9 xmm15 zmm6 zmm7 zmm8
..B1.36:                        # Preds ..B1.35
                                # Execution count [4.50e+00]
        cmpl      $1200, %r13d                                  #173.13
        jl        ..B1.71       # Prob 10%                      #173.13
                                # LOE rbx rdi r8 r9 r10 r12 r14 r15 ecx r13d xmm1 xmm9 xmm15 zmm6 zmm7 zmm8
..B1.37:                        # Preds ..B1.36
                                # Execution count [4.50e+00]
        movq      %r8, %rax                                     #173.13
        andq      $63, %rax                                     #173.13
        testb     $3, %al                                       #173.13
        je        ..B1.39       # Prob 50%                      #173.13
                                # LOE rbx rdi r8 r9 r10 r12 r14 r15 eax ecx r13d xmm1 xmm9 xmm15 zmm6 zmm7 zmm8
..B1.38:                        # Preds ..B1.37
                                # Execution count [2.25e+00]
        xorl      %eax, %eax                                    #173.13
        jmp       ..B1.41       # Prob 100%                     #173.13
                                # LOE rbx rdi r8 r9 r10 r12 r14 r15 eax ecx r13d xmm1 xmm9 xmm15 zmm6 zmm7 zmm8
..B1.39:                        # Preds ..B1.37
                                # Execution count [2.25e+00]
        testl     %eax, %eax                                    #173.13
        je        ..B1.41       # Prob 50%                      #173.13
                                # LOE rbx rdi r8 r9 r10 r12 r14 r15 eax ecx r13d xmm1 xmm9 xmm15 zmm6 zmm7 zmm8
..B1.40:                        # Preds ..B1.39
                                # Execution count [2.50e+01]
        negl      %eax                                          #173.13
        addl      $64, %eax                                     #173.13
        shrl      $2, %eax                                      #173.13
        cmpl      %eax, %r13d                                   #173.13
        cmovl     %r13d, %eax                                   #173.13
                                # LOE rbx rdi r8 r9 r10 r12 r14 r15 eax ecx r13d xmm1 xmm9 xmm15 zmm6 zmm7 zmm8
..B1.41:                        # Preds ..B1.38 ..B1.40 ..B1.39
                                # Execution count [5.00e+00]
        movl      %r13d, %edx                                   #173.13
        subl      %eax, %edx                                    #173.13
        andl      $7, %edx                                      #173.13
        negl      %edx                                          #173.13
        addl      %r13d, %edx                                   #173.13
        cmpl      $1, %eax                                      #173.13
        jb        ..B1.49       # Prob 50%                      #173.13
                                # LOE rbx rdi r8 r9 r10 r12 r14 r15 eax edx ecx r13d xmm1 xmm9 xmm15 zmm6 zmm7 zmm8
..B1.42:                        # Preds ..B1.41
                                # Execution count [4.50e+00]
        vmovdqu   .L_2il0floatpacket.1(%rip), %ymm5             #173.13
        xorl      %r11d, %r11d                                  #173.13
        vmovups   .L_2il0floatpacket.4(%rip), %zmm10            #173.13
        vmovups   320(%rsp), %zmm11                             #173.13[spill]
        vmovups   256(%rsp), %zmm12                             #173.13[spill]
        vmovups   192(%rsp), %zmm13                             #173.13[spill]
        vmovdqu   .L_2il0floatpacket.0(%rip), %ymm14            #173.13
        vpbroadcastd %eax, %ymm4                                #173.13
        vbroadcastsd %xmm1, %zmm3                               #146.23
        vbroadcastsd %xmm15, %zmm2                              #147.23
        vbroadcastsd %xmm9, %zmm0                               #148.23
        movslq    %eax, %rsi                                    #173.13
        movq      %r10, 408(%rsp)                               #173.13[spill]
        movq      %r9, 384(%rsp)                                #173.13[spill]
                                # LOE rbx rsi rdi r8 r11 r12 r14 r15 eax edx ecx r13d xmm1 xmm9 xmm15 ymm4 ymm5 ymm14 zmm0 zmm2 zmm3 zmm6 zmm7 zmm8 zmm10 zmm11 zmm12 zmm13
..B1.43:                        # Preds ..B1.47 ..B1.42
                                # Execution count [2.50e+01]
        vpcmpgtd  %ymm5, %ymm4, %k3                             #173.13
        vmovdqu32 (%r8,%r11,4), %ymm16{%k3}{z}                  #174.25
        kmovw     %k3, %r10d                                    #173.13
        vpaddd    %ymm16, %ymm16, %ymm17                        #175.40
        vpaddd    %ymm17, %ymm16, %ymm16                        #175.40
                                # LOE rbx rsi rdi r8 r11 r12 r14 r15 eax edx ecx r10d r13d xmm1 xmm9 xmm15 ymm4 ymm5 ymm14 ymm16 zmm0 zmm2 zmm3 zmm6 zmm7 zmm8 zmm10 zmm11 zmm12 zmm13 k3
..B1.46:                        # Preds ..B1.43
                                # Execution count [1.25e+01]
        kmovw     %k3, %k1                                      #175.40
        kmovw     %k3, %k2                                      #175.40
        vpxord    %zmm17, %zmm17, %zmm17                        #175.40
        vpxord    %zmm18, %zmm18, %zmm18                        #175.40
        vpxord    %zmm19, %zmm19, %zmm19                        #175.40
        vgatherdpd 16(%rdi,%ymm16,8), %zmm17{%k1}               #175.40
        vgatherdpd 8(%rdi,%ymm16,8), %zmm18{%k2}                #175.40
        vgatherdpd (%rdi,%ymm16,8), %zmm19{%k3}                 #175.40
                                # LOE rbx rsi rdi r8 r11 r12 r14 r15 eax edx ecx r10d r13d xmm1 xmm9 xmm15 ymm4 ymm5 ymm14 zmm0 zmm2 zmm3 zmm6 zmm7 zmm8 zmm10 zmm11 zmm12 zmm13 zmm17 zmm18 zmm19
..B1.47:                        # Preds ..B1.46
                                # Execution count [2.50e+01]
        addq      $8, %r11                                      #173.13
        #vpaddd    %ymm14, %ymm5, %ymm5                          #173.13
        #vsubpd    %zmm17, %zmm0, %zmm28                         #177.40
        #vsubpd    %zmm18, %zmm2, %zmm26                         #176.40
        #vsubpd    %zmm19, %zmm3, %zmm25                         #175.40
        #vmulpd    %zmm26, %zmm26, %zmm24                        #178.53
        #vfmadd231pd %zmm25, %zmm25, %zmm24                      #178.53
        #vfmadd231pd %zmm28, %zmm28, %zmm24                      #178.67
        #vrcp14pd  %zmm24, %zmm23                                #195.42
        #vcmppd    $1, %zmm13, %zmm24, %k2                       #194.26
        #vfpclasspd $30, %zmm23, %k0                             #195.42
        #kmovw     %k2, %r9d                                     #194.26
        #knotw     %k0, %k1                                      #195.42
        #vmovaps   %zmm24, %zmm16                                #195.42
        #andl      %r9d, %r10d                                   #194.26
        #vfnmadd213pd .L_2il0floatpacket.9(%rip){1to8}, %zmm23, %zmm16 #195.42
        #kmovw     %r10d, %k3                                    #198.21
        #vmulpd    %zmm16, %zmm16, %zmm17                        #195.42
        #vfmadd213pd %zmm23, %zmm16, %zmm23{%k1}                 #195.42
        #vfmadd213pd %zmm23, %zmm17, %zmm23{%k1}                 #195.42
        #vmulpd    %zmm12, %zmm23, %zmm18                        #196.42
        #vmulpd    %zmm11, %zmm23, %zmm20                        #197.58
        #vmulpd    %zmm18, %zmm23, %zmm21                        #196.48
        #vmulpd    %zmm21, %zmm23, %zmm19                        #196.54
        #vfmsub213pd %zmm10, %zmm21, %zmm23                      #197.58
        #vmulpd    %zmm20, %zmm19, %zmm22                        #197.65
        #vmulpd    %zmm23, %zmm22, %zmm27                        #197.71
        #vfmadd231pd %zmm25, %zmm27, %zmm8{%k3}                  #198.21
        #vfmadd231pd %zmm26, %zmm27, %zmm7{%k3}                  #199.21
        #vfmadd231pd %zmm28, %zmm27, %zmm6{%k3}                  #200.21
        cmpq      %rsi, %r11                                    #173.13
        jb        ..B1.43       # Prob 82%                      #173.13
                                # LOE rbx rsi rdi r8 r11 r12 r14 r15 eax edx ecx r13d xmm1 xmm9 xmm15 ymm4 ymm5 ymm14 zmm0 zmm2 zmm3 zmm6 zmm7 zmm8 zmm10 zmm11 zmm12 zmm13
..B1.48:                        # Preds ..B1.47
                                # Execution count [4.50e+00]
        movq      408(%rsp), %r10                               #[spill]
        movq      384(%rsp), %r9                                #[spill]
        cmpl      %eax, %r13d                                   #173.13
        je        ..B1.63       # Prob 10%                      #173.13
                                # LOE rbx rdi r8 r9 r10 r12 r14 r15 eax edx ecx r13d xmm1 xmm9 xmm15 zmm6 zmm7 zmm8
..B1.49:                        # Preds ..B1.48 ..B1.41 ..B1.71
                                # Execution count [2.50e+01]
        lea       8(%rax), %esi                                 #173.13
        cmpl      %esi, %edx                                    #173.13
        jl        ..B1.57       # Prob 50%                      #173.13
                                # LOE rbx rdi r8 r9 r10 r12 r14 r15 eax edx ecx r13d xmm1 xmm9 xmm15 zmm6 zmm7 zmm8
..B1.50:                        # Preds ..B1.49
                                # Execution count [4.50e+00]
        vbroadcastsd %xmm1, %zmm3                               #146.23
        vbroadcastsd %xmm15, %zmm2                              #147.23
        vbroadcastsd %xmm9, %zmm0                               #148.23
        vmovups   .L_2il0floatpacket.4(%rip), %zmm21            #173.13
        vmovups   320(%rsp), %zmm22                             #173.13[spill]
        vmovups   256(%rsp), %zmm23                             #173.13[spill]
        vmovups   192(%rsp), %zmm24                             #173.13[spill]
        movslq    %eax, %rsi                                    #173.13
        movq      %r12, 432(%rsp)                               #173.13[spill]
        movq      %rbx, 400(%rsp)                               #173.13[spill]
        movq      %r14, 392(%rsp)                               #173.13[spill]
        movq      %r15, 424(%rsp)                               #173.13[spill]
        movl      %ecx, 416(%rsp)                               #173.13[spill]
        movq      %r10, 408(%rsp)                               #173.13[spill]
        movq      %r9, 384(%rsp)                                #173.13[spill]
                                # LOE rsi rdi r8 eax edx r13d xmm1 xmm9 xmm15 zmm0 zmm2 zmm3 zmm6 zmm7 zmm8 zmm21 zmm22 zmm23 zmm24
..B1.51:                        # Preds ..B1.55 ..B1.50
                                # Execution count [2.50e+01]
        vmovdqu   (%r8,%rsi,4), %ymm4                           #174.25
        movl      20(%r8,%rsi,4), %ecx                          #174.25
        movl      24(%r8,%rsi,4), %r15d                         #174.25
        vpaddd    %ymm4, %ymm4, %ymm5                           #175.40
        vpaddd    %ymm5, %ymm4, %ymm4                           #175.40
        movl      (%r8,%rsi,4), %r14d                           #174.25
        lea       (%rcx,%rcx,2), %ebx                           #175.40
        movl      4(%r8,%rsi,4), %r12d                          #174.25
        lea       (%r15,%r15,2), %ecx                           #175.40
        movl      8(%r8,%rsi,4), %r11d                          #174.25
        movl      12(%r8,%rsi,4), %r10d                         #174.25
        lea       (%r14,%r14,2), %r14d                          #175.40
        movl      16(%r8,%rsi,4), %r9d                          #174.25
        lea       (%r12,%r12,2), %r12d                          #175.40
        movl      28(%r8,%rsi,4), %r15d                         #174.25
        lea       (%r11,%r11,2), %r11d                          #175.40
        lea       (%r10,%r10,2), %r10d                          #175.40
        lea       (%r9,%r9,2), %r9d                             #175.40
        lea       (%r15,%r15,2), %r15d                          #175.40
                                # LOE rsi rdi r8 eax edx ecx ebx r9d r10d r11d r12d r13d r14d r15d xmm1 xmm9 xmm15 ymm4 zmm0 zmm2 zmm3 zmm6 zmm7 zmm8 zmm21 zmm22 zmm23 zmm24
..B1.54:                        # Preds ..B1.51
                                # Execution count [1.25e+01]
        vpcmpeqb  %xmm0, %xmm0, %k1                             #175.40
        vpcmpeqb  %xmm0, %xmm0, %k2                             #175.40
        vpcmpeqb  %xmm0, %xmm0, %k3                             #175.40
        vpxord    %zmm5, %zmm5, %zmm5                           #175.40
        vpxord    %zmm10, %zmm10, %zmm10                        #175.40
        vpxord    %zmm11, %zmm11, %zmm11                        #175.40
        vgatherdpd 16(%rdi,%ymm4,8), %zmm5{%k1}                 #175.40
        vgatherdpd 8(%rdi,%ymm4,8), %zmm10{%k2}                 #175.40
        vgatherdpd (%rdi,%ymm4,8), %zmm11{%k3}                  #175.40
                                # LOE rsi rdi r8 eax edx r13d xmm1 xmm9 xmm15 zmm0 zmm2 zmm3 zmm5 zmm6 zmm7 zmm8 zmm10 zmm11 zmm21 zmm22 zmm23 zmm24
..B1.55:                        # Preds ..B1.54
                                # Execution count [2.50e+01]
        addl      $8, %eax                                      #173.13
        addq      $8, %rsi                                      #173.13
       # vsubpd    %zmm5, %zmm0, %zmm20                          #177.40
       # vsubpd    %zmm10, %zmm2, %zmm18                         #176.40
       # vsubpd    %zmm11, %zmm3, %zmm17                         #175.40
       # vmulpd    %zmm18, %zmm18, %zmm4                         #178.53
       # vfmadd231pd %zmm17, %zmm17, %zmm4                       #178.53
       # vfmadd231pd %zmm20, %zmm20, %zmm4                       #178.67
       # vrcp14pd  %zmm4, %zmm16                                 #195.42
       # vcmppd    $1, %zmm24, %zmm4, %k2                        #194.26
       # vfpclasspd $30, %zmm16, %k0                             #195.42
       # vfnmadd213pd .L_2il0floatpacket.9(%rip){1to8}, %zmm16, %zmm4 #195.42
       # knotw     %k0, %k1                                      #195.42
       # vmulpd    %zmm4, %zmm4, %zmm5                           #195.42
       # vfmadd213pd %zmm16, %zmm4, %zmm16{%k1}                  #195.42
       # vfmadd213pd %zmm16, %zmm5, %zmm16{%k1}                  #195.42
       # vmulpd    %zmm23, %zmm16, %zmm10                        #196.42
       # vmulpd    %zmm22, %zmm16, %zmm12                        #197.58
       # vmulpd    %zmm10, %zmm16, %zmm13                        #196.48
       # vmulpd    %zmm13, %zmm16, %zmm11                        #196.54
       # vfmsub213pd %zmm21, %zmm13, %zmm16                      #197.58
       # vmulpd    %zmm12, %zmm11, %zmm14                        #197.65
       # vmulpd    %zmm16, %zmm14, %zmm19                        #197.71
       # vfmadd231pd %zmm17, %zmm19, %zmm8{%k2}                  #198.21
       # vfmadd231pd %zmm18, %zmm19, %zmm7{%k2}                  #199.21
       # vfmadd231pd %zmm20, %zmm19, %zmm6{%k2}                  #200.21
        cmpl      %edx, %eax                                    #173.13
        jb        ..B1.51       # Prob 82%                      #173.13
                                # LOE rsi rdi r8 eax edx r13d xmm1 xmm9 xmm15 zmm0 zmm2 zmm3 zmm6 zmm7 zmm8 zmm21 zmm22 zmm23 zmm24
..B1.56:                        # Preds ..B1.55
                                # Execution count [4.50e+00]
        movq      432(%rsp), %r12                               #[spill]
        movq      400(%rsp), %rbx                               #[spill]
        movq      392(%rsp), %r14                               #[spill]
        movq      424(%rsp), %r15                               #[spill]
        movl      416(%rsp), %ecx                               #[spill]
        movq      408(%rsp), %r10                               #[spill]
        movq      384(%rsp), %r9                                #[spill]
                                # LOE rbx rdi r8 r9 r10 r12 r14 r15 edx ecx r13d xmm1 xmm9 xmm15 zmm6 zmm7 zmm8
..B1.57:                        # Preds ..B1.56 ..B1.49 ..B1.72
                                # Execution count [5.00e+00]
        lea       1(%rdx), %eax                                 #173.13
        cmpl      %r13d, %eax                                   #173.13
        ja        ..B1.63       # Prob 50%                      #173.13
                                # LOE rbx rdi r8 r9 r10 r12 r14 r15 edx ecx r13d xmm1 xmm9 xmm15 zmm6 zmm7 zmm8
..B1.58:                        # Preds ..B1.57
                                # Execution count [2.50e+01]
        subl      %edx, %r13d                                   #173.13
        vpbroadcastd %r13d, %ymm0                               #173.13
        vbroadcastsd %xmm1, %zmm4                               #146.23
        vpcmpgtd  .L_2il0floatpacket.1(%rip), %ymm0, %k3        #173.13
        movslq    %edx, %rdx                                    #173.13
        vmovdqu32 (%r8,%rdx,4), %ymm2{%k3}{z}                   #174.25
        kmovw     %k3, %edx                                     #173.13
        vpaddd    %ymm2, %ymm2, %ymm1                           #175.40
        vpaddd    %ymm1, %ymm2, %ymm0                           #175.40
                                # LOE rbx rdi r9 r10 r12 r14 r15 edx ecx xmm9 xmm15 ymm0 zmm4 zmm6 zmm7 zmm8 k3
..B1.61:                        # Preds ..B1.58
                                # Execution count [1.25e+01]
        kmovw     %k3, %k1                                      #175.40
        kmovw     %k3, %k2                                      #175.40
        vpxord    %zmm1, %zmm1, %zmm1                           #175.40
        vpxord    %zmm2, %zmm2, %zmm2                           #175.40
        vpxord    %zmm3, %zmm3, %zmm3                           #175.40
        vgatherdpd 16(%rdi,%ymm0,8), %zmm1{%k1}                 #175.40
        vgatherdpd 8(%rdi,%ymm0,8), %zmm2{%k2}                  #175.40
        vgatherdpd (%rdi,%ymm0,8), %zmm3{%k3}                   #175.40
                                # LOE rbx r9 r10 r12 r14 r15 edx ecx xmm9 xmm15 zmm1 zmm2 zmm3 zmm4 zmm6 zmm7 zmm8
..B1.62:                        # Preds ..B1.61
                                # Execution count [2.50e+01]
        #vbroadcastsd %xmm15, %zmm15                             #147.23
        #vbroadcastsd %xmm9, %zmm9                               #148.23
        #vsubpd    %zmm1, %zmm9, %zmm17                          #177.40
        #vsubpd    %zmm2, %zmm15, %zmm14                         #176.40
        #vsubpd    %zmm3, %zmm4, %zmm13                          #175.40
        #vmulpd    %zmm14, %zmm14, %zmm12                        #178.53
        #vfmadd231pd %zmm13, %zmm13, %zmm12                      #178.53
        #vfmadd231pd %zmm17, %zmm17, %zmm12                      #178.67
        #vrcp14pd  %zmm12, %zmm11                                #195.42
        #vcmppd    $1, 192(%rsp), %zmm12, %k2                    #194.26[spill]
        #vfpclasspd $30, %zmm11, %k0                             #195.42
        #kmovw     %k2, %eax                                     #194.26
        #knotw     %k0, %k1                                      #195.42
        #vmovaps   %zmm12, %zmm0                                 #195.42
        #andl      %eax, %edx                                    #194.26
        #vfnmadd213pd .L_2il0floatpacket.9(%rip){1to8}, %zmm11, %zmm0 #195.42
        #kmovw     %edx, %k3                                     #198.21
        #vmulpd    %zmm0, %zmm0, %zmm1                           #195.42
        #vfmadd213pd %zmm11, %zmm0, %zmm11{%k1}                  #195.42
        #vfmadd213pd %zmm11, %zmm1, %zmm11{%k1}                  #195.42
        #vmulpd    256(%rsp), %zmm11, %zmm2                      #196.42[spill]
        #vmulpd    320(%rsp), %zmm11, %zmm4                      #197.58[spill]
        #vmulpd    %zmm2, %zmm11, %zmm5                          #196.48
        #vmulpd    %zmm5, %zmm11, %zmm3                          #196.54
        #vfmsub213pd .L_2il0floatpacket.4(%rip), %zmm5, %zmm11   #197.58
        #vmulpd    %zmm4, %zmm3, %zmm10                          #197.65
        #vmulpd    %zmm11, %zmm10, %zmm16                        #197.71
        #vfmadd231pd %zmm13, %zmm16, %zmm8{%k3}                  #198.21
        #vfmadd231pd %zmm14, %zmm16, %zmm7{%k3}                  #199.21
        #vfmadd231pd %zmm17, %zmm16, %zmm6{%k3}                  #200.21
                                # LOE rbx r9 r10 r12 r14 r15 ecx zmm6 zmm7 zmm8
..B1.63:                        # Preds ..B1.48 ..B1.62 ..B1.57
                                # Execution count [4.50e+00]
        vmovups   .L_2il0floatpacket.10(%rip), %zmm13           #151.22
        vpermd    %zmm6, %zmm13, %zmm0                          #151.22
        vpermd    %zmm7, %zmm13, %zmm5                          #150.22
        vpermd    %zmm8, %zmm13, %zmm14                         #149.22
        vaddpd    %zmm6, %zmm0, %zmm6                           #151.22
        vaddpd    %zmm7, %zmm5, %zmm7                           #150.22
        vaddpd    %zmm8, %zmm14, %zmm8                          #149.22
        vpermpd   $78, %zmm6, %zmm1                             #151.22
        vpermpd   $78, %zmm7, %zmm9                             #150.22
        vpermpd   $78, %zmm8, %zmm15                            #149.22
        vaddpd    %zmm1, %zmm6, %zmm2                           #151.22
        vaddpd    %zmm9, %zmm7, %zmm10                          #150.22
        vaddpd    %zmm15, %zmm8, %zmm16                         #149.22
        vpermpd   $177, %zmm2, %zmm3                            #151.22
        vpermpd   $177, %zmm10, %zmm11                          #150.22
        vpermpd   $177, %zmm16, %zmm17                          #149.22
        vaddpd    %zmm3, %zmm2, %zmm4                           #151.22
        vaddpd    %zmm11, %zmm10, %zmm12                        #150.22
        vaddpd    %zmm17, %zmm16, %zmm18                        #149.22
                                # LOE rbx r9 r10 r12 r14 r15 ecx xmm4 xmm12 xmm18
..B1.64:                        # Preds ..B1.24 ..B1.63 ..B1.22
                                # Execution count [5.00e+00]
        vaddsd    (%r15,%r12,8), %xmm18, %xmm0                  #208.9
        vmovsd    %xmm0, (%r15,%r12,8)                          #208.9
        vaddsd    (%r14,%r12,8), %xmm12, %xmm1                  #209.9
        vmovsd    %xmm1, (%r14,%r12,8)                          #209.9
        vaddsd    (%rbx,%r12,8), %xmm4, %xmm2                   #210.9
        vmovsd    %xmm2, (%rbx,%r12,8)                          #210.9
        incq      %r12                                          #143.5
        cmpq      440(%rsp), %r12                               #143.5[spill]
        jb        ..B1.21       # Prob 82%                      #143.5
                                # LOE rbx r9 r10 r12 r14 r15 ecx
..B1.65:                        # Preds ..B1.64
                                # Execution count [9.00e-01]
        movq      128(%rsp), %r13                               #[spill]
        movl      %ecx, %ebx                                    #
                                # LOE r13 ebx
..B1.66:                        # Preds ..B1.16 ..B1.65 ..B1.19
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.3, %edi                         #219.5
        vzeroupper                                              #219.5
..___tag_value_computeForce.138:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #219.5
..___tag_value_computeForce.139:
                                # LOE r13 ebx
..B1.67:                        # Preds ..B1.66
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #221.16
..___tag_value_computeForce.140:
#       getTimeStamp()
        call      getTimeStamp                                  #221.16
..___tag_value_computeForce.141:
                                # LOE r13 ebx xmm0
..B1.68:                        # Preds ..B1.67
                                # Execution count [1.00e+00]
        testl     %ebx, %ebx                                    #222.5
        jne       ..B1.70       # Prob 78%                      #222.5
                                # LOE r13 xmm0
..B1.69:                        # Preds ..B1.68
                                # Execution count [2.20e-01]
        movq      %r13, %rdi                                    #222.5
        vmovsd    %xmm0, 128(%rsp)                              #222.5[spill]
#       fclose(FILE *)
        call      fclose                                        #222.5
                                # LOE
..B1.80:                        # Preds ..B1.69
                                # Execution count [2.20e-01]
        vmovsd    128(%rsp), %xmm0                              #[spill]
                                # LOE xmm0
..B1.70:                        # Preds ..B1.80 ..B1.68
                                # Execution count [1.00e+00]
        vsubsd    160(%rsp), %xmm0, %xmm0                       #224.14[spill]
        addq      $536, %rsp                                    #224.14
	.cfi_restore 3
        popq      %rbx                                          #224.14
	.cfi_restore 15
        popq      %r15                                          #224.14
	.cfi_restore 14
        popq      %r14                                          #224.14
	.cfi_restore 13
        popq      %r13                                          #224.14
	.cfi_restore 12
        popq      %r12                                          #224.14
        movq      %rbp, %rsp                                    #224.14
        popq      %rbp                                          #224.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #224.14
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B1.71:                        # Preds ..B1.36
                                # Execution count [4.50e-01]: Infreq
        movl      %r13d, %edx                                   #173.13
        xorl      %eax, %eax                                    #173.13
        andl      $-8, %edx                                     #173.13
        jmp       ..B1.49       # Prob 100%                     #173.13
                                # LOE rbx rdi r8 r9 r10 r12 r14 r15 eax edx ecx r13d xmm1 xmm9 xmm15 zmm6 zmm7 zmm8
..B1.72:                        # Preds ..B1.35
                                # Execution count [4.50e-01]: Infreq
        xorl      %edx, %edx                                    #173.13
        jmp       ..B1.57       # Prob 100%                     #173.13
        .align    16,0x90
                                # LOE rbx rdi r8 r9 r10 r12 r14 r15 edx ecx r13d xmm1 xmm9 xmm15 zmm6 zmm7 zmm8
	.cfi_endproc
# mark_end;
	.type	computeForce,@function
	.size	computeForce,.-computeForce
..LNcomputeForce.0:
	.section .rodata.str1.4, "aMS",@progbits,1
	.align 4
	.align 4
il0_peep_printf_format_0:
	.long	2112073
	.data
# -- End  computeForce
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
.L_2il0floatpacket.5:
	.long	0x02010101,0x04040202,0x08080804,0x20101010,0x40402020,0x80808040,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.type	.L_2il0floatpacket.5,@object
	.size	.L_2il0floatpacket.5,64
	.align 64
.L_2il0floatpacket.6:
	.long	0x00000000,0x00000000,0x00000004,0x00000000,0x00000008,0x00000000,0x0000000c,0x00000000,0x00000001,0x00000000,0x00000005,0x00000000,0x00000009,0x00000000,0x0000000d,0x00000000
	.type	.L_2il0floatpacket.6,@object
	.size	.L_2il0floatpacket.6,64
	.align 64
.L_2il0floatpacket.7:
	.long	0x00000001,0x00000000,0x00000005,0x00000000,0x00000009,0x00000000,0x0000000d,0x00000000,0x00000000,0x00000000,0x00000004,0x00000000,0x00000008,0x00000000,0x0000000c,0x00000000
	.type	.L_2il0floatpacket.7,@object
	.size	.L_2il0floatpacket.7,64
	.align 64
.L_2il0floatpacket.8:
	.long	0x00000002,0x00000000,0x00000006,0x00000000,0x0000000a,0x00000000,0x0000000e,0x00000000,0x00000002,0x00000000,0x00000006,0x00000000,0x0000000a,0x00000000,0x0000000e,0x00000000
	.type	.L_2il0floatpacket.8,@object
	.size	.L_2il0floatpacket.8,64
	.align 64
.L_2il0floatpacket.10:
	.long	0x00000008,0x00000009,0x0000000a,0x0000000b,0x0000000c,0x0000000d,0x0000000e,0x0000000f,0x00000008,0x00000009,0x0000000a,0x0000000b,0x0000000c,0x0000000d,0x0000000e,0x0000000f
	.type	.L_2il0floatpacket.10,@object
	.size	.L_2il0floatpacket.10,64
	.align 32
.L_2il0floatpacket.0:
	.long	0x00000008,0x00000008,0x00000008,0x00000008,0x00000008,0x00000008,0x00000008,0x00000008
	.type	.L_2il0floatpacket.0,@object
	.size	.L_2il0floatpacket.0,32
	.align 32
.L_2il0floatpacket.1:
	.long	0x00000000,0x00000001,0x00000002,0x00000003,0x00000004,0x00000005,0x00000006,0x00000007
	.type	.L_2il0floatpacket.1,@object
	.size	.L_2il0floatpacket.1,32
	.align 8
.L_2il0floatpacket.3:
	.long	0x00000000,0x40480000
	.type	.L_2il0floatpacket.3,@object
	.size	.L_2il0floatpacket.3,8
	.align 8
.L_2il0floatpacket.9:
	.long	0x00000000,0x3ff00000
	.type	.L_2il0floatpacket.9,@object
	.size	.L_2il0floatpacket.9,8
	.section .rodata.str1.4, "aMS",@progbits,1
	.align 4
.L_2__STRING.0:
	.long	1701080681
	.long	1920229240
	.long	1919247201
	.long	778315103
	.long	7632239
	.type	.L_2__STRING.0,@object
	.size	.L_2__STRING.0,20
	.align 4
.L_2__STRING.1:
	.word	119
	.type	.L_2__STRING.1,@object
	.size	.L_2__STRING.1,2
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.3:
	.long	1668444006
	.word	101
	.type	.L_2__STRING.3,@object
	.size	.L_2__STRING.3,6
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.2:
	.long	622869070
	.long	1680154724
	.long	174335264
	.byte	0
	.type	.L_2__STRING.2,@object
	.size	.L_2__STRING.2,13
	.space 3, 0x00 	# pad
	.align 4
.L_2__STRING.4:
	.long	622869057
	.word	2660
	.byte	0
	.type	.L_2__STRING.4,@object
	.size	.L_2__STRING.4,7
	.space 1, 0x00 	# pad
	.align 4
.L_2__STRING.6:
	.long	2122789
	.type	.L_2__STRING.6,@object
	.size	.L_2__STRING.6,4
	.data
	.section .note.GNU-stack, ""
# End
