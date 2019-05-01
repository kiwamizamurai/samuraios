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
    syscall
    mov rax, 0x2000001   ; system call number (sys_exit)
    syscall

section  .data
msg: db 'Displaying 9 stars',0xa ; a message
len: equ $ - msg                 ; length of message
s2: times 9 db '*'