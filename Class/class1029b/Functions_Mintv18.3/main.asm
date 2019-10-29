;
;This program will test out the functions library
;
;
;Include our external functions library functions
%include "./functions.inc"
 
SECTION .data
	welcomeAct	db	"Welcome to my progrm", 0ah, 0dh, 0h
	byeAct db 	"Bye, have a good day!", 0ah , 0dh, 0h
	pA db "Process A", 0ah, 0dh, 0h
	pB db "Process B", 0ah, 0dh, 0h
	pC db "Process C", 0ah, 0dh, 0h
	pD db "Process D", 0ah, 0dh, 0h
	pDefault db "Default Process", 0ah, 0dh, 0h
	CaseTable	db 'A'
				dd Process_A
		.entrySize equ($ - CaseTable)
				db 'B'
				dd Process_B
				db 'C'
				dd Process_C
				db 'D'
				dd Process_D
		.numberOfEntries equ ($ - CaseTable) / CaseTable.entrySize
SECTION .bss
 
SECTION     .text
	global      _start
     
_start:
	nop
	;----- WELCOME -----
	call Printendl
	push welcomeAct
	call PrintString ;print the welcome prompt
	call Printendl ;print empty line
	
	;Process the Sqitch statment / case table
	mov ecx, CaseTable ;number of items in the switch
	mov esi, CaseTable ;put the address of our table into rsi
	mov al, 'D' ;our test value
	
	Switch1:
		cmp al, [esi] ;compare our value to the lookup table value
		jne Switch1_goAgain ; This is not the one
		call NEAR [esi + 1] ; call the function associated with the found value
		;nesr is used to tell the computer we are using an address, not a value
		jmp leave_Switch1 ;flag to leave the loop
		
		Switch1_goAgain: ;go to the next one
			add esi, CaseTable.entrySize
			
	Loop Switch1
		call Switch_default
	
	
	leave_Switch1: ;a flag to be called to get out of the loop ;equivalent to break; from a loop in c++
	;----- GOODBYE ---
	push byeAct
	call PrintString
	call Printendl
	
;
;Setup the registers for exit and poke the kernel
Exit: 
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel
Process_A:
	push pA
	call PrintString
ret ;finish Process_A
Process_B:
	push pB
	call PrintString
ret ;finish Process_B
Process_C:
	push pC
	call PrintString
ret ;finish Process_C
Process_D:
	push pD
	call PrintString
ret ;finish Process_D
Switch_default: ;default condition ;Beleit Breyrah
	push pDefault
	call PrintString
	Loop Switch1
	mov ebx, 9999h
ret
