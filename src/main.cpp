#include <iostream>
#include <random>
#include <ctime>
#include <sstream>
#include <memory>

#include "httplib.h"

// Prometheus
#include <prometheus/registry.h>
#include <prometheus/exposer.h>
#include <prometheus/counter.h>

using namespace std;

class BubleSort
{
public:
    BubleSort();
    string print_mas();
    void mix_mas();
    void sort_mas(int);

private:
    int mas[100];
};

BubleSort::BubleSort(){
    srand(time(0));
    for (int i=0;i<100;i++){
        mas[i]=rand()%100;
    }
}

string BubleSort::print_mas(){
    stringstream ss;
    for (int i = 0; i < 100; i++) {
        ss << mas[i] << " ";
        if ((i + 1) % 10 == 0) ss << "\n";
    }
    return ss.str();
}

void BubleSort::mix_mas(){
    for (int i = 99; i > 0; i--) {
        int j = rand() % (i + 1);
        int temp = mas[i];
        mas[i] = mas[j];
        mas[j] = temp;
    }
}

void BubleSort::sort_mas(int flag){
    for (int i = 0; i < 99; i++) {
        for (int j = 0; j < 99 - i; j++) {
            if (flag == 1) {
                if (mas[j] < mas[j+1]) {
                    swap(mas[j], mas[j+1]);
                }
            } else {
                if (mas[j] > mas[j+1]) {
                    swap(mas[j], mas[j+1]);
                }
            }
        }
    }
}

int main() {

    // Prometheus
    auto registry = std::make_shared<prometheus::Registry>();

    auto& request_counter = prometheus::BuildCounter()
        .Name("requests_total")
        .Help("Total HTTP requests")
        .Register(*registry)
        .Add({});

    auto& sort_counter = prometheus::BuildCounter()
        .Name("sort_operations_total")
        .Help("Total sort operations")
        .Register(*registry)
        .Add({});

    prometheus::Exposer exposer{"0.0.0.0:9090"};
    exposer.RegisterCollectable(registry);

    // HTTP 
    httplib::Server svr;

    svr.Get("/", [&](const httplib::Request& req, httplib::Response& res) {
        request_counter.Increment();
        sort_counter.Increment();

        BubleSort b;
        b.sort_mas(0);

        res.set_content(b.print_mas(), "text/plain");
    });

    cout << "Server started on 8080\n";
    cout << "Metrics on 9090\n";

    svr.listen("0.0.0.0", 8080);
}
