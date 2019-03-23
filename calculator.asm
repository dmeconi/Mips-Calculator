.data

intAsk:	.asciiz "Please enter an integer: "
opAsk:	.asciiz "Please enter an operation (+,-,*,/): "
thankDisplay:	.asciiz "Thank you."
overflowCase: .asciiz "I'm sorry, that would overflow."
divZeroCase: .asciiz "I'm sorry, you cannot divide by 0."

.text

main:

	#asks to input a int & listens to input
	li $v0, 4		#Sets syscall type to print a string
	la $a0, intAsk
	syscall
	la $v0, 5			#Listener for User input
	syscall 
	
	
	li	$v0, 10		# exit cleanly
	syscall
	
Add:
Sub:
Multi:
Divide:
