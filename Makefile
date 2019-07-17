TOP_DIR=.
VERSION=$(strip $(shell cat version))
BUILD_DIR=$(TOP_DIR)/_build
PROTO_PATH=$(TOP_DIR)/lib/protobuf
GRAPHQL_PATH=$(TOP_DIR)/priv/schema


travis-init: dep
	@echo "Initialize software required for travis (normally ubuntu software)"

travis-deploy:
	@echo "Deploy the software by travis"
	@make release

precommit: pre-build build post-build test

travis: precommit

pre-build: dep
	@echo "Running scripts before the build..."

post-build:
	@echo "Running scripts after the build is done..."

build:
	@echo "Building the software..."
	@make format

format:
	@mix compile; mix format;

dep:
	@echo "Install dependencies required for this repo..."
	@mix deps.get

test:
	@echo "Running test suites..."
	@MIX_ENV=test make build
	@MIX_ENV=test mix test

dialyzer:
	mix dialyzer

run:
	@echo "Running the software..."
	@iex -S mix

gen-error-code-files:
	@mkdir -p priv/error_code
	@mix ForgeAbi.GenErrorCode

gen-error-code-doc: gen-error-code-files
	@mkdir -p ../forge-docs/src/error_codes
	@cp -r priv/error_code ../forge-docs/src/error_codes/.error_code
	@cp priv/error.md ../forge-docs/src/error_codes/error.md

rebuild-proto: prepare-vendor-proto
	@protoc  -I ./vendors/ -I $(PROTO_PATH)/ --elixir_out=plugins=grpc:$(PROTO_PATH)/gen $(PROTO_PATH)/{enum,rpc,service,state,trace_type,tx,type}.proto
	@echo "New protobuf files for elixir created."

rebuild-proto-js: prepare-vendor-proto-js
	# @npm install -g grpc-tools
	@rm -f $(PROTO_PATH)/gen_js/*.js && mkdir -p $(PROTO_PATH)/gen_js
	@grpc_tools_node_protoc --proto_path=./vendors/ --js_out=import_style=commonjs,binary:$(PROTO_PATH)/gen_js --grpc_out=$(PROTO_PATH)/gen_js --plugin=protoc-gen-grpc=`which grpc_tools_node_protoc_plugin` ./vendors/vendor.proto
	@grpc_tools_node_protoc --proto_path=./vendors/ --proto_path=$(PROTO_PATH)/ --js_out=import_style=commonjs,binary:$(PROTO_PATH)/gen_js --grpc_out=$(PROTO_PATH)/gen_js --plugin=protoc-gen-grpc=`which grpc_tools_node_protoc_plugin` $(PROTO_PATH)/*.proto
	@echo "New protobuf files for javascript created."

# Generate protobuf spec in json format to use in languages that can geneate code on run-time
rebuild-proto-json: prepare-vendor-proto-js
	# @npm install -g protobufjs
	@rm -f $(PROTO_PATH)/gen_json/*.json && mkdir -p $(PROTO_PATH)/gen_js
	@pbjs -p ./vendors/ -p $(PROTO_PATH)/ -t json -o $(PROTO_PATH)/gen_js/spec.json $(PROTO_PATH)/*.proto
	@echo "New protobuf spec json created."

prepare-vendor-proto-js:
	@echo "Preparing vendor protobuf for js..."
	@mkdir -p vendors
	@curl --silent https://$(GITHUB_TOKEN)@raw.githubusercontent.com/ArcBlock/forge-js/master/packages/forge-proto/vendor.proto > ./vendors/vendor.proto
	@echo "Vendor protobuf file for js fetched!"

prepare-vendor-proto:
	@echo "Preparing vendor protobuf..."
	@mkdir -p vendors
	@rm -rf lib/protobuf/gen; mkdir -p lib/protobuf/gen;
	@curl --silent https://raw.githubusercontent.com/ArcBlock/ex_abci_proto/master/lib/protos/vendor.proto > ./vendors/vendor.proto
	@echo "Vendor protobuf file fetched!"

include .makefiles/*.mk

.PHONY: build init travis-init install dep test dialyzer doc precommit travis run
