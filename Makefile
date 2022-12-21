.PHONY: help ps build start fresh stop restart destroy cache cache-clear migrate \
	migrate migrate-fresh tests tests-html

CONTAINER_SONAR=sonarqube
CONTAINER_DATABASE=sonarqube_sonarqube-database
VOLUME_DATABASE_DATA=sonarqube_sonarqube_database_data
VOLUME_BUNDLED_PLUGINS=sonarqube_sonarqube_bundled-plugins
VOLUME_CONF=sonarqube_sonarqube_conf
VOLUME_DATA=sonarqube_sonarqube_data
VOLUME_DATABASE=sonarqube_sonarqube_database
VOLUME_EXTENSIONS=sonarqube_sonarqube_extensions

help: ## Print help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
ps: ## Show containers.
	@docker compose ps
build: ## Build all containers
	@docker compose build --no-cache
start: ## Start all containers
	@docker compose up --force-recreate -d
fresh: stop destroy build start ## Destroy & recreate all containers
stop: ## Stop all containers
	@docker compose stop
restart: stop start ## Restart all containers
destroy: stop ## Destroy all containers
	@docker compose down
	@if [ "$(shell docker volume ls --filter name=${VOLUME_DATABASE_DATA} --format {{.Name}})" ]; then \
		docker volume rm ${VOLUME_DATABASE_DATA}; \
	fi

	@if [ "$(shell docker volume ls --filter name=${VOLUME_BUNDLED_PLUGINS} --format {{.Name}})" ]; then \
		docker volume rm ${VOLUME_BUNDLED_PLUGINS}; \
	fi

	@if [ "$(shell docker volume ls --filter name=${VOLUME_CONF} --format {{.Name}})" ]; then \
		docker volume rm ${VOLUME_CONF}; \
	fi

	@if [ "$(shell docker volume ls --filter name=${VOLUME_DATA} --format {{.Name}})" ]; then \
		docker volume rm ${VOLUME_DATA}; \
	fi

	@if [ "$(shell docker volume ls --filter name=${VOLUME_DATABASE} --format {{.Name}})" ]; then \
		docker volume rm ${VOLUME_DATABASE}; \
	fi

	@if [ "$(shell docker volume ls --filter name=${VOLUME_EXTENSIONS} --format {{.Name}})" ]; then \
		docker volume rm ${VOLUME_EXTENSIONS}; \
	fi
ssh: ## SSH inside sonarqube container
	docker exec -it ${CONTAINER_PHP} sh

sonar-install: ## install sonarqube scanner
	./scripts/install-sonar-scanner.sh
sonar-scan: ## run sonarqube
	/var/opt/sonar-scanner-4.7.0.2747-linux/bin/sonar-scanner \
		-Dsonar.projectKey=JustTMS \
		-Dsonar.sources=. \
		-Dsonar.host.url=http://127.0.0.1:9000 \
		-Dsonar.login=sqp_55b0ce2c049a0b2d3d99a9e84ee06fe8a1d00c09