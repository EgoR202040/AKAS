	SECTION .text
	GLOBAL num2hexstr
;subroutine for convert number to hex string ;
;parameters: ;
; rax – number ;
; rdi - buffer for hex string ;
; rcx - buffer length ;
; rsi - address of table with hex digits ;
;---------------------------------------------- ;
num2hexstr:
	mov rdx, rax ; копия обрабатываемого числа
	and rdx, 0xF ; обнуляем все, кроме младших 4 бит
	mov dl, [rsi + rdx] ; для этих бит выбираем цифру из таблицы
	mov [rdi+rcx-1], dl ; записываем цифру в конец строки
	shr rax, 4 ; сдвигаем число на одну цифру вправо
	loop num2hexstr ; повторяем, пока rcx>0
	ret
;======================================================
SECTION .data
digits: db "0123456789ABCDEF"
	align 4
hexstr: db "000000000"
.len: equ $ - hexstr
	db 0xA
;======================================================
