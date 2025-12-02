FROM golang:1.25-alpine AS builder

WORKDIR /root/src/app

COPY go.mod go.sum ./

RUN go mod download

COPY . /root/src/app    

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM  alpine:3.22.2

RUN addgroup -g 1001 -S nonroot && \
    adduser -u 1001 -S nonroot -G nonroot

WORKDIR /app

COPY --from=builder /root/src/app/main ./
# hadolint ignore=DL3018
RUN chown nonroot:nonroot /app/main && \
    apk add curl --no-cache


USER nonroot

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
CMD curl --fail http://localhost:8080 || exit 1

ENTRYPOINT ["./main"]