default rel

section .data
    is_begin DB 0

section .text
global ft_list_remove_if
extern __errno_location, free

; void    ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
; RDI = begin_list
; RSI = data_ref (data to compare)
; RDX = cmp (pointer to function that compares)
; RCX = free_fct (pointer to function that frees list element)
; RBX = tmp
; R12 = prev
; R13 = curr
ft_list_remove_if:
    test rdi, rdi           ; if **begin_list == NULL
    jz .set_errno_efault
    test rdx, rdx           ; if cmp == NULL
    jz .set_errno_efault

    mov r13, [rdi]          ; curr = *begin_list
.loop:
    test r13, r13           ; if curr == NULL
    jz .return
    push rdi
    push rsi
    push rdx
    push rcx
    mov rdi, [r13]          ; RDI = curr->data
    call rdx                ; RAX = cmp(curr->data, data_ref)
    pop rcx
    pop rdx
    pop rsi
    pop rdi

    test rax, rax           ; if RAX is zero
    jnz .move_pointers
    mov rbx, [r13 + 8]
    test rcx, rcx           ; if free_fct == NULL
    jz .erase_element
.erase_data:
    push rdi
    push rsi
    push rdx
    push rcx
    mov rdi, [r13]
    call rcx
    pop rcx
    pop rdx
    pop rsi
    pop rdi
.erase_element:
    push rdi
    push rsi
    push rdx
    push rcx
    mov rdi, r13
    call free wrt ..plt
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    cmp r13, [rdi]
    je .move_begin_list
    mov r13, rbx
    mov [r12 + 8], r13
    jmp .loop
.move_begin_list:
    mov r13, rbx
    mov [rdi], r13
    jmp .loop
.move_pointers:
    mov r12, r13            ; prev = curr
    mov r13, [r13 + 8]      ; R13 = R13->next
    jmp .loop
.set_errno_efault:
    mov rax, 14                     ; error code (EFAULT)
    push rax                        ; save error code
    call __errno_location wrt ..plt ; get address of the `errno` variable
    pop qword [rax]                 ; store error code in errno
    mov rax, -1
.return:
    ret