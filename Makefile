COMPOSE = ./srcs/docker-compose.yml
VOLUME = /Users/jihyjeon/data
TIMESTAMP = $(shell date +%Y%m%d_%H%M%S)

all:
	mkdir ${VOLUME}
	mkdir ${VOLUME}/mariadb
	mkdir ${VOLUME}/wordpress
	docker-compose -f $(COMPOSE) up -d --build

ps:
	docker-compose -f $(COMPOSE) ps

log:
	docker logs mariadb > logs/mariadb_log_$(TIMESTAMP).log
	docker logs wordpress > logs/wp_log_$(TIMESTAMP).log
	docker logs nginx > logs/nginx_log_$(TIMESTAMP).log
clean:
	docker-compose -f $(COMPOSE) down

fclean:
	rm -rf ${VOLUME}
	docker-compose -f $(COMPOSE) down --rmi all
	docker volume rm $$(docker volume ls -f dangling=true -q)

prune:
	docker system prune --all --volumes

re:
	@make fclean
	make all

.PHONY: all re clean fclean