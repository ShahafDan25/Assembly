;
;This program will test out the functions library
;
;
;Include our external functions library functions

bits 32
extern printf ;bring up the printf function
extern scanf ; bring up scanf option to get user input
 
SECTION .data
	welcomeAct	db	"Welcome to my Program", 0dh, 0ah, 0h	;Prompt String
	byeAct		db	"Have a good day", 0dh, 0ah, 0h
	
	intFormatString	db	0ah, 0dh, "The ineteger value is: %d", 0ah, 0dh, 0h
	intToPrint	dd	10

	floatFormatString	db	"The float value is: %5.4f" , 0ah, 0dh, 0h ;5 digits overall, 4 decimal 
	floatToPrint	dd	57.636541
	
	inputFormatString 	db	"%s", 0
	intInputFormatString db "%u", 0
	
	putInt db "please insert an integer", 0ah, 0dh, 0h
	printInt db 0ah, 0dh, "Printing that integer: ",  0h
	
	pushLine db " ", 0ah, 0dh, 0h
	
SECTION .bss
	;reserve bytes here
	userInput	resb	30h;reserve 30bytes for user input
	intInput	resd	1 ;reserve 4 byte (1 double word) for user int input
SECTION     .text
	global      main
     
main:
	;---------SCANNING ----
	push welcomeAct
	call printf
	add esp, 4 ;= pop eax
	
	push userInput ;Put the user input buffer into the stack
	push inputFormatString
	call scanf
	add esp, 8 ;clean up the stack
	
	;print space:
;
	
	push userInput ;print the contents of what the user input
	call printf
	add esp, 4

	push pushLine ;print the contents of what the user input
	call printf
	add esp, 4

    ;-----PRINTING INTS AND FLOATS ----
    ;print our integer using C Routine
    push DWORD [intToPrint]
    push intFormatString
    call printf
    pop eax
    pop eax
    add esp, 8 ;alternative for doing 2 pops
    
    ; DO NOT remove or change the lines below here.
    ; THese exist out of the application and back to linux in an orderly fashion
    ; THese exist out of the application and back to linux in an orderly fashion
    
    ;Print our floating point using C Routine
    finit
	mov eax, floatToPrint ;put our float into eax
	fld  DWORD [eax]
	fstp QWORD [esp]
	push floatFormatString
	call printf
	add esp, 12
	;pop eax ;next three lines is the alternative to adding to esp
	;pop eax
	;pop eax
	
	
	;-----SCANNING AN INTEGER---- then printing it
	push pushLine
	call printf
	add esp, 4 ;pop eax
	
	push putInt
	call printf
	add esp, 4
	
	push intInput
	push intInputFormatString
	call scanf ;get user input
	add esp, 8 ;clear the stack, pop eax times 2
	
	push printInt
	call printf
	add esp, 4
	
	push DWORD [intInput]
	push intFormatString
	call printf
	add esp, 8 ;clean up the stack
	
	push pushLine
	call printf
	add esp, 4
;
;Setup the registers for exit and poke the kernel
;Exit: 
	mov		eax,1				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel
