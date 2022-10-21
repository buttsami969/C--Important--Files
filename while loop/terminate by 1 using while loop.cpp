#include<iostream>
using namespace std;
int main()
{
	
	int num=1,count=0;
cout<<"\t\t\t\t\t\t\CLASS EXERCISE NO: 2\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t WHILE LOOP:\t\t\t\t\t\t\t"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
	cout<<"ENTER A NUMBER,1 to terminate"<<endl;
	cin>>num;
	while(num!=1)
	{
		cout<<"ENTER A NUMBER"<<endl;
		cin>>num;
		count++;
	}
	cout<<"PROGRAM ENDED:"<<endl;
	cout<<"Total Value enter by the user:"<<count++<<endl;
	return 0;
}


