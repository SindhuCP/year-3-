.data
A: .word 18
divisor: .word 9
ans: .word 0
 
.text
    la x11,ans
    lw x5,A
    lw a0,divisor
loop:
    blt x5,x0,not_div
    beq x5,x0,div
    sub x5,x5,a0
    j loop
not_div:
    addi x10,x0,0
    j exit
div:
    addi x10,x0,1
    j exit
exit:
    sw x10,0(x11)
    nop