#--------------------------------------------------------------------------------------------------
# @Copy right preserved by Student.Ahmed Fouatih Hamza Faiz,  Arcitecture-2  winter 2025    lab 7
# These program create a an array in int if size 10, and asks the user to input its element
# and then it sums all them and output the result
#---------------------------------------------------------------------------------------------------


.data
	array: .word 0:10
	prompt: .string "Enter the number: "
	result: .string "Theire sum is: "
	
.text
	
	li t0, 0	# act as counter
	li t1, 10	# act as bound
	la t2, array	# hold the base addresse initially
	li s0, 0	# act as summer for the elments
	
	LOOP1:
		bge t0, t1, LOOP2
		
   		# prompt user for input
    		li a7, 51
   		la a0, prompt
   		ecall
    
		# stroring the elment
		sw a0, 0(t2)
		
		# update the address of the newt elment, as well as idex
		addi t2, t2, 4
		addi t0, t0, 1
		
		j LOOP1

	LOOP2:
		blez t0, EXIT
		
		# update the address, index
		addi t2, t2, -4
		addi t0, t0, -1
		
		# load the elment from array[10] until array[0]
		lw t3, 0(t2)
		
		# add to the result
		add s0, s0, t3
		
		j LOOP2
		
	EXIT:
   		# output the result
   		li a7, 56
   		la a0, result
   		mv a1, s0
   		ecall

		# exit syscall
		li a7, 10
		ecall