.data
aryA: .word 10,20,30,40,50,60,70,80,90,100
aryB: .word 10,20,30,40,50,60,70,80,90,100
aryC: .zero 40
.text
la x1,aryA
la x2,aryB
la x3,aryC
li x4,10
li x5,0
back:lw x6,0(x1)
lw x7,0(x2)
mul x8,x6,x7
add x5,x5,x8
sw x5,0(x3)
addi x1,x1,4
addi x2,x2,4
addi x3,x3,4
addi x4,x4,-1
bne x4,x0,back
nop