;
;This program will test out the functions library
;
;
;Include our external functions library functions
%include "./functions.inc"
bits 32
 ;extern printf
 ;extern scanf
SECTION .data
	welcomeAct	db	"Welcome to my Program", 0dh, 0ah, 0h	;Prompt String
		.len equ($-welcomeAct);
		
	byeAct		db	"Have a good day", 0dh, 0ah, 0h
	
	pushLine db " ", 0ah, 0dh, 0h
	
SECTION .bss

SECTION     .text
	global      _start
     
_start:
	finit
	;---WELCOME---
	push welcomeAct
	;call PrintString
	add esp, 4 ;pop eax
	
	push pushLine
	;call printf
	add esp, 4 ;pop eax
	
	;--- PRINT USING KERNEL ---
	mov ecx, welcomeAct ;ecx contains the address of the strin we wish  to print
	mov edx, welcomeAct.len	;edx, contains the length of the welcomeAct string
	mov eax, 04h ;eax contains the action we want to take: 4h = write
	mov ebx, 01h ;ebx contains the destination of the action: 1h = stdout (!!!)
	;int 80 ;tickle the kernel
	
	;---GOODBYE---
	push byeAct
	;call printf
	add esp, 4 ;popo eax

	;EXIT PROTOCOl
	mov		eax,1				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel
