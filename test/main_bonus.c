#include "libasm.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

// void    test_ft_atoi_base() {
//     char    *str = "   -10";
//     char    *base = "0123456789abcdef";

//     printf("\n-------TEST FT_ATOI_BASE---------\n");
//     printf("return  -->  %d\n", ft_atoi_base(str, base));
//     printf("errno   -->  %d\n", errno);
//     errno = 0;
// }

void    test_ft_list_push_front(t_list **head) {
    printf("\n-----TEST FT_LIST_PUSH_FRONT-----\n");
    ft_list_push_front(head, "1");
    ft_list_push_front(head, "2");
    ft_list_push_front(head, "1");
    ft_list_push_front(head, "4");
    ft_list_push_front(head, "4");
    
    t_list  *tmp = *head;
    for (int i = 0; tmp; i++) {
        printf("list[%d]'s data = %s\n", i, (char *) tmp->data);
        tmp = tmp->next;
    }
}

void    test_ft_list_size(t_list  *head) {
    printf("\n--------TEST FT_LIST_SIZE--------\n");
    printf("%d\n", ft_list_size(head));
}

// void    test_ft_list_sort(t_list **head) {
//     printf("\n--------TEST FT_LIST_SORT--------\n");
//     t_list *half = ft_list_sort(head, ft_strcmp);
//     printf("head's data = %s\n", (char *) (*head)->data);
//     printf("half's data = %s\n", (char *) half->data);
// }

void    test_ft_list_remove_if(t_list  **head) {
    printf("\n-----TEST FT_LIST_REMOVE_IF------\n");
    printf("%d\n", ft_list_remove_if(head, "1", ft_strcmp, free));

    t_list  *tmp = *head;
    for (int i = 0; tmp; i++) {
        printf("list[%d]'s data = %s\n", i, (char *) tmp->data);
        tmp = tmp->next;
    }
    printf("errno   -->  %d\n", errno);
    errno = 0;
}

int main() {
    t_list  *head = NULL;
    
    //test_ft_atoi_base();
    test_ft_list_push_front(&head);
    // test_ft_list_size(head);
    // test_ft_list_sort(&head);
    test_ft_list_remove_if(&head);

    return 0;
}