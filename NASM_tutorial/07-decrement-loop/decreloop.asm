global _main
section .text
_main:
    mov rcx, 10

loop_label:
    mov     rax, 0x2000004
    mov     rdi, 1
    mov     rsi, msg
    mov     rdx, msg.len

    push rcx       ; to avoid register rcx from changing
    syscall
    pop rcx        ; to avoid register rcx from changing

    ; inc rcx
    cmp rcx, 10
    loop loop_label

    mov     rax, 0x2000001
    mov     rdi, 0
    syscall


section .data
msg:    db      "Hello, world!", 10
.len:   equ     $ - msg



; nasm -f macho64 correct_sum.asm
; ld -macosx_version_min 10.14 -lSystem -o correct_sum correct_sum.o
; ./correct_sum