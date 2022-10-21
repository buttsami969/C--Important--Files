#include<iostream>
using namespace std;
int result(int n)
{
	if(n%2==0)
	return 1;
	else
	return 0;
}
int main()
{
	int arr[3];
	int A;	
cout<<"\t\t\t\t\t\t ASSIGNMENT NO :7\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t\tFUCTIONS:\t\t\t\t\t\t\t"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
cout<<"TASK1.1"<<endl;
cout<"\n";
cout<<"ENTER THREE NUMBERS:"<<endl;
	for(int i=0;i<3;i++)
	{
		cin>>arr[i];
		cout<<"\n"<<endl;
		}	
	for(int i=0;i<3;i++)
	{
		A=result(arr[i]);
		if(A==1)
		cout<<" IS EVEN NUMBER:"<<arr[i]<<endl;
		else if (A==0)
		cout<<" IS ODD NUMBER:"<<arr[i]<<endl;
	}
	return 0;
}
