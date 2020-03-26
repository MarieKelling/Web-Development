// Kelling-Marie-801-Lab2.cpp 

#include "pch.h"
#include <iostream>
using namespace std;

int main()
{
	//Declare constant 
	const float COMMISSION_PERCENTAGE = .02;

	//Declare variables
	int shares_bought = 750;
	int share_price = 35;

	//Declare variables that are calculations of other variables 
	int total_paid = shares_bought * share_price;
	float total_commission = total_paid * COMMISSION_PERCENTAGE;
	float total_amount_paid = total_commission + total_paid;

	//Display calculations
	cout << "Total amount paid for stock (without commission): $";
	cout << total_paid;

	cout << "\n\nTotal amount of commission: $";
	cout << total_commission;

	cout << "\n\nTotal amount paid (stock plus commission): $";
	cout << total_amount_paid << endl << endl;

	system("pause");
	return 0;
}
