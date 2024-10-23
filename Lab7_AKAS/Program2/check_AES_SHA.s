section .data
	newline db 0x0A
    rdrand_msg db "RDSEED/RDRAND supported", 0
    aes_msg db "AES-NI supported", 0
    sha_msg db "SHA extensions supported", 0
    not_supported_msg db "Not supported", 0

section .text
    global _start

_start:
    ; Проверка поддержки RDRAND/RDSEED
    mov eax, 1
    cpuid
    bt ecx, 30  ; Проверка наличия RDRAND
    jc rdrand_supported
    bt ecx, 18  ; Проверка наличия RDSEED
    jc rdrand_supported
    jmp check_aes

rdrand_supported:
    mov rdi, rdrand_msg
    call print_string

check_aes:
    ; Проверка поддержки AES-NI
    mov eax, 1
    cpuid
    bt ecx, 25  ; Проверка наличия AES-NI
    jc aes_supported
    mov rdi, not_supported_msg
    call print_string
    jmp check_sha

aes_supported:
    mov rdi, aes_msg
    call print_string

check_sha:
    ; Проверка поддержки SHA extensions
    mov eax, 7
    xor ecx, ecx
    cpuid
    bt ebx, 29  ; Проверка наличия SHA extensions
    jc sha_supported
    mov rdi, not_supported_msg
    call print_string
    jmp exit

sha_supported:
    mov rdi, sha_msg
    call print_string
    mov eax, 4           
    mov ebx, 1           
    mov ecx, newline    
    mov edx, 1         
    int 0x80 

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
