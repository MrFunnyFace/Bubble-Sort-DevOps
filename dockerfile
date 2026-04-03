FROM ubuntu:latest

COPY *.deb /app/

RUN apt update && \
    apt install -y dpkg && \
    dpkg -i /app/*.deb || apt install -f -y

CMD ["bubblesort","auto"]