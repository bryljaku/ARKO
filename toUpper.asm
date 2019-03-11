.data
text0: .asciiz "enter string\n" #definicja tekstu który wpiszemy
string: .space 100 #definicja bufora na string do wczytania

.text
.global main

main:
	#wypisz tekst
	la $a0, text0 #wypisz text0
	li $v0, 4 #instrukcja nr 4 = wypisz string
	syscall #system wykona instrukcje nr 4
	
	#pobierz tekst od uzytkownika
	la $a0, string #adres bufora jako argument wywo³ania systemowego
	la $a1, 100 #maksymalna iloœæ znaków jak¹ przyjmie system 
	li $v0, 8 #instrukcja numer 8 = pobierz string
	syscall
	
	li $t0, 'a' #za³adowanie a do rejestru 0
	li $t1, 'z' # ^^^^^^^^^^ z ^^^^^^^^^^^ 1
	li $t2, 0x20 # 0x20 = 32 = int(' ')
	
	la $t3, string #przechowujemy adres stringa w buforze t3, na pocz¹tku wskazuje on na pocz¹tek
		       # póŸniej bêdziemy go u¿ywaæ do iterowania po stringu
loop_begin:
	# $t0 = 'a' | $t1 = 'z' | $t2 = 0x20 = 32 = ' ' | $t3 - adres iteratora
	#load byte, z miejsca na które wskazuje t3 do t4
	lb $t4, ($t3)
	#beq = if ... go to
	beq $t4, $zero, loop_end #jeœli zawartoœæ rejestru t4 jest równa 0 to koñczymy pêtlê
	blt $t4, $t0, increment_ptr
	bgt $t4, $t1,  increment_ptr
	# 'a' <= $t4 <= 'z'
	sub $t4, $t4, $t2 #subtraction: t4 = t4 - t2
	sb $t4, ($t3)
increment_ptr:
	addi $t3, $t3, 1
	b loop_begin
loop_end:
	li $v0, 4
	la $a0, string
	syscall
	
	li $v0, 10 #terminate program 
	syscall
	
	