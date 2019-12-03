;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
	; put your variables below
	lineAct db "===============================", 0ah ,0dh, 0h
	welcomeAct db "Hello World, Assignment #7:", 0ah, 0dh, "We will now calculate the variance of the following values" , 0ah, 0dh, 0h
	goodbyeAct db "Bye, have a good one", 0ah, 0dh, 0h
	avgAct db "Average is: ", 0h
	totalAct db "Total is: ", 0h
	valuesAct db "the values given are: ", 0h
	VarianceAct db "The Variance of these values is: ", 0h
	ref db 0h
	PrintMinus db "-", 0h
	;valuesArray	dq	-512, -3, 245, 800, -88 ;everything should be signed
	;	.len equ (($ - valuesArray) /8 );divide by 8 because we are using quad word
	valuesArray	dq	-365, -722, 567, -876, -222 ;everything should be signed
		.len equ (($ - valuesArray) /8 );divide by 8 because we are using quad word
		
	total	dq	0h; set total to zero, we will use total / length to calculate he average (mean)
	average dq	0h
	varianceTotal dq 0h ;store total of squared values previously to calculating variance
	varianceAverage dq 0h
SECTION .bss
	;reserve memory here
	
	
SECTION     .text
	global  _start
     
_start:
	;code goes here
	
	;--------- WELCOME ---------
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
	
	;========= PRINT AND CALCULATE VALUES (also total loop =============

	mov cx, valuesArray.len;set counter
	totalLoop:
		clc ;clear the carry flag
		mov rax, [valuesArray + rsi]
		
		;jc negative ;just in carry (meaning if the left most (most significant) bit is 1, then the number is negative)
		add [total], rax
		clc
		bt rax, 63;puts the last bit in the carry flag
		jnc printIt; if not carry flag, the umbe is positive, just print without negative
		neg rax
		push PrintMinus
		call PrintString
		printIt:
			push rax
			call Print64bitNumDecimal
			cmp rcx, 1 ;just so we dont print the last comma
			je next ; if this is the last item, avoid printintg the comma
			call PrintComma
		next:
		mov rax, 0 ;clear every loop just in case, I guess
		add rsi, 8 ;add 8 bit sfor quad word
		clc
	loop totalLoop
	call Printendl
	call Printendl
	
	
	mov rbx, [total]
	;======== PRINT TOTAL=========
	push totalAct
	call PrintString
	clc
	bt rbx, 63
	jnc cont1
	push PrintMinus
	call PrintString
	neg rbx
	cont1:
	push rbx
	call Print64bitNumDecimal

	mov rax, 0
	mov rax, [total]
	mov rcx, valuesArray.len;set counter	div valuesArray.len ;divide signed rax (total) by rcx (length), then rax will store our integer average
	clc
	bt rax, 63
	jnc cont3 ;positive number
	neg rax
	cont3:
	idiv rcx
	mov [average], rax
	;======== PRINT AVERGE ===========
	call Printendl
	push avgAct
	call PrintString
	clc
	mov rbx, [total]
	bt rbx, 63
	jnc cont2
	push PrintMinus
	call PrintString
	cont2:
	push rax
	call Print64bitNumDecimal

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
	;------ GOODBYTE ----
	call Printendl
	push goodbyeAct
	call PrintString
	call Printendl
	push lineAct
	call PrintString
	
;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel


;;TODO:
;print values of the array

