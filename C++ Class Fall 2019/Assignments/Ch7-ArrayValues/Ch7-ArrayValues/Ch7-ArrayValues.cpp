// Marie Kelling Chapter 7 Assignment 


#include "pch.h"
#include <iostream>
using namespace std;

//Program evaluates integers and selects the largest and smalles integer 

int main()
{
	const int SIZE = 10;
	int values[SIZE]; 
	int largest;
	int smallest;
	int count;

	//Prompt user for the 10 integers
	cout << "Please enter 10 values: ";
	for (count = 0; count < SIZE; count++) {
		cout << "\nEnter an integer: ";
		cin >> values[count];
	}

	//Calculate the largest & smallest integers 
	largest = smallest = values[0];		//prime both vars to have the value of the first element 
	
	for (count = 1; count < SIZE; count++) {
		if (values[count] > largest) {
			largest = values[count];
		}
		if (values[count] < smallest) {
			smallest = values[count];
		}
	}

	//Display the largest & smallest integers of the array
	cout << "\nThe largest integer is: " << largest << endl;
	cout << "\nThe smallest integer is: " << smallest << endl;
    

	system("pause");
	return 0;
}


