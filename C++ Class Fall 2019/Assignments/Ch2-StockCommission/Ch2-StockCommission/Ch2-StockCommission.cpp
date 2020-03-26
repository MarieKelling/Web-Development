// Ch2-StockCommission.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include "pch.h"
#include <iostream>
using namespace std;

int main()
{
	//declare variables
	int stock = 750 * 35.00;
	int commission = stock * .02;
	int total = stock + commission;

	//output the information
	cout << "The total amount paid for stock: $" << stock << "\n";
	cout << "The total amount paid for commission: $" << commission << "\n";
	cout << "The total amount paid for stock and commission: $" << total << "\n";

	//exit program
	system("pause");
}


