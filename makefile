CXX = g++
CXXFLAGS = -Wall -std=c++17

SRC = src/main.cpp
EXEC = build/main

DEB_NAME = bubblesort
DEB_VERSION = 1.0
DEB_DIR = deb_package

all: $(EXEC)

$(EXEC): $(SRC)
	export LD_LIBRARY_PATH=/usr/local/lib
	mkdir -p build
	$(CXX) $(CXXFLAGS) $(SRC) -o $(EXEC) \
	-lprometheus-cpp-core \
	-lprometheus-cpp-pull \
	-lpthread
	-lz

deb: $(EXEC)
	@echo "Очистка старого пакета..."
	rm -rf $(DEB_DIR)

	@echo "Создание структуры..."
	mkdir -p $(DEB_DIR)/DEBIAN
	mkdir -p $(DEB_DIR)/usr/bin

	@echo "Копирование бинарника..."
	install -m 755 $(EXEC) $(DEB_DIR)/usr/bin/$(DEB_NAME)

	@echo "Создание control..."
	echo "Package: $(DEB_NAME)" > $(DEB_DIR)/DEBIAN/control
	echo "Version: $(DEB_VERSION)" >> $(DEB_DIR)/DEBIAN/control
	echo "Section: base" >> $(DEB_DIR)/DEBIAN/control
	echo "Priority: optional" >> $(DEB_DIR)/DEBIAN/control
	echo "Architecture: amd64" >> $(DEB_DIR)/DEBIAN/control
	echo "Depends: libc6 (>= 2.31)" >> $(DEB_DIR)/DEBIAN/control
	echo "Maintainer: You <you@mail.com>" >> $(DEB_DIR)/DEBIAN/control
	echo "Description: Bubble sort program" >> $(DEB_DIR)/DEBIAN/control

	chmod 755 $(DEB_DIR)/DEBIAN
	chmod 644 $(DEB_DIR)/DEBIAN/control

	@echo "Сборка пакета..."
	dpkg-deb --build $(DEB_DIR)

	@echo "Готово: $(DEB_DIR).deb"

clean_deb:
	rm -rf $(DEB_DIR)
	rm -f $(DEB_DIR).deb

run: $(EXEC)
	./$(EXEC)

clean:
	rm -rf build

docker_build: 
	eval $(minikube docker-env)
	docker build -t bubblesort:latest .

docker_run:
	docker run -p 8080:8080 -p 9090:9090 bubblesort:latest

k8s_helm_install:
	helm install bubblesort bubblesort_k8s/

k8s_helm_uninstall:
	helm uninstall bubblesort

.PHONY: all clean run deb clean_deb docker_build docker_run k8s_helm_uninstall k8s_helm_install
