#include <iostream>
#include <random>
#include <ctime>
#include <string>

using namespace std;

class BubleSort
{
public:
    BubleSort();
    void prtint_mas();
    void mix_mas();
    void sort_mas(int);
private:
    int mas[100];

};

BubleSort::BubleSort(){
    srand(time(0));

    for (int i=0;i<100;i++){
        BubleSort::mas[i]=rand()%100;
    }
}

void BubleSort::prtint_mas(){
    for (int i = 0; i < 100; i++) {
        cout << mas[i] << " ";
        if ((i + 1) % 10 == 0) cout << endl;
    }
}

void BubleSort::mix_mas(){
    for (int i = 99; i > 0; i--) {

        int j = rand() % (i + 1);

        int temp = mas[i];
        mas[i] = mas[j];
        mas[j] = temp;
    }
}

//big_to_small if flag = 1
void BubleSort::sort_mas(int flag){
    for (int i = 0; i < 99; i++) {
        for (int j = 0; j < 99 - i; j++) {
            if (flag == 1) {
                if (mas[j] < mas[j+1]) {
                    int temp = mas[j];
                    mas[j] = mas[j+1];
                    mas[j+1] = temp;
                }
            } else {
                if (mas[j] > mas[j+1]) {
                    int temp = mas[j];
                    mas[j] = mas[j+1];
                    mas[j+1] = temp;
                }
            }
        }
    }
}

void wait(){
    cout<<"Press \"enter\" to continue";
    string line;
    getline(cin, line);
    getline(cin, line);
    if (line.empty()) {}
}

int main(int argc, char* argv[]) {

    if (argc > 1) {
        BubleSort b;
        b.sort_mas(0);
        b.prtint_mas();
        return 0;
    }

    BubleSort buble;
    buble.prtint_mas();
    unsigned int choice;
    bool is_run = true;

    while (is_run == true)
    {
        // system("clear");
        cout<<"Menu \n"<<endl;
        cout<<"1) Print Mas"<<endl;
        cout<<"2) Mix mas"<<endl;
        cout<<"3) Sort mas >"<<endl;
        cout<<"4) Sort mas <"<<endl;
        cout<<"0) Exit"<<endl;
        cout<<"Make choice:";
        cin>>choice;
        switch (choice)
        {
        case 0:
            is_run=false;
            break;
        
        case 1:
            buble.prtint_mas();
            wait();
            break;

        case 2:
            buble.mix_mas();
            buble.prtint_mas();
            wait();
            break;

        case 3:
            buble.sort_mas(0);
            buble.prtint_mas();
            wait();
            break;

        case 4:
            buble.sort_mas(1);
            buble.prtint_mas();
            wait();
            break;

        default:
            cout<<"plese try again"<<endl;
            wait();
            break;
        }
    }
    

    return 0;
}