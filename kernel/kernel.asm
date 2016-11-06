[org 0x7c00]

BEGIN_STR:
	db "Hello World !!!"
	db 0x0
	db 0x0

PROTECTED_MODE_STR: 
	db "Started PM"
	db 0x0
	db 0x0

mov ebx, BEGIN_STR
call print_string

call switch_to_pm

%include "kernel/switch.asm"

BEGIN_PROTECTED_MODE:
	mov ebx, PROTECTED_MODE_STR
	call print_string

jmp $

times 510-($-$$) db 0
dw 0xaa55