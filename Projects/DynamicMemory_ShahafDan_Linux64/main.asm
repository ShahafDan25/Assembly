;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
	; put your variables below
	lineAct db "===============================", 0ah ,0dh, 0h
	welcomeAct db "Hello World, Assignment #11", 0ah, 0dh, 0h 
	byeAct db "Bye, have a good one", 0ah, 0dh, 0h
	moreArgsAct db "You have entered too many arguments, Please call the program again", 0ah, 0dh, 0h
	lessArgsAct db "You have not entered enough arguments, Please call the program again", 0ah, 0dh, 0h
	goodArgsAct db "Good, you entered only 2 parameters", 0ah, 0dh, 0h
	failedFileAct	db	"Could not open the file, ending program.", 0ah, 0dh, 0h
	successInputFile db 	"Succesfully opened the input file", 0ah, 0dh, 0h
	successOutputFile db 	"Succesfully opened the output file", 0ah, 0dh, 0h
	endl db	0ah, 0dh, 0h
		.len equ ($ - endl)
	programActionAct	db	"Copying From the Source ", 0h
	programActionAct2	db	", to the destination ", 0h
	encKeyAct			db		"Please enter the encryption key", 0ah, 0dh, 0h

SECTION .bss
	;reserve memory here
	inputFileAddress	resb 	255
	outputFileAddress	resb 	255
	numArgs 			resb 	1				; reserve one byte for how many variable are entered to main
	argument			resq		1
	totalBytes			resq	15
	encKey 				resb 	1
	
	
	
	
SECTION     .text
	global  _start
     
_start:
	;code goes here
	
	;=============== WELCOME MESSAGE ================
	call Printendl
	push lineAct
	call PrintString
	push welcomeAct
	call PrintString 
	call Printendl
	
	
	;================== ASSIGNMENT ===========================
	;-------- PART 1)  get address from the command line ------------
	pop rax											;put the number of arguments its rax
	mov [numArgs], rax								;save it in numArgs
	sub rax, 1
	cmp rax, 2										;compare it to 2 arguments
	jl lessArgs
	jg moreArgs
	je goodNumberArgs
	
	moreArgs:
	push moreArgsAct
	call PrintString
	call Printendl
	jmp Exit
	
	lessArgs:
	push lessArgsAct
	call PrintString
	call Printendl
	jmp Exit
	
	goodNumberArgs:									;the number of arguments pass is two which is okay
	push goodArgsAct
	call PrintString
	call Printendl
	
	pop rax											; so it will now hold the address of the main program entirely, pop twice
	pop rax											;rax will now store in the inputFile data
	mov [inputFileAddress], rax
	pop rax
	mov [outputFileAddress], rax					;move into a variance the address of the output file
	mov rax, 0										;clear the rax register
	
	;-------------------- PART 2) open inputFile ------------------
	
	mov rax, 2h										;sys_open
	mov rdi, QWORD [inputFileAddress]				;rdi holds the address of the file
	mov rsi, 0										;Read/Write permission only
	mov rdx, 0644o
	syscall											;Tickle the Kernel
	cmp rax, 0h
	jl	failedOpening
	push successInputFile
	call PrintString
	
	
	;-------------------- PART 3) open outputFile ------------------
	mov rax, 2h										;sys_open
	mov rdi, QWORD [outputFileAddress]				;rdi holds the address of the file
	mov rsi, 0										;Read/Write permission only
	mov rdx, 0644o
	syscall											;Tickle the Kernel
	cmp rax, 0h
	jl	failedOpening
	push successInputFile
	call PrintString
	
	;------ MINI PART: ask the user for an encryption key----------
	push encKeyAct
	call PrintString
	call Printendl
	call ReadText									;store input ket in rax
	mov [encKey], rax
	
	
	;------------------- PART 4) notify the user of the action ---------------
	push programActionAct							;push display
	call PrintString								;display
	mov rax, [inputFileAddress]						;prepare to print the name of the input file
	push rax										;push it
	call PrintString								;display it
	push programActionAct2							;push continous display
	call PrintString								;display
	mov rax, 0										;clear it just in case
	mov rax, [outputFileAddress]					;prepare to print the name of the output file
	push rax										;push it
	call PrintString								; print it
	call Printendl									;Empty line
	
	;----------------- PART 5) Dynamically allocate 0ffffh bytes ------------
	;stage: get current break address, store it in currentBreak and in iniital break;
	mov rax, 45										;System call break
	mov rbx, 0										;invalid address
	syscall 										;poke the kernel
	mov rdx, rax									;store the current address in RDX
	
	mov rax, 45										;system break
	mov rbx, rdx									;put the current break address in RBX too
	add rbx, 0ffffh									;allocate (dynamically) 0ffffh bytes
	syscall											;Poke the kernel (now additional 0ffffh in the heap)
	
	;-------- PART 6) Loop: read 0ffffh bytes from the file into the allocated memory ------------
	mov rcx, 0ffffh
	; RDX still holds the break in memory for the allocated 0ffffh bytes - might create a variable later
	readFileLoop:
		
	loop readFileLoop
	
	
	;----------------- Failed Opening File ---------------
	jmp Exit
	failedOpening:
		push failedFileAct
		call PrintString
		call Printendl
	jmp Exit
	
	;=================== GOODBYE MESSAGE =====================
	call Printendl
	push byeAct
	call PrintString
	call Printendl
	push lineAct
	call PrintString
	call Printendl

;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel


;=================== TO DO LIST ======================
; check if the file exists ---- https://gist.github.com/Archenoth/5380671


