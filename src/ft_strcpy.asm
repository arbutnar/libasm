; char *strcpy(char *dest, const char *src)
; The  strcpy()  function copies the string pointed to by src, including the terminating null byte ('\0'), to the buffer pointed to by dest.
; The strings may not overlap, and the destination string dest must be large enough to receive the copy.


section .text
    global ft_strcpy
    extern ft_strlen, __errno_location

set_errno:
    mov rax, 14             ; Error code (EFAULT)
    call __errno_location wrt ..plt   ; Get address of errno variable
    mov [rax], rax          ; Store error code in errno
    mov rax, 0              ; Return NULL (error case)
    ret

ft_strcpy:
    test rdi, rdi           ; Check if destination (rdi) is NULL
    jz set_errno
    test rsi, rsi           ; Check if source (rsi) is NULL
    jz set_errno

    push rdi                ; Save destination pointer (for return value)
    mov rdx, rdi            ; Save destination pointer for copying
    mov rdi, rsi            ; Move source into rdi for strlen
    call ft_strlen          ; Get length of source

    inc rax                 ; Include null terminator in length
    mov rcx, rax            ; Store length in rcx (counter for `loop`)

.copy:
    mov al, [rsi]           ; Load byte from source
    mov [rdx], al           ; Store byte to destination
    inc rsi                 ; Increment source pointer
    inc rdx                 ; Increment destination pointer
    loop .copy              ; Decrement `rcx`, jump if not zero

    pop rax                 ; Restore original destination pointer (return value)
    ret                     ; Return