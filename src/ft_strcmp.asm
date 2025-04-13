; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_strcmp.asm                                      :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: arbutnar <arbutnar@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2025/03/29 10:09:44 by arbutnar          #+#    #+#             ;
;   Updated: 2025/03/29 10:09:44 by arbutnar         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

section .text
    global ft_strcmp
    extern  __errno_location

; int strcmp(const char *s1, const char *s2)
; RDI = s1 (pointer first string to compare)
; RSI = s2 (ppointer second string to compare)
; RAX = return (0 if s1 == s2, or ASCII value difference between the first mismatching characters, or -1 if error occured)
ft_strcmp:
    test rdi, rdi           ; check if RDI is NULL
    jz .set_errno_efault    ; if NULL, set EFAULT error
    test rsi, rsi           ; check if RSI is NULL
    jz .set_errno_efault    ; if NULL, set EFAULT error
    xor rcx, rcx            ; initialize counter to 0
    jmp .loop_through
.increment:
    inc rcx                     ; increment counter
.loop_through:
    mov al, byte [rdi + rcx]
    mov bl, byte [rsi + rcx]
    cmp al, bl
    jne .return_non_eq
    cmp al, 0
    jne .increment
.return_eq:
    xor rax, rax            ; RAX = 0
    ret                     ; return to caller
.return_non_eq:
    movzx rax, al           ; zero-extend AL to RAX
    movzx rbx, bl           ; zero-extend BL to RBX
    sub rax, rbx            ; calculate ASCII value difference
    ret                     ; return to caller
.set_errno_efault:
    mov rax, 14                     ; error code (EFAULT)
    push rax                        ; save error code
    call __errno_location wrt ..plt ; get address of the `errno` variable
    pop qword [rax]                 ; set error code as errno address value
    mov rax, -1
    ret                             ; return to caller