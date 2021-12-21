				# Program2
				# Mziomukulu-Mike-Kumalo
				# Recursive_Compound_interest_Calculator
				
.data

##bounds
	fixed_R_lowbound:			.float	0.0
	fixed_R_highbound:			.float	1.0
	fixed_Principle_lowbound:	.float	100.00
	fixed_Principle_highbound:	.float	5000000.00
	fixed_target_lowbound:		.float	101.00
	fixed_target_highbound:		.float	5000001.00
	
##messages
	newLine:  .asciiz "\n"
	message1: .asciiz "Enter the principal:"
	message2: .asciiz "Enter the interest rate(0.0 < interest < 1.0, 0.01 for 1%):"
	message3: .asciiz "Enter the target balance:$"
	message4: .asciiz "Number of last years for display you would like to see the balance (-1 all):"
	message5: .asciiz "the balance at the end of a year "
	message6: .asciiz "year "
	message7: .asciiz ": "
	message8: .asciiz "It takes "
	message9: .asciiz " years."
	
.text
.globl main

main:

##load_bounds
		##lowerBound_R
			la	$a0,	fixed_R_lowbound			##$f20-Lr
			lwc1	$f20, ($a0)
		##higherBound_R
			la	$a0,	fixed_R_highbound			##$f21-Hr
			lwc1	$f21, ($a0)
		##lowerBound_Principle
			la	$a0,	fixed_Principle_lowbound	##$f22-Lp
			lwc1	$f22, ($a0)
		##higherBound_Principle
			la	$a0,	fixed_Principle_highbound	##$f23-Hp
			lwc1	$f23, ($a0)	
		##lowerBound_target
			la	$a0,	fixed_target_lowbound		##$f24-L_t
			lwc1	$f24, ($a0)
		##higherBound_taregt
			la	$a0,	fixed_target_highbound		##$f25-Ht
			lwc1	$f25, ($a0)
			
##loopCounter		
		li $t1, 0
		li $t4,0
loop_01:
			
##Display_principal_message1
		li	$v0,	4
		la	$a0,	message1
		syscall
		
##Get_principal_
		li	$v0,	6			
		syscall
		mov.s $f4, $f0								##$f4_principal_register
		
##compare_Userintput_to_bounds	
		c.lt.s	$f4, $f22 
		bc1t loop_01
		
		c.lt.s	$f23, $f4 
		bc1t  loop_01		
		
loop_02:
 
##Display_Interest_Rate_message2
		li	$v0,	4
		la	$a0,	message2
		syscall
		
##Get_Interest_Rate_
		li	$v0,	6			
		syscall
		mov.s $f5, $f0								##$f5_InterestRate_register

##compare_Userintput_to_bounds	
		c.lt.s	$f5, $f20 
		bc1t loop_02
		
		c.lt.s	$f21, $f5 
		bc1t  loop_02
				
loop_03:

##Display_targetBalance_message3
		li	$v0,	4
		la	$a0,	message3
		syscall
		
##Get_targetBalance_
		li	$v0,	6			
		syscall
		mov.s $f6, $f0								##$f6_targetBalance_register

##compare_Userintput_to_bounds	
		c.lt.s	$f6, $f24 
		bc1t loop_03
		
		c.lt.s	$f25, $f6 
		bc1t  loop_03	
		
loop_04:

##Display_NumofYearsTodisplay_message4
		li	$v0,	4
		la	$a0,	message4
		syscall
		
##Get_numofYearstoDisplay_
		li	$v0,	5			
		syscall

		move $t2, $v0								##$t2_numOfYearsToDisplay_register

##print_balance_message		
		li,	$v0,	4
		la,	$a0,	message5
		syscall

	##loopCounter		
		li $t1, 0
		li $t8, 0
		
	sw	$ra, 	($sp)
	
	jal calulation

	lw	$ra,	($sp)
	
	j last_message

	jr $31
###################################End_main####################################################
calulation:


##calculations	
	mul.s $f26, $f4, $f5   								####$f26- has interest
	add.s	$f4, $f4, $f26	

##increment_loop
	add $t1, $t1, 1	
	move $t8, $t1
	
##Save_Registers_to_stack
	subu	$sp, $sp, 12
	s.s		$f4,	4($sp)
	sw		$t1	8($sp)
	sw		$ra,	0($sp)	
	
	##save_numtodesplay_
	##sw		$t2		12($sp)
	
	
##base_case	
	c.lt.s $f6, $f4 
	bc1t loop_06			

jal calulation	
			
lw		$t1,	8($sp)
l.s		$f4,	4($sp)

loop_06:
	##if base case is reached go to loop_07
	##check-below/0 - if t2<0>0
	blt	$t2, 0, printAll
	bgt $t2, 0, printToYear
		
	
	
####PrintAll	
printAll:

##print_newLine
		li	$v0,	4
		la	$a0,	newLine
		syscall
		
##year_message
		li,	$v0,	4
		la,	$a0,	message6
		syscall
		
##print_loop_num
		li $v0, 1
		move, $a0, $t1
		syscall
		
##space_message
		li,	$v0,	4
		la,	$a0,	message7
		syscall
		
##print_balance
		li $v0, 2
		mov.s $f12, $f4 							##print_principal
		syscall
	j restore
	
####PrintToYear
printToYear:
	##increment_loop
	add $t4, $t4, 1	
	bgt $t4, $t2, restore
	##print_newLine
		li	$v0,	4
		la	$a0,	newLine
		syscall
		
##year_message
		li,	$v0,	4
		la,	$a0,	message6
		syscall
		
##print_loop_num
		li $v0, 1
		move, $a0, $t1
		syscall
		
##space_message
		li,	$v0,	4
		la,	$a0,	message7
		syscall
		
##print_balance
		li $v0, 2
		mov.s $f12, $f4 							##print_principal
		syscall
	j	restore

restore:
##restoreRegisters
	lw		$ra, 	($sp)
	addu	$sp,	$sp, 12
	jr $ra	
##################################End_Calculation####################################################	
	
##last_message	
last_message:

		##print_newLine
		li	$v0,	4
		la	$a0,	newLine
		syscall
		
##it_takes_message		
		li,	$v0,	4
		la,	$a0,	message8
		syscall
		
##print_loop_num
		li $v0, 1
		move, $a0, $t8
		syscall
		
##years_message		
		li,	$v0,	4
		la,	$a0,	message9
		syscall		
	
	jr $31
	


	