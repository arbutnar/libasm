#include "libasm.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

void    test_ft_atoi_base() {
    printf("----------TEST FT_ATOI_BASE----------\n");
    printf("INVALID------------------------------\n");
    printf("str == NULL      |  return  -->  %d\n", ft_atoi_base(NULL, "0123456789"));
    printf("                 |  errno   -->  %d\n", errno);
    printf("                 -\n");
    errno = 0;
    printf("base == NULL     |  return  -->  %d\n", ft_atoi_base("1", NULL));
    printf("                 |  errno   -->  %d\n", errno);
    printf("                 -\n");
    errno = 0;
    printf("base len == 0    |  return  -->  %d\n", ft_atoi_base("10", ""));
    printf("                 |  errno   -->  %d\n", errno);
    printf("                 -\n");
    errno = 0;
    printf("base len == 1    |  return  -->  %d\n", ft_atoi_base("10", "1"));
    printf("                 |  errno   -->  %d\n", errno);
    printf("                 -\n");
    errno = 0;
    printf("base have dupes  |  return  -->  %d\n", ft_atoi_base("10", "010"));
    printf("                 |  errno   -->  %d\n", errno);
    printf("                 -\n");
    errno = 0;
    printf("base have + -    |  return  -->  %d\n", ft_atoi_base("10", "+012"));
    printf("                 |  errno   -->  %d\n", errno);
    printf("                 -\n");
    errno = 0;
    printf("base have + -    |  return  -->  %d\n", ft_atoi_base("  ---+--+1234ab567", "0123456789"));
    printf("                 |  errno   -->  %d\n", errno);
    errno = 0;
    printf("VALID--------------------------------\n");
}

void    test_ft_list_push_front(t_list **head, char **data_arr) {
    t_list  *tmp = NULL;
    char    *dup = NULL;

    printf("-----TEST FT_LIST_PUSH_FRONT-----\n");
    for (int i = 0; data_arr[i]; i++) {
        dup = strdup(data_arr[i]);  // safely allocate memory
        ft_list_push_front(head, dup);
    }
    tmp = *head;
    for (int i = 0; tmp; i++) {
        printf("list[%d]'s data = %s\n", i, (char *) tmp->data);
        tmp = tmp->next;
    }
    printf("errno   -->  %d\n", errno);
    errno = 0;
}

void    test_ft_list_size(t_list  *head) {
    printf("--------TEST FT_LIST_SIZE--------\n");
    printf("return  -->  %d\n", ft_list_size(head));
    printf("errno   -->  %d\n", errno);
    errno = 0;
}

// void    test_ft_list_sort(t_list **head) {
//     printf("--------TEST FT_LIST_SORT--------\n");
//     t_list *half = ft_list_sort(head, ft_strcmp);
//     printf("head's data = %s\n", (char *) (*head)->data);
//     printf("half's data = %s\n", (char *) half->data);
// }

int tmp_strcmp(char *s1, char *s2) {
    printf("ciaoo\n");
    printf("s1 = %s\n", s1);
    printf("s2 = %s\n", s2);

    return 1;
}

void    test_ft_list_remove_if(t_list  **head) {
    t_list  *tmp = NULL;
    printf("-----TEST FT_LIST_REMOVE_IF------\n");
    ft_list_remove_if(head, "1", ft_strcmp, free);

    tmp = *head;
    for (int i = 0; tmp; i++) {
        printf("list[%d]'s data = %s\n", i, (char *) tmp->data);
        tmp = tmp->next;
    }
    printf("errno   -->  %d\n", errno);
    errno = 0;
}

int main() {
    t_list  *head = NULL;
    char    *data_arr[] = { "1", "2", "1", "3", "1", NULL };

    test_ft_atoi_base();
    test_ft_list_push_front(&head, data_arr);
    test_ft_list_size(head);
    // test_ft_list_sort(&head);
    test_ft_list_remove_if(&head);

    return 0;
}