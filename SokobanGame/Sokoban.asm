.data

    str1: .byte "Welcome to Sokoban!", 0
    str2: .byte "1. Play Game", 0
    str3: .byte "2. Quit Game", 0
    str4: .byte "Selection Option: ", 0
    str5: .byte "Exiting Game... Thank you for Playing!", 0
    arcade_str: .byte "1. Arcade Mode", 0
    lvl_select_str: .byte "2. Level Selection", 0

.text

start:
    addi $sp, $sp, -372
    sw $ra, 324($sp)

    li $v0, 4
    li $a0, str1
    syscall

    li $v0, 11
    li $a0, 10
    syscall

    li $v0, 4
    li $a0, str2
    syscall
    li $v0, 11
    li $a0, 10
    syscall

    li $v0, 4
    li $a0, str3
    syscall
    li $v0, 11
    li $a0, 10
    syscall

    li $v0, 4
    li $a0, str4
    syscall

    li $v0, 5
    syscall

    move $t1, $v0

    li $v0, 11
    li $a0, 10
    syscall
    
    li $t0, 2

if_exit:
    bne $t1, $t0, if_play
    li $v0, 4
    li $a0, str5
    syscall
    li $v0, 10
    syscall 

if_play:
    li $t1, 29 ; --> x
    li $t2, 13 ; --> y
    li $s0, 1 ; --> currentLevel

    li $v0, 52 ; --> call rlutil::hidecursor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall

    li $v0, 51 ; --> call rlutil::locate(x,y)
    move $a1, $t1
    move $a2, $t2
    syscall

    jal generateMap
    jal printMap
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 29
    li $a2, 13
    syscall
while_play:
if_lvl_passed:
    jal checkLevelPassed
    li $t0, 1
    ;#show $v0
    beq $v0, $zero, end_if_lvl_passed
    addi $s0, $s0, 1
    
if_lvl_1:
    li $t0, 1
    bne $s0, $t0, end_if_lvl_1
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 29
    li $a2, 13
    syscall
    j end_if_lvl_passed
end_if_lvl_1:
if_lvl_2:
    li $t0, 2
    bne $s0, $t0, end_if_lvl_2
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 22
    li $a2, 7
    syscall
    j end_if_lvl_passed
end_if_lvl_2:
if_lvl_3:
    li $t0, 3
    bne $s0, $t0, end_if_lvl_3
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 15
    li $a2, 7
    syscall
    j end_if_lvl_passed
end_if_lvl_3:
if_lvl_4:
    li $t0, 4
    bne $s0, $t0, end_if_lvl_4
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 15
    li $a2, 4
    syscall
    j end_if_lvl_passed
end_if_lvl_4:
if_lvl_5:
    li $t0, 5
    bne $s0, $t0, end_if_lvl_5
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 8
    li $a2, 10
    syscall
    j end_if_lvl_passed
end_if_lvl_5:
if_lvl_6:
    li $t0, 6
    bne $s0, $t0, end_if_lvl_6
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 36
    li $a2, 4
    syscall
    j end_if_lvl_passed
end_if_lvl_6:
if_lvl_7:
    li $t0, 7
    bne $s0, $t0, end_if_lvl_7
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 22
    li $a2, 19
    syscall
    j end_if_lvl_passed
end_if_lvl_7:
if_lvl_8:
    li $t0, 8
    bne $s0, $t0, end_if_lvl_8
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 8
    li $a2, 7
    syscall
    j end_if_lvl_passed
end_if_lvl_8:
if_lvl_9:
    li $t0, 9
    bne $s0, $t0, end_if_lvl_9
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 22
    li $a2, 16
    syscall
    j end_if_lvl_passed
end_if_lvl_9:
if_lvl_10:
    li $t0, 10
    bne $s0, $t0, end_if_lvl_10
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 29
    li $a2, 19
    syscall
end_if_lvl_10:
end_if_lvl_passed:
    li $v0, 31 ;--> call kbhit()
    syscall
    li $t0, 31
    ;#show $v0

if_kbhit:
    beq $v0, $t0, end_if_kbhit
    sw $v0, 360($sp)
    li $v0, 51 ;--> call rlutil::locate
    syscall
    jal ErasePlayer
    lw $v0, 360($sp)
if_kb_a:
    li $t3, 97
    bne $v0, $t3, if_kb_d
    li $a3, -7
    jal checkPosX
    beq $v0, $zero, if_kb_end
    jal checkBoxSpot
    addi $a1, $a1, -7
    j if_kb_end
if_kb_d:
    li $t3, 100
    bne $v0, $t3, if_kb_w
    li $a3, 7
    jal checkPosX
    beq $v0, $zero, if_kb_end
    ; --> repaint boxspot function
    jal checkBoxSpot
    addi $a1, $a1, 7
    j if_kb_end
if_kb_w:
    li $t3, 119
    bne $v0, $t3, if_kb_s
    li $a3, -3
    jal checkPosY
    beq $v0, $zero, if_kb_end
    jal checkBoxSpot
    addi $a2, $a2, -3
    j if_kb_end
if_kb_s:
    li $t3, 115
    bne $v0, $t3, if_kb_space
    li $a3, 3
    jal checkPosY
    beq $v0, $zero, if_kb_end
    jal checkBoxSpot
    addi $a2, $a2, 3
if_kb_space:
    li $t3, 32
    bne $v0, $t3, if_kb_end
    j if_lvl_1
if_kb_end:
    li $v0, 51
    syscall
    jal Player
    sw $a1, 364($sp)
    sw $a2, 368($sp)
    jal RepaintBoxes
    lw $a1, 364($sp)
    lw $a2, 368($sp)
end_if_kbhit:
    j while_play
end_while_play:
    lw $ra, 324($sp)
    addi $sp, $sp, 372
    ;li $v0, 10
    ;syscall
    ;li $v0, 30
    ;syscall
    ;li $v0, 53 ; --> call rlutil::cls()
    ;syscall
    ;j start
    jr $ra