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
.globl gather
.type gather, @function
gather :
push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15

xor   rax, rax
vpcmpeqd ymm0, ymm0, ymm0
.align 16
1:
vmovups xmm1, [rsi + rax * 4]
vmovups xmm2, [rsi + rax * 4 + 16]
vmovups xmm3, [rsi + rax * 4 + 32]
vmovups xmm4, [rsi + rax * 4 + 48]
vmovdqa ymm5, ymm0
vmovdqa ymm6, ymm0
vmovdqa ymm7, ymm0
vmovdqa ymm8, ymm0
vxorpd ymm9,  ymm9,  ymm9
vxorpd ymm10, ymm10, ymm10
vxorpd ymm11, ymm11, ymm11
vxorpd ymm12, ymm12, ymm12
vgatherdpd ymm9,  [rdi + xmm1 * 8], ymm5
vgatherdpd ymm10, [rdi + xmm2 * 8], ymm6
vgatherdpd ymm11, [rdi + xmm3 * 8], ymm7
vgatherdpd ymm12, [rdi + xmm4 * 8], ymm8

#ifdef TEST
vmovapd [rcx + rax * 8],      ymm9
vmovapd [rcx + rax * 8 + 32], ymm10
vmovapd [rcx + rax * 8 + 64], ymm11
vmovapd [rcx + rax * 8 + 96], ymm12
#endif

addq rax, 16
cmpq rax, rdx
jl 1b

pop r15
pop r14
pop r13
pop r12
pop rbx
mov  rsp, rbp
pop rbp
ret
.size gather, .-gather
