;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
	
	welcomeAct	db	"Welcome to my progrm", 0ah, 0dh, 0h
	byeAct db 	"Bye, have a good day!", 0ah , 0dh, 0h
	

	oldBottomAddress	dq 		0h
	
SECTION .bss
	;memory reservation goes here
	
	
SECTION     .text
	global  _start
     
_start:
	;----- WELCOME -----
	call Printendl
	push welcomeAct
	call PrintString ;print the welcome prompt
	call Printendl ;print empty line
	
	;------------ PROGRAM --------------
	
	;obtain current 'bottom' of my program
	mov rax, 0h							;Sysbreak call
	mov rdi, 0h							; Return into rax the current bottom of the program
	syscall								;tickle the kernel
	mov [oldBototmAddress], rax
	
	mov rdi, rax						;Move the bottom address inot rdi
	add rsi, 100h						;Increase it by 100
	mov rax, 0h							;Sys_break call
	syscall								;Tickle the kernel
	mov [newBottomAddress], rax			;Save the new bottom
	
	
	
	
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

