
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
	; get few parameters:
		; 1) array 1
		; 2) array 2
		; 3) the length of the array
	mov ebx, [esp + 4] ;array1
	mov eax, [esp + 8] ;array2
	mov ecx, [esp + 12] ;size of the arrays - should be the same!
	mov edi, 0 ;counter 1 = 0
	mov esi, ecx ;counter2 = size
	sub esi, 1 ;counter2 = size - 1
	L1: ;loop ecx times
		mov eax, [ebx + esi]
		push eax ;do i really need this line?
		add esi, 4 ;counter1++
		sub edi, 4 ;counter2--
	loop L1
ret ;automatically will reture eax

addTwoArrays: ;??? very confused on how to do this one
	mov ebx, [esp + 4] ; move to ebx the pointer to the first array
	mov ecx, [esp + 8] ;move to ecx the number of utems in the array
	mov edx, [esp + 12] ;move to edx the pointer to the second array
	;coming from the assumption that the length of both arrays (1 and 2) in the same
	mov esi, ecx
	sub esi, 1 ;set counter2 to size - 1
	mov edi, 0;use edi as counter
	addArraysLoop:
		mov eax, ebx
		push eax ;stack of eax to move forward
	
		inc edi;counter1 ++;
		dec esi ;counter2--;
	loop addArraysLoop
	
ret ;returns the final eax, therefore eax must inclue the third array

addTwo:
	mov eax, [esp + 4] ;mov to eax the first pointer to a parameter from the stack
	mov edx, [esp + 8] ;mov to edx the second one from the stack
	add eax, edx;eax = eax + edx
ret ; return eax

multiplyTwo:
	mov esi, [esp + 4] ;mov to esi the first pointer to a parameter
	mov edx, [esp + 8] ;mov to edi the second one
	mov eax, esi; mov x to eax
	mul edx ;multiple eax (x) by y (edi)
ret ;return eax (x*y)

pow2:
	mov eax, [esp + 4] ;copies the value from the stack to esi
	mul eax
ret ;always returns eax
	
addArray:
	;taken from the presentation
	nop 
	mov esi, [esp + 4] ;copy the first parameter to esi; pointer to an array
	mov ecx, [esp + 8]; copy second parameter to ecx; number of items in the array
	push ebx ;needed when c++
	mov ebx, 0 ;set counter to zero
	mov eax, 0 ;set total to zero
	
	Loop1:
		mov edx, [esi + ebx] ;copy values in edx to eax
		add eax, edx ;add the array value in edx to eax
		add ebx, 4 ;incremeny ebx by a double word size (4 bytes)
	loop Loop1 ;ecx contrains the counter - decrementit and loop
	pop ebx ;needed when C++ calls assembler programs
ret ;return
