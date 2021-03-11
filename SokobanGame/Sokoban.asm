.data

    str1: .byte "Welcome to Sokoban!", 0
    str2: .byte "1. Play Game", 0
    str3: .byte "2. Quit Game", 0
    str4: .byte "Selection Option: ", 0
    str5: .byte "Exiting Game... Thankxd you for Playing!", 0
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
    ;jal Block

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
    move $a3, $s0 ; --> current level(will break program eventually)

    ;#show $t1
    ;jal Player
    ;li $v0, 51
    ;syscall
    ;jal ErasePlayer
    jal generateMap
    jal printMap
    li $v0, 51 ; --> call rlutil::locate(x,y)
    li $a1, 29
    li $a2, 13
    syscall
while_play:
    ;#show $t0
    li $v0, 31 ;--> call kbhit()
    syscall
    ;#show $a0
    ;lw $a0, 340($sp)
    ;#show $a0
    ;#show $a0
    ;lw $t0, 340($sp)
    ;#show $t0
if_kbhit:
    beq $v0, $zero, end_if_kbhit
    ;#show $v0
    sw $v0, 360($sp)
    ;#show $v0
    li $v0, 51 ;--> call rlutil::locate
    ;#show $a1
    ;#show $a2
    syscall
    jal ErasePlayer
    lw $v0, 360($sp)
if_kb_a:
    li $t3, 97
    bne $v0, $t3, if_kb_d
    li $a3, -7
    jal checkPosX
    beq $v0, $zero, if_kb_end
    addi $a1, $a1, -7
    j if_kb_end
if_kb_d:
    li $t3, 100
    bne $v0, $t3, if_kb_w
    li $a3, 7
    jal checkPosX
    beq $v0, $zero, if_kb_end
    addi $a1, $a1, 7
    j if_kb_end
if_kb_w:
    li $t3, 119
    bne $v0, $t3, if_kb_s
    li $a3, -3
    jal checkPosY
    beq $v0, $zero, if_kb_end
    addi $a2, $a2, -3
    j if_kb_end
if_kb_s:
    li $t3, 115
    bne $v0, $t3, end_if_kbhit
    li $a3, 3
    jal checkPosY
    beq $v0, $zero, if_kb_end
    ; --> LOGIC FOR MOVEMENT
    addi $a2, $a2, 3
if_kb_end:
    li $v0, 51
    syscall
    ;#show $v0
    jal Player
    sw $a1, 364($sp)
    sw $a2, 368($sp)
    jal RepaintBoxes
    lw $a1, 364($sp)
    lw $a2, 368($sp)
    ;#show $a1
    ;#show $a2
    ;#show $a1
    ;#show $a2
end_if_kbhit:
    j while_play
end_while_play:
    lw $ra, 324($sp)
    addi $sp, $sp, 372
    jr $ra