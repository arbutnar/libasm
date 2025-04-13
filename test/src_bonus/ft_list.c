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

t_list  *split_list(t_list *begin_list) {
    t_list *half = begin_list;
    t_list *end = begin_list;

    while (end && end->next && end->next->next) {
        half = half->next;
        end = end->next->next;
    }
    end = half->next;
    half->next = NULL;
    return (end);
}

t_list  *merge_lists(t_list *begin_list, t_list *half_list, int (*cmp)()) {
    t_list  *res;

    if (!begin_list) return (half_list);
    if (!half_list) return (begin_list);

    if (cmp(begin_list->data, half_list->data)) {
        res = half_list;
        res->next = merge_lists(begin_list, half_list->next, cmp);
    } else {
        res = begin_list;
        res->next = merge_lists(begin_list->next, half_list, cmp);
    }
    return (res);
}

// void    ft_list_sort(t_list **begin_list, int (*cmp)()) {
//     t_list  *half_list = split_list(*begin_list);

//     if ((*begin_list)->next) ft_list_sort(begin_list, cmp);
//     if (half_list->next) ft_list_sort(&half_list, cmp);

//     t_list  *tmp = merge_lists(*begin_list, half_list, cmp);
//     for (int i = 0; tmp; i++) {
//         printf("\nlist[%d]'s data = %s\n", i, (char *)tmp->data);
//         tmp = tmp->next;
//     }
// }

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

int main() {
    t_list  *head = NULL;
    t_list  *tmp = NULL;

    // 1 9 4 8 5 3 7 2 6
    ft_list_push_front(&head, "1");
    ft_list_push_front(&head, "2");
    ft_list_push_front(&head, "1");
    ft_list_push_front(&head, "3");
    ft_list_push_front(&head, "1");

    tmp = head;

    printf("Number of elements in list: %d\n", ft_list_size(head));
    for (int i = 0; tmp; i++) {
       printf("list[%d]'s data = %s\n", i, (char *)tmp->data);
       tmp = tmp->next;
    }
    printf("------------------\n");

    //ft_list_sort(&head, ft_strcmp);
    ft_list_remove_if(&head, NULL, ft_strcmp, free);
    for (int i = 0; head; i++) {
        printf("list[%d]'s data = %s\n", i, (char *) head->data);
        head = head->next;
    }
    return (0);
}