#include "../libasm.h"
#include <stdio.h>
#include <stdlib.h>

void    ft_list_push_front(t_list **begin_list, void *data) {
    t_list  *node = NULL;
    
    if (!(node = malloc(sizeof(t_list))))
        return ;
    node->data = data;
    node->next = (*begin_list) ? *begin_list : NULL;
    *begin_list = node;
}

int ft_list_size(t_list *begin_list) {
    int i;

    for (i = 0; begin_list; i++)
        begin_list = begin_list->next;
    return (i);
}

void    ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *)) {
    t_list  *temp = NULL;
    t_list  *prev = NULL;
    t_list  *curr = *begin_list;
    int     is_begin;

    while (curr) {
        if (curr->data != data_ref) {
            prev = curr;
            curr = curr->next;
            continue;
        }
        is_begin = (curr == *begin_list);
        temp = curr->next;
        free_fct(curr);
        if (is_begin)
            *begin_list = curr = temp;
        else
            prev->next = curr = temp;
    }
}

void ft_print_list(t_list *head) {
    t_list *tmp = head;

    for (int i = 0; tmp; i++) {
       printf("list[%d]'s data = %s\n", i, (char *)tmp->data);
       tmp = tmp->next;
    }
}

void    ft_list_sort(t_list **begin_list, int (*cmp)()) {
    t_list  *prev;
    t_list  *curr;
    t_list  *next;
    int     sorted = 0;

    while (!sorted) {
        sorted = 1;
        prev = NULL;
        curr = *begin_list;
        next = curr->next;
        while (next) {
            if (cmp(curr->data, next->data) > 0) {
                sorted = 0;
                curr->next = next->next;
                next->next = curr;
                curr = next;
                if (prev)
                    prev->next = curr;
                else
                    *begin_list = curr;
            }
            prev = curr;
            curr = curr->next;
            next = curr->next;
        }
    }
}

int main() {
    t_list  *head = NULL;
    t_list  *tmp = NULL;

    // 1 9 4 8 5 3 7 2 6
    ft_list_push_front(&head, "1");
    ft_list_push_front(&head, "2");
    ft_list_push_front(&head, "0");
    ft_list_push_front(&head, "3");
    ft_list_push_front(&head, "1");
    ft_list_push_front(&head, "9");
    ft_list_push_front(&head, "4");
    ft_list_push_front(&head, "7");
    ft_list_push_front(&head, "0");
    ft_list_push_front(&head, "8");

    tmp = head;

    printf("Number of elements in list: %d\n", ft_list_size(head));
    for (int i = 0; tmp; i++) {
       printf("list[%d]'s data = %s\n", i, (char *)tmp->data);
       tmp = tmp->next;
    }
    printf("------------------\n");

    ft_list_sort(&head, ft_strcmp);
    // ft_list_remove_if(&head, NULL, ft_strcmp, free);
    for (int i = 0; head; i++) {
        printf("list[%d]'s data = %s\n", i, (char *) head->data);
        head = head->next;
    }
    return (0);
}