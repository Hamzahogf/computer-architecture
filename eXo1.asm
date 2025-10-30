#enter a number i and output msg i time
.data
	prompt: .asciz "enter a number : " 
	msg:    .asciz "Salem\n" 
	
.global _start

.text
_start:
	#promt to "enter a value"
	li a7 , 4
	la a0 , prompt
	ecall
	#get the value
	li a7 , 5
	ecall
	#move
	mv s0 , a0
	#looping to execute
	LOOP:
	  blez s0 , EXIT 		#checking if s0 == 0 else exit
	  li a7 , 4			#load the print sys call
	  la a0 , msg 			#load address
	  ecall
	  addi s0 , s0 ,-1
	  beqz zero , LOOP		#goto LOOP ; j LOOP
	EXIT:
	#exit sys call
	 li a7 , 10			
	 ecall  
