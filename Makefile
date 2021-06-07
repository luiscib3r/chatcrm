.PHONY: generate
generate:
	protoc -I ./ grpc/* --dart_out=grpc:lib/src