; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_list_sort.asm                                   :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: arbutnar <arbutnar@student.42.fr>          +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2025/03/29 10:09:44 by arbutnar          #+#    #+#             ;
;   Updated: 2025/03/29 10:09:44 by arbutnar         ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

default rel

section .data
    sorted DB 0

section .text
    global ft_list_sort
    extern __errno_location

call_with_alignment:
    push rbp
    mov rbp, rsp
    and rsp, -16
    call rdx
    mov rsp, rbp
    pop rbp
    ret

; void  ft_list_sort(t_list **begin_list, int (*cmp)())
; RDI = begin_list
; RSI = cmp (pointer to function that compares)
; R12 = prev
; R13 = curr
; R14 = next
ft_list_sort:
    push r12
    push r13
    push r14
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi

    test rdi, rdi
    jz .set_errno_efault
    mov rdi, [rdi]
    test rdi, rdi
    jz .set_errno_efault
    test rsi, rsi
    jz .set_errno_efault
.while_not_sorted:
    cmp byte [sorted], 1
    je .return
    mov byte [sorted], 1
    mov r12, 0
    mov r13, [rbp - 8]
    mov r13, [r13]
    mov r14, [r13 + 8]
.while_next:
    test r14, r14
    jz .while_not_sorted
    mov rdi, [r13]
    mov rsi, [r14]
    mov rdx, [rbp - 16]
    call call_with_alignment
    cmp eax, 1
    jl .move_forward
.swap:
    mov byte [sorted], 0
    mov r9, [r14 + 8]
    mov [r13 + 8], r9
    mov [r14 + 8], r13
    mov r13, r14
    test r12, r12
    jz .update_head
    mov [r12 + 8], r13
    jmp .move_forward
.update_head:
    mov r8, [rbp - 8]
    mov [r8], r13
.move_forward:
    mov r12, r13
    mov r13, [r13 + 8]
    mov r14, [r13 + 8]
    jmp .while_next
.set_errno_efault:
    call __errno_location wrt ..plt
    mov qword [rax], 14
.return:
    mov rsp, rbp
    pop rbp
    pop r14
    pop r13
    pop r12
    ret