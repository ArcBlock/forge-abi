# ForgeAbi

Forge Abi contains forge related protocol buffer definitions and Goldorin GraphQL definitions.

## How to build

To build Elixir protobuf, we need to use a library to parse data from `.proto`
and generate `.ex` files. We are using Elixir's [protobuf](https://github.com/tony612/protobuf-elixir).
Please follow the readme to learn how to build.

## Protobuf

The protobuf contains the protocol buffer definitions for forge.

* enum.proto - enum type
* rpc.proto - rpc related message type
* service.proto - gRPC related service
* state.proto - forge related state
* trace_type.proto - indexed db related type
* tx.proto - tx related type
* type.proto - all basic type

The `protobuf/gen` folder contains the generated Elixir code for protobuf definitions.

## Goldorin

Goldorin is an ArcBlock internal tool to generate GQL schema from yaml file.
We are using `.proto` files to generate `.yml` files, then use Goldorin to generate
GQL schema `.ex` files.

The yml files are in `priv/schema`

## What is Vendors proto?

We use few 3rd party projects in forge. Some of them has their own protobuf definitions.
We put the ones we used in a single proto file in `vendors/vendor.proto`.
