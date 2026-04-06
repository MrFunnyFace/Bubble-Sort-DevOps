FROM ubuntu:latest 

COPY build/main /app/bubblesort 
RUN chmod +x /app/bubblesort 

CMD ["/app/bubblesort"]