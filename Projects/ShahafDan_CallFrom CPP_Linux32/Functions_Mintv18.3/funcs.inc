;example of usage:
;	mov ecx, SOMESTRING 
;    mov edx, SOMESTRING.len
;	call DisplayText
;the function assumes the address if rhge string will be in the ecx register 
;and that the length in the edx register
extern DisplayText

;example of usage:
;
extern Displayendl


extern ReadText
