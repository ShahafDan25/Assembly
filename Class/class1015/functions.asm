global addTwo ;make addTwo visible to the linker
global DisplayText
global DispTest


addTwo:
	nop
	
	mov rax, [esp + 8]
	mov rdx, [esp + 16]
	add rax, rdx ;add first and second parameters
	
ret ;--- will return by defauly
	
DisplayText:
	mov eax, 04h
	mov ebx, 01h
	int 80 ;Tickle/Poke the Kernel
ret ;finish the function, return 

 
	
