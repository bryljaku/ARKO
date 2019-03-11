.data
prompt: .asciiz "Enter text to test if it is palindrome\n"
space: .asciiz " "
palindrome: .asciiz "It is a palindrome\n"
notPalindrome: .asciiz "It is not a palindrome\n"
string: .space 128

.text
main:
	li $v0, 4
	la $a0, prompt
	syscall #print prompt
	
	li $v0, 8
	la $a1, 128
	la $a0, string
	syscall #get string
	
	la $t0, string
	la $t1, string
# $t0 -> A = S
# $t1 -> B = S, B is our iterator 
moveBtoEnd: #t2 -> current char
	lb $t2, ($t1)
	beq $t2, $zero, escapeMovingB
	addu $t1, $t1,1
	b moveBtoEnd
escapeMovingB:
#b stays after our string so we have to move it back 2 places (string: ...words\n\0
	sub $t1, $t1, 2
check_loop: # t2, t3 -> here we store chars from our string
	bge $t0, $t1, palindromee
	#load chars
	lb $t2, ($t0)
	lb $t3, ($t1)
	
	bne $t2, $t3 not_palindrome
	#otherwise A++, B--
	addu $t0, $t0, 1
	sub $t1, $t1, 1
	
	b check_loop
	
palindromee:
	li $v0, 4
	la $a0, palindrome
	syscall
	b end
not_palindrome:
	li $v0, 4
	la $a0, notPalindrome
	syscall
end:
	li $v0, 10
	syscall