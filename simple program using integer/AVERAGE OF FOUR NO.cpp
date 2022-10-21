//write a program to compute the total and average of four numbers.
#include<iostream>
using namespace std;
int main()
{
float n1,n2,n3,n4,TOTAL,AVERAGE;
 cout<<"\t\t\t\t\t\t\tASSIGNMENT NO 1\t\t\t\t\t\t\t"<<endl;
cout<<"\n"<<endl;
cout<<"NAME:ABDUL SAMI BUTT."<<endl;
cout<<"ROLL NO: NUML-F20-15750."<<endl;
cout<<"\n"<<endl;
cout<<"TASK # 1.3:"<<endl;
cout<<"\n"<<endl;
cout<<"COMPUTE THE TOTAL AND AVERAGE OF FOUR NUMBERS:\n";
cout<<"--------------------------------------------------\n";
cout<<"INPUT FIRST TWO NUMBERS (SEPERATED BY SPACE): ";
cin>> n1 >> n2;
cout<<"INPUT last TWO NUMBERS (SEPERATED BY SPACE): ";
cin>> n3 >> n4;
 TOTAL=n1+n2+n3+n4;
AVERAGE=TOTAL/4;

 cout<<"THE TOTAL OF Four NUMBERS IS : "<<TOTAL<<endl;
cout<<"THE AVERAGE OF Four NUMBERS IS : "<<AVERAGE<<endl;
cout<<endl;
return 0;
}

