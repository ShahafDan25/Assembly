;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
	; put your variables below
	welcomeAct db "Hello World", 0ah, 0dh, 0h
	goodbyeAct db "Bye, have  good one", 0ah, 0dh, 0h
	
	promptAct db "Please enter a string with less than 20 chars", 0ah, 0dh, 0h
	;define an array
	array1	db	10h, 20h, 30h, 40h, 50h ;5 items in this array. each is a byte
		.len	equ($-array1) ;create accessibility variable to the length of the array - how many items?
		
	aVar dd 0h
		
SECTION .bss
	;reserve memory here
	readBuffer resb 20 ;where data will be stored in the inputs
		.len	equ	($-readBuffer)
 
SECTION     .text
	global  _start
     
_start:
;-------------OBJECTIVE--------------
;take in a string, and reverse it




	;code goes here
	;---------HELLO---------
	push welcomeAct
	call PrintString 
	call Printendl
	
	;---PROMPT---
	push promptAct
	call PrintString
	call Printendl
	
	;---PROGRAM---
	push readBuffer ;get keyboard input from the user
	push readBuffer.len	;it is oing to go into readBuffer
	call ReadText ;built in function to read the text into last pushed variable
	;read text function returns rax = number of chars entered
	
	
	;reserve the data input (hint: loop from the book)
	;Print the new reversed string
	
	;build the loop, print from the back
	mov rax, 0 ;clean rax first
	mov rdx, 0 ;clean rdx
	mov rsi, 0 ;start counter at 0
	mov rcx, readBuffer.len ;set the length to rcx
	Loop1:
		movzx rax, BYTE [readBuffer + rsi] ;get the rsi'th character from readBuffer, mov it into rax register
		push rax
		inc rsi ;increase the counter = counter++;
	Loop Loop1 ;go back to loop 1	
	
	;set up another loop to move the reversed stack into a new variabvle (or register)
	;pop the name from the stack in reverse
	;and store it in the aName array
	
	mov rcx, readBuffer.len
	mov rsi, 0 ;ser counter to 0 again
	
	Loop2: 
		pop rax ;move the next item in rax
		mov [readBuffer + rsi], al ;store in a string
		inc rsi ;counter++
	Loop Loop2
	
	mov rdx, readBuffer ;move the value of the readBuffer int rdx
	push rdx
	push readBuffer.len ;pushing the length becaus ethe print text requires the length of the string we want to print
	call PrintText ;print the reversed string
	
	;------GOODBYTE----
	call Printendl
	push goodbyeAct
	call PrintString
	call Printendl
	
;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel
