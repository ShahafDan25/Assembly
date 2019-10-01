;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc" 
;includes the linux libraries from the functions64.inc folder
 
SECTION .data
 
 
	welcomePrompt	db	"Welcome to my 64 bit program", 00h
	goodbyePrompt	db	"Program is ending, goodbye", 00h
	hexnumToPrint 	dq	1234567890123456h
	decNumToPrint	dq	1234567890123456
	
	testRight db "Right", 00h
	testLeft db "Left", 00h
	testCenter db "Center", 00h
	
	;largeArray TIMES 1000000 db -999; create a100000 array with -999
	;largeArray	db	1000000		DUP(-999);indows wy od doing the above
	
	;in class assignment
	byteDataArray db 01,01,01,01,01,01,01,01 ;done here
	;wordDataArray TIMES 5, dw, 0h
	;doubleWordDataArray TIMES 8, dw, 0h
	;quadWordDataArray TIMES 20, dq, 0h
	
	
	;data section, put your variables here
	wordVariable	db	 "This is a message", 0dh, 0ah, 0h
		
SECTION .bss
 
	workArea resb 1024h ;reserve 1024 bytes under the label workArea
	
SECTION     .text
	global  _start
     
_start:

	push [byteDataArray]
	call Print64bitNumHex
	
	;put your code here
	nop;nop 1 bit allocation
	
	
;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel
