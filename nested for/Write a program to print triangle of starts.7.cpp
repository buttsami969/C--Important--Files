//Write a program to print triangle of starts.
#include<iostream>
using namespace std;
int main()
{
	int Y,O,U;
cout<<"\t\t\t\t\t\tCLASS EXERCISE NO: 1\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t NESTED LOOP:\t\t\t\t\t\t\t"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;

	cout<<"ENTER NUMBER OF ROWS:"<<endl;
	cin>>Y;
	for(O=1;O<=Y;++O)
	{
		for(U=1;U<=O;++U)
		{
			cout<<"* ";
	     
	     }
	     cout<<"\n";
	}
	return 0;
}
