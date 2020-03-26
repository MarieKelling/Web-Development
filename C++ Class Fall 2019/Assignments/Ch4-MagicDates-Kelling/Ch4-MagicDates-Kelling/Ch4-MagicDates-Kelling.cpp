// Ch4-MagicDates-Kelling.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include "pch.h"
#include <iostream>
using namespace std;

int month, day, year;

int main()
{
	cout << "Please enter a month in numeric form: " << endl;
	cin >> month;

	cout << "Please enter a day: " << endl;
	cin >> day;

	cout << "Please enter a year in a two-digit format: " << endl;
	cin >> year;

	if (month * day == year) {
		cout << "This date is magic!" << endl;
	}
	else {
		cout << "This date is not magic." << endl;
	}

	system("pause");
	return 0;
}


