# Reference

This contents are totally based on the following link

- [x64 アセンブリ 入門](http://www.zombie-hunting-club.com/entry/2017/10/22/010630)
- [主なx64レジスタまとめ](http://www.zombie-hunting-club.com/entry/2017/10/15/220724)

## 記法
アセンブリの記法にはIntel記法とAT&T記法の二種類がある。

Intel記法:

    mov eax, 2      ; eaxに2を代入  
    
AT&T記法:

    mov $2, %eax    ; 上記と同じ  
    
また、アセンブリにおけるコメントアウトは、";" である。

## プログラムの基本構成

data, bss, text の３セクションで構成される

Scriptでは次のような感じ

    section .data
    
    section .text
    
    section .text
       global main
    main:
    
詳しい説明は次のリンクを

- [Pythonやってた数学科がハッカーになるためにOS自作を目指してやるの巻ーその２（アセンブラを読む）](https://qiita.com/kiwamizamurai/items/f502b3b70c7b4a624017)

## アセンブリ命令の構成
アセンブリ命令は、ニーモニックとオペランドの二つから構成されている。
ニーモニックは命令の種類であり、オペランドは命令の対象である。Example:

    mov eax, 2
    
- mov: ニーモニック
- eax: 第一オペランド
- 2 : 第二オペランド

## 基本的なmnemonic

これについてはggrべし

    アセンブリ　命令　一覧　
    x86 ニーモニック　リスト
    
など

## バイトオーダー
データをメモリに格納する方法には、**ビッグエンディアン**と**リトルエンディアン**の二種類がある。
たとえば、 ABCD（0x41424344） という文字列を格納する場合を考える。 

- ビッグエンディアンの場合

そのまま \x41\x42\x43\x44 と格納されるが、

- リトルエンディアンの場合

\x44\x43\x42\x41 と逆順で格納される。 

x64ではリトルエンディアンが採用されているので、この方式に慣れる必要がある。
    
    

## What is register?

レジスタは、プロセッサ内部にある記憶回路である。
最初はレジスタと言われてもピンとこないかもしれないが、実際にアセンブリを書くときには、
レジスタは変数と同じように扱えるので、難しく考えず単なる変数だと思えば良い。
また、レジスタには、ある程度役割が決まっているものもあるので、注意が必要である。
レジスタの名称は、x86かx64かで異なる。レジスタには主に以下の種類が存在する。

- 汎用レジスタ
- 演算用レジスタ
- フラグレジスタ
- 命令ポインタレジスタ

上記のうち汎用レジスタは、ある程度は好きに使用できるが、その他は特別な用途があり、使用するときは注意が必要である。



### 汎用レジスタ
汎用的に使用できるレジスタ。
以下の種類が存在する。

    RAX, RBX, RCX, RDX, RSI, RDI, RSP, RBP, R8 ~ R15

この中でも、アセンブリを書くときに特に覚えておきたいのは、
システムコール番号は RAX に指定し、以下の順番でシステムコールの引数をとるということである。

    UNIX: RDI, RSI, RDX, RCX, R10, R8, R9
    Windows: RCX, RDX, R8, R9




### Size of register

| 大きさ         ||レジスタ名|
| ------------- |---|-------------:|
| 64bit   || RAX, RBX, RCX, RDX, RSI, RDI, RSP, RBP, R8~R15 |
|32bit	|| EAX, EBX, ECX, EDX, ESI, EDI, ESP, EBP, R8D~R15D|
|16bit || AX, BX, CX, DX, SI, DI, SP, BP, R8W~R15W|
|上位8bit || AH, BH, CH, DH|
|下位8bit || AL, BL, CL, DL, SIL, DIL, SPL, BPL, R8L~R15L|


![image](https://cdn-ak.f.st-hatena.com/images/fotolife/G/Garfields/20171015/20171015220450.png)



## システムコール

- [x86 Linux の 32bit と 64bit のシステムコールの違い](https://www.mztn.org/lxasm64/x86_x64_table.html)
- [x86　Linux　システムコール一覧](http://d.hatena.ne.jp/toshi_hirasawa/20081105/1225885030)


MacOSではシステムコール番号がLinuxと異なるので注意する必要がある。
例えば次の"Hello, world!" と出力するアレンブリコード(hello.asm)を考える。
上のリンクからもわかるように

- writeのシステムコールは、4
- exitのシステムコールは、1

であるがMacOSの場合はこれらの数値に `0x2000000` を足す必要があるつまり次のようになる。
ちなみに32bitで使われていた`int 0x80`は64bitでは`syscall`になる。

また、システムコールの引数は、第一引数から以下のレジスタに格納する必要がある。

    rdi, rsi, rdx, rcx, r8, r9
    
引数が7つ以上ある場合には、7つめ以降の引数をスタックにプッシュする。


    global _main
    section .text
    _main:
        mov     rax, 0x2000004             ; system call number (sys_write)
        mov     rdi, 1                     ; file descriptor (stdout)
        mov     rsi, msg                   ; message to write
        mov     rdx, msg.len               ; message length
        syscall                            ; call kernel (実行と思えばいい？)
        mov     rax, 0x2000001             ; system call number (sys_exit)
        mov     rdi, 0
        syscall                            ; call kernel (実行と思えばいい？)
    section .data
    msg:    db      "Hello, world!", 10    ; a message   (10=0x0a means new line)
    .len:   equ     $ - msg                ; length of message

実行の際は次のコマンドを打てばよいが`macosx_version_min`はそれぞれの環境で異なるので次のコマンドで確認する必要がある

    $ sw_vers
    ProductName:    Mac OS X
    ProductVersion: 10.14.4

確認ができれば

    $ nasm -f macho64 hello.asm
    $ ld -macosx_version_min 10.14 -lSystem -o hello hello.o
    $ ./hello






