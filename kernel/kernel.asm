[org 0x7c00]

helloWorld: 
	db 'Hello World !!!'
	db 0x0
	db 0x0

print_string:
	mov ebx, helloWorld
	mov ecx, 0xb8000

print_character: 
	mov al, [ebx]
	mov ah, 0x0f

	cmp al, 0
	je loop

	mov [ecx], ax
	add ebx, 1
	add ecx, 2

	;Instructions of the form jmp address are encoded using relative offsets in x86. The offsets are relative to the address immediately following the jmp instruction.
	jmp print_character

loop:
	jmp loop

times 510-($-$$) db 0
dw 0xaa55