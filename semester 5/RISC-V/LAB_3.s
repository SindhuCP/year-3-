.data 
lab3: .word 0xabcdeeff,0x11223344,0xaabbccdd,0x12345678,0x11aa22bb


.text
li x4,0x500
li x2,5
la x3,lab3

next:addi x7,x0,4
back:lbu x6,3(x3)
sb x6,0(x4)
#sw x4,3(x3)
addi x3,x3,-1
addi x4,x4,1
addi x7,x7,-1
bne x7,x0,back #branch not equa; when equal it will come out 

addi x3,x3,8
addi x2,x2,-1
bne x2,x0,next

