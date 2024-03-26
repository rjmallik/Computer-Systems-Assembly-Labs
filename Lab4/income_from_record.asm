income_from_record:

	
        lw t2, 0(a0)

	li t3, 13#CR
	li t4, 10#TEN
	li t6,0 #SUM 
	#lbu a1, 0(t5)   	
	#addi t5, t5, 1		
loop: 
	
	lbu t5, 0(t2)		# a1 = *nextChar MACRO
	beq t5, t3, end   	#if you reach the CR character then branch out of the loop
	addi t5, t5, -48	# nextChar++; point to new nextChar
	mul t6, t6, t4		#Sum *= 10
	add t6, t6, t5		#sum += converted integer
	addi t2,t2,1
	j loop
end: 
# End your  coding  here!
	mv a0, t6 #return converted integers.
	ret
	
#######################end of income_from_record###############################################