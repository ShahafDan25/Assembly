;
;This program will test out the functions library
;
;
;Include our external functions library functions
%include "./functions.inc"
 
SECTION .data
	
	welcomeAct db "Hello World (and Shahaf)", 0ah, 0dh, 0h
	byeAct db "Goodbye World", 0ah, 0dh, 0h
	
	Array2d	dw	10h, 20h, 30h, 40h, 50h
			dw	60h, 70h, 80h, 90h, 100h
			dw	110h, 120h, 130h, 140h, 150h
			dw	160h, 170h, 180h, 190h, 200h
			dw	210h, 220h, 230h, 240h, 250h
		.numCols equ 5 ;set length to 5 columns
		.size equ 1 ;set the size (?)
		
		
SECTION .bss


SECTION     .text
	global      _start
     
_start:
	nop
	
	;----- WELCOME-------
	call Printendl
	push welcomeAct
	call PrintString
	call Printendl
	
	;----- PROGRAM--------
	mov eax, Array2d.numCols ;number of columns
	mov ebx, 3 ;
	mul ebx ;multiply that by row number
	add eax, 2 ;add out column number
	mov ebx, Array2d.size
	mul ebx ;multiple by the size of each entry in the array
	add eax, Array2d ;add the address (base) of our array
	mov esi, eax ; put the addres sinto esi
	mov ax, [Array2d + esi] ; the value at tat location into al
	
	
	;------ GOODBYE------------
	push byeAct
	call PrintString
	call Printendl
	
	
;Setup the registers for exit and poke the kernel
Exit: 
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel

