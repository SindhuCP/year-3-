.data
cod: .word 0x07
.text
la x10,cod
lw x2,0(x10)
li x7,5
li x4,01
li x8,2
li x1,00
andi x3,x2,0xffffffe0
bne x3,x0,notacode
back:and x5,x2,x4
beq x5,x0,next
addi x1,x1,1
next:slli x4,x4,1
addi x7,x7,-1
bne x7,x0,back
bne x1,x8,notacode
addi x11,x0,0xff
store:sb x11,4(x10)
j exit
notacode:add x11,x0,x0
beq x0,x0, store
exit:nop