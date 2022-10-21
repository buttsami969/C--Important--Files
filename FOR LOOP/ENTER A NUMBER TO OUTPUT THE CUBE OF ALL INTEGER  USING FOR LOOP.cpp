#include<iostream>
using namespace std;
int main()
{
	int M,NUMBER,CUBE;
cout<<"\t\t\t\t\t\t\CLASS EXERCISE NO: 2\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t FOR LOOP:\t\t\t\t\t\t\t"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
	cout<<"\n\n DISPLAY THE CUBE OF THE NUMBERS UPTO A GIVEN INTEGER:\n"<<endl;
	cout<<" ----------------------------------------------------"<<endl;
	cout<<" ENTER THE NUMBER OF TERMS "<<endl;
	cin>>NUMBER;
	for(M=1;M<=NUMBER;M++)
	{
		CUBE=M*M*M;
	    cout<<"NUMBER IS: "<< M <<" AND THE CUBE OF  "<< M << " IS: " << CUBE <<endl;
}
	return 0;
}
