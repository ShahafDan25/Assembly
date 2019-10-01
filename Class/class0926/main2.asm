;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
	
	welcomeAct	db	"Welcome to my progrm", 0ah, 0dh, 0h
	byeAct		db	"Thank you, Goodbye", 0ah,0dh,0h
	
	byteArray 	db 		10h, 20h, 30h, 40h, 50h;define an array of 5 elemnts ech one a byte long
		.len	equ ($-byteArray) ;get the length of the array
	qwordArray	dq		10h, 20h, 30h, 40h	;define an array of 4 elements each two bytes long
	;we can get the length of this array by:
		.len	equ($-qwordArray)/8 
SECTION .bss
	;memory reservation goes here
	Rval	resd	1
SECTION     .text
	global  _start
     
_start:
;----HELLO WORLD PROMPT ----
	push welcomeAct;welcome
	call PrintString
	call Printendl
	
	;Indirect
	;1)Adress into reg.
	;2)modify value inside reg.
	
	;indexed
	;1)Put an offsetr value in reg.
	;2)Modify offset in register
	
	
	;adding up all entries in the array using indexed methos:
	mov rax, 0 ;clear the rax register
	mov rbx, 0 ;clear the rbx register
	mov	rsi,	byteArray ;move byteArray address into rsi
	movzx	rax,	BYTE [rsi]	;mov 10h
	inc	rsi ;increases rsi by 1
	mov bl, [rsi] ;mov 20 into bl
	
	add rax, rbx	;add 20 to rax
	inc rsi
	mov bl, [rsi]
	add rax, rbx ;add 30 to rax
	inc rsi
	mov bl, [rsi]
	add rax, rbx
	
	push rax
	call Print64bitNumHex
	call Printendl;
	call Printendl;
	
	;-----------USING LOOPS --------------
	mov rcx, 5 ;size of our array
	mov rax, 0 ; clear out the total reg
	mov rbx, 0;clear out the temp reg
	
	mov rsi,byteArray
	addloop: ;this is a jump loop
		

		mov bl, [rsi] ;mov rsi value into bl
		add rax, rbx ;add value in rbx to total in rax
		inc rsi
		
		;Print inside a loop code:
		push rax
		call Print64bitNumHex
		call Printendl
		
		
	LOOP addloop ;call to return to the loop again
	addLoop_exit:	;this is the exit loop value
	;----- FINISHING LOOP ----
		call Printendl;
	
	;Adding up all entries in the array using indexed
	mov	rax, 0
	mov rbx, 0
	mov rsi, 0 ;put the offset from the beginning of the array into rsi
	;by now we cleared all rax,rab and rsi registers
	
	movzx	rax, BYTE	[byteArray + 1] ;copy 10 into rax: byteArray address + 0
	add rsi, 1 ;position offset to the next value (20)
	mov bl, [byteArray + rsi]	;put 20 into bl register
	add rax, rbx ;adds 20 to rax
	
	;test
	push rax
	call Print64bitNumHex
	call Printendl;
	call Printendl;
	
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
