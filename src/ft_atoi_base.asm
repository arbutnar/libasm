; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_atoi_base.asm                                   :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: arbutnar <arbutnar@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2025/03/29 10:09:44 by arbutnar          #+#    #+#             ;
;   Updated: 2025/03/29 10:09:44 by arbutnar         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

default rel     ; address type for memory operands to be RIP-relative instead of absolute addressing

section .data
    sign        DB 1
    base_len    DB 0
    res         DB 0

section .text
    global ft_atoi_base
    extern __errno_location

is_space:
    cmp byte [rdi], 9      ; '\t'(Tab)
    je .return_true
    cmp byte [rdi], 10     ; '\n'(Newline)
    je .return_true
    cmp byte [rdi], 11     ; '\v'(Vertical tab)
    je .return_true
    cmp byte [rdi], 12     ; '\f'(Form feed)
    je .return_true
    cmp byte [rdi], 13     ; '\r'(Carriage return)
    je .return_true
    cmp byte [rdi], 32     ; ' '(Space)
    je .return_true
.return_false:
    xor rax, rax
    ret
.return_true:
    mov rax, 1
    ret

check_base:
    sub rsp, 256
    mov rcx, 256
    xor rax, rax
    mov rdi, rsp
    rep stosb
    xor rcx, rcx            ; RCX = 0
.loop:
    movzx rax, byte [rsi + rcx]
    cmp rax, 0
    je .return_base_length
    cmp rax, '-'                ; check for invalid character in base
    je .return_error            ; if found, return -1 with errno
    cmp rax, '+'                ; check for invalid character in base
    je .return_error            ; if found, return -1 with errno
    cmp byte [rsp + rax], 1     ; Check if this character was seen before
    je .return_error
    mov byte [rsp + rax], 1
    inc rcx
    jmp .loop
.return_base_length:
    mov r9, rcx
    mov rax, rcx            ; save base length in RAX
    jmp .return
.return_error:
    mov rax, -1             ; if error occured return 0
.return:
    add rsp, 256
    ret                     ; return to caller

handle_spaces:
    jmp .loop
.inc:
    inc rdi
.loop:
    cmp byte [rdi], 9      ; '\t'(Tab)
    je .inc
    cmp byte [rdi], 10     ; '\n'(Newline)
    je .inc
    cmp byte [rdi], 11     ; '\v'(Vertical tab)
    je .inc
    cmp byte [rdi], 12     ; '\f'(Form feed)
    je .inc
    cmp byte [rdi], 13     ; '\r'(Carriage return)
    je .inc
    cmp byte [rdi], 32     ; ' '(Space)
    je .inc
    ret

handle_signs:
    jmp .loop
.update_sign:
    neg byte [sign]
.inc:
    inc rdi
.loop:
    cmp byte [rdi], '-'
    je .update_sign
    cmp byte [rdi], '+'
    je .inc
    ret

get_index:
    xor rax, rax
.loop:
    movzx r13, byte [rsi + rax]
    cmp r13, 0
    je .not_found
    cmp r13b, byte [rdi]
    je .return
    inc rax
    jmp .loop
.not_found:
    mov rax, -1
.return:
    ret

handle_conversion:
    xor rax, rax
    jmp .loop
.inc:
    inc rdi
.loop:
    cmp byte [rdi], 0
    je .return
    push rax
    call get_index
    mov r8, rax
    pop rax
    test r8, r8
    js .return
    mul r9
    add rax, r8
    jmp .inc
.return:
    ret

; int ft_atoi_base(char *str, char *base)
; RDI = str (pointer to string to convert)
; RSI = base (pointer to string that rapresent base)
; RAX = return (numeric value of str converted in base)
ft_atoi_base:
    test rdi, rdi
    jz .return_errno_efault
    test rsi, rsi
    jz .return_errno_efault
    push rdi
    call check_base
    pop rdi
    cmp rax, 2
    jl .return_errno_efault

    call handle_spaces
    call handle_signs
    call handle_conversion
    movsx rbx, byte [sign]
    mul rbx                     ; apply sign to return value
    ret
.return_errno_efault:
    mov rax, 14                     ; error code (EFAULT)
    push rax                        ; save error code
    call __errno_location wrt ..plt ; get address of the `errno` variable
    pop qword [rax]                 ; store error code in errno
    mov rax, -1
    ret