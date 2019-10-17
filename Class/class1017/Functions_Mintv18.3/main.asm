;
;This program will test out the functions library
;
;
;Include our external functions library functions
%include "./functions.inc"
 
SECTION .data
	welcomeAct db "Hello World", 0ah, 0dh, 0h
	byeAct db "Goodbye", 0ah, 0dh, 0h
	
	anInteger db 10h
 
SECTION .bss
 
SECTION     .text
	global      _start
     
_start:
	nop
	;--- WELCOME ---
	push welcomeAct
	call PrintString
	call Printendl
	
	nop
	
	cmp BYTE [anInteger], 50h
	je theirEqual
	jae itsEitherGreaterThanOrEqual
	jbe itsEitherLessThanOrEqual
	ja isGreaterThan
	jb itsLessThan
	jmp goesHere
	
	goesHere: ;should never happen
		nop
		jmp endit
	
	theirEqual: 
		nop
		;do something because the ineteger wasequal to 50h
		jmp endit
		
	isGreaterThan:
		nop
		;do something becase an integer was greater than 50h
		jmp endit
		
	itsLessThan:
		nop
		;do something becase an integer was less than 50h
		jmp endit
	
	;---GOODBYE ---
	push byeAct
	call PrintString
	call Printendl
	
;
;Setup the registers for exit and poke the kernel
Exit: 
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel
