default: qemu

kernel.o:
	gcc -m32 -ffreestanding -c kernel/kernel.c -o bin/kernel.o

kernel_entry.o: 
	nasm kernel/kernel_entry.asm -f elf -o bin/kernel_entry.o

kernel.bin: kernel_entry.o kernel.o
	ld -melf_i386 -o bin/kernel.bin -Ttext 0x1000 bin/kernel_entry.o bin/kernel.o --oformat binary

debug: kernel.bin
	od -t x1 -A n bin/kernel.bin

boot.bin:
	nasm kernel/boot.asm -f bin -o bin/boot.bin

qemu: kernel.bin boot.bin
	cat bin/boot.bin bin/kernel.bin > bin/os_image
	qemu-system-x86_64 bin/os_image

clean:
	rm -r bin/*
