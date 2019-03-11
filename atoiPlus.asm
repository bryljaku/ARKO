.data
string: .space 128
over: .asciiz "Overflow\n"

.text
main:
	li $v0, 8
	la $a0, string
	la $a1, 128
	syscall
		
	la $t0, string
	li $t2, 0
	# $t1 -> sum
	# $t0 -> string iterator
get_sign:
	li $t3, 1
	lb $t1, ($t0)
	bne $t1, '-', positive
	li $t3, -1
	addu $t0, $t0, 1
positive:

loop:
	# $t2 -> current digit
	lb $t1, ($t0)
	addu $t0, $t0, 1
	
	beq $t1, 10, end_loop # 10 = '\n'
	# check if it is digit
	ble $t1, '0', end_loop 
	bge $t1, '9' end_loop
	
	#check overflow (do not know how it works)
	mul $t2, $t2, 10
	mfhi $t5
	bnez $t5, overflow
	mflo $t2
	
	sub $t1, $t1, '0' #do not know why
	add $t2, $t2, $t1

	b loop
overflow:
	li $v0, 4
	la $a0, over
	syscall
	b exit
end_loop:
	mul $t2, $t2, $t3
	li $v0, 1
	move $a0, $t2
	syscall
exit:
	li $v0, 10
	syscall