#define STDOUT 1
typedef long long ssize_t;

ssize_t write(long file_descriptor, const void *buffer, long count) {
    ssize_t result;
    const long sys_write = 0x2000004;
    __asm__ (
        "mov x16, %1\n"
        "mov x0, %2\n"
        "mov x1, %3\n"
        "mov x2, %4\n"
        "svc #0x80\n"
        "mov %0, x0\n"
        : "=r"(result)
        : "r"(sys_write), "r"(file_descriptor), "r"(buffer), "r"(count)
        : "x16", "x0", "x1", "x2", "memory"
    );
    return result;
}

void putchar(char c) {
    write(STDOUT, &c, 1);
}

void puts(char *c) {
    for (int i = 0; ; i++) {
        if (c[i] == '\0') {
            return;
        }
        putchar(c[i]);
    }
}
