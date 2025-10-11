.data
	promt: .asciz "enter the value : "
	final: .asciz "the final result here you go : "
	
.text

li a7 , 4
la a0 , promt
ecall

li a7 , 5
ecall

jal sum

EXIT:
    add s0 , a0 , zero

    li a7 , 4
    la a0 , final
    ecall

    li a7 , 1
    mv a0 , s0
    ecall

    li a7 , 10
    ecall


sum:
	li t0 , 1
	bne t0 , a0 , ELSE
	addi a0 , zero , 1
	jr ra
ELSE:
	addi sp , sp , -8
	sw ra , 4(sp)
	sw a0 , 0(sp)
	addi a0 , a0 , -1
	
	jal ra , sum
	addi t0 , a0 , 0
	
	lw ra , 4(sp)
	lw a0 , 0(sp)
	addi sp , sp,8
	
	add a0 , a0 , t0
	
	jr ra
