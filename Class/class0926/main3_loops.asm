;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
	
	welcomeAct	db	"Welcome to my progrm", 0ah, 0dh, 0h
	byeAct		db	"Thank you, Goodbye", 0ah,0dh,0h
	
	source 	db		"Soure String Printed", 00h
	szSource	db	$-source	;size of the string to copy
	
SECTION .bss
	;memory reservation goes here
	target	resb	0ffh	;reserve 254 bytes for new string
	
SECTION     .text
	global  _start
     
_start:
	nop ;1 byte
;----HELLO WORLD PROMPT ----
	push welcomeAct;welcome
	call PrintString
	call Printendl
	
	mov esi, 0;clear index reg
	mov cx, [szSource] ;set up a loop counter
	
L1: ;set up the loop
	mov al, [source + esi] ;get char from source
	; this is an indexed prgram because of the line above
	mov [target + esi] ,al	;now store it in the target
	inc esi ;increase theiterator by one
	
	;now let's print it
	push rax
	call Print64bitNumHex
	call Printendl
	
loop L1 ;call L1 flag to go again
	
	
	;----GOODBYE PROMPT ---
	push byeAct ;bye
	call PrintString
	call Printendl
	
;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel
