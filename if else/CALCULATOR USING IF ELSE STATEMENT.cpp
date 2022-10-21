#include<iostream>
using namespace std;
int main()
{
	char x;
	int num1, num2;

while (true)
{
	cout<<"\t\t\t\t\t\t\tQUIZ NO 1\t\t\t\t\t\t\t"<<endl;
	cout<<"NAME:ABDUL SAMI BUTT."<<endl;
	cout<<"ROLL NO : NUML-F20-15750."<<endl;
	cout<<"\n"<<endl;
cout << "Enter number one" << endl;
cin >> num1;

cout << "Enter number two" << endl;
cin >> num2;

cout << "Press A for ADDITION" << endl;
cout << "Press B for SUBTRACTION" << endl;
cout << "Press C for DIVISION" << endl;
cout << "Press D for MULTIPLICATION" << endl;
cout << "Press E for REMAINDER" << endl;
cin>>x;
if (x == 'A')
cout << "The sum = " << num1 + num2 << endl;

else if (x == 'B')
cout << "The SUBTRACTION = " << num1 - num2 << endl;

else if (x == 'C')
	cout << "The DIVISION = " << num1 / num2 << endl;

else if (x == 'D')
cout << "The MULTIPLICATION = " << num1 * num2 << endl;

else if (x == 'E')
cout << "The REMAINDER = " << num1 % num2 << endl;

else
cout << "INVALID OPERATION" << endl;

}


return 0;

}
