mov ah, 0x0e

; attempt 2
; It tries to print the memory address of 'the_secret' which is the correct approach.
; However, BIOS places our bootsector binary at address 0x7c00
; so we need to add that padding beforehand. We'll do that in attempt 3
mov al, "2"
int 0x10
mov al, [the_secret]
; アドレスを指定してデータを移動したりする場合は[]を利用します
; alレジスタにthe_secretレジスタが保持しているアドレスの情報を移動する、という命令
int 0x10

jmp $ ; infinite loop

the_secret:
    ; ASCII code 0x58 ('X') is stored just before the zero-padding.
    ; On this code that is at byte 0x2d (check it out using 'xxd file.bin')
    db "X"

times 510 - ($ - $$) db 0
dw 0xaa55