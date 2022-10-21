#include<iostream>
using namespace std;
int main()
{
cout<<"\t\t\t\t\t\tASSIGNMENT NO 5\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t   LAB NO 5 \t\t\t\t\t\t\t"<<endl; 
cout<<"\t\t\t\t\t\t  PART NO 2:\t\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t  WHILE LOOP:\t\t\t\t\t\t\t\t\n"<<endl;
cout<<"\n"<<endl;  	
cout<<"NAME:ABDUL SAMI BUTT"<<endl;  	
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"\n"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
cout<<"TASK NO 1.3:"<<endl;  	
cout<<"\n";
cout <<"THIS PROGRAM TO CALCULATE THE SUM OF NUMBERS FROM FIRST TO THE NUMBER YOU HAVE GIVEN:\n"<<endl;
cout<<"--------------------------------------------------------------------------------------"<<endl;
int SUM= 0, NUMBER, K= 1;
cout << "ENTER A NUMBER : ";
cin >> NUMBER;
cout<<"\n"<<endl;
	while (K <=NUMBER)
	{
		
		SUM+=K;
		K+=1;
		
	} 
	cout << "THE SUM OF FIRST NUMBER " << NUMBER << " POSITIVE NUMBERS IS :\n\n 1 + 2 + 3 + 4 + 5 .... + " << NUMBER << " = " << SUM <<endl;
	return 0;
}
