; Assembler 32bit template

bits 32
section .data
;variables with values go here
	fileName db "file1.txt", 0h
	fileText db "Some datat to put onto disk, we will need to read a file into this string", 0h
		.len equ ($ - fileText)
	fileText2 db "Some More text o write into the end of our file", 0h
		.len equ ($ - fileText2)
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

	;------ OPEN THE FILE TO WRITE ------
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
	
	
	
	;------- APPEND TO THE FILE --------
	mov eax, 5h 	;open the file
	mov ebx, fileName ;mov into ebx the file name
	mov ecx, 2h ;open for read AANNDD write
	int 80h ;poke the kernel
	mov [outputFile], eax ;save out file descriptor
	
	
	
	;--------- POSITION FILE POINTER TO THE END ------------
	mov eax, 13h ;set position of file pointer
	mov ebx, [outputFile] ;our file descriptor
	mov edx, 2h ;startin at the end of the file 
	mov ecx, 0h ;move zero bytes
	int 80h ; tickler the kernel
	
	
	
	
	;----- APPEND NEW DATA TO THE FILE -------
	mov eax, 4h ;write to  the file
	mov ebx, [outputFile] ;file descriptor
	mov ecx, fileText2 ;the adddress of the data we want to write
	mov edx, fileText2.len ;the length of that data
	int 80h ;int = interrupt, meaning to poke the kernel
	
	
	
	
	
	;--------- WRITE A CARRIAGE RETURN AND LINE FEED ---------
	mov eax, 4h ;write to  the file
	mov ebx, [outputFile] ;file descriptor
	mov ecx, endl
	mov edx, endl.len
	int 80h ;int = interrupt, meaning to poke the kernel
	
	
	
	
	
	;------- OPEN THE FILE FOR READ -----------------
	mov eax, 5h ; open for read
	mov ebx, fileName ;the name of the flie
	mov ecx, 0h ;read only
	int 80h ;poke the kernel
	
						;---- WE SHOULD HAVE THIS WHENEVR THERE IS A PROBLEM< HELPS US TO CATCH THE PROBLEM ------
	
	cmp eax, 0h ;;see if the file is still empty, go ahead and close the file
	jl endit ;jump to endit if the file did not end
	
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
	
	;ls /
	;would show also all files that start with /
	
	endit:
	;Do not remove/change the lines below here.
	;These exit out of the application and back
	;to linux in an orderly fashion
	nop
	mov eax,1      ; Exit system call value
	mov ebx,0      ; Exit return code
	int 80h        ; Call the kernel
