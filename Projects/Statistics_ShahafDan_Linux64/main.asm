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
		.len equ (($ - valuesArray) / 8);divide by 8 because we are using quad word
		
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
	mov rdx, 0; use register to transfer numbers to total
	mov rcx, 0 ;clear counter for loops just in case
	mov cx, valuesArray.len
	;inc ecx
	mov rsi, 0 ;counter
	totalLoop:
		add ax, [valuesArray + rsi]
		push rax
		call Print64bitNumDecimal
		call PrintComma
		inc rsi
	loop totalLoop
	
	mov [total], eax
	push rax
	call Print64bitNumDecimal
	call PrintComma
	call Printendl
	;call Print64bitNumHex
	
	
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
