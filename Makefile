# Mandatory archived library
NAME		=	libasm.a
# SRC			=	src/ft_errno.asm
SRC			=	src/ft_write.asm	\
				src/ft_read.asm		\
				src/ft_strlen.asm	\
				src/ft_strcpy.asm	\
				src/ft_strcmp.asm	\
				src/ft_strdup.asm
OBJ			=	$(SRC:.asm=.o)

# Bonus archived library
BONUS		=	libasm_bonus.a
BONUS_SRC	=	src_bonus/ft_atoi_base.asm			\
				src_bonus/ft_list_push_front.asm	\
				src_bonus/ft_list_size.asm			\
				src_bonus/ft_list_sort.asm			\
				src_bonus/ft_list_remove_if.asm
BONUS_OBJ	=	$(BONUS_SRC:.asm=.o)

# Test library
TEST		=	test

# Compiler
ASM 		=	nasm
ASM_FLAG	=	-f elf64
CC			=	gcc
C_FLAG		=	-Wall -Wextra -Werror -no-pie

$(NAME):	$(SRC)
			@for file in $(SRC); do \
				obj=$${file%.asm}.o; \
				$(ASM) $(ASM_FLAG) -o $$obj $$file; \
			done
			ar rcs $@ $(OBJ)
			rm -f $(OBJ)

$(TEST):	main.c $(NAME) libasm.h
			$(CC) $^ -o $@ $(C_FLAG)
			rm -f main.o

all:		$(NAME)

clean:
			rm -f $(OBJ)

fclean:		clean
			rm -f $(NAME) $(TEST) main.o

re:			fclean all

.PHONY:		all clean fclean re
