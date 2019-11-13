;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
	; put your variables below
	welcomeAct db "Hello World, Assignment #7:", 0ah, 0dh, 0h
	goodbyeAct db "Bye, have a good one", 0ah, 0dh, 0h
	avgAct db "Average is: ", 0h
	totalAct db "Total is: ", 0h
	valuesAct db "the values given are: ", 0h
	valuesArray	dq	-999, 878, 776, -580, 768, 654 ;everything should be signed
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
		;bt rax, 64 ;puts the last bit in the carry flag
		;jc negative ;just in carry (meaning if the left most (most significant) bit is 1, then the number is negative)
		adc [total], rax
		mov rax, 0 ;clear every loop just in case, I guess
		add rsi, 8 ;add 8 bit sfor quad word
	loop totalLoop

	mov rbx, [total]
	;======== PRINT TOTAL=========
	push totalAct
	call PrintString
	push rbx
	call Print64bitNumDecimal

	mov rax, [total]
	mov cx, valuesArray.len;set counter	div valuesArray.len ;divide signed rax (total) by rcx (length), then rax will store our integer average
	idiv rcx
	mov [average], rax
	;======== PRINT AVERGE ===========
	call Printendl
	push avgAct
	call PrintString
	push rax
	call Print64bitNumDecimal
	;;; ASSUME THAT BY NOW WE HAVE THE TOTAL IN TOTAL
	
	;======= CALCULATING MEAN DIFFERENCES =============
	mov rax, 0
	mov rbx, 0
	mov rcx, 0
	mov rsi, 0 ;clearing registers, first of all
	mov cx, valuesArray.len;set iterator
	meanFifLoop
		; for each value:
		;1) substract the previosuly calculated mean
		;2) sqaure the new value
		;3) add it to varianceTotal
		mov rax, [valuesAct + rsi] ;move o rax the next value in line
		sbb rax, [average] ;substract the previously caluated average from the current spoken value stored in rax
		imul rax ;multiply rax by rax (squaring it)
		add [varianceTotal], rax ;add the new values (which much be positive, becauseit was sqaures) to its corresponding variable
		
		mov rax, 0 ;clean rax for safety reasons LOL
		add rsi, 8;8 for quad words
		
	loop MeanDifLoop
	
	mov rcx, 0
	mov rax, 0
	mov cx, valuesArray.len
	mov rax [varianceTotal]
	idiv rcx ;divide the variance toatl (storedin rax) by rcx
	mov [varianceAverage], rax
	
	push rax
	call Print64bitNumDecimal
	;------ GOODBYTE ----
	call Printendl
	push goodbyeAct
	call PrintString
	call Printendl
	
;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel


;;TODO:
;print values of the array
;try other values
;calculate  means differences
;sqauer them all
