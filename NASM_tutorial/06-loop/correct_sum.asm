global _main
section .text
_main:
    mov rcx, 0

loop_label:
    mov     rax, 0x2000004
    mov     rdi, 1
    mov     rsi, msg
    mov     rdx, msg.len

    push rcx       ; to avoid register rcx from changing
    syscall
    pop rcx        ; to avoid register rcx from changing

    inc rcx
    cmp rcx, 5
    jb loop_label

    mov     rax, 0x2000001
    mov     rdi, 0
    syscall


section .data
msg:    db      "Hello, world!", 10
.len:   equ     $ - msg