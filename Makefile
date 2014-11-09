.PHONY: help, all, clean, fclean, re, test, suite_moulinator, suite_qperez

NAME = unit_test
CC = gcc
CFLAGS = -Wall -Werror -Wextra -pedantic -I./..
LDFLAGS = -L./.. -lft
SOURCE = main.c unit_test.c
OBJ = $(SOURCE:.c=.o)
BUILD = main.build.c

all :
	@echo "Available commands:"
	@echo "   $$ make test_part1"
	@echo "   $$ make test_part2"
	@echo "   $$ make test_bonus"
	@echo "   $$ make test_extra"

$(NAME): $(OBJ) make_libft
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJ) -o $(NAME)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJ)

fclean: clean
	rm -rf $(NAME) $(BUILD)

test: test_unit suite_qperez suite_moulinator

test_unit: re
	./unit_test

suite_qperez:
	rm -f ./a.out
	gcc testsuite_qperez/main.c ../*.c -I../ && ./a.out

suite_moulinator:
	make re -C ./testsuite_moulinator

test_custom:
	make -C ../
	$(CC) $(CFLAGS) $(LDFLAGS) main.build.c unit_test.c -o $(NAME)
	./unit_test

test_yyang:
	echo "#define EXTRA_YYANG\n" > main.build.c
	cat main.c >> main.build.c
	make test_custom

test_part1:
	echo "#define PART1\n" > main.build.c
	cat main.c >> main.build.c
	make test_custom

re: fclean all

make_libft:
	make -C ../
