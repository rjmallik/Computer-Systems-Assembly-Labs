length_of_file:

	
#Start your coding here

	li a0, 0
	li t0, -1 # Counter
loop_LOF:
	lbu t1, 0(a1)
	
	addi t0, t0, 1
	beqz t1, end_LOF
	
	addi a1, a1, 1
	j loop_LOF
end_LOF:
	mv a0, t0 


#End your coding here
	
	ret
#######################end of length_of_file###############################################	
