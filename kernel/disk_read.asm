set_memory:
	mov dl, [BOOT_DRIVE]
	
retry_count:
	mov di, 5

disk_load:
	push dx
	mov ah, 0x02
	mov al, dh

	mov ch, 0x00
	mov dh, 0x00
	mov cl, 0x02

	int 0x13

	jc disk_retry

	pop dx
	cmp dh, al
	jne disk_error_2

	call disk_success

	ret

disk_load_again:
	call disk_start
	call disk_load

disk_retry:
	mov ah, 0x00
	int 0x13
	dec di
	jnz disk_load_again
	jmp disk_error

disk_start:
	mov si, DISK_READING_START
	call print_string
	ret

disk_success:
	mov si, DISK_SUCCESS_MSG
	call print_string
	ret

disk_error:
	mov si, DISK_ERROR_MSG 
	call print_string
	ret

disk_error_2:
	mov si, DISK_ERROR_MSG_2
	call print_string
	ret

BOOT_DRIVE db 0

DISK_READING_START db "Disk Start from the starting ", 0, 0
DISK_ERROR_MSG db "Disk read error mridul ", 0, 0
DISK_ERROR_MSG_2 db "Disk read error222! ", 0, 0
DISK_SUCCESS_MSG db "Disk Success ", 0, 0