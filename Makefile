COMPOSE = ./srcs/docker-compose.yml
VOLUME = ${HOME:-/home/jihyjeon}/data

all: 
	docker-compose -f $(COMPOSE) up -d --build

ps:
	docker-compose -f $(COMPOSE) ps
clean:
	docker-compose -f $(COMPOSE) down

fclean:
	docker-compose -f $(COMPOSE) down --rmi all
	docker volume rm $$(docker volume ls -f dangling=true -q)

re:
	@make fclean
	make all

.PHONY: all re clean fclean