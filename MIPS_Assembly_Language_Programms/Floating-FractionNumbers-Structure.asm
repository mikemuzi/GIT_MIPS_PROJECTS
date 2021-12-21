				# Program1
				# Mziomukulu Mike Kumalo
				# Floating-point fraction numbers

.data
	
	##bounds
	low_principal:		.float	100.00
	high_principal:		.float	1000000.00
	low_interestRate:	.float	0.005
	high_interestRate:	.float	0.399
	day_by_year:		.float	0.08219
	
	####### messages #######
	
	newLine:  .asciiz "\n"
	message1: .asciiz "Enter the principal in $ (100.00 - 1,000,000.00): "
	message2: .asciiz "Enter the annual interest rate (0.005 - 0.399): "
	message3: .asciiz "Enter the monthly payment amount in $ (1.00 - 2,000.00): "
	message5: .asciiz "month "
	message6: .asciiz ":"
	message7: .asciiz "  current principal = "
	message8: .asciiz "It will take "
	message9: .asciiz " months to complete the loan."
	
.text

.globl main  
   
main:

##load bounds
		##lowerBound
			la	$a0,	low_principal	
			lwc1	$f20, ($a0) 
		##higherBound
			la	$a0,	high_principal	
			lwc1	$f21, ($a0)
		##lowerBound
			la	$a0,	low_interestRate	
			lwc1	$f22, ($a0) 
		##higherBound
			##la	$a0,	high_InterestRate	###fix_comparision
			##lwc1	$f23, ($a0)
		##LoadDay/year
			la	$a0,	day_by_year	
			lwc1	$f24, ($a0)	
loop_01:

	##load_principal_message
		li	$v0,	4
		la	$a0,	message1
		syscall
		
	##get_Principle
		li	$v0,	6			
		syscall
		mov.s $f4, $f0								####$f4_principal_register
		
	##compare_Userintput_to_bounds	
		c.lt.s	$f4, $f20 
		bc1t loop_01
		
		c.lt.s	$f21, $f4 
		bc1t  loop_01
	
	##print_newLine
		##li	$v0,	4
		##la	$a0,	newLine
		##syscall
		
	
loop_02:

	##load_anualInterestRate_message
		li,	$v0,	4
		la,	$a0,	message2
		syscall
		
	##get_get_InterestRate
		li	$v0,	6			
		syscall
		mov.s $f5, $f0								####$f5_interestRate_register
		
	##compare_Userintput_to_bounds	
		##c.lt.s	$f5, $f22 
		##bc1t loop_02
		
		
		##c.lt.s	$f23, $f5 
		##bc1t  loop_02
	
	##print_newLine
		##li	$v0,	4
		##la	$a0,	newLine
		##syscall
		
	
loop_03:
		
	##load_monthly_payment_message
		li,	$v0,	4
		la,	$a0,	message3
		syscall
		
	##get_get_monthly_payment
		li	$v0,	6			
		syscall
		mov.s $f6, $f0								####$f6_monthly_payment_register

loop_04:
	
	##loopCounter
		li $t7, 1
		
	##print_newLine
		##li	$v0,	4
		##la	$a0,	newLine
		##syscall
		
	##load first_month_message
		li,	$v0,	4
		la,	$a0,	message5
		syscall
		
		##print_loop_num
		li $v0, 1
		move, $a0, $t7
		syscall
		
		li,	$v0,	4
		la,	$a0,	message6
		syscall
		
		li,	$v0,	4
		la,	$a0,	message7
		syscall
		
	##print_payment
		li $v0, 2
		mov.s $f12, $f4
		syscall
		
	##print_newLine
		li	$v0,	4
		la	$a0,	newLine
		syscall		
		
##loop_05:

	##calculate_monthly_interest
	mul.s	$f25, $f4, $f5
	mul.s   $f25  $f25, $f24							#####f$26_monthly_interest
		
	##calculate_first_payment_Principal
	sub.s	$f26, $f6 $f25								######$f26_first_payment
	
	##calculate_remaining_principle
	
	
	mov.s $f27, $f26								##f$29_remaining_payments
	sub.s	$f28, $f4, $f27
		
loop_06:
	
	##increment_loop
		add $t7, $t7, 1
		
	##load_month_message
		li,	$v0,	4
		la,	$a0,	message5
		syscall
		
		##print_loop_num
		li $v0, 1
		move, $a0, $t7
		syscall
		
		li,	$v0,	4
		la,	$a0,	message6
		syscall
		
		li,	$v0,	4
		la,	$a0,	message7
		syscall
		
	##print_payment
		li $v0, 2
		mov.s $f12, $f28
		syscall
		
	##calculate_monthly_interest
	##mul.s	$f25, $f4, $f5
	##mul.s   $f26  $f24, $f25							#####f$26_monthly_interest
		
	##calculate_first_payment_Principal
	##sub.s	$f27, $f6 $f26								######$f27_first_payment
	
	##calculate_remaining_principle
	sub.s	$f28, $f28, $f27
	
	##mov.s $f29, $f28									##f$29_remaining_payments
	
	##print_newLine
		li	$v0,	4
		la	$a0,	newLine
		syscall
		
	##increment_loop
	##add $t7, $t7, 1
	
	c.lt.s $f28, $f6 
	bc1t loop_07   									 ##when_remaining_payment_is_less_than_monthly_payments_$f6
	
	j loop_06
		
loop_07:
		
	##print_newLine
		li	$v0,	4
		la	$a0,	newLine
		syscall
		
	##final_month count
		li,	$v0,	4
		la,	$a0,	message8
		syscall
		
	##print_loop_num
		li $v0, 1
		move, $a0, $t7
		syscall
		
		li,	$v0,	4
		la,	$a0,	message9
		syscall
		
jr $31

loop_05:
###Printss

	##print_newLine
		li	$v0,	4
		la	$a0,	newLine
		syscall
		
##print_principal
		li $v0, 2
		mov.s $f12, $f4 							##print_principal
		syscall

##print_newLine
		li	$v0,	4
		la	$a0,	newLine
		syscall

##print_InterestRate
		li $v0, 2
		mov.s $f12, $f5 							##print_InterestRate
		syscall
		
##print_newLine
		li	$v0,	4
		la	$a0,	newLine
		syscall

##print_targetBalance
		li $v0, 2
		mov.s $f12, $f6 							##print_targetBalance
		syscall
		
##print_newLine
		li	$v0,	4
		la	$a0,	newLine
		syscall

##print_numberOfYears
		li $v0, 2
		mov.s $f12, $f7 							##print_numberOfYears
		syscall


		