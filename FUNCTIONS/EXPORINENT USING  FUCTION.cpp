#include<iostream>
using namespace std;
#include<math.h>
int POWER(int &B,int &E)
{
int J;
cout<<"\t\t\t\t\t\t ASSIGNMENT NO :8\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t\tFUCTIONS:\t\t\t\t\t\t\t"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
cout<<"TASK1.3"<<endl;
cout<"\n";

J=pow(B,E);
return J;
}
int main()
{
	int B,E,RESULT;
	cout<<"ENTER THE NUMBER:"<<endl;
	cin>>B;
	cout<<"ENTER THE EXPOINTENT NUMBER:"<<endl;
	cin>>E;
	RESULT=POWER(B,E);
	cout<<" CALCULATION= "<<RESULT<<endl;
	return 0;
}

