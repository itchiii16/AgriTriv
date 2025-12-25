.data
welcome_msg: .asciiz "\n=========== Welcome to AgriTriv! ===========\n"
welcome_detail: .asciiz "Get ready for a fun and educational trivia about agriculture!\n"
welcome_end: .asciiz "=============================\n"
ready_prompt: .asciiz "Are you ready to play? (1=Yes, 0=No): "
name_prompt: .asciiz "Enter your name: "
hello_msg: .asciiz "\Welcome to the game, "
newline: .asciiz "\n"
input_prompt: .asciiz "\nYour answer (A-D): "
score_msg: .asciiz "\nScore: "
continue_prompt: .asciiz "\nContinue to next round? (1=Yes, 0=No): "
final_score_msg: .asciiz "\nThank you for playing, your final score is: "
level_prompt: .asciiz "Choose difficulty level (1-3):\n1. Easy\n2. Medium\n3. Hard\nYour choice: "
invalid_level_msg: .asciiz "Invalid choice. Defaulting to Easy.\n"

player_name: .space 20
score: .word 0

# Questions Data
questions_easy:   .word q1e, q2e, q3e, q4e, q5e
options_easy:     .word o1e, o2e, o3e, o4e, o5e
answers_easy:     .byte 'A', 'C', 'B', 'D', 'A'

questions_medium: .word q1m, q2m, q3m, q4m, q5m
options_medium:   .word o1m, o2m, o3m, o4m, o5m
answers_medium:   .byte 'B', 'D', 'A', 'C', 'C'

questions_hard:   .word q1h, q2h, q3h, q4h, q5h
options_hard:     .word o1h, o2h, o3h, o4h, o5h
answers_hard:     .byte 'C', 'B', 'D', 'A', 'B'

# Easy Questions
q1e: .asciiz "What is the most widely grown crop in the world?\n"
o1e: .asciiz "A. Corn\nB. Wheat\nC. Rice\nD. Barley\n"

q2e: .asciiz "Which nutrient do plants need in the largest amount?\n"
o2e: .asciiz "A. Iron\nB. Zinc\nC. Nitrogen\nD. Magnesium\n"

q3e: .asciiz "Which season is best for planting rice in the Philippines?\n"
o3e: .asciiz "A. Winter\nB. Summer\nC. Rainy\nD. Dry\n"

q4e: .asciiz "Which of these is a fruit?\n"
o4e: .asciiz "A. Carrot\nB. Potato\nC. Lettuce\nD. Tomato\n"

q5e: .asciiz "What is used to enrich soil fertility?\n"
o5e: .asciiz "A. Compost\nB. Plastic\nC. Salt\nD. Gravel\n"

# Medium Questions
q1m: .asciiz "What is crop rotation primarily used for?\n"
o1m: .asciiz "A. Irrigation\nB. Soil health\nC. Sunlight\nD. Harvesting\n"

q2m: .asciiz "Which of these is a legume crop?\n"
o2m: .asciiz "A. Rice\nB. Soybean\nC. Corn\nD. Wheat\n"

q3m: .asciiz "Which method is best for conserving water in farming?\n"
o3m: .asciiz "A. Drip irrigation\nB. Sprinklers\nC. Flooding\nD. Spraying\n"

q4m: .asciiz "Which farming type focuses on small-scale, family-run operations?\n"
o4m: .asciiz "A. Industrial\nB. Urban\nC. Subsistence\nD. Commercial\n"

q5m: .asciiz "Which mineral is essential for photosynthesis?\n"
o5m: .asciiz "A. Calcium\nB. Phosphorus\nC. Magnesium\nD. Sulfur\n"

# Hard Questions
q1h: .asciiz "Which organism helps fix nitrogen in legume roots?\n"
o1h: .asciiz "A. E. coli\nB. Algae\nC. Rhizobium\nD. Fungi\n"

q2h: .asciiz "Which practice is NOT sustainable agriculture?\n"
o2h: .asciiz "A. Cover cropping\nB. Monoculture\nC. Organic farming\nD. Permaculture\n"

q3h: .asciiz "What is the Green Revolution known for?\n"
o3h: .asciiz "A. Crop diseases\nB. Use of machines\nC. Genetic modification\nD. High-yield crops\n"

q4h: .asciiz "Which compound is a natural pesticide?\n"
o4h: .asciiz "A. Neem oil\nB. Diesel\nC. Vinegar\nD. Charcoal\n"

q5h: .asciiz "What is the ideal pH range for most crops?\n"
o5h: .asciiz "A. 3.5-4.0\nB. 6.0-7.5\nC. 5.0-5.5\nD. 8.0-9.0\n"

# You can add more questions following the same pattern

.text
.globl main

main:

    li $v0, 4
    la $a0, welcome_msg
    syscall

    li $v0, 4
    la $a0, ready_prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    beq $t0, 0, exit_game

    li $v0, 4
    la $a0, name_prompt
    syscall

    li $v0, 8
    la $a0, player_name
    li $a1, 20
    syscall

    li $v0, 4
    la $a0, hello_msg
    syscall

    li $v0, 4
    la $a0, player_name
    syscall

    li $v0, 4
    la $a0, level_prompt
    syscall

    li $v0, 5
    syscall
    move $t9, $v0      # Level choice

    li $t0, 1
    li $t1, 3
    blt $t9, $t0, default_easy
    bgt $t9, $t1, default_easy
    j set_level

default_easy:
    li $v0, 4
    la $a0, invalid_level_msg
    syscall
    li $t9, 1

set_level:
    li $t0, 1
    beq $t9, $t0, level_easy

    li $t0, 2
    beq $t9, $t0, level_medium

    li $t0, 3
    beq $t9, $t0, level_hard

level_easy:
    la $s0, questions_easy
    la $s1, options_easy
    la $s2, answers_easy
    j level_start

level_medium:
    la $s0, questions_medium
    la $s1, options_medium
    la $s2, answers_medium
    j level_start

level_hard:
    la $s0, questions_hard
    la $s1, options_hard
    la $s2, answers_hard

level_start:
    li $t1, 0         
    li $t2, 5         

level_loop:
    li $t3, 0         

question_loop:

    li $v0, 4
    la $a0, newline
    syscall

    mul $t5, $t1, 4
    add $t4, $s0, $t5
    lw $a0, 0($t4)
    li $v0, 4
    syscall

    mul $t5, $t1, 4
    add $t4, $s1, $t5
    lw $a0, 0($t4)
    li $v0, 4
    syscall

    li $v0, 4
    la $a0, input_prompt
    syscall

    li $v0, 12
    syscall
    move $t6, $v0     

    add $t4, $s2, $t1
    lb $t7, 0($t4)

    beq $t6, $t7, correct_answer
    j continue_question

correct_answer:
    lw $t8, score
    addi $t8, $t8, 1
    sw $t8, score

continue_question:
    addi $t1, $t1, 1
    addi $t3, $t3, 1

    blt $t3, $t2, question_loop

    li $v0, 4
    la $a0, continue_prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    beq $t0, 1, level_loop

    li $v0, 4
    la $a0, final_score_msg
    syscall

    lw $a0, score
    li $v0, 1
    syscall

    j exit_game

exit_game:
    li $v0, 10
    syscall