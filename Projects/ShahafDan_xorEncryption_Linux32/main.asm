;
;This program will test out the functions library
;
;
;Include our external functions library functions
%include "./functions.inc"
 
SECTION .data
	welcomeAct	db	"Welcome to my progrm", 0ah, 0dh, 0h
	byeAct db 	"Bye, have a good day!", 0ah , 0dh, 0h
	menu db "Encrypt / Decrypt Program", 0ah, 0dh,
		 db "1) Enter a String", 0ah, 0dh, 
		 db	"2) Enter an Encryption Key", 0ah, 0dh,
		 db	"3) Print the Input String", 0ah, 0dh,
		 db	"4) Print the Input Key", 0ah ,0dh,
		 db	"5) Encrypt / Display the String", 0ah, 0dh,
		 db	"6) Decrypt / Display the String", 0ah, 0dh,
		 db	"x) Exit Program", 0ah, 0dh,
		 db	"Please Enter One", 0ah, 0dh, 0ah, 0dh, 0h
	
	caseTable 	db '1'
				dq enterString
			.entrySize equ ($ - caseTable)
				db '2'
				dq enterKey
				db '3'
				dq printInputString
				db '4'
				dq printKey
				db '5'
				dq encryptString
				db '6'
				dq decryptKey
				db 'x'
				dq exitProgram
		.numberOfEntries equ ($ - caseTable) / caseTable.entrySize
	
SECTION .bss
	inputString resb 255 ;reserve 255 bits for the inputString variable
	
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
	;---- first: PRINT MENU ---
	push menu;
	call PrintString
	
	mov ecx, caseTable ;mov the number of items in the switch
	mov esi, caseTable ;put the address of our table into the pointer esi register
	
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


; ----- FUNCTION HERE ----
enterString:

ret

enterKey

ret
	
printInputString

ret

printKey

ret

encryptString

ret

decryptKey

ret

exitProgram

ret 



