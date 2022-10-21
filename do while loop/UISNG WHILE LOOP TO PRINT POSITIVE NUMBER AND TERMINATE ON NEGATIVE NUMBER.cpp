#include<iostream>
using namespace std;
int main()
{
	int NUMBER,sum=0;
cout<<"\t\t\t\t\t\tASSIGNMENT NO 5\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t   LAB NO 5 \t\t\t\t\t\t\t"<<endl;  
cout<<"\n"<<endl;  	
cout<<"NAME:ABDUL SAMI BUTT"<<endl;  	
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"\n"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
cout<<"TASK NO 1.2:"<<endl;  	
cout<<"\n";
	do
	
	{
	cout<<"ENTER A  POSITIVE NUMBER NUMBER \t"<<endl;
	cin>>NUMBER;
			sum=sum+NUMBER;
		}

	while(NUMBER>=0);
	cout<<"YOU INPUT A NEGATIVE NUMBER IS ="<<NUMBER<<endl;
	cout<<"SUM OF VALUE="<<sum<<endl;
	
	
	return 0;
}
