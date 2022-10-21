//Write a C++ program, If the variable divisor is not zero, divide the variable dividend bydivisor, and store the result in quotient.
#include<iostream>
using namespace std;
int main()
{
int dividend,divisor,quotient;
cout<<"\t\t\t\t\t\t\tASSIGNMENT NO 2\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t\t\tLAB:2\t\t\t\t\t\t"<<endl;
cout<<"\n"<<endl;
cout<<"NAME:ABDUL SAMI BUTT."<<endl;
cout<<"ROLL NO: NUML-F20-15750."<<endl;
cout<<"\n"<<endl;
cout<<"TASK # 1.2:"<<endl;
cout<<"\n"<<endl;
cout<<"ENTER A DIVIDEND:"<<endl;
cin>>dividend;
cout<<"ENTER A DIVISOR:"<<endl;
cin>>divisor;
quotient=dividend/divisor;
if(divisor= 0)
{
cout<<"QUOTIENT="<<quotient<<endl;
}
else if (divisor==0)
quotient = divisor;
cout<<"QUOTIENT="<<quotient<<"\nDIVISOR"<<divisor<<"\nDIVIDEND"<<dividend<<endl;
return 0;
}
