# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 19.0.5.281 Build 20190815";
# mark_description "-I./src/includes -S -D_GNU_SOURCE -DAOS -DPRECISION=2 -DNEIGHBORS_LOOP_RUNS=1 -DVECTOR_WIDTH=8 -DALIGNMENT=6";
# mark_description "4 -restrict -Ofast -xCORE-AVX512 -qopt-zmm-usage=high -o ICC/force.s";
	.file "force.c"
	.text
..TXTST0:
.L_2__routine_start_computeForce_0:
# -- Begin  computeForce
	.text
# mark_begin;
       .align    16,0x90
	.globl computeForce
# --- computeForce(Parameter *, Atom *, Neighbor *, int)
computeForce:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %ecx
..B1.1:                         # Preds ..B1.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForce.1:
..L2:
                                                          #103.87
        pushq     %rbp                                          #103.87
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #103.87
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #103.87
        pushq     %r12                                          #103.87
        pushq     %r13                                          #103.87
        pushq     %r14                                          #103.87
        subq      $104, %rsp                                    #103.87
        xorl      %eax, %eax                                    #106.16
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
        movq      %rdx, %r14                                    #103.87
        movq      %rsi, %r13                                    #103.87
        movq      %rdi, %r12                                    #103.87
..___tag_value_computeForce.9:
#       getTimeStamp()
        call      getTimeStamp                                  #106.16
..___tag_value_computeForce.10:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.48:                        # Preds ..B1.1
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 16(%rsp)                               #106.16[spill]
                                # LOE rbx r12 r13 r14 r15
..B1.2:                         # Preds ..B1.48
                                # Execution count [1.00e+00]
        movl      4(%r13), %ecx                                 #107.18
        movq      64(%r13), %r11                                #109.20
        movq      72(%r13), %r10                                #109.45
        movq      80(%r13), %r9                                 #109.70
        vmovsd    72(%r12), %xmm2                               #111.27
        vmovsd    8(%r12), %xmm1                                #112.23
        vmovsd    (%r12), %xmm0                                 #113.24
        testl     %ecx, %ecx                                    #116.24
        jle       ..B1.42       # Prob 50%                      #116.24
                                # LOE rbx r9 r10 r11 r13 r14 r15 ecx xmm0 xmm1 xmm2
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
        xorl      %edi, %edi                                    #116.5
        movl      %ecx, %edx                                    #116.5
        xorl      %esi, %esi                                    #116.5
        movl      $1, %r8d                                      #116.5
        xorl      %eax, %eax                                    #117.17
        shrl      $1, %edx                                      #116.5
        je        ..B1.7        # Prob 9%                       #116.5
                                # LOE rax rdx rbx rsi rdi r9 r10 r11 r13 r14 r15 ecx r8d xmm0 xmm1 xmm2
..B1.5:                         # Preds ..B1.3 ..B1.5
                                # Execution count [2.50e+00]
        movq      %rax, (%rsi,%r11)                             #117.9
        incq      %rdi                                          #116.5
        movq      %rax, (%rsi,%r10)                             #118.9
        movq      %rax, (%rsi,%r9)                              #119.9
        movq      %rax, 8(%rsi,%r11)                            #117.9
        movq      %rax, 8(%rsi,%r10)                            #118.9
        movq      %rax, 8(%rsi,%r9)                             #119.9
        addq      $16, %rsi                                     #116.5
        cmpq      %rdx, %rdi                                    #116.5
        jb        ..B1.5        # Prob 63%                      #116.5
                                # LOE rax rdx rbx rsi rdi r9 r10 r11 r13 r14 r15 ecx xmm0 xmm1 xmm2
..B1.6:                         # Preds ..B1.5
                                # Execution count [9.00e-01]
        lea       1(%rdi,%rdi), %r8d                            #117.9
                                # LOE rax rbx r9 r10 r11 r13 r14 r15 ecx r8d xmm0 xmm1 xmm2
..B1.7:                         # Preds ..B1.3 ..B1.6
                                # Execution count [1.00e+00]
        lea       -1(%r8), %edx                                 #116.5
        cmpl      %ecx, %edx                                    #116.5
        jae       ..B1.9        # Prob 9%                       #116.5
                                # LOE rax rbx r9 r10 r11 r13 r14 r15 ecx r8d xmm0 xmm1 xmm2
..B1.8:                         # Preds ..B1.7
                                # Execution count [9.00e-01]
        movslq    %r8d, %r8                                     #116.5
        movq      %rax, -8(%r11,%r8,8)                          #117.9
        movq      %rax, -8(%r10,%r8,8)                          #118.9
        movq      %rax, -8(%r9,%r8,8)                           #119.9
                                # LOE rbx r9 r10 r11 r13 r14 r15 ecx xmm0 xmm1 xmm2
..B1.9:                         # Preds ..B1.7 ..B1.8
                                # Execution count [9.00e-01]
        vmulsd    %xmm2, %xmm2, %xmm13                          #111.45
        xorl      %edi, %edi                                    #124.15
        vmovdqu32 .L_2il0floatpacket.0(%rip), %ymm16            #153.13
        vmulsd    .L_2il0floatpacket.3(%rip), %xmm0, %xmm0      #177.45
        vmovdqu   .L_2il0floatpacket.1(%rip), %ymm15            #153.13
        vmovups   .L_2il0floatpacket.4(%rip), %zmm5             #177.58
        vbroadcastsd %xmm13, %zmm14                             #111.25
        vbroadcastsd %xmm1, %zmm13                              #112.21
        vbroadcastsd %xmm0, %zmm9                               #177.45
        movq      16(%r13), %rdx                                #127.25
        xorl      %r8d, %r8d                                    #124.5
        movslq    %ecx, %r12                                    #124.5
        xorl      %eax, %eax                                    #124.5
        movq      24(%r14), %r13                                #126.25
        movslq    16(%r14), %rcx                                #125.43
        movq      8(%r14), %rsi                                 #125.19
        shlq      $2, %rcx                                      #108.5
        movq      %r12, 80(%rsp)                                #124.5[spill]
        movq      %r13, 88(%rsp)                                #124.5[spill]
        movq      %r11, 96(%rsp)                                #124.5[spill]
        movq      %r15, 8(%rsp)                                 #124.5[spill]
        movq      %rbx, (%rsp)                                  #124.5[spill]
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0x88, 0xff, 0xff, 0xff, 0x22
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 ymm15 ymm16 zmm5 zmm9 zmm13 zmm14
..B1.10:                        # Preds ..B1.40 ..B1.9
                                # Execution count [5.00e+00]
        movq      88(%rsp), %rbx                                #126.25[spill]
        vxorpd    %xmm24, %xmm24, %xmm24                        #130.22
        vmovapd   %xmm24, %xmm18                                #131.22
        movl      (%rbx,%r8,4), %r11d                           #126.25
        vmovapd   %xmm18, %xmm4                                 #132.22
        vmovsd    (%rax,%rdx), %xmm10                           #127.25
        vmovsd    8(%rax,%rdx), %xmm6                           #128.25
        vmovsd    16(%rax,%rdx), %xmm12                         #129.25
        testl     %r11d, %r11d                                  #153.32
        jle       ..B1.40       # Prob 50%                      #153.32
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r11d xmm4 xmm6 xmm10 xmm12 xmm18 xmm24 ymm15 ymm16 zmm5 zmm9 zmm13 zmm14
..B1.11:                        # Preds ..B1.10
                                # Execution count [4.50e+00]
        vpxord    %zmm8, %zmm8, %zmm8                           #130.22
        vmovaps   %zmm8, %zmm7                                  #131.22
        vmovaps   %zmm7, %zmm11                                 #132.22
        cmpl      $8, %r11d                                     #153.13
        jl        ..B1.45       # Prob 10%                      #153.13
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r11d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.12:                        # Preds ..B1.11
                                # Execution count [4.50e+00]
        cmpl      $1200, %r11d                                  #153.13
        jl        ..B1.44       # Prob 10%                      #153.13
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r11d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.13:                        # Preds ..B1.12
                                # Execution count [4.50e+00]
        movq      %rcx, %r15                                    #125.43
        imulq     %rdi, %r15                                    #125.43
        addq      %rsi, %r15                                    #108.5
        movq      %r15, %r12                                    #153.13
        andq      $63, %r12                                     #153.13
        testl     $3, %r12d                                     #153.13
        je        ..B1.15       # Prob 50%                      #153.13
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r15 r11d r12d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.14:                        # Preds ..B1.13
                                # Execution count [2.25e+00]
        xorl      %r12d, %r12d                                  #153.13
        jmp       ..B1.17       # Prob 100%                     #153.13
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r15 r11d r12d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.15:                        # Preds ..B1.13
                                # Execution count [2.25e+00]
        testl     %r12d, %r12d                                  #153.13
        je        ..B1.17       # Prob 50%                      #153.13
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r15 r11d r12d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.16:                        # Preds ..B1.15
                                # Execution count [2.50e+01]
        negl      %r12d                                         #153.13
        addl      $64, %r12d                                    #153.13
        shrl      $2, %r12d                                     #153.13
        cmpl      %r12d, %r11d                                  #153.13
        cmovl     %r11d, %r12d                                  #153.13
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r15 r11d r12d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.17:                        # Preds ..B1.14 ..B1.16 ..B1.15
                                # Execution count [5.00e+00]
        movl      %r11d, %r14d                                  #153.13
        subl      %r12d, %r14d                                  #153.13
        andl      $7, %r14d                                     #153.13
        negl      %r14d                                         #153.13
        addl      %r11d, %r14d                                  #153.13
        cmpl      $1, %r12d                                     #153.13
        jb        ..B1.25       # Prob 50%                      #153.13
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r15 r11d r12d r14d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.18:                        # Preds ..B1.17
                                # Execution count [4.50e+00]
        vmovdqa   %ymm15, %ymm4                                 #153.13
        xorl      %r13d, %r13d                                  #153.13
        vpbroadcastd %r12d, %ymm3                               #153.13
        vbroadcastsd %xmm10, %zmm2                              #127.23
        vbroadcastsd %xmm6, %zmm1                               #128.23
        vbroadcastsd %xmm12, %zmm0                              #129.23
        movslq    %r12d, %rbx                                   #153.13
        movq      %r9, 24(%rsp)                                 #153.13[spill]
        movq      %r10, 32(%rsp)                                #153.13[spill]
                                # LOE rax rdx rcx rbx rsi rdi r8 r13 r15 r11d r12d r14d xmm6 xmm10 xmm12 ymm3 ymm4 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.19:                        # Preds ..B1.23 ..B1.18
                                # Execution count [2.50e+01]
        vpcmpgtd  %ymm4, %ymm3, %k3                             #153.13
        vmovdqu32 (%r15,%r13,4), %ymm17{%k3}{z}                 #154.25
        kmovw     %k3, %r10d                                    #153.13
        vpaddd    %ymm17, %ymm17, %ymm18                        #155.40
        vpaddd    %ymm18, %ymm17, %ymm17                        #155.40
                                # LOE rax rdx rcx rbx rsi rdi r8 r13 r15 r10d r11d r12d r14d xmm6 xmm10 xmm12 ymm3 ymm4 ymm15 ymm16 ymm17 zmm0 zmm1 zmm2 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14 k3
..B1.22:                        # Preds ..B1.19
                                # Execution count [1.25e+01]
        kmovw     %k3, %k1                                      #155.40
        kmovw     %k3, %k2                                      #155.40
        vpxord    %zmm18, %zmm18, %zmm18                        #155.40
        vpxord    %zmm19, %zmm19, %zmm19                        #155.40
        vpxord    %zmm20, %zmm20, %zmm20                        #155.40
        vgatherdpd 16(%rdx,%ymm17,8), %zmm18{%k1}               #155.40
        vgatherdpd 8(%rdx,%ymm17,8), %zmm19{%k2}                #155.40
        vgatherdpd (%rdx,%ymm17,8), %zmm20{%k3}                 #155.40
                                # LOE rax rdx rcx rbx rsi rdi r8 r13 r15 r10d r11d r12d r14d xmm6 xmm10 xmm12 ymm3 ymm4 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14 zmm18 zmm19 zmm20
..B1.23:                        # Preds ..B1.22
                                # Execution count [2.50e+01]
        addq      $8, %r13                                      #153.13
        #vpaddd    %ymm16, %ymm4, %ymm4                          #153.13
        #vsubpd    %zmm18, %zmm0, %zmm29                         #157.40
        #vsubpd    %zmm19, %zmm1, %zmm27                         #156.40
        #vsubpd    %zmm20, %zmm2, %zmm26                         #155.40
        #vmulpd    %zmm27, %zmm27, %zmm25                        #158.53
        #vfmadd231pd %zmm26, %zmm26, %zmm25                      #158.53
        #vfmadd231pd %zmm29, %zmm29, %zmm25                      #158.67
        #vrcp14pd  %zmm25, %zmm24                                #175.42
        #vcmppd    $1, %zmm14, %zmm25, %k2                       #174.26
        #vfpclasspd $30, %zmm24, %k0                             #175.42
        #kmovw     %k2, %r9d                                     #174.26
        #knotw     %k0, %k1                                      #175.42
        #vmovaps   %zmm25, %zmm17                                #175.42
        #andl      %r9d, %r10d                                   #174.26
        #vfnmadd213pd .L_2il0floatpacket.9(%rip){1to8}, %zmm24, %zmm17 #175.42
        #kmovw     %r10d, %k3                                    #178.21
        #vmulpd    %zmm17, %zmm17, %zmm18                        #175.42
        #vfmadd213pd %zmm24, %zmm17, %zmm24{%k1}                 #175.42
        #vfmadd213pd %zmm24, %zmm18, %zmm24{%k1}                 #175.42
        #vmulpd    %zmm13, %zmm24, %zmm19                        #176.42
        #vmulpd    %zmm9, %zmm24, %zmm21                         #177.58
        #vmulpd    %zmm19, %zmm24, %zmm22                        #176.48
        #vmulpd    %zmm22, %zmm24, %zmm20                        #176.54
        #vfmsub213pd %zmm5, %zmm22, %zmm24                       #177.58
        #vmulpd    %zmm21, %zmm20, %zmm23                        #177.65
        #vmulpd    %zmm24, %zmm23, %zmm28                        #177.71
        #vfmadd231pd %zmm26, %zmm28, %zmm8{%k3}                  #178.21
        #vfmadd231pd %zmm27, %zmm28, %zmm7{%k3}                  #179.21
        #vfmadd231pd %zmm29, %zmm28, %zmm11{%k3}                 #180.21
        cmpq      %rbx, %r13                                    #153.13
        jb        ..B1.19       # Prob 82%                      #153.13
                                # LOE rax rdx rcx rbx rsi rdi r8 r13 r15 r11d r12d r14d xmm6 xmm10 xmm12 ymm3 ymm4 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.24:                        # Preds ..B1.23
                                # Execution count [4.50e+00]
        movq      24(%rsp), %r9                                 #[spill]
        movq      32(%rsp), %r10                                #[spill]
        cmpl      %r12d, %r11d                                  #153.13
        je        ..B1.39       # Prob 10%                      #153.13
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r11d r12d r14d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.25:                        # Preds ..B1.24 ..B1.17 ..B1.44
                                # Execution count [2.50e+01]
        lea       8(%r12), %ebx                                 #153.13
        cmpl      %ebx, %r14d                                   #153.13
        jl        ..B1.33       # Prob 50%                      #153.13
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r11d r12d r14d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.26:                        # Preds ..B1.25
                                # Execution count [4.50e+00]
        movq      %rcx, %r13                                    #125.43
        imulq     %rdi, %r13                                    #125.43
        vbroadcastsd %xmm10, %zmm1                              #127.23
        vbroadcastsd %xmm6, %zmm0                               #128.23
        vbroadcastsd %xmm12, %zmm2                              #129.23
        movslq    %r12d, %rbx                                   #153.13
        addq      %rsi, %r13                                    #108.5
        movq      %rax, 40(%rsp)                                #108.5[spill]
        movq      %rcx, 48(%rsp)                                #108.5[spill]
        movq      %rsi, 56(%rsp)                                #108.5[spill]
        movq      %r8, 64(%rsp)                                 #108.5[spill]
        movq      %rdi, 72(%rsp)                                #108.5[spill]
        movq      %r9, 24(%rsp)                                 #108.5[spill]
        movq      %r10, 32(%rsp)                                #108.5[spill]
                                # LOE rdx rbx r13 r11d r12d r14d xmm6 xmm10 xmm12 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.27:                        # Preds ..B1.31 ..B1.26
                                # Execution count [2.50e+01]
        vmovdqu   (%r13,%rbx,4), %ymm3                          #154.25
        vpaddd    %ymm3, %ymm3, %ymm4                           #155.40
        vpaddd    %ymm4, %ymm3, %ymm3                           #155.40
        movl      (%r13,%rbx,4), %r10d                          #154.25
        movl      4(%r13,%rbx,4), %r9d                          #154.25
        movl      8(%r13,%rbx,4), %r8d                          #154.25
        movl      12(%r13,%rbx,4), %edi                         #154.25
        lea       (%r10,%r10,2), %r10d                          #155.40
        movl      16(%r13,%rbx,4), %esi                         #154.25
        lea       (%r9,%r9,2), %r9d                             #155.40
        movl      20(%r13,%rbx,4), %ecx                         #154.25
        lea       (%r8,%r8,2), %r8d                             #155.40
        movl      24(%r13,%rbx,4), %eax                         #154.25
        lea       (%rdi,%rdi,2), %edi                           #155.40
        movl      28(%r13,%rbx,4), %r15d                        #154.25
        lea       (%rsi,%rsi,2), %esi                           #155.40
        lea       (%rcx,%rcx,2), %ecx                           #155.40
        lea       (%rax,%rax,2), %eax                           #155.40
        lea       (%r15,%r15,2), %r15d                          #155.40
                                # LOE rdx rbx r13 eax ecx esi edi r8d r9d r10d r11d r12d r14d r15d xmm6 xmm10 xmm12 ymm3 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.30:                        # Preds ..B1.27
                                # Execution count [1.25e+01]
        vpcmpeqb  %xmm0, %xmm0, %k1                             #155.40
        vpcmpeqb  %xmm0, %xmm0, %k2                             #155.40
        vpcmpeqb  %xmm0, %xmm0, %k3                             #155.40
        vpxord    %zmm4, %zmm4, %zmm4                           #155.40
        vpxord    %zmm17, %zmm17, %zmm17                        #155.40
        vpxord    %zmm18, %zmm18, %zmm18                        #155.40
        vgatherdpd 16(%rdx,%ymm3,8), %zmm4{%k1}                 #155.40
        vgatherdpd 8(%rdx,%ymm3,8), %zmm17{%k2}                 #155.40
        vgatherdpd (%rdx,%ymm3,8), %zmm18{%k3}                  #155.40
                                # LOE rdx rbx r13 r11d r12d r14d xmm6 xmm10 xmm12 ymm15 ymm16 zmm0 zmm1 zmm2 zmm4 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14 zmm17 zmm18
..B1.31:                        # Preds ..B1.30
                                # Execution count [2.50e+01]
        addl      $8, %r12d                                     #153.13
        addq      $8, %rbx                                      #153.13
        #vsubpd    %zmm4, %zmm2, %zmm26                          #157.40
        #vsubpd    %zmm17, %zmm0, %zmm24                         #156.40
        #vsubpd    %zmm18, %zmm1, %zmm23                         #155.40
        #vmulpd    %zmm24, %zmm24, %zmm3                         #158.53
        #vfmadd231pd %zmm23, %zmm23, %zmm3                       #158.53
        #vfmadd231pd %zmm26, %zmm26, %zmm3                       #158.67
        #vrcp14pd  %zmm3, %zmm22                                 #175.42
        #vcmppd    $1, %zmm14, %zmm3, %k2                        #174.26
        #vfpclasspd $30, %zmm22, %k0                             #175.42
        #vfnmadd213pd .L_2il0floatpacket.9(%rip){1to8}, %zmm22, %zmm3 #175.42
        #knotw     %k0, %k1                                      #175.42
        #vmulpd    %zmm3, %zmm3, %zmm4                           #175.42
        #vfmadd213pd %zmm22, %zmm3, %zmm22{%k1}                  #175.42
        #vfmadd213pd %zmm22, %zmm4, %zmm22{%k1}                  #175.42
        #vmulpd    %zmm13, %zmm22, %zmm17                        #176.42
        #vmulpd    %zmm9, %zmm22, %zmm19                         #177.58
        #vmulpd    %zmm17, %zmm22, %zmm20                        #176.48
        #vmulpd    %zmm20, %zmm22, %zmm18                        #176.54
        #vfmsub213pd %zmm5, %zmm20, %zmm22                       #177.58
        #vmulpd    %zmm19, %zmm18, %zmm21                        #177.65
        #vmulpd    %zmm22, %zmm21, %zmm25                        #177.71
        #vfmadd231pd %zmm23, %zmm25, %zmm8{%k2}                  #178.21
        #vfmadd231pd %zmm24, %zmm25, %zmm7{%k2}                  #179.21
        #vfmadd231pd %zmm26, %zmm25, %zmm11{%k2}                 #180.21
        cmpl      %r14d, %r12d                                  #153.13
        jb        ..B1.27       # Prob 82%                      #153.13
                                # LOE rdx rbx r13 r11d r12d r14d xmm6 xmm10 xmm12 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.32:                        # Preds ..B1.31
                                # Execution count [4.50e+00]
        movq      40(%rsp), %rax                                #[spill]
        movq      48(%rsp), %rcx                                #[spill]
        movq      56(%rsp), %rsi                                #[spill]
        movq      64(%rsp), %r8                                 #[spill]
        movq      72(%rsp), %rdi                                #[spill]
        movq      24(%rsp), %r9                                 #[spill]
        movq      32(%rsp), %r10                                #[spill]
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r11d r14d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.33:                        # Preds ..B1.32 ..B1.25 ..B1.45
                                # Execution count [5.00e+00]
        lea       1(%r14), %ebx                                 #153.13
        cmpl      %r11d, %ebx                                   #153.13
        ja        ..B1.39       # Prob 50%                      #153.13
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r11d r14d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.34:                        # Preds ..B1.33
                                # Execution count [2.50e+01]
        imulq     %rcx, %rdi                                    #125.43
        vbroadcastsd %xmm10, %zmm4                              #127.23
        subl      %r14d, %r11d                                  #153.13
        addq      %rsi, %rdi                                    #108.5
        vpbroadcastd %r11d, %ymm0                               #153.13
        vpcmpgtd  %ymm15, %ymm0, %k3                            #153.13
        movslq    %r14d, %r14                                   #153.13
        vmovdqu32 (%rdi,%r14,4), %ymm1{%k3}{z}                  #154.25
        kmovw     %k3, %edi                                     #153.13
        vpaddd    %ymm1, %ymm1, %ymm2                           #155.40
        vpaddd    %ymm2, %ymm1, %ymm0                           #155.40
                                # LOE rax rdx rcx rsi r8 r9 r10 edi xmm6 xmm12 ymm0 ymm15 ymm16 zmm4 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14 k3
..B1.37:                        # Preds ..B1.34
                                # Execution count [1.25e+01]
        kmovw     %k3, %k1                                      #155.40
        kmovw     %k3, %k2                                      #155.40
        vpxord    %zmm1, %zmm1, %zmm1                           #155.40
        vpxord    %zmm2, %zmm2, %zmm2                           #155.40
        vpxord    %zmm3, %zmm3, %zmm3                           #155.40
        vgatherdpd 16(%rdx,%ymm0,8), %zmm1{%k1}                 #155.40
        vgatherdpd 8(%rdx,%ymm0,8), %zmm2{%k2}                  #155.40
        vgatherdpd (%rdx,%ymm0,8), %zmm3{%k3}                   #155.40
                                # LOE rax rdx rcx rsi r8 r9 r10 edi xmm6 xmm12 ymm15 ymm16 zmm1 zmm2 zmm3 zmm4 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.38:                        # Preds ..B1.37
                                # Execution count [2.50e+01]
        #vbroadcastsd %xmm6, %zmm6                               #128.23
        #vbroadcastsd %xmm12, %zmm12                             #129.23
        #vsubpd    %zmm1, %zmm12, %zmm23                         #157.40
        #vsubpd    %zmm2, %zmm6, %zmm21                          #156.40
        #vsubpd    %zmm3, %zmm4, %zmm20                          #155.40
        #vmulpd    %zmm21, %zmm21, %zmm19                        #158.53
        #vfmadd231pd %zmm20, %zmm20, %zmm19                      #158.53
        #vfmadd231pd %zmm23, %zmm23, %zmm19                      #158.67
        #vrcp14pd  %zmm19, %zmm18                                #175.42
        #vcmppd    $1, %zmm14, %zmm19, %k2                       #174.26
        #vfpclasspd $30, %zmm18, %k0                             #175.42
        #kmovw     %k2, %ebx                                     #174.26
        #knotw     %k0, %k1                                      #175.42
        #vmovaps   %zmm19, %zmm0                                 #175.42
        #andl      %ebx, %edi                                    #174.26
        #vfnmadd213pd .L_2il0floatpacket.9(%rip){1to8}, %zmm18, %zmm0 #175.42
        #kmovw     %edi, %k3                                     #178.21
        #vmulpd    %zmm0, %zmm0, %zmm1                           #175.42
        #vfmadd213pd %zmm18, %zmm0, %zmm18{%k1}                  #175.42
        #vfmadd213pd %zmm18, %zmm1, %zmm18{%k1}                  #175.42
        #vmulpd    %zmm13, %zmm18, %zmm2                         #176.42
        #vmulpd    %zmm9, %zmm18, %zmm4                          #177.58
        #vmulpd    %zmm2, %zmm18, %zmm10                         #176.48
        #vmulpd    %zmm10, %zmm18, %zmm3                         #176.54
        #vfmsub213pd %zmm5, %zmm10, %zmm18                       #177.58
        #vmulpd    %zmm4, %zmm3, %zmm17                          #177.65
        #vmulpd    %zmm18, %zmm17, %zmm22                        #177.71
        #vfmadd231pd %zmm20, %zmm22, %zmm8{%k3}                  #178.21
        #vfmadd231pd %zmm21, %zmm22, %zmm7{%k3}                  #179.21
        #vfmadd231pd %zmm23, %zmm22, %zmm11{%k3}                 #180.21
                                # LOE rax rdx rcx rsi r8 r9 r10 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.39:                        # Preds ..B1.24 ..B1.38 ..B1.33
                                # Execution count [4.50e+00]
        vmovups   .L_2il0floatpacket.10(%rip), %zmm19           #132.22
        vpermd    %zmm11, %zmm19, %zmm0                         #132.22
        vpermd    %zmm7, %zmm19, %zmm6                          #131.22
        vpermd    %zmm8, %zmm19, %zmm20                         #130.22
        vaddpd    %zmm11, %zmm0, %zmm11                         #132.22
        vaddpd    %zmm7, %zmm6, %zmm7                           #131.22
        vaddpd    %zmm8, %zmm20, %zmm8                          #130.22
        vpermpd   $78, %zmm11, %zmm1                            #132.22
        vpermpd   $78, %zmm7, %zmm10                            #131.22
        vpermpd   $78, %zmm8, %zmm21                            #130.22
        vaddpd    %zmm1, %zmm11, %zmm2                          #132.22
        vaddpd    %zmm10, %zmm7, %zmm12                         #131.22
        vaddpd    %zmm21, %zmm8, %zmm22                         #130.22
        vpermpd   $177, %zmm2, %zmm3                            #132.22
        vpermpd   $177, %zmm12, %zmm17                          #131.22
        vpermpd   $177, %zmm22, %zmm23                          #130.22
        vaddpd    %zmm3, %zmm2, %zmm4                           #132.22
        vaddpd    %zmm17, %zmm12, %zmm18                        #131.22
        vaddpd    %zmm23, %zmm22, %zmm24                        #130.22
                                # LOE rax rdx rcx rsi r8 r9 r10 xmm4 xmm18 xmm24 ymm15 ymm16 zmm5 zmm9 zmm13 zmm14
..B1.40:                        # Preds ..B1.39 ..B1.10
                                # Execution count [5.00e+00]
        movq      96(%rsp), %rbx                                #188.9[spill]
        addq      $24, %rax                                     #124.5
        movslq    %r8d, %rdi                                    #124.32
        incq      %rdi                                          #124.32
        #vaddsd    (%rbx,%r8,8), %xmm24, %xmm0                   #188.9
        #vmovsd    %xmm0, (%rbx,%r8,8)                           #188.9
        #vaddsd    (%r10,%r8,8), %xmm18, %xmm1                   #189.9
        #vmovsd    %xmm1, (%r10,%r8,8)                           #189.9
        #vaddsd    (%r9,%r8,8), %xmm4, %xmm2                     #190.9
        #vmovsd    %xmm2, (%r9,%r8,8)                            #190.9
        incq      %r8                                           #124.5
        cmpq      80(%rsp), %r8                                 #124.5[spill]
        jb        ..B1.10       # Prob 82%                      #124.5
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 ymm15 ymm16 zmm5 zmm9 zmm13 zmm14
..B1.41:                        # Preds ..B1.40
                                # Execution count [9.00e-01]
        movq      8(%rsp), %r15                                 #[spill]
	.cfi_restore 15
        movq      (%rsp), %rbx                                  #[spill]
	.cfi_restore 3
                                # LOE rbx r15
..B1.42:                        # Preds ..B1.2 ..B1.41
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #201.16
        vzeroupper                                              #201.16
..___tag_value_computeForce.43:
#       getTimeStamp()
        call      getTimeStamp                                  #201.16
..___tag_value_computeForce.44:
                                # LOE rbx r15 xmm0
..B1.43:                        # Preds ..B1.42
                                # Execution count [1.00e+00]
        vsubsd    16(%rsp), %xmm0, %xmm0                        #204.14[spill]
        addq      $104, %rsp                                    #204.14
	.cfi_restore 14
        popq      %r14                                          #204.14
	.cfi_restore 13
        popq      %r13                                          #204.14
	.cfi_restore 12
        popq      %r12                                          #204.14
        movq      %rbp, %rsp                                    #204.14
        popq      %rbp                                          #204.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #204.14
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0x80, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0x88, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B1.44:                        # Preds ..B1.12
                                # Execution count [4.50e-01]: Infreq
        movl      %r11d, %r14d                                  #153.13
        xorl      %r12d, %r12d                                  #153.13
        andl      $-8, %r14d                                    #153.13
        jmp       ..B1.25       # Prob 100%                     #153.13
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r11d r12d r14d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.45:                        # Preds ..B1.11
                                # Execution count [4.50e-01]: Infreq
        xorl      %r14d, %r14d                                  #153.13
        jmp       ..B1.33       # Prob 100%                     #153.13
        .align    16,0x90
                                # LOE rax rdx rcx rsi rdi r8 r9 r10 r11d r14d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
	.cfi_endproc
# mark_end;
	.type	computeForce,@function
	.size	computeForce,.-computeForce
..LNcomputeForce.0:
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
	.data
	.section .note.GNU-stack, ""
# End
