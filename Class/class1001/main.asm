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
	
	;define an array
	array1	db	10h, 20h, 30h, 40h, 50h ;5 items in this array. each is a byte
		.len	equ($-array1) ;create accessibility variable to the length of the array - how many items?
		
	aVar dd 0h
		
SECTION .bss
	;reserve memory here
 
SECTION     .text
	global  _start
     
_start:
	;code goes here
	;---------HELLO---------
	push welcomeAct
	call PrintString 
	call Printendl
	
	;----------STACK CODE --------
	push 10h ;push to stack
	push 20h ;push to stack
	push 30h ;push to stack
	
	pop rax
	push rax
	call Print64bitNumHex ;print the register we pushed
	call Printendl
	
	pop rax
	push rax
	call Print64bitNumHex ;print rax again
	call Printendl
	
	pop rax
	push rax
	call Print64bitNumHex ;print rax again
	call Printendl
	
	
	;------ EQUIVALENT STACK CODE ----
	push 40h
	push 50h
	push 60h
	
	pop rbx
	push 0h
	pop rbx
	pop rbx
	; it does not actually removes that item from the stack, rather points the pointer to the next item in the stacke
	mov rcx, 100
	loop1:
		push 0h
		call Print64bitNumHex ;print rax again ;will print 0h (currently being pointed to)
		;a hundred times
	Loop loop1
	
	
	
	;------ ARRAY STACK CODE ----
	mov rax, 0 ;clean rax first
	call Printendl
	call Printendl
	call Printendl
	;push address and array contents onto stack
	push array1 ;push OFFSET array1 in windows
	push array1.len ;push the size of the array (LENGTHOF - windows method)
	
	
	movzx rdx, BYTE [array1] ;push the first value in the array onto the stack
	push rdx
	
	call Print64bitNumHex ;print again value in rax
	call Printendl
	
	mov rdx, 0h	;move 0h into rdx
	mov al, [array1] ;move first element of array1 into al register
	push rdx
	call Print64bitNumHex
	call Printendl
	
	;---NESTED LOOPS ---
	call Printendl
	call Printendl
	mov rcx, 3 ;set an outer loop counter
	OuterLoop:
		mov [aVar], rcx ;aVar = rcx + 10
		add DWORD [aVar], 10 ;
		add [aVar], rcx
		push rcx ;save the outerloop counter
		mov rcx, 5 ;set inner loop count to 5 (do it 5 times)
			InnerLoop:
				;do something in this loop
				mov rdx, rcx ;mov value from rcx to rdx
				push rdx
				call Print64bitNumHex
				call Printendl
			Loop InnerLoop
			pop rcx ;restore the value of the outer loop counter
		Loop OuterLoop
	
	
	;------GOODBYTE----
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
