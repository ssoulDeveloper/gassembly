title ret
.model small
.stack
.data
strb db "Inserisci la base -> $"
strh db "Inserisci l'altezza -> $"
dieci db 0Ah
num db 00
cifra db 00
x db 00
b db 00
h db 00
.code
.startup
acapo macro
  mov DL,0Ah
  mov AH,02h
  int 21h
  mov DL,0Dh
  mov AH,02h
  int 21h
endm

mov CL,02h
leggi: 
  mov num,0h
	mov cifra,0h
	acapo 
    cmp CL,1 ; decide la frase da scrivere
    je struno
    lea DX,strb
    jmp scrivi
	struno: lea DX, strh
	scrivi : mov AH,09h
    int 21h
	ciclet: 
		mov AH,01h ; ciclo di lettura
        int 21h
        cmp AL,0Dh
        jz esci
        sub AL,30h
        mov cifra,al
        mov al,num
        mul dieci
        add al,cifra
        mov num,al
    jmp ciclet
	esci:
		mov bl,num ; decide dove mettere il numero letto
		cmp CL,01h
		je uno
		mov b,bl
		jmp oltre
		uno: mov h,bl
		oltre:dec CL
jnz leggi 
acapo
acapo
mov bl,0h
mov cl,h
mov dh,h
mov x,0
riga: 			; scrittura **********
	cmp bl, b
	je avanti
	mov dl,2Ah
	mov ah,02h
	int 21h
	inc bl
jmp riga
ciclo:          ; ciclo di scrittura per h - 2 volte
	acapo
	mov bl,0h
	inc x	
	cmp x,dh ; sarebbe un cmp x,h
	je riga
	ancora :     ; scritttura *    *
		cmp bl,b
		je chiudi
		inc bl
		cmp bl,1
		je ast
		cmp bl, b
		je ast
		mov dl,20h
		jmp salto
		ast : mov dl,2Ah
		salto :	
			mov ah,02h
			int 21h
			inc bl
	jmp ancora
chiudi :mov DL,2Ah
	mov AH,02h
	int 21h
avanti : loop ciclo
mov ah,01h
int 21h
mov ah,4ch
int 21h
end