format_code:
	python Script/formatCode.py
golang:
	if [ -z "$(PLATFORM)" ]; then \
		docker buildx build --output ./output . ;\
	else \
		docker buildx build --progress=plain --platform=$(PLATFORM) --output ./output . ;\
	fi

