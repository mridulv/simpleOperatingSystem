unsigned int page_table[1024] __attribute__((aligned(4096)));;

void set_page_tables() {
	unsigned int pages_entry[1024 * 1024] __attribute__((aligned(4096)));

	unsigned int KERNEL_VIRTUAL_OFFSET = 0xC0000000;
	unsigned int KERNEL_FIRST_VIRTUAL_ADDRESS = 0xC0000000 >> 12;

	int numPageTables = 4;
	int numPagesInPageTable = 1024;
	int numPageTableEntriesInPageDirectory = 1024;
	int totalPages = numPageTables * numPagesInPageTable;

	unsigned int index = 0;
	unsigned int *pages_ptr = (unsigned int *)(pages_entry - KERNEL_VIRTUAL_OFFSET);
	unsigned int *page_table_ptr = (unsigned int *)(pages_entry - KERNEL_VIRTUAL_OFFSET);

	unsigned int positionAndFlags = 7;

	while (index < totalPages) {
		pages_ptr[index] = positionAndFlags;
		index = index + 1;
		positionAndFlags += 4096;
	}

	positionAndFlags = 7;
	index = KERNEL_FIRST_VIRTUAL_ADDRESS;
	unsigned int totalPagesLeft = KERNEL_FIRST_VIRTUAL_ADDRESS + totalPages;
	while (index < totalPagesLeft) {
		pages_ptr[index] = positionAndFlags;
		index = index + 1;
		positionAndFlags += 4096;
	}

	positionAndFlags = (unsigned int)&pages_ptr[0];
	positionAndFlags = positionAndFlags | 7;
	index = 0;
	while (index < numPageTableEntriesInPageDirectory) {
		page_table_ptr[index] = positionAndFlags;
		index = index + 1;
		positionAndFlags += 4096;
	}
}

void main() {
	char* video_memory = (char*) 0xb8000;
	*video_memory = 'X';
	set_page_tables();
}

void main2() {
	char* video_memory = (char*) 0xb8004;
	*video_memory = 'Y';
	// __asm__ 
	// (
	// 	"leal (page_table, ), %ecx\n\t" // 0xC0000000 = KERNEL_VIRTUAL_BASE
	// 	"movl %cr3, %ecx"
	// );
}