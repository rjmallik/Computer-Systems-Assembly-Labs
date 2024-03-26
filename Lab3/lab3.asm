.macro exit #macro to exit program
	li a7, 10
	ecall
	.end_macro	

.macro print_str(%string1) #macro to print any string
	li a7,4 
	la a0, %string1
	ecall
	.end_macro
	
.macro read_n(%x)#macro to input integer n into register x
	li a7, 5
	ecall 		
	#a0 now contains user input
	addi %x, a0, 0
	.end_macro
	
.macro 	file_open_for_write_append(%str)
	la a0, %str
	li a1, 1
	li a7, 1024
	ecall
.end_macro
	
.macro  initialise_buffer_counter
	#buffer begins at location 0x10040000
	#location 0x10040000 to keep track of which address we store each character byte to 
	#actual buffer to store the characters begins at 0x10040008
	
	#initialize mem[0x10040000] to 0x10040008
	addi sp, sp, -16
	sd t0, 0(sp)
	sd t1, 8(sp)
	
	li t0, 0x10040000
	li t1, 0x10040008
	sd t1, 0(t0)
	
	ld t0, 0(sp)
	ld t1, 8(sp)
	addi sp, sp, 16
	.end_macro
	

.macro write_to_buffer(%char)
	
	
	addi sp, sp, -16
	sd t0, 0(sp)
	sd t4, 8(sp)
	
	
	li t0, 0x10040000
	ld t4, 0(t0)#t4 is starting address
	#t4 now points to location where we store the current %char byte
	
	#store character to file buffer
	li t0, %char
	sb t0, 0(t4)
	
	#update address location for next character to be stored in file buffer
	li t0, 0x10040000
	addi t4, t4, 1
	sd t4, 0(t0)
	
	ld t0, 0(sp)
	ld t4, 8(sp)
	addi sp, sp, 16
	.end_macro

.macro fileRead(%file_descriptor_register, %file_buffer_address)
#macro reads upto first 10,000 characters from file
	addi a0, %file_descriptor_register, 0
	li a1, %file_buffer_address
	li a2, 10000
	li a7, 63
	ecall
.end_macro 

.macro fileWrite(%file_descriptor_register, %file_buffer_address,%file_buffer_address_pointer)
#macro writes contents of file buffer to file
	addi a0, %file_descriptor_register, 0
	li a1, %file_buffer_address
	li a7, 64
	
	#a2 needs to contains number of bytes sent to file
	li a2, %file_buffer_address_pointer
	ld a2, 0(a2)
	sub a2, a2, a1
	
	ecall
.end_macro 

.macro print_file_contents(%ptr_register)
	li a7, 4
	addi a0, %ptr_register, 0
	ecall
	#entire file content is essentially stored as a string
.end_macro
	


.macro close_file(%file_descriptor_register)
	li a7, 57
	addi a0, %file_descriptor_register, 0
	ecall
.end_macro

.data	
	prompt: .asciz  "Enter the height of the pattern (must be greater than 0):"
	invalidMsg: .asciz  "Invalid Entry!"
	newline: .asciz  "\n" #this prints a newline
	star: .asciz "*"
	blankspace: .asciz " "
	outputMsg: .asciz  " display pattern saved to lab3_output.txt "
	filename: .asciz "lab3_output.txt"

.text

	file_open_for_write_append(filename)
	#a0 now contaimns the file descriptor (i.e. ID no.)
	#save to t6 register
	addi t6, a0, 0
	
	initialise_buffer_counter
	
	#for utilsing macro write_to_buffer, here are tips:
	#0x2a is the ASCI code input for star(*)
	#0x20  is the ASCI code input for  blankspace
	#0x0a  is the ASCI code input for  newline (/n)

	
	#START WRITING YOUR CODE FROM THIS LINE ONWARDS
	#DO NOT  use the registers a0, a1, a7, t6, sp anywhere in your code.
	
	#................ your code here..........................................................#
#PSEUDOCODE:
#Main:
#	print prompt and then get the user input
#	if the input is less than zero or equal to zero, jump to I1
#	Load registers to have a lower bound for the loop 
#
#Loop_Head:
#	Branch to loop_end if the loop iterator is greater than or equal to user input
#	for every iteration of loop_head jump to loop_head 2
#Loop_head2:
#	Branch if iterator for loop_head2 is greater than or equal to the iterator for the first loop head (this will create a nested loop)
#	redirect code to either stars intruction or spaces 
#Spaces: 
#	print spaces
#	incremenet the loop_2 iterator and loop back to loop_head2
#
#Stars: 
#	print stars
#	increment the loop_2 iterator and loop back to loop_head2
#I1:		
#	print invalid string message+newline and jump back to the top of main
#
#Loop_head2_end:
#	incremenet the loop_head iterator, print a newline and jump back to the top of loop_head
#
#loop_end:
#	continue
#
j main
I1:
	print_str(invalidMsg)
	print_str(newline)
	j main
main:
	print_str(prompt)
	read_n(t1)#get the user input. 
	
	li t0, 0#set the lower bound for the loop. 	
	beqz t1, I1
	bltz t1, I1
	li t3, 0
	addi t3, t1, 0
	addi t3, t3, -1
	li t4, 0
	addi t4, t1, 0
	addi t4, t4, 1
	
	loop_head:
		bge t0, t1, loop_end
		li t2, 0
		j loop_head2
	loop_head2: 
		bge t2, t4, loop_head2_end
		beqz t2, stars
		beq, t2, t0, stars
		beq, t0, t3, stars
		j spaces
	stars: 
		addi t2, t2, 1
		bge t2, t4, loop_head2_end
		print_str(star)
		write_to_buffer(0x2a)
		j loop_head2
	spaces: 
		print_str(blankspace)
		write_to_buffer(0x20)
		addi t2, t2, 1
		j loop_head2
	loop_head2_end:
		print_str(newline)
		write_to_buffer(0x0a)
		addi t0, t0, 1
		j loop_head
	loop_end:
	
	#Then should create the file, and write to the file. 
	
	#END YOUR CODE ABOVE THIS COMMENT
	#Don't change anything below this comment!
	
	#write null character to end of file
	write_to_buffer(0x00)
	
	#write file buffer to file
	fileWrite(t6, 0x10040008,0x10040000)
	addi t5, a0, 0
	
	print_str(newline)
	print_str(outputMsg)
	
	exit