#--------------------------------------------------------------------------------------------------
# @Copy right preserved by Student.Ahmed Fouatih Hamza Faiz,  Arcitecture-2  winter 2025    lab 7
# program that allocates an n×n array of integers on the heap, where n is a user input,
# then compute and print the value of each element in the a special way (indicated by the lab sheet).
#---------------------------------------------------------------------------------------------------

.data
	welecom: .string "========================================MATRIX SQUARED====================================================\n"
	prompt:  .string "Enter the size of the squared matrix: "
	space:   .string " "
	line:    .string "\n"
	end:     .string "===============================================================================================================\n"
	
.global _start

.text

#defining some needed macros
.macro print_str(%str)
	 li a7 , 4
	 la a0 , %str
	 ecall
.end_macro 

.macro print_int(%reg)
    li a7 , 1
    mv a0, %reg 
    ecall
.end_macro

.macro read_int()
	li a7 , 5
	ecall
.end_macro 

.macro sbrk(%bytes)
	li a7, 9
	mv a0, %bytes
	ecall
.end_macro

# main code
_start:
	
	# print salutation, as well as the size of the matrix
	print_str(welecom)
	print_str(prompt)
	read_int()
	
	# for holding the number of bytes
	li t0, 4
	
	# compute the total bytes needed for our matrix
	mul t1, a0, a0
	mul t1, t1, t0
	
	# savign the value of n ( will be needed in the loops
	mv t2, a0
	
	# allocate the heap
	sbrk(t1)
	
	# store the base address
	mv s0, a0
	
	# setting up some counters t0:=i, t1:=j, t2:=n
	li t0, 0
	li t5, 4
	
	LOOP1:
		bge t0, t2, EXIT
		
		li t1, 0 # j = 0
		
		LOOP2:
			bge t1, t2, NEXT
			
			# t3:= i + j
			add t3, t0, t1 
			
			# compute the address
			mul t4, t0, t2	        # i * n
			add t4, t4, t1		# i * n + j
			mul t4, t4, t5		# (i * n + j) * 4
			add t4, t4, s0		# &base + (i * n + j) * 4
			
			# store the number
			sw t3, 0(t4)
			
			blez t0, ONE_
				# compute the address of  m[i-1][j]
				mul t6, t2, t5          # t6:= n * 4
				sub t6, t4, t6  	# t6:= t4 - t6 (i.e &base + (i * n + j) * 4  - n * 4)
				
				# load the content
				lw t6, 0(t6)
				
				# m[i][j] + m[i-1][j]
				add t3, t3, t6
				
				# store it
				sw t3, 0(t4)				
		ONE_:	blez t1, TWO_
				# compute the address of m[i][j-1]
				sub t6, t4, t5		# t6:= t4 - t5 (i.e &base + (i * n + j) * 4  - 4)
				
				# load the content
				lw t6, 0(t6)
				
				# m[i][j] + m[i][j-1]
				add t6, t6, t3
				
				# store it
				sw t6, 0(t4)	

		TWO_:	
				# load the content of m[i][j]
				lw t6, 0(t4)
				
				# print the value,as well as: " "
				print_int(t6)
				print_str(space)
				
				# update the counter of j (t1)
				addi t1, t1, 1
				j LOOP2
		NEXT:
			# go to new line
			print_str(line)
			
			# for updating the counter i (t0)
			addi t0, t0, 1
			j LOOP1
	EXIT:
		# print end
		print_str(end)
		
		# exit syscall
		li a7, 10
		ecall