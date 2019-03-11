.data
prompt: .asciiz "wprowadz liczby aby je dodac, aby zakonczyc wprowadz 0\n"

.text
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
loop:
	#pobierz liczbe od uzytkownika
	li $v0, 5
	syscall
	
	move $t1, $v0
	beq $t1, $zero, end_loop #if number == 0 then finish
	
	add $t2, $t2, $t1 #dodaj kolejna liczbe
	b loop 
	
end_loop:
	move $a0, $t2
	li $v0, 1
	syscall #print int
		
	li $v0, 10
	syscall #terminate
	
	
	