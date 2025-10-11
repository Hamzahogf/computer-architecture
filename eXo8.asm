#----------------------------------------------------------------------------------------------------------------
# These lab file is prepared by (@Copy right) Student.Ahmed Fouatih Hamza Faiz  ,  ACHITECTURE-2  winter-2025
# These program display the #C and #G and the length of the string in the file dna.txt
#----------------------------------------------------------------------------------------------------------------

.data
	dna: 	  .asciz "dna.txt"
	welecom:  .string "Welecom Back !!"
	buffer:	  .space 1000
	warning:  .string "Issues in opening/reading the file !!"
	resultC:  .string "Number of 'C' in the dna.txt is: "
	resultG:  .string "Number of 'G' in the dna.txt is: "
	resultL:  .string "The length of the file dna.txt is: "
	end:	  .string "Good Luck !!"

		
.text
	#----------------get_ready-----------------
	# these macro will be needed when diplaying the results
	.macro print_inf(%string, %int)
		li a7, 56
		la a0, %string
		mv a1, %int
		ecall
	.end_macro
	
	.macro print_str(%string)
		li a7, 55
		la a0, %string
		ecall
	.end_macro
	
	.macro return()
		li a7, 10
		ecall
	.end_macro
	
	#------------------_start-------------------
	# salutation msg
	li a1, 5     			# just to handle the argument of 55 (other mode)
	print_str(welecom)

	# open file 'r mode'
	li a7, 1024
	la a0, dna
	li a1, 0
	ecall
	
	# to catch if error with opening file
	bltz a0, ERROR
	
	# save file descriptor for closing the file later
	mv s1, a0
	
	# read it in the buffer
	li a7, 63
	la a1, buffer
	li a2, 1000
	ecall

	# to catch if error with opening file
	bltz a0, ERROR
	
	# number of bytes to read
	mv s0, a0

	# closing the file
	li a7, 57
	mv a0, s1
	ecall
	
	# counting number of t1 = C, t2 = G , t0 = length of the string
	li t1, 0
	li t2, 0
	
	# ininit the counter 
	li t0, 0
	
	LOOP:	
		bge t0, s0, OUT
		
		# load the current char since is an array 
		la t3, buffer
		add t3, t3, t0
		lbu t3, 0(t3)
		
		# check if C
		li t4, 'C'
		beq t3, t4, C
		
		# check if G
	COND1:	li t4, 'G'
		beq t3, t4, G
		
		# next iter
	COND2:	addi t0, t0, 1
		j LOOP
		
		
	C:	# increment t1 (i.e the counter of C)	
		addi t1, t1, 1
		j COND1
		
	G:	# increment the t2 (i.e the counter of G)
		addi t2, t2, 1
		j COND2
		
	OUT:
		# diplay the length, C, G
		print_inf(resultL, s0)
		print_inf(resultC, t1)
		print_inf(resultG, t2)
		
		# display end
		li a1, 4     			# just to handle the argument of 55 (msg mode)
		print_str(end)
		
		# exit sys call
		return

	ERROR:
		# diplay the error, then exit
		li a1, 2 			# just to handle the argument of 55 (warning mode)
		print_str(warning)
		return
		
