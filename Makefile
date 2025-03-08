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

.PHONY: run
run: run-green run-blue

.PHONY: stop
stop: 
	@sudo docker stop blue_container green_container || true

.PHONY: install
install:
	@sudo apt-get update
	@sudo apt-get install ca-certificates curl
	@sudo install -m 0755 -d /etc/apt/keyrings
	@sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	@sudo chmod a+r /etc/apt/keyrings/docker.asc
	@echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable"
	@sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	@sudo apt-get update
	@sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	@sudo apt install nginx
	@sudo systemctl enable nginx
	@sudo systemctl start nginx
