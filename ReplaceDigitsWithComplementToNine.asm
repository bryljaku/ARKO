# for i in string:
#	if digit:
#		i = 9 - digit
#	
.data
prompt: .asciiz "Enter string with some digits. I will replace them with their complement to 9\n"
string1: .space 64  #reserve space for 64 chars

.text
main:
	li $v0, 4
	la $a0, prompt
	syscall #display prompt

	li $v0, 8
	la $a0, string1
	la $a1, 64
	syscall #load string

	la $t1, string1
# t1 -> iterator
# t2 -> char
	li $t5, 9
loop:
	lb  $t2, ($t1)
	beq $t2, 0, end
	blt $t2, '0', back_loop
	bgt $t2, '9', back_loop
	#check whether it is a digit
	#it it is:
	li $t6, '0'
	li $t7, '9'
findComplement:
	beq $t7, $t2, save
	addi $t6, $t6, 1
	subi $t7, $t7, 1
	b findComplement
save:	
	sb $t6, ($t1)
back_loop:
	add $t1, $t1, 1
	b loop
end:
	li $v0, 4
	la $a0, string1
	syscall
	
	li $v0, 10
	syscall
	