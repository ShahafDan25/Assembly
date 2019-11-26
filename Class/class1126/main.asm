;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
	
	welcomeAct	db	"Welcome to my progrm", 0ah, 0dh, 0h
	byeAct db 	"Bye, have a good day!", 0ah , 0dh, 0h
	

	oldBottomAddress	dq 		0h
	newBottomAddress	dq 		0h
	
SECTION .bss
	;memory reservation goes here
	
	programPath		resq		1
	argumentOne		resq		1
	argumentTwo		resq		1
	argumentThree	resq		1
	numArguments 	resq		1
	
	
SECTION     .text
	global  _start
     
_start:
	
	
	
	;----- WELCOME -----
	call Printendl
	push welcomeAct
	call PrintString ;print the welcome prompt
	call Printendl ;print empty line
	
	nop									; start debuggin point
	;------------ PROGRAM --------------
	
	pop rax								;Get the number of arguments and put into rax
	mov [numArguments], rax				;Sav ethe number of arguments
	pop rax								;Get the address of the first argument - program path
	mov [programPath], rax				;Save our 1st argument in a variable
	pop rax								;get the address of our first argument
	mov [argumentTwo], rax				;save our 2nd arguyment argument
	pop rax								;Get the address of the second argument
	mov [argumentThree], rax			;Save our 3rd agument into a variable
	
	
	
	
	;to pass arguments to main:
	;first argument is the program path
	;simply go to kdbg main
	;top bar menu: click execution > arguments > types arguments with spaces to separate
	
	
	;obtain current 'bottom' of my program
	mov rax, 0ch						;Sysbreak call ;0ch into rax is the code for systeam break call
	mov rdi, 0h							;Return into rax the current bottom of the program
	syscall								;tickle the kernel
	mov [oldBottomAddress], rax			;Save the old bottom
	
	
	;Allocate 100h bytes to the memory area
	mov rdi, rax						;Move the bottom address inot rdi
	add rdi, 100h						;Increase it by 100
	mov rax, 0ch							;Sys_break call
	syscall								;Tickle the kernel
	cmp rax, 0							;Did the realloction work? (reallocation of memory)
	jl allocationError					;Jump to that label (flag....) if rax holds a negative number
	mov [newBottomAddress], rax			;Save the new bottom
	
	mov rcx, 100h						;Let's fill our newly allocated memory with 0ah
	mov rsi, [oldBottomAddress]			;Addres sof our old last bytewhich is the first new byte of our
	PhilLoop:							;Allocated memory loop
		mov  [rsi], BYTE 0ah					;put an 'a' there
		inc rsi							;Go to the next memory location
	Loop PhilLoop						;Loop it
	
	;Restore our orginal memory data (deete the previously allocated memory)
	mov rax, 0ch						;sys_brk call
	mov rdi, [oldBottomAddress]			;our original memory bottom
	syscall
	
	allocationError:					; allocation did not go as planned flag / label
	nop 								;1 byte break
	
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

