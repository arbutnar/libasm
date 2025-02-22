; size_t    ft_strlen(const char *s);
; The strlen() function calculates the length of the string pointed to by s, excluding the terminating null byte ('\0').


section .text
    global ft_strlen
    extern __errno_location

set_errno:
    mov rax, 14             ; Error code (EFAULT)
    call __errno_location wrt ..plt   ; Get address of errno variable
    mov [rax], rax          ; Store error code in errno
    mov rax, -1
    ret

ft_strlen:
    test rdi, rdi           ; Check if destination (rdi) is NULL
    jz set_errno
    xor rcx, rcx            ; Clear counter register

.loop:
    cmp byte [rdi + rcx], 0 ; Check if the current byte is null
    je .return              ; Returns if null terminator is found
    inc rcx                 ; Increment counter
    jmp .loop

.return:
    mov rax, rcx
    ret                     ; Return lenght in rax