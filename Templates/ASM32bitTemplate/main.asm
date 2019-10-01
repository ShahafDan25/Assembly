; Assembler 32bit template

bits 32
section .data
;variables with values go here
	
	byteVariable db 12h 				;byte = 8bites or 2 nibles
	wordVariable dw 3456h 				;Wrod = 16bits or 4 nibbles	
	dwordVariable dd 78901234h 			;Double Word = 32 bits or 8 nibbles
	qwordVariable dq 1234567812345678h 	;Quad word = 64 bit or 16 nibbles
	fwordVariable dd 123.45				;Double Word floating point of 32 bits
	fqwordVariable dq 123.45			;Quad Word floating point of 64bits
	
	
section .bss
;reserved memory goes here
section .text
;Your program code goes here

	global _start
_start:
    nop
	
	;Your program code should go here
	mov eax, 0ffffffffh
	mov ax, 2222h
	mov al, 33h
	mov ah, 44h
	
	;Do not remove/change the lines below here.
	;These exit out of the application and back
	;to linux in an orderly fashion
	nop
	mov eax,1      ; Exit system call value
	mov ebx,0      ; Exit return code
	int 80h        ; Call the kernel
