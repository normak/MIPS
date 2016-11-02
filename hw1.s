.data
	reverse: .word 0
	str1: .asciiz "Programming assignment 1 for CDA3101\n"
	str2: .asciiz "This palindrome checker only deals with positive integer numbers.\n"
	str3: .asciiz "Enter a number to check if it is a palindrome or not. \n"
	str4: .asciiz " is a palindrome number.\n"
	str5: .asciiz " is not a palindrome number.\n"
.text
main:
	lw $s0, reverse # int reverse = 0 is in $s0

	li $v0, 4	# print str1
	la $a0, str1
	syscall

	li $v0, 4 # print str2
	la $a0, str2
	syscall

	li $v0, 4 # print str 3
	la $a0, str3
	syscall

	li $v0, 5 # read int value
	syscall
	move $s1, $v0 #store read number in $s1
	add $s2, $zero, $s1 #make copy of number

	# reverse = s0
	# temp = s1
	# num = s2

Loop:
	beq $s1, $zero, endloop # if temp equals 0 then branch to endloop
	li $t2, 10 # reverse = reverse * 10
	mult $s0, $t2
	mflo $s0
	
	div $s1, $t2 #temp / 10 remainder in HI
	mfhi $t0 #temp % 10 stored in $t0 from HI
	add $s0, $t0, $s0 #reverse = temp%10 + reverse

	div $s1, $t2 
	mflo $s1 # temp = temp/10 from LO
	j Loop # Go to start of loop

endloop:
	beq $s2, $s0, ispal #if num = reverse, branch
	li $v0, 1 # else, it is not a palindrome
	move $a0, $s2 # print number
	syscall
	li $v0, 4 # print str5
	la $a0, str5
	syscall
	j end #skip to end since it's not a palindrome

ispal:
	li $v0, 1 #it is a palindrome
	move $a0, $s2 #print number
	syscall
	li $v0, 4 # print str4
	la $a0, str4
	syscall

end:
	li $v0, 10 #End the program
	syscall