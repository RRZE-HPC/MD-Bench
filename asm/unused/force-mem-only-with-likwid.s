# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 19.0.5.281 Build 20190815";
# mark_description "-I/mnt/opt/likwid-5.2-dev/include -I./src/includes -S -D_GNU_SOURCE -DLIKWID_PERFMON -DAOS -DPRECISION=2 -DN";
# mark_description "EIGHBORS_LOOP_RUNS=1 -DVECTOR_WIDTH=8 -DALIGNMENT=64 -restrict -Ofast -xCORE-AVX512 -qopt-zmm-usage=high -o ";
# mark_description "ICC/force.s";
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
        subq      $88, %rsp                                     #121.112
        xorl      %eax, %eax                                    #124.16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
        movq      %rdx, %r15                                    #121.112
        movq      %rsi, %r12                                    #121.112
        movq      %rdi, %rbx                                    #121.112
..___tag_value_computeForce.11:
#       getTimeStamp()
        call      getTimeStamp                                  #124.16
..___tag_value_computeForce.12:
                                # LOE rbx r12 r15 xmm0
..B1.51:                        # Preds ..B1.1
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 24(%rsp)                               #124.16[spill]
                                # LOE rbx r12 r15
..B1.2:                         # Preds ..B1.51
                                # Execution count [1.00e+00]
        movl      4(%r12), %r13d                                #125.18
        movq      64(%r12), %r9                                 #127.20
        movq      72(%r12), %r14                                #127.45
        movq      80(%r12), %r8                                 #127.70
        vmovsd    72(%rbx), %xmm2                               #129.27
        vmovsd    8(%rbx), %xmm1                                #130.23
        vmovsd    (%rbx), %xmm0                                 #131.24
        testl     %r13d, %r13d                                  #134.24
        jle       ..B1.43       # Prob 50%                      #134.24
                                # LOE r8 r9 r12 r14 r15 r13d xmm0 xmm1 xmm2
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
        xorl      %ebx, %ebx                                    #134.5
        movl      %r13d, %edx                                   #134.5
        xorl      %ecx, %ecx                                    #134.5
        movl      $1, %esi                                      #134.5
        xorl      %eax, %eax                                    #135.17
        shrl      $1, %edx                                      #134.5
        je        ..B1.7        # Prob 9%                       #134.5
                                # LOE rax rdx rcx rbx r8 r9 r12 r14 r15 esi r13d xmm0 xmm1 xmm2
..B1.5:                         # Preds ..B1.3 ..B1.5
                                # Execution count [2.50e+00]
        movq      %rax, (%rcx,%r9)                              #135.9
        incq      %rbx                                          #134.5
        movq      %rax, (%rcx,%r14)                             #136.9
        movq      %rax, (%rcx,%r8)                              #137.9
        movq      %rax, 8(%rcx,%r9)                             #135.9
        movq      %rax, 8(%rcx,%r14)                            #136.9
        movq      %rax, 8(%rcx,%r8)                             #137.9
        addq      $16, %rcx                                     #134.5
        cmpq      %rdx, %rbx                                    #134.5
        jb        ..B1.5        # Prob 63%                      #134.5
                                # LOE rax rdx rcx rbx r8 r9 r12 r14 r15 r13d xmm0 xmm1 xmm2
..B1.6:                         # Preds ..B1.5
                                # Execution count [9.00e-01]
        lea       1(%rbx,%rbx), %esi                            #135.9
                                # LOE rax r8 r9 r12 r14 r15 esi r13d xmm0 xmm1 xmm2
..B1.7:                         # Preds ..B1.3 ..B1.6
                                # Execution count [1.00e+00]
        lea       -1(%rsi), %edx                                #134.5
        cmpl      %r13d, %edx                                   #134.5
        jae       ..B1.9        # Prob 9%                       #134.5
                                # LOE rax r8 r9 r12 r14 r15 esi r13d xmm0 xmm1 xmm2
..B1.8:                         # Preds ..B1.7
                                # Execution count [9.00e-01]
        movslq    %esi, %rsi                                    #134.5
        movq      %rax, -8(%r9,%rsi,8)                          #135.9
        movq      %rax, -8(%r14,%rsi,8)                         #136.9
        movq      %rax, -8(%r8,%rsi,8)                          #137.9
                                # LOE r8 r9 r12 r14 r15 r13d xmm0 xmm1 xmm2
..B1.9:                         # Preds ..B1.7 ..B1.8
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.0, %edi                         #141.5
        movq      %r8, 32(%rsp)                                 #141.5[spill]
        movq      %r9, 80(%rsp)                                 #141.5[spill]
        vmovsd    %xmm2, (%rsp)                                 #141.5[spill]
        vmovsd    %xmm1, 8(%rsp)                                #141.5[spill]
        vmovsd    %xmm0, 16(%rsp)                               #141.5[spill]
..___tag_value_computeForce.18:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #141.5
..___tag_value_computeForce.19:
                                # LOE r12 r14 r15 r13d
..B1.10:                        # Preds ..B1.9
                                # Execution count [9.00e-01]
        vmovsd    16(%rsp), %xmm0                               #[spill]
        xorl      %esi, %esi                                    #143.15
        vmovsd    (%rsp), %xmm2                                 #[spill]
        xorl      %eax, %eax                                    #143.5
        vmulsd    %xmm2, %xmm2, %xmm13                          #129.45
        xorl      %edi, %edi                                    #143.5
        vmovdqu32 .L_2il0floatpacket.0(%rip), %ymm16            #173.13
        vmulsd    .L_2il0floatpacket.3(%rip), %xmm0, %xmm0      #197.45
        vmovdqu   .L_2il0floatpacket.1(%rip), %ymm15            #173.13
        vmovups   .L_2il0floatpacket.4(%rip), %zmm5             #197.58
        vmovsd    8(%rsp), %xmm1                                #[spill]
        vbroadcastsd %xmm13, %zmm14                             #129.25
        vbroadcastsd %xmm1, %zmm13                              #130.21
        vbroadcastsd %xmm0, %zmm9                               #197.45
        movslq    %r13d, %r13                                   #143.5
        movq      24(%r15), %r10                                #145.25
        movslq    16(%r15), %rdx                                #144.43
        movq      8(%r15), %rcx                                 #144.19
        movq      32(%rsp), %r8                                 #[spill]
        movq      16(%r12), %rbx                                #146.25
        shlq      $2, %rdx                                      #126.5
        movq      %r13, 64(%rsp)                                #143.5[spill]
        movq      %r10, 72(%rsp)                                #143.5[spill]
                                # LOE rax rdx rcx rbx rsi rdi r8 r14 ymm15 ymm16 zmm5 zmm9 zmm13 zmm14
..B1.11:                        # Preds ..B1.41 ..B1.10
                                # Execution count [5.00e+00]
        movq      72(%rsp), %r9                                 #145.25[spill]
        vxorpd    %xmm24, %xmm24, %xmm24                        #149.22
        vmovapd   %xmm24, %xmm18                                #150.22
        movl      (%r9,%rax,4), %r10d                           #145.25
        vmovapd   %xmm18, %xmm4                                 #151.22
        vmovsd    (%rdi,%rbx), %xmm10                           #146.25
        vmovsd    8(%rdi,%rbx), %xmm6                           #147.25
        vmovsd    16(%rdi,%rbx), %xmm12                         #148.25
        testl     %r10d, %r10d                                  #173.32
        jle       ..B1.41       # Prob 50%                      #173.32
                                # LOE rax rdx rcx rbx rsi rdi r8 r14 r10d xmm4 xmm6 xmm10 xmm12 xmm18 xmm24 ymm15 ymm16 zmm5 zmm9 zmm13 zmm14
..B1.12:                        # Preds ..B1.11
                                # Execution count [4.50e+00]
        vpxord    %zmm8, %zmm8, %zmm8                           #149.22
        vmovaps   %zmm8, %zmm7                                  #150.22
        vmovaps   %zmm7, %zmm11                                 #151.22
        cmpl      $8, %r10d                                     #173.13
        jl        ..B1.48       # Prob 10%                      #173.13
                                # LOE rax rdx rcx rbx rsi rdi r8 r14 r10d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.13:                        # Preds ..B1.12
                                # Execution count [4.50e+00]
        cmpl      $1200, %r10d                                  #173.13
        jl        ..B1.47       # Prob 10%                      #173.13
                                # LOE rax rdx rcx rbx rsi rdi r8 r14 r10d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.14:                        # Preds ..B1.13
                                # Execution count [4.50e+00]
        movq      %rdx, %r15                                    #144.43
        imulq     %rsi, %r15                                    #144.43
        addq      %rcx, %r15                                    #126.5
        movq      %r15, %r11                                    #173.13
        andq      $63, %r11                                     #173.13
        testl     $3, %r11d                                     #173.13
        je        ..B1.16       # Prob 50%                      #173.13
                                # LOE rax rdx rcx rbx rsi rdi r8 r14 r15 r10d r11d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.15:                        # Preds ..B1.14
                                # Execution count [2.25e+00]
        xorl      %r11d, %r11d                                  #173.13
        jmp       ..B1.18       # Prob 100%                     #173.13
                                # LOE rax rdx rcx rbx rsi rdi r8 r14 r15 r10d r11d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.16:                        # Preds ..B1.14
                                # Execution count [2.25e+00]
        testl     %r11d, %r11d                                  #173.13
        je        ..B1.18       # Prob 50%                      #173.13
                                # LOE rax rdx rcx rbx rsi rdi r8 r14 r15 r10d r11d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.17:                        # Preds ..B1.16
                                # Execution count [2.50e+01]
        negl      %r11d                                         #173.13
        addl      $64, %r11d                                    #173.13
        shrl      $2, %r11d                                     #173.13
        cmpl      %r11d, %r10d                                  #173.13
        cmovl     %r10d, %r11d                                  #173.13
                                # LOE rax rdx rcx rbx rsi rdi r8 r14 r15 r10d r11d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.18:                        # Preds ..B1.15 ..B1.17 ..B1.16
                                # Execution count [5.00e+00]
        movl      %r10d, %r13d                                  #173.13
        subl      %r11d, %r13d                                  #173.13
        andl      $7, %r13d                                     #173.13
        negl      %r13d                                         #173.13
        addl      %r10d, %r13d                                  #173.13
        cmpl      $1, %r11d                                     #173.13
        jb        ..B1.26       # Prob 50%                      #173.13
                                # LOE rax rdx rcx rbx rsi rdi r8 r14 r15 r10d r11d r13d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.19:                        # Preds ..B1.18
                                # Execution count [4.50e+00]
        vmovdqa   %ymm15, %ymm4                                 #173.13
        xorl      %r12d, %r12d                                  #173.13
        vpbroadcastd %r11d, %ymm3                               #173.13
        vbroadcastsd %xmm10, %zmm2                              #146.23
        vbroadcastsd %xmm6, %zmm1                               #147.23
        vbroadcastsd %xmm12, %zmm0                              #148.23
        movslq    %r11d, %r9                                    #173.13
        movq      %r8, 32(%rsp)                                 #173.13[spill]
        movq      %r14, (%rsp)                                  #173.13[spill]
                                # LOE rax rdx rcx rbx rsi rdi r9 r12 r15 r10d r11d r13d xmm6 xmm10 xmm12 ymm3 ymm4 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.20:                        # Preds ..B1.24 ..B1.19
                                # Execution count [2.50e+01]
        vpcmpgtd  %ymm4, %ymm3, %k3                             #173.13
        vmovdqu32 (%r15,%r12,4), %ymm17{%k3}{z}                 #174.25
        kmovw     %k3, %r14d                                    #173.13
        vpaddd    %ymm17, %ymm17, %ymm18                        #175.40
        vpaddd    %ymm18, %ymm17, %ymm17                        #175.40
                                # LOE rax rdx rcx rbx rsi rdi r9 r12 r15 r10d r11d r13d r14d xmm6 xmm10 xmm12 ymm3 ymm4 ymm15 ymm16 ymm17 zmm0 zmm1 zmm2 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14 k3
..B1.23:                        # Preds ..B1.20
                                # Execution count [1.25e+01]
        kmovw     %k3, %k1                                      #175.40
        kmovw     %k3, %k2                                      #175.40
        vpxord    %zmm18, %zmm18, %zmm18                        #175.40
        vpxord    %zmm19, %zmm19, %zmm19                        #175.40
        vpxord    %zmm20, %zmm20, %zmm20                        #175.40
        vgatherdpd 16(%rbx,%ymm17,8), %zmm18{%k1}               #175.40
        vgatherdpd 8(%rbx,%ymm17,8), %zmm19{%k2}                #175.40
        vgatherdpd (%rbx,%ymm17,8), %zmm20{%k3}                 #175.40
                                # LOE rax rdx rcx rbx rsi rdi r9 r12 r15 r10d r11d r13d r14d xmm6 xmm10 xmm12 ymm3 ymm4 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14 zmm18 zmm19 zmm20
..B1.24:                        # Preds ..B1.23
                                # Execution count [2.50e+01]
        addq      $8, %r12                                      #173.13
        #vpaddd    %ymm16, %ymm4, %ymm4                          #173.13
        #vsubpd    %zmm18, %zmm0, %zmm29                         #177.40
        #vsubpd    %zmm19, %zmm1, %zmm27                         #176.40
        #vsubpd    %zmm20, %zmm2, %zmm26                         #175.40
        #vmulpd    %zmm27, %zmm27, %zmm25                        #178.53
        #vfmadd231pd %zmm26, %zmm26, %zmm25                      #178.53
        #vfmadd231pd %zmm29, %zmm29, %zmm25                      #178.67
        #vrcp14pd  %zmm25, %zmm24                                #195.42
        #vcmppd    $1, %zmm14, %zmm25, %k2                       #194.26
        #vfpclasspd $30, %zmm24, %k0                             #195.42
        #kmovw     %k2, %r8d                                     #194.26
        #knotw     %k0, %k1                                      #195.42
        #vmovaps   %zmm25, %zmm17                                #195.42
        #andl      %r8d, %r14d                                   #194.26
        #vfnmadd213pd .L_2il0floatpacket.9(%rip){1to8}, %zmm24, %zmm17 #195.42
        #kmovw     %r14d, %k3                                    #198.21
        #vmulpd    %zmm17, %zmm17, %zmm18                        #195.42
        #vfmadd213pd %zmm24, %zmm17, %zmm24{%k1}                 #195.42
        #vfmadd213pd %zmm24, %zmm18, %zmm24{%k1}                 #195.42
        #vmulpd    %zmm13, %zmm24, %zmm19                        #196.42
        #vmulpd    %zmm9, %zmm24, %zmm21                         #197.58
        #vmulpd    %zmm19, %zmm24, %zmm22                        #196.48
        #vmulpd    %zmm22, %zmm24, %zmm20                        #196.54
        #vfmsub213pd %zmm5, %zmm22, %zmm24                       #197.58
        #vmulpd    %zmm21, %zmm20, %zmm23                        #197.65
        #vmulpd    %zmm24, %zmm23, %zmm28                        #197.71
        #vfmadd231pd %zmm26, %zmm28, %zmm8{%k3}                  #198.21
        #vfmadd231pd %zmm27, %zmm28, %zmm7{%k3}                  #199.21
        #vfmadd231pd %zmm29, %zmm28, %zmm11{%k3}                 #200.21
        cmpq      %r9, %r12                                     #173.13
        jb        ..B1.20       # Prob 82%                      #173.13
                                # LOE rax rdx rcx rbx rsi rdi r9 r12 r15 r10d r11d r13d xmm6 xmm10 xmm12 ymm3 ymm4 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.25:                        # Preds ..B1.24
                                # Execution count [4.50e+00]
        movq      32(%rsp), %r8                                 #[spill]
        movq      (%rsp), %r14                                  #[spill]
        cmpl      %r11d, %r10d                                  #173.13
        je        ..B1.40       # Prob 10%                      #173.13
                                # LOE rax rdx rcx rbx rsi rdi r8 r14 r10d r11d r13d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.26:                        # Preds ..B1.25 ..B1.18 ..B1.47
                                # Execution count [2.50e+01]
        lea       8(%r11), %r9d                                 #173.13
        cmpl      %r9d, %r13d                                   #173.13
        jl        ..B1.34       # Prob 50%                      #173.13
                                # LOE rax rdx rcx rbx rsi rdi r8 r14 r10d r11d r13d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.27:                        # Preds ..B1.26
                                # Execution count [4.50e+00]
        movq      %rdx, %r12                                    #144.43
        imulq     %rsi, %r12                                    #144.43
        vbroadcastsd %xmm10, %zmm1                              #146.23
        vbroadcastsd %xmm6, %zmm0                               #147.23
        vbroadcastsd %xmm12, %zmm2                              #148.23
        movslq    %r11d, %r9                                    #173.13
        addq      %rcx, %r12                                    #126.5
        movq      %rdi, 8(%rsp)                                 #126.5[spill]
        movq      %rdx, 16(%rsp)                                #126.5[spill]
        movq      %rcx, 40(%rsp)                                #126.5[spill]
        movq      %rax, 48(%rsp)                                #126.5[spill]
        movq      %rsi, 56(%rsp)                                #126.5[spill]
        movq      %r8, 32(%rsp)                                 #126.5[spill]
        movq      %r14, (%rsp)                                  #126.5[spill]
                                # LOE rbx r9 r12 r10d r11d r13d xmm6 xmm10 xmm12 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.28:                        # Preds ..B1.32 ..B1.27
                                # Execution count [2.50e+01]
        vmovdqu   (%r12,%r9,4), %ymm3                           #174.25
        vpaddd    %ymm3, %ymm3, %ymm4                           #175.40
        vpaddd    %ymm4, %ymm3, %ymm3                           #175.40
        movl      (%r12,%r9,4), %r14d                           #174.25
        movl      4(%r12,%r9,4), %r8d                           #174.25
        movl      8(%r12,%r9,4), %edi                           #174.25
        movl      12(%r12,%r9,4), %esi                          #174.25
        lea       (%r14,%r14,2), %r14d                          #175.40
        movl      16(%r12,%r9,4), %ecx                          #174.25
        lea       (%r8,%r8,2), %r8d                             #175.40
        movl      20(%r12,%r9,4), %edx                          #174.25
        lea       (%rdi,%rdi,2), %edi                           #175.40
        movl      24(%r12,%r9,4), %eax                          #174.25
        lea       (%rsi,%rsi,2), %esi                           #175.40
        movl      28(%r12,%r9,4), %r15d                         #174.25
        lea       (%rcx,%rcx,2), %ecx                           #175.40
        lea       (%rdx,%rdx,2), %edx                           #175.40
        lea       (%rax,%rax,2), %eax                           #175.40
        lea       (%r15,%r15,2), %r15d                          #175.40
                                # LOE rbx r9 r12 eax edx ecx esi edi r8d r10d r11d r13d r14d r15d xmm6 xmm10 xmm12 ymm3 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.31:                        # Preds ..B1.28
                                # Execution count [1.25e+01]
        vpcmpeqb  %xmm0, %xmm0, %k1                             #175.40
        vpcmpeqb  %xmm0, %xmm0, %k2                             #175.40
        vpcmpeqb  %xmm0, %xmm0, %k3                             #175.40
        vpxord    %zmm4, %zmm4, %zmm4                           #175.40
        vpxord    %zmm17, %zmm17, %zmm17                        #175.40
        vpxord    %zmm18, %zmm18, %zmm18                        #175.40
        vgatherdpd 16(%rbx,%ymm3,8), %zmm4{%k1}                 #175.40
        vgatherdpd 8(%rbx,%ymm3,8), %zmm17{%k2}                 #175.40
        vgatherdpd (%rbx,%ymm3,8), %zmm18{%k3}                  #175.40
                                # LOE rbx r9 r12 r10d r11d r13d xmm6 xmm10 xmm12 ymm15 ymm16 zmm0 zmm1 zmm2 zmm4 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14 zmm17 zmm18
..B1.32:                        # Preds ..B1.31
                                # Execution count [2.50e+01]
        addl      $8, %r11d                                     #173.13
        addq      $8, %r9                                       #173.13
        #vsubpd    %zmm4, %zmm2, %zmm26                          #177.40
        #vsubpd    %zmm17, %zmm0, %zmm24                         #176.40
        #vsubpd    %zmm18, %zmm1, %zmm23                         #175.40
        #vmulpd    %zmm24, %zmm24, %zmm3                         #178.53
        #vfmadd231pd %zmm23, %zmm23, %zmm3                       #178.53
        #vfmadd231pd %zmm26, %zmm26, %zmm3                       #178.67
        #vrcp14pd  %zmm3, %zmm22                                 #195.42
        #vcmppd    $1, %zmm14, %zmm3, %k2                        #194.26
        #vfpclasspd $30, %zmm22, %k0                             #195.42
        #vfnmadd213pd .L_2il0floatpacket.9(%rip){1to8}, %zmm22, %zmm3 #195.42
        #knotw     %k0, %k1                                      #195.42
        #vmulpd    %zmm3, %zmm3, %zmm4                           #195.42
        #vfmadd213pd %zmm22, %zmm3, %zmm22{%k1}                  #195.42
        #vfmadd213pd %zmm22, %zmm4, %zmm22{%k1}                  #195.42
        #vmulpd    %zmm13, %zmm22, %zmm17                        #196.42
        #vmulpd    %zmm9, %zmm22, %zmm19                         #197.58
        #vmulpd    %zmm17, %zmm22, %zmm20                        #196.48
        #vmulpd    %zmm20, %zmm22, %zmm18                        #196.54
        #vfmsub213pd %zmm5, %zmm20, %zmm22                       #197.58
        #vmulpd    %zmm19, %zmm18, %zmm21                        #197.65
        #vmulpd    %zmm22, %zmm21, %zmm25                        #197.71
        #vfmadd231pd %zmm23, %zmm25, %zmm8{%k2}                  #198.21
        #vfmadd231pd %zmm24, %zmm25, %zmm7{%k2}                  #199.21
        #vfmadd231pd %zmm26, %zmm25, %zmm11{%k2}                 #200.21
        cmpl      %r13d, %r11d                                  #173.13
        jb        ..B1.28       # Prob 82%                      #173.13
                                # LOE rbx r9 r12 r10d r11d r13d xmm6 xmm10 xmm12 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.33:                        # Preds ..B1.32
                                # Execution count [4.50e+00]
        movq      8(%rsp), %rdi                                 #[spill]
        movq      16(%rsp), %rdx                                #[spill]
        movq      40(%rsp), %rcx                                #[spill]
        movq      48(%rsp), %rax                                #[spill]
        movq      56(%rsp), %rsi                                #[spill]
        movq      32(%rsp), %r8                                 #[spill]
        movq      (%rsp), %r14                                  #[spill]
                                # LOE rax rdx rcx rbx rsi rdi r8 r14 r10d r13d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.34:                        # Preds ..B1.33 ..B1.26 ..B1.48
                                # Execution count [5.00e+00]
        lea       1(%r13), %r9d                                 #173.13
        cmpl      %r10d, %r9d                                   #173.13
        ja        ..B1.40       # Prob 50%                      #173.13
                                # LOE rax rdx rcx rbx rsi rdi r8 r14 r10d r13d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.35:                        # Preds ..B1.34
                                # Execution count [2.50e+01]
        imulq     %rdx, %rsi                                    #144.43
        vbroadcastsd %xmm10, %zmm4                              #146.23
        subl      %r13d, %r10d                                  #173.13
        addq      %rcx, %rsi                                    #126.5
        vpbroadcastd %r10d, %ymm0                               #173.13
        vpcmpgtd  %ymm15, %ymm0, %k3                            #173.13
        movslq    %r13d, %r13                                   #173.13
        kmovw     %k3, %r9d                                     #173.13
        vmovdqu32 (%rsi,%r13,4), %ymm1{%k3}{z}                  #174.25
        vpaddd    %ymm1, %ymm1, %ymm2                           #175.40
        vpaddd    %ymm2, %ymm1, %ymm0                           #175.40
                                # LOE rax rdx rcx rbx rdi r8 r14 r9d xmm6 xmm12 ymm0 ymm15 ymm16 zmm4 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14 k3
..B1.38:                        # Preds ..B1.35
                                # Execution count [1.25e+01]
        kmovw     %k3, %k1                                      #175.40
        kmovw     %k3, %k2                                      #175.40
        vpxord    %zmm1, %zmm1, %zmm1                           #175.40
        vpxord    %zmm2, %zmm2, %zmm2                           #175.40
        vpxord    %zmm3, %zmm3, %zmm3                           #175.40
        vgatherdpd 16(%rbx,%ymm0,8), %zmm1{%k1}                 #175.40
        vgatherdpd 8(%rbx,%ymm0,8), %zmm2{%k2}                  #175.40
        vgatherdpd (%rbx,%ymm0,8), %zmm3{%k3}                   #175.40
                                # LOE rax rdx rcx rbx rdi r8 r14 r9d xmm6 xmm12 ymm15 ymm16 zmm1 zmm2 zmm3 zmm4 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.39:                        # Preds ..B1.38
                                # Execution count [2.50e+01]
        #vbroadcastsd %xmm6, %zmm6                               #147.23
        #vbroadcastsd %xmm12, %zmm12                             #148.23
        #vsubpd    %zmm1, %zmm12, %zmm23                         #177.40
        #vsubpd    %zmm2, %zmm6, %zmm21                          #176.40
        #vsubpd    %zmm3, %zmm4, %zmm20                          #175.40
        #vmulpd    %zmm21, %zmm21, %zmm19                        #178.53
        #vfmadd231pd %zmm20, %zmm20, %zmm19                      #178.53
        #vfmadd231pd %zmm23, %zmm23, %zmm19                      #178.67
        #vrcp14pd  %zmm19, %zmm18                                #195.42
        #vcmppd    $1, %zmm14, %zmm19, %k2                       #194.26
        #vfpclasspd $30, %zmm18, %k0                             #195.42
        #kmovw     %k2, %esi                                     #194.26
        #knotw     %k0, %k1                                      #195.42
        #vmovaps   %zmm19, %zmm0                                 #195.42
        #andl      %esi, %r9d                                    #194.26
        #vfnmadd213pd .L_2il0floatpacket.9(%rip){1to8}, %zmm18, %zmm0 #195.42
        #kmovw     %r9d, %k3                                     #198.21
        #vmulpd    %zmm0, %zmm0, %zmm1                           #195.42
        #vfmadd213pd %zmm18, %zmm0, %zmm18{%k1}                  #195.42
        #vfmadd213pd %zmm18, %zmm1, %zmm18{%k1}                  #195.42
        #vmulpd    %zmm13, %zmm18, %zmm2                         #196.42
        #vmulpd    %zmm9, %zmm18, %zmm4                          #197.58
        #vmulpd    %zmm2, %zmm18, %zmm10                         #196.48
        #vmulpd    %zmm10, %zmm18, %zmm3                         #196.54
        #vfmsub213pd %zmm5, %zmm10, %zmm18                       #197.58
        #vmulpd    %zmm4, %zmm3, %zmm17                          #197.65
        #vmulpd    %zmm18, %zmm17, %zmm22                        #197.71
        #vfmadd231pd %zmm20, %zmm22, %zmm8{%k3}                  #198.21
        #vfmadd231pd %zmm21, %zmm22, %zmm7{%k3}                  #199.21
        #vfmadd231pd %zmm23, %zmm22, %zmm11{%k3}                 #200.21
                                # LOE rax rdx rcx rbx rdi r8 r14 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.40:                        # Preds ..B1.25 ..B1.39 ..B1.34
                                # Execution count [4.50e+00]
        vmovups   .L_2il0floatpacket.10(%rip), %zmm19           #151.22
        vpermd    %zmm11, %zmm19, %zmm0                         #151.22
        vpermd    %zmm7, %zmm19, %zmm6                          #150.22
        vpermd    %zmm8, %zmm19, %zmm20                         #149.22
        vaddpd    %zmm11, %zmm0, %zmm11                         #151.22
        vaddpd    %zmm7, %zmm6, %zmm7                           #150.22
        vaddpd    %zmm8, %zmm20, %zmm8                          #149.22
        vpermpd   $78, %zmm11, %zmm1                            #151.22
        vpermpd   $78, %zmm7, %zmm10                            #150.22
        vpermpd   $78, %zmm8, %zmm21                            #149.22
        vaddpd    %zmm1, %zmm11, %zmm2                          #151.22
        vaddpd    %zmm10, %zmm7, %zmm12                         #150.22
        vaddpd    %zmm21, %zmm8, %zmm22                         #149.22
        vpermpd   $177, %zmm2, %zmm3                            #151.22
        vpermpd   $177, %zmm12, %zmm17                          #150.22
        vpermpd   $177, %zmm22, %zmm23                          #149.22
        vaddpd    %zmm3, %zmm2, %zmm4                           #151.22
        vaddpd    %zmm17, %zmm12, %zmm18                        #150.22
        vaddpd    %zmm23, %zmm22, %zmm24                        #149.22
                                # LOE rax rdx rcx rbx rdi r8 r14 xmm4 xmm18 xmm24 ymm15 ymm16 zmm5 zmm9 zmm13 zmm14
..B1.41:                        # Preds ..B1.40 ..B1.11
                                # Execution count [5.00e+00]
        movq      80(%rsp), %rsi                                #208.9[spill]
        addq      $24, %rdi                                     #143.5
        vaddsd    (%rsi,%rax,8), %xmm24, %xmm0                  #208.9
        vmovsd    %xmm0, (%rsi,%rax,8)                          #208.9
        movslq    %eax, %rsi                                    #143.32
        vaddsd    (%r14,%rax,8), %xmm18, %xmm1                  #209.9
        vmovsd    %xmm1, (%r14,%rax,8)                          #209.9
        incq      %rsi                                          #143.32
        vaddsd    (%r8,%rax,8), %xmm4, %xmm2                    #210.9
        vmovsd    %xmm2, (%r8,%rax,8)                           #210.9
        incq      %rax                                          #143.5
        cmpq      64(%rsp), %rax                                #143.5[spill]
        jb        ..B1.11       # Prob 82%                      #143.5
        jmp       ..B1.44       # Prob 100%                     #143.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r14 ymm15 ymm16 zmm5 zmm9 zmm13 zmm14
..B1.43:                        # Preds ..B1.2
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.0, %edi                         #141.5
..___tag_value_computeForce.48:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #141.5
..___tag_value_computeForce.49:
                                # LOE
..B1.44:                        # Preds ..B1.41 ..B1.43
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.0, %edi                         #219.5
        vzeroupper                                              #219.5
..___tag_value_computeForce.50:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #219.5
..___tag_value_computeForce.51:
                                # LOE
..B1.45:                        # Preds ..B1.44
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #221.16
..___tag_value_computeForce.52:
#       getTimeStamp()
        call      getTimeStamp                                  #221.16
..___tag_value_computeForce.53:
                                # LOE xmm0
..B1.46:                        # Preds ..B1.45
                                # Execution count [1.00e+00]
        vsubsd    24(%rsp), %xmm0, %xmm0                        #224.14[spill]
        addq      $88, %rsp                                     #224.14
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
..B1.47:                        # Preds ..B1.13
                                # Execution count [4.50e-01]: Infreq
        movl      %r10d, %r13d                                  #173.13
        xorl      %r11d, %r11d                                  #173.13
        andl      $-8, %r13d                                    #173.13
        jmp       ..B1.26       # Prob 100%                     #173.13
                                # LOE rax rdx rcx rbx rsi rdi r8 r14 r10d r11d r13d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
..B1.48:                        # Preds ..B1.12
                                # Execution count [4.50e-01]: Infreq
        xorl      %r13d, %r13d                                  #173.13
        jmp       ..B1.34       # Prob 100%                     #173.13
        .align    16,0x90
                                # LOE rax rdx rcx rbx rsi rdi r8 r14 r10d r13d xmm6 xmm10 xmm12 ymm15 ymm16 zmm5 zmm7 zmm8 zmm9 zmm11 zmm13 zmm14
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
	.section .rodata.str1.4, "aMS",@progbits,1
	.align 4
	.align 4
.L_2__STRING.0:
	.long	1668444006
	.word	101
	.type	.L_2__STRING.0,@object
	.size	.L_2__STRING.0,6
	.data
	.section .note.GNU-stack, ""
# End
