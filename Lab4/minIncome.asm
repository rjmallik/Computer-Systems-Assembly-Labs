minIncome:


	
	bnez a1, minIncome_fileNotEmpty 
	li a0, 0
	ret

 minIncome_fileNotEmpty:
	li t0, 0
	li t1, 0
	
	addi sp, sp, -8
	sd ra, 0(sp)
	
	addi t4, a0, 0
	addi t4, t4, 4
	
	
	
	beqz t1, firstValue
	
loop_MI: 
	bge t1, a1, exit_MI 
	
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
	
	blt a0, t0, min_adjustment
	
	
	addi t4, t4, 8
	addi t1, t1, 1

	j loop_MI
	
firstValue: 
	mv a0, t4
	
	addi sp, sp, -32
	sd t0, 0(sp)
	sd t1, 8(sp)
	sd t3, 16(sp)#STACK STUFF , adding to stack and removing
	sd t4, 24(sp)
	
	jal income_from_record

	ld t0, 0(sp)
	ld t1, 8(sp)
	ld t3, 16(sp)
	ld t4, 24(sp)
	addi sp, sp, 32
	
	addi t3, t4, -4
	addi t0, a0, 0
	j loop_MI

min_adjustment: 
	mv t0, a0
	addi t3, t4, -4
	addi t4, t4, 8
	addi t1, t1, 1
	j loop_MI
exit_MI:
	
	mv a0, t3
	ld ra, 0(sp)
	addi sp, sp, 8
	ret
#######################end of minIncome###############################################
