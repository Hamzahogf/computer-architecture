#copy right: Student.AHMED FOUATIH HAMZA FAIZ.   course : ARCHITECUR-2  LAB-6 ,  year: 2024-2025        
#the programe for : cellcuse <-> fernhite ; binary <-> decimal
#make sure to read the comments are very usefull as they are many
#HAPPY RAMADAN


#string is an alias for asciz
.data
	program_welcom: .string "==================================CONVERTER PROGRAM===================================\nDo you want : \n 1-tempurator convertor \n 2-number system convertor" 
	program_menu: 	.string "Do you want : \n 1-tempurator convertor \n 2-number system convertor \n"
	answer: 	.string "enter its index : "
	answer_:	.string "put the number :  "
	result: 	.string "it is : "
	warning:	.string "RE-ENTER A VLID INDEX  !!!\n"
	replay:		.string "Do you wish to display the menu again [y/n] ? : "
	end:		.string "======================================================================================\n"
	temp_welecom: 	.string "==================================TEMPURATOR CONVERTOR================================\n"
	temp_menu: 	.string "do you want : \n 1-Celsius to Fahrenheit  \n 2-Fahrenheit to Celsius \n"
	temp_const1: 	.float 1.8
	temp_const2: 	.float 32.0
	temp_f: 	.string " 'F .\n"
	temp_c: 	.string " 'C .\n"
	point:		.string " .\n"
	num_welecom:	.string "=================================SYSTEM NUMBER CONVARTOR===============================\n"
	num_menu:	.string "do you want : \n 1-binary to decimal \n 2-decimal to binary \n"
	num_const:	.byte 2
	buffer:		.space 2  	#(1 char + '\0')
	y:		.string "y"
	Y:		.string "Y"

				
.global _start


.text

#defining some needed macros
.macro print(%str)
	 li a7 , 4
	 la a0 , %str
	 ecall
.end_macro 

.macro print_float(%reg)
    li a7 , 2
    fmv.s fa0, %reg 
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

.macro read_float()
	li a7, 6
	ecall
.end_macro

.macro read_string()
	li a7 , 63
        li a0, 0           # File descriptor 0 (stdin)
        la a1, buffer      # Load address of buffer
        li a2, 2           # Max bytes to read (including '\0')
	ecall
.end_macro


#main program 
_start:
	#salutation
	li a7 , 51
	la a0 , program_welcom
	ecall
	
	#display the menu
	MENU:
		li a7 , 55
		blez a0 , MSG
		la  a0 , program_menu
		li a1  , 1
		ecall
		li a7 , 10
		ecall
		print(answer)
		
		#read the value
		read_int()
		
		#check if valid index
		li t0 , 2		
		bgt a0 , t0 ,MSG
		blez a0 ,MSG
		
		beq a0 , t0 , NUM
	TEMP:
		#menu
		print(temp_welecom)
	TEMP1:	print(temp_menu)
		print(answer)
		
		#read the index
		read_int()
		
		#chekc if valid index or no ; do not forget t0 := 2
		ble a0 , zero , MSG1
		bgt a0 , t0 , MSG1
		
		mv a1 , a0
		
		#read the value
		print(answer_)
		read_float()
		jal ra , TEMPURATOR
		beqz zero , END
		
	NUM: 	
		#menu
		print(num_welecom)
	NUM1:	print(num_menu)
		print(answer)
		
		#read the index
		read_int()
		
		#chekc if valid index or no ; do not forget t0 := 2
		ble a0 , zero , MSG2
		bgt a0 , t0 , MSG2
		
		#to save it in a1
		mv a1 , a0
		
		#read the value
		print(answer_)
		read_int()
		jal ra , NUMBER
		beqz zero , END
		
	MSG:
		#print msg to ask to enter a valid number from the program menu ; then go back to menu
		la a0 , warning
		li a1 , 2
		ecall
		beqz zero , MENU
		
	MSG2:
		#print warning and goto again to NUM
		print(warning)
		j NUM1
		
	MSG1:
		#print warning and goto again to NUM
		print(warning)
		j TEMP1
				
	END:	
		#ask the user if he want to re-run the program 
		print(replay)
		read_string()
		#load addresses of y and Y and of buffer ; and their content
		la t0 , y
		lb t0 , 0(t0)	
		la t1 , Y 
		lb t1 , 0(t1)
		la a0 , buffer
		lb a0 , 0(a0)
		
		#if enter y or Y so goto menu ; else any char enterd will out the program
		beq a0 , t0 , MENU
		beq a0 , t1 , MENU
		
		#exit sys call
		li a7 , 10
		ecall
		
		
		


#tempurator convertor procedure
TEMPURATOR:
#a0 will have the index of the menu
#fa0 will have the floating value that will be converted

	#check : c to f , f to c
	li t0 , 1
	beq a1 , t0 , CELS_FAHR

	#fehr => cel
	FAHR_CELS:
		#load addresses of 1.8 and 32.0 ; then load their values into ft0 and ft2 (resp.)
		la t0 , temp_const1
		flw ft0 , 0(t0)
		la t1 , temp_const2
		flw ft2 , 0(t1)
		
		#caluclte f - 32 ; then divide by 1.8
		fsub.s fs0 , fa0 , ft2
		fdiv.s fs0 , fs0 , ft0
		
		#print the result
		print(result)
		print_float(fs0)
		print(temp_c)
		
		#exit
		beqz zero , BACK
		
	#cel => fehr
	CELS_FAHR:
		 #load addresses of 1.8 and 32.0 ; then load their values into ft0 and ft2 (resp.)
		 la t0 , temp_const1
		 flw ft0, 0(t0)
		 la t1 , temp_const2
		 flw ft2 , 0(t1)
		
		 #calculate the c * 1.8 then add 32.0
		 fmul.s fs0 , fa0 , ft0
		 fadd.s fs0 , fs0 , ft2
		 
		 #print the result
		 print(result)
		 print_float(fs0)
		 print(temp_f)
	
	BACK: 
		#print end ; go back to caller 
		print(end)
		jalr zero , 0(ra)



	 
#system number converot procedur
NUMBER:
#a1 will have the index from the menu
#a0 will have the value to be conerted

	#check : b to d ; d to b
	addi t0 , zero , 1
	beq a1 , t0 , BINR_DECM
	
	#decimal => binary
	DECM_BINR:
		 #s0 will have the num ; t2 := 2 ; t1 :=0 ; t3 !=0 will be used to keep track the number of bits
		 mv s0 , a0
		 la t2 , num_const
		 lb t2 , 0(t2)
		 li t1 , 0
		 li t3 , 0
		 print(result)
		 beqz s0 , ZERO_
		 LOOP1:
		 	# calculate the num / 2  and update num%=2
			beq s0 , zero , PRINT__
			rem t1 , s0 , t2
			div s0 , s0 , t2
			
			# Push t1 onto the stack ; and upate the pointer sp ; because i will need to traverse from the inverse 
			sw t1, 0(sp)         
    			addi sp, sp, -4  
    			            
			addi t3, t3, 1       # Increment bit counter
			
			#loop again
			j LOOP1
			
		 PRINT__:	
		  	# Now, print the bits from MSB to LSB by popping from the stack
			beqz t3, BACK_  
			
			# Increment sp by 4 (move to the previous stack position)
	       		addi sp, sp, 4 
	       		
	       		# Load the bit from the stack into t1 ; and print it 
         		lw t1, 0(sp)  
       			print_int(t1)     
       			
       			# Decrement bit counter; and loop again
       			addi t3, t3, -1   
			j PRINT__
		ZERO_:
			#print
			print_int(zero)
			j BACK_
			
	#binary => decimal
	BINR_DECM:
		#s0 := num ;t0 is already intilized to 1 (it will play the role of the puissance ) and s1 :=0 
		mv s0 , a0
		addi t2 , zero , 10
		li s1 , 0
		LOOP2:
	   		beqz s0 , PRINT_
	   		
	   		#apply the simple algorithm 
	   		rem t1 , s0 , t2
	   		div s0 , s0 , t2
	   		
	   		#update t1 , and add s1 := s1 + t1
	   		mul t1 , t1 , t0
	   		add s1 , s1 , t1
	   		 
	   		#multply t0 by 2
	   		slli t0 , t0 , 1
	   		
	   		#loop again
	   		j LOOP2
	   	
	  	PRINT_:
	  		print(answer)
	  		print_int(s1)
	  		j BACK_
	BACK_:
	   #back to the caller
	   print(point)
	   print(end)
	   jalr zero , 0(ra)
