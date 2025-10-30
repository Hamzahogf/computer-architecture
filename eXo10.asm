# These file is prepared by Student.Ahmed Fouatih Hamza Faiz,  Archi-2   winter-2025
# These program take an positive number x and calculate : x^5 + 6x^3 + 3x + 4. 



# defining the needed data
.data
	welecom:	.string "Welecom Back ."
	prompt:		.string "Enter a positive (+) number: "
	warning:	.string "We said positive not negative number !"
	result:		.string "The result of the expression is: "
	end:		.string "Thanks for using these program. "
	
	

# the main code	
.text
	#----------------get_ready-----------------
	# printing a string to the user console 
	.macro print_str(%str)
		li a7, 55
		la a0, %str
		li a1, 8
		ecall
	.end_macro
	
	# reading a num and printing a string
	.macro read_int(%str)
		li a7, 51
		la a0, %str
		ecall
	.end_macro
	
	# printing a warnign messg
	.macro print_warn(%str)
		li a7, 55
		la a0, %str
		li a1, 2
		ecall
	.end_macro
	
	# print a str followed by a num int
	.macro print_str_int(%str, %num)
		li a7, 56
		mv a1, %num
		la a0, %str
		ecall
	.end_macro
	
	# exit syscall
	.macro return()
		li a7, 10
		ecall
	.end_macro
	
	#------------------_start-------------------
	# salutation message
 	print_str(welecom)
	
	# ask the user to enter a number
 READ:	read_int(prompt)
	bltz a0, WARN			# in order to check if he enter a postive num or not (as in the assignment said)
	
	# call the function to calculate the expression mentioned
	jal exp
	
	# printing the value that will be in a0
	print_str_int(result, a0)
	
	# print end
	print_str(end)
	return
	
 WARN: # for handling if the user ener a negative int
 	print_warn(warning)
 	j READ
 	
 	
 	#----------------function implementations---------------
 exp:	# these function will calculate the x^5 + 6x^3 + 3x + 4. by calling 'pow' and 'times' func
 	# arguments: 
 	#	a0:	will contain the x (positive int) entered by the user
 	# return:
 	#	a0:	will contain the calculted value of the expression
 	
 	# Prologue
 	addi sp, sp, -4
 	sw ra, 0(sp)
 	
 	# calling power for x ^ 5,
 	li a1, 5
 	jal pow
 	
 	mv s0, a1	# hold the x ^ 5
 	
 	# clling power for x ^ 3
 	li a1, 3
 	jal pow
 	
 	mv s1, a0	# to save the a0
 	
 	# calling times for 6 x^3
 	mv a0, a1
 	li a1, 6
 	jal times
 	
 	add s0, s0, a1	# x^5 + 6x^3 
 	
 	# calling times for 3 x
 	li a1, 3
 	mv a0, s1
 	jal times
 	
 	add s0, s0, a1	# x^5 + 6x^3 + 3 x 
 	addi s0, s0, 4 # x^5 + 6x^3 + 3 x + 4
 	
 	mv a0, s0	# to set the result
 	
 	# Epilogue  
 	lw ra, 0(sp)
 	addi sp, sp, 4
 	
 	jalr  x0, 0(ra)	# go back to callee
 	
 
 		
 pow:	# these function will calculate the power of a numbrt
	# arguments:
	#	a0: number int positive
	#	a1: the power
	# return:
	#	a1: the result of the operation
	
	# copuing the a0
	mv t1, a0
	mv t2, a0
	
	# loop counter
	li t0, 1
	LOOP:
		bge t0, a1, OUT	# check if reached 
		
		mul t2, t2, t1  # the power computation
			
		addi t0, t0, 1
		j LOOP
	OUT:
		mv a1, t2	# put the result in a1
		jalr x0, 0(ra)	# go back to callee
		
		
		
 times: # these function will calculate the multiplication of a numbr 
	# arguments:
	#	a0: number int positive
	#	a1: the coefficient
	# return:
	#	a1: the result of the operation
	
	
	mul a1, a0, a1	# the operation
	jalr x0, 0(ra)	# back to callee
