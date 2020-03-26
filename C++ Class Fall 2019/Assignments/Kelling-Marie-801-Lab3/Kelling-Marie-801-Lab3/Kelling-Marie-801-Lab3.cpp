// Kelling-Marie-801-Lab3.cpp 

#include "pch.h"
#include <iostream>
using namespace std;

int main()
{
	//Declare Variables
	int gallons;
	int miles;

	//Prompt user for information
	cout << "How many gallons of gas can your car hold? ";
	cin >> gallons;
	cout << "\nHow many miles can your car drive on a full tank of gas? ";
	cin >> miles;

	//Display the calculated MPG based on the user input 
	cout << "\nYour average MPG is: " << miles / gallons << "\n\n";

	system("pause");
	return 0;
}
