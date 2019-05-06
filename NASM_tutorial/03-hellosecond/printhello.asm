section .data
	string: db "hello world", 0x0A
	string_length equ $ - string

section .text
global _main
;

_main:
	mov rax, 0x2000004      ; 1
	mov rdi, 1
	mov rsi, string
	mov rdx, string_length
	syscall

	mov rax, 0x2000001      ; 60
	mov rdi, 0
	syscall

; http://bttb.s1.valueserver.jp/wordpress/blog/2017/09/06/アセンブリ言語入門-nasmの使い方-2/

; nasm -f macho64 printhello.asm
; ld -macosx_version_min 10.14 -lSystem -o printhello printhello.o
; ./printhello