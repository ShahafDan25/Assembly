
%include "./functions64.inc"
global calcvariance

SECTION     .text
;============== VARIANCE CALCULATOR FUNCTION =================
calcvariance:
	
	;push "-"
	;call PrintString

	;=========CREATE THE STACK============
	push rbp 						;Store the current stack frame
	mov rbp, rsp					;Preserve esp into ebp for argument reference			
	mov rbx, 0		
	mov rdx, 0
	mov rcx, 0				;we will store the total in rbx for now
	;========= STACK ACTION CODE ============
	mov rdi, [rbp + 16]				;push the address of the sampleArray stored in rbp + 16 to a pointer variable
	mov rcx, [rbp + 24];
	
	loopie:
		mov rax, [rdi]				;move to rax the dereferenced value stored in the rdi pointer
		clc							;clear carry flag, we will use it to detect negative values
		bt rax, 63					;use bt to store the most SIGNificant bit in the carry flag
		jnc notNeg					;if carry flag os 0: not negative
		neg rax	
		sub rbx, rax				;substract the value from the total
		
		
		;------- PRINT MINUSSS-----------
		
		jmp neg
		notNeg:						; conitnue code here if the value is not negative
		add rbx, rax				;add the value to the total
		neg:	

		push rax					;prepare to print
		call Print64bitNumDecimal	;Print values
		cmp rcx, 1
		je lastOne
		call PrintComma				;Print a coma
		lastOne:
		add rdi, 8
	loop loopie
	
	call Printendl					;line spacing
	
	
	;------ Print total----------
	;push totalAct					;Print total prompt
	;call PrintString				;Print it
	mov rdx, rbx
	clc								;Clear he carry flag: will be used to determine sign of total
	bt rbx, 63						;get the SIGNficiant bit of the total (storedin rbx)
	jnc notNeg2						;jump if not negative
	neg rbx							;but if it negative, re-negate it
	;push PrintMinus					;and also print a minux sign
	;call PrintString				; Print it
	notNeg2:						;But, if the total (in rbx) is not negative:
	push rbx						;Prepare printing total
	call Print64bitNumDecimal		; print total
	call Printendl


	
	;----------Calculate average----------
	;carry still holds the negation value!
	mov rax, 0						;clear rax
	mov rax, rbx					;now rax holds the total
	mov rcx, [rbp + 24]				;now rcx holds valuesArray.len
	mov rbx, 0
	mov rbx, rdx
	cdq								;Expand to avoid floating point exception
	idiv rcx						;divide rax with 5 - CHANGE TO A LENGTH VARIABLE
	
	
	;push avgAct						;prepare to print average act
	;call PrintString				;print it
	clc
	bt rbx, 63					;check SIGNificant bit	
	jnc notNeg3					;if the number is negative {
	;push PrintMinus					;print a minus
	;call PrintString				;}
	notNeg3:						;else {...}	
	push rax						;cout <<
	call Print64bitNumDecimal		;average <<
	call Printendl					;endl;
	
	;sub rsp, 8						;create enough room for an average 
	push rax						;rax (average(abs)) is now in the stack in RBP - 8 ;automatically does rsp - 8
	mov rax, 0
	
	mov rsi, 0
						;create enough room for a pointer for another array
	;call Printendl
	;push PrintMinus
	;call PrintString
	;call Printendl
	;by now we should have x qw values in the stack
	;--------- CALCULATE THE AVERAGE OF THE NEW ARRAY ----------
	mov rdx, [rbp - 8]					;RDX now holds the values mean (RDX = AVERAGE)
	mov rax, 0	
	mov rdi, 0					;clear RAX register
	mov rcx, [rbp + 24]						;Do we pass the number of elements as a parameter? - CHANGE
	mov rdi, [rbp + 16]
	varianceArrayLoop:
		;sub rsp, 8					;create space for one more values in the array
		mov rax, [rdi]				;move to rbx the dereferenced value stored in the rdi pointer
		mov rdx, [rbp - 8]
		clc
		bt rbx, 63
		jnc	pos						;not a negative
			;neg rax
			add rax, rdx				;if negaative, substract and take absolute value
		jmp posCont
		pos:
			sub rax, rdx			;subtract the average in RDX from the current rax value
		posCont:
		
		imul rax					;Squar the edited value, does something to rdx everytime, so we have to reassign the value to rdx
		sub rsp, 8					;create stack room for 8 more bits
		mov QWORD [rsp], rax
		
		add rdi, 8 					;increase rdi (the iterator)
		
		mov rax, 0					;go to the next argument in the array, whose address is stored in the rdi pointer
	loop varianceArrayLoop
	
	;----- CALCULATE AVERAGE OF SQUARED VALUES
	mov rcx, 0
	mov rcx, [rbp + 24]				;the number of elementsin the original array passed to the function
	mov rax, 0						;RBX is going to hold our total
	mov rdx, rsp
	
	loopom:
	
	add rax, [rdx]					;calculate the average (whihc must be positive) of the squared values
	add rdx, 8
	add rsi, 8
	loop loopom
	mov rcx, 0
	mov rcx, [rbp + 24]
	
	cdq									;Exapnd into RAX:RDX to avoid floating point exception
	
	idiv rcx
	
	push VarianceAct
	call PrintString
								;Divide by the number of elements
	push rax							;
	call Print64bitNumDecimal
	call Printendl
	;=========== DESTROY STACK ==============
	mov rsp, rbp					;Restore the stack position
	pop rbp							;Restore ebp's original value in the stack frame
	
ret 	
