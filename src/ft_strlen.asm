; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_strlen.asm                                      :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: arbutnar <arbutnar@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2025/03/29 10:09:44 by arbutnar          #+#    #+#             ;
;   Updated: 2025/03/29 10:09:44 by arbutnar         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

section .text
    global ft_strlen
    extern __errno_location

; size_t    ft_strlen(const char *s)
; RDI = s (pointer to source string)
; RAX = return (length of s, excluding '\0', or -1 is s is NULL)
ft_strlen:
    test rdi, rdi           ; check if RDI is NULL
    jz .set_errno_efault    ; if NULL, set EFAULT error
    xor rax, rax            ; RAX = 0
    jmp .loop_through
.increment:
    inc rax
.loop_through:
    cmp byte [rdi + rax], 0 ; check if the current byte is null
    jne .increment          ; if not NULL, continue looping
    jmp .return
.set_errno_efault:
    call __errno_location wrt ..plt ; get address of the `errno` variable
    mov qword [rax], 14             ; store error code in errno
    mov rax, 0
.return:
    ret                     ; return lenght in RAX