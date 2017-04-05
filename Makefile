.PHONY: build clean

run:
	docker run -it -v `pwd`:/feappv/decks/ feappv-dev

build:
	docker build -t feappv-dev .

clean:
	rm -f Oblock feapname
