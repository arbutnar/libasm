; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_list_size.asm                                   :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: arbutnar <arbutnar@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2025/03/29 10:09:44 by arbutnar          #+#    #+#             ;
;   Updated: 2025/03/29 10:09:44 by arbutnar         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

section .text
global ft_list_size
extern __errno_location

; int ft_list_size(t_list *begin_list)
; RDI = begin_list (head pointer)
; RAX = size of list (return)
ft_list_size:
    test rdi, rdi
    jz .set_errno_efault

    xor rax, rax
.loop:
    inc     rax                 ; increment size
    mov     rdi, [rdi + 8]      ; move to next node (rdi = rdi->next)
    test    rdi, rdi
    jnz     .loop               ; if not null, continue
    ret
.set_errno_efault:
    mov rax, 14                     ; error code (EFAULT)
    push rax                        ; save error code
    call __errno_location wrt ..plt ; get address of the `errno` variable
    pop qword [rax]                 ; store error code in errno
    mov rax, -1
.return:
    ret