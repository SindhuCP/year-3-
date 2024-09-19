#11b
li s0 LED_MATRIX_0_BASE 
li s1 LED_MATRIX_0_WIDTH 
li s2 LED_MATRIX_0_HEIGHT 
li s3, 0x00AA00 
li s4,0xFFC72C 
li s5,0xFF0000 
li s6 SWITCHES_0_BASE
mv a0,s0
li a2,0 
start: 
lb a3,0(s6)#status of switch 
srl a4,a3,a2 
andi a4,a4,1 
beq x1,a4,L1 
sw s3,0(a0) 
addi a2,a2,1 
addi a0,a0,4 
j start 
L1: sw s5,0(a0) 
addi a2,a2,1 
addi a0,a0,4 
j start