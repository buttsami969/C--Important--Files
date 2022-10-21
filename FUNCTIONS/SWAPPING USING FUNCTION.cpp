#include<iostream>
using namespace std;

void swap(int ,int );

int main()
{

    int a,b;
cout<<"\t\t\t\t\t\t ASSIGNMENT NO :8\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t\tFUCTIONS:\t\t\t\t\t\t\t"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
cout<<"TASK1.1"<<endl;
cout<"\n";

    cout<<"Enter the Two Numbers : ";
    cin>>a>>b;
    cout<<"\nAfter Swapping of Two Numbers:";
    swap(a,b);
    
    return 0;
}
void swap(int x,int y)
{
 int z;

 
 z=x;

 x=y;

 y=z;

 cout<<"A="<<x<<" B="<<y;
 
}

