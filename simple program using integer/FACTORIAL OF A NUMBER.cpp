#include<iostream>
using namespace std;
int main()
{
	int M,N,FACTORIAL=1;
	cout<<"ENTER A NUMBER"<<endl;
	cin>>N;
	for(M=1;M<=N;++M)
	{
		FACTORIAL*=M;
	}
cout<<"FACTORIAL OF "<<N<< " = "<<FACTORIAL<<endl;
return 0;
}
