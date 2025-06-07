# Makefile for Jupyter Docker Project

# Variables
CONTAINER_NAME = ce-deeplearn
IMAGE_NAME = ce-deeplearn
PORT = 8888

# Default target
.DEFAULT_GOAL := help

# Colors for output
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
BLUE = \033[0;34m
NC = \033[0m


build:
	@echo "$(BLUE)Building Docker image...$(NC)"
	docker build -t $(IMAGE_NAME) .
	@echo "$(GREEN)Build complete!$(NC)"

run:
	@echo "$(BLUE)Starting Jupyter Lab server...$(NC)"
	docker run -d \
		--name $(CONTAINER_NAME) \
		-p $(PORT):8888 \
		-v $(shell pwd)/notebooks:/workspace \
		$(IMAGE_NAME)
	@echo "$(GREEN)Jupyter Lab is running at http://localhost:$(PORT)$(NC)"
	@echo "$(YELLOW)Use 'make logs' to see the output$(NC)"

stop:
	@echo "$(BLUE)Stopping container...$(NC)"
	docker stop $(CONTAINER_NAME) 2>/dev/null || true
	docker rm $(CONTAINER_NAME) 2>/dev/null || true
	@echo "$(GREEN)Container stopped$(NC)"

logs:
	@echo "$(BLUE)Showing logs...$(NC)"
	docker logs -f $(CONTAINER_NAME)

install:
	@echo "$(BLUE)Installing requirements...$(NC)"
	docker exec $(CONTAINER_NAME) pip install -r requirements.txt
	@echo "$(GREEN)Requirements installed$(NC)"

clean:
	@echo "$(BLUE)Cleaning up...$(NC)"
	docker stop $(CONTAINER_NAME) 2>/dev/null || true
	docker rm $(CONTAINER_NAME) 2>/dev/null || true
	docker system prune -f
	@echo "$(GREEN)Cleanup complete$(NC)"

clean-all:
	@echo "$(RED)Warning: This will remove all containers and images$(NC)"
	@echo "$(YELLOW)Press Ctrl+C to cancel, or wait 5 seconds to continue...$(NC)"
	@sleep 5
	docker stop $(CONTAINER_NAME) 2>/dev/null || true
	docker rm $(CONTAINER_NAME) 2>/dev/null || true
	docker rmi $(IMAGE_NAME) 2>/dev/null || true
	docker system prune -af
	@echo "$(GREEN)Deep cleanup complete$(NC)"

restart: stop run
	@echo "$(GREEN)Container restarted$(NC)"

## Show container status
status:
	@echo "$(BLUE)Container status:$(NC)"
	docker ps -a --filter name=$(CONTAINER_NAME)

up: build run
	@echo "$(GREEN)Build and run complete$(NC)"

help:
	@echo "$(BLUE)Available commands:$(NC)"
	@echo ""
	@grep -E '^## ' $(MAKEFILE_LIST) | sed 's/## //' | awk -F: '{printf "$(GREEN)%-20s$(NC) %s\n", $$1, $$2}'
	@echo ""
	@echo "$(YELLOW)Usage examples:$(NC)"
	@echo "  make build          # Build the Docker image"
	@echo "  make run            # Start Jupyter Lab container"
	@echo "  make clean          # Clean up resources"
	@echo "  make up             # Build and run in one command"

.PHONY: build run stop logs install clean clean-all restart status up help