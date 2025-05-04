CC	= gcc
FLG	= -Wall -Wextra -Werror

MAND_TARGET	=	mandatory
MAND_ARC	=	libasm.a
MAND_SRC	=	src/ft_write.asm \
				src/ft_read.asm \
				src/ft_strlen.asm \
				src/ft_strcpy.asm \
				src/ft_strcmp.asm \
				src/ft_strdup.asm
MAND_OBJ	=	$(MAND_SRC:.asm=.o)

BONUS_TARGET	=	bonus
BONUS_ARC		=	libasm_bonus.a
BONUS_SRC		=	src/ft_atoi_base.asm \
					src/ft_list_push_front.asm \
					src/ft_list_size.asm \
					src/ft_list_sort.asm \
					src/ft_list_remove_if.asm
BONUS_OBJ		=	$(BONUS_SRC:.asm=.o)

TEST_TARGET	=	test
TEST_DIR	=	test

all:	$(MAND_TARGET) $(BONUS_TARGET)

# Compile assembly files to create object files
%.o: %.asm
	@echo "Assembling $<"
	@nasm -f elf64 -o $@ $<

# Create mandatory library by archiving object files
$(MAND_TARGET): $(MAND_OBJ)
	@echo "Creating $(MAND_ARC)"
	@ar rcs $(MAND_ARC) $^

# Create bonus library by archiving object files
$(BONUS_TARGET): $(BONUS_OBJ)
	@echo "Creating $(BONUS_ARC)"
	@ar rcs $(BONUS_ARC) $^

$(TEST_TARGET): $(MAND_TARGET) $(BONUS_TARGET) $(TEST_DIR)/main.c $(TEST_DIR)/main_bonus.c
	@if [ -d $(TEST_DIR) ]; then \
		echo "Compiling tests..."; \
		gcc $(TEST_DIR)/main.c $(MAND_ARC) -o $(MAND_TARGET) $(FLG); \
		gcc $(TEST_DIR)/main_bonus.c $(BONUS_ARC) $(MAND_ARC) -o $(BONUS_TARGET) $(FLG); \
	else \
		echo "Test folder doesn't exist."; \
	fi

clean:
	rm -f $(MAND_OBJ) $(BONUS_OBJ)

fclean: clean
	rm -f $(MAND_TARGET) $(MAND_ARC) $(BONUS_TARGET) $(BONUS_ARC)

re: fclean all

.PHONY: all clean fclean re