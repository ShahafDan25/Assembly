
SECTION .data
	szLF db 0dh, 0ah, 0h
	stdin db 0h
	sys_read db 03h

global DisplayText
global Displayendl
global ReadText
	

DisplayText:
	mov eax, 04h ;we are goin to write something
	mov ebx, 01h ;determine what are we writing to
	int 80h ;Tickle/Poke the Kernel
ret ;finish the function, return 

Displayendl: ;the function imply prints the carriage return and new ilne string
	mov ecx, szLF ;mov the address of the characters to the ecx reg
	mov edx, 03h ;move the length of the character arrays to edx
	mov eax, 04h ;we are goin to write something
	mov ebx, 01h ;determine what are we writing to
	int 80h ;tickle the kernel
ret 

ReadText:
	mov edx, stdin ; we are going to READ 
	;sys_read equ 03h
	;stdin equ 0h
	mov eax, sys_read ;what are we going to read from
	int 80h ;poke the kernel
ret
