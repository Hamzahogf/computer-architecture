#s = (a+b) - (c+101)
.data
	prompt1: .asciz "enter 1st value : "
	prompt2: .asciz "enter 2nd value : "
	prompt3: .asciz "enter 3rd value : "
	
.global _start

.text

.macro print(%str)
	 li a7 , 4
	 la a0 , %str
	 ecall
.end_macro 

.macro read()
	li a7 , 5
	ecall
.end_macro 

_start:
	#promt to enter value
 	print(prompt1)
 	#read the 1st value
	read()
	#save it in s0
	mv s0 , a0
	#promt to enter value b and read it 
	print(prompt2)
	#read 2nd value
	read()
	#save it in s1
	mv s1 , a0
	#promt to enter value c
	print(prompt3)
	#read 3rd value
	read()
	#save it in s2
	mv s2 , a0
	#claulte the value
	add t0 , s0 , s1
	addi t1 , s2 , 101
	sub s3 , t0 , t1
	#print the value
	li a7 , 1
	mv a0 , s3
	ecall
	#exit
	li a7 , 10
	ecall
