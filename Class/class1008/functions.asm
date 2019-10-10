global addTwo ;make addTwo visible to the linker
addTwo:
	nop
	
	mov rax, [esp + 8]
	mov rdx, [esp + 16]
	add rax, rdx ;add first and second parameters
	
ret ;--- will return by defauly
	
