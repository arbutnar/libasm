// Write a function that converts the string argument str (base N <= 16)
// to an integer (base 10) and returns it.

// The characters recognized in the input are: 0123456789abcdef
// Those are, of course, to be trimmed according to the requested base. For
// example, base 4 recognizes "0123" and base 16 recognizes "0123456789abcdef".
// Uppercase letters must also be recognized: "12fdb3" is the same as "12FDB3".

// Minus signs ('-') are interpreted only if they are the first character of the
// string.

// Your function must be declared as follows:
// int  ft_atoi_base(const char *str, int str_base);

#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int in_base(char c, int base_len) {
    char    *lbase = "0123456789abcdef";
    char    *ubase = "0123456789ABCDEF";

    for (int i = 0; i < base_len; i++)
        if (c == lbase[i] || c == ubase[i])
            return (1);
    return (0);
}

int ft_atoi_base(const char *str, int str_base) {
    int sign = 1, res = 0;

    if (!str || str_base < 2 || str_base > 16)
        return (0);

    if (*str == '-') {
        sign = -1;
        str++;
    }
    for (; *str == '+'; str++);
    for (; *str; str++) {
        if (*str == '\t' || *str == '\n' || *str == '\v' ||
                *str == '\f' || *str == '\r' || *str == ' ')
            continue;
        if (!in_base(*str, str_base))
            return (0);
        res *= str_base;
        if (*str >= '0' && *str <= '9')
            res += (*str - '0');
        else if (*str >= 'A' && *str <= 'F')
            res += (*str - 'A' + 10);
        else if (*str >= 'a' && *str <= 'f')
            res += (*str - 'a' + 10);
    }
    return (res * sign);
}

int main() {
    int res = ft_atoi_base("10001", 2);

    printf("%d\n", res);
    return (0);
}
