; size_t    ft_strlen(const char *s);
; The strlen() function calculates the length of the string pointed to by s, excluding the terminating null byte ('\0').

extern __errno_location

section .text
global ft_strlen

set_errno:
    mov rax, 14
    push rax
    call __errno_location
    pop qword [rax]
    mov rax, -1
    ret


ft_strlen:
    test rdi, rdi
    jz set_errno
    xor rcx, rcx        ; Clear counter register

._loop:
    cmp byte [rdi], 0   ; Check if the current byte is null
    je ._return         ; Returns if null terminator is found
    inc rcx             ; Increment counter
    inc rdi             ; Increment char pointer
    jmp ._loop

._return:
    mov rax, rcx
    ret ; Return lenght in rax