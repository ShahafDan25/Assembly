;
;This program will test out the functions library
;
;
;Include our external functions library functions
%include "./functions.inc"
 
SECTION .data
	
	string1	db	"Hello World", 0h
		.len equ ($ - string1) ;create a length
		
		dwArray dd 10h, 20h, 30h, 40h
			.len equ($ - dwArray) / 4
			
	cmpStr1	db	"CompareStr-111", 0h
		.len equ ($ - cmpStr1)
	cmpStr2	db	"CompareStr 222", 0h
		.len equ ($ - cmpStr2)
		
	dash db "-"
		.len equ ($ - dash)
SECTION .bss
	string2	resb 255 ;resevrse 255 bits for that string
	dwArray2 resd 16 ;reserve 16 dwords
SECTION     .text
	global      _start
     
_start:
	nop
	
	;---CLASS PRACTICE---
	; MOVSB - Copies Data found at haddress in ESI to address in EDI
	mov esi, string1
	mov edi, string2
	mov ecx, string1.len
	rep movsb 	;copies string 1 to string 2
				;movsx increments esi and edit, decrements ecx
	
	; MOVSD - Copies Data found at haddress in ESI to address in EDI
	mov esi, dwArray
	mov edi, dwArray2
	mov ecx, dwArray.len
	rep movsd 	;copies array 1 to array 2
	
	; CMPSB = Compare Signle Byte
	; CMPSW = Compare Single Word
	; CMPSD = Compare Signle Double Word
	;;; ==== NOTICE === ;;;;
	mov esi, cmpStr1
	mov edi, cmpStr2
	mov ecx, cmpStr1.len
	;compsb >>>>>>>>> would only compare the first single byte of each cmpStr
	repne cmpsb ;will repeat until finds a byte that is  equal between the two cmpStr strings; repeat as long as the bytes are not equal
	; repeat incremets the addresses of esi and edi
	
	mov esi , cmpStr2 ;our strng we are looking at
	mov edi , dash ;contains a single byte "-"
	mov ecx, cmpStr2.len ;length of both of our strings
	repne cmpsb; ; rep increments both esi and edi
	Loop1;so we need a loop i fboth array are not the same size
		cmp [esi], [edi] ;this loop will look for the dirst occurance
		je exitFlag ;os a dasy in the string pointed to be (??? - not my commnets)
		inc esi ;esi
		
	loop Loop1
	exitFlag:
		cmp ecx, 0
		je notFound 
		;found code
		nmp endit
	notFound:
	
	;SCASB (remember dashing situation)
	mov edi, cmpStr2 ;our string with a dash
	mov ecx, cmpStr2.len ;length of out string
	mov al, [dash] ;;search character "-"
	repne scasb ;keep going until "-" is found in hte cmpStr2
	
	
	
	endit:
	; Do not remove / change thelines below here
	nop
	mov eax, 1
	
;Setup the registers for exit and poke the kernel
Exit: 
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel

