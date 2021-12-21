				# Program1
				# Mziomukulu Mike Kumalo
				# If-then structure

.data

	###testMessages
	test1: .asciiz "greater than "
	test2: .asciiz "less than "
	
	####### messages #######
	newLine:  .asciiz "\n"
	message1: .asciiz "Enter your current driving speed in MPH(1 to 200 MPH): "
	message2: .asciiz "Enter the absolute speed limit specified for the road you are currently running on (15 to 70): "
	
	####### invalid_messages #######
	invalid_M1: .asciiz "You made an invalid input for your current driving speed. Enter a valid input for your current driving speed.\n"
	invalid_M2: .asciiz "You made an invalid input for the absolute speed limit. Enter a valid input for the speed limit.\n"
	
	####### valid_message #######
	valid_M:	.asciiz "You are a safe driver!"
	
	####### penalty_messages #######
	
	penalty_message1:	.asciiz "$120 fine"
	penalty_message2:	.asciiz "$140 fine"
	penalty_message3:	.asciiz "Class B misdemeanor and carries up to six months in jail and a maximum $1,500 fines"
	penalty_message4:	.asciiz "Class A misdemeanor and carries up to one year in jail and a maximum $2,500 fines"
	
	
.text
.globl main  
   
main:

loop_01:

	###load bounds currentSpeed(1-200)
		##lowerBound
			li	$s1,	1	
		##higherBound
			li	$s2,	200	
			
	###load message ask userFor current speed
	li	$v0,	4							
	la	$a0,	message1
	syscall
	
	###Get current driving speed from user
	li	$v0,	5
	syscall
		
	move	$t0,	$v0     ##########a-59-63
	
	###conditionalBranches
	blt $t0,	$s1, loop_01_01
	bgt	$t0,	$s2, loop_01_01	
	
	j	loop_02	

###print_invalid_Speed_Message
loop_01_01:		
	li	$v0,	4
	la	$a0,	invalid_M1
		syscall	
	j loop_01	
	
###print_newLine
		li	$v0,	4
		la	$a0,	newLine
		syscall	
		
#############################################################################
	
loop_02:	

	###load bounds AbsoluteSpeed(15-70)
		##lowerBound
			li	$s3,	15	
		##higherBound
			li	$s4,	70	
				
		
	###load message_ask_userFor absoluteSpeed
	li	$v0,	4	
	la	$a0,	message2						
	syscall
	
	
	###Get absoluteSpeed from user
	li	$v0,	5    
	syscall
	
	move	$t1,	$v0
	
	###conditionalBranches
	blt $t1,	$s3, loop_01_02
	bgt	$t1,	$s4, loop_01_02
	j	loop_03
	
loop_01_02:	
###print_invalid_Speed_Message	
	li	$v0,	4
	la	$a0,	invalid_M2
		syscall	
	j loop_02	

#############################################################################

loop_03:
##CalculateFines

	sub $t4, $t0, $t1
	
	##create new bounds
	##bounds_(0-20)
	li	$t8,0
	li	$t2, 21
	
	##bounds_(21-25)
	li	$t5, 26
	
	##bound_(26-34)
	
	li	$t6, 34
	##bounds_(>35)
	li	$t7, 35
	
	
	##move $s5, $t4
	##li $v0, 1
	##syscall
	
##print_value

	### print newLine
	###li	$v0,	4
	###la	$a0,	newLine
	###syscall
	

	##condition(currentSpeed < absoluteSpeed)
		blt	$t0, $t1, loop_08
	
	##condition(0-20)			##check_if greater than 0
								##less than the rest in range
	##bgt $t4,	$t8, loop_04	##greater than 35
	blt $t4,	$t2, loop_04 	##use less than
	
	##condition(21-25)
	blt $t4,	$t5, loop_05
	
	##condition(26-34)
	blt $t4,	$t6, loop_06
	
	##condition(>35)
	bge $t4	$t7, loop_07
		
#############################################################################

###Printing_Penalty_message1(1-20)
loop_04:

	### print newLine
	li	$v0,	4
	la	$a0,	newLine
	syscall
	
	li	$v0,	4
	la $a0,	penalty_message1
	syscall
	j loop_09

####################################################################################
	
###Printing_Penalty_message2(21-25)
loop_05:
	
	### print newLine
	li	$v0,	4
	la	$a0,	newLine
	syscall
	
	li	$v0,	4
	la $a0,	penalty_message2
	syscall
	j loop_09

#############################################################################
	
###Printing_Penalty_message3(26-34)
loop_06:

	### print newLine
	li	$v0,	4
	la	$a0,	newLine
	syscall
	
	li	$v0,	4
	la $a0,	penalty_message3
	syscall
	j loop_09
	
#############################################################################	
	
###Printing_Penalty_message4(> 35)
loop_07:

	### print newLine
	li	$v0,	4
	la	$a0,	newLine
	syscall
	
	li	$v0,	4
	la $a0,	penalty_message4
	syscall
	j loop_09

#############################################################################

###Printing_valid_messages(if currentSpeed < speedLimit($t1 reg))
loop_08:

	### print newLine
	li	$v0,	4
	la	$a0,	newLine
	syscall
	
	li	$v0,	4
	la $a0,	valid_M
	syscall
	j loop_09
	
#############################################################################
	
##End_program	
loop_09:	
	jr $31	
