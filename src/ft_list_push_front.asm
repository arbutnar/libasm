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
    extern malloc

; void ft_list_push_front(t_list **begin_list, void *data)
; RDI = begin_list (pointer to head pointer)
; RSI = data (void pointer to store in node)
ft_list_push_front:
    test rdi, rdi
    jz .return
    mov r12, rsi                ; Save data pointer in rbx (callee-saved)
    mov r10, rdi                ; save **begin_list in r10
    mov rdi, 16                 ; sizeof(t_list) 8 byte ptr + 8 byte ptr
    call malloc wrt ..plt       ; malloc(sizeof(t_list))
    test rax, rax               ; malloc == NULL
    jz .return
    mov [rax], r12              ; rax->data = data (using saved value)
    mov rcx, [r10]              ; rcx = *begin_list
    test rcx, rcx               ; if (rcx == NULL)
    jz .null_next
    mov [rax + 8], rcx
    jmp .update_head

.null_next:
    mov qword [rax + 8], 0      ; rax->next = NULL

.update_head:
    mov [r10], rax

.return:
    ret