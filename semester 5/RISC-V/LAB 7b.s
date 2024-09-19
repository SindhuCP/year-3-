#linear search
# o/p in x8
# indexing starts from 0, output is 11 if not found, works for 10 element array
.data
arr: .word 1,2,3,4,5,6,7,8,9
.text
li x5,11 #n+1
la x1,arr
addi x1,x1,-4
li x2,6 # x2=search element
addi x4,x0,-1 # x4=for indexing
loop:addi x1,x1,4 # incrementing index
lw x3,0(x1) # storing current element
addi x4,x4,1
bge x4,x5,exit1
bne x3,x2,loop
exit1:bne x5,x4,exit 
addi x4,x0,-1
exit:sw x4,0(x8)
nop