; char *strcpy(char *dest, const char *src)
; The  strcpy()  function copies the string pointed to by src, including the terminating null byte ('\0'), to the buffer pointed to by dest.
; The strings may not overlap, and the destination string dest must be large enough to receive the copy.

extern  __errno_location

section .text
global ft_strcpy

set_errno:
    mov rax, 14
    push rax                ; Save error code
    call __errno_location   ; Get address of the `errno` variable
    pop qword [rax]         ; Set error code as errno address value
    mov rax, 0
    ret                     ; Return to the caller

ft_strcpy:
    test rdi, rdi
    jz set_errno
    mov rax, rdi        ; Assign content of destination pointer (RDI) to return register (RAX)
    test rsi, rsi
    jz set_errno

._loop:
    mov bl, byte [rsi]  ; Load a byte from the source (RSI) into BL
    mov byte [rdi], bl  ; Store the byte into the destination (RDI)
    inc rsi             ; Increment the source pointer (RSI)
    inc rdi             ; Increment the destination pointer (RDI)
    test bl, bl         ; Check if BL (the byte) is null (0x00)
    jne ._loop          ; If not null, continue copying
    ret                 ; Return RAX register