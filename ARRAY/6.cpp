#include<iostream>
using namespace std;
int main()
{
	int A[10];
	int M;
	int K= 8;
	int COUNT= 0;
cout<<"\t\t\t\t\t\t ASSIGNMENT NO :6\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t ARRAY:\t\t\t\t\t\t\t"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
cout<<"TASK1.2:"<<endl;
cout<"\n";
	for (M= 0; M < 10; M++){
		cout << "ENTER N OF THE INTEGER NUMBERS: " << endl;
		cin >> A[M];
	}
	
	cout << "ENTER THE NUMBER TO SEARCHED:" << endl;
	cin >> K;
	for (M= 0; M< 10; M++)
	{
		if (A[M] ==K)
		{
			cout << K<< " : HAS APPEARED TO THE POSITION: (" << M+ 1 << ") IN THE ARRAY:" << endl;
			COUNT++;
		}
	}
	cout << "RESULT::" <<K<< "HAS APPEARED ("<<COUNT<<") TIMES IN THE ARRAY:" << endl;
	
	return 0;
}
