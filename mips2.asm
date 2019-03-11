	.macro printString (%str)
	.data
myString: .asciiz %str
	.text
	li $v0, 4
	la $a0, myString
	syscall
	.end_macro
	
	
.data
hello: .asciiz "\nHejka stulejka\n"
inputFileMessage: .asciiz "\nEnter path to input file:\n"
outputFileMessage: .asciiz "\nEnter path to output file:\n"
pathErrorMessage: .asciiz "\nWrong filepath, aborting.\n"

.text
main:
	

printHello:
	#wypisanie hello
	la $a0, hello
	li $v0, 4 # 4 = print string
	syscall

	printString("Hejka")
	li $v0, 8
	la $a0, 128
	li $a1, 128
	syscall
	l
