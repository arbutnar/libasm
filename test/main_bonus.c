#include "libasm.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

void    test_ft_atoi_base() {
    struct {
        char    *str;
        char    *base;
        char    *description;
    } cases[] = {
        {NULL, "0123456789", "str == NULL"},
        {"1", NULL, "base == NULL"},
        {"10", "", "base len == 0"},
        {"10", "1", "base len == 1"},
        {"10", "010", "base have dupes"},
        {"10", "+012", "base have + -"},
        {"9", "012", "*str ∌ base"},
        {"4422", "0123456789", "base 10"},
        {"10", "0123456789abcdef", "base 16"},
        {"+-----+2000", "0123456789", "neg str"},
        {"       0011", "01", "spaces"},
    };

    printf("\33[0;32mTEST FT_ATOI_BASE\33[0m\n");
    for (unsigned int i = 0; i < (sizeof(cases)/sizeof(*cases)); i++) {
        printf("\33[0;33m[\"%s\", \"%s\"] %s:\n\33[0m", cases[i].str, cases[i].base, cases[i].description);
        printf("return  -->  %d\n", ft_atoi_base(cases[i].str, cases[i].base));
        printf("errno   -->  %d\n", errno);
        errno = 0;
    }
}

void ft_print_list(t_list *head) {
    t_list *tmp = head;

    for (int i = 0; tmp; i++) {
       printf("list[%d]'s data = %s\n", i, (char *)tmp->data);
       tmp = tmp->next;
    }
}

void ft_free_list(t_list *head) {
    t_list *tmp;

    while (head) {
        tmp = head->next;
        free(head->data);
        free(head);
        head = tmp;
    }
}

void    test_ft_list_push_front(t_list **head, char **data_arr) {
    char    *dup = NULL;

    printf("\33[0;32mTEST FT_LIST_PUSH_FRONT\33[0m\n");
    for (int i = 0; data_arr[i]; i++) {
        dup = strdup(data_arr[i]);
        ft_list_push_front(head, dup);
    }
    ft_print_list(*head);
}

void    test_ft_list_size(t_list  *head) {
    printf("\33[0;32mTEST FT_LIST_SIZE\33[0m\n");
    printf("return  -->  %d\n", ft_list_size(head));
}

int tmp_strcmp(char *s1, char *s2) {
    return (*s1 - *s2);
}

void    test_ft_list_sort(t_list **head) {
    printf("\33[0;32mTEST FT_LIST_SORT\33[0m\n");
    ft_list_sort(head, tmp_strcmp);
    ft_print_list(*head);
}

void    test_ft_list_remove_if(t_list  **head) {
    printf("\33[0;32mTEST FT_LIST_REMOVE_IF\33[0m\n");
    ft_list_remove_if(head, "1", tmp_strcmp, free);
    ft_print_list(*head);
}

int main() {
    t_list  *head = NULL;
    char    *char_arr[] = { "1", "2", "0", "3", "1", "9", "4", "7", "9", "6", NULL };

    test_ft_atoi_base();
    test_ft_list_push_front(&head, char_arr);
    test_ft_list_size(head);
    test_ft_list_sort(&head);
    test_ft_list_remove_if(&head);

    ft_free_list(head);

    return 0;
}