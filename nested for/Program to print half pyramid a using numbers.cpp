//Program to print half pyramid a using numbers
#include<iostream>
using namespace std;
int main()
{
	int Y,O,U;
	cout<<"ENTER NUMBER OF ROWS:"<<endl;
	cin>>Y;
	for(O=1;O<=Y;++O)
	{
		for(U=1;U<=O;++U)
		{
			cout<<U<<" ";
	     
	     }
	      	cout<<"\n";
	}
	return 0;
}
