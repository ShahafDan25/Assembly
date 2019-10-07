;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
	; put your variables below
	welcomeAct db "Hello World", 0ah, 0dh, 0h
	goodbyeAct db "Bye, have  good one", 0ah, 0dh, 0h
	
	indexedAct db "Adding Array4 and 5 and put it in Array6, INDEXED OPERAND", 0ah,0dh,0h
	indirectAct db "Adding Array1 and 2 and put it in Array3, INDIRECT OPERAND", 0ah,0dh,0h
	
	;define an array
	Array1	db	10h, 30h, 0F0h, 20h, 50h, 12h 
		.len	equ($-Array1) ;length of Array1
		
	Array2	db	0E0h, 40h, 22h, 0E5h, 40h, 55h 
		.len	equ($-Array2) ;length of Array2
		
	Array4	dd	11BDh, 3453h, 2FF0h, 6370h, 3350h, 1025h
		.len	equ($-Array4) ;length of Array4
		
	Array5	dd	0FFFh, 0C3Fh, 22FFh, 0EF53h, 400h, 5555h 
		.len	equ($-Array5) ;length of Array5
		
	testAct db "Test", 0ah,0dh,0h
	;;DO NOT USE MOVZX
		
SECTION .bss
	;reserve memory here
	Array3 resb 6 ;reservse 6 bytes for Array 3
		.len	equ($-Array3)
	Array6 resb 64 ;reserve (6quadwords * 4 bytes =) 24 bytes for Array6
		.len	equ	($-Array6) ;reserve the length,size of the Array6. current uninitialized
SECTION     .text
	global  _start
     
_start:
	;code goes here
	;--------- WELCOME ---------
	call Printendl
	push welcomeAct
	call PrintString 
	call Printendl
	
	
	;----- PART B ------ DID THIS IS THE INDEXED OPERAND WAY
	; 0. set rsi and eax to 0, reset both
	; 1. loop to move an element from Array1 to a reg
	; 2. add the rsi'th value from Array2 to that register
	; 3. add the value from that register, to the Array3
	
	;first, print prompt
	call Printendl
	push indirectAct
	call PrintString
	call Printendl
	
	
	mov rcx, Array1.len ;clean rax 
	mov rsi, 0 ;set rsi (count) to zero
	L1:
		mov rax,0 
		mov rbx,0
		;movzx rax, BYTE [Array1 + Array1.len - 1 - rsi] >>> CANT USE MOVZX/SX
		mov al, BYTE [Array1 + rsi] ;if we want to add the last element
		mov bl, BYTE [Array2 + rsi]
		add rax, rbx ;add rxb to rax
		mov [Array3 + rsi], rax
		
		inc rsi ;count++
	Loop L1 ;goto L1 flag
	
	;---print array 3 to check:
	mov rcx, 0;clean rcx, just in case
	mov rcx, Array3.len
	mov rsi, 0
	Lprint1:
		mov rax, 0
		mov al, [Array3 + rsi]
		push rax
		inc rsi
		call Print64bitNumHex
		call PrintComma
	Loop Lprint1
	
	call Printendl
	
	
	;-----PART 3 ------ INDEXED
	;print prompt first:
	call Printendl
	push indexedAct
	call PrintString
	call Printendl
	
	;coming from the assumption that Array4 and 5 are the same size
	mov rcx, 0 ;clean rcx, just in case
	mov rcx, Array4.len
	mov rsi, 0; ;set rsi (count to zero)
	L2:	
		mov rax, 0
		mov rbx, 0
		mov eax, DWORD [Array4 + rsi] ;add the last element
		mov ebx, DWORD [Array5 + rsi]
		;now we have the rsi'th value stored in the eax from Array1 and in the ebx from Array2
		;we now want to add them together and put it in Array6
		add rax, rbx ;adding the value in rbx, to the one in rax (which is in eax)
		mov [Array6 + rsi], rax ;mov that value into the rsi'th position in Array6
		inc rsi ;counter++;
	Loop L2
	
	;---print array6  to check
	mov rax, [Array6]
	push rax
	call Print64bitNumHex
	call Printendl
	
	;------ GOODBYTE ----
	call Printendl
	push goodbyeAct
	call PrintString
	call Printendl
	
;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel
