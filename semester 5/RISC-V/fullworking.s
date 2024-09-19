.data
    imem: .word 0x3e810093 #0x003100b3,0x403100b3,0x3e812083,0x001570b3,0x3e112423

.text
li x15,1
la x11,imem
li x12,0

statement: .string "Decoded instruction:   "
la a0,statement
li a7,4
ecall

#extracting opcode
lw x10,0(x11)
li x1, 0b00000000000000000000000001111111
and x1, x10, x1
sw x1,0(x12)
li x18,51 #opcode for R type
li x19,19 #opcode for immediate type
li x20,3 #opcode for load type
li x21,35 #opcode for store type
li x22,103

beq x1,x18,r_type
beq x1,x19,i_type
beq x1,x20,i_type
beq x1,x22,i_type
beq x1,x21,s_type

r_type: 
  # Extract the rd
  li x31, 0b00000000000000000000111110000000
  and x31, x10, x31
  srli x31, x31, 7
  sw x31, 1(x12)

  # Extract the function code (funct3)
  li x30, 0b00000000000000000111000000000000
  and x30, x10, x30
  srli x30, x30, 12
  sw x30, 2(x12)
  
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

  # Extract the func 7
  li x5, 0b11111110000000000000000000000000
  and x5, x10, x5
  srli x5,x5,25
  sw x5, 5(x12)
  
  addi sp, sp, -20
  li s0, 1
  li t1, 4
  li t2, 5
  li t3, 6
  li t4, 7
  sw s0, 0(sp)
  sw t1, 4(sp)
  sw t2, 8(sp)
  sw t3, 12(sp)
  sw t4,16(sp)
  lw s0, 0(sp)
  lw t1, 4(sp)
  lw t2, 8(sp)
  lw t3, 12(sp)
  lw t4,16(sp)
  
  beq x30,x0,add_sub
  beq x30,s0,shift_ll
  beq x30,t1,x_or
  beq x30,t2,sr_l_a
  beq x30,t3,o_r
  beq x30,t4,a_nd
  
  add_sub:
      li s0,32
      sw s0,0(sp)
      lw s0,0(sp)
      beq x5,x0,a_dd
      beq x5,s0,s_ub
      a_dd:
          instr1: .string "add"
          la a0,instr1
          li a7,4
          ecall
          j branch_done
      s_ub:
          instr2: .string "sub"
          la a0,instr2
          li a7,4
          ecall
          j branch_done
      branch_done: j r_done
  shift_ll:
      instr3: .string "sll"
      la a0,instr3
      li a7,4
      ecall
      j r_done
  x_or:
      instr4: .string "xor"
      la a0,instr4
      li a7,4
      ecall
      j r_done
  sr_l_a:
      li s0,32
      sw s0,0(sp)
      lw s0,0(sp)
      beq x5,x0,sr_l
      beq x5,s0,sr_a
      sr_l:
          instr5: .string "srl"
          la a0,instr5
          li a7,4
          ecall
          j if_done
      sr_a:
          instr6: .string "sra"
          la a0,instr6
          li a7,4
          ecall
          j if_done
      if_done: j r_done
  o_r:
      instr7: .string " or"
      la a0,instr7
      li a7,4
      ecall
      j r_done
  a_nd:
      instr8: .string "and"
      la a0,instr8
      li a7,4
      ecall
      j r_done
      
r_done: j print

s_type:
  # Extract the imm1 (imm1)
  li x31, 0b00000000000000000000111110000000
  and x31, x10, x31
  srli x31, x31, 7


   # Extract the function code (funct3)
  li x4, 0b00000000000000000111000000000000
  and x4, x10, x4
  srli x4, x4, 12
  sw x4, 1(x12)
  
  # Extract the source register 1 (rs1)
  li x3, 0b00000000000011111000000000000000
  and x3, x10, x3
  srli x3, x3, 15
  sw x3, 2(x12)
  
  # Extract the source register 2 (rs2)
  li x3, 0b00000001111100000000000000000000
  and x3, x10, x3
  srli x3, x3, 20
  sw x3, 3(x12)

  # Extract the immediate value 2 (imm2)
  li x30, 0b11111110000000000000000000000000
  and x30, x10, x30
  srli x30,x30,20
  add x30,x30,x31
  sw x30, 4(x12)
  
  addi sp, sp, -8
  li s0, 1
  li t1, 2
  sw s0, 0(sp)
  sw t1, 4(sp)
  lw s0, 0(sp)
  lw t1, 4(sp)
  beq x4,x0,s_b
  beq x4,s0,s_h
  beq x4,t1,s_w
  
  s_b:
      instr9: .string "sb "
      la a0,instr9
      li a7,4
      ecall
      j s_done
  s_h:
      instr10: .string "sh "
      la a0,instr10
      li a7,4
      ecall
      j s_done
  s_w:
      instr11: .string "sw "
      la a0,instr11
      li a7,4
      ecall
      j s_done
  
  
s_done:j print


i_type:
  # Extract the destination register (rd)
  li x31, 0b00000000000000000000111110000000
  and x31, x10, x31
  srli x31, x31, 7
  sw x31, 1(x12)

  # Extract the source register (rs1)
  li x30, 0b00000000000011111000000000000000
  and x30, x10, x30
  srli x30, x30, 15
  sw x30, 2(x12)

  # Extract the function code (funct3)
  li x27, 0b00000000000000000111000000000000
  and x27, x10, x27
  srli x27, x27, 12
  sw x27, 3(x12)

  # Extract the immediate value (imm)
  li x26, 0b11111111111100000000000000000000
  and x26, x10, x26
  srli x26,x26,20
  sw x26, 4(x12)
  
  addi sp, sp, -8
  li s0, 3
  li t1, 19
  li t2, 103
  sw s0, 0(sp)
  sw t1, 4(sp)
  sw t2,8(sp)
  lw s0, 0(sp)
  lw t1, 4(sp)
  lw t2, 8(sp)
  beq x1,s0,load
  beq x1,t1,imm
  beq x1,t2,jump
  load: 
      addi sp, sp, -12
      li s0, 1
      li t1, 2
      li t2, 4
      li t3, 5
      sw s0, 0(sp)
      sw t1, 4(sp)
      sw t2,8(sp)
      sw t3,12(sp)
      lw s0, 0(sp)
      lw t1, 4(sp)
      lw t2, 8(sp)
      lw t3, 12(sp)
      beq x27,x0,l_b
      beq x27,s0,l_h
      beq x27,t1,l_w
      beq x27,t2,l_bu
      beq x27,t3,l_hu
      
      l_b:
          instr12: .string "lb "
          la a0,instr12
          li a7,4
          ecall
          j i_done
      l_h:
          instr13: .string "lh "
          la a0,instr13
          li a7,4
          ecall
          j i_done
      l_w:
          instr14: .string "lw "
          la a0,instr14
          li a7,4
          ecall
          j i_done
      l_bu:
          instr15: .string "lbu"
          la a0,instr15
          li a7,4
          ecall
          j i_done
      l_hu:
          instr16: .string "lhu"
          la a0,instr16
          li a7,4
          ecall
          j i_done
  imm:
      addi sp, sp, -12
      li s0, 1
      li t1, 4
      li t2, 6
      li t3, 7
      sw s0, 0(sp)
      sw t1, 4(sp)
      sw t2,8(sp)
      sw t3,12(sp)
      lw s0, 0(sp)
      lw t1, 4(sp)
      lw t2, 8(sp)
      lw t3, 12(sp)
      beq x4,x0,add_i
      beq x4,s0,sll_i
      beq x4,t1,xor_i
      beq x4,t3,and_i
      add_i:
          instr17: .string "addi   "
          la a0,instr17
          li a7,4
          ecall
          j i_done
      sll_i:
          instr18: .string "slli   "
          la a0,instr18
          li a7,4
          ecall
          j i_done
      xor_i:
          instr19: .string "xori   "
          la a0,instr19
          li a7,4
          ecall
          j i_done
      and_i:
          instr21: .string "andi   "
          la a0,instr21
          li a7,4
          ecall
          j i_done
  jump:
      instr22: .string "jalr   "
      la a0,instr22
      li a7,4
      ecall
      j i_done
  
i_done:j print



print: nop