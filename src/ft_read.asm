; ssize_t read(int fd, void *buf, size_t count);
; read() attempts to read up to count bytes from file descriptor fd into the buffer starting at buf.


section .text
    global ft_read
    extern __errno_location

set_errno:
    neg rax                 ; Convert negative return value to positive (error code)
    push rax                ; Save error code
    call __errno_location wrt ..plt   ; Get address of the `errno` variable
    pop qword [rax]         ; Set error code as errno address value
    mov rax, -1
    ret                     ; Return to the caller

ft_read:
    mov rax, 0              ; System call number for `read` (0 for Linux)
    syscall                 ; Perform the system call
    test rax, rax           ; Check if RAX (return value) is negative
    js set_errno            ; Jump if negative
    ret                     ; Return to the caller