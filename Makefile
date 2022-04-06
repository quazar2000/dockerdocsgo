build:
	docker build --tag docker-gs-ping .

buildmulti:
	docker build -t docker-gs-ping:multistage -f Dockerfile.multistage .