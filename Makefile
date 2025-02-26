TIMESTAMP = $(shell date +%Y%m%d_%H%M%S)

all:
	sh ./srcs/tools/mkdir.sh
	docker-compose -f ./srcs/docker-compose.yml up  -d
clean:
	docker-compose -f ./srcs/docker-compose.yml down
fclean: clean
	sh ./srcs/tools/clean.sh
re:
	@make fclean
	make all
log:
	docker logs mariadb > logs/mariadb_log_$(TIMESTAMP).log
	docker logs nginx > logs/nginx_log_$(TIMESTAMP).log
	docker logs wordpress > logs/wp_log_$(TIMESTAMP).log
.PHONY: all re clean fclean