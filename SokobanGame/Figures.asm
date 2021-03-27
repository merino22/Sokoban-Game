.global Block
.global Tree
.global Box
.global Boxspot
.global Player
.global ErasePlayer

; Print Box Function
Box:
    li $v0, 29 ; --> call rlutil::setBackgroundColor()
    li $a0, 6
    syscall
    li $v0, 28 ; --> call rlutil::setColor()
    li $a0, 0
    syscall 
    li $t1, 0 ;--> i
for_box:
    slti $t0, $t1, 3
    beq $t0, $zero, end_for_box
    sw $a2, 336($sp) ; --> store y in stack
    add $a2, $a2, $t1
    li $v0, 51 ; --> call rlutil::locate
    syscall
    lw $a2, 336($sp) ; --> load y variable from stack
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

; Print Block Function
Block:
    li $t1, 0
for_block:
    slti $t0, $t1, 3
    beq $t0, $zero, end_for_block
    sw $a2, 336($sp) ; --> store y value in stack
    add $a2, $a2, $t1
    li $v0, 51 ;--> call rlutil::locate(x, y)
    syscall
    lw $a2, 336($sp) ;--> load y variable from stack
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
    li $v0, 28 ; --> call rlutil::setBackgroundColor()
    li $a0, 15
    syscall
    li $v0, 29 ; --> call rlutil::setColor()
    li $a0, 4
    syscall
    li $v0, 27 ;--> call ascii character switch
    li $a0, 179 ; --> send ascii value of character to print
    syscall
    j end_if_block

else_block:
    li $v0, 28 ; --> call rlutil::setBackgroundColor()
    li $a0, 15
    syscall
    li $v0, 29 ; --> call rlutil::setColor()
    li $a0, 4
    syscall
    li $v0, 27 ; --> call ascii character switch
    li $a0, 95 ; --> send ascii value of character to print
    syscall
    j end_if_block

sec_if_block:
    li $t0, 5
    bne $t2, $t0, sec_else_block
    li $v0, 28 ; --> call rlutil::setBackgroundColor()
    li $a0, 15
    syscall
    li $v0, 29  ; --> call rlutil::setColor()
    li $a0, 4
    syscall
    li $v0, 27 ; --> call ascii character switch 
    li $a0, 179 ; --> send ascii character value to print
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

; Print Tree Function
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

; Print Boxspot Function
Boxspot:
    li $v0, 28
    li $a0, 7
    syscall
    li $t1, 0 ; --> i
for_box_spot:
    slti $t0, $t1, 3
    beq $t0, $zero, end_for_boxspot
    sw $a2, 336($sp)
    add $a2, $a2, $t1
    li $v0, 51
    syscall
    lw $a2, 336($sp)
    li $t2, 0 ; --> j
s_for_boxspot:
    slti $t0, $t2, 7
    beq $t0, $zero, end_s_for_boxspot
    li $t3, 0 ; --> comp var
i_bs_0:
    bne $t1, $t3, i_bs_1
x_j_2:
    li $t3, 2
    bne $t2, $t3, x_j_4
    li $v0, 28
    li $a0, 7
    syscall
    li $v0, 27
    li $a0, 92
    syscall
    j end_i_bs
x_j_4:
    li $t3, 4
    bne $t2, $t3, x_j_e
    li $v0, 28
    li $a0, 7
    syscall
    li $v0, 27
    li $a0, 47
    syscall
    j end_i_bs
x_j_e:
    li $v0, 30
    syscall
    li $v0, 27
    li $a0, 32
    syscall
    j end_i_bs
i_bs_1:
    li $t3, 1
    bne $t1, $t3, i_bs_2
y_j_3:
    li $t3, 3
    bne $t2, $t3, y_j_e
    li $v0, 28
    li $a0, 7
    syscall
    li $v0, 27
    li $a0, 88
    syscall
    j end_i_bs
y_j_e:
    li $v0, 30
    syscall
    li $v0, 27
    li $a0, 32
    syscall
    j end_i_bs
i_bs_2:
z_j_2:
    li $t3, 2
    bne $t2, $t3, z_j_4
    li $v0, 28
    li $a0, 7
    syscall
    li $v0, 27
    li $a0, 47
    syscall
    j end_i_bs
z_j_4:
    li $t3, 4
    bne $t2, $t3, z_j_e
    li $v0, 28
    li $a0, 7
    syscall
    li $v0, 27
    li $a0, 92
    syscall
    j end_i_bs
z_j_e:
    li $v0, 30
    syscall
    li $v0, 27
    li $a0, 32
    syscall 
end_i_bs:
    addi $t2, $t2, 1
    j s_for_boxspot
end_s_for_boxspot:
    li $v0, 11
    li $a0, 10
    syscall
    addi $t1, $t1, 1
    j for_box_spot 
end_for_boxspot:
    jr $ra

; --> Print Player Function
Player:
    li $v0, 30
    syscall
    li $t1, 0 ;--> i
for_player:
    ;#show $t1
    slti $t0, $t1, 3
    beq $t0, $zero, end_for_player
    sw $a2, 336($sp)
    add $a2, $a2, $t1
    li $v0, 51
    syscall
    lw $a2, 336($sp)
    li $t2, 0 ; --> j
s_for_player:
    slti $t0, $t2, 7
    beq $t0, $zero, end_s_for_player
    li $t3, 0
i_p_0:
    bne $t1, $t3, i_p_1
    li $v0, 28
    li $a0, 1
    syscall
    li $v0, 27
i_p_0_j_1:
    li $t3, 1
    bne $t2, $t3, i_p_0_j_5
    li $a0, 220
    syscall
    j end_i_player
i_p_0_j_5:
    li $t3, 5
    bne $t2, $t3, i_p_0_j_2
    li $a0, 220
    syscall
    j end_i_player
i_p_0_j_2:
    li $t3, 2
    bne $t2, $t3, i_p_0_j_3
    li $a0, 219
    syscall
    j end_i_player
i_p_0_j_3:
    li $t3, 3
    bne $t2, $t3, i_p_0_j_4
    li $a0, 219
    syscall
    j end_i_player
i_p_0_j_4:
    li $t3, 4
    bne $t2, $t3, i_p_0_j_e
    li $a0, 219
    syscall
    j end_i_player
i_p_0_j_e:
    li $a0, 32
    syscall
    j end_i_player
i_p_1:
    li $t3, 1
    bne $t1, $t3, i_p_2
    li $v0, 28
    li $a0, 7
    syscall
    li $v0, 27
i_p_1_j_1:
    li $t3, 1
    bne $t2, $t3, i_p_1_j_5
    li $a0, 179
    syscall
    j end_i_player
i_p_1_j_5:
    li $t3, 5
    bne $t2, $t3, i_p_1_j_2
    li $a0, 179
    syscall
    j end_i_player
i_p_1_j_2:
    li $t3, 2
    bne $t2, $t3, i_p_1_j_4
    li $a0, 228
    syscall
    j end_i_player
i_p_1_j_4:
    li $t3, 4
    bne $t2, $t3, i_p_1_j_3
    li $a0, 228
    syscall
    j end_i_player
i_p_1_j_3:
    li $t3, 3
    bne $t2, $t3, i_p_1_j_e
    li $a0, 95
    syscall
    j end_i_player
i_p_1_j_e:
    li $a0, 32
    syscall
    j end_i_player
i_p_2:
    li $t3, 2
    bne $t1, $t3, end_i_player
    ;#show $t1
i_p_2_j_1:
    li $t3, 1
    bne $t2, $t3, i_p_2_j_5
    li $v0, 11
    li $a0, 92
    ;#show $a0
    syscall
    j end_i_player
i_p_2_j_5:
    li $t3, 5
    bne $t2, $t3, i_p_2_j_3
    li $v0, 11
    li $a0, 47
    syscall
    j end_i_player
i_p_2_j_3:
    li $t3, 3
    bne $t2, $t3, i_p_2_j_e
    li $v0, 27
    li $a0, 196
    syscall
    j end_i_player
i_p_2_j_e:
    li $v0, 11
    li $a0, 32
    syscall
end_i_player:

    addi $t2, $t2, 1
    j s_for_player
end_s_for_player:
    ;li $v0, 11
    ;li $a0, 10
    ;syscall
    addi $t1, $t1, 1
    j for_player
end_for_player:
    jr $ra

ErasePlayer:
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 11
    li $a0, 32
    li $t1, 0 ; --> i
for_ep_i:
    slti $t0, $t1, 3
    beq $t0, $zero, end_for_ep_i
    sw $a2, 336($sp)
    add $a2, $a2, $t1
    li $v0, 51 ; --> call rlutil::locate(x,y)
    syscall
    lw $a2, 336($sp)
    li $t2, 0 ; --> j
for_ep_j:
    slti $t0, $t2, 7
    beq $t0, $zero, end_for_ep_j
    li $v0, 11
    li $a0, 32
    syscall
    addi $t2, $t2, 1
    j for_ep_j
end_for_ep_j:
    addi $t1, $t1, 1
    j for_ep_i
end_for_ep_i:
    jr $ra