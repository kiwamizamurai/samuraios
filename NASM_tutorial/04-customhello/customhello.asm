section .data
    ;string: db "hello world", 0x0A
    ;string: db 0x61, 0x62, 0x63, 0x0A
    string: dw 0x61, 0x62, 0x63, 0x0A
    ; change from 'db' to 'dw'
    ; each output is 'db.txt' and 'dw.txt'
    ; you can check the difference by using 'diff' command
    ; $ diff db.txt dw.txt
    ; https://www.ibm.com/support/knowledgecenter/ja/ssw_aix_71/com.ibm.aix.networkcomm/conversion_table.htm
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

; 逆アセンブル
; objdump -D ./customhello
; -Dというオプションは
; 逆アセンブル結果をtextセクション以外も含めて表示するオプションです。