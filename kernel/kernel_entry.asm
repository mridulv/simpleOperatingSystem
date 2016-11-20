[bits 32]

[extern main]
[extern main2]
[extern page_table]

call main

lea ECX, [page_table - 0xC0000000]
mov CR3, ECX

mov ECX, CR0
or ECX, 0x80000000
mov CR0, ECX

;lea ECX, [StartInHigherHalf]
;jmp ECX

;StartInHigherHalf:
;	call main2

jmp $