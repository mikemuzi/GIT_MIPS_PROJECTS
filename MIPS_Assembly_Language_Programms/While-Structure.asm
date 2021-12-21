				# Program1
				# Mziomukulu Mike Kumalo
				# WHILE structure
				
.data
	
	####### messages #######
	
	##array
	array:	.space	32
	
	comma_:	  .asciiz "," 
	newLine:  .asciiz "\n"
	message1: .asciiz "Enter the origin of your sequence: "
	message2: .asciiz "Enter your multiple factor: "
	message3: .asciiz "Enter the total number of the numbers: "
	checkSum: .asciiz "Check-sum: "
	
.text
.globl main  
   
main:
	
	##loopCounter
	li 	$s8, 0 
	
	##sum
	li	$s7, 0	
	
	##add_to
	li	$t3, 0
	
	
loop_01:

	##load bounds
		##lowerBound
			li	$s1,	1	
		##higherBound
			li	$s2,	5
			
	##load_OriginMessage
		li	$v0,	4
		la	$a0,	message1
		syscall
		
	##get_Sequence_origin
		li	$v0,	5			
		syscall
		
		move $t7,	$v0
		
	##compare_Userintput_to_bounds
	blt $t7,	$s1, loop_01
	bgt	$t7,	$s2, loop_01	
		
	##print_newLine
		li	$v0,	4
		la	$a0,	newLine
		syscall
		
loop_02:	
	
	##load_factor_bounds
		##lowerBound
			li	$s3,	2	
		##higherBound
			li	$s4,	7
		
	##load_factor_Message
		li	$v0,	4
		la	$a0,	message2
		syscall	
		
	##get_factor
		li,	$v0,	5
		syscall					##factor_being_added_to_originNum($t7 + $t8)
		move $t8,	$v0
		
	##compare_Userintput_to_bounds
	blt $t8,	$s3, loop_02
	bgt	$t8,	$s4, loop_02	
	
	
	##print_newLine
		li	$v0,	4
		la	$a0,	newLine
		syscall
		
loop_03:

##load_bounds
		##lowerBound
			li	$s5,	3	
		##higherBound
			li	$s6,	30	
	
##load_array_message
		li	$v0,	4
		la	$a0,	message3
		syscall
		
##get_arrayNum
		li	$v0,	5
		syscall
		move  $t9,	$v0
		
##compare_Userintput_to_bounds
	blt $t9,	$s5, loop_03
	bgt	$t9,	$s6, loop_03
	
##print_newLine
		li	$v0,	4
		la	$a0,	newLine
		syscall	

	
	
loop_04:
			
##print first number
		li $v0, 1
		move, $a0, $t7
		syscall

##print_comma	
		li	$v0,	4
		la	$a0,	comma_
		syscall	
		
	##addfactor
	add $s7, $t7,$t8
	
	move $t3, $s7
	
	add $t3, $t3,$t7
	##sum-t3-
	
	
	##increment_loop
	add $s8, $s8, 1
	
	##addsum
	##add $t5, $t9, $t4
	
while: 

##while_loopcounter_equals array_Num_end
##$t9 - array num_register
##$s8 - loop_counter___$s7 - sum
	
							
##otherwise_print_and increment
		li $v0, 1
		move, $a0, $s7
		syscall
		
##addfactor
	add $s7, $s7,$t8
	
##increment_loop
	add $s8, $s8, 1	
	
	##calculate_Sum
	##add $t5, $t3, $s7       ##creat new vairable for store previois add new value/ 
	
	beq $s8, $t9, loop_06	
	
	##print_comma	
		li	$v0,	4
		la	$a0,	comma_
		syscall
	add $t3, $t3, $s7
	
		j	while
			
loop_06:
	
	##print_newLine
		li	$v0,	4
		la	$a0,	newLine
		syscall
	
	##print_newLine
		li	$v0,	4
		la	$a0,	newLine
		syscall
	
	##print_Check_Sum
		li	$v0,	4
		la	$a0,	checkSum
		syscall
		
	##print_Sum
		li $v0, 1
		move, $a0, $t3
		
		syscall	
		
	j loop_09
	
##End_program	

loop_09:	
	jr $31	
