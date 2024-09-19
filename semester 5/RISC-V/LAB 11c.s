#11c
.data
r1:
.word 0b00111101
.word 0b11011101
.word 0b11000001
.word 0b00000100

r2:
    .word 0b00100100
    .word 0b10010001
    .word 0b00000001
    .word 0b00000100
r3:
    .word 0b00100100
    .word 0b10010001
    .word 0b00000001
    .word 0b00000100
r4:
    .word 0b00111100
    .word 0b10011101
    .word 0b00011101
    .word 0b00000100  
r5:
    .word 0b00110000
    .word 0b10000101
    .word 0b00000000
    .word 0b10001000
r6:
    .word 0b00101000
    .word 0b10000101
    .word 0b00000000
    .word 0b01010000
r7:
    .word 0b00100101
    .word 0b11011101
    .word 0b11000000
    .word 0b00100000 
         
.text
li s0 LED_MATRIX_0_BASE
li s1 LED_MATRIX_0_WIDTH
li s2 LED_MATRIX_0_HEIGHT
li s3,0x0000FF 
li s4,0xFFB6C1
addi s5,s0,LED_MATRIX_0_SIZE #Bound
mv a0,s0
li a1,0x000000
resetled:
 sw a1,0(a0)
 addi a0,a0,4
 bne a0,s5,resetled

    bne a0, s5, resetled

li t0, 0b10000000
li t1,1
mv a0,s0
la a2,r1
lw a1,0(a2)
start:
 and t2,a1,t0
 beq t2,x1,not
 sw s3,0(a0)
 cont: beq t0,t1,nextrow
 srli t0,t0,1
 addi a0,a0,4
 j start
 not: sw s4,0(a0)
 j cont
nextrow: li t0, 0b10000000
addi a0,a0,4
beq a0,s5,done
addi a2,a2,4
lw a1,0(a2)
j start
done: nop