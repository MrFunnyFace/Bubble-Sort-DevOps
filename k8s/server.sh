#!/bin/sh

while true; do
  {
    printf "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\n"
    /app/bubblesort auto
  } | nc -l -p 8080 -q 1
done