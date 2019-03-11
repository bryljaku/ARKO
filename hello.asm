#hello

.data
name: .space 30
prompt: .asciiz "Enter your name: "
hello: .asciiz "\n Hello, "


.text
main:
	#prompt user
	la $a0, prompt
	li $v0, 4
	syscall
	
	#get name
	la $a0, name
	li $a1, 30
	li $v0, 8
	syscall
	
	#print hello
	la $a0, hello
	li $v0, 4
	syscall
	
	#print name
	la $a0, name
	li $v0, 4
	syscall