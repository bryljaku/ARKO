.data
string: .space 128

.text
main:
	li $v0, 8
	la $a0, string
	la $a1, 128
	syscall
	la $t8, string
	la $t1, string
	addiu $t8, $t8, 128
	li $t9, 0
	
	
loop_begin:
	bgt $t1, $t8, fin
	lb $t2, ($t1)
	beq $t2, $zero, fin
	beq $t2, '\n', fin
	
	blt $t2, 'a', increment
	bgt $t2, 'z', increment
	
	beq $t9, $zero, incrementMod 
	
	li $t9, 0
upper:
	subi $t2, $t2, 32
	sb $t2, ($t1)
increment:
	addiu $t1, $t1, 1
	b loop_begin
fin:
	la $a0, string
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
incrementMod:
	addi $t9, $t9, 1
	b increment