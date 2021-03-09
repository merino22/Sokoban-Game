.global start

start:
    li $t0, 1
while:
    beq $v0, $t0, end_while
    li $v0, 31
    syscall
    #show $v0
    j while
end_while:
    li $v0, 32
    syscall
    #show $v0
