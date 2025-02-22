#ifndef LIB_BONUS_H
#define LIB_BONUS_H

#include <sys/types.h>
#include <stddef.h>

typedef struct s_list
{
    void            *data;
    struct s_list   *next;
} t_list;

int     ft_atoi_base(char *str, int base);
void    ft_list_push_front(t_list **begin_list, void *data);
int     ft_list_size(t_list *begin_list);
void    ft_list_sort(t_list **begin_list, int (*cmp)()); // (*cmp)(list_ptr->data, list_other_ptr->data);
void    ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
// (*cmp)(list_ptr->data, data_ref);
// (*free_fct)(list_ptr->data);

#endif /*LIB_BONUS_H*/