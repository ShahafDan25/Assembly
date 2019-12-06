;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
%include "./stats.inc"
 
SECTION .data
	; put your variables below
	lineAct db "===============================", 0ah ,0dh, 0h
	welcomeAct db "Hello World, Assignment #8:", 0ah, 0dh, "We will now calculate the variance of the following values" , 0ah, 0dh, 0h
	goodbyeAct db "Bye, have a good one", 0ah, 0dh, 0h
	avgAct db "Average is: ", 0h
	totalAct db "Total is: ", 0h
	valuesAct db "the values given are: ", 0h
	VarianceAct db "The Variance is: ", 0h
	PrintMinus db "-", 0h
	
	
	valuesArray	dq	-512, -3, 245, 800, -88 ;everything should be signed
		.len equ (($ - valuesArray) /8 );divide by 8 because we are using quad word
	;valuesArray	dq	-365, -722, 567, -876, -222 ;everything should be signed
	;	.len equ (($ - valuesArray) /8 );divide by 8 because we are using quad word
		
SECTION .bss
	
	
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
	push valuesArray.len
	push valuesArray
						;push into the stack frame	
	call calcvariance					;call the variable
		
	
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



;============= SPACE FOR CONVENIENCE ==================




;//// TODO

;3. dont forget to pop unused values
;4. Print Prompts and Minuses
;5 Leave as many comments as possible








