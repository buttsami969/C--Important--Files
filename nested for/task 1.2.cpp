#include<iostream>
using namespace std;
int main()
{
	int h,k,l;
cout<<"\t\t\t\t\t\t ASSIGNMENT NO :3\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\tNESTED FOR LOOP:\t\t\t\t\t\t\t"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
cout<<"TASK1.2"<<endl;
cout<<"\n"<<endl;
cout<<"ENTER NUMBER OF LINES:";
cin>>l;
	for (h=0;h<l;h++)
	{
		for(k=0;k<l;k++)
		{
			if(h>=k)
			{
				
				if((k+h)%2==0)
				{
						cout<<"*";
				}
			
			else
			{
				cout<<"#";
			}
		}
	
		}
			cout<<endl;
	}
		return 0 ;
	}



