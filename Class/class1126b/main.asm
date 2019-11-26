;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
	
	welcomeAct	db	"Welcome to my progrm", 0ah, 0dh, 0h
	byeAct db 	"Bye, have a good day!", 0ah , 0dh, 0h
	dash db "-", 0h

	oldBottomAddress	dq 		0h
	newBottomAddress	dq 		0h
	
SECTION .bss
	;memory reservation goes here
	
	programPath		resq		1
	numArguments	resq		1
	argument		resq		1
	
	
SECTION     .text
	global  _start
     
_start:
	
	
	
	;----- WELCOME -----
	call Printendl
	push welcomeAct
	call PrintString ;print the welcome prompt
	call Printendl ;print empty line
	
	nop									; start debuggin point
	;------------ PROGRAM --------------
	
	pop rax								;Get the address of the first argument - program path
	mov [numArguments], rax				;Save our 1st argument in a variable
	
	mov rcx, [numArguments]
	argsLoop:
		pop rax
		mov [argument], rax
		push rax
		call PrintString
		call Printendl
	Loop argsLoop
	
	
	
	nop
	
	;----- GOODBYE ---
	push byeAct
	call PrintString
	call Printendl
;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel

