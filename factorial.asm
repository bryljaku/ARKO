.data
prompt: .asciiz "get factiorial of given number:\n"

.text

main:
	li $v0, 5
	syscall
	move $t2, $v0 #output
	move $t1, $v0 #current multiplier
	beq $t2, 0, zero
	
loop:
	subi $t1, $t1, 1
	ble $t1, $zero, end
	mulou $t2, $t2, $t1
	j loop
end:
	li $v0, 1
	la $a0, ($t2)
	syscall
	li $v0, 10
	syscall 
zero:
	li $t2, 1
	j end