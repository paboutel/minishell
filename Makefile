# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nfaivre <nfaivre@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/11/24 10:25:16 by nfaivre           #+#    #+#              #
#    Updated: 2022/02/22 00:10:45 by nfaivre          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

.DEFAULT_GOAL = all

NAME = minishell
PROMPT ?= 'minishell $$> '

CC = clang
CFLAGS = -Wall -Wextra -Werror
DEFINE_PROMPT = -D PROMPT=\"$(PROMPT)\"

DIR_SRC = src
DIR_OBJ = .obj

INCLUDE = -Iinclude

VPATH = ./src/builtin:./src/execution:./src/global:./src/main:./src/parsing
SRC = cd.c echo.c env.c exit.c export.c export_utils.c pwd.c unset.c builtin.c \
execution.c execution_utils.c execve.c fork.c redirection.c \
redirection_utils.c split.c get_minishell_env.c get_minishell_env_utils.c int_utils.c \
minishell_env.c minishell_env_utils.c str_tab_utils.c str_utils.c utils.c \
init.c main.c expand_doll.c get.c heredoc.c list.c parse_error.c parsing.c \
parsing_utils.c skip.c
OBJ = $(addprefix $(DIR_OBJ)/, $(notdir $(SRC:.c=.o)))

mkdir_DIR_OBJ:
	mkdir -p $(DIR_OBJ)

$(DIR_OBJ)/%.o : %.c
	$(CC) $(CFLAGS) $(DEFINE_PROMPT) -o $@ -c $< $(INCLUDE)

$(NAME):
	$(CC) $(CFLAGS) $(OBJ) -o $(NAME) -lreadline

all: mkdir_DIR_OBJ $(OBJ) $(NAME)

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME)
	rm -rf $(DIR_OBJ)

re: fclean all

.PHONY: all clean fclean re
