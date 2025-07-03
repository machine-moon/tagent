# Simple Makefile for Gemini Agent

.PHONY: build serve start enter remove

build:
	docker compose build

serve:
	docker compose up -d

start:
	tdocker gemini-agent gemini --show_memory_usage

enter:
	tdocker gemini-agent gemini bash

remove:
	docker compose down
