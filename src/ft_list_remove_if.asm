default rel

section .data
    is_begin DB 0

section .text
global ft_list_remove_if
extern __errno_location, _free

; void    ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
; RDI = begin_list
; RSI = data_ref (data to compare)
; RDX = cmp (pointer to function that compares)
; RCX = free_fct (pointer to function that frees list element)
ft_list_remove_if:
    test rdi, rdi
    jz .set_errno_efault
    test rdx, rdx
    jz .set_errno_efault

    mov rbx, [rdi]                  ; RBX = *begin_list
.loop:
    test rbx, rbx
    jz .return
    push rdi
    mov rdi, [rbx]
    call rdx                        ; cmp(RBX->data, data_ref)
    pop rdi
    test rax, rax
    jz .update_elements
    mov r12, rbx
    mov rbx, [rbx + 8]
    jmp .loop
.update_elements:
    test rbx, [rdi]
    jne .erase_element
    mov [is_begin], byte 1
.erase_element:
    mov r13, [rbx + 8]
    push rdi
    mov rdi, rbx
    call _free
    pop rdi
    cmp [is_begin], byte 1
    je .update_begin_list
    jmp .update_inside_list
.update_begin_list:
    mov [rdi], r13
    mov rbx, r13
    jmp .loop
.update_inside_list:
    mov [r12 + 8], r13
    mov rbx, r13
    jmp .loop
.set_errno_efault:
    mov rax, 14                     ; error code (EFAULT)
    push rax                        ; save error code
    call __errno_location wrt ..plt ; get address of the `errno` variable
    pop qword [rax]                 ; store error code in errno
    mov rax, -1
.return:
    ret