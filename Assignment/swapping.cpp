#include<iostream>
using namespace std;
int main()
{
	int a[10],A,B,C,D;
	A=B=C=D=0;
		int COUNT= 0;
cout<<"\t\t\t\t\t\t ASSIGNMENT NO :6\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t ARRAY:\t\t\t\t\t\t\t"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
cout<<"TASK1.3:"<<endl;
cout<<"\n";
	cout<<"ENTER MARKS OF TEN STUDENTS:"<<endl;
	for(int i=0;i<10;i++)
	{
		cin>>a[i];
		if(a[i]>=80)
		{
			cout<<"THE GRADE OF THE STUDENTS IS A"<<endl;
			A++;
		}
	else if(a[i]>60)
		{
			cout<<"THE GRADE OF THE STUDENTS IS B"<<endl;
			B++;
		}
	 else if(a[i]>40)
		{
			cout<<"THE GRADE OF THE STUDENTS IS C"<<endl;
			C++;
		}
	else 
		{
			cout<<"THE GRADE OF THE STUDENTS IS F"<<endl;
			D++;
		}

	
	}
	return 0;
}

