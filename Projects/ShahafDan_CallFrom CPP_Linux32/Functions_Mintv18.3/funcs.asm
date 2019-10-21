
SECTION .data
	szLF db 0dh, 0ah, 0h
	stdin db 0h
	sys_read db 03h
	

global DisplayText
global Displayendl
global revArray
global ReadText
global addTwoArrays
global addTwo
global multiplyTwo
global pow2
global addArray

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

revArray:
	;put functions code here
	mov ebx, [esp + 4] ;mov to ebx the pointer to the first array
	mov ecx, [esp + 8] ;mov to ecx the pointer to the second array
ret

addTwoArrays:
	mov esi, [esp + 4] ; move to esi the pointer to the first array
	mov ecx, [esp + 8] ;move to ecx the number of utems in the array
	mov edx, [esp + 12] ;move to edi the pointer to the second array
	;coming from the assumption that the length of both arrays (1 and 2) in the same
	
	mov edi, 0;use edi as counter
	addArraysLoop:
		
	
	loop addArraysLoop
	
ret

addTwo:
	mov esi, [esp + 4] ;mov to esi the first pointer to a parameter from the stack
	mov edi, [esp + 8] ;mov to edi the second one from the stack
	mov eax, esi; eax = esi
	add eax, edi;eax = esi + edi
ret ; return eax

multiplyTwo:
	mov esi, [esp + 4] ;mov to esi the first pointer to a parameter
	mov edi, [esp + 8] ;mov to edi the second one
	mov eax, esi; mov x to eax
	mul eax, edi ;multiple eax (x) by y (edi)
ret ;return eax (x*y)

pow2:
	mov esi, [esp + 4] ;copies the value from the stack to esi
	mov eax, esi ;will return eax later at ret
	mov ecx, esi ;multiple eax by esi, esi times
	PowLoop:
		mul eax, esi ;multiple eax by esi
	Loop PowLoop ;traverse through the loop

ret ;always returns eax
	
addArray
	;taken from the presentation
	nop 
	mov esi, [esp + 4] ;copy the first parameter to esi; pointer to an array
	mov ecx, [esp + 8]; copy second parameter to ecx; number of items in the array
	push ebx ;needed when c++
	mov ebx, 0 ;set counter to zero
	mov eax, 0 ;set total to zero
	
	Loop1:
		mov edx. [esi + ebx] ;copy values in edx to eax
		add eax, edx ;add the array value in edx to eax
		add ebx, 4 ;incremeny ebx by a double word size (4 bytes)
	loop Loop1 ;ecx contrains the counter - decrementit and loop
	pop ebx ;needed when C++ calls assembler programs
ret ;return
