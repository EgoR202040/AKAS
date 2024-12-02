section .data
    cpu_name db 48 dup(0)  ; 

section .text
global getCpuName

getCpuName:
    push rbx               ; 
    push rbp
    mov rbp, rsp          ; Создание похожего на стека

    ; First call: eax = 0x80000002
    mov eax, 0x80000002
    cpuid
    mov [rel cpu_name + 0], eax   ; 
    mov [rel cpu_name + 4], ebx   ; 
    mov [rel cpu_name + 8], ecx   ;
    mov [rel cpu_name + 12], edx  ; 

    ; Second call: eax = 0x80000003
    mov eax, 0x80000003
    cpuid
    mov [rel cpu_name + 16], eax  ; 
    mov [rel cpu_name + 20], ebx  ; 
    mov [rel cpu_name + 24], ecx  ; 
    mov [rel cpu_name + 28], edx  ; 

    ; Third call: eax = 0x80000004
    mov eax, 0x80000004
    cpuid
    mov [rel cpu_name + 32], eax  ; 
    mov [rel cpu_name + 36], ebx  ; 
    mov [rel cpu_name + 40], ecx  ; 
    mov [rel cpu_name + 44], edx  ;

    lea rax, [rel cpu_name]

    mov rsp, rbp          ;
    pop rbp
    pop rbx               ; 
    ret
