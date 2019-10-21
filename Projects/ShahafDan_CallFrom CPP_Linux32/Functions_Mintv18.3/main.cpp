#include <iostream>
#include <iomanip>
#include <cstdlib>
using namespace std;
extern "C" {int addTwo(int a, int b);}
/*extern "C" 
{
		int addTwo(int a, int b);
		//void addTwoArrays(int[] array1, int[] array2);
		//int[] revArray (int[] array1, int[] array2);
		int multiplyTwo(int a, int b);
		int pow2 (int a);
		// int add array still need to be declared here
}*/

int main()
{
	cout << " welcome to my program of c++ and assembly" << endl;
	
	int ret = addTwo(5, 4);
	cout << "5 + 4 = " << ret << endl;
	return 0;
}	
