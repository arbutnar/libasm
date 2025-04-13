; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_strcpy.asm                                      :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: arbutnar <arbutnar@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2025/03/29 10:09:44 by arbutnar          #+#    #+#             ;
;   Updated: 2025/03/29 10:09:44 by arbutnar         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

section .text
    global ft_strcpy
    extern ft_strlen, __errno_location

; char  *strcpy(char *dest, const char *src)
; RDI = dest (pointer to copy string)
; RSI = src (pointer to copied string, including '\0')
; RAX = return (pointer to dest)
ft_strcpy:
    test rdi, rdi           ; check if RDI is NULL
    jz .set_errno_efault    ; if NULL, set EFAULT error
    test rsi, rsi           ; check if RSI is NULL
    jz .set_errno_efault    ; if NULL, set EFAULT error
    mov rax, rdi            ; store destination in rax (for return value)
    xor rcx, rcx            ; initialize counter to 0
.loop_through:
    mov bl, [rsi + rcx]     ; load byte from source into BL
    mov [rdi + rcx], bl     ; store byte to destination
    inc rcx                 ; increment counter
    test bl, bl             ; check if NULL
    jnz .loop_through       ; if not NULL, continue looping
    ret                     ; return to caller (RAX == RDI)
.set_errno_efault:
    mov rax, 14                     ; error code (EFAULT)
    push rax                        ; save error code
    call __errno_location wrt ..plt ; get address of the `errno` variable
    pop qword [rax]                 ; store error code in errno
    xor rax, rax                    ; RAX = NULL
    ret                             ; return to caller