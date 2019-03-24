.data

intAsk:	.asciiz "Please enter an integer: "
opAsk:	.asciiz "Please enter an operation (+,-,*,/): "
thankDisplay:	.asciiz "Thank you."
overflowCase: .asciiz "I'm sorry, that would overflow."
divZeroCase: .asciiz "I'm sorry, you cannot divide by 0."
nLine: .asciiz "\n"

addSign: .asciiz  "+"
subSign: .asciiz  "-"
multSign: .asciiz "*"
divSign: .asciiz  "/"
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
	
	
	li	$v0, 10		# exit cleanly
	syscall
	
Add:
	add $s1,$s0,$s2

Sub:
Multi:
Divide:
