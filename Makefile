default: qemu

qemu: kernel.bin
	qemu-system-x86_64 bin/kernel.bin

kernel.bin: 
	nasm kernel/kernel.asm -f bin -o bin/kernel.bin

debug: kernel.bin
	od -t x1 -A n bin/kernel.bin

clean:
	rm -r bin/*
