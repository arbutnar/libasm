; char *strdup(const char *s)
; The strdup() function returns a pointer to a new string which is a duplicate of the string s.
; Memory for the new string is obtained with malloc(3), and can be freed with free(3).


section .text
    global ft_strdup
    extern malloc, ft_strlen, ft_strcpy, __errno_location

set_errno:
    mov rax, 14
    push rax                ; Save error code
    call __errno_location wrt ..plt   ; Get address of the `errno` variable
    pop qword [rax]         ; Set error code as errno address value
    mov rax, 0
    ret                     ; Return to the caller

ft_strdup:
    test rdi, rdi
    jz set_errno
    push rdi                ; Push source pointer to retrieve value later

.allocate:
    call ft_strlen
    add rax, 1              ; Increment RAX by 1 (source length + 1)
    mov rdi, rax            ; Move the result into RDI (malloc argument)
    call malloc wrt ..plt   ; Malloc stores new allocated address into RAX
    mov rdi, rax            ; Move RAX into RDI register as strcpy dest argument

    pop rsi                 ; Pop source pointer into RSI as strcpy src argument
    call ft_strcpy
    ret