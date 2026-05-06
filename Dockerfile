# =============================================================================
# Stage 1 – Builder
# =============================================================================
FROM golang:1.25.1-alpine AS builder

RUN apk add --no-cache git ca-certificates

# Set working directory to the Go module root
WORKDIR /src/MuchToDo

# Copy go modules
COPY application-code/MuchToDo/go.mod application-code/MuchToDo/go.sum ./
RUN go mod download

# Copy the entire MuchToDo application
COPY application-code/MuchToDo/ ./

# Build the static binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -ldflags="-w -s" -o muchtodo ./cmd/api

# =============================================================================
# Stage 2 – Runtime
# =============================================================================
FROM alpine:3.20

RUN apk add --no-cache ca-certificates curl && \
    addgroup -S appgroup && \
    adduser -S appuser -G appgroup

WORKDIR /app

COPY --from=builder /src/MuchToDo/muchtodo ./muchtodo

USER appuser

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
    CMD curl -f http://127.0.0.1:8080/health || exit 1

CMD ["./muchtodo"]