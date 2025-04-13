; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_strdup.asm                                      :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: arbutnar <arbutnar@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2025/03/29 10:09:44 by arbutnar          #+#    #+#             ;
;   Updated: 2025/03/29 10:09:44 by arbutnar         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

section .text
    global ft_strdup
    extern malloc, ft_strlen, ft_strcpy, __errno_location

; char  *strdup(const char *s)
; RDI = s (pointer to string to duplicate)
; RAX = return (pointer to just created string)
ft_strdup:
    test rdi, rdi           ; check if RDI is NULL
    jz .set_errno_efault    ; if NULL, set EFAULT error
    push rdi                ; push source pointer to retrieve value later
.allocate:
    call ft_strlen
    add rax, 1              ; increment RAX by 1 (source length + 1)
    mov rdi, rax            ; move the result into RDI (malloc argument)
    call malloc wrt ..plt   ; malloc stores new allocated address into RAX
    test rax, rax           ; check if malloc returned NULL
    jz .set_errno_enomem    ; if NULL, set ENOMEM error
    mov rdi, rax            ; move RAX into RDI register as strcpy dest argument
    pop rsi                 ; pop source pointer into RSI as strcpy src argument
    call ft_strcpy
    ret                     ; return to caller
.set_errno_efault:
    mov rax, 14                     ; error code (EFAULT)
    jmp .set_errno
.set_errno_enomem:
    mov rax, 12                     ; error code (ENOMEM)
    jmp .set_errno
.set_errno:
    push rax                        ; save error code
    call __errno_location wrt ..plt ; get address of the `errno` variable
    pop qword [rax]                 ; store error code in errno
    xor rax, rax                    ; RAX = NULL
    ret                             ; return to caller