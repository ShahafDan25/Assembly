;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
	
	welcomeAct	db	"Welcome to my progrm", 0ah, 0dh, 0h
	byeAct		db	"Thank you, Goodbye", 0ah,0dh,0h
	
	byteArray 	db 		10h, 20h, 30h, 40h, 50h;define an array of 5 elemnts ech one a byte long
	qwordArray	dq		10h, 20h, 30h, 40h	;define an array of 4 elements each two bytes long
	
SECTION .bss
	;memory reservation goes here
	Rval	resd	1
SECTION     .text
	global  _start
     
_start:
;----HELLO WORLD PROMPT ----
	push welcomeAct;welcome
	call PrintString
	call Printendl
	
	movzx 	rax, 	BYTE [byteArray + 0]
	movzx 	rax,	BYTE [byteArray + 1]
	
	mov  	rsi,	byteArray	;esi for 32 bit  -  will contain the address of the array
	movzx	rax		,BYTE [rsi]	 	;moves the first entry into rax
	add 	rsi, 	1	;point to the second entry
	movzx 	rax, BYTE [rsi]	;move the second entry intro rax
	
	mov	rsi, 	qwordArray	;will contain the address of the uad-word array
	mov rax, 	QWORD [rsi]		;copies the first entry into rax
	add rsi, 8		;point to the second quad-word array entry
	mov	rax,	QWORD [rsi]	;Copies the second entry into rax
	
	
	;stack is  temporry storing location\
	;I still not sure I understan what rsi is
	
	
	;----GOODBYE PROMPT ---
	push byeAct ;bye
	call PrintString
	call Printendl
	
;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel
