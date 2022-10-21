#include<iostream>
using namespace std;
int maximumvalue(int a,int b,int c)
{
	if(a>b)
	{
		if(a>c) 
		return a;
		else
		return c;
	}
	else if(b>c)
    return b;
    else
    return c;
}
int minimumvalue(int a,int b,int c)
{
	
	if(a<b)
	{
	
		if(a<c) 
		return a;
		else
		return c;
	}
	else if(b<c)
    return b;
    else
    return c;
}


int main()
{
	int a,b,c;
cout<<"\t\t\t\t\t\t ASSIGNMENT NO :6\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t\tARRAY:\t\t\t\t\t\t\t"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
cout<<"TASK 1.2"<<endl;
cout<"\n";
cout<<"ENTER THREE NUMBERS:"<<endl;
cin>>a>>b>>c;
cout<<"MAXIMUM VALUE IS:"<<maximumvalue(a,b,c)<<endl;
cout<<"MINIMUM VALUE IS:"<<minimumvalue(a,b,c)<<endl;
	return 0;
}
