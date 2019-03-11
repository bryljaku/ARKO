.data
	prompt: .asciiz "Enter numers\n"


.text
	#print prompt
	li $v0, 4
	la $a0, prompt
	syscall
	
	#get number1
	li $v0, 5 #get number from user and save it in v0
	syscall
	move $t0, $v0 #move number from v0 to t0
	
	#get number2
	li $v0, 5
	syscall
	move $t1, $v0
	
	#add these numbers
	add $t3, $t0, $t1
	
	#move sum to a0 and print
	move $a0, $t3
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
	
	
	
	