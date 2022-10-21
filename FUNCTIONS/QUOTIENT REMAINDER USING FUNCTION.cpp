#include<iostream>
using namespace std;
int data(int &j,int &k)
{
cout<<"\t\t\t\t\t\t ASSIGNMENT NO :8\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t\tFUCTIONS:\t\t\t\t\t\t\t"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
cout<<"TASK1.2"<<endl;
cout<"\n";

 	cout<<"ENTER DIVIDEND:"<<endl;
 	cin>>j;
 	cout<<"ENTER DIVISOR: "<<endl;
 	cin>>k;
 	return 0;
 }
 void divide(int &j,int &k,int &quotient,int &remindar)
 {
 
 	quotient=j/k;
 	remindar=j%k;
 }
 
 
 void print(int j,int k,int quotient,int remindar )
 {
 	cout<<"FIRST NUMBER = "<<j<<endl;
 	cout<<"SECOND NUMBER =  "<<k<<endl;
 	cout<<"QUOTIENT  ="<<quotient<<endl;
 	cout<<"REMAINDER="<<remindar<<endl;
 	
 }
  int main()
{
 	int l,m,remindar,quotient;

 	  data(l,m);
 	  divide(l,m,quotient,remindar);
 	  print(l,m,quotient,remindar);
 	 return 0;
 }

