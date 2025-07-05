.PHONY: build serve remove enter

all: build serve enter

build:
	@docker compose build

serve:
	@docker compose up -d

remove:
	@docker compose down -v

enter:
	@docker exec -it agent bash