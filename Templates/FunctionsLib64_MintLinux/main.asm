;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
 
	welcomePrompt	db	"Welcome to my 64 bit Program", 00h
	goodbyePrompt	db	"Program ending, have a great day!", 00h
		
	hexNumToPrint	dq	1234567890123456h
	decNumToPrint	dq	1234567890123456
	
	testRight		db	"Right", 00h
	testLeft		db	"Left", 00h
	testCenter		db	"Center", 00h
 
SECTION .bss
 
SECTION     .text
	global  _start
     
_start:

	push	welcomePrompt
	call	PrintString
	call	Printendl
	call	Printendl
			
	mov		rax, 10h
	mov		rcx, 20h
	mov		rdx, 30h
	mov		rbx, 40h
	mov		rsi, 50h
	mov		rdi, 60h
	mov		rbp, 70h
	mov		r8, 80h
	mov		r9, 89h
	mov		r10, 10h
	mov		r11, 11h
	mov		r12, 12h
	mov		r13, 13h
	mov		r14, 14h
	mov		r15, 15h
	call	PrintRegisters
	call	Printendl
	
;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel
