#----------------------------------------------------------------------------------------------------------------
# These lab file is prepared by (@Copy right) Student.Ahmed Fouatih Hamza Faiz  ,  ACHITECTURE-2  winter-2025
# These program copy an input text file into an output file.
#----------------------------------------------------------------------------------------------------------------



#***************************************************
# check if the user must enter .txt !important 
#***************************************************




.data
	ask_file_output:	 .string "Enter the file name.txt to be copied in: "
	buffer0: .space  800
	buffer2: .space  800
	warning: .string "Error in opening the file,\n TRY TO ADD AT THE END '.txt' in the input file."
	salut: .string "GOOD MORNING MISS."
	end:	 .string "succeffuly copied the file."
	ask_file:	 .string "Enter the file name.txt to be copied: "
	buffer3: .space  800
	
.text
	#----------------get_ready-----------------
	# these macro will be needed when diplaying the results
	.macro print(%string)
		li a7, 55
		la a0, %string
		ecall
	.end_macro
	
	# print and read a string from the user
	.macro print_read(%string, %buffer)
		li a7, 54
		la a0, %string
		la a1, %buffer
		li a2, 800
		ecall
	.end_macro
	
	# exist syscall
	.macro exit()
		li a7, 10
		ecall
	.end_macro
	
	# open file
	.macro open_file(%buffer)
		li a7, 1024
		la a0, %buffer
		ecall
	.end_macro
	
	# read it in the buffer
	.macro read_file(%buffer)
		li a7, 63
		la a1, %buffer
		li a2, 800
		ecall
	.end_macro
	
	# write to a file
	.macro write_file(%decriptor, %buffer)
		li a7, 64
		mv a0, %decriptor
		la a1, %buffer
		li a2, 800
		ecall
	.end_macro
	
	# close a file
	.macro close_file(%decriptor)
		li a7, 57
		mv a0, %decriptor
		ecall
	.end_macro
	


	#------------------_start------------------- 
	li a1, 4     			# just to handle the argument of 55 (msg mode)
	print(salut)		# print salutaion
	
	
	print_read(ask_file , buffer0)  # get the file name, input
	la a0, buffer0			# for argument for remove func	 
	jal ra , clenear			# Remove newline at the end of buffer1
	
	
	li a1, 0		 	# read only mode
	open_file(buffer0)		# open file 'r mode', 
	bltz a0, ERR			# and then check if any error
	mv s0, a0			# save file descriptor for closing the file later
	
	read_file(buffer2)		# read it in the buffer, and check if any error
	bltz a0, ERR			# and then check if any error
	
	close_file(s0)			# close the file
	
	print_read(ask_file_output, buffer3)  # get the file name, output
	la a0, buffer3			# for argument for remove func	 
	jal ra , clenear			# Remove newline at the end of buffer1
		
	
	li a1, 1			# if write-only with create,
	open_file(buffer3)		# opening a file
	mv s0, a0			# save file descriptor for closing the file later
		
	write_file(s0, buffer2)		# writing to a file
		
	close_file(s0)			# close the file
	
	li a1, 1			# just to handle the argument of 55 (inf mode)
	print(end)
	exit
	
	ERR:
		li a1, 2 			# just to handle the argument of 55 (warning mode)
		print(warning)		# diplay the error, then exit
		exit
		
	
					
	clenear:
		#----------------func1-----------------
		# these function will replace '\n' with null terminator
		# a0 = buffer
	
		mv t0, a0     			 # t0 points to buffer1
		li t1, 0
		li t3, 10
	
		LOOP:
  	  		lbu t2, 0(t0)
  			beq t2, t3, replace_with_zero   # 10 is ASCII code for '\n'
 	 		beq t2, zero, done             # end of string
 	  		addi t0, t0, 1
 	 		j LOOP

		replace_with_zero:
 	  	 	sb zero, 0(t0)   		# replace '\n' with null terminator
		
		done:
			jalr zero, 0(ra) 
