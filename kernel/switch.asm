%include "kernel/gdt.asm"
%include "kernel/print.asm"

protected_mode: 
	db "Switched to PM #!#! #!#! #!#!"
	db 0x0
	db 0x0

switch_to_pm:
	cli
	lgdt [gdt_descriptor]
	
	mov eax, cr0
	or eax, 1b
	mov cr0, eax

	jmp init_protected_mode

init_protected_mode:
	mov ebx, protected_mode
	call print_string
	call BEGIN_PROTECTED_MODE
