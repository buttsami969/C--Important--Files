#include<iostream>
using namespace std;
int main()
{

 int n;
 for(n=1;n<=10;n++)
 {
 	cout<<n<<'\t';
 	if(n==8)
 	{
 		cout<<"coutdown aborated";
 		break;
	 }
 }
 cout<<'\n';
 return 0;
}
