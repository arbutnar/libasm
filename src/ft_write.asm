; ssize_t ft_write(int fd, const void *buf, size_t count);
; write() writes up to count bytes from the buffer starting at buf to the file referred to by the file descriptor fd.

section .text
global ft_write

ft_write:
	mov rax, 1       ; System call number for `write` (1 for Linux)
    mov rdi, rdi     ; File descriptor (passed as the first argument)
    mov rsi, rsi     ; Buffer pointer (passed as the second argument)
    mov rdx, rdx     ; Size of data to write (passed as the third argument)
    syscall          ; Make the system call
    ret              ; Return to the caller