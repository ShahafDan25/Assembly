;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
	;=========== ALL PROMPTS ARE DEFINED BELOW ================
	lineAct db "===============================", 0ah ,0dh, 0h
	welcomeAct db "Hello World, Assignment #11", 0ah, 0dh, 0h 
	byeAct db "Bye, have a good one", 0ah, 0dh, 0h
	moreArgsAct db "You have entered too many arguments, Please call the program again", 0ah, 0dh, 0h
	lessArgsAct db "You have not entered enough arguments, Please call the program again", 0ah, 0dh, 0h
	goodArgsAct db "Good, you entered only 2 parameters", 0ah, 0dh, 0h
	failedFileAct	db	"Could not open the file, ending program.", 0ah, 0dh, 0h
	successInputFile db 	"Succesfully opened the input file", 0ah, 0dh, 0h
	successOutputFile db 	"Succesfully opened the output file", 0ah, 0dh, 0h
	programActionAct	db	"Copying From the Source ", 0h
	programActionAct2	db	", to the destination ", 0h
	encKeyAct			db		"Please enter the encryption key", 0ah, 0dh, 0h
	encKeyLength		db 		0h						;create key length to read
	

SECTION .bss
	;reserve memory here
	inputFileAddress	resb 	255
	outputFileAddress	resb 	255
	numArgs 			resb 	1				; reserve one byte for how many variable are entered to main
	argument			resq	1
	totalBytes			resq	15
	encKey 				resb 	255
		.len equ ($ - encKey) / 1				;used later for ReadText
	originalFile		resq 	1
	breakTracker		resq	1
	currentBreak		resq	1
	
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
	mov [originalFile], rax
	pop rax
	mov [outputFileAddress], rax					;move into a variance the address of the output file
	mov rax, 0										;clear the rax register
	
	;-------------------- PART 2) open inputFile ------------------
	
	mov rax, 2h										;sys_open
	mov rdi, QWORD [originalFile]				;rdi holds the address of the file
	mov rsi, 0										;Read/Write permission only
	mov rdx, 0
	syscall											;Tickle the Kernel
	cmp rax, 0h
	jl	failedOpening
	mov [inputFileAddress], rax
	push successInputFile
	call PrintString
	
	
	;-------------------- PART 3) open outputFile ------------------
	mov rax, 54h									;get rid of previous copies
	mov rdi, QWORD [outputFileAddress]				;rdi holds the address of the file
	syscall
	;------------ delete any other files with this name, create a new one to encrypt to
	mov rax, 55h									;Create a new file
	mov rdi, QWORD [outputFileAddress]
	mov rsi, 777o									;Thanks for the internet
	mov rcx, 0h										;clear RCX completely
	syscall											;Tickle the Kernel
	cmp rax, 0h
	jl	failedOpening
	mov [outputFileAddress], rax					;if managed to open: bring RAX to that variable
	push successInputFile
	call PrintString
	
	;------ MINI PART: ask the user for an encryption key----------
	push encKeyAct
	call PrintString
	call Printendl
	push encKey
	push encKey.len
	call ReadText									;store input key in encKey
	sub rax, 1
	mov [encKeyLength], rax							;ReadText returns in rax the length of the input
	
	
	
	;------------------- PART 4) notify the user of the action ---------------
	push programActionAct							;push display
	call PrintString								;display
	mov rax, [originalFile]						;prepare to print the name of the input file
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
	mov rax, 45h									;System call break
	mov rdi, 0h										;invalid address
	syscall 										;poke the kernel
	mov [breakTracker], rax									;store the current address in RDX
	;stage: allocate 0ffffh bytes of memory from the break
	mov rdi, rax									;old break in file's data to rdi
	add rdi, 0ffffh									;Add the amountetd wanted dynamic memory to the last break in the file (in RDI)	
	mov rax, 45h									;sys_break
	syscall											;execute orders by the system
	;cmp rax, 0										;allocate (dynamically) 0ffffh bytes
	mov [currentBreak], rax							;not currentBreak has our new location of the break
	
	
	;-------- PART 6) Loop: read 0ffffh bytes from the file into the allocated memory ------------
	;mov rcx, 0ffffh
	; RDX still holds the break in memory for the allocated 0ffffh bytes - might create a variable later
	readFileLoop:									;flag, not a loop
		mov rax, 0h
		mov rdi, [inputFileAddress]
		mov rsi, [breakTracker]
		mov rdx, 0ffffh
		syscall										;Poke the kernel
		mov rcx, rax
		dec rcx										;next byte
		mov r8, rax
		mov rdi, 0
		mov rax, 0
		mov rbx, 0
		
		encryptLoop:
			mov bl, [breakTracker + rdi]
			xor bl, [encKey + rax]					;ancrypt using xor
			mov [breakTracker + rdi], bl
			
			add rdi, 1								;next byte
			add rax, 1								;next byte
			
			push rbx
			mov rcx, 0
			mov rbx, 0
			mov rbx, [encKeyLength]
			div rbx
			mov rax, rdx
			pop rbx									;Restore RBX's value
			
			
		loop encryptLoop
		
		mov rax, 1h									;write to file
		mov rdi, [outputFileAddress]
		mov rsi, [breakTracker]
		mov rdx, r8
		syscall										;poke the kernel with the needed conditions
		
		add r8, 0							
		cmp r8, 0ffffh								;check if we are done reading/encrypting from the file
		jne Exit
		jmp readFileLoop
		

	
	
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


