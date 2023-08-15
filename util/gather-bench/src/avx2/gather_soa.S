.intel_syntax noprefix
.data
.align 64
SCALAR:
.double 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0

# rdi -> a
# rsi -> idx
# rdx -> N
# rcx -> t
.text
.globl gather_soa
.type gather_soa, @function
gather_soa :
push rbp
mov rbp, rsp
push rbx
push r9
push r10
push r11
push r12
push r13
push r14
push r15

xor rax, rax
vpcmpeqd ymm8, ymm8, ymm8
lea r8, [rdi + rdx * 8]
lea r9, [r8  + rdx * 8]
.align 16
1:

vmovups xmm3, XMMWORD PTR [rsi + rax * 4]
vmovdqa ymm5, ymm8
vmovdqa ymm6, ymm8
vmovdqa ymm7, ymm8
vxorpd ymm0, ymm0, ymm0
vxorpd ymm1, ymm1, ymm1
vxorpd ymm2, ymm2, ymm2
vgatherdpd ymm0, [rdi + xmm3 * 8], ymm5
vgatherdpd ymm1, [r8  + xmm3 * 8], ymm6
vgatherdpd ymm2, [r9  + xmm3 * 8], ymm7

#ifdef TEST
vmovupd  [rcx + rax * 8], ymm0
lea rbx, [rcx + rdx * 8]
vmovupd  [rbx + rax * 8], ymm1
lea r10, [rbx + rdx * 8]
vmovupd  [r10 + rax * 8], ymm2
#endif

addq rax, 4
cmpq rax, rdx
jl 1b

pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop rbx
mov  rsp, rbp
pop rbp
ret
.size gather_soa, .-gather_soa
