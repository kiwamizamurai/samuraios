section .data
    ; Define constants
    num1:   equ 100
    num2:   equ 50    ; change number
    ; initialize message
    msg:    db 'Sum is correct', 10

global _main
section .text
; global _mainを先に宣言するとできた


;; entry point
_main:
    ; set num1's value to rax
    mov rax, num1
    ; set num2's value to rbx
    mov rbx, num2
    ; get sum of rax and rbx, and store it's value in rax
    add rax, rbx
    ; compare rax and 150
    cmp rax, 150
    ; go to .exit label if rax and 150 are not equal
    jne .exit
    ; go to .rightSum label if rax and 150 are equal
    jmp .rightSum

; Print message that sum is correct
.rightSum:
    ;; write syscall
    mov     rax, 0x2000004
    ;; file descritor, standard output
    mov     rdi, 1
    ;; message address
    mov     rsi, msg
    ;; length of message
    mov     rdx, 15
    ;; call write syscall
    syscall
    ; exit from program
    jmp .exit

; exit procedure
.exit:
    ; exit syscall
    mov    rax, 0x2000001
    ; exit code
    mov    rdi, 0
    ; call exit syscall
    syscall


; https://0xax.github.io/asm_2/


; nasm -f macho64 jmp.asm
; ld -macosx_version_min 10.14 -lSystem -o jmp jmp.o
; ./jmp