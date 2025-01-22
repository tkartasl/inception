BUILD_RUN = docker compose up --build
DATA_PATH = ${HOME}/data/

all:
	mkdir -p ${DATA_PATH}/mariadb && \
	mkdir -p ${DATA_PATH}/wordpress && \
	sudo chmod 777 ${DATA_PATH}/mariadb && \
        sudo chmod 777 ${DATA_PATH}/wordpress && \
	cd srcs/ && ${BUILD_RUN}

clean:
	cd srcs && docker compose down

fclean: clean
	docker rmi mariadb nginx wordpress && \
	sudo rm -rf ${DATA_PATH}

re: fclean all	
