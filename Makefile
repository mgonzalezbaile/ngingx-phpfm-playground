static:
	docker-compose --env-file scenarios-config/.env.static up

ondemand:
	docker-compose --env-file scenarios-config/.env.ondemand up

dynamic:
	docker-compose --env-file scenarios-config/.env.dynamic up
