#include "libasm.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

void ft_print_list(t_list *head) {
    t_list *tmp = head;

    for (int i = 0; tmp; i++) {
       printf("list[%d]'s data = %s\n", i, (char *)tmp->data);
       tmp = tmp->next;
    }
}

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
    printf("VALID--------------------------------\n");
    printf("base 10          |  return  -->  %d\n", ft_atoi_base("  ---+--+1234ab567", "0123456789"));
    printf("                 |  errno   -->  %d\n", errno);
    errno = 0;
    printf("base 10          |  return  -->  %d\n", ft_atoi_base("1234ab567", "0123456789abcdef"));
    printf("                 |  errno   -->  %d\n", errno);
    errno = 0;
}

void    test_ft_list_push_front(t_list **head, char **data_arr) {
    char    *dup = NULL;

    printf("-----TEST FT_LIST_PUSH_FRONT-----\n");
    for (int i = 0; data_arr[i]; i++) {
        dup = strdup(data_arr[i]);
        ft_list_push_front(head, dup);
    }
    ft_print_list(*head);
    printf("errno   -->  %d\n", errno);
    errno = 0;
}

void    test_ft_list_size(t_list  *head) {
    printf("--------TEST FT_LIST_SIZE--------\n");
    printf("return  -->  %d\n", ft_list_size(head));
    printf("errno   -->  %d\n", errno);
    errno = 0;
}

int tmp_strcmp(char *s1, char *s2) {
    return (*s1 - *s2);
}

void    test_ft_list_sort(t_list **head) {
    printf("--------TEST FT_LIST_SORT--------\n");
    ft_list_sort(head, tmp_strcmp);
    ft_print_list(*head);
    printf("errno   -->  %d\n", errno);
    errno = 0;
}

void    test_ft_list_remove_if(t_list  **head) {
    t_list  *tmp = NULL;
    printf("-----TEST FT_LIST_REMOVE_IF------\n");
    ft_list_remove_if(head, "1", tmp_strcmp, free);

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
    char    *char_arr[] = { "1", "2", "0", "3", "1", "9", "4", "7", "9", "6", NULL };

    test_ft_atoi_base();
    test_ft_list_push_front(&head, char_arr);
    test_ft_list_size(head);
    test_ft_list_sort(&head);
    test_ft_list_remove_if(&head);

    return 0;
}