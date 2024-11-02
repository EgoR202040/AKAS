%include "syscall.mac"
;======================================================
SECTION .text
GLOBAL _start
EXTERN num2hexstr
_start:
    mov eax, 1
    cpuid ; return processor info in eax
    shr ebx, 16 ; так как содержимое cpuid_ebx взято из регистра ebx
    and ebx, 0xFF
    mov [procnum], ebx
    WRITE procnum, 10
    EXIT
;======================================================
SECTION .data
newline: db 0x0A
procnum: dq 0
digits: db "0123456789ABCDEF"
align 4
hexstr: db "000000000"
.len: equ $ - hexstr
db 0xA
;======================================================

