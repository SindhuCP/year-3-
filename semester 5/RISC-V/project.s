#.data 
#str: .string "ADDI x1,x2,"

#.text
#la a0 str
#li a7 4
#ecall

#li a0 10
#li a7 1
#ecall


#add x1,x2,x3
#sub x1,x2,x3
#addi x1,x2,1000
#lw x1,1000(x2)
#sw x1,1000(x2)


.data
    imem: .word 0x3e810093,0x3e812083 #0x003100b3,0x403100b3,0x3e112423

.text
li x15,2
la x11,imem
li x12,0



main:
  #li x10, 0b00111110100000010000000010010011  # addi x1,x2,1000 Load the binary machine code instruction
   lw x10,0(x11)
  # Extract the opcode
  li x1, 0b00000000000000000000000001111111
  and x1, x10, x1
  sw x1, 0(x12)

  # Extract the destination register (rd)
  li x2, 0b00000000000000000000111110000000
  and x2, x10, x2
  srli x2, x2, 7
  sw x2, 1(x12)

  # Extract the source register (rs1)
  li x3, 0b00000000000011111000000000000000
  and x3, x10, x3
  srli x3, x3, 15
  sw x3, 2(x12)

  # Extract the function code (funct3)
  li x4, 0b00000000000000000111000000000000
  and x4, x10, x4
  srli x4, x4, 12
  sw x4, 3(x12)

  # Extract the immediate value (imm)
  li x5, 0b11111111111100000000000000000000
  and x5, x10, x5
  srli x5,x5,20
  sw x5, 4(x12)

  # Display the decoded instruction details
  la a0, inst_str
  li a7, 4           # Length of the string to print
  ecall
  lw a0,0(a2)
  li a7,1
  ecall
  addi x15,x15,-1
  addi x11,x11,4
  addi x12,x12,4
  bne x15,x0,main


  # Exit the program
  li a7, 10           # sys_exit system call number
  ecall
  
  
inst_str: .string "\nDecoded Instruction: "


