#include<iostream>
using namespace std;
int main()
{
	int M,N,FACTORIAL=1;
cout<<"\t\t\t\t\t\t\CLASS EXERCISE NO:1\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t FOR LOOP:\t\t\t\t\t\t\t"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
	cout<<"ENTER A NUMBER"<<endl;
	cin>>N;
	for(M=1;M<=N;++M)
	{
		FACTORIAL*=M;
	}
cout<<"FACTORIAL OF "<<N<< " = "<<FACTORIAL<<endl;
return 0;
}
