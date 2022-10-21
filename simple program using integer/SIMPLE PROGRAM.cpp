#include<iostream>
using namespace std;
int main()
{
int second,minutes,hours,days,years,century;
cout<<"\t\t\t\t\t\t\CLASS EXERCISE NO:7\t\t\t\t\t\t\t"<<endl;
cout<<"\n"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"\n"<<endl;
cout<<"PLEASE ENTER SECOND:"<<endl;
cin>>second;
cout<<"--------------------"<<endl;
minutes=second/60;
hours=minutes/60;
days=hours/24;
years=days/365;
cout<<"YEARS:"<<years<<"\n"<<"DAYS:"<<days<<"\n"<<"HOURS:"<<hours<<"\n"<<"MINUTES:"<<minutes<<endl;
return 0;
}
