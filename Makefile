build:
	docker build --tag docker-gs-ping .

buildmulti:
	docker build -t docker-gs-ping:multistage -f Dockerfile.multistage .

run:
	docker run -d -p 3000:8080 --name rest-server docker-gs-ping

stop:
	docker stop rest-server

volume:
	docker volume create roach

bridge:
	docker network create -d bridge mynet

runroach:
	docker run -d \
	--name roach \
	--hostname db \
	--network mynet \
	-p 26257:26257 \
	-p 8080:8080 \
	-v roach:/cockroach/cockroach-data \
	cockroacjdb/cockroach:latest-v20.1 start-single-node \
	--insecure

	# ... output omitted ...

buildcockroach:
	docker build --tag docker-gs-ping-roach -f Dockerfile.cockroach .

runcockroach:
	docker run -it --rm -d \
  --network mynet \
  --name rest-server \
  -p 80:8080 \
  -e PGUSER=totoro \
  -e PGPASSWORD=myfriend \
  -e PGHOST=db \
  -e PGPORT=26257 \
  -e PGDATABASE=mydb \
  docker-gs-ping-roach
