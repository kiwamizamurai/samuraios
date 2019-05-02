section .text
    global _main ; must be declared for linker (gcc)
_main:           ; tell linker entry point
    mov rdx, len ; message length
    mov rsi, msg ; message to write
    mov rdi, 1   ; file descriptor (stdout)
    mov rax, 0x2000004   ; system call number (sys_write)
    syscall

    mov rdx, 9   ; message length
    mov rsi, s2  ; message to write
    mov rdi, 1   ; file descriptor (stdout)
    mov rax, 0x2000004   ; system call number (sys_write)
    ; Mac OS X 64bitでは、syscall番号に0x2000000を足して下さい。（標準出力は4なので0x2000004）
    syscall
    mov rax, 0x2000001   ; system call number (sys_exit)
    syscall

section  .data
msg: db 'Displaying 9 stars',0xa ; a message
len: equ $ - msg                 ; length of message
s2: times 9 db '*'


; https://dev.classmethod.jp/etc/asm_mov/