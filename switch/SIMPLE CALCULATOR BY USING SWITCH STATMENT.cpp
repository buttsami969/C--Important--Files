//Write a program to make a simple calculator by using switch statement
#include<iostream>
using namespace std;
int main()
{
char OPERATOR;
float NUM1,NUM2;
cout<<"\t\t\t\t\t\tASSIGNMENT NO 3\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t LAB NO 3 \t\t\t\t\t\t\t"<<endl;
cout<<"\n"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"\n"<<endl;
cout<<"TASK NO 1.3:"<<endl;
cout<<"\n";
cout<<"SIMPLE CALCULATOR"<<endl;
cout<<"--------------------------"<<endl;
cout<<"\n"<<endl;
cout<<"ENTER AN OPERATOR(+,-,*,/):"<<endl;
 cin>>OPERATOR;
 cout<<"ENTER TWO OPERANDS:"<<endl;
 cin>>NUM1>>NUM2;
switch(OPERATOR)
{
case'+':;
cout<<NUM1<<"+"<<"="<<NUM1+NUM2<<endl;
break;
case'-':;
cout<<NUM1<<"-"<<"="<<NUM1-NUM2<<endl;
break;
case'*':;
cout<<NUM1<<"*"<<"="<<NUM1*NUM2<<endl;
break;
case'/':;
cout<<NUM1<<"+"<<"="<<NUM1/NUM2<<endl;
break;
default:
cout<<"ERROR! YOU INPUT A WRONG OPERATOR"<<endl;
}
return 0;
}
