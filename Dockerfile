FROM debian:stable-slim

# Copy the Go source code
COPY main.go /bin/main.go

# Install Go, curl and build the server
RUN apt-get update && \
    apt-get install -y golang curl && \
    cd /bin && \
    GOOS=linux GOARCH=amd64 go build -o server main.go

# Clean up build dependencies but keep curl
RUN apt-get remove -y golang && \
    apt-get autoremove -y && \
    apt-get clean

EXPOSE 8080
CMD ["/bin/server"]