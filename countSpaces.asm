#show current amount of chars to the actual place

.data
prompt:	.asciiz "Enter text: "

buf: .space 100

.text
main:
	#print prompt
	la $a0, prompt
	li $v0, 4 # 4 =  print string
	syscall
	
	#get text from user
	la $a0, buf
	li $a1, 100
	li $a0, 8 # 8 = get string
	syscall

nextchar:
	lbu $t2, ($t0) #load byte unsigned
	addiu $t0, $t0, 1 #next char
	bltu $t2, ' ', fin # if < ' ' terminate
	beq $t2, ' ', nextchar # if $t2 == ' '  ->nextchar
	sb $t2, ($t1) # overwrite byte from $t2 to $t1
	addiu $t1, $t1, 1 #nastêpny znak
	b nextchar # powrót na pocz¹tek nextchar	
fin:
	# print result
	sb $zero, ($t1)
	la $a0, buf
	li $v0, 4
	syscall
