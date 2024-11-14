SECTION .text
GLOBAL num2decstr
;---------------------------------------------- ;
;subroutine for convert number to decimal string ;
;parameters: ;
; rax – number ;
; rdi - buffer for decimal string ;
; rcx - buffer length ;
;---------------------------------------------- ;
num2decstr:
    push rbx
    push rdx
    push rsi
    mov rsi, rdi
    add rsi, rcx
    dec rsi
    mov rbx, 10 ; основание системы счисления (десятичная)
.loop:
    xor rdx, rdx ; обнуляем rdx для деления
    div rbx ; делим rax на 10, результат в rax, остаток в rdx
    add dl, '0' ; преобразуем остаток в символ цифры
    mov [rsi], dl ; записываем символ в буфер
    dec rsi ; переходим к следующему символу в буфере
    loop .loop ; повторяем, пока rcx > 0
    pop rsi
    pop rdx
    pop rbx
    ret
