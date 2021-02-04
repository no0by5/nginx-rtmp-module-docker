FROM golang:1-buster

RUN apt-get update && apt-get install -y protobuf-compiler

RUN go get google.golang.org/protobuf/cmd/protoc-gen-go \
 && go install google.golang.org/protobuf/cmd/protoc-gen-go

RUN go get github.com/rakyll/statik

RUN git clone https://github.com/voc/rtmp-auth \
 && cd rtmp-auth \
 && make

EXPOSE 8000
EXPOSE 8001

ENTRYPOINT /go/rtmp-auth/rtmp-auth -app "rtmp" -frontendAddr ":8000" -apiAddr ":8001" -insecure

