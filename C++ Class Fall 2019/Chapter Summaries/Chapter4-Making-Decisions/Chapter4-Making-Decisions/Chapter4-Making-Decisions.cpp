// Chapter4-Making-Decisions.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include "pch.h"
#include <iostream>
using namespace std;



int main()
{
	//Logical Not Operator: 
	cout << "Logical Not:" << endl;
	int x = 0;
	cout << "!(x > 2): " << !(x > 2) << endl;		//is x not greater than 2?
	cout << "!x: " << !x << endl;					//logical negation of x
	cout << "!x > 2: " << (!x > 2) << endl;			//is the logical negation of x greater than 2?


	//Switch Statements: 
	char choice1;
	cout << "Please enter A, B, or C: " << endl;
	cin >> choice1;
	switch (choice1) 
	{
		case 'A': cout << "You selected A.\n";
			break;
		case 'B': cout << "You selected B.\n";
			break;
		case 'C': cout << "You selected C.\n";
			break;
		default: cout << "You did not enter A, B, or C.\n";
	}

	//Purposefully leaving break statement out pt. 1: 
	char choice2;
	cout << "Please enter A, B, or C: " << endl;
	cin >> choice2;
	switch (choice2)
	{
		case 'a':
		case 'A': cout << "You selected A.\n";
			break;
		case 'b':
		case 'B': cout << "You selected B.\n";
			break;
		case 'c':
		case 'C': cout << "You selected C.\n";
			break;
		default: cout << "You did not enter A, B, or C.\n";
	}

	//Purposefully leaving break statement out pt. 2: 
	char permissions;
	cout << "Please enter your permissions level: 1, 2, or 3: " << endl;
	cin >> permissions;
	switch (permissions)
	{
		case '1': cout << "You have level 1 permissions.\n";
		case '2': cout << "You have level 2 permissions.\n";
		case '3': cout << "You have level 3 permissions.\n";
		default: cout << "You did not enter one of the permission options./n";
	}




	system("pause");
	return 0; 
}


