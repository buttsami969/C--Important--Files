//Write a C++ program to input an alphabet and check whether it is vowel or consonant.
#include<iostream>
using namespace std;
int main()
{
char ch;
cout<<"\t\t\t\t\t\t\tASSIGNMENT NO 3\t\t\t\t\t\t\t"<<endl;
 cout<<"\t\t\t\t\t\t\t\tLAB:3\t\t\t\t\t\t"<<endl;
cout<<"\n"<<endl;
cout<<"NAME:ABDUL SAMI BUTT."<<endl;
cout<<"ROLL NO: NUML-F20-15750."<<endl;
cout<<"\n"<<endl;
cout<<"TASK # 1.2:"<<endl;
 cout<<"\n"<<endl;
cout<<"ENTER ANY ALPHABET:"<<endl;
cin>>ch;
switch(ch)

{
case'a':cout<<"IT IS A VOWEL";
break;
case'e':cout<<"IT IS A VOWEL";
break;
case'i':cout<<"IT IS A VOWEL";
break;
case'o':cout<<"IT IS A VOWEL";
break;
case'u':cout<<"IT IS A VOWEL";
break;
case'A':cout<<"IT IS A VOWEL";
break;
case'E':cout<<"IT IS A VOWEL";
break;
case'I':cout<<"IT IS A VOWEL";
break;
case'O':cout<<"IT IS A VOWEL";
break;
case'U':cout<<"IT IS A VOWEL";
break;
default: cout<<"consonant";
}
return 0;
}
