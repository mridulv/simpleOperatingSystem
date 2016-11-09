[org 0x7c00]

KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl

BEGIN_STR db "Hello World !!! ", 0, 0

PROTECTED_MODE_STR db "Started PM !!!", 0, 0

mov si, BEGIN_STR
call print_string

call LOADING_KERNEL

call switch_to_pm

jmp $

LOADING_KERNEL:
	mov bx, KERNEL_OFFSET

	mov dh, 1
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

	call KERNEL_OFFSET

	jmp $


START_KERNEL:
	;call KERNEL_OFFSET
	;jmp $

times 510-($-$$) db 0
dw 0xaa55
