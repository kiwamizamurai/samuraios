mov ah, 0x0e   ; tty mode

mov bp, 08000  ; this is an address far away from 0x7c00 so that we don't get overwritten
mov sp, bp     ; if the stack is empty then sp pointers to bp
; Remember that the bp register stores the base address (i.e. bottom) of the stack, and sp stores the top,
; and that the stack grows downwards from bp (i.e. sp gets decremented)

push 'A'
push 'B'
push 'C'
; スタックは、一時的なデータの保存に使われるメモリ領域です。引数やローカル変数の保持に使われます。
; スタックに対してできる操作はPUSHとPOP, PUSHでは、データをスタックに積み、POPでは、データを取り出します。

; to show how the stack grows downwards
mov al, [0x7ffe]  ; 0x8000 - 2
int 0x10

; however, don't try to access [0x8000] now, because it won't work
; you can only access the stack top so, at this point, only 0x7ffe (look above)
mov al, [0x8000]
int 0x10

; recover our characters using the standard procedure: 'pop'
; we can only pop full words so we need an auxiliary register to manipulate
; the lower byte
pop bx
mov al, bl    ; BL is 8bit
int 0x10      ; prints C

pop bx
mov al, bl    ; BL is 8bit
int 0x10      ; prints B

pop bx
mov al, bl    ; BL is 8bit
int 0x10      ; prints A

; data that has been pop'd from the stack is garbage now
mov al, [0x8000]
int 0x10

jmp $
times 510-($-$$) db 0
dw 0xaa55







