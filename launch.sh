#!/bin/sh

nasm kernel/kernel.asm -f bin -o bin/kernel.bin
qemu-system-x86_64 bin/kernel.bin

