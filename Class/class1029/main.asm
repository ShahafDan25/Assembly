;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
	
	welcomeAct	db	"Welcome to my progrm", 0ah, 0dh, 0h
	byeAct db 	"Bye, have a good day!", 0ah , 0dh, 0h
	
	CaseTable	db 'A'
				dq Process_A
		.entrySize equ($ - CaseTable)
				db 'B'
				dq Process_B
				db 'C'
				dq Process_C
				db 'D'
				dq Process_D
		.numberOfEntries equ ($ - CaseTable) / CaseTable.entrySize
	
SECTION .bss
	;memory reservation goes here
	
	
SECTION     .text
	global  _start
     
_start:
	nop ;1byte
	;----- WELCOME -----
	call Printendl
	push welcomeAct
	call PrintString ;print the welcome prompt
	call Printendl ;print empty line
	
	
	
	;----- GOODBYE ---
	push byeAct
	call PrintString
	call Printendl
;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel
