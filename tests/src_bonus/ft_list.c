#include "../libasm_bonus.h"
#include <stdio.h>
#include <stdlib.h>

void    ft_list_push_front(t_list **begin_list, void *data) {
    t_list  *node = NULL;
    
    if (!(node = malloc(sizeof(t_list))))
    return ;
    node->data = data;
    if (*begin_list)
    node->next = *begin_list;
    *begin_list = node;
}

int ft_list_size(t_list *begin_list) {
    int i;

    for (i = 0; begin_list; i++)
        begin_list = begin_list->next;
    return (i);
}

void    ft_list_sort(t_list **begin_list, int (*cmp)()) {
    t_list  *ptr = NULL, *other_ptr = NULL;
}

int main() {
    t_list  *head = NULL;

    ft_list_push_front(&head, "element_1");
    ft_list_push_front(&head, "element_2");
    ft_list_push_front(&head, "element_3");
    ft_list_push_front(&head, "element_4");

    printf("Number of elements in list: %d\n", ft_list_size(head));
    
    for (int i = 0; head; i++) {
        printf("list[%d]'s data = %s\n", i, (char *) head->data);
        head = head->next;
    }
    return (0);
}