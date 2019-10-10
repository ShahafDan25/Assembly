;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
	; put your variables below
	welcomeAct db "Hello World", 0ah, 0dh, 0h
	goodbyeAct db "Bye, have  good one", 0ah, 0dh, 0h
	
		
SECTION .bss
	;reserve memory here
 
SECTION     .text
	global  _start
     
_start:
	;code goes here
	;---------HELLO---------
	push welcomeAct
	call PrintString 
	call Printendl
	
	
	;------GOODBYTE----
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
