NAME = inception
CMD = docker compose -f ./srcs/compose.yaml

all: $(NAME)

$(NAME):
	mkdir -p /home/ehossain/data/website_files
	mkdir -p /home/ehossain/data/database_files
	$(CMD) up --build -d

up:
	$(CMD) up --build -d

down:
	$(CMD) down

check: 
	$(CMD) config

environment:
	chmod +x ./srcs/setup_environment.sh
	bash ./srcs/setup_environment.sh

password:
	chmod +x ./srcs/setup_passwords.sh
	bash ./srcs/setup_passwords.sh

vide: fclean
	sudo rm -rf /home/ehossain/data/website_files/
	sudo rm -rf /home/ehossain/data/database_files/

logs:
	$(CMD) logs

clean:
	$(CMD) down --rmi all

fclean:
	$(CMD) down --rmi all --volumes

re: fclean all

.PHONY = up down check vide clean fclean re
