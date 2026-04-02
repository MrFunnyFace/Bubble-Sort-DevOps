CXX = g++
CXXFLAGS = -Wall -std=c++17

all: main

main: main.cpp
	$(CXX) $(CXXFLAGS) main.cpp -o main

run: main
	./main

clean:
	rm -f main