.data

    str1: .byte "Welcome to Sokoban!", 0
    str2: .byte "Play Game", 0
    str3: .byte "Quit Game", 0
    str4: .byte "Selection Option: ", 0
    str5: .byte "Exiting Game... Thank you for Playing!", 0
    kb_count_str: .byte "Move Counter: ", 0
    lvl_str: .byte "Level: ", 0
    instruc: .byte "Instructions", 0
    accept_msg: .byte "Press Space to Return to Main Menu", 0

.text

start:
    addi $sp, $sp, -372
    sw $ra, 324($sp)

while_start: ; --> Menu while loop
    li $v0, 53
    syscall
    li $v0, 52
    syscall
    li $v0, 28
    li $a0, 6
    syscall
    li $v0, 29
    li $a0, 0
    syscall
    li $v0, 39
    syscall
    li $v0, 28
    li $a0, 6
    syscall

    li $v0, 51
    li $a1, 35
    li $a2, 15
    syscall
    li $v0, 4
    li $a0, str2
    syscall

    li $v0, 51
    li $a1, 35
    li $a2, 16
    syscall
    li $v0, 4
    li $a0, instruc
    syscall

    li $v0, 51
    li $a1, 35
    li $a2, 17
    syscall
    li $v0, 4
    li $a0, str3
    syscall

    li $v0, 51
    li $a1, 33 
    li $a2, 15
    syscall

    li $v0, 11
    li $a0, 62
    syscall

if_kb_menu: ; --> Logic for menu selection
    li $v0, 31
    syscall
    ;#show $v0
    sw $v0, 360($sp)
    li $v0, 51
    syscall
    li $v0, 11
    li $a0, 32
    syscall
    lw $v0, 360($sp)
if_kb_enter:
    li $t0, 10
    bne $t0, $v0, if_kb_menu_1
    li $t0, 15
    ;#show $a2
    bne $a2, $t0, if_kb_instruct
    j if_play
if_kb_instruct:
    li $t0, 16
    bne $a2, $t0, if_kb_exit
    jal printInstruc
    j while_start
if_kb_exit:
    li $t0, 17
    ;#show $a2
    bne $a2, $t0, if_kb_menu_1
    j if_exit
if_kb_menu_1:
    li $t0, 119
    bne $t0, $v0, if_kb_menu_2
    li $t0, 15
    beq $a2, $t0, end_kb_menu
    addi $a2, $a2, -1
    li $v0, 51
    syscall
    li $v0, 11
    li $a0, 62
    syscall
    j if_kb_menu
if_kb_menu_2:
    li $t0, 115
    bne $t0, $v0, end_kb_menu
    li $t0, 17
    beq $a2, $t0, end_kb_menu
    addi $a2, $a2, 1
    li $v0, 51
    syscall
    li $v0, 11
    li $a0, 62
    syscall
    j if_kb_menu
end_kb_menu:
    li $v0, 11
    li $a0, 62
    syscall
    j while_start
end_while_start:

    move $t1, $v0
    li $t0, 2

if_exit: ; --> If quit game option is choosen
    li $v0, 30
    syscall
    li $v0, 53
    syscall
    li $v0, 4
    li $a0, str5
    syscall
    li $v0, 11
    li $a0, 10
    syscall
    li $v0, 10
    syscall 

if_play: ; --> If play game option is choosen
    li $s1, 0
    li $t1, 29 ; --> x
    li $t2, 13 ; --> y
    li $s0, 1 ; --> currentLevel

    li $v0, 52 ; --> call rlutil::hidecursor()
    syscall
    li $v0, 30
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall

    li $v0, 51 ; --> call rlutil::locate(x,y)
    move $a1, $t1
    move $a2, $t2
    syscall

    jal generateMap ; --> Pass map to be played onto stack
    jal printMap ; --> Print map from values stored in stack
    jal printLvlCounter ; --> Print current level to screen
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 29
    li $a2, 13
    syscall
while_play: ; --> Play while loop
if_lvl_passed: ; --> Check if level has been passed
    jal checkLevelPassed
    li $t0, 10 ; --> Winning condition variable
    ;#show $v0
    beq $v0, $zero, end_if_lvl_passed
    beq $s0, $t0, game_finished ; --> winning condition
    addi $s0, $s0, 1
    
if_lvl_1:
    li $s1, 0
    li $t0, 1
    bne $s0, $t0, end_if_lvl_1
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    jal printLvlCounter
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 29
    li $a2, 13
    syscall
    j end_if_lvl_passed
end_if_lvl_1:
if_lvl_2:
    li $s1, 0
    li $t0, 2
    bne $s0, $t0, end_if_lvl_2
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    jal printLvlCounter
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 22
    li $a2, 7
    syscall
    j end_if_lvl_passed
end_if_lvl_2:
if_lvl_3:
    li $s1, 0
    li $t0, 3
    bne $s0, $t0, end_if_lvl_3
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    jal printLvlCounter
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 15
    li $a2, 7
    syscall
    j end_if_lvl_passed
end_if_lvl_3:
if_lvl_4:
    li $s1, 0
    li $t0, 4
    bne $s0, $t0, end_if_lvl_4
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    jal printLvlCounter
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 15
    li $a2, 4
    syscall
    j end_if_lvl_passed
end_if_lvl_4:
if_lvl_5:
    li $s1, 0
    li $t0, 5
    bne $s0, $t0, end_if_lvl_5
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    jal printLvlCounter
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 8
    li $a2, 10
    syscall
    j end_if_lvl_passed
end_if_lvl_5:
if_lvl_6:
    li $s1, 0
    li $t0, 6
    bne $s0, $t0, end_if_lvl_6
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    jal printLvlCounter
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 36
    li $a2, 4
    syscall
    j end_if_lvl_passed
end_if_lvl_6:
if_lvl_7:
    li $s1, 0
    li $t0, 7
    bne $s0, $t0, end_if_lvl_7
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    jal printLvlCounter
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 22
    li $a2, 19
    syscall
    j end_if_lvl_passed
end_if_lvl_7:
if_lvl_8:
    li $s1, 0
    li $t0, 8
    bne $s0, $t0, end_if_lvl_8
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    jal printLvlCounter
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 22
    li $a2, 4
    syscall
    j end_if_lvl_passed
end_if_lvl_8:
if_lvl_9:
    li $s1, 0
    li $t0, 9
    bne $s0, $t0, end_if_lvl_9
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    jal printLvlCounter
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 22
    li $a2, 16
    syscall
    j end_if_lvl_passed
end_if_lvl_9:
if_lvl_10:
    li $s1, 0
    li $t0, 10
    bne $s0, $t0, end_if_lvl_10
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    jal generateMap
    jal printMap
    jal printLvlCounter
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 22
    li $a2, 16
    syscall
end_if_lvl_10:
end_if_lvl_passed:
    li $v0, 31 ;--> call kbhit()
    syscall
    li $t0, 31
    ;#show $v0

if_kbhit: ; --> Check if any key has been hit
    beq $v0, $t0, end_if_kbhit
    sw $v0, 360($sp)
    li $v0, 51 ;--> call rlutil::locate
    syscall
    jal ErasePlayer ; --> Erase player from board
    lw $v0, 360($sp)
if_kb_a: ; --> Move Left
    li $t3, 97
    bne $v0, $t3, if_kb_d
    li $a3, -7
    jal checkPosX ; --> check if x has valid movement
    beq $v0, $zero, if_kb_end
    jal checkBoxSpot ; --> check if boxspot available & repaints it
    addi $a1, $a1, -7 ; decrement on x movement
    addi $s1, $s1, 1
    j if_kb_end
if_kb_d: ; --> Move Right
    li $t3, 100
    bne $v0, $t3, if_kb_w
    li $a3, 7
    jal checkPosX ; --> check if x has valid movement
    beq $v0, $zero, if_kb_end
    jal checkBoxSpot ; --> check if boxspot available & repaints it
    addi $a1, $a1, 7 ; increment on x movement
    addi $s1, $s1, 1
    j if_kb_end 
if_kb_w: ; --> Move Up
    li $t3, 119
    bne $v0, $t3, if_kb_s
    li $a3, -3
    jal checkPosY ; --> check if y has valid movement
    beq $v0, $zero, if_kb_end
    jal checkBoxSpot ; --> check if boxspot available & repaints it
    addi $a2, $a2, -3 ; decrement on y movement
    addi $s1, $s1, 1
    j if_kb_end
if_kb_s: ; --> Move Down
    li $t3, 115
    bne $v0, $t3, if_kb_space
    li $a3, 3
    jal checkPosY ; --> check if y has valid movement
    beq $v0, $zero, if_kb_end
    jal checkBoxSpot ; --> check if boxspot available & repaints it
    addi $a2, $a2, 3 ; increment on y movement
    addi $s1, $s1, 1
if_kb_space: ; --> Restart level
    li $t3, 32
    bne $v0, $t3, if_kb_esc
    j if_lvl_1
if_kb_esc: ; --> End game, jump back to main menu
    li $t3, 27
    bne $v0, $t3, if_kb_end
    j while_start
if_kb_end:
    li $v0, 51 ; --> rlutil::locate(x,y)
    syscall
    jal Player ; Print player on board
    sw $a1, 364($sp)
    sw $a2, 368($sp)
    jal RepaintBoxes ; Repaint boxes if any have been moved
    li $v0, 30 ; --> Reset colors
    syscall
    li $v0, 51 ; --> Call rlutil::locate(x, y) for move counter
    li $a1, 35
    li $a2, 29
    syscall
    li $v0, 4
    li $a0, kb_count_str ; --> Print move counter
    syscall
    li $v0, 1
    move $a0, $s1
    syscall
    lw $a1, 364($sp) ; --> Load x value from stack
    lw $a2, 368($sp) ; --> Load y value from stack
end_if_kbhit:
    j while_play
end_while_play:

game_finished: ; --> Winning Condition Satisfied
    li $v0, 30 ; --> call rlutil::resetColor()
    syscall
    li $v0, 53 ; --> call rlutil::cls()
    syscall
    li $v0, 28 ; --> call rlutil::setColor()
    li $a0, 6
    syscall
    li $v0, 29 ; --> call rlutil::setBackgroundColor()
    li $a0, 0
    syscall
    li $v0, 40 ; --> Call winner screen
    syscall
    li $v0, 51
    li $a1, 10
    li $a2, 10
    syscall
    li $v0, 4
    li $a0, accept_msg
    syscall
while_win_screen: ; --> Display of Winner Screen
    li $v0, 31
    syscall
    li $t0, 32
    beq $v0, $t0, end_while_win_screen
    j while_win_screen
end_while_win_screen:
    j start
exit_true:
    lw $ra, 324($sp)
    addi $sp, $sp, 372
    jr $ra