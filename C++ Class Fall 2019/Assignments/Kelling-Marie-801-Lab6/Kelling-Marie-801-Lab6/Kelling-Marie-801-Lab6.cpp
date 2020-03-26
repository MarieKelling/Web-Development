// Kelling-Marie-801-Lab6.cpp 

#include "pch.h"
#include <iostream>
using namespace std;

//Function Prototypes w/ reference variables as parameters 
double getLength();
double getWidth();
double getArea(double&, double&);
void displayData(double&, double&, double&);

int main()
{
	//Declare Variables
	double length, width, area;

	//Get the rectangle's length.
	length = getLength();

	//Get the rectangle's width.
	width = getWidth();

	//Get the rectangle's area.
	area = getArea(length, width);

	//Display the rectangle's data.
	displayData(length, width, area);

	system("pause");
	return 0;
}

//Function Definitions w/ reference variables as parameters 
double getLength() {
	double length;
	cout << "Enter the rectangle's length: ";
	cin >> length;
	return length;
}

double getWidth() {
	double width;
	cout << "\nEnter the rectangle's width: ";
	cin >> width;
	return width;
}

double getArea(double& l, double& w) {
	return l * w;
}

void displayData(double& l, double& w, double& a) {
	cout << "\nThe length is " << l << endl;
	cout << "\nThe width is " << w << endl;
	cout << "\nThe area is " << a << endl << endl;
}

