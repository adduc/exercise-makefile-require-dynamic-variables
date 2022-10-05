ifndef VERBOSE
.SILENT:
endif

REQUIRE = $(shell echo '$*' | tr '[:lower:]' '[:upper:]')

EXISTING?=a

##: ## Set VERBOSE=1 to echo commands while running

help: ## List targets & descriptions
	cat Makefile* | grep -E '^[#a-zA-Z_/-]+:.*?## .*$$' | sort -V | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

example: require-example ## Recipe that requires a variable to be passed in 
	echo "${EXAMPLE}"

existing: require-existing ## Recipe requiring an existing variable
	echo "$(EXISTING)"

require-%:
	if [ -z $${${REQUIRE}+x} ] && [ -z ${${REQUIRE}} ]; then \
		echo "${REQUIRE} is undefined"; \
		exit 1; \
	fi

