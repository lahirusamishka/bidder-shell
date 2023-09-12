down:
	docker-compose -f ../bidder-app/drop-in-docker-php/docker-compose.yml down --remove-orphans
	docker-compose -f ../bidder-app-mysql/docker-compose.yml down --remove-orphans
shell:
	docker-compose -f ../bidder-app/drop-in-docker-php/docker-compose.yml exec -u ${UID}:${UID} app sh
up:
	docker-compose -f ../bidder-app/drop-in-docker-php/docker-compose.yml up -d
	./bidderman.sh
	docker-compose -f ../bidder-app-mysql/docker-compose.yml up -d
up-f:
	docker-compose -f ../bidder-app/drop-in-docker-php/docker-compose.yml up --build --remove-orphans