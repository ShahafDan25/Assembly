
SECTION .data

	

;------ GLOABLIZE FUNCSTION ----------

global addTwoArrays
global addTwo
global multiplyTwo
global pow2
global addArray
global revArray



;----- REVERSING AN ARRAY -----	
revArray:
	nop
	mov esi, [esp + 4] ;array1
	mov edi, [esp + 8] ;array2
	mov ecx, [esp + 12] ;size of the arrays - should be the same for both array!
	mov eax, 0
	push ebx ;have to do this due to a bug in the system
	L1: ;loop ecx times
		mov ebx, [esi + eax]
		mov [edi + ((ecx- 1 )* 4)], ebx
		add eax, 4
	loop L1
	
	mov eax, edi;move to eax to be returned, the array2 (reversed array1)
	pop ebx;have to do this due to a bug in the system
ret ;automatically will reture eax



;----- ADDING ARRAYS -----	
addTwoArrays: 
	nop	
	mov esi, [esp + 4] ;mov to esi the pointer to the first array
	mov edi, [esp + 8] ;mov to edi the pointer to the second array
	mov edx, [esp + 12] ;mov to edx the third array
	mov ecx, [esp + 16];mov to the ecx the size of the array
	push ebx ;have to do this due to a bug
	mov ebx, 0 ;use ebx as out counter, ebx = 0, increment by 4 (bytes) every loops
	L:
		mov eax, [edi + ebx] ;put in the temp reg the current idexed value
		mov [edx + ebx], eax ;from thet temp reg mov it to the empty array at the same index
		
		mov eax, [esi + ebx] ;;put in the temp reg the current idexed value
		add [edx + ebx], eax ;add that value to the same position in the sum array (3rd array)
		add ebx, 4 ;counter++
	loop L
	mov eax, edx
	pop ebx ;have to do this due a bug
ret ;returns the final eax, therefore eax must inclue the third array


;----- ADDING TWO NUMBERS -----	
addTwo:
	nop
	mov eax, [esp + 4] ;mov to eax the first pointer to a parameter from the stack
	mov edx, [esp + 8] ;mov to edx the second one from the stack
	add eax, edx;eax = eax + edx
ret ; return eax

;----- MULTIPLYING TWO NUMBERS -----	
multiplyTwo:
	nop
	mov esi, [esp + 4] ;mov to esi the first pointer to a parameter
	mov edx, [esp + 8] ;mov to edi the second one
	mov eax, esi; mov x to eax
	mul edx ;multiple eax (x) by y (edi)
ret ;return eax (x*y)


;----- SQUARING A NUMBER -----	
pow2:
	nop
	mov eax, [esp + 4] ;copies the value from the stack to esi
	mul eax
ret ;always returns eax
	
	
	
;----- ADDING ARRAY ELEMENTS -----	
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
