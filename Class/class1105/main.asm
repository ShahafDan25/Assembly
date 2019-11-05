;
;This program will test out the functions library
;
;
;Include our external functions library functions
%include "./functions.inc"
 
SECTION .data
	welcomeAct	db	"Welcome to my progrm", 0ah, 0dh, 0h
	byeAct db 	"Bye, have a good day!", 0ah , 0dh, 0h
	
	dWordvar dd -101
	wordVal dw -101
	byteVal db -101
	
SECTION .bss
 
SECTION     .text
	global      _start
     
_start:

	;----- WELCOME -----
	call Printendl
	push welcomeAct
	call PrintString ;print the welcome prompt
	call Printendl ;print empty line
	
	nop
	
	mov eax, [dWordvar]
	mov edx, 0h
	cdq ;sign extend 32 bit to 64 bit edx:eax
	
	mov ax, [wordVal]
	mov dx, 0
	cwd ;sign extent 16bit ax to 32 bit dx:ax (put together ax dx)
	
	mov al, [byteVal]
	mov ah, 0
	cbw ;sign extend 8 bit al to 16 bit ah:al
	
	;64 bit only! => will only work in a 64 bit system code
	;mov rax, [qwordVal]
	;cqo 		;sign extend 64 bit rax to 128 bit rdx:rax
	nop
	
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

