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

; int ft_list_size(t_list *begin_list)
; RDI = begin_list (head pointer)
; RAX = size of list (return)
ft_list_size:
    test rdi, rdi
    jz .return
    jmp .loop_through
.increment:
    inc rax
.loop_through:
    cmp rdi, 0
    je .return
    mov rdi, [rdi + 8]
    jmp .increment
.return:
    ret