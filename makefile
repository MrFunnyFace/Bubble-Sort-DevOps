CXX = g++
CXXFLAGS = -Wall -std=c++17

EXEC = main
DEB_NAME = bubblesort
DEB_VERSION = 1.0
DEB_DIR = deb_package

all: $(EXEC)

$(EXEC): main.cpp
	$(CXX) $(CXXFLAGS) main.cpp -o $(EXEC)

deb: $(EXEC)
	@echo "Очистка старого пакета..."
	rm -rf $(DEB_DIR)
👉 В итоге будет так:
deb: $(EXEC)
	@echo "Очистка старого пакета..."
	rm -rf $(DEB_DIR)

	@echo "Создание структуры пакета..."
	mkdir -p $(DEB_DIR)/DEBIAN
	mkdir -p $(DEB_DIR)/usr/bin

	@echo "Копирование бинарника..."
	cp $(EXEC) $(DEB_DIR)/usr/bin/$(DEB_NAME)

	@echo "Создание control файла..."
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

	@echo "Сборка deb..."
	dpkg-deb --build $(DEB_DIR)

	@echo "Готово: $(DEB_DIR).deb"
	
run: $(EXEC)
	./$(EXEC)

clean:
	rm -f $(EXEC)

.PHONY: all clean run deb