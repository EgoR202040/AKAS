section .data
    vendor times 12 db 0  ; Buffer

section .text
    extern putchar        ; 
    extern exit           ; 
    global main            ;

main:
    ; Set up the stack frame
    push ebp
    mov ebp, esp

    ; Get CPUID information
    xor eax, eax          ; 
    cpuid                  ; 
    mov [vendor + 0], ebx  ;
    mov [vendor + 4], edx  ;
    mov [vendor + 8], ecx  ; 

    mov esi, vendor       ; 
    mov ecx, 12           ; 

loop_start:
    mov al, [esi]         ; 
    push eax              ; 
    call putchar          ; 
    add esp, 4            ; 
    inc esi               ; 
    loop loop_start       ; 

    ; Exit the program
    push 0                ;
    call exit             ; 
    add esp, 4            ; 

    mov esp, ebp
    pop ebp
    ret
