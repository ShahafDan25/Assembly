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
	
	pop rax
	push 0h
	pop rax
	pop rax
	; it does not actually removes that item from the stack, rather points the pointer to the next item in the stacke
	mov rcx, 100
	loop1:
		push 0h
		call Print64bitNumHex ;print rax again
	Loop loop1
	
	
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
