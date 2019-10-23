extern "C" 
{
	int addTwo(int a, int b); 
	/* Add Two takes two integres
	 * adds them up
	 * returns the sum in eax
	 */
	 
	int multiplyTwo (int a, int b); 
	/* Takes in two integers
	 * multiplies them
	 * returns the product in eax 
	 */
	 
	int pow2 (int a); 
	/* Take in an integer
	 * multiply it by itself (squaring it)
	 * returns the result in eax
	 */
	 
	int addArray(int array[], int size);
	/* Takes in an array, and its size
	 * adds all the elements of the array together
	 * returns the sum in eax
	 */
	  
	int * addTwoArrays (int array1[], int array2[], int array3[], int size); 
	/* takes in two filled array, one empty array (all of the same size), and their common size
	 * add each element from array1 and 2 and put it in the third array
	 * do that size times
	 * return the third array in eax
	 */
	 
	int * revArray(int array1[], int array2[], int size); 
	/* take in a filled arraym an empty array of the same size, and that size as a variable
	 * take the last element from the first array, put it in the first element of the second array
	 * take the one before last element from the first array, put it in the second element in the second array
	 * and so on and so on
	 * return the second array in eax
	 */
}

//CALL THE MAIN PROGRAM BY:
// 1)			./build main funcs
// 2)			./main
