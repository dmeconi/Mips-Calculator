.data

intAsk:	.asciiz "Please enter an integer: "
opAsk:	.asciiz "Please enter an operation (+,-,*,/): "
thankDisplay:	.asciiz "Thank you."
overflowCase: .asciiz "I'm sorry, that would overflow."
divZeroCase: .asciiz "I'm sorry, you cannot divide by 0."
nLine: .asciiz "\n"
remainder: .asciiz "R"

.text

main:

	#asks to input a int & listens to input 1st int
	li $v0, 4			#Sets syscall type to print a string
	la $a0, intAsk
	syscall
	la $v0, 5			#Listener for User input
	syscall
	#moves input to s0
	move $s0, $v0


	#aks for operation (+,-,*,/) & listens to input for operation OP
	li $v0, 4			#sets syscall type to print a string
	la $a0, opAsk
	syscall
	li $v0,12			#listens for User Input
	syscall
	#moves input to t1
	move $s1,$v0
	#creates new line for aesthetics
	li $v0, 4
	la $a0, nLine
	syscall

	#asks to input a int & listens to input 2nd int
	li $v0, 4			#Sets syscall type to print a string
	la $a0, intAsk
	syscall
	li $v0, 5			#Listener for User input
	syscall
	#moves input to s2
	move $s2, $v0

	#checks to see what operation is to be preformed
	li $t0, '+'		#loads char (+)
	beq $s1,$t0,Add		#branches if condition is true is +

	li $t0, '-'		#loads char(-)
	beq $s1,$t0,Sub		#branches if condition is true is -

	li $t0, '*'		#loads char(-)
	beq $s1,$t0,Multi		#branches if condition is true is *

	li $t0, '/'		#loads char(-)
	beq $s1,$t0,Divide		#branches if condition is true is /


	Terminate:
	li $v0, 10		# exit cleanly
	syscall

Add:
	#check for over flow
	addu $t0,$s0,$s2
	xor  $t3,$t0,$s0
	bltz $t3,overflow

	#if no overflow detected
	jal addNoOverflow
	move $t0,$v0		#
	#now prints results

	#Printing thank you message
	li 	$v0, 4 			#system call code for printing string is 4
	la 	$a0,thankDisplay 	#loads address for string to be printed
	syscall

	#printing a space
	li 	$a0, 32		#adds a space using asiic for space #=32
	li 	$v0, 11 	#11 is syscall number needed to print char
	syscall

	#Add s0 int first int to be printed
	li	$v0, 1		#syscall # for printing int
	move 	$a0, $s0	#$a0 register to be printed
	syscall

	#printing a space
	li 	$a0, 32		#adds a space using asiic for space #=32
	li 	$v0, 11 	#11 is syscall number needed to print char
	syscall

	#printing the user inputted operator
	move $a0, $s1		#copy from register for time as loading would take more time
	li $v0, 11 		#11 is the value from printing the character
	syscall

	#printing a space
	li 	$a0, 32		#adds a space using asiic for space #=32
	li 	$v0, 11 	#11 is syscall number needed to print char
	syscall

	#Add s2 int first int to be printed
	li	$v0, 1		#syscall # needed to print an int
	move 	$a0, $s2	#$a0 register to be printed
	syscall

	#printing a space
	li 	$a0, 32		#adds a space using asiic for space #=32
	li 	$v0, 11 	#11 is syscall number needed to print char
	syscall

	#printing the equals sign
	li $a0, '='		#puts asiic equal into a0 return
	li $v0, 11 		#11 syscall # needed to print a character
	syscall

	#printing a space
	li 	$a0, 32		#adds a space using asiic for space #=32
	li 	$v0, 11 	#11 is syscall number needed to print char
	syscall

	#printing result stored in $s3 register
	li	$v0, 1		#syscall # needed to print an int
	move 	$a0, $t0	#moves $s3 register stored value result to be printed
	syscall
	j Terminate		#terminates program

	addNoOverflow:
	add 	$v0, $s0, $s2		#adding two values and storing it into s3 because its a saved register
	li	$v1,0		#no error found
	jr	$ra			# return to jal
Sub:
	#checking for overflow
	xor 	$t3,$s0,$s2 		# check to see if the signs of the operands are the same, if they are then there cannot be overflow
	bgtz	$t3,case1		# no overflow if $t3>0

	subu $t0,$s0,$s2		#unsigned subtraction
	xor $t2,$t0,$s0			#checks to see if sign is different
	blez $t2,overflow		#detects if there is a overflow and branches to overflow
	case1:
	jal subNoOverflow		#goes to no overflow function
	move $t0,$v0

	#Printing thank you message
	li 	$v0, 4 			#system call code for printing string is 4
	la 	$a0,thankDisplay 	#loads address for string to be printed
	syscall

	#printing a space
	li 	$a0, 32		#adds a space using asiic for space #=32
	li 	$v0, 11 	#11 is syscall number needed to print char
	syscall

	#Add s0 int first int to be printed
	li	$v0, 1		#syscall # for printing int
	move 	$a0, $s0	#$a0 register to be printed
	syscall

	#printing a space
	li 	$a0, 32		#adds a space using asiic for space #=32
	li 	$v0, 11 	#11 is syscall number needed to print char
	syscall

	#printing the user inputted operator
	move $a0, $s1		#copy from register for time as loading would take more time
	li $v0, 11 		#11 is the value from printing the character
	syscall

	#printing a space
	li 	$a0, 32		#adds a space using asiic for space #=32
	li 	$v0, 11 	#11 is syscall number needed to print char
	syscall

	#Add s2 int first int to be printed
	li	$v0, 1		#syscall # needed to print an int
	move 	$a0, $s2	#$a0 register to be printed
	syscall

	#printing a space
	li 	$a0, 32		#adds a space using asiic for space #=32
	li 	$v0, 11 	#11 is syscall number needed to print char
	syscall

	#printing the equals sign
	li $a0, '='		#puts asiic equal into a0 return
	li $v0, 11 		#11 syscall # needed to print a character
	syscall

	#printing a space
	li 	$a0, 32		#adds a space using asiic for space #=32
	li 	$v0, 11 	#11 is syscall number needed to print char
	syscall

	#printing result stored in $s3 register
	li	$v0, 1		#syscall # needed to print an int
	move 	$a0, $t0	#moves $s3 register stored value result to be printed
	syscall
	j Terminate		#terminates program

	subNoOverflow:
	sub $v0,$s0,$s2		#subtracts registers
	li $v1,0		#no error found
	jr $ra
Multi:
Divide:

overflow:
	li $v0, 4
	la $a0, overflowCase
	syscall
	li $v0,1 #Error has been detected so 1 must be placed in
	j Terminate
