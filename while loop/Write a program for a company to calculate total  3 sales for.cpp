#include<iostream>
using namespace std;
int main()
{
	int sum_region_1=0,sum_region_2=0,sum_region_3=0;
cout<<"\t\t\t\t\t\t\CLASS EXERCISE NO: 3\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t NESTED LOOP:\t\t\t\t\t\t\t"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
	while(1)
	{
		int region_1;
		cout<<"ENTER FIRST REGION SALE:"<<endl;
		cin>>region_1;
		if(region_1==0)
		{
			break;
		}
		else
		{
		  sum_region_1 +=region_1;
		}
	
	}
	while(1)
	{
		int region_2;
		cout<<"ENTER SECOND REGION SALE:"<<endl;
		cin>>region_2;
		if(region_2==0)
		{
			break;
		}
		else
		{
		 sum_region_2 +=region_2;
		}
	
	}
	while(1)
	{
		int region_3;
		cout<<"ENTER THIRD REGION SALE:"<<endl;
		cin>>region_3;
		if(region_3==0)
		{
			break;
		}
		else
		{
		  sum_region_3 +=region_3;
		}
	
	}
	
	cout<<"SUM OF FIRST REGION SCALE IS :"<<sum_region_1<<endl;
	cout<<"SUM OF SECOND REGION SCALE IS :"<<sum_region_2<<endl;
	cout<<"SUM OF THIRD REGION SCALE IS :"<<sum_region_3<<endl;
	 return 0;
}

