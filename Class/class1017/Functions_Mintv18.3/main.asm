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
	;jump to L1 if either bit 4,5 or 6 is set in theBL register
	and bl, 00111000b
	cmp bl, 0
		jne L1
	
	;jump to L2 if bits 4,5,6 are all set in the BL register
	and bl, 00111000b
	cmp bl, 00110000b ;equivalent to 3h
		je L2
	
	
	;jump to L3 if Al has the even prity flag (if there was amathematical operation active on it)
	add al, 0
		jp L3
	
	;jump to L4 if eax is negative
	and eax, 8000h
	cmp eax, 8000h
		je L4
	;another way to do it:
	add eax, 0
		js L4
		
	;jump to L5 if ebx - ecx is greater than zero
	mov edx, ebx
	sub edx, ecx
	cmp edx, 0h
		jae L5
		
	;last resort
	jmp goesHere
	
	goesHere: ;last resoort
		nop
		jmp endit
	
	L1:
		nop
		;do something becase an integer was less than 50h
		jmp endit
		
	L2:
		nop
		;do something becase an integer was less than 50h
		jmp endit
		
	L3:
		nop
		;do something becase an integer was less than 50h
		jmp endit
		
	L4:
		nop
		;do something becase an integer was greater than 50h
		jmp endit
		
	L5:
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
