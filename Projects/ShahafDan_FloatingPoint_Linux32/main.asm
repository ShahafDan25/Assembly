;
;This program will test out the functions library
;
;
;Include our external functions library functions
%include "./functions.inc"
 
SECTION .data
	welcomeAct	db	"Welcome to my program", 0ah, 0dh, 0h
	byeAct 		db	"Have a cool day", 0ah, 0dh, 0h
	
	enterA		db 	"Enter A's Value (float) please!", 0ah, 0dh, 0h
	enterB		db 	"Enter B's Value (float) please!", 0ah, 0dh, 0h
	enterC		db 	"Enter C's Value (integer) please!", 0ah, 0dh, 0h
	promptA		db 	";ets calculate: ((A+B) * (B / C)) ** 2", 0ah, 0dh, 0h
	prompt		db "((A+B) * (B / C)) ** 2  = ", 0h
	
	nvp db "input not valid, ending program", 0ah, 0dh, 0h
	
SECTION .bss
	
	A resd 1
	B resd 1
	C resd 1
	ApB 	resd	1
	BdC		resd 	1
	ABC		resd	1
	D	resd 	1
SECTION     .text
	global      _start
     
_start:
	
	;============ WELCOME============
	call Printendl;
	push welcomeAct ;prepares to call welcomeAct
	call PrintString ;prints the welcome act
	call Printendl;prints an empty line
	call Printendl
	
	push promptA
	call PrintString
	call Printendl
	;=============== ASSIGNMENT =============
	nop
	
	;-----Print and read first
	mov eax, 0
	push enterA
	call PrintString
	call Printendl
	call InputFloat				;stores input in eax
	jc notValid;lcheck for input validity, if not valid, end porgram
	fstp DWORD [A]
	
	
	
	mov eax, 0
	push enterB
	call PrintString
	call Printendl
	call InputFloat				;stores input in eax
	jc notValid						;lcheck for input validity, if not valid, end porgram
	fstp DWORD [B]
	
	mov eax, 0
	push enterC
	call PrintString
	call Printendl
	call InputUInt				;stores input in eax
	jc notValid
	mov [C], eax
	
	fld dword [A]					;push A onto the stack
	fld dword [B]					;push B onto to second spot in the stack
	fadd							;add A + B
	fstp dword [ApB]					;store A + B in ApB
	
	
	
	fld dword [B]					;St(0) = B
	fild dword [C]					;ST(1) = C
	fwait
	fdiv 							;St(0) = ST0 / St1 = B / C
	fstp dword [BdC]				;store St (0) in BdC
	
			
	fld dword [ApB]					;put in ST0
	fld dword [BdC]					;put in ST1
	fmul 					;multiply the ApB and BdC
	
	fstp dword [ABC]
	
	
	
	fld dword [ABC]
	fld dword [ABC]
	fmul 								;pushin it to the two upper positions in the stack, multiplyling them
	
						;Squaring it
	
	fstp dword	[D]				;store the final reult in the final reserved variable
		
		
		
		
	push prompt
	call PrintString
	mov ebx, [D]
	push ebx
	push 8
	call PrintDWFloat			;not sure about how to print it
	call Printendl
	
	
	nop
	
	notValid:
		push nvp
		call PrintString
		call Printendl
	;================= GOODBYE ===============
	push byeAct ;print the goodbye statment
	call PrintString
	call Printendl
	call Printendl
	
;Setup the registers for exit and poke the kernel
Exit: 
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel
