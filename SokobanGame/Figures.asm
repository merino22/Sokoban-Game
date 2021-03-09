.global Block
.global Tree
.global Box

Box:
    li $v0, 29
    li $a0, 3
    syscall
    li $v0, 28
    li $a0, 0
    syscall 
    li $t1, 0 ;--> i
for_box:
    slti $t0, $t1, 3
    beq $t0, $zero, end_for_box
    sw $a2, 336($sp)
    add $a2, $a2, $t1
    li $v0, 51 ; --> call rlutil::locate
    syscall
    lw $a2, 336($sp)
    li $t2, 0 ; --> j
    li $v0, 27
    ;#show $t1
s_for_box:
    slti $t0, $t2, 7
    beq $t0, $zero, end_s_for_box
    li $t3, 0 ;--> i_cond compare
    ;#show $t2
if_i:
    bne $t1, $t3, else_if_i
if_j_0_1:
    li $t3, 0
    bne $t2, $t3, ei_j_0_3
    li $a0, 201 ; -- 201
    syscall
    j end_i
ei_j_0_3:
    li $t3, 3
    bne $t2, $t3, ei_j_0_6
    li $a0, 203 ; 203
    syscall
    j end_i
ei_j_0_6:
    li $t3, 6
    bne $t2, $t3, else_j_0
    li $a0, 187 ; -- 187
    syscall
    j end_i
else_j_0:
    li $a0, 205
    syscall
    j end_i

else_if_i:
    li $t3, 1
    bne $t1, $t3, else_i
if_j_1_1:
    li $t3, 0
    bne $t2, $t3, ei_j_1_3
    li $a0, 204
    syscall
    j end_i
ei_j_1_3:
    li $t3, 3
    bne $t2, $t3, ei_j_1_6
    li $a0, 206
    syscall
    j end_i
ei_j_1_6:
    li $t3, 6
    bne $t2, $t3, else_j_1
    li $a0, 185
    syscall
    j end_i

else_j_1:
    li $a0, 205
    syscall
    j end_i

else_i:
    li $t3, 2
    bne $t1, $t3, end_i
if_j_2_1:
    li $t3, 0
    bne $t2, $t3, ei_j_2_3
    li $a0, 200
    syscall
    j end_i
ei_j_2_3:
    li $t3, 3
    bne $t2, $t3, ei_j_2_6
    li $a0, 202 ; --. 202
    syscall
    j end_i
ei_j_2_6:
    li $t3, 6
    bne $t2, $t3, else_j_2
    li $a0, 188
    syscall
    j end_i
else_j_2:
    li $a0, 205
    syscall
end_i:

    addi $t2, $t2, 1
    j s_for_box
end_s_for_box:
    li $v0, 11
    li $a0, 10
    syscall
    addi $t1, $t1, 1
    j for_box
end_for_box:
    jr $ra


Block:
    li $t1, 0
for_block:
    slti $t0, $t1, 3
    beq $t0, $zero, end_for_block
    sw $a2, 336($sp)
    add $a2, $a2, $t1
    li $v0, 51
    syscall
    lw $a2, 336($sp)
    li $t2, 0
sec_for_block:
    slti $t0, $t2, 7
    beq $t0, $zero, end_sec_for_block
if_block:
    li $t0, 2
    div $t1, $t0
    mfhi $t0
    bne $t0, $zero, sec_if_block

    li $t0, 2
    bne $t2, $t0, else_block
    li $v0, 28
    li $a0, 15
    syscall
    li $v0, 29
    li $a0, 4
    syscall
    li $v0, 27
    li $a0, 179
    syscall
    j end_if_block

else_block:
    li $v0, 28
    li $a0, 15
    syscall
    li $v0, 29
    li $a0, 4
    syscall
    li $v0, 27
    li $a0, 95
    syscall
    j end_if_block

sec_if_block:
    li $t0, 5
    bne $t2, $t0, sec_else_block
    li $v0, 28
    li $a0, 15
    syscall
    li $v0, 29
    li $a0, 4
    syscall
    li $v0, 27
    li $a0, 179
    syscall
    j end_if_block
sec_else_block:
    li $v0, 28
    li $a0, 15
    syscall
    li $v0, 29
    li $a0, 4
    syscall
    li $v0, 27
    li $a0, 95
    syscall
end_if_block:

    addi $t2, $t2, 1
    j sec_for_block
end_sec_for_block:
    li $v0, 30
    syscall
    li $v0, 11
    li $a0, 10
    syscall
    addi $t1, $t1, 1
    j for_block
end_for_block:
    jr $ra

Tree:
    li $v0, 11
    li $a0, 32

    li $t1, 1 ; $t1 --> i
    li $t5, 3 ; $t5 --> 3
for_tree:
    slt $t0, $t5, $t1
    bne $t0, $zero, end_for_tree
    sw $a2, 336($sp)
    add $a2, $a2, $t1
    addi $a2, $a2, -1
    li $v0, 51
    syscall
    lw $a2, 336($sp)
    sll $t3, $t1, 1
    addi $t3, $t3, -1 ; $t3 --> amount
    sub $t4, $t5, $t1
    addi $t4, $t4, 1 ; $t4 --> pos

    li $t2, 0 ; $t2 --> j
sec_for_tree:
    slti $t0, $t2, 7
    beq $t0, $zero, end_sec_for_tree

if_tree:
    beq $t1, $t5, else_tree
    bne $t2, $t4, else_pos 
    li $t6, 0 ; $t6 --> k
for_k:
    slt $t0, $t6, $t3
    beq $t0, $zero, end_for_k
    li $v0, 28
    li $a0, 2
    syscall
    li $v0, 29
    li $a0, 0
    syscall
    li $v0, 27
    li $a0, 176
    syscall
    addi $t6, $t6, 1
    j for_k
end_for_k:
    add $t2, $t2, $t6
    addi $t2, $t2, -1
    j end_if_tree
else_pos:
    li $v0, 30
    syscall
    li $v0, 29
    li $a0, 1
    syscall
    li $v0, 11
    li $a0, 32
    syscall
    j end_if_tree
else_tree:
    bne $t2, $t5, sec_else_pos
    li $v0, 28
    li $a0, 0
    syscall
    li $v0, 29
    li $a0, 4
    syscall
    li $v0, 11
    li $a0, 108
    syscall
    j end_if_tree
sec_else_pos:
    li $v0, 30
    syscall
    li $v0, 29
    li $a0, 1
    syscall
    li $v0, 11
    li $a0, 32
    syscall
end_if_tree:
    addi $t2, $t2, 1
    j sec_for_tree
end_sec_for_tree:
    li $v0, 30
    syscall
    li $v0, 11
    li $a0, 10
    syscall
    addi $t1, $t1, 1
    j for_tree
end_for_tree:
    jr $ra

    