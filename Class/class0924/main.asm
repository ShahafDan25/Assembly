;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
	Xval	dd 	5h
	Yval 	dd 	10h
	Zval	dd	2h
	
	
	RvalAct	db	"Rval = Xval + (-Yval + Zval) = ", 0h
	welcomeAct	db	"Welcome to my progrm", 0ah, 0dh, 0h
	
SECTION .bss
	;memory reservation goes here
	Rval	resd	1
SECTION     .text
	global  _start
     
_start:
	nop ;1byte
	;code goes here
	push welcomeAct
	call PrintString ;print the welcome prompt
	call Printendl ;print empty line
	
	;now print the rval Act
	push RvalAct
	call PrintString
	
	;befoer all, clean the ebx and eax register
	mov ebx, 0
	mov eax, 0
	;first negte Yval
	mov ebx, [Yval] ;move the vlue of Yval into ebx
	neg ebx ;negate the value stored in ebx (-Y)
	add ebx, [Zval]	;add Zval to ebx, which results in 
	mov eax, [Xval] ;mov whatever is stored in X into eax register (32 bit reg)
	;(-Y + Z)
	sub eax, ebx ;substract ebx from eax X - (-Y + Z)
	mov [Rval], eax ;mov the final value into Rval
	
	;now print the 32 bit register
	push rax
	call Print64bitNumHex
	call Printendl ;print an empty line again
;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel
