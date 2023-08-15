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
.globl gather_aos
.type gather_aos, @function
gather_aos :
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

xor   rax, rax
vpcmpeqd ymm8, ymm8, ymm8
.align 16
1:

vmovups xmm3, XMMWORD PTR [rsi + rax * 4]
vpaddd xmm4, xmm3, xmm3
#ifdef PADDING
vpaddd xmm3, xmm4, xmm4
#else
vpaddd xmm3, xmm3, xmm4
#endif
vmovdqa ymm5, ymm8
vmovdqa ymm6, ymm8
vmovdqa ymm7, ymm8
vxorpd ymm0, ymm0, ymm0
vxorpd ymm1, ymm1, ymm1
vxorpd ymm2, ymm2, ymm2
vgatherdpd ymm0, [     rdi + xmm3 * 8], ymm5
vgatherdpd ymm1, [8  + rdi + xmm3 * 8], ymm6
vgatherdpd ymm2, [16 + rdi + xmm3 * 8], ymm7

#ifdef TEST
vmovupd  [rcx + rax * 8], ymm0
lea rbx, [rcx + rdx * 8]
vmovupd  [rbx + rax * 8], ymm1
lea r9,  [rbx + rdx * 8]
vmovupd  [r9  + rax * 8], ymm2
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
.size gather_aos, .-gather_aos
