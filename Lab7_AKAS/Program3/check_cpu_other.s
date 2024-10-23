section .data
	newline db 0x0A
    bmi1_msg db "BMI1 supported", 0
    bmi2_msg db "BMI2 supported", 0
    adx_msg db "ADX supported", 0
    not_supported_msg db "Not supported", 0

section .text
    global _start

_start:
    ; Проверка поддержки BMI1
    mov eax, 7
    xor ecx, ecx
    cpuid
    bt ebx, 3  ; Проверка наличия BMI1
    jc bmi1_supported
    mov rdi, not_supported_msg
    call print_string
    jmp check_bmi2

bmi1_supported:
    mov rdi, bmi1_msg
    call print_string
    mov eax, 4           
    mov ebx, 1           
    mov ecx, newline    
    mov edx, 1         
    int 0x80 

check_bmi2:
    ; Проверка поддержки BMI2
    mov eax, 7
    xor ecx, ecx
    cpuid
    bt ebx, 8  ; Проверка наличия BMI2
    jc bmi2_supported
    mov rdi, not_supported_msg
    call print_string
    jmp check_adx

bmi2_supported:
    mov rdi, bmi2_msg
    call print_string
    mov eax, 4           
    mov ebx, 1           
    mov ecx, newline    
    mov edx, 1         
    int 0x80 

check_adx:
    ; Проверка поддержки ADX
    mov eax, 7
    xor ecx, ecx
    cpuid
    bt ebx, 19  ; Проверка наличия ADX
    jc adx_supported
    mov rdi, not_supported_msg
    call print_string
    jmp exit

adx_supported:
    mov rdi, adx_msg
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
