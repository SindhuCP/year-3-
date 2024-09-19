#11 a
li s0 LED_MATRIX_0_BASE 
li s1 LED_MATRIX_0_WIDTH 
li s2 LED_MATRIX_0_HEIGHT 
li s3, 0x0A3799 
li s4,0xFFC72C #Yellow colour 
start: 
li a1,0x000000 
addi t1, t1,64 
mv a0,s0 
sw s4,0(a0) 
L1:sw a1,0(a0) 
addi a0,a0,4 
sw s4,0(a0) 
addi t2,t2,1 
bne t1,t2,L1 
j start