.intel_syntax noprefix
.data
.align 64
SCALAR:
.double 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0

.section .rodata, "a"
.align 64
.align 64
.ymm_reg_mask.1:
	.long	0x00000000,0x00000001,0x00000002,0x00000003,0x00000004,0x00000005,0x00000006,0x00000007
	.type	.ymm_reg_mask.1,@object
	.size	.ymm_reg_mask.1,32
	.align 8

# rdi -> a
# rsi -> neighbors
# rdx -> numneighs[i]
# rcx -> &t[t_idx]
# r8  -> ntest
.text
.globl gather_md_aos
.type gather_md_aos, @function
gather_md_aos :
push rbp
mov rbp, rsp
push rbx
push r10
push r11
push r12
push r13
push r14
push r15

vmovdqu ymm7, YMMWORD PTR .ymm_reg_mask.1[rip]
mov r15, rdx
xor rax, rax
.align 16
1:

vmovdqu ymm3, YMMWORD PTR [rsi + rax * 4]
vpaddd ymm4, ymm3, ymm3
#ifdef PADDING
vpaddd ymm3, ymm4, ymm4
#else
vpaddd ymm3, ymm3, ymm4
#endif

# Prefetching instructions
#mov ebx, DWORD PTR[rsi + rax*4]
#mov r9d, DWORD PTR[4 + rsi + rax*4]
#mov r10d, DWORD PTR[8 + rsi + rax*4]
#mov r11d, DWORD PTR[12 + rsi + rax*4]
#mov r12d, DWORD PTR[16 + rsi + rax*4]
#mov r13d, DWORD PTR[20 + rsi + rax*4]
#mov r14d, DWORD PTR[24 + rsi + rax*4]
#mov r15d, DWORD PTR[28 + rsi + rax*4]
#lea ebx, DWORD PTR[rbx]
#lea r9d, DWORD PTR[r9]
#lea r10d, DWORD PTR[r10]
#lea r11d, DWORD PTR[r11]
#lea r12d, DWORD PTR[r12]
#lea r13d, DWORD PTR[r13]
#lea r14d, DWORD PTR[r14]
#lea r15d, DWORD PTR[r15]

vpcmpeqb k1, xmm5, xmm5
#ifndef ONLY_FIRST_DIMENSION
vpcmpeqb k2, xmm5, xmm5
vpcmpeqb k3, xmm5, xmm5
#endif

vpxord zmm0, zmm0, zmm0
#ifndef ONLY_FIRST_DIMENSION
vpxord zmm1, zmm1, zmm1
vpxord zmm2, zmm2, zmm2
#endif

vgatherdpd zmm0{k1}, [     rdi + ymm3 * 8]
#ifndef ONLY_FIRST_DIMENSION
vgatherdpd zmm1{k2}, [8 +  rdi + ymm3 * 8]
vgatherdpd zmm2{k3}, [16 + rdi + ymm3 * 8]
#endif

#ifdef TEST
vmovupd  [rcx + rax * 8], zmm0
lea rbx, [rcx + r8  * 8]
vmovupd  [rbx + rax * 8], zmm1
lea r10, [rbx + r8  * 8]
vmovupd  [r10 + rax * 8], zmm2
#endif

# TODO: see if this logic can be optimized
addq rax, 8
subq r15, 8
cmpq r15, 8
jge 1b

cmpq r15, 0
jle .end_func

vpbroadcastd ymm6, r15d
vpcmpgtd k1, ymm6, ymm7
vmovdqu32 ymm3{k1}{z}, YMMWORD PTR [rsi + rax * 4]
vpaddd ymm4, ymm3, ymm3
#ifdef PADDING
vpaddd ymm3, ymm4, ymm4
#else
vpaddd ymm3, ymm3, ymm4
#endif

vpxord    zmm0, zmm1, zmm2
#ifndef ONLY_FIRST_DIMENSION
kmovw     k2, k1
kmovw     k3, k1
vpxord    zmm1, zmm1, zmm1
vpxord    zmm2, zmm2, zmm2
#endif

vgatherdpd zmm0{k1}, [     rdi + ymm3 * 8]
#ifndef ONLY_FIRST_DIMENSION
vgatherdpd zmm1{k2}, [8 +  rdi + ymm3 * 8]
vgatherdpd zmm2{k3}, [16 + rdi + ymm3 * 8]
#endif

#ifdef TEST
vmovupd  [rcx + rax * 8], zmm0
lea rbx, [rcx + r8  * 8]
vmovupd  [rbx + rax * 8], zmm1
lea r10, [rbx + r8  * 8]
vmovupd  [r10  + rax * 8], zmm2
#endif

addq rax, r15

.end_func:
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop rbx
mov  rsp, rbp
pop rbp
ret
.size gather_md_aos, .-gather_md_aos
