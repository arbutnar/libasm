; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_write.asm                                       :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: arbutnar <arbutnar@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2025/03/29 10:09:44 by arbutnar          #+#    #+#             ;
;   Updated: 2025/03/29 10:09:44 by arbutnar         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

section .text
    global ft_write
    extern __errno_location

; ssize_t   ft_write(int fd, const void *buf, size_t count)
; RDI = fd (destination file descriptor)
; RSI = buf (pointer to source buffer)
; RDX = count (number of bytes to write)
; RAX = return (0 if ok, or -1 if syscall returned error)
ft_write:
    mov rax, 1              ; system call number for `write` (1 for Linux)
    syscall                 ; perform the system call
    cmp rax, 0              ; check if return value is negative
    js .set_errno           ; if negative, set errno
    ret                     ; return to caller
.set_errno:
    neg rax                         ; negate error code
    push rax                        ; save error code
    call __errno_location wrt ..plt ; get address of the `errno` variable
    pop qword [rax]                 ; store error code in errno
    mov rax, -1
    ret                             ; return to caller