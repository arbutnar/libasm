#include "libasm.h"
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>

char *test_cases[] = {
    "",
    "42",
    "This is a longer string.",
    "abc\0def",
    "こんにちは",
};
char *descriptions[] = {
    "Empty string",
    "Short string",
    "Longer string",
    "Embedded null",
    "Unicode string (UTF-8)"
};

void test_ft_strlen() {
    printf("\33[0;32mTEST FT_STRLEN\n\33[0m");
    for (unsigned int i = 0; i < (sizeof(test_cases)/sizeof(*test_cases)); i++) {
        char *str = test_cases[i];
        printf("\33[0;33m[\"%s\"] %s:\n\33[0m", test_cases[i], descriptions[i]);
        printf("strlen      |  return  --> %ld\n", strlen(str));
        printf("ft_strlen   |  return  --> %ld\n", ft_strlen(str));
    }
}

void    test_ft_strcpy() {
    printf("\n\33[0;32mTEST FT_STRCPY\n\33[0m");
    for (unsigned int i = 0; i < (sizeof(test_cases)/sizeof(*test_cases)); i++) {
        char dest[strlen(test_cases[i])];
        char *src = test_cases[i];
        printf("\33[0;33m[\"%s\"] %s:\n\33[0m", test_cases[i], descriptions[i]);
        char *ret = strcpy(dest, src);
        printf("strcpy      |  dest    -->  %s\n", dest);
        printf("            |  return  -->  %s\n", ret);
        ret = ft_strcpy(dest, src);
        printf("ft_strcpy   |  dest    -->  %s\n", dest);
        printf("            |  return  -->  %s\n", ret);
    }
}

void    test_ft_strcmp() {
    printf("\n\33[0;32mTEST FT_STRCMP\n\33[0m");
    struct {
        char    *s1;
        char    *s2;
        char    *description;
    } cases[] = {
        {"", "", "Empty vs Empty"},
        {"abc", "abc", "Equal strings"},
        {"abcde", "abcd", "More vs Less"},
        {"abc", "xyz", "Completely different"},
        {"", "a", "Empty vs non-empty"},
    };

    for (unsigned int i = 0; i < (sizeof(cases)/sizeof(*cases)); i++) {
        printf("\33[0;33m[\"%s\", \"%s\"] %s:\n\33[0m", cases[i].s1, cases[i].s2, cases[i].description);
        printf("strcmp      |  return  --> %d\n", strcmp(cases[i].s1, cases[i].s2));
        printf("ft_strcmp   |  return  --> %d\n", ft_strcmp(cases[i].s1, cases[i].s2));
    }
}

void    test_ft_write() {
    char    input[] = "testing my write/ft_write using pipe for reading output";
    int     input_len = strlen(input);
    int     fds[2];
    pipe(fds);

    printf("\n\33[0;32mTEST FT_WRITE\n\33[0m");
    // fd = -1; count = 10;
    printf("\33[0;33m[-1] Invalid fd:\n\33[0m");
    printf("write       |  return  -->  %ld\n", write(-1, input, 10));
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;
    printf("ft_write    |  return  -->  %ld\n", ft_write(-1, input, 10));
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;

    // fd = 1; count = 0;
    printf("\33[0;33m[1] Zero-length write:\n\33[0m");
    printf("write       |  return  -->  %ld\n", write(1, input, 0));
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;
    printf("ft_write    |  return  -->  %ld\n", ft_write(1, input, 0));
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;

    // fd = fds[1]; count = input_len;
    printf("\33[0;33m[fds[1]] Valid:\n\33[0m");
    char output[input_len + 1];
    memset(output, 0, input_len + 1);

    printf("write       |  return  -->  %ld\n", write(fds[1], input, input_len));
    read(fds[0], output, input_len);
    printf("            |  wrote   -->  %s\n", output);
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;
    printf("ft_write    |  return  -->  %ld\n", ft_write(fds[1], input, input_len));
    read(fds[0], output, input_len);
    printf("            |  wrote   -->  %s\n", output);
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;
}

void    test_ft_read() {
    char    input[] = "testing my read/ft_read using tmpfile for writing input";
    int     input_len = strlen(input);
    FILE    *ft = tmpfile();
    if (!ft) {
        perror("tmpfile failed");
        return;
    }
    int fd = fileno(ft);
    write(fd, input, input_len);

    printf("\n\33[0;32mTEST FT_READ\n\33[0m");
    // fd = -1; count = 10;
    printf("\33[0;33m[-1] Invalid fd:\n\33[0m");
    printf("read        |  return  -->  %ld\n", read(-1, input, 10));
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;
    printf("ft_read     |  return  -->  %ld\n", ft_read(-1, input, 10));
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;

    // fd = 0; count = 0;
    printf("\33[0;33m[0] Zero-length read:\n\33[0m");
    printf("read        |  return  -->  %ld\n", read(0, input, 0));
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;
    printf("ft_read     |  return  -->  %ld\n", ft_read(0, input, 0));
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;

    // fd = fd; count = input_len;
    printf("\33[0;33m[fd] Valid:\n\33[0m");
    char output[input_len + 1];
    memset(output, 0, input_len + 1);
    lseek(fd, 0, SEEK_SET);

    printf("read        |  return  -->  %ld\n", read(fd, output, input_len));
    printf("            |  read    -->  %s\n", output);
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;
    lseek(fd, 0, SEEK_SET);
    memset(output, 0, input_len + 1);
    printf("ft_read     |  return  -->  %ld\n", ft_read(fd, output, input_len));
    printf("            |  read    -->  %s\n", output);
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;
}

void    test_ft_strdup() {
    printf("\n\33[0;32mTEST FT_STRDUP\n\33[0m");
    for (unsigned int i = 0; i < sizeof(test_cases)/sizeof(*test_cases); i++) {
        char *str = test_cases[i];
        printf("\33[0;33m[\"%s\"] %s:\n\33[0m", test_cases[i], descriptions[i]);
        char *ret = strdup(str);
        printf("strdup      |  return  -->  %s\n", ret);
        ret = ft_strdup(str);
        printf("ft_strdup   |  return  -->  %s\n", ret);
    }
}

int main() {
    test_ft_strlen();
    test_ft_strcpy();
    test_ft_strcmp();
    test_ft_write();
    test_ft_read();
    test_ft_strdup();
    return 0;
}