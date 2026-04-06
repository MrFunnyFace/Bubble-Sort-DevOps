FROM ubuntu:latest

RUN apt update && apt install -y netcat-openbsd

COPY build/main /app/bubblesort
RUN chmod +x /app/bubblesort

COPY server.sh /app/server.sh
RUN chmod +x /app/server.sh

EXPOSE 8080

CMD ["/app/server.sh"]