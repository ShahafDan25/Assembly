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
	avgAct db "Average is:" , 0ah, 0dh, 0h
	
	valuesArray	dq	-999, 878, 776, -580, 768, 654 ;everything should be signed
		.len equ (($ - valuesArray) /8 );divide by 8 because we are using quad word
		
	total	dq	0h; set total to zero, we will use total / length to calculate he average (mean)
	average dq	0h
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
	
	mov cx, valuesArray.len;set counter
	totalLoop:
	
		mov rax, [valuesArray + rsi]
		;bt rax, 64 ;puts the last bit in the carry flag
		;jc sub ;just in carry (meaning if the left most (most significant) bit is 1, then the number is negative)
		adc [total], rax

		push rax
		call Print64bitNumDecimal
		call Printendl
		mov rax, 0 ;clear every loop just in case, I guess
		add rsi, 8 ;add 8 bit sfor quad word
	loop totalLoop
	
	call Printendl
	mov rbx, [total]
	push rbx
	call Print64bitNumDecimal
	mov rax, [total]
	mov cx, valuesArray.len;set counter	div valuesArray.len ;divide signed rax (total) by rcx (length), then rax will store our integer average
	idiv rcx
	mov [average], rax
	call Printendl
	push rax
	call Print64bitNumDecimal
	;;; ASSUME THAT BY NOW WE HAVE THE TOTAL IN TOTAL
	
	
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
;change array3 from indexed to indirect
;fix array 6
;do windows too
;https://stackoverflow.com/questions/20302276/adding-signed-numbers-in-assembly
