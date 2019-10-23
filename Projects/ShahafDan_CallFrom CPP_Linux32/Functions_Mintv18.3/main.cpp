#include <iostream>
#include <iomanip>
#include <cstdlib>
#include "funcs.hpp"
using namespace std;

//Define a C-Style function call
int main() //fix later to a user friendly main after done with functions
{
	cout << endl << " -------------------------- " << endl << endl;
	int toRevArray [7] = {3,4,5,6,7,8,9}; //statically define an array
	int arr2 [7] = {1,2,3,4,5,6,7};
	int revArr [7] = {0,0,0,0,0,0,0}; //this array will be reversed
	cout << "Welcome to Shahaf's c++ and assembly program" << endl;
	int ret = addTwo(10, 20);
	//Return value is always in eax
	cout << "The addition of the two parameters is: " << ret << endl;
	
	ret = multiplyTwo(7, 5);
	cout << "5 times 5 is: " << ret << endl;
	
	ret = pow2(6);
	cout << "6 squared is: " << ret << endl;
	
	ret = addArray(toRevArray, 7);
	cout << "total of array elemens " << ret << endl;
	
	int * ret1= new int[7] ;
	ret1 = addTwoArrays(toRevArray, arr2, revArr, 7);
	//ret1 now stores the array
	for(unsigned int i = 0; i < 7; i++)
	{
		cout << ret1[i] << " ";
	}
	cout << endl;
	//ret = revArray(toRevArray, 7);
	
	int * ret2= new int[7] ;
	cout << "reversing an array: " << endl;
	ret2 = revArray(toRevArray, revArr, 7);
	for(unsigned int i = 0; i < 7; i++)
	{
		cout << ret2[i] << " ";
	}
	cout << endl;
	//cout << "the reversed array is: " << ret <<  endl;
	cout << endl << " -------------------------- " << endl << endl;
	return 0;
}//main


//TODO:

	//document all functions in funcs.inc
	//SUBMIT TO CANVAS
