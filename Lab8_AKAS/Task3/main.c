#include <stdio.h>

extern unsigned int crc32c(const unsigned int *buf, unsigned long len);

int main() {
    unsigned int data[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 0};
    unsigned long len = sizeof(data) / sizeof(data[0]);
    unsigned int crc = crc32c(data, len);
    printf("CRC32: %08x\n", crc);
    return 0;
}
