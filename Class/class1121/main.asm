; Assembler 32bit template

bits 32
section .data
;variables with values go here
	fileName db "file1.txt", 0h
	fileText db "Some datat to put onto disk", 0h
		.len equ ($ - fileText)
	endl db 0ah, 0dh
		.len equ ($ - endl)
section .bss
;reserved memory goes here
	outputFile resd 1
	
	inputFile resd  1
	
	inputBuffer resb 255
		.len equ ($ - inputBuffer)
section .text
;Your program code goes here

	global _start
_start:
    nop
	
	;Your program code should go here

	;--- OPEN THE FILE TO WRITE ------
	mov eax, 8h ;open for write
	mov ebx, fileName ;address of file name
	;mov ecx, 01ffh ;Octal 777
	mov ecx, 1b6h
	int 80h ;poke the kernel
	mov [outputFile], eax ;Put our file details into eax
	
	
	;---- PROCESS FILE -----
	mov eax, 4h ;write to  the file
	mov ebx, [outputFile] ;file descriptor
	mov ecx, fileText ;the adddress of the data we want to write
	mov edx, fileText.len ;the length of that data
	int 80h ;int = interrupt, meaning to poke the kernel
	
	;--------- WRITE A CARRIAGE RETURN AND LINE FEED ---------
	mov eax, 4h ;write to  the file
	mov ebx, [outputFile] ;file descriptor
	mov ecx, endl
	mov edx, endl.len
	int 80h ;int = interrupt, meaning to poke the kernel
	
	
	
	;----------- CLOSE FILE -----------
	mov eax, 6h ;Close the file
	mov ebx, [outputFile] ;file descriptor
	int 80h;poke the kernel
	
	;------- OPEN THE FILE FOR READ -----------------
	mov eax, 5h ; open for read
	mov ebx, fileName ;the name of the flie
	mov ecx, 0h ;read only
	int 80h ;poke the kernel
	mov [inputFile], eax
	
	
	;------------PROCESS INPUT FILE -----------
	mov eax, 3h ;read from this file
	mov ebx,[inputFile] ; the input file info
	mov ecx, inputBuffer ;where the data read goes
	mov edx, inputBuffer.len ;the size of our input buffer
	int 80h; interuupt the kernel

	;----------- CLOSE FILE -----------
	mov eax, 6h ;Close the file
	mov ebx, [inputFile] ;file descriptor
	int 80h;poke the kernel
	
	;------------ TERMINAL COMMANDS --------------
	;cat file1.txt 
	;woulld print the file input
;	;
	;ghex file1.txt 
	;will sho the values in hex decimnal in the fileName
;	;
	;ls -la 
	;would show information about all hte ilesin the directory
	
	
	endit:
	;Do not remove/change the lines below here.
	;These exit out of the application and back
	;to linux in an orderly fashion
	nop
	mov eax,1      ; Exit system call value
	mov ebx,0      ; Exit return code
	int 80h        ; Call the kernel
