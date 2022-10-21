#include<iostream>
using namespace std;
int main()
{
	int s_1, s_2,kph,mph;
cout<<"\t\t\t\t\t\t\CLASS EXERCISE NO: 3\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t FOR LOOP:\t\t\t\t\t\t\t"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;

	const double conversion_factor=0.6214;
	const int increment=10;
	cout<<"ENTER STARTING SPEED IN KM"<<endl;
	cin>>s_1;
	cout<<"ENTER ENDING SPEED IN KM"<<endl;
	cin>>s_2;
	for(kph=s_1;kph<=s_2;kph+=increment)
	{
		mph=kph*conversion_factor;
		cout<<kph<<"\t"<<mph<<endl;
	}
	return 0;
}
