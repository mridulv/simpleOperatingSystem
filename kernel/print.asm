print_string:
  pusha

loop:
  mov  al, [si]
  or  al, al
  jz return

  xor bx, bx
  mov  ah, 0x0E    ;Teletype function
  int  0x10
  
  inc  si
  jmp  loop

return:
  popa
  ret