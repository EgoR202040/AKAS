section .data
    bufferSize equ 1024  ; Размер буфера для чтения строки

section .bss
    buffer resb bufferSize  ; Буфер для хранения строки

section .text
    global _start

_start:
    ; Чтение строки из stdin
    mov eax, 3          ; Системный вызов read (номер 3)
    mov ebx, 0          ; Дескриптор файла stdin (0)
    mov ecx, buffer     ; Адрес буфера для чтения
    mov edx, bufferSize ; Размер буфера
    int 0x80            ; Вызов ядра

    ; Проверка, что чтение прошло успешно
    cmp eax, 0          ; Если eax == 0, то ничего не прочитано
    jle exit            ; Если ничего не прочитано, выходим

    ; Запись строки в stdout
    mov eax, 4          ; вызов write
    mov ebx, 1          ; Дескриптор файла stdout (1)
    mov ecx, buffer     ; Адрес буфера для записи
    mov edx, bufferSize ; Можно было использовать регистр eax,но у меня он выводил только 4 байта
    int 0x80            ;

exit:
    ; Завершение программы
    mov eax, 1          ; Системный вызов exit (номер 1)
    xor ebx, ebx        ; Код завершения 0
    int 0x80            ; Вызов ядра
