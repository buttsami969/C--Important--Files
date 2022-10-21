#include <iostream>
using namespace std;

int main()
{
    int arr[10],i,n;

cout<<"\t\t\t\t\t\t ASSIGNMENT NO :6\t\t\t\t\t\t\t"<<endl;
cout<<"\t\t\t\t\t\t\tARRAY:\t\t\t\t\t\t\t"<<endl;
cout<<"NAME:ABDUL SAMI BUTT"<<endl;
cout<<"ROLL NO:NUML-F20-15750"<<endl;
cout<<"BS-CS-160"<<endl;
cout<<"\n"<<endl;
cout<<"TASK1.1"<<endl;
cout<"\n";
cout << "ENTER TOTAL NUMBER OF ELEMENTS(1 to 10): ";
cin >>n;
cout<<endl;
   
    for(i = 0; i < n; ++i)
    {
       cout << "ENTER NUMBER " << i + 1 << " : ";
       cin >> arr[i];
    }

    for(i = 1;i < n; ++i)
    {
    
       if(arr[0] < arr[i])
           arr[0] = arr[i];
    }
    cout << "LAGREST ELEMENTS= " << arr[0];

    return 0;
}
