#enter name and dispaly salem 'name'
.data
	msg:	 .asciz "Salam "
	ask:	 .asciz "enter your name : "
	buffer:  .space 100  			# Allocate 100 bytes for input
	
.global _start

.text

.macro print(%str)
	 li a7 , 4
	 la a0 , %str
	 ecall
.end_macro 

_start:
	 #asking to enter the name
	 print(ask)
	 #inputting the name
	 li a7,8 	   			#8 for string , 5 for int
	 la a0, buffer     			# Load address of buffer
	 li a1, 100       			# Max input size (100 bytes)
	 ecall
	 #outtputing the message
	 print(msg)
	 #outtputing the name
	 print(buffer)
	 #exit sys CALL
	 li a7 , 10
	 ecall
