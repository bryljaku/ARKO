.data
string: .space 128

.text
main:
	la $a0, string
	la $a1, 128
	li $v0, 8
	syscall #read string
	
	la $t0, string
	li $t2, 0
# $t1 -> sum
# $t0 -> string iterator
loop:
# $t2 -> current digit
	lb $t1, ($t0)
	addu $t0, $t0, 1
	
	beq $t1, 10, end_loop # 10 = '\n'
	
	mul $t2, $t2, 10
	
	sub $t1, $t1, '0' #do not know why
	add $t2, $t2, $t1

	b loop
end_loop:
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 10
	syscall