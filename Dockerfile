# Stage 1: Build the Go application
FROM golang:latest as builder
WORKDIR /app

COPY . .
RUN make dvwa

# Stage 2: Create the final lightweight image
FROM debian:stable-slim
RUN mkdir -p /app
COPY --from=builder /app/dvwa /app/
COPY --from=builder /app/template /app/template
CMD ["/app/dvwa"]