;
;This program will test out the functions library
;
;
;Include our external functions library functions
;%include "./functions.inc"
 
SECTION .data
	;welcomeAct	db	"Welcome to my progrm", 0ah, 0dh, 0h
	;byeAct db 	"Bye, have a good day!", 0ah , 0dh, 0h
	
	char1 db '8'
	char2 db '2'
	
SECTION .bss
 
SECTION     .text
	global      _start
     
_start:

	;----- WELCOME -----
	;call Printendl
	;push welcomeAct
	;call PrintString ;print the welcome prompt
	;call Printendl ;print empty line
	
	;---------PROGRAM-----------
	mov eax, 0h ;clear out eax
	mov al, [char1] ;put '8' into al
	add al, [char2] ;add '2' into al
	aaa ;ASCII adjsut our total in eax
	or ax,  3030h ;add the 30h's in front of every digit
	
	;----- GOODBYE ---
	;push byeAct
	;call PrintString
	;call Printendl
	
;
;Setup the registers for exit and poke the kernel

	mov		eax,1				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel

