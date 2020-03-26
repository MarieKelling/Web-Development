// Kelling-Marie-801-Lab5.cpp 

#include "pch.h"
#include <iostream>
using namespace std;

int main()
{
	//Declare Variables
	int value, count, num;

	//Prompt user for information 
	cout << "Please enter a positive integer value: ";
	cin >> value;


	//Error checking to ensure the user enters a positive integer 
	while (value < 0)
	{
		cout << "\nERROR: Please enter a POSITIVE integer value: ";
		cin >> value;
	}

	count = 0;
	num = 0;

	//Calculate the sum of the number 1 - whatever the user entered
	for (int i = 0; i <= value; i++)
	{
		count = count + num;
		num++;
	}

	//Display the sum
	cout << "\nThe sum of numbers 1-" << value << " is: " << count << endl << endl;

	system("pause");
	return 0;

}
