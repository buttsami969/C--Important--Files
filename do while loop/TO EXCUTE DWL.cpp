#include<iostream>
using namespace std;
int main()
{
	int NUM=1,L,W,AREA,PERIMETER,DIAGONAL; 
cout<<"\t\t\t\t\t\tASSIGNMENT NO 5\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t   LAB NO 5 \t\t\t\t\t\t\t"<<endl; 
cout<<"\t\t\t\t\t\t  PART NO 2:\t\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t DO WHILE LOOP:\t\t\t\t\t\t\t\t\n"<<endl;
cout<<"\n"<<endl;  	
cout<<"NAME:ABDUL SAMI BUTT"<<endl;  	
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"\n"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
cout<<"TASK NO 1.4:"<<endl;  	
cout<<"\n";
	do
	{
	cout<<"ENTER THE LENGTH:"<<endl;
	cin>>L;
	cout<<"ENTER THE WIDTH:"<<endl;
	cin>>W;
	      AREA=L*W;
	      PERIMETER=2*(L+W);
	      DIAGONAL=L+W;
	      ++NUM;
	}
	while(NUM<=5);
	
	cout<<"THE AREA IS ="<<AREA<<"\n"<<endl;
	cout<<"THE PERIMETER IS ="<<PERIMETER<<"\n"<<endl;
	cout<<"THE DIAGNOL IS="<<DIAGONAL<<"\n"<<endl;

	return 0;
}

