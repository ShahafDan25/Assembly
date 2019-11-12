;
;This program will test out the functions library
;
;
;Include our external functions library functions
%include "./functions.inc"
 
SECTION .data
	welcomeAct	db	"Welcome to my progrm", 0ah, 0dh, 0h
	byeAct db 	"Bye, have a good day!", 0ah , 0dh, 0h

	
SECTION .bss
 
SECTION     .text
	global      _start
    global myFunc
    global myFunc2
    global myFunc3
_start:
nop
	;----- WELCOME -----
	call Printendl
	push welcomeAct
	call PrintString ;print the welcome prompt
	call Printendl ;print empty line
	
	;---------PROGRAM-----------
	push 11111111h ;arg#1
	push 22222222h ;arg#2
	call myFunc3
	
	;----- GOODBYE ---
	push byeAct
	call PrintString
	call Printendl
	
;
;Setup the registers for exit and poke the kernel
	nop
	mov		eax,1				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel

myFunc: 
	push ebp;save the caller's ebp pointer
	mov ebp, esp ;set up outown ebp - stcak foundation of our function
	
	
	
	mov esp, ebp ;restore our stack pointer - tremvoe any local variables
	pop ebp
ret

myFunc2: 
	push ebp;save the caller's ebp pointer
	mov ebp, esp ;set up outown ebp - stcak foundation of our function
	sub esp, 8 ;allocate two 4 byte integer variables
	;local variable x is: [ebp - 4]
	;local variable y is: [ebp - 8]
	
	mov DWORD [ebp - 4], 11111111h ;set x to 11111111
	mov DWORD [ebp - 8], 22222222h ;set y to 22222222
	
	
	mov esp, ebp ;restore our stack pointer - tremvoe any local variables
	pop ebp
ret

myFunc3: 
	push ebp;save the caller's ebp pointer
	mov ebp, esp ;set up outown ebp - stcak foundation of our function
	sub esp, 8 ;allocate two 4 byte integer variables
	
	;gonna have two arguments sent there from the stack
	mov eax, [ebp + 8] ;put our second argument into eax
	mov eax, [ebp + 12]] ;put our first argument into eax
	
	
	mov esp, ebp ;restore our stack pointer - tremvoe any local variables
	pop ebp
ret

