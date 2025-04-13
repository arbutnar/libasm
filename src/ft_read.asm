; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_read.asm                                        :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: arbutnar <arbutnar@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2025/03/29 10:09:44 by arbutnar          #+#    #+#             ;
;   Updated: 2025/03/29 10:09:44 by arbutnar         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

section .text
    global ft_read
    extern __errno_location

; ssize_t   ft_read(int fd, const void *buf, size_t count)
; RDI = fd (source file descriptor)
; RSI = buf (pointer to destination buffer)
; RDX = count (number of bytes to read)
; RAX = return (0 if ok, or -1 if syscall returned error)
ft_read:
    mov rax, 0              ; system call number for `read` (0 for Linux)
    syscall                 ; perform the system call
    cmp rax, 0              ; check if RAX (return value) is negative
    js .set_errno           ; jump if negative
    ret                     ; return to caller
.set_errno:
    neg rax                         ; convert negative return value to positive (error code)
    push rax                        ; save error code in r12 (callee-saved register)
    call __errno_location wrt ..plt ; get address of the `errno` variable
    pop qword [rax]                 ; set error code as errno address value
    mov rax, -1
    ret                             ; return to caller