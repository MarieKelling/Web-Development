// Chapter3.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include "pch.h"
#include <iostream>		//cout, cin 
#include <cmath>		//pow
#include <iomanip>		//setprecision, setw
using namespace std;

int x, y, value, value1, value2;
double expotentialValue, precision, precisionFixed;

int main()
{
	//Accept multiple values with cin: 
	/*cout << "Accept multiple values with cin: " << endl;
	cout << " Enter 2 values separated by a space: ";
	cin >> value1 >>  value2;
	cout << " The 2 values you entered are: " << value1 << " and " << value2 << endl;
	cout << endl;*/

	//Operator Precedence: 
	cout << "Operator Precedence: " << endl;
	x = 5 + 3 * 4;
	cout << " 5 + 3 * 4 = " << x << endl;
	y = 25 % 5;
	cout << " 25 % 5 = " << y << endl;
	cout << endl;

	//Exponent Functionality: 
	cout << "Exponent Functionality: " << endl;
	expotentialValue = pow(2.0, 3.0);
	cout << " 2 to the 3rd power is: " << expotentialValue << endl;
	cout << endl;

	//Setw Manipulator: 
	cout << "Setw() Manipulator: " << endl;
	value = 20;
	cout << " (" << setw(4) << value << ")" << endl;
	cout << endl;

	//SetPrecision: 
	cout << "SetPrecision: " << endl;
	precision = 1.234;
	cout << setprecision(2) << precision << endl;
	//cout << " " << precision << " --> Doesn't produce expected results?" << endl;
	cout << endl;

	//Fixed Manipulator: 
	cout << "Fixed Manipulator: " << endl;
	precisionFixed = 2.234;
	cout << setprecision(2) << fixed << precisionFixed << endl;
	//cout << " " << precisionFixed << " --> Produces expected results." << endl;
	cout << endl;


	//ShowPoint: 
	cout << "Showpoint(): " << endl;

	cout << endl;


	//Rand() Function: 
	cout << "Rand() Function: " << endl;

	cout << endl;


	system("pause");
	return 0;
}


