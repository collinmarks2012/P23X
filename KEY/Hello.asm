.model small
.stack 100h
.data
char DB 'A' 
.code
Hello Proc
mov ax, @data
mov ds, ax

mov ah, 8
int 21h


mov dl, 'A'
mov ah, 2
int 21h
Hello ENDP
mov ax, 4c00h
int 21h
END Hello