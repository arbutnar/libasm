; ssize_t read(int fd, void *buf, size_t count);
; read() attempts to read up to count bytes from file descriptor fd into the buffer starting at buf.

section .text
global ft_read

ft_read:
	mov rax, 0       ; System call number for `read` (0 for Linux)
    mov rdi, rdi     ; File descriptor (passed as the first argument)
    mov rsi, rsi     ; Buffer pointer (passed as the second argument)
    mov rdx, rdx     ; Size of data to read (passed as the third argument)
    syscall          ; Make the system call
    ret              ; Return to the caller