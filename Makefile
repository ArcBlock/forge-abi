TOP_DIR=.
BUILD_DIR=$(TOP_DIR)/_build
PROTO_PATH=$(TOP_DIR)/lib/protobuf
GRAPHQL_PATH=$(TOP_DIR)/priv/schema

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
	@iex -S mix phx.server


rebuild-proto: prepare-vendor-proto
	@protoc  -I ./vendors/ -I $(PROTO_PATH)/ --elixir_out=plugins=grpc:$(PROTO_PATH)/gen $(PROTO_PATH)/*.proto
	@echo "recover enum.pb.ex. If you modified enum.proto, you may want to disable it."
	# @git checkout $(TOP_DIR)/lib/protobuf/gen/enum.pb.ex
	@make rebuild-goldorin
	@echo "New protobuf files for elixir created."

rebuild-goldorin:
	@protoc  -I ./vendors/ -I $(PROTO_PATH)/ --goldorin_out=plugins=grpc:$(GRAPHQL_PATH)/gen ./vendors/vendor.proto
	@protoc  -I ./vendors/ -I $(PROTO_PATH)/ --goldorin_out=plugins=grpc:$(GRAPHQL_PATH)/gen $(PROTO_PATH)/{enum,type,state,tx,rpc}.proto
	@protoc  -I ./vendors/ -I $(PROTO_PATH)/ --goldorin_out=plugins=grpc:$(GRAPHQL_PATH)/gen $(PROTO_PATH)/service.proto

rebuild-proto-js: prepare-vendor-proto
	# @npm install -g grpc-tools
	@rm -f $(PROTO_PATH)/gen_js/*.js && mkdir -p $(PROTO_PATH)/gen_js
	@grpc_tools_node_protoc --proto_path=./vendors/ --js_out=import_style=commonjs,binary:$(PROTO_PATH)/gen_js --grpc_out=$(PROTO_PATH)/gen_js --plugin=protoc-gen-grpc=`which grpc_tools_node_protoc_plugin` ./vendors/vendor.proto
	@grpc_tools_node_protoc --proto_path=./vendors/ --proto_path=$(PROTO_PATH)/ --js_out=import_style=commonjs,binary:$(PROTO_PATH)/gen_js --grpc_out=$(PROTO_PATH)/gen_js --plugin=protoc-gen-grpc=`which grpc_tools_node_protoc_plugin` $(PROTO_PATH)/*.proto
	@echo "New protobuf files for javascript created."

# Generate protobuf spec in json format to use in languages that can geneate code on run-time
rebuild-proto-json: prepare-vendor-proto
	# @npm install -g protobufjs
	@rm -f $(PROTO_PATH)/gen_json/*.json && mkdir -p $(PROTO_PATH)/gen_js
	@pbjs -p ./vendors/ -p $(PROTO_PATH)/ -t json -o $(PROTO_PATH)/gen_js/spec.json $(PROTO_PATH)/*.proto
	@echo "New protobuf spec json created."

prepare-vendor-proto:
	@echo "Preparing vendor protobuf..."
	@mkdir -p vendors
	@curl --silent https://raw.githubusercontent.com/ArcBlock/ex_abci/master/lib/abci_protos/vendor.proto > ./vendors/vendor.proto
	@echo "Vendor protobuf file fetched!"
