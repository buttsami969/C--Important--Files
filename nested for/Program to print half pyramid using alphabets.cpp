//Program to print half pyramid using alphabets
#include<iostream>
using namespace std;
int main()
{
	 char Y,O,U,ALPHABET='A';
	cout<<"ENTER UPPERCASE LETTER:"<<endl;
	cin>>Y;
	for(O=1;O<=Y-'A'+1;++O)
	{
		for(U=1;U<=O;++U)
		{
			cout<<ALPHABET<<" ";
	     
	     }
	     ++ALPHABET;
	      	cout<<"\n";
	}
	return 0;
}
