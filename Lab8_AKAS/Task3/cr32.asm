SECTION .text
GLOBAL crc32c

; unsigned int crc32c(const unsigned int * buf, unsigned long len)
; * buf - rdi
; len - rsi
crc32c:
    mov eax, -1          ; начальное заполнение
    xor r11, r11         ; индекс массива
    shl rsi, 2           ; умножаем длину на 4, так как теперь работаем с 32-битными значениями

.oncemore:
    crc32 eax, dword [rdi+r11]  ; накопление CRC для 32-битного значения
    add r11, 4           ; следующий элемент массива (шаг 4 байта)
    cmp r11, rsi         ; конец массива?
    jne .oncemore        ; нет – еще разок

    xor eax, -1          ; инверсия результата
    ret
