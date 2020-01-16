;
;This program will test out the functions library
;
;
;Include our external functions library functions
%include "./functions.inc"
 
SECTION .data
	welcomeAct	db	"Welcome to my program", 00h

	vA	 db		10h ;define byte of 10 hexa ;8
	vB	 dw 	2000h ;define a work of 2000 hexa ;16
	vC 	 dd 	30000h ;define a double word of 30000 hexa ;32
	vD  	 dd	 0h ;define an empty doubel word ;32
	
	actOne	db 'A + (B + C) = D = ', 00h
	actTwo 	db	'(A + C) - B = D = ', 00h
	
	goodbyeAct	db	"Thank you, Enjoy the rest of day", 00h
SECTION .bss
 
SECTION     .text

	
	global      _start
     
_start:
	
	;Display Program Header 
	;code should be going in here
	call Printendl;
	push welcomeAct ;prepares to call welcomeAct
	call PrintString ;prints the welcome act
	call Printendl;prints an empty line
	call Printendl
	
	mov eax, 0 ;clear eax register
	mov ax, [vB] ;start with B, move it to ax 16 bit register
	;since C is a 32 bit variabloe, we will add into eax, which already includes thax, which contains the B variable
	add eax, [vC]
	;now, we want to add the 8 bit variable (1 byte) to the eax register, so we will add it to the ah regiter which is of the sam eize
	add al, [vA]
	;now, whatever is stored in the eax register (A + (B + C)), we will add to the variable D
	mov [vD], eax ;we want to dereference so we use the brackets
	
	; now we want to print D, to show we have the right value in there
	;we will push it and then call a function to print it
	
	push actOne
	call PrintString
	
	push eax ;could not call the variable value for some reason, so I just called to register to print whatever it stores
	call Print32bitNumHex
	call Printendl
	call Printendl
	
	;; lets runs act tow, with the substraction action
	push actTwo
	call PrintString

	mov eax, 0 ;clear again the eax register
	mov al, [vA]	;move a 1 byte variable into an 8 bit register
	add eax, [vC] ;add the C variable into the 32 bit register, macthing its size
	;so far we have done A + C in the eax register
	
	sub eax, [vB] ;we now substract the B variable from the eax register, meaqning we substract the ax register value of B from eax
	
	mov [vD], eax ;mov the value stored in eax into the variable D
	
	push eax
	call Print32bitNumHex
	call Printendl
	call Printendl
	
	push goodbyeAct ;print the goodbye statment
	call PrintString
	call Printendl
	call Printendl
	
;Setup the registers for exit and poke the kernel
Exit: 
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel
