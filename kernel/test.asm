[bits 16]
[org 0x7C00]

KERNEL_OFFSET equ 0x1000

xor  ax, ax
mov  ds, ax
mov  es, ax    
mov  [BOOT_DRIVE], dl
mov  ax, 0x07E0
cli
mov  ss, ax 
mov  sp, 0x1200
sti
mov  si, MSG_REAL_MODE       
call print_string           
call load_kernel            
jmp  $

print_string:
  pusha
  mov  bx, 0x0007  ;BL=WhiteOnBlack BH=Display page 0
  mov  ah, 0x0E    ;Teletype function
 loop:
  mov  al, [si]
  cmp  al, 0
  je return
  int  0x10
  inc  si
  jmp  loop
 return:
  popa
  ret

disk_load:
  mov  [SECTORS], dh
  mov  ch, 0x00      ;C=0
  mov  dh, 0x00      ;H=0
  mov  cl, 0x02      ;S=2
 next_group:
  mov  di, 5         ;Max 5 tries
 again: 
  mov  ah, 0x02      ;Read sectors
  mov  al, [SECTORS]
  int  0x13
  jc   maybe_retry
  sub  [SECTORS], al ;Remaining sectors
  jz  ready
  mov  cl, 0x01      ;Always sector 1
  xor  dh, 1         ;Next head on diskette!
  jnz  next_group
  inc  ch            ;Next cylinder
  jmp  next_group
 maybe_retry:
  mov  ah, 0x00      ;Reset diskdrive
  int  0x13
  dec  di
  jnz  again
  jmp  disk_error
 ready:
  ret

disk_error:
  mov  si, DISK_ERROR_MSG 
  call print_string 
  jmp  $

DISK_ERROR_MSG db "Disk read error!", 0

load_kernel: 
  mov  bx, KERNEL_OFFSET       
  mov  dh, 15           
  mov  dl, [BOOT_DRIVE]                      
  call disk_load    

  mov  si, MSG_REAL_MODE_LOADED       
  call print_string       
  ret

; Global variables
BOOT_DRIVE     db 0
SECTORS        db 0
MSG_REAL_MODE  db "Started in 16-bit Real Mode", 0 
MSG_REAL_MODE_LOADED  db "Started in 16-bit Real Mode Loaded", 0 

; Bootsector padding 
times 510-($-$$) db 0 
dw 0xAA55

; 15 sector padding
times 15*256 dw 0xDADA