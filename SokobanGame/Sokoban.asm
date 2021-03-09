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
    addi $sp, $sp, -348
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
    move $a2, $t3
    syscall
    move $a3, $s0
    ;#show $t1
    jal generateMap
    jal printMap
while_play:
    ;#show $t0
    li $v0, 31 ;--> call kbhit()
    syscall
if_w:
    beq $v0, $zero, end_if_w
    #show $v0
end_if_w:
    j while_play
if_kbhit:
    beq $v0, $zero, end_if_kbhit
    li $v0, 32 ; --> call getch()
    move $t0, $v0
    #show $t0
    li $v0, 51 ; --> call rlutil::locate
    move $a1, $t1
    move $a2, $t3
    syscall

end_if_kbhit:
    j while_play
end_while_play:
    lw $ra, 324($sp)
    addi $sp, $sp, 344
    jr $ra