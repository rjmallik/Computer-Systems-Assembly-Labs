totalIncome:


	
	bnez a1, totalIncome_fileNotEmpty 
	li a0, 0
	ret
	
totalIncome_fileNotEmpty:
	
	li t0, 0#sum
	li t1, 0#loop Counter
	
	addi sp, sp, -8
	sd ra, 0(sp)
	
	addi t4, a0, 0
	
	addi t4, t4, 4
	
loop_TI: 
	
	bge t1, a1, exit_TI
	
	mv a0, t4
	
	addi sp, sp, -24
	sd t4, 0(sp)
	sd t0, 8(sp)
	sd t1, 16(sp)
	
	jal income_from_record
	
	ld t4, 0(sp)
	ld t0, 8(sp)
	ld t1, 16(sp)
	addi sp, sp, 24
	
	addi t4, t4, 8
	add t0, t0, a0
	addi t1, t1, 1
	
	j loop_TI 
# End your  coding  here!
exit_TI:
	addi a0, t0, 0
	ld ra, 0(sp)
	addi sp, sp, 8
	ret
#######################end of nameOfMaxIncome_totalIncome###############################################
