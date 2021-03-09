.global printMap
.global generateMap

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
    li $t0, 36
    li $t3, 0
    mult $t1, $t0 ; --> i * 36
    mflo $t3
    sll $t0, $t2, 2 ; --> j * 4
    add $t3, $t0, $t3
    add $t3, $a0, $t3
    lw $t4, 0($t3)

    li $t0, 1 ;--> constant 1
    sw $t1, 328($sp) ;--> store i var in stack
    sw $t2, 332($sp) ;--> store j var in stack
if_tree:
    bne $t4, $t0, if_block
    jal Tree
if_block:
    li $t0, 2
    bne $t4, $t0, if_box 
    jal Block
if_box:
    li $t0, 3
    bne $t4, $t0, end_ifs
    jal Box
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
    lw $ra, 344($sp)
    jr $ra

generateMap:
if_first_level:
    li $t0, 1
    bne $a3, $t0, if_second_level

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
    li $t0, 3
    sw $t0, 120($sp)
    li $t0, 0
    sw $t0, 124($sp)
    li $t0, 3
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
    li $t0, 3
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
    li $t0, 3
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
    bne $a3, $t0, if_third_level

if_third_level:
    li $t0, 3
    bne $a3, $t0, end_levels

end_levels:
    jr $ra

