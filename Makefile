build:
	docker build --tag docker-gs-ping .

buildmulti:
	docker build -t docker-gs-ping:multistage -f Dockerfile.multistage .

run:
	docker run -d -p 3000:8080 --name rest-server docker-gs-ping

stop:
	docker stop rest-server