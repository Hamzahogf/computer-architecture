#chack if  two integers are equal
.data
	prompt1: .asciz "enter 1st value : "
	prompt2: .asciz "enter 2nd value : "
	equal: .asciz "they are indeed equal"
	n_equal: .asciz "they are'not equal"
	
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
	 #ask for input
	 print(prompt1)
	 #read 1st value
	 read()
	 #save it in s0
	 mv s0 , a0
	 #ask for input 
	 print(prompt2)
	 #read 2nd value
	 read()
	 #save it in s1
	 mv s1 , a0
	 #cheking the equality
	 beq s0 , s1 , EQUAL
	  #print not equal
	 print(n_equal)
	 beqz zero , EXIT 		#goto to EXIT 
	 EQUAL:
	   #print eqaul
	   print(equal)
	 #exit sys
	 EXIT:
	 li a7 , 10
	 ecall
