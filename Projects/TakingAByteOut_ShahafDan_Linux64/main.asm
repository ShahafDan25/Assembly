;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
	; put your variables below
	lineAct db "===============================", 0ah ,0dh, 0h
	welcomeAct db "Hello World, Assignment #8:", 0ah, 0dh, "We will now calculate the variance of the following values" , 0ah, 0dh, 0h
	goodbyeAct db "Bye, have a good one", 0ah, 0dh, 0h
	avgAct db "Average is: ", 0h
	totalAct db "Total is: ", 0h
	valuesAct db "the values given are: ", 0h
	VarianceAct db "The Variance of these values is: ", 0h
	PrintMinus db "-", 0h
	
	
	
	valuesArray	dq	-512, -3, 245, 800, -88 ;everything should be signed
		.len equ (($ - valuesArray) /8 );divide by 8 because we are using quad word
	;valuesArray	dq	-365, -722, 567, -876, -222 ;everything should be signed
	;	.len equ (($ - valuesArray) /8 );divide by 8 because we are using quad word
		
		
	total	dq	0h; set total to zero, we will use total / length to calculate he average (mean)
	average dq	0h
	varianceTotal dq 0h ;store total of squared values previously to calculating variance
	varianceAverage dq 0h
SECTION .bss
	;reserve memory here
	tempArray resq valuesArray.len
		.len equ (($ - tempArray) / 8);
	
SECTION     .text
	global  _start
     
_start:
	;code goes here
	
	;============ WELCOME MESSAGE =================
	call Printendl
	push lineAct
	call PrintString
	push welcomeAct
	call PrintString 
	call Printendl
	
	mov rax, 0
	mov rbx, 0
	mov rdx, 0; use register to transfer numbers to total
	mov rcx, 0 ;clear counter for loops just in case
	mov rsi ,0
	
	
	;Call the calcvariance function
	push tempArray
	push valuesArray					;push into the stack frame	
	;push valuesArray.len				;push into the stack frame

	call calcvariance					;call the variable
	
	
	;========= PRINT AND CALCULATE VALUES (also total loop =============

	

	;======= CALCULATING MEAN DIFFERENCES =============
	mov rax, 0
	mov rbx, 0
	call Printendl
	mov rcx, 0
	mov rsi, 0 ;clearing registers, first of all
	mov rcx, valuesArray.len;set iterator
	MeanDifLoop:
		; for each value:
		;1) substract the previosuly calculated mean
		;2) sqaure the new value
		;3) add it to varianceTotal
		mov rax, [valuesArray + rsi] ;move o rax the next value in line
		clc
		mov rbx, [total]
		bt rbx, 63
		jnc cont0
		add rax, [average]
		jmp cont9
		cont0:
		sub rax, [average]
		cont9:
		
	
		imul rax ;multiply rax by rax (squaring it)
		add [varianceTotal], rax ;add the new values (which much be positive, becauseit was sqaures) to its corresponding variable
		
		mov rax, 0 ;clean rax for safety reasons LOL
		mov rbx, 0 ;clean the average holder register
		add rsi, 8;8 for quad words
	loop MeanDifLoop
		call Printendl


;============= PRINT VARIANCE ===============
push VarianceAct
call PrintString
	mov rcx, 0
	mov rax, 0
	mov rax, [varianceTotal]
	mov cx, valuesArray.len
	idiv rcx ;divide the variance toatl (storedin rax) by rcx
	mov [varianceAverage], rax
	
	push rax
	call Print64bitNumDecimal
	
	;=========== GOODBYE MESSAGE ================
	call Printendl
	push goodbyeAct
	call PrintString
	call Printendl
	push lineAct
	call PrintString
	
;=============== EXIT ==================
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel

;============== VARIANCE CALCULATOR FUNCTION =================
calcvariance:
	;=========CREATE THE STACK============
	push rbp 						;Store the current stack frame
	mov rbp, rsp					;Preserve esp into ebp for argument reference			
	mov rbx, 0						;we will store the total in rbx for now
	;========= STACK ACTION CODE ============
	mov rdi, [rbp + 16]				;push the address of the sampleArray stored in rbp + 16 to a pointer variable
	mov rcx, 5						;Do we pass the number of elements as a parameter? - CHANGE
	loopie:
		mov rax, [rdi]				;move to rax the dereferenced value stored in the rdi pointer
		clc							;clear carry flag, we will use it to detect negative values
		bt rax, 63					;use bt to store the most SIGNificant bit in the carry flag
		jnc notNeg					;if carry flag os 0: not negative
		neg rax	
		sub rbx, rax				;substract the value from the total
		push PrintMinus				;print a minus if the vaue is negative
		call PrintString
		jmp neg
		notNeg:						; conitnue code here if the value is not negative
		add rbx, rax				;add the value to the total
		neg:						;continue code here if thevalue IS negative
		push rax					;prepare to print
		call Print64bitNumDecimal	;Print values
		call PrintComma				;Print a coma
		add rdi, 8 					;go to the next argument in the array, whose address is stored in the rdi pointer
	loop loopie
	
	call Printendl					;line spacing
	
	
	;------ Print total----------
	push totalAct					;Print total prompt
	call PrintString				;Print it
	clc								;Clear he carry flag: will be used to determine sign of total
	bt rbx, 63						;get the SIGNficiant bit of the total (storedin rbx)
	jnc notNeg2						;jump if not negative
	neg rbx							;but if it negative, re-negate it
	push PrintMinus					;and also print a minux sign
	call PrintString				; Print it
	notNeg2:						;But, if the total (in rbx) is not negative:
	push rbx						;Prepare printing total
	call Print64bitNumDecimal		; print total
	call Printendl
	
	
	;----------Calculate average----------
	;carry still holds the negation value!
	mov rax, 0						;clear rax
	mov rax, rbx
	mov rcx, 5						;now rax holds the total
	idiv rcx						;divide rax with 5 - CHANGE TO A LENGTH VARIABLE
	
	push avgAct						;prepare to print average act
	call PrintString				;print it
	clc								;Clear carry
	bt rax, 63						;check SIGNificant bit	
	jnc notNeg3						;if the number is negative {
	push PrintMinus					;print a minus
	call PrintString				;}
	notNeg3:						;else {...}	
	push rax						;cout <<
	call Print64bitNumDecimal		;average <<
	call Printendl					;endl;
	
	AVG equ 0h
	mov AVG, rax
	;------- CREATE SPACE FOR SQUARED VALUES ARRAY ----------
	mov rcx, 5						;CREATE SIZE VARIABLE GODDAMNIT
	addStackSpaceLoop:
		sub rsp, 8		
	loop addStackSpaceLoop
	
	;by now we should have x qw values in the stack
	;--------- CALCULATE THE AVERAGE OF THE NEW ARRAY ----------
	mov rdx, rax					;RDX now holds the values mean (RDX = AVERAGE)
	mov rax, 0						;clear RAX register
	mov rcx, 5						;Do we pass the number of elements as a parameter? - CHANGE
	mov rdi, [rbp + 16]
	varianceArrayLoop:
		mov rax, [rdi]				;move to rbx the dereferenced value stored in the rdi pointer
		
		jnc	notNeg4					;not a negative average
			add rax, rdx
		jmp neg4
		notNeg4:
			sub rax, rdx
		neg4:
		imul rax					;Squar the edited value
		push rax					;move the squared values into the next spot in the stack
		call Print64bitNumDecimal
		call PrintComma
		add rdi, 8 					;increase rdi (the iterator)
		
		mov rax, 0					;go to the next argument in the array, whose address is stored in the rdi pointer
	loop varianceArrayLoop
	mov rbx, 0
	mov rdi, 0
	mov rdi, [rbp + 24]				;move to rsi the address of the variable pushed first to the stack
	mov rcx, 5						;size of array 
	populateTempLoop:
		
		mov rbx, 0
		add rdi, 8					;to go to the next quad word (8bytes) in the array, indexed way
	loop populateTempLoop
	;=========== DESTROY STACK ==============
	mov rsp, rbp					;Restore the stack position
	pop rbp							;Restore ebp's original value in the stack frame
	
ret 	

;============= SPACE FOR CONVENIENCE ==================













