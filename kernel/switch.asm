[bits 16]
protected_mode: 
	db "Switched to PM #!#! #!#! #!#!"
	db 0x0
	db 0x0

switch_to_pm:

	mov si, BEGIN_STR
	call print_string

	cli
	lgdt [gdt_descriptor]
	
	mov eax, cr0
	or eax, 1b
	mov cr0, eax

	jmp CODE_SEG:init_protected_mode

[bits 32]
init_protected_mode:
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax 
	mov fs, ax 
	mov gs, ax

	mov ebp, 0x90000
	mov esp , ebp

	call BEGIN_PROTECTED_MODE