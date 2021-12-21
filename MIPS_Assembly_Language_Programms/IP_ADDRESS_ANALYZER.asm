											######## Mziomukulu-Mike-Kumalo ########
												#### 		Project 3		####	
											######## IP_ADDRESS_ANALYEZER   ######## 
.data
 				
	#######Messages#######
		newLine:  			.asciiz "\n"
		IP_messg:  			.asciiz "IP: "
		dot_messg:  			.asciiz "."
		enter_IP_Messg:		.asciiz "Enter an IP address"
		error_messg1:		.asciiz	"The entered number is larger than 255." 
		error_messg2:		.asciiz	"The entered number is less than 0."
		first_messg: 		.asciiz "First: "
		secnd_messg: 		.asciiz "Second: "
		third_messg:		.asciiz "Third: "
		forth_messg: 		.asciiz "Fourth: "
	######Class_Address_Messages#########
		classA:				.asciiz	"Class A address"
		classB:				.asciiz	"Class B address"
		classC:				.asciiz	"Class C address"
	match_domain_msg:		.asciiz	"Matching domain found at: "
	no_match_msg:			.asciiz	"No match found. "
		
####################################################################################################################
					####IP_ADDRESS_TABLE###
	
	IP_ROUTING_TABLE_SIZE:
		.word	20 
	IP_ROUTING_TABLE:
		# line #, x.x.x.x -------------------------------------
		.byte	0, 120, 188,  76, 111	# 120.188.76.111 (class A)
		.byte	1, 202,  57, 233,   3	# 207.57.233.3 (class C)
		.byte	2, 195, 244, 201,  84	# 195.244.201.84 (class C)
		.byte	3, 138,  93, 222, 192	# 138.93.222.192 (class B)
		.byte	4, 131,  55, 141,  22	# 131.55.141.22 (class B)
		.byte	5,  18, 252,  39, 253	# 18.252.39.253 (class A)
		.byte	6,  48, 122, 177,   9	# 48.122.177.9 (class A)
		.byte	7, 197, 165, 210, 192	# 197.165.210.192 (class C)
		.byte	8, 202,  44, 133, 222	# 202.44.133.222 (class C)
		.byte	9,  24, 125,  99,  99	# 24.125.99.99 (CLASS A)
		.byte	20, 146, 163, 255, 255	# 146.163.255.255 (class B)
		.byte	21, 147, 163, 255, 255	# 147.163.255.255 (class B)
		.byte	22, 201,  88,  88,  90	# 201.88.88.90 (class C)
		.byte	23, 182, 151,  44,  56	# 182.151.44.56 (class B)
		.byte	24,  24, 125, 100, 100	# 24.125.100.100 (class A)
		.byte	25, 146, 163, 140,  80	# 146.163.170.80 (class B)
		.byte	26, 146, 163, 147,  80	# 146.163.147.80 (class B)
		.byte	27, 146, 164, 147,  80	# 146.164.147.80 (class B)
		.byte	28, 148, 163, 170,  80	# 148.163.170.80 (class B)
		.byte	29, 193,  77,  77,  10	# 193.77.77.10 (class C)
		
######################################################################################################################

.text
.globl main

main:
	#######Bounds#######
		##DomainClass_A
			##1-127
		##DomainClass_B
			##128-191
		##DomainClass_C
			##192-223
		##DomainClass_D
			##224-239		
	#######Load_Class_Bounds#######
	li	$s3,	1
	li	$s4,	127
	li	$s5,	128
	li	$s6,	191
	li	$s7,	192
	li	$s8,	223
	
	##loop_counter
	li	$t7,	0
	li	$t8,	0
	li	$v1,	-1
	
	#######Enter_IP_ADDRESS#######
			
		li	$v0,	4
		la	$a0,	enter_IP_Messg
		syscall
		
	#######print_newLine#######
		li	$v0,	4
		la	$a0,	newLine
		syscall
	
first_IP:
	
	#######load_bound#######
		li	$s2,	0
		li	$s1,	255
	
	#######frist_message#######	
		li	$v0,	4
		la	$a0,	first_messg
		syscall
		
	#######Get_first_IP#######
		li	$v0,	5			
		syscall
		
		move $t1, $v0				##$t1-first_IP##
	
	#######compare_to_Bound#######
		bgt	$t1,	$s1, error_messge1
		blt $t1,	$s2, error_messge1b		
		j secnd_IP
		
	#######error_messages#######	
error_messge1:
		li	$v0,	4
		la	$a0,	error_messg1
		syscall
		
	#######print_newLine#######
		li	$v0,	4
		la	$a0,	newLine
		syscall
		
		j first_IP
		
error_messge1b:
		li	$v0,	4
		la	$a0,	error_messg2
		syscall
		
	#######print_newLine#######
		li	$v0,	4
		la	$a0,	newLine
		syscall
		
		j first_IP
		
#######End_first#################################################
		
secnd_IP:
		
	#######second_message#######
		li	$v0,	4
		la	$a0,	secnd_messg
		syscall
		
	#######Get_secon_IP#######
		li	$v0,	5			
		syscall
		
		move $t2, $v0				##$t2-second_IP##
	
	#######compare_to_Bound#######
		bgt	$t2,	$s1, error_messge2
		blt $t2,	$s2, error_messge2b
		j third_IP
		
	#######error_message#######	
error_messge2:
		li	$v0,	4
		la	$a0,	error_messg1
		syscall
		
	#######print_newLine#######
		li	$v0,	4
		la	$a0,	newLine
		syscall
		
		j secnd_IP
		
error_messge2b:
		li	$v0,	4
		la	$a0,	error_messg2
		syscall
		
	#######print_newLine#######
		li	$v0,	4
		la	$a0,	newLine
		syscall
		
		j secnd_IP
		
#######End_second#################################################

third_IP:
	
	#######third_message#######
		li	$v0,	4
		la	$a0,	third_messg
		syscall
		
	#######Get_third_IP#######
		li	$v0,	5			
		syscall
		
		move $t3, $v0				##$t3-third_IP##
	
	#######compare_to_Bound#######
		bgt	$t3,	$s1, error_messge3
		blt $t3,	$s2, error_messge3b
		j fourth_IP
		
	#######error_message#######	
error_messge3:
		li	$v0,	4
		la	$a0,	error_messg1
		syscall
		
	#######print_newLine#######
		li	$v0,	4
		la	$a0,	newLine
		syscall
		
		j third_IP

error_messge3b:
		li	$v0,	4
		la	$a0,	error_messg2
		syscall
		
	#######print_newLine#######
		li	$v0,	4
		la	$a0,	newLine
		syscall
		
		j third_IP
	
#######End_third#################################################	

fourth_IP:

#######fourth_message#######
		li	$v0,	4
		la	$a0,	forth_messg
		syscall
		
	#######Get_fourth_IP#######
		li	$v0,	5			
		syscall
		
		move $t4, $v0				##$t4-fourth_IP##
	
	#######compare_to_Bound#######
		bgt	$t4,	$s1, error_messge4
		blt $t4,	$s2, error_messge4b
		
		j check_Class
		
	#######error_message#######	
error_messge4:
		li	$v0,	4
		la	$a0,	error_messg1
		syscall
		
	#######print_newLine#######
		li	$v0,	4
		la	$a0,	newLine
		syscall
		
		j fourth_IP
		
error_messge4b:
		li	$v0,	4
		la	$a0,	error_messg2
		syscall
		
	#######print_newLine#######
		li	$v0,	4
		la	$a0,	newLine
		syscall
		
		j fourth_IP
		
#######End_fourth#################################################

		
#######Domain_Message_Prints#########

message_A:
		
		#######print_newLine#######
		li	$v0,	4
		la	$a0,	newLine
		syscall
		######print_messageA#######
		li	$v0,	4
		la	$a0,	classA
		syscall
			
		add $t8,  1
		
		j load_table
		
message_B:

		#######print_newLine#######
		li	$v0,	4
		la	$a0,	newLine
		syscall
		li	$v0,	4
		la	$a0,	classB
		syscall
		
		add $t8,  2
		
		j load_table
		
message_C:
		#######print_newLine#######
		li	$v0,	4
		la	$a0,	newLine
		syscall
		li	$v0,	4
		la	$a0,	classC
		syscall
		
		add $t8, 3
		j load_table
		
###########################End_Messages################################################

#######Check_Class_######
		
		######Check_first_IP######$t1-IP1######
		
check_Class:
		blt	$t1,	$s5,	message_A				##< 128
		blt	$t1,	$s7,	message_B				##<	192
		ble	$t1,	$s8,	message_C				##<`224

	######load_table######
load_table:
		
	##t6-table_register_size
	lw	$t6,	IP_ROUTING_TABLE_SIZE

	###loa_table####
	la $a1,	IP_ROUTING_TABLE
	
	#######print_newLine#######
	li	$v0,	4
	la	$a0,	newLine
	syscall
		
	j loop_loop

loop_loop:
	
	lbu	$s0,    0($a1)
	lbu	$s1,	1($a1)
	lbu	$s2,	2($a1)
	lbu	$s3,	3($a1)
	lbu	$s4,	4($a1)
	
	#######print_IP_message#######
	li	$v0,	4
	la	$a0,	IP_messg
	syscall
	
	###print_firstNum###
	li	$v0,	1
	move	$a0,	$s1
	syscall
		
	###print_dot_###
	li	$v0,	4
	la	$a0,	dot_messg
	syscall
	
	###print_secondNum###
	li	$v0,	1
	move	$a0,	$s2
	syscall
	
	###print_dot_table###
	li	$v0,	4
	la	$a0,	dot_messg
	syscall
	
	###print_thirdNum###
	li	$v0,	1
	move	$a0,	$s3
	syscall
	
	###print_dot_table###
	li	$v0,	4
	la	$a0,	dot_messg
	syscall
	
	###print_fourthNum###
	li	$v0,	1
	move	$a0,	$s4
	syscall
	
	#######print_newLine#######
	li	$v0,	4
	la	$a0,	newLine
	syscall
	
	##sub	$t6, 1
	add $t7 $t7, 1
	addi $a1, 5
	
	beq	$t8, 1, classA_Check	##$t6-counter = $t7-0
	beq	$t8, 2, classB_Check
	beq	$t8, 3, classC_Check
	j end_

classA_Check:
	
		beq	$t1, $s1, found_match	
		blt $t7, $t6, loop_loop
		beq $v1, -1, no_match
		
		j print_match
		
classB_Check:
		beq	$t1, $s1, classB_Check2	
		blt $t7, $t6, loop_loop
		beq $v1, -1, no_match
		j print_match
		
		classB_Check2:
			beq	$t2, $s2, found_match
			blt $t7, $t6, loop_loop
			beq $v1, -1, no_match
			j print_match
			
classC_Check:
		beq	$t1, $s1, classC_Check2	
		blt $t7, $t6, loop_loop
		beq $v1, -1, no_match
		j print_match
		
		classC_Check2:
			beq	$t2, $s2, classC_Check3
			blt $t7, $t6, loop_loop
			beq $v1, -1, no_match
			j print_match
					
				classC_Check3:
					beq	$t3, $s3, found_match
					blt $t7, $t6, loop_loop
					beq $v1, -1, no_match
					j print_match	
found_match:
	move	$v1,	$s0
	beq $t6, $t7, end_	
	j loop_loop

###print_match_messg###	
print_match:
	li	$v0,	4
	la	$a0,	match_domain_msg
	syscall

	###print_domain_Num###
	li	$v0,	1
	move	$a0,	$v1
	syscall
	
	jr $31
	
######no_match_found######
no_match:
	
	###print_no_match_messg###
	li	$v0,	4
	la	$a0,	no_match_msg
	syscall

	jr $31

end_:
	beq $v1, -1, no_match
	
	j print_match
	
	jr $31
	