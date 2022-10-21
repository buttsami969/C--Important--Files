 //Write a program in C++ to print the sum of even numbers from 1 to n(input the number n)
#include<iostream> 
using namespace std;
int main()
{
	int COUNT, NUMBER,SUM=0;
cout<<"\t\t\t\t\t\tASSIGNMENT NO 4\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t   LAB NO 4 \t\t\t\t\t\t\t"<<endl;  
cout<<"\n"<<endl;  	
cout<<"NAME:ABDUL SAMI BUTT"<<endl;  	
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"\n"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
cout<<"TASK NO 1.2:"<<endl;  	
cout<<"\n";
cout<<"ENTER THE LIMIT:"<<endl;
cin>>NUMBER;
cout<<"EVEN NUMBERS FROM 1 TO\t" << NUMBER <<" ARE:"<<endl;
for(COUNT=1;COUNT<=NUMBER;COUNT++)
{
 cout<<2*COUNT<<" "<<endl;
 SUM+=2*COUNT;

}
cout<<"SUM OF ALL EVEN NUMBER FROM 1 TO  " <<NUMBER <<" IS: "<<SUM<<endl;

return 0;
}

