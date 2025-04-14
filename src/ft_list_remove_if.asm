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
; RBX = curr
ft_list_remove_if:
    test rdi, rdi           ; check if **begin_list == NULL
    jz .set_errno_efault
    test rdx, rdx           ; check if *cmp == NULL
    jz .set_errno_efault

    mov rbx, [rdi]          ; RBX = *begin_list
.loop:
    test rbx, rbx           ; check if RBX == NULL
    jz .return
    push r13
    push rdi
    push rsi
    push rdx
    push rcx
    mov rdi, [rbx]          ; RDI = RBX->data
    call rdx                ; RAX = cmp(RBX->data, data_ref)
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    pop r13

    test rax, rax           ; check if RAX is zero
    jnz .move_pointer
    mov r12, rbx
    push rdi
    push rsi
    push rdx
    push rcx
    mov rdi, rbx
    call free wrt ..plt
    pop rcx
    pop rdx
    pop rsi
    pop rdi

    mov rbx, r12
    cmp rbx, [rdi]          ; RBX == *begin_list
    je .update_begin_list
    jmp .update_in_list
.update_begin_list:
    mov [rdi], rbx
    jmp .loop
.update_in_list:
    mov r13, rbx
    jmp .loop
.move_pointer:
    mov r13, rbx            ; R13 = RBX (current node)
    mov rbx, [rbx + 8]      ; RBX = RBX->next
    ret
    jmp .loop
.set_errno_efault:
    mov rax, 14                     ; error code (EFAULT)
    push rax                        ; save error code
    call __errno_location wrt ..plt ; get address of the `errno` variable
    pop qword [rax]                 ; store error code in errno
    mov rax, -1
.return:
    ret