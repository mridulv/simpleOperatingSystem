[org 0x7c00]

mov [BOOT_DRIVE], dl

BEGIN_STR db "Hello World !!! ", 0, 0

PROTECTED_MODE_STR db "Started PM !!!", 0, 0

mov si, BEGIN_STR
call print_string

call LOADING_KERNEL

call switch_to_pm

jmp $

LOADING_KERNEL:
	mov dh, 15
	call set_memory

	mov si, BEGIN_STR
	call print_string

	ret

%include "kernel/disk_read.asm"
%include "kernel/print.asm"
%include "kernel/gdt.asm"
%include "kernel/print_32.asm"
%include "kernel/switch.asm"


[bits 32]
BEGIN_PROTECTED_MODE:
	mov ebx, PROTECTED_MODE_STR
	call print_string_pm

	jmp $


START_KERNEL:
	;call KERNEL_OFFSET
	;jmp $

times 510-($-$$) db 0
dw 0xaa55

times 15*256 dw 0xDADA
