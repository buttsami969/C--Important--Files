#include<iostream>
using namespace std;
int main()
{
int marks;
cout<<"\t\t\t\t\t\t\tASSIGNMENT NO 2\t\t\t\t\t\t\t"<<endl;
cout<<"\n"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"\n"<<endl;
cout<<"ENTER MARKS BETWEEN 0 1O 100"<<endl;
cout<<"--------------------------------"<<endl;
cout<<"\nENTER MARKS:"<<endl; 
cin>>marks;
if(marks>100)
{
cout<<"MARKS MUST BE LESS THEN OR EQUAL TO 100"<<endl;
cout<<"ENTER MARKS AGAIN:"<<endl;
cin>>marks;
}
switch(marks/10)
{
case 10:
case 9:
cout<<"GRADE A"<<endl;
 cout<<"YOU ARE PASSED IN EXAM!"<<endl;
 break;
case 8:
 cout<<"GRADE B"<<endl;
 cout<<"YOU ARE PASSED IN EXAM!"<<endl;
 break;
 case 7:
 cout<<"GRADE C"<<endl;
 cout<<"YOU ARE PASSED IN EXAM!"<<endl;
 break;
 case 6:
 cout<<"GRADE D"<<endl;
 cout<<"YOU ARE PASSED IN EXAM!"<<endl;
 break;
 case 5:
 cout<<"GRADE E"<<endl;
 cout<<"YOU ARE PASSED IN EXAM!"<<endl;
 break;
 case 4:
 cout<<"GRADE F"<<endl;
 cout<<"YOU ARE PASSED IN EXAM!"<<endl;
 break;
 default:
 cout<<"GRADE G"<<endl;
 cout<<"YOU ARE FAILED IN EXAM!"<<endl;
}
return 0;
}

