boot_sect_hello.bin: boot_sect_hello.asm
	nasm -fbin boot_sect_hello.asm -o boot_sect_hello.bin

qemu: boot_sect_hello.bin
	qemu-system-x86_64 boot_sect_hello.bin

clean:
	rm *.bin

# to execute, type the following command
# make qemu