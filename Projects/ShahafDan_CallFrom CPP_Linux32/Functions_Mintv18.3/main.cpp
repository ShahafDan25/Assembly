#include <iostream>
#include <iomanip>
#include <cstdlib>
using namespace std;

extern "C" 
{
	int addTwo(int a, int b); //works
	int multiplyTwo (int a, int b); //works
	int pow2 (int a); //works
	//int revArray (int atr[], int size);
	int addArray(int array[], int size); //works
}

//Define a C-Style function call
int main() 
{
	int toRevArray [7] = {1,3,5,7,6,4,2}; //statically define an array
	cout << "Welcome to Shahaf's c++ and assembly program" << endl;
	int ret = addTwo(10, 20);
	//Return value is always in eax
	cout << "The addition of the two parameters is: " << ret << endl;
	
	ret = multiplyTwo(5, 5);
	cout << "5 times 5 is: " << ret << endl;
	
	ret = pow2(6);
	cout << "6 squared is: " << ret << endl;
	
	ret = addArray(toRevArray, 7);
	cout << "total of array elemens " << ret << endl;
	//ret = revArray(toRevArray, 7);
	//cout << "the reversed array is: " << ret <<  endl;
	return 0;
}//main
