.data
promt: .asciz "enter a value : "
promt2: .asciz "i am here "

.text
li a7, 4
la a0, promt
ecall
li a7, 5
ecall
jal func
li a7, 10
ecall
func:
	 mv a1, a0
	 li a7, 4
	 la a0, promt2
	 ecall
	 
	 li a7, 1
	 mv a0, a1
	 ecall
	 
	 jr ra