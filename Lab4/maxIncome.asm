maxIncome:

	
	bnez a1, maxIncome_fileNotEmpty # minIncome function
	li a0, 0
	ret

 maxIncome_fileNotEmpty:
	li t0, 0
	li t1, 0
	
	addi sp, sp, -8
	sd ra, 0(sp)
	
	addi t4, a0, 0
	
	addi t4, t4, 4
	
	
	
	beqz t1, firstValueM
	
loop_MAI: 
	bge t1, a1, exit_MAI 
	
	mv a0, t4
	
	addi sp, sp, -32
	sd t0, 0(sp)
	sd t1, 8(sp)
	sd t3, 16(sp)
	sd t4, 24(sp)
	
	jal income_from_record
	

	ld t0, 0(sp)
	ld t1, 8(sp)
	ld t3, 16(sp)
	ld t4, 24(sp)
	addi sp, sp, 32
	
	bgt a0, t0, max_adjustment
	

	addi t4, t4, 8
	addi t1, t1, 1

	j loop_MAI
	
firstValueM: 
	mv a0, t4
	
	addi sp, sp, -32
	sd t0, 0(sp)
	sd t1, 8(sp)
	sd t3, 16(sp)
	sd t4, 24(sp)
	
	jal income_from_record
	

	ld t0, 0(sp)
	ld t1, 8(sp)
	ld t3, 16(sp)
	ld t4, 24(sp)
	addi sp, sp, 32
	
	addi t3, t4, -4
	addi t0, a0, 0
	j loop_MAI

max_adjustment: 
	mv t0, a0
	addi t3, t4, -4
	addi t4, t4, 8
	addi t1, t1, 1
	j loop_MAI
exit_MAI:
	
	mv a0, t3
	ld ra, 0(sp)
	addi sp, sp, 8
	ret
#######################end of minIncome###############################################
