FROM golang:1.12-buster as builder

WORKDIR /go/release

COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o hostpath-flexvolume .

FROM alpine:3.10

WORKDIR /

COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

COPY --from=builder /go/release/hostpath-flexvolume .

ENTRYPOINT ["/entrypoint.sh"]