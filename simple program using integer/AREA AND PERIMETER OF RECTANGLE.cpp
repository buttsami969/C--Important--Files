//WRITE A PROGRAM IN c++ TO FIND THE AREA AND PERIMETER OF A RECTANGLE.
#include<iostream>
using namespace std;
int main()
{
 int WIDTH,LENGTH,AREA,PERIMETER;

 cout<<"\t\t\t\t\t\t\tASSIGNMENT NO 1\t\t\t\t\t\t\t"<<endl;
 cout<<"\n"<<endl;
 cout<<"NAME:ABDUL SAMI BUTT."<<endl;
 cout<<"ROLL NO: NUML-F20-15750."<<endl;
cout<<"\n"<<endl;
cout<<"TASK # 1.4:"<<endl;
 cout<<"\n"<<endl;
 cout<<"\n\nFIND THE AREA AND PERIMETER OF A RECTANGLE:\n";
 cout<<"-------------------------------------------------\n";

 cout<<"INPUT THE LENGTH OF THE RECTANGLE:";
 cin>>LENGTH;
 cout<<"INPUT THE AREA OF THE RECTANGLE:";
 cin>>WIDTH;
 AREA=(LENGTH*WIDTH);
 PERIMETER=2*(LENGTH+WIDTH);
 cout<<"THE AREA OF THE RECTANGLE IS:"<<AREA<<endl;
 cout<<"THE PERIMETER OF THE RECTANGLE IS:"<<PERIMETER<<endl;
 cout<<endl;
 return 0;
 }

