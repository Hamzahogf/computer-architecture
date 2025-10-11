.data
	arr:	.word -12, 0, 2, 5, 15
	
.text
	
	la a0, arr
	addi a1, zero, 5
	jal ra, foo
	li a7, 1
	ecall
	li a7, 10
	ecall

foo:
	addi t1, zero, 1
	beq a1, zero, end
	beq a1, t1, end
	lw t2, 0(a0)
	LOOP:
		beq t1, a1, end
		addi a0, a0, 4
		lw t3, 0(a0)
		bgt t2, t3, bye
		add t2, zero, t3
		addi t1, t1, 1
		beq zero, zero, LOOP
	end:
		addi a0, zero, 1
		jalr ra
	bye:
		addi a0, zero, 0
		jalr ra
		