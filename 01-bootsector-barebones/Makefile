boot_sect_simple.bin: boot_sect_simple.asm
	nasm -f bin boot_sect_simple.asm -o boot_sect_simple.bin

qemu: boot_sect_simple.bin
	qemu-system-x86_64 boot_sect_simple.bin

clean:
	rm *.bin

# http://exlight.net/devel/make/make_errors.html
# https://postd.cc/writing-an-os-baby-steps/
# Press Tab command on the command-lines