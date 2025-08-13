global sort_ascending

; void swap(int* buffer, int offset1, int offet2)
extern swap 

segment .text

; Inputs:
;  - rdi = length
;  - rsi = array pointer
; Outputs: none.
; Uses sysv calling convention
sort_ascending:    
    ; rax, rdi, rsi, rdx, rcx, r8, r9, r10, r11 are scratch registers
    mov [length], rdi
    mov [array], rsi

    mov qword [i], 0    ; i = 0
    
    ; tmp: rax, rdi rsi, rdx, rcx

loop:
    ; if (i >= length) goto loop_end
    mov rax, [i]
    mov rdi, [length]
    cmp rax, rdi
    jge loop_end

    ; j = i + 1
    mov rax, [i]
    inc rax
    mov [j], rax

    ; smallest = array[i]
    mov rax, [i]
    lea rax, [rax * 4]
    add rax, [array]
    mov rax, [rax]
    mov dword [smallest], eax

    ; initialize smallest_offset to i
    mov rax, [i]
    mov [smallest_offset], rax

inner_loop:
    ; if (j >= length) goto end_inner_loop
    mov rax, [j]
    cmp rax, [length]
    jge end_inner_loop

    ; if (edx >= smallest) goto not_smaller 
    mov rax, [j]
    lea rax, [rax * 4]
    add rax, [array]    ; rax = array + j
    mov eax, [rax]      ; rax = array[j]

    mov edi, [smallest]
    cmp rax, rdi
    jge not_smaller

    ; smallest = array[j]
    mov rax, [j]
    lea rax, [rax * 4]
    add rax, [array]
    mov dword eax, [rax]
    mov [smallest], eax

    ; smallest_offset = j
    mov rax, [j]
    mov [smallest_offset], rax
not_smaller:

    inc qword [j]; j++
    jmp inner_loop
end_inner_loop:

    ; swap current value with smallest. TODO    : implement in asm
    mov rdi, [array] 
    mov rsi, [smallest_offset]
    mov rdx, [i]
    call swap

    ; mov rax, [array]            ; rax = array
    ; add rax, [smallest_offset]  ; rax = array + smallest_offset
    ; mov rsi, rax                ; rsi = array + smallest_offset

    ; mov rax, [array]            ; rax = array
    ; add rax, [i]                ; rax = array + i
    ; mov rcx, rax                ; rcx = array + i

    ; mov rdx, [rcx]              ; rdx = array[i]

    ; mov [rsi], rdx              ; *(array + smallest_offset) = array[i]
    
    ; mov r9, [smallest]
    ; mov [rcx], r9               ; *(array + i) = smallest value

    inc qword [i]   ; i++
    jmp loop
loop_end:

    xor rax, rax
    ret

segment .data
    length: dq 0
    array: dq 0
    i: dq 0
    j: dq 0  
    smallest: dd 0
    smallest_offset: dq 0
segment .bss

segment .rodata