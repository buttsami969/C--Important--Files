#include<iostream>
using namespace std;
int main()
{
	int a1[10],a2[10],a3[10];
	int i,j=0,k=0,n;
	cout<<"ENTER THE NUMBERS OF ELEMENTS TO BE STORED IN THE ARRAY:"<<endl;
	cin>>n;
	cout<<"INPUT THE ELEMENT IN THE ARRAY:"<<n<<endl;
	for(i=0;i<n;i++)
	{
		cout<<"ELEMENT:"<<i<<endl;
		cin>>a1[i];
	}
		for(i=0;i<n;i++)
		{
			if(a1[i]%2==0)
		{
			a2[j]=a1[i];
			j++;
		}
		else
		{
			a3[k]=a1[i];
			k++;
		}
	}
	cout<<"THE EVEN ELEMENTS ARE:"<<j<<endl;
	for(i=0;i<j;i++)
	{
	cin>>a2[i];	
	}
	cout<<"THE odd ELEMENTS ARE:"<<k<<endl;
		for(i=0;i<k;i++)
	{
	cin>>a3[i];	
	}
return 0;
}
