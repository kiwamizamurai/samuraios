print:
    pusha
; pusha saves some more registers, notably the value of sp before executing, bp, si, and di.

; keep this in mind:
; while (string[i] != 0) { print string[i]; i++ }

; the comparison for string end (null byte)
start:
    mov al, [bx]  ; 'bx' is the base address for the string
    cmp al, 0
    je done

    ; the part where we print with the BIOS help
    mov ah, 0x0e
    int 0x10      ; 'al' already contains the car

    ; increment pointer and do next loop
    add bx, 1
    jmp start

done:
    popa
    ret
    ; ret（リターン）命令は保存してある（ＳＰ）にあるのアドレスをＰＣへ戻しています。

print_nl:
    pusha

    mov ah, 0x0e
    mov al, 0x0a  ; new line char
    int 0x10
    mov al, 0x0d  ; carriage return
    int 0x10

    popa
    ret
