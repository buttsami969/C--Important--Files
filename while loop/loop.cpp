#include<iostream> 
using namespace std;
int main()
{
	int COUNT=1, NUMBER,SUM=0;
cout<<"ENTER THE LIMIT:"<<endl;
cin>>NUMBER;
cout<<"EVEN NUMBERS FROM 1 TO\t" << NUMBER <<" ARE:"<<endl;
while(COUNT<=NUMBER)
{
 if(COUNT%2==0)
 {
 	SUM=SUM+COUNT;
 }
 COUNT++;
}
cout<<"SUM OF ALL EVEN NUMBER FROM 1 TO  " <<NUMBER <<" IS: "<<SUM<<endl;

return 0;
}

