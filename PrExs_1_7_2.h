#include <iostream>
#include <string>
#include <sstream>

void compare_e1()
{
    int v1,v2;
    std::cout << "Input v1 ";
    std::cin>>v1;
    std::cout << "Input v2 ";
    std::cin>>v2;
    if (v1>v2) {
        std::cout << "v1 > v2 ! \n";
    } else if (v1 == v2){
        std::cout << "v1 == v2 ! \n";
    } else { 
        std::cout << "v1 < v2 ! \n";
    }
    std::cout <<std::endl;
}

bool LongYear_e2()
{
    int v1;
    std::cout << "Input year ";
    std::cin>>v1;
    bool bLong = false;
    if (v1 % 400==0) {
        bLong = true;
    } else if (v1 % 100==0){
        bLong = false;
    } else if (v1 % 4==0){
        bLong = true;
    } else { 
        bLong = false;
    }
    
    if (bLong) {
        std::cout << " Long Year ! \n";
    } else {
        std::cout << " Not So Long Year ! \n";
    }
    std::cout <<std::endl;
    return bLong;
}

void SqUravn_e3(float a=1.,float b=2.,float c=-2.)
{
    float D=b*b-4*a*c;
    if(a!=0){
        if(D>=0){
            std::cout << " x1 = ";
            std::cout << (-b-sqrt(D))/2./a;
            std::cout << ", x2 = ";
            std::cout << (-b+sqrt(D))/2./a;
        } else {std::cout << "No real roots ! ";}
        
    } else {std::cout << "Not square equation! ";}
    std::cout <<std::endl;
}

bool ChetNechet_e4()
{
    int v1;
    std::cout << "Input number ";
    std::cin>>v1;
    bool bLong = false;
    if (v1 % 2==0) {
        bLong = true;
    } else { 
        bLong = false;
    }
    
    if (bLong) {
        std::cout << " Chetnoe ! \n";
    } else {
        std::cout << " NeChetnoe ! \n";
    }
    std::cout <<std::endl;
    return bLong;
}

void SquaresN_e5(int n = 10)
{
    for (int i = 1; i <= n; i++ )
    {
        std::cout << i;
        std::cout << "^2 = ";
        std::cout << i*i;
        std::cout << "\n";
    }
    std::cout <<std::endl;
}

std::string process(const std::string& input)  // Removes all characters except <space> and digits [0-9]
{
    std::string ret;
    for(int i=0; i<(int)input.size(); i++)
    {
        if(input[i]==' '||(input[i]>='0'&&input[i]<='9'))
            ret+=input[i];
    }
    std::cout <<std::endl;
    return ret;
}
float MaxInput_e6()
{
    std::string input;
    std::cout << "Input sequence:";
    std::getline(std::cin,input);
    std::stringstream ss(process(input));
    float num=0;
    float mx=0;
    do {
        if(num>mx){mx=num;}
    } while(ss >> num);
    std::cout << "Max in seq is " << mx << "\n";
    std::cout <<std::endl;
    return mx;
}


void TabSqEq_e7(float mn=-4., float mx=4.,float dl=0.5)
{
    float x=mn;
    while (x<=mx){
        std::cout << "f(\t";
        std::cout << x;
        std::cout << "\t) = \t";
        std::cout << -2.*x*x -5.*x-8.;
        std::cout << "\n";
        x+=dl;
    };
    std::cout <<std::endl;
}

int** RandMatrix()
{
    int rowCount=5,colCount=5;
    int** a = new int*[rowCount];
    for(int i = 0; i < rowCount; ++i)
    a[i] = new int[colCount];
    int mn =100,mx=0;
    for(int i = 0; i < rowCount; i++)
    {
        for(int j = 0; j < colCount; j++)
        {
             a[i][j]=rand()%31+30;
             std::cout << a[i][j];
             std::cout << "\t";
             if(a[i][j] < mn){mn=a[i][j];}
             if(a[i][j] > mx){mx=a[i][j];}
        }
        std::cout << "\n";
    }
    
    std::cout << " Max = " << mx <<"\n" ;
    std::cout << " Min = " << mn <<"\n" ;
    std::cout <<std::endl;
    
    return a;
}

int MxMatr(int** a,int rowCount=5,int colCount=5)
{
    int mx = 0;
    for(int i = 0; i < rowCount; i++)
    {
        for(int j = 0; j < colCount; j++)
        {
             if(a[i][j] > mx){mx=a[i][j];}
        }
    }
    return mx;
}
int MnMatr(int** a,int rowCount=5,int colCount=5)
{
    int mn = 100;
    for(int i = 0; i < rowCount; i++)
    {
        for(int j = 0; j < colCount; j++)
        {
             if(a[i][j] < mn){mn=a[i][j];}
        }
    }
    return mn;
}

struct student
{
    int GrNum = 0;
    std::string fam="";
    std::string Im="";
    std::string Ot="";
    int usp[5] = {1, 2, 3, 4, 5};
    float AvgMark = 0.;
    float mean(){
        float s=0;
        for(int i=0; i<5; i++){s+=usp[i];}
        AvgMark = s/5.;
        return s/5.;
    }
    std::string output() {
        return fam + " " + Im +"." + Ot + ". \t Group=" + std::to_string(GrNum) +" \t Avg.Mark=" + std::to_string(mean());
    }
};

bool stud_sorter(student const& lhs, student const& rhs) {
    return lhs.AvgMark < rhs.AvgMark;
};

struct train{
	std::string Dest="Point1";
	std::string NumP="AA1";
	std::string time="00:00";
	std::string output() {return Dest + " \t" + NumP +" \t" + time;}
};
bool NumTrain_sorter(train const& lhs, train const& rhs) {
    return lhs.NumP < rhs.NumP;
};
bool DestTrain_sorter(train const& lhs, train const& rhs) {
    if(lhs.Dest < rhs.Dest){
        return true;
    } else {
        if(lhs.Dest == rhs.Dest){
            if(lhs.time < rhs.time){return true;}
            else {return false;}
        } else {return false;}
    }
};


int main()
{

    compare_e1();
    LongYear_e2();
    SqUravn_e3();
    ChetNechet_e4();
    SquaresN_e5();
    MaxInput_e6();
    TabSqEq_e7();


    int** a = RandMatrix();
    for(int i = 0; i < 5; i++)
    {
        for(int j = 0; j < 5; j++)
        {
             std::cout << a[i][j];
             std::cout << "\t";
        }
        std::cout << "\n";
    }
    std::cout << "\n";
    std::cout << " Max = " << MxMatr(a) <<"\n" ;
    std::cout << " Min = " << MnMatr(a) <<"\n" ;

    student st1[10];
    for(int i=0;i<10;i++)
    {
        st1[i].fam = "Fam_"+std::to_string(i%10);
        st1[i].Im = "I"+std::to_string(i%2);
        st1[i].Ot = "S"+std::to_string(i%5);
        st1[i].GrNum = i%3+100;
        for(int j=0;j<5;j++) {st1[i].usp[j]=abs(rand()) % 3+3;}
        st1[i].mean();
        std::cout << st1[i].output() << std::endl;
    }
    
    std::sort(std::begin(st1), std::end(st1), &stud_sorter);
    
    bool bGoodOnly = false;
    std::cout << std::endl;
    std::cout << std::endl;
    for(int i=0;i<10;i++)
    {
        if (bGoodOnly){
            if (st1[i].mean()>=4)
            std::cout << st1[i].output() << std::endl;
        } else {std::cout << st1[i].output() << std::endl;}
    }
    
    std::cout << "End 1" <<std::endl;
    
    bGoodOnly = true;
    std::cout << std::endl;
    std::cout << std::endl;
    for(int i=0;i<10;i++)
    {
        if (bGoodOnly){
            if (st1[i].mean()>=4)
            std::cout << st1[i].output() << std::endl;
        } else {std::cout << st1[i].output() << std::endl;}
    }
    
    std::cout << "End All" <<std::endl;


    train tr1[5];
    for(int i=0;i<5;i++)
    {
        tr1[i].Dest = "Point_"+std::to_string(std::rand()%2);
        tr1[i].NumP = "A"+std::to_string(std::rand()%3);
        tr1[i].time = std::to_string(std::rand()%14+10)+":"+std::to_string(std::rand()%50+10);
        std::cout << tr1[i].output() << std::endl;
    }
    
    
    std::sort(std::begin(tr1), std::end(tr1), &NumTrain_sorter);
    std::cout << std::endl;
    for(int i=0;i<5;i++){ std::cout << tr1[i].output() << std::endl;}
    std::cout << std::endl;
    
    std::sort(std::begin(tr1), std::end(tr1), &DestTrain_sorter);
    std::cout << std::endl;
    for(int i=0;i<5;i++){ std::cout << tr1[i].output() << std::endl;}
    std::cout << std::endl;
    
    std::cout << "Input Train Num";
    std::string TrNum = "";
    std::cin>>TrNum;
    
    std::cout << std::endl;
    for(int i=0;i<5;i++){ if(tr1[i].NumP==TrNum) std::cout << tr1[i].output() << std::endl;}
    std::cout << std::endl;
    
    return 0;
    
}