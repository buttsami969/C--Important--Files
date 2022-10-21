#include<iostream>
using namespace std;
int main()
{
	char user;
	cout<<"\t\t\t\t\t\t\tASSIGNMENT NO 1\t\t\t\t\t\t\t"<<endl;
	cout<<"NAME:ABDUL SAMI BUTT."<<endl;
	cout<<"ROLL NO : NUML-F20-15750."<<endl;
	cout<<"\n"<<endl;
	cout << "ENTER V FOR VISITOR." << endl;
	cout << "ENTER U FOR UNIVERSITY. " << endl;
	cin >> user;
	if (user == 'V')
	{

		cout << "ENTER M FOR MALE. " << endl;
		cout << "ENTER F FOR FEMALE.  " << endl;
		cin >> user;
		if (user == 'M')
		 {

			cout << " WELCOME YOU ARE A MALE VISITOR." << endl;
		 }
		else
		if (user == 'F')
		{
			cout << " WELCOME YOU ARE A FEMALE VISITOR." << endl;
		}
	}
	else
	if (user == 'U')
	{
		cout << "ENTER S FOR STUDENTS." << endl;
		cout << "ENTER F FOR FACULTY." << endl;
		cout << "ENTER T STAFF." << endl;
		cin >> user;
		if (user == 'S')
		{

		cout << "ENTER M FOR MALE. " << endl;
		cout << "ENTER F FOR FEMALE.  " << endl;
		cin >> user;
		if (user == 'M')
		 {
         cout << "WELCOME YOU ARE A MALE VISITOR." << endl;
		 }
		else
		if (user == 'F')
		{
		cout << "WELCOME YOU ARE A FEMALE VISITOR." << endl;
		}
	if (user == 'M')
			{
				cout << "M FOR MASTER. " << endl;
				cout << "G FOR GRADUATE." << endl;
				cin >> user;

				if (user == 'M')
				{
					cout << "ENTER C FOR COMPUTER SCIENCE." << endl;
					cout << "ENTER E FOR ENGINEERING." << endl;
					cout << "ENTER B FOR BUSINESS ADMINISTRATOR." << endl;
					cin >> user;
					if (user == 'C')
					{
						cout << "MASTER IN COMPUTER SCIENCE." << endl;
					}
					else
					if (user == 'E')
					{
						cout << "MASTER IN ELECTRICAL ENGINEERING." << endl;
					}
					else
					if (user == 'B')

					{
						cout << "MASTER IN BUSINESS ADMINISTRATOR." << endl;
					}
					
				}
				else
				if(user=='G')
				{
					
					cout <<"ENTER C FOR COMPUTER SCIENCE." << endl;
					cout << "ENTER E FOR ENGINEERING." << endl;
					cout << "ENTER B FOR BUSINESS ADMINISTRATOR." << endl;
					cin >> user;
					if (user == 'C')
					{
						cout << "GRADUATE IN COMPUTER SCIENCE." << endl;
					}
					else
					if (user == 'E')
					{
						cout << "GRADUATE IN ELECTRICAL ENGINEERING." << endl;
					}
					else
					if (user == 'B')

					{
						cout << "GRADUATE IN BUSINESS ADMINISTRATOR." << endl;
					}
					
				}
				
			}
			
				if (user == 'F')
			{
				cout << "M FOR MASTER. " << endl;
				cout << "G FOR GRADUATE." << endl;
				cin >> user;

				if (user == 'M')
				{
					cout << "ENTER C FOR COMPUTER SCIENCE." << endl;
					cout << "ENTER E FOR ENGINEERING." << endl;
					cout << "ENTER B FOR BUSINESS ADMINISTRATOR." << endl;
					cin >> user;
					if (user == 'C')
					{
						cout << "MASTER IN COMPUTER SCIENCE." << endl;
					}
					else
					if (user == 'E')
					{
						cout << "MASTER IN ELECTRICAL ENGINEERING." << endl;
					}
					else
					if (user == 'B')

					{
						cout << "MASTER IN BUSINESS ADMINISTRATOR." << endl;
					}
			}
			else
			if(user=='G')
			{
			    	cout <<"ENTER C FOR COMPUTER SCIENCE." << endl;
					cout << "ENTER E FOR ENGINEERING." << endl;
					cout << "ENTER B FOR BUSINESS ADMINISTRATOR." << endl;
					cin >> user;
					if (user == 'C')
					{
						cout << "GRADUATE IN COMPUTER SCIENCE." << endl;
					}
					else
					if (user == 'E')
					{
						cout << "GRADUATE IN ELECTRICAL ENGINEERING." << endl;
					}
					else
					if (user == 'B')

					{
						cout << "GRADUATE IN BUSINESS ADMINISTRATOR." << endl;
					}
			    }
			
		}	
		
		}
		else
		if (user == 'F')
		{
			cout << "ENTER P FOR PERMANENT." << endl;
			cout << "ENTER V FOR VISITOR." << endl;
			cin >> user;
			if (user == 'P')
			{
				cout << "ENTER M FOR MALE." << endl;
				cout << "ENTER F FOR FEMALE." << endl;
				cin >> user;
				if (user == 'M')
				{
					cout << "M FOR MASTER. " << endl;
					cout << "G FOR GRADUATION." << endl;
					cin >> user;

					if (user == 'M')
					{
						cout << "ENTER C FOR COMPUTER SCIENCE." << endl;
						cout << "ENTER E FOR ENGINEERING." << endl;
						cout << "ENTER B FOR BUSINESS ADMINISTRATOR." << endl;
						cin >> user;
						if (user == 'C')
						{
							cout << "MASTER IN COMPUTER SCIENCE." << endl;
						}
						else
						if (user == 'E')
						{
							cout << "MASTER IN ELECTRICAL ENGINEERING." << endl;
						}
						else
						if (user == 'B')

						{
							cout << "MASTER IN BUSINESS ADMINISTRATOR." << endl;
						}
						if (user == 'F')
						{
							cout << "ENTER C FOR COMPUTER SCIENCE. " << endl;
							cout << "ENTER E FOR ELECTRICAL ENGINEERING." << endl;
							cout << "ENTER B FOR BUSINESS ADMINSTRATOR.   " << endl;
							cin >> user;
							if (user == 'C')
							{
								cout << "MASTER IN COMPUTER SCIENCE." << endl;
							}
							else
							if (user == 'E')
							{
								cout << "MASTER IN ELECTRICAL ENGINEERING" << endl;
							}
							else
							if (user == 'B')

							{
								cout << "MASTER IN BUSINESS ADMINISTRATOR." << endl;
							}
						}
						else
						if (user == 'G')
						{
							cout << "ENTER C FOR COMPUTER SCIENCE." << endl;
							cout << "ENTER E FOR ELECTRICAL ENGINEERING" << endl;
							cout << "ENTER B FOR BUSINESS ADMINSTRATOR" << endl;
							if (user == 'C')
							{
								cout << "GRADUATION IN COMPUTER SCIENCE." << endl;
							}
							else
							if (user == 'E')
							{
								cout << "GRADUATION IN ELECTRICAL ENGINEERING." << endl;
							}
							else
							if (user == 'B')

							{
								cout << "GRADUATION IN BUSINESS ADMINISTRATOR." << endl;
							}

						}

					}
					
				}
				else
				if (user == 'F')
				{

					cout << "ENTER C FOR COMPUTER SCIENCE." << endl;
					cout << "ENTER E FOR ELECTRICAL ENIGEERING. " << endl;
					cout << "ENTER B FOR BUSINESS ADMINISTRATOR. " << endl;
					cin >> user;
					if (user == 'C')
					{
						cout << "MASTER IN COMPUTER SCIENCE" << endl;
					}
					else
					if (user == 'E')
					{
						cout << "MASTER IN ELECTRICAL ENGINEERING." << endl;
					}
					else
					if (user == 'B')

					{
						cout << "MASTER IN  BUSINESS ADMINISTRATOR." << endl;
					}
					if (user == 'M')
					{
						cout << "ENTER C FOR COMPUTER SCIENCE." << endl;
						cout << "ENTER E FOR ELECTRICAL ENGINEERING." << endl;
						cout << "ENTER B FOR BUSINESS ADMINSTRATOR " << endl;
						cin >> user;
						if (user == 'C')
						{
							cout << "MASTER IN  COMPUTER SCIENCE." << endl;
						}
						else
						if (user == 'E')
						{
							cout << "MASTER IN ELECTRICAL ENGINEERING." << endl;
						}
						else
						if (user == 'B')

						{
							cout << "MASTER IN BUSINESS ADMINISTRATOR" << endl;
						}
					}
					else
					if (user == 'G')
					{
						cout << "ENTER C FOR COMPUTER SCIENCE." << endl;
						cout << "ENTER E FOR ELECTRICAL ENGINEERING." << endl;
						cout << "ENTER B FOR BUSINESS ADMISINTRATOR. " << endl;
						cin >> user;
						if (user == 'C')
						{
							cout << "GRADUATION IN  COMPUTER SCIENCE." << endl;
						}
						else
						if (user == 'E')
						{
							cout << "GRADUATION IN ELECTRICAL ENGINEERING." << endl;
						}
						else
						if (user == 'B')

						{
							cout << "GRADUATION IN BUSINESS ADMINISTRATOR." << endl;
						}

					}

				}

			}
			else
			if(user=='V')
			{
					cout << "ENTER M FOR MALE." << endl;
				cout << "ENTER F FOR FEMALE." << endl;
				cin >> user;
				if (user == 'M')
				{
					cout << "M FOR MASTER. " << endl;
					cout << "G FOR GRADUATION." << endl;
					cin >> user;

					if (user == 'M')
					{
						cout << "ENTER C FOR COMPUTER SCIENCE." << endl;
						cout << "ENTER E FOR ENGINEERING." << endl;
						cout << "ENTER B FOR BUSINESS ADMINISTRATOR." << endl;
						cin >> user;
						if (user == 'C')
						{
							cout << "MASTER IN COMPUTER SCIENCE." << endl;
						}
						else
						if (user == 'E')
						{
							cout << "MASTER IN ELECTRICAL ENGINEERING." << endl;
						}
						else
						if (user == 'B')

						{
							cout << "MASTER IN BUSINESS ADMINISTRATOR." << endl;
						}
						if (user == 'F')
						{
							cout << "ENTER C FOR COMPUTER SCIENCE. " << endl;
							cout << "ENTER E FOR ELECTRICAL ENGINEERING." << endl;
							cout << "ENTER B FOR BUSINESS ADMINSTRATOR.   " << endl;
							cin >> user;
							if (user == 'C')
							{
								cout << "MASTER IN COMPUTER SCIENCE." << endl;
							}
							else
							if (user == 'E')
							{
								cout << "MASTER IN ELECTRICAL ENGINEERING" << endl;
							}
							else
							if (user == 'B')

							{
								cout << "MASTER IN BUSINESS ADMINISTRATOR." << endl;
							}
						}
						else
						if (user == 'G')
						{
							cout << "ENTER C FOR COMPUTER SCIENCE." << endl;
							cout << "ENTER E FOR ELECTRICAL ENGINEERING" << endl;
							cout << "ENTER B FOR BUSINESS ADMINSTRATOR" << endl;
							if (user == 'C')
							{
								cout << "GRADUATION IN COMPUTER SCIENCE." << endl;
							}
							else
							if (user == 'E')
							{
								cout << "GRADUATION IN ELECTRICAL ENGINEERING." << endl;
							}
							else
							if (user == 'B')

							{
								cout << "GRADUATION IN BUSINESS ADMINISTRATOR." << endl;
							}

						}

					}
					
				}
				else
				if (user == 'F')
				{

					cout << "ENTER C FOR COMPUTER SCIENCE." << endl;
					cout << "ENTER E FOR ELECTRICAL ENIGEERING. " << endl;
					cout << "ENTER B FOR BUSINESS ADMINISTRATOR. " << endl;
					cin >> user;
					if (user == 'C')
					{
						cout << "MASTER IN COMPUTER SCIENCE" << endl;
					}
					else
					if (user == 'E')
					{
						cout << "MASTER IN ELECTRICAL ENGINEERING." << endl;
					}
					else
					if (user == 'B')

					{
						cout << "MASTER IN  BUSINESS ADMINISTRATOR." << endl;
					}
					if (user == 'M')
					{
						cout << "ENTER C FOR COMPUTER SCIENCE." << endl;
						cout << "ENTER E FOR ELECTRICAL ENGINEERING." << endl;
						cout << "ENTER B FOR BUSINESS ADMINSTRATOR " << endl;
						cin >> user;
						if (user == 'C')
						{
							cout << "MASTER IN  COMPUTER SCIENCE." << endl;
						}
						else
						if (user == 'E')
						{
							cout << "MASTER IN ELECTRICAL ENGINEERING." << endl;
						}
						else
						if (user == 'B')

						{
							cout << "MASTER IN BUSINESS ADMINISTRATOR" << endl;
						}
					}
					else
					if (user == 'G')
					{
						cout << "ENTER C FOR COMPUTER SCIENCE." << endl;
						cout << "ENTER E FOR ELECTRICAL ENGINEERING." << endl;
						cout << "ENTER B FOR BUSINESS ADMISINTRATOR. " << endl;
						cin >> user;
						if (user == 'C')
						{
							cout << "GRADUATION IN  COMPUTER SCIENCE." << endl;
						}
						else
						if (user == 'E')
						{
							cout << "GRADUATION IN ELECTRICAL ENGINEERING." << endl;
						}
						else
						if (user == 'B')

						{
							cout << "GRADUATION IN BUSINESS ADMINISTRATOR." << endl;
						}

					}

				}

			}
			
		}
		else
		if (user == 'T')
		{
			cout << "ENTER M for MAINTENANCE." << endl;
			cout << "ENTER A for ADMINISTATION." << endl;
			cout << "ENTER H for ACCOUNT." << endl;
			cout << "ENTER D for ACADEMICS." << endl;
			cin >> user;
			if (user == 'D')
			{
				cout << "ENTER C FOR CENTRAL." << endl;
				cout << "ENTER A FOR DEPARTMENT ACADEMICS." << endl;
				cin >> user;
				if (user == 'A')
				{

		cout << "ENTER M FOR MALE. " << endl;
		cout << "ENTER F FOR FEMALE.  " << endl;
		cin >> user;
		if (user == 'M')
		 {
         cout << "WELCOME YOU ARE A MALE VISITOR." << endl;
		 }
		else
		if (user == 'F')
		{
		cout << "WELCOME YOU ARE A FEMALE VISITOR." << endl;
		}
	if (user == 'M')
			{
				cout << "M FOR MASTER. " << endl;
				cout << "G FOR GRADUATE." << endl;
				cin >> user;

				if (user == 'M')
				{
					cout << "ENTER C FOR COMPUTER SCIENCE." << endl;
					cout << "ENTER E FOR ENGINEERING." << endl;
					cout << "ENTER B FOR BUSINESS ADMINISTRATOR." << endl;
					cin >> user;
					if (user == 'C')
					{
						cout << "MASTER IN COMPUTER SCIENCE." << endl;
					}
					else
					if (user == 'E')
					{
						cout << "MASTER IN ELECTRICAL ENGINEERING." << endl;
					}
					else
					if (user == 'B')

					{
						cout << "MASTER IN BUSINESS ADMINISTRATOR." << endl;
					}
					
				}
				else
				if(user=='G')
				{
					
					cout <<"ENTER C FOR COMPUTER SCIENCE." << endl;
					cout << "ENTER E FOR ENGINEERING." << endl;
					cout << "ENTER B FOR BUSINESS ADMINISTRATOR." << endl;
					cin >> user;
					if (user == 'C')
					{
						cout << "GRADUATE IN COMPUTER SCIENCE." << endl;
					}
					else
					if (user == 'E')
					{
						cout << "GRADUATE IN ELECTRICAL ENGINEERING." << endl;
					}
					else
					if (user == 'B')

					{
						cout << "GRADUATE IN BUSINESS ADMINISTRATOR." << endl;
					}
					
				}
				
			}
			
				if (user == 'F')
			{
				cout << "M FOR MASTER. " << endl;
				cout << "G FOR GRADUATE." << endl;
				cin >> user;

				if (user == 'M')
				{
					cout << "ENTER C FOR COMPUTER SCIENCE." << endl;
					cout << "ENTER E FOR ENGINEERING." << endl;
					cout << "ENTER B FOR BUSINESS ADMINISTRATOR." << endl;
					cin >> user;
					if (user == 'C')
					{
						cout << "MASTER IN COMPUTER SCIENCE." << endl;
					}
					else
					if (user == 'E')
					{
						cout << "MASTER IN ELECTRICAL ENGINEERING." << endl;
					}
					else
					if (user == 'B')

					{
						cout << "MASTER IN BUSINESS ADMINISTRATOR." << endl;
					}
			}
			else
			if(user=='G')
			{
			    	cout <<"ENTER C FOR COMPUTER SCIENCE." << endl;
					cout << "ENTER E FOR ENGINEERING." << endl;
					cout << "ENTER B FOR BUSINESS ADMINISTRATOR." << endl;
					cin >> user;
					if (user == 'C')
					{
						cout << "GRADUATE IN COMPUTER SCIENCE." << endl;
					}
					else
					if (user == 'E')
					{
						cout << "GRADUATE IN ELECTRICAL ENGINEERING." << endl;
					}
					else
					if (user == 'B')

					{
						cout << "GRADUATE IN BUSINESS ADMINISTRATOR." << endl;
					}
			    }
			
			}
			

			}

		}
		
	}
	
	}

	return 0;
}



