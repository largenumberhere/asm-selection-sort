global sort_ascending

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

    cmp qword [length], 0
    jle handle_empty_array

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
    mov eax, [rax]
    mov dword [smallest], eax

    ; initialize smallest_offset to i
    mov rax, [i]
    mov [smallest_offset], eax

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
    cmp eax, edi
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

    ; swap current value with smallest
    mov rdi, [array] 
    mov rsi, [smallest_offset]
    mov rdx, [i]

    lea rax, [rdi + (rdx * 4)]    
    mov r10, rax                  ; r10 = &array[i]
    mov eax, [rax]                ; rax = array[i]
    
    lea rcx, [rdi + (rsi * 4)]  
    mov r8, rcx                   ; r8 = &array[smallest_offset]
    mov ecx, [rcx]                ; rxc = array[smallest_offset]

    
    mov [r10], ecx                ; array[i] = array[smallest_offset]
    mov [r8], eax                 ; array[smallest_offset] = (copy of) array[i]

    inc qword [i]   ; i++
    jmp loop
loop_end:

    xor rax, rax
    ret


handle_empty_array:
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