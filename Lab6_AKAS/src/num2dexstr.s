section .data
    digit_buffer times 20 db 0  ; Буфер для хранения
SECTION .text
GLOBAL num2dexstr

num2dexstr:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    push r15

    mov r12, rdi       ; Сохраняем копию числа в r12
    mov r13, digit_buffer ; Указатель на буфер для строки
    mov r14, 10        ; Делитель (10 для десятичной системы)
    xor r15, r15       ; Счетчик цифр

.loop:
    xor rdx, rdx       ; Очищаем rdx для деления
    mov rax, r12       ; Число в rax
    div r14            ; Делим на 10 (rax = частное, rdx = остаток)
    add rdx, '0'       ; Преобразуем остаток в 0
    mov [r13 + r15], dl ; Сохраняем символ в буфер
    inc r15            ; Увеличиваем счетчик цифр
    mov r12, rax       ; Обновляем число (частное)
    test rax, rax      ; Проверяем, равно ли число нулю
    jnz .loop          ; Если не равно, продолжаем цикл

    ; Инвертируем строку (так как цифры были сохранены в обратном порядке)
    mov rdi, r13       ; Указатель на начало буфера
    lea rsi, [r13 + r15 - 1] ; Указатель на конец буфера

.reverse_loop:
    cmp rdi, rsi
    jae .end_reverse
    mov al, [rdi]
    mov bl, [rsi]
    mov [rdi], bl
    mov [rsi], al
    inc rdi
    dec rsi
    jmp .reverse_loop

.end_reverse:
    mov byte [r13 + r15], 0 ; Добавляем завершающий нулевой байт(обязательно)
    mov rax, r13       ; Возвращаем указатель на строку

    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret
