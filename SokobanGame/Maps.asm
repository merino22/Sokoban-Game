.global printMap
.global generateMap
.global checkPosX
.global checkPosY
.global RepaintBoxes
.global checkBoxSpot
.global checkLevelPassed
.global printLvlCounter
.global printInstruc

.data
    kb_count_str: .byte "Move Counter: ", 0
    lvl_str: .byte "Level: ", 0
    instr_0: .byte "======== GAME INSTRUCTIONS ========", 0
    instr_1: .byte "           Move Up: W", 0
    instr_2: .byte "           Move Down: S", 0
    instr_3: .byte "           Move Left: A", 0
    instr_4: .byte "           Move Right: D", 0
    instr_5: .byte "           Restart Level: SPACE", 0
    instr_6: .byte "           Exit Level: ESC", 0
    instr_7: .byte "           Press SPACE to return to Main Menu"

.text

; Function for Printing Instruction Menu
printInstruc:
    li $v0, 30
    syscall
    li $v0, 53
    syscall
    li $v0, 28
    li $a0, 6
    syscall
    li $v0, 29
    li $a0, 0
    syscall
    li $v0, 4
    la $a0, instr_0
    syscall
    li $v0, 11
    li $a0, 10
    syscall
    li $v0, 4
    la $a0, instr_1
    syscall
    li $v0, 11
    li $a0, 10
    syscall
    li $v0, 4
    la $a0, instr_2
    syscall
    li $v0, 11
    li $a0, 10
    syscall
    li $v0, 4
    la $a0, instr_3
    syscall
    li $v0, 11
    li $a0, 10
    syscall
    li $v0, 4
    la $a0, instr_4
    syscall
    li $v0, 11
    li $a0, 10
    syscall
    li $v0, 4
    la $a0, instr_5
    syscall
    li $v0, 11
    li $a0, 10
    syscall
    li $v0, 4
    la $a0, instr_6
    syscall
    li $v0, 11
    li $a0, 10
    syscall
    li $v0, 4
    li $a0, instr_7
    syscall
while_instruc:
    li $v0, 31
    syscall
    li $t0, 32
    beq $v0, $t0, end_while_instruc
    j while_instruc
end_while_instruc:
    jr $ra

; Function for Printing Level Counter
printLvlCounter:
    li $v0, 51
    li $a1, 15
    li $a2, 29
    syscall
    li $v0, 4
    li $a0, lvl_str ; --> print level
    syscall
    li $v0, 1
    move $a0, $s0
    syscall
    li $v0, 51
    li $a1, 35
    li $a2, 29
    syscall
    li $v0, 4
    li $a0, kb_count_str ; --> print move counter
    syscall
    li $v0, 1
    move $a0, $s1
    syscall
    jr $ra

; Function for checking if current level is passed
checkLevelPassed:
    lw $a0, 340($sp)
    li $t1, 0 ;--> i
    li $t7, 5 ;--> compare
for_check_lvl:
    slti $t0, $t1, 9
    beq $t0, $zero, end_for_check_lvl
    li $t3, 36
    mult $t1, $t3 ;--> i * 36
    mflo $t4 ;--> i * 36
    li $t2, 0
s_for_check_lvl:
    slti $t0, $t2, 9
    beq $t0, $zero, end_s_for_check_lvl
    li $t3, 4
    mult $t2, $t3
    mflo $t5 ; --> i * 4
    add $t5, $t5, $t4
    add $t5, $t5, $a0
    lw $t6, 0($t5)
if_five:
    bne $t6, $t7, end_if_five
    li $v0, 0
    j end_false
end_if_five:
    addi $t2, $t2, 1
    j s_for_check_lvl
end_s_for_check_lvl:
    addi $t1, $t1, 1
    j for_check_lvl
end_for_check_lvl:
    li $v0, 1
end_false:
    sw $a0, 340($sp)
    jr $ra

; Function for printing current level Map
printMap:
    ; $a0 --> mem direction of map
    ;#show $a0
    sw $ra, 344($sp)
    li $a1, 1 ; $a1 --> x
    li $a2, 1; $a2 --> y
    li $t1, 0 ; --> i
for_i:
    slti $t0, $t1, 9
    beq $t0, $zero, end_for_i
    li $t2, 0 ; --> j
for_j:
    slti $t0, $t2, 9
    beq $t0, $zero, end_for_j
    lw $a0, 340($sp)
    ;#show $a0
    li $t0, 36
    li $t3, 0
    mult $t1, $t0 ; --> i * 36
    mflo $t3
    sll $t0, $t2, 2 ; --> j * 4
    add $t3, $t0, $t3
    add $t3, $a0, $t3
    lw $t4, 0($t3)
    ;#show $t4
    li $t0, 1 ;--> constant 1
    sw $t1, 328($sp) ;--> store i var in stack
    sw $t2, 332($sp) ;--> store j var in stack
    ;#show $a0
    sw $a0, 340($sp)
if_tree:
    bne $t4, $t0, if_block
    jal Tree
    ;#show $a0
if_block:
    li $t0, 2
    bne $t4, $t0, if_box 
    jal Block
if_box:
    li $t0, 3
    bne $t4, $t0, if_boxspot
    jal Box
if_boxspot:
    li $t0, 5
    bne $t4, $t0, if_player
    jal Boxspot
if_player:
    li $t0, 4
    bne $t4, $t0, end_ifs
    jal Player
end_ifs:
    lw $t1, 328($sp)
    lw $t2, 332($sp)
    addi $a1, $a1, 7
    addi $t2, $t2, 1
    j for_j
end_for_j:
    li $a1, 1
    addi $a2, $a2, 3
    addi $t1, $t1, 1
    j for_i
end_for_i:
    ;#show $s0
    lw $ra, 344($sp)
    jr $ra

; Function for checking if next x movement is valid
checkPosX:
    lw $a0, 340($sp)
    ;#show $a0
    move $t1, $a1 ; --> x
    move $t2, $a2 ; --> y
    move $t3, $a3 ; --> posMove
    li $t4, 7 ; --> Divisor
    ; --> x-1/7
    addi $t1, $t1, -1 
    div $t1, $t4
    mflo $t1

    ; --> posMove/7
    div $t3, $t4
    mflo $t3
    
    ; --> y-1/3
    li $t4, 3
    addi $t2, $t2, -1
    div $t2, $t4
    mflo $t2

    li $t4, 0 ;--> boxSum
if_lt_0:
    slt $t0, $t3, $zero
    beq $t0, $zero, else_lt_0
    li $t4, -1
    j end_lt
else_lt_0:
    li $t4, 1
end_lt:

    li $t5, 36
    mult $t2, $t5
    mflo $t2

    li $t5, 4
    mult $t1, $t5
    mflo $t1

    mult $t3, $t5
    mflo $t3

    mult $t4, $t5
    mflo $t4

    li $t5, 0
    add $t5, $a0, $t5
    ;#show $t5
    add $t5, $t5, $t2
    add $t5, $t5, $t1
    sw $t5, 348($sp) ;--> x + y
    add $t5, $t5, $t3
    ;#show $t5
    sw $t5, 352($sp);--> x + y + posMove
    add $t5, $t5, $t4
    sw $t5, 356($sp);--> x+y+posMove+boxsum

if_arr_2:
    lw $t4, 352($sp)
    lw $t5, 0($t4)
    li $t1, 2
    bne $t1, $t5, if_arr_3
    li $v0, 0
    j end_if_arr
if_arr_3:
    li $t1, 3
    bne $t1, $t5, if_arr_e

if_boxsum_0:
    lw $t4, 356($sp)
    lw $t5, 0($t4)
    li $t1, 0
    bne $t5, $t1, if_boxsum_5
    lw $t4, 348($sp)
    sw $t1, 0($t4)
    lw $t4, 352($sp)
    li $t1, 4
    sw $t1, 0($t4)
    lw $t4, 356($sp)
    li $t1, 3
    sw $t1, 0($t4)
    li $v0, 1
    j end_if_arr
if_boxsum_5:
    li $t1, 5
    bne $t5, $t1, if_boxsum_e
    lw $t4, 348($sp)
    sw $t1, 0($t4)
    lw $t4, 352($sp)
    li $t1, 4
    sw $t1, 0($t4)
    lw $t4, 356($sp)
    li $t1, 3
    sw $t1, 0($t4)
    li $v0, 1
    j end_if_arr
if_boxsum_e:
    li $v0, 0
    j end_if_arr
if_arr_e:
    lw $t4, 348($sp)
    li $t1, 0
    sw $t1, 0($t4)
    lw $t4, 352($sp)
    li $t1, 4
    sw $t1, 0($t4)
    li $v0, 1
end_if_arr:
    sw $a0, 340($sp)
    jr $ra

; Function for checking if next y movement is valid
checkPosY:
    lw $a0, 340($sp)
    ;#show $a0
    move $t1, $a1 ; --> x
    move $t2, $a2 ; --> y
    move $t3, $a3 ; --> posMove
    li $t4, 7 ; --> Divisor
    ; --> x-1/7
    addi $t1, $t1, -1 
    div $t1, $t4
    mflo $t1

    li $t4, 3
    ; --> posMove/3
    div $t3, $t4
    mflo $t3
    
    ; --> y-1/3
    li $t4, 3
    addi $t2, $t2, -1
    div $t2, $t4
    mflo $t2

    li $t4, 0 ;--> boxSum
if_lt_0_y:
    slt $t0, $t3, $zero
    beq $t0, $zero, else_lt_0_y
    li $t4, -1
    j end_lt_y
else_lt_0_y:
    li $t4, 1
end_lt_y:

    li $t5, 36
    mult $t2, $t5
    mflo $t2

    mult $t3, $t5
    mflo $t3

    mult $t4, $t5
    mflo $t4

    li $t5, 4
    mult $t1, $t5
    mflo $t1

    li $t5, 0
    add $t5, $a0, $t5
    ;#show $t5
    add $t5, $t5, $t2
    add $t5, $t5, $t1
    sw $t5, 348($sp) ;--> x + y
    add $t5, $t5, $t3
    ;#show $t5
    sw $t5, 352($sp);--> x + y + posMove
    add $t5, $t5, $t4
    sw $t5, 356($sp);--> x+y+posMove+boxsum

if_arr_2_y:
    lw $t4, 352($sp)
    lw $t5, 0($t4)
    li $t1, 2
    bne $t1, $t5, if_arr_3_y
    li $v0, 0
    j end_if_arr
if_arr_3_y:
    li $t1, 3
    bne $t1, $t5, if_arr_e_y

if_boxsum_0_y:
    lw $t4, 356($sp)
    lw $t5, 0($t4)
    li $t1, 0
    bne $t5, $t1, if_boxsum_5_y
    lw $t4, 348($sp)
    sw $t1, 0($t4)
    lw $t4, 352($sp)
    li $t1, 4
    sw $t1, 0($t4)
    lw $t4, 356($sp)
    li $t1, 3
    sw $t1, 0($t4)
    li $v0, 1
    j end_if_arr_y
if_boxsum_5_y:
    li $t1, 5
    bne $t5, $t1, if_boxsum_e_y
    lw $t4, 348($sp)
    sw $t1, 0($t4)
    lw $t4, 352($sp)
    li $t1, 4
    sw $t1, 0($t4)
    lw $t4, 356($sp)
    li $t1, 3
    sw $t1, 0($t4)
    li $v0, 1
    j end_if_arr_y
if_boxsum_e_y:
    li $v0, 0
    j end_if_arr
if_arr_e_y:
    lw $t4, 348($sp)
    li $t1, 0
    sw $t1, 0($t4)
    lw $t4, 352($sp)
    li $t1, 4
    sw $t1, 0($t4)
    li $v0, 1
end_if_arr_y:
    sw $a0, 340($sp)
    jr $ra

; Function for repainting boxes onto map after array modification
RepaintBoxes:
    ; $a0 --> mem direction of map
    ;#show $a0
    sw $ra, 344($sp)
    li $a1, 1 ; $a1 --> x
    li $a2, 1; $a2 --> y
    li $t1, 0 ; --> i
for_i_rep:
    slti $t0, $t1, 9
    beq $t0, $zero, end_for_i_rep
    li $t2, 0 ; --> j
for_j_rep:
    slti $t0, $t2, 9
    beq $t0, $zero, end_for_j_rep
    lw $a0, 340($sp)
    ;#show $a0
    li $t0, 36
    li $t3, 0
    mult $t1, $t0 ; --> i * 36
    mflo $t3
    sll $t0, $t2, 2 ; --> j * 4
    add $t3, $t0, $t3
    add $t3, $a0, $t3
    lw $t4, 0($t3)
    ;#show $t4
    li $t0, 1 ;--> constant 1
    sw $t1, 328($sp) ;--> store i var in stack
    sw $t2, 332($sp) ;--> store j var in stack
    ;#show $a0
    sw $a0, 340($sp)

if_box_repaint:
    li $t0, 3
    bne $t4, $t0, end_ifs_rep
    jal Box
end_ifs_rep:
    lw $t1, 328($sp)
    lw $t2, 332($sp)
    addi $a1, $a1, 7
    addi $t2, $t2, 1
    j for_j_rep
end_for_j_rep:
    li $a1, 1
    addi $a2, $a2, 3
    addi $t1, $t1, 1
    j for_i_rep
end_for_i_rep:
    lw $ra, 344($sp)
    jr $ra

; Check if player or box is on top of a boxspot, if removed repaint boxspot
checkBoxSpot:
    sw $ra, 344($sp)
if_lvl_1:
    li $t3, 1
    bne $s0, $t3, if_lvl_2
lvl_1_spot_1:
    li $t1, 8 ;--> x
    li $t2, 13;--> y
    bne $a1, $t1, lvl_1_spot_2
    bne $a2, $t2, lvl_1_spot_2
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_1_spots
lvl_1_spot_2:
    li $t1, 22 ;--> x
    li $t2, 4;--> y
    bne $a1, $t1, lvl_1_spot_3
    bne $a2, $t2, lvl_1_spot_3
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_1_spots
lvl_1_spot_3:
    li $t1, 43 ;--> x
    li $t2, 10;--> y
    bne $a1, $t1, lvl_1_spot_4
    bne $a2, $t2, lvl_1_spot_4
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_1_spots
lvl_1_spot_4:
    li $t1, 29 ;--> x
    li $t2, 19;--> y
    bne $a1, $t1, end_lvl_1_spots
    bne $a2, $t2, end_lvl_1_spots
    jal sortBoxspotArray
    jal Boxspot
end_lvl_1_spots:
    j end_if_lvl
if_lvl_2:
    li $t3, 2
    bne $s0, $t3, if_lvl_3 
lvl_2_spot_1:
    li $t1, 50 ;--> x
    li $t2, 10;--> y
    bne $a1, $t1, lvl_2_spot_2
    bne $a2, $t2, lvl_2_spot_2
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_2_spots
lvl_2_spot_2:
    li $t1, 50 ;--> x
    li $t2, 13;--> y
    bne $a1, $t1, lvl_2_spot_3
    bne $a2, $t2, lvl_2_spot_3
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_2_spots
lvl_2_spot_3:
    li $t1, 50 ;--> x
    li $t2, 16;--> y
    bne $a1, $t1, end_lvl_2_spots
    bne $a2, $t2, end_lvl_2_spots
    jal sortBoxspotArray
    jal Boxspot
end_lvl_2_spots:
    j end_if_lvl

if_lvl_3:
    li $t3, 3
    bne $s0, $t3, if_lvl_4
lvl_3_spot_1:
    li $t1, 8 ;--> x
    li $t2, 16;--> y
    bne $a1, $t1, lvl_3_spot_2
    bne $a2, $t2, lvl_3_spot_2
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_3_spots
lvl_3_spot_2:
    li $t1, 15 ;--> x
    li $t2, 19;--> y
    bne $a1, $t1, lvl_3_spot_3
    bne $a2, $t2, lvl_3_spot_3
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_3_spots
lvl_3_spot_3:
    li $t1, 15 ;--> x
    li $t2, 19;--> y
    bne $a1, $t1, lvl_3_spot_4
    bne $a2, $t2, lvl_3_spot_4
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_3_spots
lvl_3_spot_4:
    li $t1, 22 ;--> x
    li $t2, 19;--> y
    bne $a1, $t1, lvl_3_spot_5
    bne $a2, $t2, lvl_3_spot_5
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_3_spots
lvl_3_spot_5:
    li $t1, 29 ;--> x
    li $t2, 19;--> y
    bne $a1, $t1, end_lvl_3_spots
    bne $a2, $t2, end_lvl_3_spots
    jal sortBoxspotArray
    jal Boxspot
end_lvl_3_spots:
    j end_if_lvl

if_lvl_4:
    li $t3, 4
    bne $s0, $t3, if_lvl_5
lvl_4_spot_1:
    li $t1, 8 ;--> x
    li $t2, 13;--> y
    bne $a1, $t1, lvl_4_spot_2
    bne $a2, $t2, lvl_4_spot_2
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_4_spots
lvl_4_spot_2:
    li $t1, 8 ;--> x
    li $t2, 16;--> y
    bne $a1, $t1, lvl_4_spot_3
    bne $a2, $t2, lvl_4_spot_3
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_4_spots
lvl_4_spot_3:
    li $t1, 8 ;--> x
    li $t2, 19;--> y
    bne $a1, $t1, end_lvl_4_spots
    bne $a2, $t2, end_lvl_4_spots
    jal sortBoxspotArray
    jal Boxspot
end_lvl_4_spots:
    j end_if_lvl

if_lvl_5:
    li $t3, 5
    bne $s0, $t3, if_lvl_6
lvl_5_spot_1:
    li $t1, 29 ;--> x
    li $t2, 10;--> y
    bne $a1, $t1, lvl_5_spot_2
    bne $a2, $t2, lvl_5_spot_2
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_5_spots
lvl_5_spot_2:
    li $t1, 36 ;--> x
    li $t2, 10;--> y
    bne $a1, $t1, lvl_5_spot_3
    bne $a2, $t2, lvl_5_spot_3
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_5_spots
lvl_5_spot_3:
    li $t1, 22 ;--> x
    li $t2, 13;--> y
    bne $a1, $t1, lvl_5_spot_4
    bne $a2, $t2, lvl_5_spot_4
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_5_spots
lvl_5_spot_4:
    li $t1, 29 ;--> x
    li $t2, 13;--> y
    bne $a1, $t1, lvl_5_spot_5
    bne $a2, $t2, lvl_5_spot_5
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_5_spots
lvl_5_spot_5:
    li $t1, 36 ;--> x
    li $t2, 13;--> y
    bne $a1, $t1, end_lvl_5_spots
    bne $a2, $t2, end_lvl_5_spots
    jal sortBoxspotArray
    jal Boxspot
end_lvl_5_spots:
    j end_if_lvl

if_lvl_6:
    li $t3, 6
    bne $s0, $t3, if_lvl_7
lvl_6_spot_1:
    li $t1, 29 ;--> x
    li $t2, 7;--> y
    ;j end_if_lvl
    bne $a1, $t1, lvl_6_spot_2
    bne $a2, $t2, lvl_6_spot_2
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_6_spots
lvl_6_spot_2:
    li $t1, 22 ;--> x
    li $t2, 10;--> y
    bne $a1, $t1, lvl_6_spot_3
    bne $a2, $t2, lvl_6_spot_3
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_6_spots
lvl_6_spot_3:
    li $t1, 36 ;--> x
    li $t2, 10;--> y
    bne $a1, $t1, lvl_6_spot_4
    bne $a2, $t2, lvl_6_spot_4
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_6_spots
lvl_6_spot_4:
    li $t1, 29 ;--> x
    li $t2, 13;--> y
    bne $a1, $t1, end_lvl_6_spots
    bne $a2, $t2, end_lvl_6_spots
    jal sortBoxspotArray
    jal Boxspot
end_lvl_6_spots:
    j end_if_lvl
if_lvl_7:
    li $t3, 7
    bne $s0, $t3, if_lvl_8
lvl_7_spot_1:
    li $t1, 22 ;--> x
    li $t2, 4;--> y
    ;j end_if_lvl
    bne $a1, $t1, lvl_7_spot_2
    bne $a2, $t2, lvl_7_spot_2
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_7_spots
lvl_7_spot_2:
    li $t1, 29 ;--> x
    li $t2, 4;--> y
    bne $a1, $t1, lvl_7_spot_3
    bne $a2, $t2, lvl_7_spot_3
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_7_spots
lvl_7_spot_3:
    li $t1, 29 ;--> x
    li $t2, 7;--> y
    bne $a1, $t1, lvl_7_spot_4
    bne $a2, $t2, lvl_7_spot_4
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_7_spots
lvl_7_spot_4:
    li $t1, 36 ;--> x
    li $t2, 10;--> y
    bne $a1, $t1, end_lvl_7_spots
    bne $a2, $t2, end_lvl_7_spots
    jal sortBoxspotArray
    jal Boxspot
end_lvl_7_spots:
    j end_if_lvl
if_lvl_8:
    li $t3, 8
    bne $s0, $t3, if_lvl_9
lvl_8_spot_1:
    li $t1, 15 ;--> x
    li $t2, 10 ;--> y
    ;j end_if_lvl
    bne $a1, $t1, lvl_8_spot_2
    bne $a2, $t2, lvl_8_spot_2
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_8_spots
lvl_8_spot_2:
    li $t1, 22 ;--> x
    li $t2, 10 ;--> y
    bne $a1, $t1, lvl_8_spot_3
    bne $a2, $t2, lvl_8_spot_3
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_8_spots
lvl_8_spot_3:
    li $t1, 36 ;--> x
    li $t2, 10 ;--> y
    bne $a1, $t1, lvl_8_spot_4
    bne $a2, $t2, lvl_8_spot_4
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_8_spots
lvl_8_spot_4:
    li $t1, 36 ;--> x
    li $t2, 16 ;--> y
    bne $a1, $t1, end_lvl_8_spots
    bne $a2, $t2, end_lvl_8_spots
    jal sortBoxspotArray
    jal Boxspot
end_lvl_8_spots:
    j end_if_lvl
if_lvl_9:
    li $t3, 9
    bne $s0, $t3, if_lvl_10
lvl_9_spot_1:
    li $t1, 29 ;--> x
    li $t2, 10 ;--> y
    ;j end_if_lvl
    bne $a1, $t1, lvl_9_spot_2
    bne $a2, $t2, lvl_9_spot_2
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_9_spots
lvl_9_spot_2:
    li $t1, 36 ;--> x
    li $t2, 10 ;--> y
    bne $a1, $t1, lvl_9_spot_3
    bne $a2, $t2, lvl_9_spot_3
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_9_spots
lvl_9_spot_3:
    li $t1, 29 ;--> x
    li $t2, 13 ;--> y
    bne $a1, $t1, lvl_9_spot_4
    bne $a2, $t2, lvl_9_spot_4
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_9_spots
lvl_9_spot_4:
    li $t1, 36 ;--> x
    li $t2, 13 ;--> y
    bne $a1, $t1, end_lvl_9_spots
    bne $a2, $t2, end_lvl_9_spots
    jal sortBoxspotArray
    jal Boxspot
end_lvl_9_spots:
    j end_if_lvl
if_lvl_10:
    li $t3, 10
    bne $s0, $t3, end_if_lvl
lvl_10_spot_1:
    li $t1, 15 ;--> x
    li $t2, 7 ;--> y
    bne $a1, $t1, lvl_10_spot_2
    bne $a2, $t2, lvl_10_spot_2
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_10_spots
lvl_10_spot_2:
    li $t1, 15 ;--> x
    li $t2, 10 ;--> y
    bne $a1, $t1, lvl_10_spot_3
    bne $a2, $t2, lvl_10_spot_3
    jal sortBoxspotArray
    jal Boxspot
    j end_lvl_8_spots
lvl_10_spot_3:
    li $t1, 22 ;--> x
    li $t2, 10 ;--> y
    bne $a1, $t1, end_lvl_10_spots
    bne $a2, $t2, end_lvl_10_spots
    jal sortBoxspotArray
    jal Boxspot
end_lvl_10_spots:
    j end_if_lvl

end_if_lvl:
    lw $ra, 344($sp)
    jr $ra

; Function for box position modification inside array
sortBoxspotArray:
    lw $a0, 340($sp)
    move $t1, $a1 ; --> x
    move $t2, $a2 ; --> y

    li $t4, 7 ; --> Divisor
    ; --> x-1/7
    addi $t1, $t1, -1 
    div $t1, $t4
    mflo $t1
    
    ; --> y-1/3
    li $t4, 3
    addi $t2, $t2, -1
    div $t2, $t4
    mflo $t2

    li $t4, 4
    mult $t1, $t4 ;--> x * 4
    mflo $t1

    li $t4, 36
    mult $t2, $t4 ;--> x * 36
    mflo $t2

    move $t4, $t1
    add $t4, $t4, $t2
    add $t4, $t4, $a0

    li $t5, 5

    sw $t5, 0($t4)
    sw $a0, 340($sp)
    jr $ra

; Function for loading next map to be played onto the stack
generateMap:
if_first_level:
    li $t0, 1
    bne $s0, $t0, if_second_level

    ;--- row 0
    li $t0, 1
    sw $t0, 0($sp)
    li $t0, 1
    sw $t0, 4($sp)
    li $t0, 2
    sw $t0, 8($sp)
    li $t0, 2
    sw $t0, 12($sp)
    li $t0, 2
    sw $t0, 16($sp)
    li $t0, 1
    sw $t0, 20($sp)
    li $t0, 1
    sw $t0, 24($sp)
    li $t0, 1
    sw $t0, 28($sp)
    li $t0, 1
    sw $t0, 32($sp)

    ;--- row 1
    li $t0, 1
    sw $t0, 36($sp)
    li $t0, 1
    sw $t0, 40($sp)
    li $t0, 2
    sw $t0, 44($sp)
    li $t0, 5
    sw $t0, 48($sp)
    li $t0, 2
    sw $t0, 52($sp)
    li $t0, 1
    sw $t0, 56($sp)
    li $t0, 1
    sw $t0, 60($sp)
    li $t0, 1
    sw $t0, 64($sp)
    li $t0, 1
    sw $t0, 68($sp)

    ;--- row 2
    li $t0, 1
    sw $t0, 72($sp)
    li $t0, 1
    sw $t0, 76($sp)
    li $t0, 2
    sw $t0, 80($sp)
    li $t0, 0
    sw $t0, 84($sp)
    li $t0, 2
    sw $t0, 88($sp)
    li $t0, 2
    sw $t0, 92($sp)
    li $t0, 2
    sw $t0, 96($sp)
    li $t0, 2
    sw $t0, 100($sp)
    li $t0, 1
    sw $t0, 104($sp)

    ;--- row 3
    li $t0, 2
    sw $t0, 108($sp)
    li $t0, 2
    sw $t0, 112($sp)
    li $t0, 2
    sw $t0, 116($sp)
    li $t0, 3 ; --aqui
    sw $t0, 120($sp)
    li $t0, 0
    sw $t0, 124($sp)
    li $t0, 3 ; --aqui
    sw $t0, 128($sp)
    li $t0, 5
    sw $t0, 132($sp)
    li $t0, 2
    sw $t0, 136($sp)
    li $t0, 1
    sw $t0, 140($sp)

    ;---row 4
    li $t0, 2
    sw $t0, 144($sp)
    li $t0, 5
    sw $t0, 148($sp)
    li $t0, 0
    sw $t0, 152($sp)
    li $t0, 3 ;-- aqui
    sw $t0, 156($sp)
    li $t0, 4
    sw $t0, 160($sp)
    li $t0, 2
    sw $t0, 164($sp)
    li $t0, 2
    sw $t0, 168($sp)
    li $t0, 2
    sw $t0, 172($sp)
    li $t0, 1
    sw $t0, 176($sp)

    ;--- row 5
    li $t0, 2
    sw $t0, 180($sp)
    li $t0, 2
    sw $t0, 184($sp)
    li $t0, 2
    sw $t0, 188($sp)
    li $t0, 2
    sw $t0, 192($sp)
    li $t0, 3 ;-- aqui
    sw $t0, 196($sp)
    li $t0, 2
    sw $t0, 200($sp)
    li $t0, 1
    sw $t0, 204($sp)
    li $t0, 1
    sw $t0, 208($sp)
    li $t0, 1
    sw $t0, 212($sp)

    ;--- row 6
    li $t0, 1
    sw $t0, 216($sp)
    li $t0, 1
    sw $t0, 220($sp)
    li $t0, 1
    sw $t0, 224($sp)
    li $t0, 2
    sw $t0, 228($sp)
    li $t0, 5
    sw $t0, 232($sp)
    li $t0, 2
    sw $t0, 236($sp)
    li $t0, 1
    sw $t0, 240($sp)
    li $t0, 1
    sw $t0, 244($sp)
    li $t0, 1
    sw $t0, 248($sp)

    ;--- row 7
    li $t0, 1
    sw $t0, 252($sp)
    li $t0, 1
    sw $t0, 256($sp)
    li $t0, 1
    sw $t0, 260($sp)
    li $t0, 2
    sw $t0, 264($sp)
    li $t0, 2
    sw $t0, 268($sp)
    li $t0, 2
    sw $t0, 272($sp)
    li $t0, 1
    sw $t0, 276($sp)
    li $t0, 1
    sw $t0, 280($sp)
    li $t0, 1
    sw $t0, 284($sp)

    ;--- row 8
    li $t0, 1
    sw $t0, 288($sp)
    li $t0, 1
    sw $t0, 292($sp)
    li $t0, 1
    sw $t0, 296($sp)
    li $t0, 1
    sw $t0, 300($sp)
    li $t0, 1
    sw $t0, 304($sp)
    li $t0, 1
    sw $t0, 308($sp)
    li $t0, 1
    sw $t0, 312($sp)
    li $t0, 1
    sw $t0, 316($sp)
    li $t0, 1
    sw $t0, 320($sp)

    move $a0, $sp
    sw $a0, 340($sp)
    j end_levels
if_second_level:
    li $t0, 2
    bne $s0, $t0, if_third_level

    ;--- row 0
    li $t0, 2
    sw $t0, 0($sp)
    li $t0, 2
    sw $t0, 4($sp)
    li $t0, 2
    sw $t0, 8($sp)
    li $t0, 2
    sw $t0, 12($sp)
    li $t0, 2
    sw $t0, 16($sp)
    li $t0, 1
    sw $t0, 20($sp)
    li $t0, 1
    sw $t0, 24($sp)
    li $t0, 1
    sw $t0, 28($sp)
    li $t0, 1
    sw $t0, 32($sp)

    ;--- row 1
    li $t0, 2
    sw $t0, 36($sp)
    li $t0, 0
    sw $t0, 40($sp)
    li $t0, 0
    sw $t0, 44($sp)
    li $t0, 0
    sw $t0, 48($sp)
    li $t0, 2
    sw $t0, 52($sp)
    li $t0, 1
    sw $t0, 56($sp)
    li $t0, 1
    sw $t0, 60($sp)
    li $t0, 1
    sw $t0, 64($sp)
    li $t0, 1
    sw $t0, 68($sp)

    ;--- row 2
    li $t0, 2
    sw $t0, 72($sp)
    li $t0, 0
    sw $t0, 76($sp)
    li $t0, 3
    sw $t0, 80($sp)
    li $t0, 4
    sw $t0, 84($sp)
    li $t0, 2
    sw $t0, 88($sp)
    li $t0, 1
    sw $t0, 92($sp)
    li $t0, 2
    sw $t0, 96($sp)
    li $t0, 2
    sw $t0, 100($sp)
    li $t0, 2
    sw $t0, 104($sp)

    ;--- row 3
    li $t0, 2
    sw $t0, 108($sp)
    li $t0, 0
    sw $t0, 112($sp)
    li $t0, 3
    sw $t0, 116($sp)
    li $t0, 3 ; --aqui
    sw $t0, 120($sp)
    li $t0, 2
    sw $t0, 124($sp)
    li $t0, 1 ; --aqui
    sw $t0, 128($sp)
    li $t0, 2
    sw $t0, 132($sp)
    li $t0, 5
    sw $t0, 136($sp)
    li $t0, 2
    sw $t0, 140($sp)

    ;---row 4
    li $t0, 2
    sw $t0, 144($sp)
    li $t0, 2
    sw $t0, 148($sp)
    li $t0, 2
    sw $t0, 152($sp)
    li $t0, 0 ;-- aqui
    sw $t0, 156($sp)
    li $t0, 2
    sw $t0, 160($sp)
    li $t0, 2
    sw $t0, 164($sp)
    li $t0, 2
    sw $t0, 168($sp)
    li $t0, 5
    sw $t0, 172($sp)
    li $t0, 2
    sw $t0, 176($sp)

    ;--- row 5
    li $t0, 1
    sw $t0, 180($sp)
    li $t0, 2
    sw $t0, 184($sp)
    li $t0, 2
    sw $t0, 188($sp)
    li $t0, 0
    sw $t0, 192($sp)
    li $t0, 0 ;-- aqui
    sw $t0, 196($sp)
    li $t0, 0
    sw $t0, 200($sp)
    li $t0, 0
    sw $t0, 204($sp)
    li $t0, 5
    sw $t0, 208($sp)
    li $t0, 2
    sw $t0, 212($sp)

    ;--- row 6
    li $t0, 1
    sw $t0, 216($sp)
    li $t0, 2
    sw $t0, 220($sp)
    li $t0, 0
    sw $t0, 224($sp)
    li $t0, 0
    sw $t0, 228($sp)
    li $t0, 0
    sw $t0, 232($sp)
    li $t0, 2
    sw $t0, 236($sp)
    li $t0, 0
    sw $t0, 240($sp)
    li $t0, 0
    sw $t0, 244($sp)
    li $t0, 2
    sw $t0, 248($sp)

    ;--- row 7
    li $t0, 1
    sw $t0, 252($sp)
    li $t0, 2
    sw $t0, 256($sp)
    li $t0, 0
    sw $t0, 260($sp)
    li $t0, 0
    sw $t0, 264($sp)
    li $t0, 0
    sw $t0, 268($sp)
    li $t0, 2
    sw $t0, 272($sp)
    li $t0, 2
    sw $t0, 276($sp)
    li $t0, 2
    sw $t0, 280($sp)
    li $t0, 2
    sw $t0, 284($sp)

    ;--- row 8
    li $t0, 1
    sw $t0, 288($sp)
    li $t0, 2
    sw $t0, 292($sp)
    li $t0, 2
    sw $t0, 296($sp)
    li $t0, 2
    sw $t0, 300($sp)
    li $t0, 2
    sw $t0, 304($sp)
    li $t0, 2
    sw $t0, 308($sp)
    li $t0, 1
    sw $t0, 312($sp)
    li $t0, 1
    sw $t0, 316($sp)
    li $t0, 1
    sw $t0, 320($sp)

    move $a0, $sp
    sw $a0, 340($sp)
    j end_levels

if_third_level:
    li $t0, 3
    bne $s0, $t0, if_forth_level
    ;--- row 0
    li $t0, 1
    sw $t0, 0($sp)
    li $t0, 2
    sw $t0, 4($sp)
    li $t0, 2
    sw $t0, 8($sp)
    li $t0, 2
    sw $t0, 12($sp)
    li $t0, 2
    sw $t0, 16($sp)
    li $t0, 1
    sw $t0, 20($sp)
    li $t0, 1
    sw $t0, 24($sp)
    li $t0, 1
    sw $t0, 28($sp)
    li $t0, 1
    sw $t0, 32($sp)

    ;--- row 1
    li $t0, 2
    sw $t0, 36($sp)
    li $t0, 2
    sw $t0, 40($sp)
    li $t0, 0
    sw $t0, 44($sp)
    li $t0, 0
    sw $t0, 48($sp)
    li $t0, 2
    sw $t0, 52($sp)
    li $t0, 1
    sw $t0, 56($sp)
    li $t0, 1
    sw $t0, 60($sp)
    li $t0, 1
    sw $t0, 64($sp)
    li $t0, 1
    sw $t0, 68($sp)

    ;--- row 2
    li $t0, 2
    sw $t0, 72($sp)
    li $t0, 0
    sw $t0, 76($sp)
    li $t0, 4
    sw $t0, 80($sp)
    li $t0, 3
    sw $t0, 84($sp)
    li $t0, 2
    sw $t0, 88($sp)
    li $t0, 1
    sw $t0, 92($sp)
    li $t0, 1
    sw $t0, 96($sp)
    li $t0, 1
    sw $t0, 100($sp)
    li $t0, 1
    sw $t0, 104($sp)

    ;--- row 3
    li $t0, 2
    sw $t0, 108($sp)
    li $t0, 2
    sw $t0, 112($sp)
    li $t0, 3
    sw $t0, 116($sp)
    li $t0, 0
    sw $t0, 120($sp)
    li $t0, 2
    sw $t0, 124($sp)
    li $t0, 2
    sw $t0, 128($sp)
    li $t0, 1
    sw $t0, 132($sp)
    li $t0, 1
    sw $t0, 136($sp)
    li $t0, 1
    sw $t0, 140($sp)

    ;---row 4
    li $t0, 2
    sw $t0, 144($sp)
    li $t0, 2
    sw $t0, 148($sp)
    li $t0, 0
    sw $t0, 152($sp)
    li $t0, 3
    sw $t0, 156($sp)
    li $t0, 0
    sw $t0, 160($sp)
    li $t0, 2
    sw $t0, 164($sp)
    li $t0, 1
    sw $t0, 168($sp)
    li $t0, 1
    sw $t0, 172($sp)
    li $t0, 1
    sw $t0, 176($sp)

    ;--- row 5
    li $t0, 2
    sw $t0, 180($sp)
    li $t0, 5
    sw $t0, 184($sp)
    li $t0, 3
    sw $t0, 188($sp)
    li $t0, 0
    sw $t0, 192($sp)
    li $t0, 0 ;-- aqui
    sw $t0, 196($sp)
    li $t0, 2
    sw $t0, 200($sp)
    li $t0, 1
    sw $t0, 204($sp)
    li $t0, 1
    sw $t0, 208($sp)
    li $t0, 1
    sw $t0, 212($sp)

    ;--- row 6
    li $t0, 2
    sw $t0, 216($sp)
    li $t0, 5
    sw $t0, 220($sp)
    li $t0, 5
    sw $t0, 224($sp)
    li $t0, 3
    sw $t0, 228($sp)
    li $t0, 5
    sw $t0, 232($sp)
    li $t0, 2
    sw $t0, 236($sp)
    li $t0, 1
    sw $t0, 240($sp)
    li $t0, 1
    sw $t0, 244($sp)
    li $t0, 1
    sw $t0, 248($sp)

    ;--- row 7
    li $t0, 2
    sw $t0, 252($sp)
    li $t0, 2
    sw $t0, 256($sp)
    li $t0, 2
    sw $t0, 260($sp)
    li $t0, 2
    sw $t0, 264($sp)
    li $t0, 2
    sw $t0, 268($sp)
    li $t0, 2
    sw $t0, 272($sp)
    li $t0, 1
    sw $t0, 276($sp)
    li $t0, 1
    sw $t0, 280($sp)
    li $t0, 1
    sw $t0, 284($sp)

    ;--- row 8
    li $t0, 1
    sw $t0, 288($sp)
    li $t0, 1
    sw $t0, 292($sp)
    li $t0, 1
    sw $t0, 296($sp)
    li $t0, 1
    sw $t0, 300($sp)
    li $t0, 1
    sw $t0, 304($sp)
    li $t0, 1
    sw $t0, 308($sp)
    li $t0, 1
    sw $t0, 312($sp)
    li $t0, 1
    sw $t0, 316($sp)
    li $t0, 1
    sw $t0, 320($sp)

    move $a0, $sp
    sw $a0, 340($sp)
    j end_levels

if_forth_level:
    li $t0, 4
    bne $s0, $t0, if_fifth_level
    ;--- row 0
    li $t0, 1
    sw $t0, 0($sp)
    li $t0, 2
    sw $t0, 4($sp)
    li $t0, 2
    sw $t0, 8($sp)
    li $t0, 2
    sw $t0, 12($sp)
    li $t0, 2
    sw $t0, 16($sp)
    li $t0, 1
    sw $t0, 20($sp)
    li $t0, 1
    sw $t0, 24($sp)
    li $t0, 1
    sw $t0, 28($sp)
    li $t0, 1
    sw $t0, 32($sp)

    ;--- row 1
    li $t0, 1
    sw $t0, 36($sp)
    li $t0, 2
    sw $t0, 40($sp)
    li $t0, 4
    sw $t0, 44($sp)
    li $t0, 0
    sw $t0, 48($sp)
    li $t0, 2
    sw $t0, 52($sp)
    li $t0, 2
    sw $t0, 56($sp)
    li $t0, 2
    sw $t0, 60($sp)
    li $t0, 1
    sw $t0, 64($sp)
    li $t0, 1
    sw $t0, 68($sp)

    ;--- row 2
    li $t0, 1
    sw $t0, 72($sp)
    li $t0, 2
    sw $t0, 76($sp)
    li $t0, 0
    sw $t0, 80($sp)
    li $t0, 3
    sw $t0, 84($sp)
    li $t0, 0
    sw $t0, 88($sp)
    li $t0, 0
    sw $t0, 92($sp)
    li $t0, 2
    sw $t0, 96($sp)
    li $t0, 1
    sw $t0, 100($sp)
    li $t0, 1
    sw $t0, 104($sp)

    ;--- row 3
    li $t0, 2
    sw $t0, 108($sp)
    li $t0, 2
    sw $t0, 112($sp)
    li $t0, 2
    sw $t0, 116($sp)
    li $t0, 0 ; --aqui
    sw $t0, 120($sp)
    li $t0, 2
    sw $t0, 124($sp)
    li $t0, 0 ; --aqui
    sw $t0, 128($sp)
    li $t0, 2
    sw $t0, 132($sp)
    li $t0, 2
    sw $t0, 136($sp)
    li $t0, 1
    sw $t0, 140($sp)

    ;---row 4
    li $t0, 2
    sw $t0, 144($sp)
    li $t0, 5
    sw $t0, 148($sp)
    li $t0, 2
    sw $t0, 152($sp)
    li $t0, 0 ;-- aqui
    sw $t0, 156($sp)
    li $t0, 2
    sw $t0, 160($sp)
    li $t0, 0
    sw $t0, 164($sp)
    li $t0, 0
    sw $t0, 168($sp)
    li $t0, 2
    sw $t0, 172($sp)
    li $t0, 1
    sw $t0, 176($sp)

    ;--- row 5
    li $t0, 2
    sw $t0, 180($sp)
    li $t0, 5
    sw $t0, 184($sp)
    li $t0, 3
    sw $t0, 188($sp)
    li $t0, 0
    sw $t0, 192($sp)
    li $t0, 0 ;-- aqui
    sw $t0, 196($sp)
    li $t0, 2
    sw $t0, 200($sp)
    li $t0, 0
    sw $t0, 204($sp)
    li $t0, 2
    sw $t0, 208($sp)
    li $t0, 1
    sw $t0, 212($sp)

    ;--- row 6
    li $t0, 2
    sw $t0, 216($sp)
    li $t0, 5
    sw $t0, 220($sp)
    li $t0, 0
    sw $t0, 224($sp)
    li $t0, 0
    sw $t0, 228($sp)
    li $t0, 0
    sw $t0, 232($sp)
    li $t0, 3
    sw $t0, 236($sp)
    li $t0, 0
    sw $t0, 240($sp)
    li $t0, 2
    sw $t0, 244($sp)
    li $t0, 1
    sw $t0, 248($sp)

    ;--- row 7
    li $t0, 2
    sw $t0, 252($sp)
    li $t0, 2
    sw $t0, 256($sp)
    li $t0, 2
    sw $t0, 260($sp)
    li $t0, 2
    sw $t0, 264($sp)
    li $t0, 2
    sw $t0, 268($sp)
    li $t0, 2
    sw $t0, 272($sp)
    li $t0, 2
    sw $t0, 276($sp)
    li $t0, 2
    sw $t0, 280($sp)
    li $t0, 1
    sw $t0, 284($sp)

    ;--- row 8
    li $t0, 1
    sw $t0, 288($sp)
    li $t0, 1
    sw $t0, 292($sp)
    li $t0, 1
    sw $t0, 296($sp)
    li $t0, 1
    sw $t0, 300($sp)
    li $t0, 1
    sw $t0, 304($sp)
    li $t0, 1
    sw $t0, 308($sp)
    li $t0, 1
    sw $t0, 312($sp)
    li $t0, 1
    sw $t0, 316($sp)
    li $t0, 1
    sw $t0, 320($sp)

    move $a0, $sp
    sw $a0, 340($sp)
    j end_levels
if_fifth_level:
    li $t0, 5
    bne $s0, $t0, if_sixth_level
    ;--- row 0
    li $t0, 1
    sw $t0, 0($sp)
    li $t0, 1
    sw $t0, 4($sp)
    li $t0, 2
    sw $t0, 8($sp)
    li $t0, 2
    sw $t0, 12($sp)
    li $t0, 2
    sw $t0, 16($sp)
    li $t0, 2
    sw $t0, 20($sp)
    li $t0, 2
    sw $t0, 24($sp)
    li $t0, 2
    sw $t0, 28($sp)
    li $t0, 1
    sw $t0, 32($sp)

    ;--- row 1
    li $t0, 1
    sw $t0, 36($sp)
    li $t0, 1
    sw $t0, 40($sp)
    li $t0, 2
    sw $t0, 44($sp)
    li $t0, 0
    sw $t0, 48($sp)
    li $t0, 0
    sw $t0, 52($sp)
    li $t0, 0
    sw $t0, 56($sp)
    li $t0, 0
    sw $t0, 60($sp)
    li $t0, 2
    sw $t0, 64($sp)
    li $t0, 1
    sw $t0, 68($sp)

    ;--- row 2
    li $t0, 2
    sw $t0, 72($sp)
    li $t0, 2
    sw $t0, 76($sp)
    li $t0, 2
    sw $t0, 80($sp)
    li $t0, 3
    sw $t0, 84($sp)
    li $t0, 3
    sw $t0, 88($sp)
    li $t0, 3
    sw $t0, 92($sp)
    li $t0, 0
    sw $t0, 96($sp)
    li $t0, 2
    sw $t0, 100($sp)
    li $t0, 1
    sw $t0, 104($sp)

    ;--- row 3
    li $t0, 2
    sw $t0, 108($sp)
    li $t0, 4
    sw $t0, 112($sp)
    li $t0, 0
    sw $t0, 116($sp)
    li $t0, 3 ; --aqui
    sw $t0, 120($sp)
    li $t0, 5
    sw $t0, 124($sp)
    li $t0, 5 ; --aqui
    sw $t0, 128($sp)
    li $t0, 0
    sw $t0, 132($sp)
    li $t0, 2
    sw $t0, 136($sp)
    li $t0, 1
    sw $t0, 140($sp)

    ;---row 4
    li $t0, 2
    sw $t0, 144($sp)
    li $t0, 0
    sw $t0, 148($sp)
    li $t0, 3
    sw $t0, 152($sp)
    li $t0, 5 ;-- aqui
    sw $t0, 156($sp)
    li $t0, 5
    sw $t0, 160($sp)
    li $t0, 5
    sw $t0, 164($sp)
    li $t0, 2
    sw $t0, 168($sp)
    li $t0, 2
    sw $t0, 172($sp)
    li $t0, 1
    sw $t0, 176($sp)

    ;--- row 5
    li $t0, 2
    sw $t0, 180($sp)
    li $t0, 2
    sw $t0, 184($sp)
    li $t0, 2
    sw $t0, 188($sp)
    li $t0, 2
    sw $t0, 192($sp)
    li $t0, 0 ;-- aqui
    sw $t0, 196($sp)
    li $t0, 0
    sw $t0, 200($sp)
    li $t0, 2
    sw $t0, 204($sp)
    li $t0, 1
    sw $t0, 208($sp)
    li $t0, 1
    sw $t0, 212($sp)

    ;--- row 6
    li $t0, 1
    sw $t0, 216($sp)
    li $t0, 1
    sw $t0, 220($sp)
    li $t0, 1
    sw $t0, 224($sp)
    li $t0, 2
    sw $t0, 228($sp)
    li $t0, 2
    sw $t0, 232($sp)
    li $t0, 2
    sw $t0, 236($sp)
    li $t0, 2
    sw $t0, 240($sp)
    li $t0, 1
    sw $t0, 244($sp)
    li $t0, 1
    sw $t0, 248($sp)

    ;--- row 7
    li $t0, 1
    sw $t0, 252($sp)
    li $t0, 1
    sw $t0, 256($sp)
    li $t0, 1
    sw $t0, 260($sp)
    li $t0, 1
    sw $t0, 264($sp)
    li $t0, 1
    sw $t0, 268($sp)
    li $t0, 1
    sw $t0, 272($sp)
    li $t0, 1
    sw $t0, 276($sp)
    li $t0, 1
    sw $t0, 280($sp)
    li $t0, 1
    sw $t0, 284($sp)

    ;--- row 8
    li $t0, 1
    sw $t0, 288($sp)
    li $t0, 1
    sw $t0, 292($sp)
    li $t0, 1
    sw $t0, 296($sp)
    li $t0, 1
    sw $t0, 300($sp)
    li $t0, 1
    sw $t0, 304($sp)
    li $t0, 1
    sw $t0, 308($sp)
    li $t0, 1
    sw $t0, 312($sp)
    li $t0, 1
    sw $t0, 316($sp)
    li $t0, 1
    sw $t0, 320($sp)

    move $a0, $sp
    sw $a0, 340($sp)
    j end_levels
if_sixth_level:
    li $t0, 6
    bne $s0, $t0, if_seventh_level
    ;--- row 0
    li $t0, 1
    sw $t0, 0($sp)
    li $t0, 1
    sw $t0, 4($sp)
    li $t0, 2
    sw $t0, 8($sp)
    li $t0, 2
    sw $t0, 12($sp)
    li $t0, 2
    sw $t0, 16($sp)
    li $t0, 2
    sw $t0, 20($sp)
    li $t0, 2
    sw $t0, 24($sp)
    li $t0, 1
    sw $t0, 28($sp)
    li $t0, 1
    sw $t0, 32($sp)

    ;--- row 1
    li $t0, 2
    sw $t0, 36($sp)
    li $t0, 2
    sw $t0, 40($sp)
    li $t0, 2
    sw $t0, 44($sp)
    li $t0, 0
    sw $t0, 48($sp)
    li $t0, 0
    sw $t0, 52($sp)
    li $t0, 4
    sw $t0, 56($sp)
    li $t0, 2
    sw $t0, 60($sp)
    li $t0, 1
    sw $t0, 64($sp)
    li $t0, 1
    sw $t0, 68($sp)

    ;--- row 2
    li $t0, 2
    sw $t0, 72($sp)
    li $t0, 0
    sw $t0, 76($sp)
    li $t0, 0
    sw $t0, 80($sp)
    li $t0, 3
    sw $t0, 84($sp)
    li $t0, 5
    sw $t0, 88($sp)
    li $t0, 0
    sw $t0, 92($sp)
    li $t0, 2
    sw $t0, 96($sp)
    li $t0, 2
    sw $t0, 100($sp)
    li $t0, 1
    sw $t0, 104($sp)

    ;--- row 3
    li $t0, 2
    sw $t0, 108($sp)
    li $t0, 0
    sw $t0, 112($sp)
    li $t0, 0
    sw $t0, 116($sp)
    li $t0, 5 ; --aqui
    sw $t0, 120($sp)
    li $t0, 3
    sw $t0, 124($sp)
    li $t0, 5 ; --aqui
    sw $t0, 128($sp)
    li $t0, 0
    sw $t0, 132($sp)
    li $t0, 2
    sw $t0, 136($sp)
    li $t0, 1
    sw $t0, 140($sp)

    ;---row 4
    li $t0, 2
    sw $t0, 144($sp)
    li $t0, 2
    sw $t0, 148($sp)
    li $t0, 2
    sw $t0, 152($sp)
    li $t0, 0 ;-- aqui
    sw $t0, 156($sp)
    li $t0, 3
    sw $t0, 160($sp)
    li $t0, 3
    sw $t0, 164($sp)
    li $t0, 0
    sw $t0, 168($sp)
    li $t0, 2
    sw $t0, 172($sp)
    li $t0, 1
    sw $t0, 176($sp)

    ;--- row 5
    li $t0, 1
    sw $t0, 180($sp)
    li $t0, 1
    sw $t0, 184($sp)
    li $t0, 2
    sw $t0, 188($sp)
    li $t0, 0
    sw $t0, 192($sp)
    li $t0, 0 ;-- aqui
    sw $t0, 196($sp)
    li $t0, 0
    sw $t0, 200($sp)
    li $t0, 2
    sw $t0, 204($sp)
    li $t0, 2
    sw $t0, 208($sp)
    li $t0, 1
    sw $t0, 212($sp)

    ;--- row 6
    li $t0, 1
    sw $t0, 216($sp)
    li $t0, 1
    sw $t0, 220($sp)
    li $t0, 2
    sw $t0, 224($sp)
    li $t0, 2
    sw $t0, 228($sp)
    li $t0, 2
    sw $t0, 232($sp)
    li $t0, 2
    sw $t0, 236($sp)
    li $t0, 2
    sw $t0, 240($sp)
    li $t0, 1
    sw $t0, 244($sp)
    li $t0, 1
    sw $t0, 248($sp)

    ;--- row 7
    li $t0, 1
    sw $t0, 252($sp)
    li $t0, 1
    sw $t0, 256($sp)
    li $t0, 1
    sw $t0, 260($sp)
    li $t0, 1
    sw $t0, 264($sp)
    li $t0, 1
    sw $t0, 268($sp)
    li $t0, 1
    sw $t0, 272($sp)
    li $t0, 1
    sw $t0, 276($sp)
    li $t0, 1
    sw $t0, 280($sp)
    li $t0, 1
    sw $t0, 284($sp)

    ;--- row 8
    li $t0, 1
    sw $t0, 288($sp)
    li $t0, 1
    sw $t0, 292($sp)
    li $t0, 1
    sw $t0, 296($sp)
    li $t0, 1
    sw $t0, 300($sp)
    li $t0, 1
    sw $t0, 304($sp)
    li $t0, 1
    sw $t0, 308($sp)
    li $t0, 1
    sw $t0, 312($sp)
    li $t0, 1
    sw $t0, 316($sp)
    li $t0, 1
    sw $t0, 320($sp)

    move $a0, $sp
    sw $a0, 340($sp)
    j end_levels
if_seventh_level:
    li $t0, 7
    bne $s0, $t0, if_eigth_level
    ;--- row 0
    li $t0, 1
    sw $t0, 0($sp)
    li $t0, 1
    sw $t0, 4($sp)
    li $t0, 2
    sw $t0, 8($sp)
    li $t0, 2
    sw $t0, 12($sp)
    li $t0, 2
    sw $t0, 16($sp)
    li $t0, 2
    sw $t0, 20($sp)
    li $t0, 1
    sw $t0, 24($sp)
    li $t0, 1
    sw $t0, 28($sp)
    li $t0, 1
    sw $t0, 32($sp)

    ;--- row 1
    li $t0, 1
    sw $t0, 36($sp)
    li $t0, 1
    sw $t0, 40($sp)
    li $t0, 2
    sw $t0, 44($sp)
    li $t0, 5
    sw $t0, 48($sp)
    li $t0, 5
    sw $t0, 52($sp)
    li $t0, 2
    sw $t0, 56($sp)
    li $t0, 1
    sw $t0, 60($sp)
    li $t0, 1
    sw $t0, 64($sp)
    li $t0, 1
    sw $t0, 68($sp)

    ;--- row 2
    li $t0, 1
    sw $t0, 72($sp)
    li $t0, 2
    sw $t0, 76($sp)
    li $t0, 2
    sw $t0, 80($sp)
    li $t0, 0
    sw $t0, 84($sp)
    li $t0, 5
    sw $t0, 88($sp)
    li $t0, 2
    sw $t0, 92($sp)
    li $t0, 2
    sw $t0, 96($sp)
    li $t0, 1
    sw $t0, 100($sp)
    li $t0, 1
    sw $t0, 104($sp)

    ;--- row 3
    li $t0, 1
    sw $t0, 108($sp)
    li $t0, 2
    sw $t0, 112($sp)
    li $t0, 0
    sw $t0, 116($sp)
    li $t0, 0 ; --aqui
    sw $t0, 120($sp)
    li $t0, 3
    sw $t0, 124($sp)
    li $t0, 5 ; --aqui
    sw $t0, 128($sp)
    li $t0, 2
    sw $t0, 132($sp)
    li $t0, 1
    sw $t0, 136($sp)
    li $t0, 1
    sw $t0, 140($sp)

    ;---row 4
    li $t0, 2
    sw $t0, 144($sp)
    li $t0, 2
    sw $t0, 148($sp)
    li $t0, 0
    sw $t0, 152($sp)
    li $t0, 3 ;-- aqui
    sw $t0, 156($sp)
    li $t0, 0
    sw $t0, 160($sp)
    li $t0, 0
    sw $t0, 164($sp)
    li $t0, 2
    sw $t0, 168($sp)
    li $t0, 2
    sw $t0, 172($sp)
    li $t0, 1
    sw $t0, 176($sp)

    ;--- row 5
    li $t0, 2
    sw $t0, 180($sp)
    li $t0, 0
    sw $t0, 184($sp)
    li $t0, 0
    sw $t0, 188($sp)
    li $t0, 2
    sw $t0, 192($sp)
    li $t0, 3 ;-- aqui
    sw $t0, 196($sp)
    li $t0, 3
    sw $t0, 200($sp)
    li $t0, 0
    sw $t0, 204($sp)
    li $t0, 2
    sw $t0, 208($sp)
    li $t0, 1
    sw $t0, 212($sp)

    ;--- row 6
    li $t0, 2
    sw $t0, 216($sp)
    li $t0, 0
    sw $t0, 220($sp)
    li $t0, 0
    sw $t0, 224($sp)
    li $t0, 4
    sw $t0, 228($sp)
    li $t0, 0
    sw $t0, 232($sp)
    li $t0, 0
    sw $t0, 236($sp)
    li $t0, 0
    sw $t0, 240($sp)
    li $t0, 2
    sw $t0, 244($sp)
    li $t0, 1
    sw $t0, 248($sp)

    ;--- row 7
    li $t0, 2
    sw $t0, 252($sp)
    li $t0, 2
    sw $t0, 256($sp)
    li $t0, 2
    sw $t0, 260($sp)
    li $t0, 2
    sw $t0, 264($sp)
    li $t0, 2
    sw $t0, 268($sp)
    li $t0, 2
    sw $t0, 272($sp)
    li $t0, 2
    sw $t0, 276($sp)
    li $t0, 2
    sw $t0, 280($sp)
    li $t0, 1
    sw $t0, 284($sp)

    ;--- row 8
    li $t0, 1
    sw $t0, 288($sp)
    li $t0, 1
    sw $t0, 292($sp)
    li $t0, 1
    sw $t0, 296($sp)
    li $t0, 1
    sw $t0, 300($sp)
    li $t0, 1
    sw $t0, 304($sp)
    li $t0, 1
    sw $t0, 308($sp)
    li $t0, 1
    sw $t0, 312($sp)
    li $t0, 1
    sw $t0, 316($sp)
    li $t0, 1
    sw $t0, 320($sp)

    move $a0, $sp
    sw $a0, 340($sp)
    j end_levels
if_eigth_level:
    li $t0, 8
    bne $s0, $t0, if_ninth_level
    ;--- row 0
    li $t0, 1
    sw $t0, 0($sp)
    li $t0, 2
    sw $t0, 4($sp)
    li $t0, 2
    sw $t0, 8($sp)
    li $t0, 2
    sw $t0, 12($sp)
    li $t0, 2
    sw $t0, 16($sp)
    li $t0, 2
    sw $t0, 20($sp)
    li $t0, 1
    sw $t0, 24($sp)
    li $t0, 1
    sw $t0, 28($sp)
    li $t0, 1
    sw $t0, 32($sp)

    ;--- row 1
    li $t0, 1
    sw $t0, 36($sp)
    li $t0, 2
    sw $t0, 40($sp)
    li $t0, 0
    sw $t0, 44($sp)
    li $t0, 4
    sw $t0, 48($sp)
    li $t0, 0
    sw $t0, 52($sp)
    li $t0, 2
    sw $t0, 56($sp)
    li $t0, 2
    sw $t0, 60($sp)
    li $t0, 2
    sw $t0, 64($sp)
    li $t0, 1
    sw $t0, 68($sp)

    ;--- row 2
    li $t0, 2
    sw $t0, 72($sp)
    li $t0, 2
    sw $t0, 76($sp)
    li $t0, 0
    sw $t0, 80($sp)
    li $t0, 2
    sw $t0, 84($sp)
    li $t0, 3
    sw $t0, 88($sp)
    li $t0, 0
    sw $t0, 92($sp)
    li $t0, 0
    sw $t0, 96($sp)
    li $t0, 2
    sw $t0, 100($sp)
    li $t0, 1
    sw $t0, 104($sp)

    ;--- row 3
    li $t0, 2
    sw $t0, 108($sp)
    li $t0, 0
    sw $t0, 112($sp)
    li $t0, 3
    sw $t0, 116($sp)
    li $t0, 5 ; --aqui
    sw $t0, 120($sp)
    li $t0, 0
    sw $t0, 124($sp)
    li $t0, 5 ; --aqui
    sw $t0, 128($sp)
    li $t0, 0
    sw $t0, 132($sp)
    li $t0, 2
    sw $t0, 136($sp)
    li $t0, 1
    sw $t0, 140($sp)

    ;---row 4
    li $t0, 2
    sw $t0, 144($sp)
    li $t0, 0
    sw $t0, 148($sp)
    li $t0, 0
    sw $t0, 152($sp)
    li $t0, 3 ;-- aqui
    sw $t0, 156($sp)
    li $t0, 3
    sw $t0, 160($sp)
    li $t0, 0
    sw $t0, 164($sp)
    li $t0, 2
    sw $t0, 168($sp)
    li $t0, 2
    sw $t0, 172($sp)
    li $t0, 1
    sw $t0, 176($sp)

    ;--- row 5
    li $t0, 2
    sw $t0, 180($sp)
    li $t0, 2
    sw $t0, 184($sp)
    li $t0, 2
    sw $t0, 188($sp)
    li $t0, 0
    sw $t0, 192($sp)
    li $t0, 2 ;-- aqui
    sw $t0, 196($sp)
    li $t0, 5
    sw $t0, 200($sp)
    li $t0, 2
    sw $t0, 204($sp)
    li $t0, 1
    sw $t0, 208($sp)
    li $t0, 1
    sw $t0, 212($sp)

    ;--- row 6
    li $t0, 1
    sw $t0, 216($sp)
    li $t0, 1
    sw $t0, 220($sp)
    li $t0, 2
    sw $t0, 224($sp)
    li $t0, 0
    sw $t0, 228($sp)
    li $t0, 0
    sw $t0, 232($sp)
    li $t0, 0
    sw $t0, 236($sp)
    li $t0, 2
    sw $t0, 240($sp)
    li $t0, 1
    sw $t0, 244($sp)
    li $t0, 1
    sw $t0, 248($sp)

    ;--- row 7
    li $t0, 1
    sw $t0, 252($sp)
    li $t0, 1
    sw $t0, 256($sp)
    li $t0, 2
    sw $t0, 260($sp)
    li $t0, 2
    sw $t0, 264($sp)
    li $t0, 2
    sw $t0, 268($sp)
    li $t0, 2
    sw $t0, 272($sp)
    li $t0, 2
    sw $t0, 276($sp)
    li $t0, 1
    sw $t0, 280($sp)
    li $t0, 1
    sw $t0, 284($sp)

    ;--- row 8
    li $t0, 1
    sw $t0, 288($sp)
    li $t0, 1
    sw $t0, 292($sp)
    li $t0, 1
    sw $t0, 296($sp)
    li $t0, 1
    sw $t0, 300($sp)
    li $t0, 1
    sw $t0, 304($sp)
    li $t0, 1
    sw $t0, 308($sp)
    li $t0, 1
    sw $t0, 312($sp)
    li $t0, 1
    sw $t0, 316($sp)
    li $t0, 1
    sw $t0, 320($sp)

    move $a0, $sp
    sw $a0, 340($sp)
    j end_levels
if_ninth_level:
    li $t0, 9
    bne $s0, $t0, if_tenth_level
    ;--- row 0
    li $t0, 2
    sw $t0, 0($sp)
    li $t0, 2
    sw $t0, 4($sp)
    li $t0, 2
    sw $t0, 8($sp)
    li $t0, 2
    sw $t0, 12($sp)
    li $t0, 2
    sw $t0, 16($sp)
    li $t0, 2
    sw $t0, 20($sp)
    li $t0, 1
    sw $t0, 24($sp)
    li $t0, 1
    sw $t0, 28($sp)
    li $t0, 1
    sw $t0, 32($sp)

    ;--- row 1
    li $t0, 2
    sw $t0, 36($sp)
    li $t0, 0
    sw $t0, 40($sp)
    li $t0, 0
    sw $t0, 44($sp)
    li $t0, 0
    sw $t0, 48($sp)
    li $t0, 0
    sw $t0, 52($sp)
    li $t0, 2
    sw $t0, 56($sp)
    li $t0, 1
    sw $t0, 60($sp)
    li $t0, 1
    sw $t0, 64($sp)
    li $t0, 1
    sw $t0, 68($sp)

    ;--- row 2
    li $t0, 2
    sw $t0, 72($sp)
    li $t0, 0
    sw $t0, 76($sp)
    li $t0, 3
    sw $t0, 80($sp)
    li $t0, 3
    sw $t0, 84($sp)
    li $t0, 3
    sw $t0, 88($sp)
    li $t0, 2
    sw $t0, 92($sp)
    li $t0, 2
    sw $t0, 96($sp)
    li $t0, 1
    sw $t0, 100($sp)
    li $t0, 1
    sw $t0, 104($sp)

    ;--- row 3
    li $t0, 2
    sw $t0, 108($sp)
    li $t0, 0
    sw $t0, 112($sp)
    li $t0, 0
    sw $t0, 116($sp)
    li $t0, 2 ; --aqui
    sw $t0, 120($sp)
    li $t0, 5
    sw $t0, 124($sp)
    li $t0, 5 ; --aqui
    sw $t0, 128($sp)
    li $t0, 2
    sw $t0, 132($sp)
    li $t0, 2
    sw $t0, 136($sp)
    li $t0, 2
    sw $t0, 140($sp)

    ;---row 4
    li $t0, 2
    sw $t0, 144($sp)
    li $t0, 2
    sw $t0, 148($sp)
    li $t0, 0
    sw $t0, 152($sp)
    li $t0, 0 ;-- aqui
    sw $t0, 156($sp)
    li $t0, 5
    sw $t0, 160($sp)
    li $t0, 5
    sw $t0, 164($sp)
    li $t0, 3
    sw $t0, 168($sp)
    li $t0, 0
    sw $t0, 172($sp)
    li $t0, 2
    sw $t0, 176($sp)

    ;--- row 5
    li $t0, 1
    sw $t0, 180($sp)
    li $t0, 2
    sw $t0, 184($sp)
    li $t0, 0
    sw $t0, 188($sp)
    li $t0, 4
    sw $t0, 192($sp)
    li $t0, 0 ;-- aqui
    sw $t0, 196($sp)
    li $t0, 0
    sw $t0, 200($sp)
    li $t0, 0
    sw $t0, 204($sp)
    li $t0, 0
    sw $t0, 208($sp)
    li $t0, 2
    sw $t0, 212($sp)

    ;--- row 6
    li $t0, 1
    sw $t0, 216($sp)
    li $t0, 2
    sw $t0, 220($sp)
    li $t0, 2
    sw $t0, 224($sp)
    li $t0, 2
    sw $t0, 228($sp)
    li $t0, 2
    sw $t0, 232($sp)
    li $t0, 2
    sw $t0, 236($sp)
    li $t0, 2
    sw $t0, 240($sp)
    li $t0, 2
    sw $t0, 244($sp)
    li $t0, 2
    sw $t0, 248($sp)

    ;--- row 7
    li $t0, 1
    sw $t0, 252($sp)
    li $t0, 1
    sw $t0, 256($sp)
    li $t0, 1
    sw $t0, 260($sp)
    li $t0, 1
    sw $t0, 264($sp)
    li $t0, 1
    sw $t0, 268($sp)
    li $t0, 1
    sw $t0, 272($sp)
    li $t0, 1
    sw $t0, 276($sp)
    li $t0, 1
    sw $t0, 280($sp)
    li $t0, 1
    sw $t0, 284($sp)

    ;--- row 8
    li $t0, 1
    sw $t0, 288($sp)
    li $t0, 1
    sw $t0, 292($sp)
    li $t0, 1
    sw $t0, 296($sp)
    li $t0, 1
    sw $t0, 300($sp)
    li $t0, 1
    sw $t0, 304($sp)
    li $t0, 1
    sw $t0, 308($sp)
    li $t0, 1
    sw $t0, 312($sp)
    li $t0, 1
    sw $t0, 316($sp)
    li $t0, 1
    sw $t0, 320($sp)

    move $a0, $sp
    sw $a0, 340($sp)
    j end_levels

if_tenth_level:
    li $t0, 10
    bne $s0, $t0, end_levels
    ;--- row 0
    li $t0, 1
    sw $t0, 0($sp)
    li $t0, 2
    sw $t0, 4($sp)
    li $t0, 2
    sw $t0, 8($sp)
    li $t0, 2
    sw $t0, 12($sp)
    li $t0, 2
    sw $t0, 16($sp)
    li $t0, 2
    sw $t0, 20($sp)
    li $t0, 2
    sw $t0, 24($sp)
    li $t0, 1
    sw $t0, 28($sp)
    li $t0, 1
    sw $t0, 32($sp)

    ;--- row 1
    li $t0, 1
    sw $t0, 36($sp)
    li $t0, 2
    sw $t0, 40($sp)
    li $t0, 0
    sw $t0, 44($sp)
    li $t0, 0
    sw $t0, 48($sp)
    li $t0, 0
    sw $t0, 52($sp)
    li $t0, 0
    sw $t0, 56($sp)
    li $t0, 2
    sw $t0, 60($sp)
    li $t0, 2
    sw $t0, 64($sp)
    li $t0, 1
    sw $t0, 68($sp)

    ;--- row 2
    li $t0, 2
    sw $t0, 72($sp)
    li $t0, 2
    sw $t0, 76($sp)
    li $t0, 5
    sw $t0, 80($sp)
    li $t0, 2
    sw $t0, 84($sp)
    li $t0, 2
    sw $t0, 88($sp)
    li $t0, 3
    sw $t0, 92($sp)
    li $t0, 0
    sw $t0, 96($sp)
    li $t0, 2
    sw $t0, 100($sp)
    li $t0, 1
    sw $t0, 104($sp)

    ;--- row 3
    li $t0, 2
    sw $t0, 108($sp)
    li $t0, 0
    sw $t0, 112($sp)
    li $t0, 5
    sw $t0, 116($sp)
    li $t0, 5 ; --aqui
    sw $t0, 120($sp)
    li $t0, 3
    sw $t0, 124($sp)
    li $t0, 0 ; --aqui
    sw $t0, 128($sp)
    li $t0, 0
    sw $t0, 132($sp)
    li $t0, 2
    sw $t0, 136($sp)
    li $t0, 1
    sw $t0, 140($sp)

    ;---row 4
    li $t0, 2
    sw $t0, 144($sp)
    li $t0, 0
    sw $t0, 148($sp)
    li $t0, 0
    sw $t0, 152($sp)
    li $t0, 2 ;-- aqui
    sw $t0, 156($sp)
    li $t0, 3
    sw $t0, 160($sp)
    li $t0, 0
    sw $t0, 164($sp)
    li $t0, 0
    sw $t0, 168($sp)
    li $t0, 2
    sw $t0, 172($sp)
    li $t0, 1
    sw $t0, 176($sp)

    ;--- row 5
    li $t0, 2
    sw $t0, 180($sp)
    li $t0, 0
    sw $t0, 184($sp)
    li $t0, 0
    sw $t0, 188($sp)
    li $t0, 4
    sw $t0, 192($sp)
    li $t0, 0 ;-- aqui
    sw $t0, 196($sp)
    li $t0, 2
    sw $t0, 200($sp)
    li $t0, 2
    sw $t0, 204($sp)
    li $t0, 2
    sw $t0, 208($sp)
    li $t0, 1
    sw $t0, 212($sp)

    ;--- row 6
    li $t0, 2
    sw $t0, 216($sp)
    li $t0, 2
    sw $t0, 220($sp)
    li $t0, 2
    sw $t0, 224($sp)
    li $t0, 2
    sw $t0, 228($sp)
    li $t0, 2
    sw $t0, 232($sp)
    li $t0, 2
    sw $t0, 236($sp)
    li $t0, 1
    sw $t0, 240($sp)
    li $t0, 1
    sw $t0, 244($sp)
    li $t0, 1
    sw $t0, 248($sp)

    ;--- row 7
    li $t0, 1
    sw $t0, 252($sp)
    li $t0, 1
    sw $t0, 256($sp)
    li $t0, 1
    sw $t0, 260($sp)
    li $t0, 1
    sw $t0, 264($sp)
    li $t0, 1
    sw $t0, 268($sp)
    li $t0, 1
    sw $t0, 272($sp)
    li $t0, 1
    sw $t0, 276($sp)
    li $t0, 1
    sw $t0, 280($sp)
    li $t0, 1
    sw $t0, 284($sp)

    ;--- row 8
    li $t0, 1
    sw $t0, 288($sp)
    li $t0, 1
    sw $t0, 292($sp)
    li $t0, 1
    sw $t0, 296($sp)
    li $t0, 1
    sw $t0, 300($sp)
    li $t0, 1
    sw $t0, 304($sp)
    li $t0, 1
    sw $t0, 308($sp)
    li $t0, 1
    sw $t0, 312($sp)
    li $t0, 1
    sw $t0, 316($sp)
    li $t0, 1
    sw $t0, 320($sp)

    move $a0, $sp
    sw $a0, 340($sp)
    j end_levels
end_levels:
    jr $ra