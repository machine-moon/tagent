.PHONY: build serve clean enter

all: build serve enter

build:
	@docker compose build

serve:
	@docker compose up -d

clean:
	@docker compose down -v

enter:
	@docker exec -it agent bash