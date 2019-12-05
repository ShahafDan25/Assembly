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
	
	;floatVar1 + (floatVar2 * floatVar3)
	
	fld	qword [floatVar2]						;push 2,0 onto the stack
	fld qword [floatVar3]						;push 225.023 onto the stack
	fmul										;floatVar2 * floatVar3
	fld qword [floatVar1]						;push 1.0 onto the stack
	fadd										;floatVar1 + (floatVar2 * floatVar3)
	
	fstp qword [floatStore]						;store the result in the reserved variable
	
	fld qword [floatVar3]						;push 225.023
	fsqrt										;sqaure root it
	fld											; THIS WILL NOT take (ST(0)) and push it again to the FLU Stack
	
	
	
	nop
	
	;Do not remove/change the lines below here.
	;These exit out of the application and back
	;to linux in an orderly fashion
	nop
	mov eax,1      ; Exit system call value
	mov ebx,0      ; Exit return code
	int 80h        ; Call the kernel
