#MIPS Programming Assignment 2
#Kamron Morgan

.data

	str1: .asciiz "Enter first integer n1: "
	str2: .asciiz "Enter second integer n2: "
	str3: .asciiz "The greatest common divisor of n1 and n2 is "
	str4: .asciiz "The least common multiple of n1 and n2 is "
	newline: .asciiz "\n"

.text

main:
	li $v0, 4 #Print str1 for prompt of first number
	la $a0, str1
	syscall

	li $v0, 5 #Read first number
	syscall
	add $a1, $v0, $zero

	li $v0, 4 #Print str2 for prompt of second number
	la $a0, str2
	syscall

	li $v0, 5 #Read second number
	syscall
	add $a2, $v0, $zero

	addi $sp, $sp, -8  #Reserve space on stack for LCM later
	sw $a1, 4($sp)
	sw $a2, 0($sp)

	jal GCD	#Call GCD

	lw $a2, 0($sp) 
	lw $a1, 4($sp)
	addi $sp, $sp, 4 #Restore space to stack
	add $s0, $v0, $zero #Store GCD result
	sw $s0, 0($sp)

	jal LCM #Call LCM

	add $s1, $v0, $zero #Store LCM result
	lw $s0, 0($sp)
	addi $sp, $sp, 4 #Restore remaining space to stack

	la $a0, str3 #Print information about GCD
	li $v0, 4
	syscall

	li $v0, 1 #Print GCD
	add $a0, $s0, $zero
	syscall

	la $a0, newline #Print new line for formatting
	li $v0, 4
	syscall

	la $a0, str4 #Print information about LCM
	li $v0, 4
	syscall

	li $v0, 1 #Print LCM
	add $a0, $s1, $zero
	syscall

	li $v0, 10 #End program
	syscall


GCD:
	bne $a2, $zero, L1 #Branch if n2 != 0
	add $v0, $a1, $zero #Basecase for GCD
	jr $ra #Return

L1: 
	addi $sp, $sp, -8 #Reserve space on stack
	sw $ra, 4($sp)
	div $a1, $a2 #Figure out n1%n2
	mfhi $s0 #Move from hi to $s0
	sw $s0, 0($sp)

	add $a1, $a2, $zero
	lw $s0, 0($sp) #load n1%n2
	add $a2, $s0, $zero
	jal GCD #Recursively call GCD

	lw $ra, 4($sp)
	addi $sp, $sp, 8 #Restore space to stack
	jr $ra #Return

LCM:
	addi $sp, $sp, -12 #Reserve space on stack
	sw $ra, 8($sp)
	sw $a1, 4($sp)
	sw $a2, 0($sp)

	jal GCD #Call GCD

	lw $a2, 0($sp) #Load arguments and return address
	lw $a1, 4($sp)
	lw $ra, 8($sp)

	mult $a1, $a2 #Do n1*n2/gcd(n1,n2)
	mflo $t0
	div $t0, $v0
	mflo $v0

	addi $sp, $sp, 12 #Restore stack
	jr $ra #Return



