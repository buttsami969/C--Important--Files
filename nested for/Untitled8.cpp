#include<iostream>
using namespace std;
int main()
{
	int h,k,l;
cout<<"\t\t\t\t\t\tASSIGNEMNT NO :3:\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t NESTED FOR LOOP:\t\t\t\t\t\t\t"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
cout<<"TASK 1.3"<<endl;
cout<<"\n"<<endl;
cout<<"ENTER NUMBER OF LINES"<<endl;
cin>>l;

	for (h=0;h<=l;h++)
	{
		for (k=0;k<=l+l;k++)
	{
		if (k>=(l-h)&&k<=(l+h)&&((h+k==l)||(k-h==l)))
		 
		 {
			cout<<"$";
		}
		 
		else
		{
		cout<<"#";
		}
	}
	

		cout<<endl;
		
	}
	return 0;
 }
