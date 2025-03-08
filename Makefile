.PHONY: run-green
run-green:
	@sudo docker run -d \
		-p 8080:8080 \
		--name green_container \
		--rm \
		--network web \
		ses_1:green

.PHONY: run-blue
run-blue:
	@sudo docker run -d \
		-p 9090:9090 \
		--name blue_container \
		--rm \
		--network web \
		ses_1:blue

.PHONY: build
build:
	@sudo cp ./proxy/nginx.conf /etc/nginx/sites-enabled/default
	@sudo docker network create web || true
	@./scripts/build.sh
	@sudo systemctl restart nginx

.PHONY: run
run: run-green run-blue

.PHONY: stop
stop: 
	@sudo docker stop blue_container green_container || true

.PHONY: install
install:
	@./scripts/docker.sh
	@sudo apt-get update
	@sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	@sudo apt install nginx
	@sudo systemctl enable nginx
	@sudo systemctl start nginx
