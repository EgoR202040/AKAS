%include "syscall.mac"
;======================================================
SECTION .text
GLOBAL _start
EXTERN num2decstr
_start:
	mov eax, 1
	cpuid ; return processor info in eax
	mov rax,rbx
	mov rdi, hexstr
	mov rcx, hexstr.len
	mov rsi, digits
	call num2decstr
	WRITE hexstr, hexstr.len+1
	EXIT
;======================================================
SECTION .data
digits: db "0123456789ABCDEF"
align 4
hexstr: db "000000000"
.len: equ $ - hexstr
db 0xA
;======================================================
