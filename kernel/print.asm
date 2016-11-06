print_string:
	mov ecx, 0xb8000

print_character: 
	mov al, [ebx]
	mov ah, 0x0f

	cmp al, 0
	je done

	mov [ecx], ax
	add ebx, 1
	add ecx, 2

	;Instructions of the form jmp address are encoded using relative offsets in x86. The offsets are relative to the address immediately following the jmp instruction.
	jmp print_character

done:
	ret