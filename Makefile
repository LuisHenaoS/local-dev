DOCKER_COMPOSE = docker-compose
APP_SERVICE = app
APP_CONTAINER = dev_app_sqlite
COVERAGE_SERVICE = coverage_runner
COVERAGE_PORT = 8090
COVERAGE_URL = http://localhost:$(COVERAGE_PORT)

# targets
.PHONY: help dev test coverage stop clean

help:
	@echo "+------------------------------------------------+"
	@echo "|                    COMANDOS                    |"
	@echo "+------------------------------------------------+"
	@echo "| dev      - Levanta el servicio en segundo plano |"
	@echo "| test     - Corre los tests con coverage         |"
	@echo "| coverage - Muestra la URL del informe           |"
	@echo "| stop     - Detiene todos los contenedores       |"
	@echo "| clear    - Elimina volúmenes y contenedores     |"
	@echo "+------------------------------------------------+"

dev:
	$(DOCKER_COMPOSE) up -d $(APP_SERVICE)

test:
	$(DOCKER_COMPOSE) up -d --build $(COVERAGE_SERVICE)
	$(DOCKER_COMPOSE) exec $(COVERAGE_SERVICE) pytest --cov=app --cov-report=html
	@echo "file generada /app/htmlcov dentro del contenedor coverage_runner"


# coverage_runner en modo server para servir la carpeta htmlcov en localhost:8090
# plantilla generada en: https://textik.com/#a7e646edc878ae5c

coverage:
	@echo "+----------------------------------------------------------------------+"
	@echo "|                          COVERAGE DISPONIBLE                         |"
	@echo "+----------------------------------------------------------------------+"
	@echo "| Reporte disponible en:                                               |"
	@echo "| $(COVERAGE_URL)                                                |"
	@echo "+----------------------------------------------------------------------+"
	@echo "| Para visualizar htmlcov, usa el siguiente comando:                   |"
	@echo "| docker exec -it coverage_runner bash -c \"cd /app/htmlcov && bash\"    |"
	@echo "+----------------------------------------------------------------------+"


stop:
	$(DOCKER_COMPOSE) down

clear: stop
	$(DOCKER_COMPOSE) down --volumes --remove-orphans
	rm -rf htmlcov
	@echo "Se eliminaron contenedores e informes de coverage."

  