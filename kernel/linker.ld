SECTIONS {
	. = 0xC0100000;

	.text : AT(ADDR(.text) - 0xC0000000) {
		*(.text);
	}

	. = ALIGN(0x1000);
	.bss : AT(ADDR(.bss) - 0xC0000000) {
		*(.text);
	}

	. = ALIGN(0x1000);
	.data : AT(ADDR(.data) - 0xC0000000) {
		*(.text);
	}
}