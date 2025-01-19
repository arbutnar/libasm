; int     ft_atoi_base(char *str, char *base)

; • Write a function that converts the initial portion of the string pointed by str to int representation.
; • str is in a specific base given as a second parameter.
; • excepted the base rule, the function should work exactly like ft_atoi.
; • If there's an invalid argument, the function should return 0. Examples of invalid arguments :
;     ◦ base is empty or size of 1
;     ◦ base contains the same character twice 
;     ◦ base contains + or - or whitespaces

extern ft_strlen

section .data
invalid_chars: db "+- "

section .text
global ft_atoi_base

ft_atoi_base:
._check_args:
    test rdi, rdi
    jz ._return_error
    test rsi, rsi
    jz ._return_error

    push rdi
    mov rdi, rsi
    call ft_strlen
    cmp rax, 0
    je ._return_error
    cmp rax, 1
    je ._return_error


._return_error:
    mov rax, 0
    ret
