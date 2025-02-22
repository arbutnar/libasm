; Write a function that converts the string argument str (base N <= 16)
; to an integer (base 10) and returns it.

; The characters recognized in the input are: 0123456789abcdef
; Those are, of course, to be trimmed according to the requested base. For
; example, base 4 recognizes "0123" and base 16 recognizes "0123456789abcdef".
; Uppercase letters must also be recognized: "12fdb3" is the same as "12FDB3".

; Minus signs ('-') are interpreted only if they are the first character of the
; string.

; Your function must be declared as follows:
; int  ft_atoi_base(const char *str, int str_base);


section .data
    lbase    DB '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 0
    ubase    DB '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 0

section .text
    global ft_atoi_base

; ft_atoi_base(const char *str, int str_base)
; rdi = str
; rsi = str_base
ft_atoi_base:
    cmp rdi, 0
    je .early_ret
    cmp rsi, 2
    jl  .early_ret
    cmp rsi, 16
    jg  .early_ret
    mov rax, 0              ; initialize return value
.check_neg_sign:
    cmp byte [rdi], '-'     ; check if return will be negative
    test    rdi, rdi
    jnz .check_plus_sign
    neg rax
    inc rdi
    jmp .check_plus_sign
.skip_sign:
    inc rdi
.check_plus_sign:
    cmp byte [rdi], '+'          ; skip initial '+' characters
    je  .skip_sign
    jmp .check_cond
.continue:
    inc rdi
.check_cond:
    cmp byte [rdi], 0
    jne .loop_through
    ret                     ; return (rax)
.loop_through:
    cmp byte [rdi], 9       ; '\t' (Tab)
    je  .continue
    cmp byte [rdi], 10      ; '\n' (Newline)
    je  .continue
    cmp byte [rdi], 11      ; '\v' (Vertical tab)
    je  .continue
    cmp byte [rdi], 12      ; '\f' (Form feed)
    je  .continue
    cmp byte [rdi], 13      ; '\r' (Carriage return)
    je  .continue
    cmp byte [rdi], 32      ; ' ' (Space)
    je  .continue
    mov rcx, 0
    jmp .in_base
.inc_base:
    inc rcx
.in_base:
    mov dl, byte [rdi]            ; Load byte from [rdi] into DL
    cmp byte [lbase + rcx], dl    ; Compare DL with [lbase + rcx]
    je  .convert
    cmp byte [ubase + rcx], dl
    je  .convert
    cmp rcx, rsi
    jne .inc_base
    jmp .early_ret
.convert_dec:
    cmp byte [rdi], '9'
    jg  .check_l_hex
    mov rdx, rax
    movzx rax, byte [rdi]
    sub rax, '0'
    push    rax
    mov rax, rdx
    pop rdx
    add rax, rdx
    jmp .continue
.convert_l_hex:
    cmp byte [rdi], 'f'
    jg  .check_u_hex
    mov rdx, rax
    movzx rax, byte [rdi]
    sub rax, 'a'
    add rax, 10
    push    rax
    mov rax, rdx
    pop rdx
    add rax, rdx
    jmp .continue
.convert_u_hex:
    cmp byte [rdi], 'F'
    jg  .continue
    mov rdx, rax
    movzx rax, byte [rdi]
    sub rax, 'A'
    add rax, 10
    push    rax
    mov rax, rdx
    pop rdx
    add rax, rdx
    jmp .continue
.convert:
    mul rsi                 ; rax *= rsi
.check_dec:
    cmp byte [rdi], '0'
    jge .convert_dec
.check_l_hex:
    cmp byte [rdi], 'a'
    jge .convert_l_hex
.check_u_hex:
    cmp byte [rdi], 'A'
    jge .convert_u_hex
.early_ret:
    mov rax, 0
    ret
