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
	
	;Process the Sqitch statment / case table
	mov rcx, caseTable ;number of items in the switch
	mov rsi, caseTable ;put the address of our table into rsi
	mov al, 'C' ;our test value
	
	Switch1:
		cmp al, [rsi] ;compare our value to the lookup table value
		jne Switch1_goAgain
		call NEAR [rsi + 1] ; call the function associated with the found value
		jmp leave_Switch1 ;flag to leave the loop
		
	Switch_goAgain: ;go to the next one
		add rsi, CaseTable.entrySize
	Loop Switch1
	
	leave_Switch1: ;a flag to be called to get out of the loop ;equivalent to break; from a loop in c++
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

Process_A:

ret ;finish Process_A
Process_B:

ret ;finish Process_B
Process_C:

ret ;finish Process_C
Process_D:

ret ;finish Process_D
