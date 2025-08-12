global sort_ascending2

segment .text

; Inputs:
;  - rdi = length
;  - rsi = array pointer
; Outputs: none.
; Uses sysv calling convention
sort_ascending2:    
    ; rax, rdi, rsi, rdx, rcx, r8, r9, r10, r11 are scratch registers
    mov [length], rdi
    mov [array], rsi

    xor r8d, r8d    ; r8d = smallest offset
    xor rax, rax    ; rax = temporary1
    xor rcx, rcx    ; ecx = temporary2
    xor rdi, rdi    ; rdi = smallest value
    xor rsi, rsi    ; rsi = tmp 4
    xor rdx, rdx    ; rdx = tmp 5

    mov qword [i], 0    ; i = 0
loop:
    ; if (i >= length) goto loop_end
    mov rax, [i]
    mov rdi, [length]
    cmp rax, rdi
    jge loop_end

    ; j = i
    mov rax, [i]
    mov [j], rax

    ; edi (smallest) = array[i]
    mov rdi, [array]
    add rdi, [i]
    mov edi, [rdi]

    ; r8d (smallest_offset) = i
    mov r8d, [i]

inner_loop:
    ; if (j >= length) goto end_inner_loop
    mov rax, [j]
    cmp rax, [length]
    jge end_inner_loop

    ; edx = array[j]
    mov rax, [array]
    add rax, [j]
    mov edx, [rax]

    ; if (edx >= smallest) goto not_smaller 
    cmp edx, edi
    jge not_smaller

    ; update smallest. edi = edx
    mov edi, edx

    ; upsate smallest offset r8d = j
    mov r8d, [j]
not_smaller:

    inc qword [j]; j++
    jmp inner_loop
end_inner_loop:

    ; swap current value with smallest
    mov rax, [array]
    add rax, r8         
    mov rsi, rax        ; rsi = &array[smallest_offset]

    mov rax, [array]
    add rax, [i]        
    mov rcx, rax        ; rcx = &array[i]

    mov rdx, [rcx]      ; rdx = array[i]
    mov [rsi], rdx      ; array[smallest_offset] = array[i]
    mov [rcx], r8d      ; array[i] = smallest value

    inc qword [i]   ; i++
    jmp loop
loop_end:


    ret

segment .data
    length: dq 0
    array: dq 0
    i: dq 0
    j: dq 0
    tmp: dq 0    
    smallest: dq 0
    smallest_offset: dq
segment .bss

segment .rodata