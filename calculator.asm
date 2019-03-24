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
	
	#now prints results
	
	j Terminate
	
	addNoOverflow:	
	add 	$t0, $s0, $s2		# adds the 2 values and stick them into $t0
	li 	$v0, 0			#indictating no overflow	
	move	$v1, $t0		# stick in $v0
	jr	$ra			# return!
Sub:
Multi:
Divide:

overflow:
	li $v0,1 #Error has been detected so 1 must be placed in
	j Terminate
