.data
num: .word 0xabcdeeff,0x11223344,0xaabbccdd,0x12345678,0x11aa22bb
.text
la x1,num
li x4,4
addi x3,x0,0
rpt:lw x2,0(x1)
add x3,x3,x2

addi x1,x1,4
addi x4,x4,-1
bne x4,x0,rpt
sw x3, 4(x1)
nop
