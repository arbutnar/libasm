#include "libasm_bonus.h"
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>

void    test_ft_atoi_base()
{
    char    *str = "10001";
    int     base = 2;

    printf("\n--------TEST FT_ATOI_BASE--------\n");
    printf("ft_atoi_base    |  return  -->  %d\n", ft_atoi_base(str, base));
}

int main()
{
    test_ft_atoi_base();
    return 0;
}