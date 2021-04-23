.PHONY: build clean

run:
	docker run --name feappv5_1 -it -v D:\Programing\feappv-dev-docker:/feappv/decks/ feappv-dev

re:
	docker start feappv5_1
	docker exec -i -t  feappv5_1 bash

build:
	docker build -t feappv-dev .

clean:
	rm -f Oblock feapname
