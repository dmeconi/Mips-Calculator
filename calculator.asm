.data

intAsk:	.asciiz "Please enter an integer: "
opAsk:	.asciiz "Please enter an operation (+,-,*,/): "
thankDisplay:	.asciiz "Thank you."
overflowCase: .asciiz "I'm sorry, that would overflow."
divZeroCase: .asciiz "I'm sorry, you cannot divide by 0."
nLine: .asciiz "\n"

.text

main:

	#asks to input a int & listens to input 1st int
	li $v0, 4			#Sets syscall type to print a string
	la $a0, intAsk
	syscall
	la $v0, 5			#Listener for User input
	syscall
	#moves input to t0
	move $t0, $v0
	
	
	#aks for operation (+,-,*,/) & listens to input for operation OP
	li $v0, 4			#sets syscall type to print a string
	la $a0, opAsk
	syscall
	li $v0,8			#listens for User Input
	syscall
	#moves input to t1
	move $t1, $v0	
	#creates new line for aesthetics
	la $a0, nLine
	syscall 
	
	#asks to input a int & listens to input 2nd int
	li $v0, 4			#Sets syscall type to print a string
	la $a0, intAsk
	syscall
	la $v0, 5			#Listener for User input
	syscall
	#moves input to t0
	move $t2, $v0
	
	li	$v0, 10		# exit cleanly
	syscall
	
Add:
Sub:
Multi:
Divide:
