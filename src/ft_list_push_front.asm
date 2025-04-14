; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_list_push_front.asm                             :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: arbutnar <arbutnar@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2025/03/29 10:09:44 by arbutnar          #+#    #+#             ;
;   Updated: 2025/03/29 10:09:44 by arbutnar         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

section .text
    global ft_list_push_front
    extern __errno_location, malloc

; void ft_list_push_front(t_list **begin_list, void *data)
; RDI = begin_list (pointer to head pointer)
; RSI = data (void pointer to store in node)
ft_list_push_front:
    test rdi, rdi
    jz .set_errno_efault

    push rdi
    push rsi
    mov rdi, 16                 ; sizeof(t_list) 8 byte ptr + 8 byte ptr
    call malloc wrt ..plt       ; malloc(sizeof(t_list))
    pop rsi
    pop rdi
    test rax, rax               ; malloc == NULL
    jz .return
    mov [rax], rsi              ; rax->data = data (using saved value)
    mov rbx, [rdi]              ; rbx = *begin_list
    mov [rax + 8], rbx
.update_head:
    mov [rdi], rax
    jmp .return
.set_errno_efault:
    mov rax, 14                     ; error code (EFAULT)
    push rax                        ; save error code
    call __errno_location wrt ..plt ; get address of the `errno` variable
    pop qword [rax]                 ; store error code in errno
    mov rax, -1
.return:
    ret