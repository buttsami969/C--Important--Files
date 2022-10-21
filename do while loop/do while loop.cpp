#include<iostream>
using namespace std;
int main()
{
	int num;
	int sum=0;
	do
	{
			cout<<"ENTER A NUMBER";
	        cin>>num;
	        sum=num+sum;
	}
	while(num!=0);
	cout<<"TOTAL SUM ="<<sum;
	return 0;
}
