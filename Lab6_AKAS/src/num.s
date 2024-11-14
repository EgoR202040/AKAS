%include "syscall.mac"
;======================================================
SECTION .text
GLOBAL _start
EXTERN num2decstr
_start:
    mov eax, 1
    cpuid ; return processor info in eax
    mov rax, rbx ; используем значение из rbx для примера
    mov rdi, decstr
    mov rcx, decstr.len
    call num2decstr
    WRITE decstr, decstr.len+1
    EXIT
;======================================================
SECTION .data
align 4
decstr: db "000000000"
.len: equ $ - decstr
db 0xA
;======================================================
