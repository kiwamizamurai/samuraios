mov ah, 0x0e   ; tty mode
mov al, 'H'    ; 1 character need 1byte (8bit)
; http://e-words.jp/w/ASCII.html
int 0x10       ; print a single letter.
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10       ; 'l' is still on al, remember?
mov al, 'o'
int 0x10

jmp $          ; jump to current address = infinite loop

; padding and magic number
times 510 - ($ - $$) db 0
dw 0xaa55