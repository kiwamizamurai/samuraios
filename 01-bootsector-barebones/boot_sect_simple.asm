; A simple boot sector program that loops forever
loop:
    jmp loop

;loopに無限ジャンプする

times 510-($-$$) db 0
dw 0xaa55

;この2行でMBRのブートシグネチャを書き込みます。timesとdbは疑似命令といい、
;機械語と1対1で対応しておらず、アセンブラにより機械語へ翻訳されます。
;まず$と$$の説明です。$$はこのプログラムの一番最初の命令を指します。$は現在の命令を指します。
;そして、times疑似命令は指定された回数分処理を繰り返す動作をします。
;db疑似命令はdata byteのことで、そのメモリの場所にデータを置く動作をします。
;ですのでこの5行目のコードは現在のメモリアドレスから510バイト目まで0で埋めます。
;そして6行目のdw擬似命令(data double byte)で511バイト目と512バイト目に55とAAを置きます。
;これが前述のブートシグネチャです。

; to compile, execute the following code
; nasm -f bin boot_sect_simple.asm -o boot_sect_simple.bin
; then execute
; qemu-system-x86_64 boot_sect_simple.bin (or qemu boot_sect_simple.bin)

;-f binによりnasmが、linuxで一般的なプログラムで使われるようなelfなどではなく、
;バイナリフォーマットにアセンブルするようにする。