;
;This program will test out the functions library
;
;
;Include our external functions library functions
%include "./functions.inc"
 
SECTION .data
	openPrompt	db	"Welcome to my Program", 0dh, 0ah, 0h	;Prompt String
		.size	equ	$-openPrompt			;Length of Prompt String
 
 
		goodbyeMsg	db 	"Program is ending, have a good day", 0dh, 0ah, 0h ;we want to cout this message
		testMessage db " This is a test message", 0dh, 0ah, 0h ;just a testing string to see if i can event print something
		hexMsg db "the Hex value of your eax register is: ", 0h
		binMsg db "the Bin value of your eax register is: ", 0h
		decMsg db "the Dec value of your eax register is: ", 0h
		;the 0ah, 0dh is equivalent to /n which ends the lines in c++

SECTION .bss
 
SECTION     .text
	global      _start
     
_start:
	;
	;Display Program Header
    push	openPrompt			;The prompt address - argument #1
    push	openPrompt.size		;The size of the prompt string - argument #2
    call    PrintText
    
    
    mov eax, 1h
    mov ecx, 2h
    mov ebx, 3h
    mov edx, 4h ;Now we moved 4 more registers
    
    call Printendl ;calls the endl command which adds another line (like in c++)
    call Printendl
    call	Printendl
    
    ;printed 3 emprty lines uing the Printendl function
    
    mov eax, 123456h
    push decMsg
    call PrintString
    call Printendl ;calling twice more to print an empty line
     push eax
    call Print32bitNumDecimal  ;a function to print the number, check the function library fo that
    call Printendl
    
    
     push binMsg
    call PrintString
    call Printendl ;calling twice more to print an empty line
     push eax
    call Print32bitNumBinary  ;a function to print the number, check the function library fo that
    call Printendl
    
    push hexMsg
    call PrintString
    call Printendl ;calling twice more to print an empty line
     push eax
    call Print32bitNumHex  ;a function to print the number, check the function library fo that
    call Printendl
    
    
    
    
    
    call PrintRegisters ;prints all the registers in the file
    
    
    push goodbyeMsg ;printing the goobyeMessage db string
    ;call PrintString ;clling the cout function in assembly to print the pushed texts
;
	
	call Printendl
	call Printendl
	call Printendl ;printed 3 more empty lines

	push testMessage
	call PrintString

;Setup the registers for exit and poke the kernel
Exit: 
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel
