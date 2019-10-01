; Assembler 32bit template

bits 32
section .data
;variables with values go here

	byteVAR		db	1
	byteVAR2	db		2

	wordVAR		dw	3
	wordVAR2	dw		4

	dwordVAR	dd	5
	dwordVAR2	dd		6

	usBytevar	db	-7 ;unsigned byte, means really nothing
	sByteVar	SBYTE	-7 ;signed byte means really nothing

	unallocByte		db	?

	byteArray	 db	 1,2,3,4,5,6,7,8
	byteArray2	 db	 1,2,3,4
				 db	 5,6,7,8

				 db 99h, 22h
				 
	myname db 	'Shahaf Dan', 0h ; 0h is null termination	
	myESname db 'Shaoof Dan', 0h
	
	aString db	'I', ' ' ,'a' ,'m' ,' ' ,'S' ,'h', 'a' ,'h' ,'a', 'f', 0h
	aString2 	db		'I am Shahaf', 0h
	
	mainMenu 	db 	'Welcoe to the main menu', 0dh, 0ah
				db '1. Open  file', 0dh, 0ah
				db '2. Print the file', 0dh, 0ah
				db '9. Exit Program', 0dh, 0ah, 0h
				 
section .bss
;reserved memory goes here

	unallocByte resb 	1
	;label ;size ;number of the size to create
	
	resBytes resb 32
	lrgeArray resb 1000000
	
	
section .text
;Your program code goes here

	global _start
_start:
    nop
	
	;Your program code should go here

	;Do not remove/change the lines below here.
	;These exit out of the application and back
	;to linux in an orderly fashion
	nop
	mov eax,1      ; Exit system call value
	mov ebx,0      ; Exit return code
	int 80h        ; Call the kernel
