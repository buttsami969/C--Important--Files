// Write a C++ program to input make of five subjectsPhysics,Chemistry,Biology,Mathematics and computer .Calculate percentage and gradeaccording to given condition using switch statements.
#include<iostream>
using namespace std;
int main()
{
 int MATH,PHYSICS,CHEMISTRY,COMPUTER,BIOLOGY,OBTAINED_MARKS;
float AVERAGE,PERCENTAGE;
cout<<"\t\t\t\t\t\t\tASSIGNMENT NO 3\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t\t LAB NO 3\t\t\t\t\t\t\t"<<endl;
 cout<<"\n"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"\n"<<endl;
cout<<"TASK NO 1.3:"<<endl;
cout<<"\n"<<endl;
cout<<"SUBJECT TOTAL MARKS IS:\n"<<"100"<<endl;
cout<<"\nTOTAL MARKS ARE:\n"<<"500"<<endl;
 cout<<"\nENTER MARKS FOR MATH:\n"<<endl;
cin>>MATH;
if(MATH>100)
{
 cout<<"MARKS MUST BE LESS THEN OR EQUAL TO 100"<<endl;
 cout<<"ENTER MATH MARKS AGAIN:"<<endl;
 cin>>MATH;
}
 cout<<"\nENTER MARKS FOR PHYSICS:\n"<<endl;
 cin>>PHYSICS;
if(PHYSICS>100)
{
 cout<<"MARKS MUST BE LESS THEN OR EQUAL TO 100"<<endl;
 cout<<"ENTER MATH MARKS AGAIN:"<<endl;
 cin>>PHYSICS;
}
 cout<<"\nENTER MARKS FOR CHEMISTRY:\n"<<endl;
 cin>>CHEMISTRY;
if(CHEMISTRY>100)
{
 cout<<"MARKS MUST BE LESS THEN OR EQUAL TO 100"<<endl;
 cout<<"ENTER MATH MARKS AGAIN:"<<endl;
 cin>>CHEMISTRY;
}
 cout<<"\nENTER MARKS FOR COMPUTER:\n"<<endl;
 cin>>COMPUTER;
if(COMPUTER>100)
{
 cout<<"MARKS MUST BE LESS THEN OR EQUAL TO 100"<<endl;
 cout<<"ENTER MATH MARKS AGAIN:"<<endl;
 cin>>COMPUTER;
}
 cout<<"\nENTER MARKS FOR BIOLOGY:\n"<<endl;
 cin>>BIOLOGY;
if(BIOLOGY>100)
{
 cout<<"MARKS MUST BE LESS THEN OR EQUAL TO 100"<<endl;
 cout<<"ENTER MATH MARKS AGAIN:"<<endl;
 cin>>BIOLOGY;
}
 OBTAINED_MARKS=MATH+PHYSICS+CHEMISTRY+COMPUTER+BIOLOGY;
 cout<<"OBTAINED MARKS ARE:\n"<<OBTAINED_MARKS<<endl;
 AVERAGE=(OBTAINED_MARKS)/5.0;
 cout<<" YOUR AVERAGE IS:"<<AVERAGE<<endl;
 PERCENTAGE=(OBTAINED_MARKS*100.0)/500.0;
 cout<<" YOUR PERCENTAGE IS:"<<PERCENTAGE<<endl;
char GRADE;
if (PERCENTAGE>=90)
{
 GRADE='A';
}

else if (PERCENTAGE>=80)
{
 GRADE='B';
}
else if (PERCENTAGE>=70)
{
 GRADE='C';

}
 else if (PERCENTAGE>=60)
{
 GRADE='D';
}
else if (PERCENTAGE>=40)
{

 GRADE='E';
}
else if(PERCENTAGE<40)
{
GRADE='F';
}
 else
{
GRADE='G';
}
 switch(GRADE)
 {
 case'A':cout<<"GRADE A"<<endl;
 cout<<"YOU ARE PASSED IN EXAM!"<<endl;
 break;
 case'B':cout<<"GRADE B"<<endl;
 cout<<"YOU ARE PASSED IN EXAM!"<<endl;
 break;
 case'C':cout<<"GRADE C"<<endl;
 cout<<"YOU ARE PASSED IN EXAM!"<<endl;
 break;
 case'D':cout<<"GRADE D"<<endl;
 cout<<"YOU ARE PASSED IN EXAM!"<<endl;
 break;
 case'E':cout<<"GRADE E"<<endl;
 cout<<"YOU ARE PASSED IN EXAM!"<<endl;

 break;
 case'F':cout<<"GRADE F"<<endl;
 cout<<"YOU ARE FAILED IN EXAM!"<<endl;
 break;
 default:cout<<"GRADE G"<<endl;
 cout<<"YOU ARE FAILED IN EXAM!"<<endl;
}
return 0;
}
