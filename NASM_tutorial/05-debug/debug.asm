section .data
    string: db 0x61, 0x62, 0x63, 0x0A
    ; This hex means 'abc'
    string_length equ $ - string

section .text
global _main

_main:

    mov rax, 0x2000004  ; system call number (sys_write)
    mov rdi, 1          ; file descriptor (stdout)
    mov rsi, string
    mov rdx, string_length
    syscall

    mov rax, 0x2000001  ; system call number (sys_exit)
    mov rdi, 0
    syscall

; https://etc2day-linux.blogspot.com/2014/02/mac-mavericksgdb.html
; https://lldb.llvm.org/use/map.html

; DEBUG command is as follows
; $ lldb ./debug

; (lldb) rbreak _main
; Set a one-shot breakpoint using one of several shorthand formats.

; (lldb) r
; Running the program until breakpoint hit:

; (lldb) d
; Seeing more of the current stack frame:

; (lldb) bt
; Getting a back trace (call stack):

; (lldb) up
; peeking at the upper stack frame:

; (lldb) down
; back down to the breakpoint-halted stack frame:

; (lldb) register read
; dumping the values of registers:

; (lldb) register read rdi
; read just one register:

; (lldb) exit
; Exit from debug mode
