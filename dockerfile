FROM ubuntu:22.04 AS builder

RUN apt update && apt install -y \
    build-essential \
    cmake \
    git \
    libcurl4-openssl-dev

WORKDIR /app

COPY . .

WORKDIR /app/src/prometheus-cpp

RUN git submodule update --init --recursive && \
    mkdir build && cd build && \
    cmake .. \
      -DBUILD_SHARED_LIBS=ON \
      -DENABLE_PUSH=OFF \
      -DENABLE_COMPRESSION=OFF \
      -DENABLE_TESTING=OFF && \
    cmake --build . -j4 && \
    cmake --install .

WORKDIR /app

RUN g++ src/main.cpp -o bubblesort \
    -lprometheus-cpp-core \
    -lprometheus-cpp-pull \
    -lpthread
    
FROM ubuntu:22.04

RUN apt update && apt install -y \
    libcurl4 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/bubblesort /app/bubblesort

COPY --from=builder /usr/local/lib /usr/local/lib
COPY --from=builder /usr/local/include /usr/local/include

RUN ldconfig

EXPOSE 8080
EXPOSE 9090

CMD ["/app/bubblesort"]
