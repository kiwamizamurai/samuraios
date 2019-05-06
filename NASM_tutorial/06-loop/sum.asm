global _main
section .text
_main:
    mov rcx, 0

loop_label:
    mov     rax, 0x2000004
    mov     rdi, 1
    mov     rsi, msg
    mov     rdx, msg.len
    syscall

    inc rcx
    cmp rcx, 5
    jb loop_label

    mov     rax, 0x2000001
    mov     rdi, 0
    syscall


section .data
msg:    db      "Hello, world!", 10
.len:   equ     $ - msg


; nasm -f macho64 correct_sum.asm
; ld -macosx_version_min 10.14 -lSystem -o correct_sum correct_sum.o
; ./correct_sum


; This script does not show 'Hello, world!' 5 times
; because the value of RCX is altered before and after 'syscall'

; CHECK by DEBUG

; $ lldb ./sum
; (lldb) rbreak _main
; (lldb) register read rcx
; (lldb) c
; (lldb) register read rcx
; (lldb) exit