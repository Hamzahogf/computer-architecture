#----------------------------------------------------------------------------------------------------------------
# These file is prepared by Student.Ahmed Fouatih Hamza Faiz,  Archi-2   winter-2025
# These program imply quicksort for soring an array given in the data
#--------------------------------------------------------CHALANGE------------------------------------------------



# defining the needed data
.data
	welecom:	.string "Welecom Back .\n"
	array:		.word 	-1, 22, 8, 35, 5, 4, 11, 2, 1, 78
	result:		.string "The result of the quick sort is: \n"
	end:		.string "\nThanks for using these program. \n"
	line:		.string "\n"
	

# the main code
.text
	#----------------get_ready-----------------
	# printing a string to the user console 
	.macro print_str(%str)
		li a7, 4
		la a0, %str
		ecall
	.end_macro
	
	# printing a int to the user console 
	.macro print_int(%str)
		li a7, 1
		mv a0, %str
		ecall
	.end_macro
	
	# exit sys call
	.macro return()
		li a7, 10
		ecall
	.end_macro
	
	#------------------_start-------------------
	#print salutation
	print_str(welecom)
	print_str(result)
	
	# calle function
	la a0, array
	li a2, 9		# the len of the array
	jal qs
	
	# print end
	print_str(end)
	return
	
	
	#------------------------functions implementation----------------------
 qs:	# these function will sort an array assendingly
 	# arguments: 
 	#	a0:	address of the array's base
	#	a2:	lenfth of the array
	
	# prologue
	addi sp, sp, -4
	sw ra, 0(sp)
	
	# callling the quicksort
	li a1, 0
	#li a2, 9	# len of our array
	jal qicksrt
	
	# printing the array
	li t0, 0
	li t1, 10
	LOOP0:
		beq t0, t1, DONE
		
		slli t3, t0, 2
		add t3, t3, a0
		lw t3, 0(t3)
		
		mv s0, a0
		print_int(t3)
		print_str(line)
		mv a0, s0
		
		addi t0, t0, 1
		j LOOP0
		
	# Epilogue
  DONE:	lw ra, 0(sp)
 	addi sp, sp, 4
 	
 	jalr x0, 0(ra)
 	
 	
 	
qicksrt:# these function do the recursion part
	# argument:
	#	a0:	address of the array
	#	a1:	left int
	#	a2:	right int
	# return: 
	#	no return
	
	addi sp, sp, -20
	sw ra, 0(sp)
	sw a1, 4(sp)
	sw a2, 8(sp)
	sw a3, 12(sp)
	sw s0, 16(sp)
	
	bge a1, a2, OUT
	# calle partion
	jal partition
	
	mv s0, a2
	addi a2, a3, -1
	jal qicksrt
	mv a2, s0
	addi a1, a3, 1
	jal qicksrt
	
	 
  OUT:	lw ra, 0(sp)
	lw a1, 4(sp)
	lw a1, 8(sp)
	lw a3, 12(sp)
	lw s0, 16(sp)
	addi sp, sp, 20
	jalr x0, 0(ra)
	
	
 partition: # these function make the swapping base on the pivot
 	    # arguments:
 	    #		a0: address of array
 	    #		a1: left
 	    # 		a2: right
 	    # return:
 	    #		a4: i + 1
 	    
 	    # pivot = a[right]
 	    slli t0, a2, 2
 	    add t0, t0, a0
 	    lw  t0, 0(t0)
 	    
 	    # i = left - 1
 	    addi t1, a1, -1
 	    
 	# j = left
 	addi t2, a1, -1
 	addi s1, a2, -1
 	LOOP:
 		addi t2, t2, 1
 		bgt t2, s1, OUT0
 		
 		#load a[j]
 		slli t4, t2, 2
 		add t4, t4, a0
 		mv t5, t4
 		lw t4, 0(t4)
 		
 		bgt t4, t0, LOOP
 		addi t1, t1, 1
 		
 		# swap a[i] a[j]
 		#load a[i]
 		slli t6, t1, 2
 		add t6, t6, a0
 		mv t3, t6
 		lw t6, 0(t6)
 		
 		sw t4, 0(t3)
 		sw t6, 0(t5)
 		
 		j LOOP
 	OUT0:
 		# swap a[i+1], a[right]
 		addi t2, t1, 1
 		slli t2, t2, 2
 		add t2, t2, a0
 		mv t3, t2
 		lw t2, 0(t2)
 		
 		slli t4, a2, 2
 		add t4, t4, a0
 		mv t5, t4
 		lw t4, 0(t4)
 		
 		sw t2, 0(t5)
 		sw t4, 0(t3)
 		
 		addi a3, t1, 1
 		jalr x0, 0(ra)
