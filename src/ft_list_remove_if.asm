default rel

section .data
    is_begin DB 0

section .text
global ft_list_remove_if
extern __errno_location, free

call_with_alignment:
    push rbp
    mov rbp, rsp
    and rsp, -16
    call rdx
    mov rsp, rbp
    pop rbp
    ret

remove_if:
    mov r14, [r13 + 8]
    mov rdi, [r13]
    mov rsi, [rbp - 16]
    mov rdx, [rbp - 24]
    call call_with_alignment
    test rax, rax
    jnz .return
    mov rdx, [rbp - 32]
    test rdx, rdx
    jz .free_node
    mov rdi, [r13]
    call call_with_alignment
.free_node:
    mov rdi, r13
    call free wrt ..plt
    xor rax, rax
.return:
    ret

; void    ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
; RDI = begin_list
; RSI = data_ref (data to compare)
; RDX = cmp (pointer to function that compares)
; RCX = free_fct (pointer to function that frees list element)
; RBX = tmp
; R12 = prev
; R13 = curr
ft_list_remove_if:
    push r12
    push r13
    push r14
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov [rbp - 32], rcx

    test rdi, rdi
    jz .set_errno_efault
    test rsi, rsi
    jz .set_errno_efault
    test rdx, rdx
    jz .set_errno_efault
    mov r12, [rdi]
    test r12, r12
    jz .return
.loop:
    mov r13, [r12 + 8]
    test r13, r13
    jz .head
    call remove_if
    test rax, rax
    jz .remove
    mov r12, r13
    jmp .loop
.remove:
    mov [r12 + 8], r14
    jmp .loop
.head:
    mov r12, [rbp - 8]
    mov r13, [r12]
    call remove_if
    test rax, rax
    jnz .return
    mov [r12], r14
    jmp .return
.set_errno_efault:
    mov rax, 14                     ; error code (EFAULT)
    push rax                        ; save error code
    call __errno_location wrt ..plt ; get address of the `errno` variable
    pop qword [rax]                 ; store error code in errno
    mov rax, -1
.return:
    mov rsp, rbp
    pop rbp
    pop r14
    pop r13
    pop r12
    ret