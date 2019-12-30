;
;Example program to execute 64-bit functions in Linux
;Shahaf Dan
;Assembly Fall 2019


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
	failedFileAct	db	"Could not open the file, ending program.", 0ah, 0dh, 0h
	programActionAct	db	"Copying From the Source ", 0h
	programActionAct2	db	", to the destination ", 0h
	encKeyAct			db		"Please enter the encryption key", 0ah, 0dh, 0h
	totalBytes			db		0h
	totalBytesAct		db		"-------- Total Bytes Encrypted: ", 0h
		.len equ ($ - totalBytesAct)
	allocError			db		"There was a provlem allocating memoery", 0ah, 0dh, 0h
	
	debug1 db "1", 0h
	debug2 db "2", 0h
	
SECTION .bss
	;================ RESERVED MEMORY BELOW =================
	inputFileAddress	resb 	255
	outputFileAddress	resb 	255
	numArgs 			resb 	1				; reserve one byte for how many variable are entered to main
	argument			resq	1
	encKey 				resb 	255
		.len equ ($ - encKey) / 1				;used later for ReadText
	originalFile		resq 	1
	breakTracker		resq	1
	currentBreak		resq	1
	tempName			resb 	255
	encKeyLength		resq	1
	travCount			resq	1
	bigTotalBytes		resq	15	
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
	nop

	mov rax, 0ch
	mov rdi, 0
	syscall
	mov [breakTracker], rax							;move the beginning to the first break tracker
	
	mov rdi, rax
	add rdi, 0ffffh									;add 0ffffh to rdi (dynamic array)
	mov rax, 0ch
	syscall											;Poke the kernel
	cmp rax, 0
	jl Exit
	mov [currentBreak], rax

	pop rax											;put the number of arguments its rax
	mov [numArgs], rax								;save it in numArgs
	sub rax, 1
	cmp rax, 2										;compare it to 2 arguments
	jl lessArgs
	jg moreArgs
	je goodNumberArgs
	
	moreArgs:										;Print prompt of too many arguments 
	push moreArgsAct
	call PrintText
	call Printendl
	jmp Exit
	
	lessArgs:										;Print prompt of too little arguments
	push lessArgsAct
	call PrintString
	call Printendl
	jmp Exit
	
	goodNumberArgs:									;the number of arguments pass is two which is okay
	
	pop rax											; so it will now hold the address of the main program entirely, pop twice
	pop rax											;rax will now store in the inputFile data
	mov [originalFile], rax
	pop rax
	mov [outputFileAddress], rax					;move into a variance the address of the output file
	mov [tempName], rax
	mov rax, 0										;clear the rax register
	;-------------------- PART 2) open inputFile ------------------
	
	mov rax, 2h										;sys_open
	mov rdi, QWORD [originalFile]					;rdi holds the address of the file
	mov rsi, 442h									;Read/Write permission only
	mov rdx, 2h										
	syscall											;Tickle the Kernel
	cmp rax, 0h
	jl	failedOpening								;File did not open
	mov [inputFileAddress], rax
	mov rax, 0h

	mov rax, 54h									;get rid of any previous versions a file with that could have
	mov rdi, [outputFileAddress]					;
	syscall											;Poke the kernel
	;------------ PART 3) delete any other files with this name, create a new one to encrypt to
	mov rax, 55h									;Create a new file
	mov rdi, QWORD [outputFileAddress]
	mov rsi, 666o									;Thanks for the internet
	mov rcx, 0h										;clear RCX completely
	syscall											;Tickle the Kernel
	cmp rax, 0h
	jl	failedOpening
	mov [outputFileAddress], rax					;if managed to open: bring RAX to that variable

	;------ MINI PART: ask the user for an encryption key----------
	push encKeyAct
	call PrintString

	push encKey										;push the variable to store user input in
	push encKey.len									;push its length
	call ReadText									;store input key in encKey
	sub rax, 1
	mov [encKeyLength], rax							;ReadText returns in rax the length of the input

	
	
	;------------------- PART 4) notify the user of the action ---------------
	call Printendl
	push programActionAct							;push display
	call PrintString								;display
	mov rax, [originalFile]							;prepare to print the name of the input file
	push rax										;push it
	call PrintString								;display it
	push programActionAct2							;push continous display
	call PrintString								;display
	xor rbx, rbx									;clear it just in case
	mov rbx, [tempName]								;prepare to print the name of the output file
	push rbx										;push it
	call PrintString								; print it
	call Printendl									;Empty line
	call Printendl
	
	nop												;for kdbg debugging purposes (1 byte)
	
	
	;---------------------- OPENING THE FILE ----------------------------
	mov rax, 2h												;open the file first
	mov rdi, [tempName]										;temp name is used to store the outputfile address that we may have detroyed
	mov rsi, 0442h
	mov rdx, 2h
	syscall
	cmp rax, 0
	jl failedOpening										;poke the kernel with the needed conditions



	readFileLoop:									;flag, not a loop
	;----------------- PART 5) Dynamically allocate 0ffffh bytes -----------
		mov rax, 0
		mov rdi, [inputFileAddress]							;move to rdi the name of the input file
		mov rsi, [breakTracker]								;move to rsi the last point in the memory tracked
		mov rdx, 0ffffh										;rdx to be the next value to be allocated
		syscall												;poke the kernel
		cmp rax, 0											;compare rax to zero (returned from syscall)
		jl allocationError
		mov [totalBytes], rax								;move it to the total bytes to keep track of it
		

	;-------- PART 6) Loop: read 0ffffh bytes from the file into the allocated memory ------------
		mov rsi, 0											;
		mov rsi, encKey										;move the encryptiong key address to rsi
		mov rax, 0
		mov al, BYTE [encKeyLength]							;one byte at a time, move to rax
		mov rdi, 0								
		mov rdi, [breakTracker]								;move again to rdi the brak tracker
		mov rbx, 0
		mov rcx, 0
		mov rcx, [totalBytes]								;look throguh the amount of bytes read

	;--------------- PART 7) Encrypt the file read data found -------------------
		encryptLoop:
		cmp rax, [encKeyLength]							;Compare rax with the length of he key
		jl pushIt
		mov rax, 0										;if it is not less than, then move it back to zero
		mov rsi, encKey
		
		pushIt:
			mov bl, [rdi]								;move to rbx the last point in the memory (breakTracker)
			xor bl, [rsi]								;encrypt it using xor
			mov [rdi], bl								;move the encrypted value into that point in memory that we had in rdi (creating the encrpted copy)

			add rsi, 1									;increase all three (to go to the next byte)
			add rax, 1
			add rdi, 1

		loop encryptLoop
					

	
;---------------- PART 8) TRACK NUMBER OF BYTES READ, COPY ENCRYPTED VERSION TO THE OUTPUT FILE  -----------------------------
												
		mov rax, [totalBytes]
		add [bigTotalBytes], rax								;keep track of the TOTAL TOTAL byte transferred
		xor rax, rax											;clear rax
		
		
		
		mov rax, 1
		mov rdi, [outputFileAddress]
		mov rsi, [breakTracker]
		xor rdx, rdx									; clean rdx
		mov rdx, [totalBytes]
		syscall													;Poke the kernel
		cmp rax, 0
		jl failedOpening
		cmp rdx, 0ffffh											;compare rdx to 0ffffh
		jl cont2												;LOOP EXIT CONDITION: exit the loop if less than 0ffffh
		jmp readFileLoop										;else execute again
		
	cont2:
	;------------------- PART 9) close files, show total bytes -------------------
	xor rcx, rcx
	mov rcx, totalBytesAct.len
	sub rcx, 1
	push totalBytesAct
	push rcx
	call PrintText
	xor rax, rax									;clear rax
	mov rax, [bigTotalBytes]
	push rax
	call Print64bitNumDecimal
	
	;------- MEMORY DEALLOCATION ( PART 10) -----------------------
	mov rax, 0ch
	mov rsi, [breakTracker]
	syscall
	
	;----------------- CLOSE INPUT AND OUTPUT FILES ------------
	mov rax, 3h
	mov rbx, originalFile
	syscall
	
	mov rax, 3h
	mov rbx, outputFileAddress
	syscall
	;----------------- Failed Opening File ---------------
	jmp exitit
	allocationError:
		push allocError
		call PrintString
		call Printendl
	jmp exitit
	failedOpening:
		push failedFileAct
		call PrintString
		call Printendl
	jmp exitit
	
	
	
	exitit:
	
	
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
;; EMPTY WOOHOO


