;
;This program will test out the functions library
;
;
;Include our external functions library functions

%include "./funcs.inc"
SECTION .data
	welcomeAct db "Welcome to Shahaf's Program", 0ah, 0dh, 0h
		.len equ($-welcomeAct)
	byeAct db "Bye, Take Care", 0ah, 0dh, 0h
 
 
	;szLF db 0dh, 0h, 0h ;define an empty line
SECTION .bss
 
SECTION     .text
	global      _start
     
_start:
	;

    ;Code will be ran through main.cpp
;
;Setup the registers for exit and poke the kernel
Exit: 
	mov		eax,1h				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel
