STRUC cpu_id, -8
 .raw: RESD 1
 .stepping: RESB 1
 .model: RESB 1
 .family: RESB 1
ENDSTRUC
;------------------------------------------------------------
SECTION .text
GLOBAL getcpuid
; cpu_id getcpuid()
getcpuid:
	push rbp
	mov rbp, rsp
	sub rsp, 8*1
	mov eax, 1
	cpuid
	mov [rbp+cpu_id.raw], eax ;RFFMtfms
	mov [rbp+cpu_id.stepping], eax ;RFFMtfms
	and DWORD [rbp+cpu_id.stepping], 0xf ;0000000s
	and eax, 0x0fff0fff ;0FFM0fms
	mov [rbp+cpu_id.family], ah ;0f
	shr eax, 4 ;00FFM0fm
	and eax, 0xfff00f ;00FFM00m
	mov [rbp+cpu_id.model], al ;0m
	or [rbp+cpu_id.model], ah ;Mm
	shr eax, 16 ;000000FF
	add [rbp+cpu_id.family], al ;FF+0f
	mov rax, [rbp+cpu_id]
	mov rsp, rbp
	pop rbp
	ret
