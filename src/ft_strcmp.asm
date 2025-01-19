; int strcmp(const char *s1, const char *s2);
; The  strcmp()  function  compares the two strings s1 and s2. It returns an integer indicating the result of the comparison, as follows:
;	• 0, if the s1 and s2 are equal
;	• The ASCII value difference between the first mismatching characters

extern  __errno_location

section .text
global ft_strcmp

set_errno:
    mov rax, 14
    push rax                ; Save error code
    call __errno_location   ; Get address of the `errno` variable
    pop qword [rax]         ; Set error code as errno address value
    mov rax, -1
    ret                     ; Return to the caller

ft_strcmp:
    mov rax, 0

._check_args:
    test rdi, rdi
    jz set_errno
    test rsi, rsi
    jz set_errno

._loop:
    mov al, byte [rdi]
    mov bl, byte [rsi]
    cmp al, bl
    jne ._return_non_eq  ; First string is greater
    cmp al, 0
    je ._return          ; Strings are equal
    inc rdi
    inc rsi
    jmp ._loop

._return_non_eq:
    sub al, bl
    movsx rax, al        ; Sign-extend AL (8-bit) to RAX (64-bit)

._return:
    ret                 ; Return to caller
