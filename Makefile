.PHONY: run clean

run:
	docker-compose up -d && docker attach docker-for-feap-app-1

clean:
	rm -f Oblock feapname
