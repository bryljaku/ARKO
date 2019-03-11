.data
prompt: .ascii "Program odwraca kolejnosc znakow we wprowadzonym tekscie\n"
	.ascii "dzielac tekst na wyrazy 4-znakowe, odwracaj¹c je, i wstawiaj¹c ponownie na miejsce\n"
	.ascii "slowa w stringu\n"
	.asciiz "Wprowadz tekst: \n"
string: .space 128

.text
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 8
	la $a0, string
	la $a1, 128
	syscall
	
	la $t9, string #address of the end of string
	
findEnd:
	lb $t8, ($t9)
	beq $t8, $zero, findEndFin
	addiu $t9, $t9, 1
	b findEnd 
	
findEndFin:
	subi $t9, $t9, 1 #go back to last char of string
	
	la $t2, string # i = address of the string's beginning 
	j getWordIterators
	
nextWord: #nextWord
	addiu $t2, $t2, 2
	
getWordIterators:#getWordIterators
	bgt $t2, $t9, end #if i greater than end address exit
	addiu $t3, $t2, 4 # j = i + 4
	
decrementJ: #decrementJ
	subi $t3, $t3, 1 #if j >= end of the string
	bge $t3, $t9, decrementJ

reverseWord: #reverse word
	bge $t2, $t3, nextWord
	
	lb $t5, ($t2)
	lb $t6, ($t3)
	sb $t6, ($t2) #
	sb $t5, ($t3) # change places
	
incrementIterators:
	addiu $t2, $t2, 1 #i++
	subiu $t3, $t3, 1 #j--
	j reverseWord
	
end:
	li $v0, 4
	la $a0, string
	syscall
	
	li $v0, 10
	syscall

