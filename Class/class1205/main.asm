; Assembler 32bit template

bits 32
section .data
;variables with values go here
	
	floatVar1	dq	1.0
	floatVar2	dq	2.0
	floatVar3	dq	225.023
	
	
section .bss
;reserved memory goes here
	floatStore	resq 1
	

section .text
;Your program code goes here

	global _start
_start:
    nop
	
	;========== CODE ===========
	fld	qword [floatVar1]
	fld qword [floatVar2]
	fld qword [floatVar3]
	
	fstp	qword	[floatStore]
	fstp	qword	[floatStore]
	fstp	qword	[floatStore]
	
	
	
	nop
	
	;Do not remove/change the lines below here.
	;These exit out of the application and back
	;to linux in an orderly fashion
	nop
	mov eax,1      ; Exit system call value
	mov ebx,0      ; Exit return code
	int 80h        ; Call the kernel
