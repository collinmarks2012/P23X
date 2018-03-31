    .model     small 				; 64k code and 64k data
	.8086 							; only allow 8086 instructions
	.stack 256 						; reserve 256 bytes for the stack
;---------------------------------------
	.data 		
	AAXX dw ?
	DDXX dw ?
	.code 
	start:
	mov ax, @data
	mov ds, ax
	mov ax, 1811h
	mov bx, 46375
	mov cx, 9002h
	mov dx, 49572
	mul cl
	mov AAXX, ax
	mov DDXX, dx
	mov ah, 2
	mov dx, AAXX
	int 21h
	mov ah, 2
	mov dx, DDXX
	int 21h
	end start
	