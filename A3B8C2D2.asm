	.data
input:  .space 128
output: .space 256

	.text
main:
	#get string
	li $v0, 8
	la $a0, input
	la $a1, 128
	syscall
	
	#set iterators i = char, j = number
iterators:
	la $t6, output #output iterator
	la $t2, input # i
	la $t3, input # j
	addiu $t3, $t3, 1
	j getNumberAndLetter
incrementIterators:
	addiu $t3, $t3, 2
	addiu $t2, $t2, 2
getNumberAndLetter:
	lb $t4, ($t2)
	lb $t5, ($t3)
	beq $t4, $zero, end
	beq $t5, $zero, end
loopNumber:
	ble $t5, '0', incrementIterators
	sb $t4, ($t6)
	addiu $t6, $t6, 1
	subiu $t5, $t5, 1
	j loopNumber
end:
	li $v0, 4
	la $a0, output
	syscall
	
	li $v0, 10
	syscall