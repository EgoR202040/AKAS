section .data
    sse_msg db "SSE supported", 0
    sse2_msg db "SSE2 supported", 0
    sse3_msg db "SSE3 supported", 0
    ssse3_msg db "SSSE3 supported", 0
    sse41_msg db "SSE4.1 supported", 0
    sse42_msg db "SSE4.2 supported", 0
    avx_msg db "AVX supported", 0
    avx2_msg db "AVX2 supported", 0
    avx512_msg db "AVX-512 supported", 0
    not_supported_msg db "Not supported", 0

section .text
    global _start

_start:
    ; Проверка поддержки SSE
    mov eax, 1
    cpuid
    bt edx, 25  ; Проверка наличия SSE
    jc sse_supported
    mov rdi, not_supported_msg
    call print_string
    jmp check_sse2

sse_supported:
    mov rdi, sse_msg
    call print_string

check_sse2:
    ; Проверка поддержки SSE2
    mov eax, 1
    cpuid
    bt edx, 26  ; Проверка наличия SSE2
    jc sse2_supported
    mov rdi, not_supported_msg
    call print_string
    jmp check_sse3

sse2_supported:
    mov rdi, sse2_msg
    call print_string

check_sse3:
    ; Проверка поддержки SSE3
    mov eax, 1
    cpuid
    bt ecx, 0  ; Проверка наличия SSE3
    jc sse3_supported
    mov rdi, not_supported_msg
    call print_string
    jmp check_ssse3

sse3_supported:
    mov rdi, sse3_msg
    call print_string

check_ssse3:
    ; Проверка поддержки SSSE3
    mov eax, 1
    cpuid
    bt ecx, 9  ; Проверка наличия SSSE3
    jc ssse3_supported
    mov rdi, not_supported_msg
    call print_string
    jmp check_sse41

ssse3_supported:
    mov rdi, ssse3_msg
    call print_string

check_sse41:
    ; Проверка поддержки SSE4.1
    mov eax, 1
    cpuid
    bt ecx, 19  ; Проверка наличия SSE4.1
    jc sse41_supported
    mov rdi, not_supported_msg
    call print_string
    jmp check_sse42

sse41_supported:
    mov rdi, sse41_msg
    call print_string

check_sse42:
    ; Проверка поддержки SSE4.2
    mov eax, 1
    cpuid
    bt ecx, 20  ; Проверка наличия SSE4.2
    jc sse42_supported
    mov rdi, not_supported_msg
    call print_string
    jmp check_avx

sse42_supported:
    mov rdi, sse42_msg
    call print_string

check_avx:
    ; Проверка поддержки AVX
    mov eax, 1
    cpuid
    bt ecx, 28  ; Проверка наличия AVX
    jc avx_supported
    mov rdi, not_supported_msg
    call print_string
    jmp check_avx2

avx_supported:
    mov rdi, avx_msg
    call print_string

check_avx2:
    ; Проверка поддержки AVX2
    mov eax, 7
    xor ecx, ecx
    cpuid
    bt ebx, 5  ; Проверка наличия AVX2
    jc avx2_supported
    mov rdi, not_supported_msg
    call print_string
    jmp check_avx512

avx2_supported:
    mov rdi, avx2_msg
    call print_string

check_avx512:
    ; Проверка поддержки AVX-512
    mov eax, 7
    xor ecx, ecx
    cpuid
    bt ebx, 16  ; Проверка наличия AVX-512
    jc avx512_supported
    mov rdi, not_supported_msg
    call print_string
    jmp exit

avx512_supported:
    mov rdi, avx512_msg
    call print_string

exit:
    mov rax, 60  ; syscall: exit
    xor rdi, rdi
    syscall

print_string:
    ; Подпрограмма для вывода строки на экран
    push rdi
    call string_length
    pop rsi
    mov rdx, rax
    mov rax, 1  ; syscall: write
    mov rdi, 1  ; file descriptor: stdout
    syscall
    ret

string_length:
    ; Подпрограмма для вычисления длины строки
    xor rax, rax
    .loop:
    cmp byte [rdi+rax], 0
    je .end
    inc rax
    jmp .loop
    .end:
    ret
