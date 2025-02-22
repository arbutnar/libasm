; ssize_t ft_write(int fd, const void *buf, size_t count);
; write() writes up to count bytes from the buffer starting at buf to the file referred to by the file descriptor fd.


section .text
    global ft_write
    extern __errno_location

set_errno:
    neg rax                 ; Convert negative return value to positive (error code)
    push rax                ; Save error code
    call __errno_location wrt ..plt   ; Get address of the `errno` variable
    pop qword [rax]         ; Set error code as errno address value
    mov rax, -1
    ret                     ; Return to the caller

ft_write:
    mov rax, 1              ; System call number for `write` (1 for Linux)
    syscall                 ; Perform the system call
    test rax, rax           ; Check if RAX (return value) is negative
    js set_errno            ; Jump if negative
    ret                     ; Return to the caller