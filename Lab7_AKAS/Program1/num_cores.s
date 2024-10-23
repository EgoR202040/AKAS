section .data
    msg db 'Number of physical processors: ', 0  ; Сообщение для вывода
    msg_len equ $ - msg                          ; Длина сообщения
    buffer db '00', 0                            ; Буфер для хранения числа в виде строки
	newline db 0x0A

section .text
    global _start

_start:
    ; Запрос информации о количестве физических процессоров
    mov eax, 0xB     ; Код функции CPUID для запроса информации о физических процессорах
    xor ecx, ecx     ; ECX = 0 для первого уровня
    cpuid

    ; Количество физических процессоров находится в EBX
    mov eax, ebx

    ; Преобразуем число в строку
    mov edi, buffer
    call int_to_string

    ; Вывод сообщения на экран
    mov rax, 1       ; Системный вызов write
    mov rdi, 1       ; Дескриптор stdout
    mov rsi, msg     ; Адрес сообщения
    mov rdx, msg_len ; Длина сообщения
    syscall

    ; Вывод количества физических процессоров на экран
    mov rax, 1       ; Системный вызов write
    mov rdi, 1       ; Дескриптор stdout
    mov rsi, buffer  ; Адрес буфера с числом
    mov rdx, 2       ; Длина буфера (2 символа)
    syscall
    
    mov eax, 4           
    mov ebx, 1           
    mov ecx, newline    
    mov edx, 1         
    int 0x80            
    
    ; Завершение программы
    mov rax, 60      ; Системный вызов exit
    xor rdi, rdi     ; Код завершения 0
    syscall

; Подпрограмма для преобразования числа в строку
int_to_string:
    add edi, 1       ; Указатель на последний символ буфера
    mov byte [edi], 0 ; Завершающий ноль
    dec edi          ; Указатель на последний символ буфера
    mov ecx, 10      ; Делитель
.next_digit:
    xor edx, edx     ; Очищаем EDX для деления
    div ecx          ; Делим EAX на 10
    add dl, '0'      ; Преобразуем остаток в символ
    mov [edi], dl    ; Сохраняем символ в буфер
    dec edi          ; Перемещаем указатель на предыдущий символ
    test eax, eax    ; Проверяем, остались ли еще цифры
    jnz .next_digit  ; Если да, продолжаем
    ret
