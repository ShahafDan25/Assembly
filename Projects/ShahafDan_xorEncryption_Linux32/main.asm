;
;This program will test out the functions library
;
;
;Include our external functions library functions
%include "./functions.inc"
 
SECTION .data
	welcomeAct	db	"Welcome to my program!", 0h
	byeAct db 	"Bye, have a good day!", 0ah , 0dh, 0h
	notFound db "Value invalid, enter a new one", 0ah, 0dh, 0h
	
	inputStringSize db 0h ;will store value returned from ReadText here
	inputKeySize db 0h ;will store value returned from ReadText here
	
	
	option1 db "Option 1 Selected: Enter a string:", 0ah, 0dh, 0h
	option2 db "Option 2 Selected: Enter an Encryption key:", 0ah, 0dh, 0h
	option3 db "Option 3 Selected: your last input string was:", 0ah, 0dh, 0h
	option4 db "Option 4 Selected: your last encryption key entered was: ", 0ah, 0dh, 0h
	option5 db "Option 5 Selected: Encrypting...", 0ah, 0dh, 0h
	option6 db "Option 6 Selected: Decrypting...", 0ah, 0dh, 0h
	optionExit db "You chose to eixt the program", 0ah, 0dh, 0h
	
	
	menu db 0ah,0dh, "----------------------- " , 0ah, 0dh,
		 db "Encrypt / Decrypt Program", 0ah, 0dh,
		 db "1) Enter a String", 0ah, 0dh, 
		 db	"2) Enter an Encryption Key", 0ah, 0dh,
		 db	"3) Print the Input String", 0ah, 0dh,
		 db	"4) Print the Input Key", 0ah ,0dh,
		 db	"5) Encrypt / Display the String", 0ah, 0dh,
		 db	"6) Decrypt / Display the String", 0ah, 0dh,
		 db	"x) Exit Program", 0ah, 0dh, 0ah, 0dh
		 db	"Please Enter One", 0ah, 0dh, 0ah, 0dh, 0h
	
	caseTable 	db '1'
				dd enterString
			.entrySize equ ($ - caseTable)
				db '2'
				dd enterKey
				db '3'
				dd printInputString
				db '4'
				dd printKey
				db '5'
				dd encryptString
				db '6'
				dd decryptKey
		.numberOfEntries equ ($ - caseTable) / caseTable.entrySize
		
	
	
SECTION .bss
	indexValue resb 8 ;reserve 8 bits for the chosen index by the user
		.len equ ($ - indexValue)
		
	inputString resb 255 ;reserve 255 bits for the inputString variable
		.len equ ($ - inputString) ;no need todivivde. because it is all bytes
		
	inputKey resb 255 ;reserve 255 bits for the encryptiong array
		.len equ ($ - inputKey)
		
	encValue resb 255
		.len equ ($ - encValue)
		
	decValue resb 255 
		.len equ ($ - decValue)
	
SECTION     .text
	global      _start
     
_start:
	nop
	;----- WELCOME -----
	call Printendl
	push welcomeAct
	call PrintString ;print the welcome prompt
	call Printendl ;print empty line
	
	;---ASSIGNMENT---
	mov edi, 0 ;reset two pointers
	mov esi, 0 ;reset two pointers
	;---- first: PRINT MENU ---
	printMenu: ;use a flag just in case I need to callit again
	push menu;
	call PrintString
	
	;----------SET UP --------
	mov ecx, caseTable ;mov the number of items in the switch ;set counter for the switch loop
	mov esi, caseTable ;put the address of our table into the pointer esi register
	push indexValue
	push indexValue.len
	call ReadText ;;read input from user
	mov al, [indexValue] ;move to the al 1 bytes register the input from the user
	;call ClearKBuffer
	
	;---------SWITCH ---------
	Switch: ;create a loop to go through every element of the table
		cmp al,'x' ;compare to x, in order to exit the program
		je exitFlag ;if the user entered x, jmp to exitFlag (exit the program)
		cmp al, [esi] ;compre to the look up table
		jne nextSwitchItem ;try the next value in the switch table
		call NEAR[esi + 1] ;call the function associated ith the user input
		jmp printMenu
		nextSwitchItem:
			add esi, caseTable.entrySize
			cmp esi, caseTable + (caseTable.numberOfEntries * caseTable.entrySize) ;compare addresses, of greater than max, then the value entered by the user is not in the table driven selection, display the "invliad" message
			jge notFoundInTable		
	Loop Switch ; go to the switch flag again
	;---------INVLIAD INPUT ---------
	notFoundInTable: ;flag to jump to if the value the user entered cannot be found in the look up table
		push notFound
		call PrintString
		jmp printMenu ;go back to printing the menu again
	;----- GOODBYE ---
	exitFlag:
	push byeAct
	call PrintString
	call Printendl
	
;
;----------- EXIT -------------
Exit: 
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel


; ----- FUNCTION HERE ----
enterString:
	mov eax, 0h
	push option1
	call PrintString ;print prompt
	push inputString
	push inputString.len
	call ReadText ; returns in eax the amount of characters	
	mov [inputStringSize], eax
	;call ClearKBuffer
	mov eax, 0
ret

enterKey:
	mov eax, 0 ; clear just in case
	push option2 
	call PrintString
	push inputKey
	push inputKey.len
	call ReadText ;get input from the user
	mov [inputKeySize], eax ; ReadText returns the "actual" length in eax, move it to a variable
	;call ClearKBuffer
	mov eax, 0
ret
	
printInputString: ;just printing some stuff
	push option3
	call PrintString
	push inputString
	call PrintString

ret

printKey: ;just printing promopt and the key
	push option4
	call PrintString
	push inputKey
	call PrintString

ret

;----5----
encryptString:
	push option5 ;print the right prompt
	call PrintString
	mov ebx, 0
	mov eax, 0
	mov edx, 0
	mov edi, 0
	mov ecx, 0
	mov cl, [inputStringSize] ;same as the encryption loop
	sub ecx, 1

	encLoop:
		;--- CODE FOR ENCRYPTING --- 
		mov eax, edi ;gotta move first to eax, because th div operand onlyt operates on the eax register
		mov ebx, [inputKeySize]
		div ebx ;stores the modules in edx
		mov ebx ,0
		mov ebx, [inputString + edi]
		xor ebx, [inputKey + edx] ;xor with the same key
		mov [encValue + edi], ebx
		inc edi
	Loop encLoop
	
	;debug by printing
	push encValue
	call PrintString

ret

;------6-----------
decryptKey:
	push option6 ;print promopt just for clearabce
	call PrintString
	mov ebx, 0
	mov eax, 0
	mov edx, 0
	mov edi, 0
	mov ecx, 0
	mov cl, [inputStringSize] ;same as the encryption loop
	sub ecx, 1

	decLoop:
		;CODE FOR DECRYPTIONG GOES HERE
		mov eax, edi ;gotta move first to eax, because th div operand onlyt operates on the eax register
		mov ebx, [inputKeySize]
		div ebx ;stores the modules in edx
		mov ebx ,0 ;clear before messing with it again
		mov ebx, [encValue + edi]
		xor ebx, [inputKey + edx] ;xor with the same key
		mov [decValue + edi], ebx
		inc edi
	Loop decLoop
	
	;;pring the decrypted value to check
	push decValue
	call PrintString
ret



;-----TODO-------
;1) do not forget to clear buffer 
;2) reerase everytime user enters input

