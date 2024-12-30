# Compiler
ASM 		:= nasm
ASM_FLAG	:= -f elf64
CC			:= gcc
C_FLAG		:= -Wall -Wextra -Werror
# Mandatory archived library
ARC			:= src/libasm.a
ARC_SRC		:= src/ft_write.asm
ARC_OBJ		:= $(ARC_SRC:.asm=.o)
# Test library
TEST		:= test
TEST_SRC	:= main.c
TEST_UTIL	:= utils/util.txt

$(ARC):		$(ARC_OBJ)
			ar rcs $@ $^

$(ARC_OBJ):	$(ARC_SRC)
			$(ASM) $(ASM_FLAG) -o $@ $^

all:		$(ARC)

$(TEST):	main.o $(ARC)
			$(CC) $^ -o $@

main.o:		main.c src/libasm.h
			$(CC) -c $(TEST_SRC) $(C_FLAG)

clean:
			rm -f $(ARC_OBJ)

fclean:		clean
			rm -f $(ARC) $(TEST) $(TEST_UTIL) main.o

re:			fclean all

.PHONY:		all clean fclean re
