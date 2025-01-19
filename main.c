#include "libasm.h"
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>

void    test_ft_strlen()
{
    /* buf == NULL --- Segmentation fault (core dumped) */
    char    *buf = "testing ft_strlen";

    printf("\n--------TEST FT_STRLEN-------\n");
    printf("strlen      |  return  -->  %ld\n", strlen(buf));
    printf("            -\n");
    printf("ft_strlen   |  return  -->  %ld\n", ft_strlen(buf));
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;
}

void    test_ft_strcpy()
{
    /* strcpy attributes recognized as nonull for gcc */
    /* dest == NULL || src == NULL --> Segmentation fault (core dumped) */
    /* dest_size < src_size *** stack smashing detected ***: terminated --> Aborted (core dumped) */
    int     dsize = 20;
    char    dest[dsize];
    char    ft_dest[dsize];
    char    *src = "testing ft_strcpy";

    printf("\n--------TEST FT_STRCPY-------\n");
    printf("strcpy      |  return  -->  %s\n", strcpy(dest, src));
    printf("            -\n");
    printf("ft_strcpy   |  return  -->  %s\n", ft_strcpy(ft_dest, src));
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;
}

void    test_ft_strcmp()
{
    char *s1 = "testing strcmp";
    char *s2 = "testing ft_strcmp";

    printf("\n--------TEST FT_STRCMP-------\n");
    printf("strcmp      |  return  -->  %d\n", strcmp(s1, s2));
    printf("            -\n");
    printf("ft_strcmp   |  return  -->  %d\n", ft_strcmp(s1, s2));
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;
}

void    test_ft_write()
{
    int     fd = 1;
    char    buf[] = "testing ft_write";
    size_t  count = sizeof(buf);
    ssize_t ret = 0;

    printf("\n--------TEST FT_WRITE--------\n");
    write(1, "write       |  output  -->  ", 28);
    ret = write(fd, buf, count);
    printf("\n");
    printf("            |  return  -->  %ld\n", ret);
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;

    printf("            -\n");
    write(1, "ft_write    |  output  -->  ", 28);
    ret = ft_write(fd, buf, count);
    printf("\n");
    printf("            |  return  -->  %ld\n", ret);
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;
}

void    test_ft_read()
{
    int     fd = 0;
    char    *buf = NULL;
    size_t  count = 0;

    printf("\n--------TEST FT_READ---------\n");
    printf("read        |  return  -->  %ld\n", read(fd, buf, count));
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;
    printf("            -\n");
    printf("ft_read     |  return  -->  %ld\n", ft_read(fd, buf, count));
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;
}

void    test_ft_strdup()
{
    /* strdup attributes recognized as nonull for gcc */
    /* dest == NULL --> Segmentation fault (core dumped) */
    char        *dest = NULL;
    char        *ft_dest = NULL;
    const char  *src = "";

    printf("\n--------TEST FT_STRDUP-------\n");
    printf("strdup      |  return  -->  %s\n", (dest = strdup(src)));
    printf("            -\n");
    printf("ft_strdup   |  return  -->  %s\n", (ft_dest = ft_strdup(src)));
    printf("            |  errno   -->  %d\n", errno);
    errno = 0;
}

int main()
{
    /*Mandatory*/
    test_ft_strlen();
    test_ft_strcpy();
    test_ft_strcmp();
    test_ft_write();
    test_ft_read();
    test_ft_strdup();

    /*Bonus*/


    return 0;
}