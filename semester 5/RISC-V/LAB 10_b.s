.data
mat1: .word 1,2,3,4,5,6,7,8,9
mat2: .word 10,11,12,13,14,15,16,17,18
.equ row1, 3
.equ row2, 3
.equ col2, 3
res: .zero 36

.text
li x4, row1
la x1, mat1
la x2, mat2
la x3, res

nextrow:
    li x5, col2
nextcol:
    lw x6, 0(x1)   # Load the current element from mat1
    lw x7, 0(x2)   # Load the current element from mat2
    add x8, x6, x7 # Add the elements
    sw x8, 0(x3)   # Store the result in res
    addi x1, x1, 4 # Move to the next element in mat1
    addi x2, x2, 4 # Move to the next element in mat2
    addi x3, x3, 4 # Move to the next element in the result matrix

    addi x5, x5, -1
    beq x5, x0, skip
    j nextcol

skip:
    addi x4, x4, -1
    bne x4, x0, nextrow