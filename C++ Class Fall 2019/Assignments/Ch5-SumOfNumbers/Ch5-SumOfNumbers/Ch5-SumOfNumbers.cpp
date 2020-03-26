// Ch5-SumOfNumbers.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include "pch.h"
#include <iostream>
using namespace std;

int main()
{
	int value;

	cout << "Please enter a positive integer value: "; 
	cin >> value;

	while (value < 0)
	{
		cout << "ERROR: Please enter a POSITIVE integer value: ";
		cin >> value;
	}

	int count = 0;
	int num = 0;

	for (int i = 0; i <= value; i++)
	{
		count = count + num;
		num++;
	}

	cout << "The sum of numbers 1-" << value << " is: " << count << endl;
	
	system("pause");
	return 0;
    
}

