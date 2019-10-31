;
;This program will test out the functions library
;
;
;Include our external functions library functions
%include "./functions.inc"
 
SECTION .data
	welcomeAct	db	"Welcome to my progrm", 0ah, 0dh, 0h
	byeAct db 	"Bye, have a good day!", 0ah , 0dh, 0h
	
	printOne db "CF: 1", 0h
	printZero db "CF: 0", 0h
	number dd 11001100111000110101110111101110b ;i hope I got this right
		.size equ ($ - number)*4; ;amount of bits in there
SECTION .bss
 
SECTION     .text
	global      _start
     
_start:
	nop
	;----- WELCOME -----
	call Printendl
	push welcomeAct
	call PrintString ;print the welcome prompt
	call Printendl ;print empty line
	
	;---ASSIGNMENT---
	;using a loop:
	;	rotate your number
	;	check the content of the carry flag
	;	if on print 1, else print 0
	;when done, print an endl and end the program
	;DO NO destroy the value o fnumberToPrint - it should have the same value ->
	; it did when the program began
	mov eax, [number] ;move to eax the nubmer
	mov ecx, number.size ;set counte rto the amount of bits
	rotateLoop:
		ROL eax, 1 ;rotate eax 1 time
		jc carrySet
		push printZero
			call PrintString
			call Printendl
		carrySet:
			push printOne;
			call PrintString
			call Printendl;
		
	loop rotateLoop ;go back to the loop flag
	call Printendl
	;----- GOODBYE ---
	push byeAct
	call PrintString
	call Printendl
	
;
;Setup the registers for exit and poke the kernel
Exit: 
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel

