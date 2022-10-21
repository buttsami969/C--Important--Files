 
#include <iostream>
using namespace std;
int main()
{
	int NUM, K, P = 0, N = 0;

cout<<"\t\t\t\t\t\tASSIGNMENT NO 4\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t   LAB NO 4 \t\t\t\t\t\t\t"<<endl;  	cout<<"\n"<<endl;  	
cout<<"NAME:ABDUL SAMI BUTT"<<endl;  	
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"\n"<<endl;
cout<<"TASK NO 1.1:"<<endl;  	
cout<<"\n";
for (K = 0; K < 10; K++)
	{
		cout << "ENTER 10 NUMBERS:" << endl;
		cin >>NUM;
		if (NUM> 0)
		{
			P++;
		}
		else
		{
			N++;
		}
	}
	cout << "YOUR POSITIVE NUMBERS ARE" <<P<< endl;
	cout << "YOUR NEGATIVE NUMBERS ARE" <<N<<endl;

	return 0;
} 

