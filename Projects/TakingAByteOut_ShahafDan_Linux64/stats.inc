; the 'calcVariance function will calculate the variance of any array (in the data section) in the main.asm program
;It will be based on the given formula in the project instructions
;In order to call this function, make sure to do the following:
;1. push the  length of the array of which you (for example: push array.len
;2. push the address of the array you have in the data section. For example: push array
;3. Now all you need to do is to call the function as follows: call calcVariance
;4. the function will return (in RAX) the calculates value of the vairance of the items in the array



extern calcvariance					;will bring out the calc variance function
