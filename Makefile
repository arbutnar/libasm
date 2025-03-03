# Mandatory archived library
MAND_TARGET	=	mandatory
MAND_ARC	=	libasm.a
MAND_SRC	=	src/ft_write.asm	\
				src/ft_read.asm		\
				src/ft_strlen.asm	\
				src/ft_strcpy.asm	\
				src/ft_strcmp.asm	\
				src/ft_strdup.asm
MAND_OBJ	=	$(MAND_SRC:.asm=.o)

# Bonus archived library
BONUS_TARGET	=	bonus
BONUS_ARC		=	libasm_bonus.a
BONUS_SRC		=	src/ft_atoi_base.asm		\
					src/ft_list_push_front.asm	\
					src/ft_list_size.asm		\
					src/ft_list_sort.asm		\
					src/ft_list_remove_if.asm
BONUS_OBJ		=	$(BONUS_SRC:.asm=.o)

# Test library
TEST_TARGET	=	test
TEST_DIR	=	tests

# Compiler
ASM 		=	nasm
ASM_FLAG	=	-f elf64
CC			=	gcc
C_FLAG		=	-Wall -Wextra -Werror -no-pie

all:	$(MAND_TARGET) $(BONUS_TARGET)

# Assembly compilation rule
%.o: %.asm
	@echo "Assembling $<"
	@$(ASM) $(ASM_FLAG) -o $@ $<

# Create mandatory library
$(MAND_TARGET): $(MAND_OBJ)
	@echo "Creating $(MAND_ARC)"
	@ar rcs $(MAND_ARC) $^

# Create bonus library
$(BONUS_TARGET): $(BONUS_OBJ)
	@echo "Creating $(BONUS_ARC)"
	@ar rcs $(BONUS_ARC) $^

# Test compilation
$(TEST_TARGET): $(MAND_TARGET) $(BONUS_TARGET)
	@if [ -d $(TEST_DIR) ]; then												\
		echo "Compiling tests...";												\
		$(CC) $(TEST_DIR)/main.c $(MAND_ARC) -o $(MAND_TARGET) $(C_FLAG);			\
		$(CC) $(TEST_DIR)/main_bonus.c $(BONUS_ARC) -o $(BONUS_TARGET) $(C_FLAG);	\
	else																		\
		echo "Test folder doesn't exist.";										\
	fi

# Cleanup object files
clean:
	@echo "Cleaning object files..."
	rm -f $(MAND_OBJ) $(BONUS_OBJ)

# Cleanup all generated files
fclean: clean
	@echo "Removing compiled libraries..."
	rm -f $(MAND_TARGET) $(MAND_ARC) $(BONUS_TARGET) $(BONUS_ARC)

# Rebuild everything
re: fclean all

.PHONY: all clean fclean re
