// Kelling-Marie-801-Lab4.cpp 

#include "pch.h"
#include <iostream>
using namespace std;

int main()
{
	//Declare Variables
	int month, day, year;

	//Prompt user for information 
	cout << "Please enter a month in numeric form: ";
	cin >> month;

	cout << "\nPlease enter a day: ";
	cin >> day;

	cout << "\nPlease enter a year in a two-digit format: ";
	cin >> year;

	//Determine if the month times the day is equal to the year 
	if (month * day == year) {
		cout << "\nThis date is magic!\n\n";
	}
	else {
		cout << "\nThis date is not magic.\n\n";
	}

	system("pause");
	return 0;
}
