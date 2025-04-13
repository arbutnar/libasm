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

default rel     ; address type for memory operands to be RIP-relative instead of absolute addressing

section .bss
    pp_begin_list:   resb  8
    half_list:       resb  8

section .text
    global ft_list_sort
    extern malloc

split_list:
    mov rdx, rdi
    mov rax, rdi
    jmp .loop_through
.reassign:
    mov rdx, [rdx + 8]
    mov rax, rbx
.loop_through:
    cmp qword rax, 0
    jz .return
    mov rbx, [rax + 8]  ; Load the value from memory into rbx
    cmp qword rbx, 0
    jz .return
    mov rbx, [rbx + 8]
    cmp qword rbx, 0
    jz .return
    jmp .reassign
.return:
    mov rax, [rdx + 8]
    mov qword [rdx + 8], 0
    ret

; void  ft_list_sort(t_list **begin_list, int (*cmp)())
; RDI = begin_list (pointer to head pointer)
; RSI = cmp (pointer to compare function)
ft_list_sort:
    cmp qword rdi, 0
    jz .abort
    push rdi
    mov r13, [rdi]
    mov rdi, r13
    call split_list
    mov [half_list], rax
    pop rdi
    cmp qword [r13 + 8], 0
    jne ft_list_sort
    mov rdi, [half_list]
    cmp qword [rdi + 8], 0
    jne ft_list_sort
.abort:
    xor rax, rax            ; RAX = 0
    ret                     ; return to caller