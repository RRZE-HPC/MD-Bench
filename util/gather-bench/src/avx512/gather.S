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
.align 16
1:
vpcmpeqb k1, xmm0, xmm0
vpcmpeqb k2, xmm0, xmm0
vpcmpeqb k3, xmm0, xmm0
vpcmpeqb k4, xmm0, xmm0
vmovdqu ymm0, [rsi + rax * 4]
vmovdqu ymm1, [rsi + rax * 4 + 32]
vmovdqu ymm2, [rsi + rax * 4 + 64]
vmovdqu ymm3, [rsi + rax * 4 + 96]
vpxord zmm4, zmm4, zmm4
vpxord zmm5, zmm5, zmm5
vpxord zmm6, zmm6, zmm6
vpxord zmm7, zmm7, zmm7
vgatherdpd zmm4{k1}, [rdi + ymm0 * 8]
vgatherdpd zmm5{k2}, [rdi + ymm1 * 8]
vgatherdpd zmm6{k3}, [rdi + ymm2 * 8]
vgatherdpd zmm7{k4}, [rdi + ymm3 * 8]

#ifdef TEST
vmovapd [rcx + rax * 8],       zmm4
vmovapd [rcx + rax * 8 + 64],  zmm5
vmovapd [rcx + rax * 8 + 128], zmm6
vmovapd [rcx + rax * 8 + 192], zmm7
#endif

addq rax, 32
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
