;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
	byteVar1 	db 	0h
	byteVar2 	db 	0h
	
	wordVar1	dw 	0h
	wordVar2 	dw 	0h
	
	dwordVar1 	dd 	0h
	dwordVar2	dd  0h
	
	
	
	
SECTION .bss
 
SECTION     .text
	global  _start
     
_start:
	;code goes here
	;first assign both byteVar1 and byteVar2 to two diferent reisters
	mov al, [byteVar1] ;move byteVar1 to al register
	mov ah, [byteVar2] ;move byteVar2 to ah register
	
	xchg al, ah ;exchanges both the al and ah registers
	
	mov [byteVar1], ah ;move back frm the xchanged register into the variable
	mov [byteVar2], al ;move back from the xchanged reister into the variable
	
	
;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel
