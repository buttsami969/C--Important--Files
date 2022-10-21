// Inverted half pyramid using *
#include<iostream>
using namespace std;
int main()
{
	int Y,O,U,K,ROWS,COLUMS;
cout<<"\t\t\t\t\t\t\CLASS EXERCISE NO: 2\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t NESTED LOOP:\t\t\t\t\t\t\t"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
	cout<<"ENTER NUMBER OF ROWS:"<<endl;
	cin>>ROWS;
	cout<<"ENTER NUMBER OF COLUMS:"<<endl;
	cin>>COLUMS;
	
	for(O=1,K=ROWS;O<=COLUMS,K>=1;++O,--K)
	{
		for(U=1;U<=O;++U)
		{
			cout<<"+ ";
	     
	     }
	     for(Y=1;Y<=K;++Y)
		{
			cout<<"* ";
	     
	     }
	     
	      	cout<<"\n";
	}
	return 0;
}
