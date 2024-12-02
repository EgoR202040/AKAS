#include <stdio.h>

extern char* getCpuName();

int main() {
    char* cpuName = getCpuName();
    printf("CPU Name: %s\n", cpuName);
    return 0;
}
