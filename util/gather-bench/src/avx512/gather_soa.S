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

xor   rax, rax
vpcmpeqd ymm8, ymm8, ymm8
lea r8, [rdi + rdx * 8]
lea r9, [r8  + rdx * 8]
.align 16
1:

vmovdqu ymm3, YMMWORD PTR [rsi + rax * 4]
vpcmpeqb k1, xmm5, xmm5
vpcmpeqb k2, xmm5, xmm5
vpcmpeqb k3, xmm5, xmm5
vpxord zmm0, zmm0, zmm0
vpxord zmm1, zmm1, zmm1
vpxord zmm2, zmm2, zmm2
vgatherdpd zmm0{k1}, [rdi + ymm3 * 8]
vgatherdpd zmm1{k2}, [r8  + ymm3 * 8]
vgatherdpd zmm2{k3}, [r9  + ymm3 * 8]

#ifdef TEST
vmovupd  [rcx + rax * 8], zmm0
lea rbx, [rcx + rdx * 8]
vmovupd  [rbx + rax * 8], zmm1
lea r10, [rbx + rdx * 8]
vmovupd  [r10 + rax * 8], zmm2
#endif

addq rax, 8
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
