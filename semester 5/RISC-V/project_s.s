# for s type

.data
    imem: .word 0x3e112423 #0x003100b3,0x403100b3,0x3e810093,0x3e812083

.text
li x15,1
la x11,imem
li x12,0



main:
  #li x10, 0b00111110100000010000000010010011  # addi x1,x2,1000 Load the binary machine code instruction
   lw x10,0(x11)
  # Extract the opcode
  li x1, 0b00000000000000000000000001111111
  and x1, x10, x1
  sw x1, 0(x12)

  # Extract the imm1 (imm1)
  li x2, 0b00000000000000000000111110000000
  and x2, x10, x2
  srli x2, x2, 7
  sw x2, 1(x12)

   # Extract the function code (funct3)
  li x4, 0b00000000000000000111000000000000
  and x4, x10, x4
  srli x4, x4, 12
  sw x4, 2(x12)
  
  # Extract the source register 1 (rs1)
  li x3, 0b00000000000011111000000000000000
  and x3, x10, x3
  srli x3, x3, 15
  sw x3, 3(x12)
  
  # Extract the source register 2 (rs2)
  li x3, 0b00000001111100000000000000000000
  and x3, x10, x3
  srli x3, x3, 20
  sw x3, 4(x12)

 

  # Extract the immediate value 2 (imm2)
  li x5, 0b11111110000000000000000000000000
  and x5, x10, x5
  srli x5,x5,22
  sw x5, 5(x12)

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