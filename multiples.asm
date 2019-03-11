.data
prompt: .asciiz "Enter 2 numbers(A\nB). Program will print out multiplications of A from A to A * B\n"
space: .asciiz " "
.text
main:
	li $v0, 5
	syscall
	move $t0, $v0
	li $v0, 5
	syscall
	move $t1, $v0
# $t0 = A 
# $t1 = B
	
	blez $t1, exit
	mul $t2, $t0, $t1
	move $t3, $t0
# $t2 = A * B 
# $t3 = m (m = A na pocz¹tku, póŸniej bêdzie inkrementowane o A co pêtle a¿ bêdzie równe A * B

loop:
	li $v0, 1
	move $a0, $t3
	syscall #print m
	
	add $t3, $t3, $t0
	
	li $v0, 4
	la $a0, space
	syscall #print space
	
	beq $t3, $t2, end_loop
	b loop #iterate

end_loop:
	li $v0, 1 
	move $a0, $t3
	syscall	#print last multiplication
		
exit:
	li $v0, 10
	syscall #terminate