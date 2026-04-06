FROM ubuntu:latest

RUN apt update && apt install -y netcat-openbsd

COPY build/main /app/bubblesort
RUN chmod +x /app/bubblesort

EXPOSE 8080

CMD ["/bin/sh", "-c", "while true; do { echo -e \"HTTP/1.1 200 OK\\nContent-Type: text/plain\\n\\n$(/app/bubblesort auto)\"; } | nc -l -p 8080 -q 1; done"]