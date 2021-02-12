.global main

.data

    str1: .byte "Welcome to Sokoban!", 0
    str2: .byte "1. Play Game", 0
    str3: .byte "2. Quit Game", 0
    str4: .byte "Selection Option: ", 0
    str5: .byte "Exiting Game... Thank you for Playing!", 0
    arcade_str: .byte "1. Arcade Mode", 0
    lvl_select_str: .byte "2. Level Selection", 0

.text

main:
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

    add $t1, $t1, $v0

    li $v0, 11
    li $a0, 10
    syscall
    
    li $t0, 2
if_exit:
    bne $t1, $t0, end_if_exit
    li $v0, 4
    li $a0, str5
    syscall
    li $v0, 10
    syscall 
end_if_exit:

if_play:
    beq $t1, $t0, end_if_play
    li $v0, 4
    li $a0, arcade_str
    syscall

    li $v0, 11
    li $a0, 10
    syscall

    li $v0, 4
    li $a0, lvl_select_str
    syscall

    li $v0, 11
    li $a0, 10
    syscall

    li $v0, 4
    li $a0, str4
    syscall

    li $v0, 5
    syscall

    move $a0, $v0

    li $v0, 1
    syscall
end_if_play:

    