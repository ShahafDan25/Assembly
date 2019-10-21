     1                                  ;
     2                                  ;This program will test out the functions library
     3                                  ;
     4                                  ;
     5                                  ;Include our external functions library functions
     6                                  %include "./functions.inc"
     1                              <1> ;
     2                              <1> ;Include file for the functions library
     3                              <1> ;
     4                              <1> sys_exit	equ	1h
     5                              <1> sys_read	equ	3h
     6                              <1> sys_write	equ	4h
     7                              <1> stdin		equ	0h
     8                              <1> stdout		equ	1h
     9                              <1> stderr		equ	3h
    10                              <1> 
    11                              <1> ;Print a string which is not null terminated
    12                              <1> ;Stack contents:
    13                              <1> ;	The Address of the string to print
    14                              <1> ;	The length of the string to print
    15                              <1> ;Example Usage:
    16                              <1> ;	push	stringVariable
    17                              <1> ;	push	stringVariable.len
    18                              <1> ;	call	PrintText
    19                              <1> ;
    20                              <1> extern		PrintText
    21                              <1> 
    22                              <1> ;Clears the keyboard buffer until \n or null are encountered
    23                              <1> ;Stack contents:
    24                              <1> ;	None
    25                              <1> ;Example Usage:
    26                              <1> ;	call	ClearKBuffer
    27                              <1> ;
    28                              <1> extern		ClearKBuffer
    29                              <1> 
    30                              <1> ;Print a new line to the console
    31                              <1> ;Stack Contents:
    32                              <1> ;	None
    33                              <1> ;Example Usage:
    34                              <1> ;	call	Printendl
    35                              <1> ;
    36                              <1> extern		Printendl
    37                              <1> 
    38                              <1> ;Convert and then print a 32bit decimal number
    39                              <1> ;Stack contents:
    40                              <1> ;	Value to Convert to an Ascii String
    41                              <1> ;Example Usage:
    42                              <1> ;	push DWORD [dwordvariable]
    43                              <1> ;	call	Print32bitNumDecimal
    44                              <1> ;
    45                              <1> extern		Print32bitNumDecimal
    46                              <1> 
    47                              <1> ;Convert and then print a 32bit signed decimal number
    48                              <1> ;Stack contents:
    49                              <1> ;	Value to Convert to an Ascii String
    50                              <1> ;Example Usage:
    51                              <1> ;	push DWORD [dwordvariable]
    52                              <1> ;	call	Print32bitSNumDecimal
    53                              <1> ;
    54                              <1> extern		Print32bitSNumDecimal
    55                              <1> 
    56                              <1> ;Convert and then print a 32bit binary number
    57                              <1> ;Stack contents:
    58                              <1> ;	Value to Convert to an Ascii String
    59                              <1> ;Example Usage:
    60                              <1> ;	push DWORD [dwordvariable]
    61                              <1> ;	call	Print32bitNumBinary
    62                              <1> ;
    63                              <1> extern		Print32bitNumBinary
    64                              <1> 
    65                              <1> ;Print a full 32bit binary number including leading zeros
    66                              <1> ;Stack contents:
    67                              <1> ;	Value to Convert to an Ascii String
    68                              <1> ;Example Usage:
    69                              <1> ;	push DWORD [dwordvariable]
    70                              <1> ;	call	Print32bitFullBinary
    71                              <1> ;
    72                              <1> extern		Print32bitFullBinary
    73                              <1> 
    74                              <1> ;Print a full 32-bits binary number in Floating Point format.
    75                              <1> ;Stack contents:
    76                              <1> ;	Value to Print to an Ascii String
    77                              <1> ;Example Usage:
    78                              <1> ;	push	eax
    79                              <1> ;	call	Print32bitFloatBinary
    80                              <1> extern		Print32bitFloatBinary
    81                              <1> 
    82                              <1> ;Convert and then print a 32bit hex number
    83                              <1> ;Stack contents:
    84                              <1> ;	Value to Convert to an Ascii String
    85                              <1> ;Example Usage:
    86                              <1> ;	push	DWORD [dWordVariable]
    87                              <1> ;	call	Print32bitNumHex
    88                              <1> ;
    89                              <1> extern		Print32bitNumHex
    90                              <1> 
    91                              <1> ;Print all 32bit Registers to the screen
    92                              <1> ;Stack contents:
    93                              <1> ;	None
    94                              <1> ;Example Usage:
    95                              <1> ;	call	PrintRegisters
    96                              <1> ;
    97                              <1> extern		PrintRegisters
    98                              <1> 
    99                              <1> ;Print all of the floating point registers ST0 - ST7
   100                              <1> ;Stack Contents:
   101                              <1> ;	None
   102                              <1> ;Return: 	None
   103                              <1> ;Example Usage:
   104                              <1> ;	call	PrintFloatingRegisters
   105                              <1> extern		PrintFloatingRegisters
   106                              <1> 
   107                              <1> ;Print a string with an ending 00h delimiter to the console
   108                              <1> ;Arguments:	Address of the String (Stack)
   109                              <1> ;Example Usage:
   110                              <1> ;	push	stackVariable
   111                              <1> ;	call	PrintString
   112                              <1> extern		PrintString
   113                              <1> 
   114                              <1> ;Print a string with an ending 00h delimiter to the console Right Justified to a print area
   115                              <1> ;Arguments:	Address of the String (Stack)
   116                              <1> ;			Width of the print area to print into
   117                              <1> ;Example Usage:
   118                              <1> ;	push	stackVariable
   119                              <1> ;	push	20
   120                              <1> ;	call	PrintRight
   121                              <1> extern		PrintRight
   122                              <1> 
   123                              <1> ;Print a string with an ending 00h delimiter to the console Left Justified to a print area
   124                              <1> ;Arguments:	Address of the String (Stack)
   125                              <1> ;			Width of the print area to print into
   126                              <1> ;Example Usage:
   127                              <1> ;	push	stackVariable
   128                              <1> ;	push	20
   129                              <1> ;	call	PrintLeft
   130                              <1> extern		PrintLeft
   131                              <1> 
   132                              <1> ;Print a string with an ending 00h delimiter to the console Centered to a print area
   133                              <1> ;Arguments:	Address of the String (Stack)
   134                              <1> ;			Width of the print area to print into
   135                              <1> ;Example Usage:
   136                              <1> ;	push	stackVariable
   137                              <1> ;	push	20
   138                              <1> ;	call	PrintCenter
   139                              <1> extern		PrintCenter
   140                              <1> 
   141                              <1> ;Print a space to the console
   142                              <1> ;Arguments:	None
   143                              <1> ;Example Usage:
   144                              <1> ;	call	PrintSpace
   145                              <1> extern		PrintSpace
   146                              <1> 
   147                              <1> ;Print a comma followed by a space to the console
   148                              <1> ;Arguments:	None
   149                              <1> ;Example Usage:
   150                              <1> ;	call	PrintComma
   151                              <1> extern		PrintComma
   152                              <1> 
   153                              <1> ;Print all byte values found in an array in Hex format
   154                              <1> ;Arguments:	Address of the Array (Stack)
   155                              <1> ;			Number of items in the array
   156                              <1> ;Example Usage:
   157                              <1> ;	push	arrayLabel
   158                              <1> ;	push	20
   159                              <1> ;	call	PrintByteArray
   160                              <1> extern		PrintByteArray
   161                              <1> 
   162                              <1> ;Print all byte values found in an array in Decimal format
   163                              <1> ;Arguments:	Address of the Array (Stack)
   164                              <1> ;			Number of items in the array
   165                              <1> ;Example Usage:
   166                              <1> ;	push	arrayLabel
   167                              <1> ;	push	20
   168                              <1> ;	call	PrintByteArrayDec
   169                              <1> extern		PrintByteArrayDec
   170                              <1> 
   171                              <1> ;Print all signed byte values found in an array in Decimal format
   172                              <1> ;Arguments:	Address of the Array (Stack)
   173                              <1> ;			Number of items in the array
   174                              <1> ;Example Usage:
   175                              <1> ;	push	arrayLabel
   176                              <1> ;	push	20
   177                              <1> ;	call	PrintSByteArrayDec
   178                              <1> extern		PrintSByteArrayDec
   179                              <1> 
   180                              <1> ;Print all word values found in an array in Hex format
   181                              <1> ;Arguments:	Address of the Array (Stack)
   182                              <1> ;			Number of items in the array
   183                              <1> ;Example Usage:
   184                              <1> ;	push	arrayLabel
   185                              <1> ;	push	20
   186                              <1> ;	call	PrintWordArray
   187                              <1> extern		PrintWordArray
   188                              <1> 
   189                              <1> ;Print all word values found in an array in Decimal format
   190                              <1> ;Arguments:	Address of the Array (Stack)
   191                              <1> ;			Number of items in the array
   192                              <1> ;Example Usage:
   193                              <1> ;	push	arrayLabel
   194                              <1> ;	push	20
   195                              <1> ;	call	PrintWordArrayDec
   196                              <1> extern		PrintWordArrayDec
   197                              <1> 
   198                              <1> ;Print all signed word values found in an array in Decimal format
   199                              <1> ;Arguments:	Address of the Array (Stack)
   200                              <1> ;			Number of items in the array
   201                              <1> ;Example Usage:
   202                              <1> ;	push	arrayLabel
   203                              <1> ;	push	20
   204                              <1> ;	call	PrintSWordArrayDec
   205                              <1> extern		PrintSWordArrayDec
   206                              <1> 
   207                              <1> ;Print all Double Word values found in an array in Hex format
   208                              <1> ;Arguments:	Address of the Array (Stack)
   209                              <1> ;			Number of items in the array
   210                              <1> ;Example Usage:
   211                              <1> ;	push	arrayLabel
   212                              <1> ;	push	20
   213                              <1> ;	call	PrintDWordArray
   214                              <1> extern		PrintDWordArray
   215                              <1> 
   216                              <1> ;Print all Double Word values found in an array in Decimal format
   217                              <1> ;Arguments:	Address of the Array (Stack)
   218                              <1> ;			Number of items in the array
   219                              <1> ;Example Usage:
   220                              <1> ;	push	arrayLabel
   221                              <1> ;	push	20
   222                              <1> ;	call	PrintDWordArrayDec
   223                              <1> extern		PrintDWordArrayDec
   224                              <1> 
   225                              <1> ;Print all signed Double Word values found in an array in Decimal format
   226                              <1> ;Arguments:	Address of the Array (Stack)
   227                              <1> ;			Number of items in the array
   228                              <1> ;Example Usage:
   229                              <1> ;	push	arrayLabel
   230                              <1> ;	push	20
   231                              <1> ;	call	PrintSDWordArrayDec
   232                              <1> extern		PrintSDWordArrayDec
   233                              <1> 
   234                              <1> ;Print a Double-word floating point number
   235                              <1> ;This version uses the integer extraction power of the FPU instead of moving bits
   236                              <1> ;	around to extract the exponent and left/right mantissa's making this a
   237                              <1> ;	much easier and shorter algorithm
   238                              <1> ;Stack Contents:
   239                              <1> ;	The floating point number to print
   240                              <1> ;	The number of fractional Digits to print
   241                              <1> ;Return:
   242                              <1> ;	None
   243                              <1> ;Example Usage:
   244                              <1> ;	push	[numberToPrint]
   245                              <1> ;	push	[fractionalDigits]
   246                              <1> ;	call	PrintDWFloat
   247                              <1> extern		PrintDWFloat
   248                              <1> 
   249                              <1> ;Print a Double-word floating point number in scientific notation
   250                              <1> ;This version uses the integer extraction power of the FPU instead of moving bits
   251                              <1> ;	around to extract the exponent and left/right mantissa's making this a
   252                              <1> ;	much easier and shorter algorithm
   253                              <1> ;Stack Contents:
   254                              <1> ;	The floating point number to print
   255                              <1> ;	The number of fractional Digits to print
   256                              <1> ;Return:
   257                              <1> ;	None
   258                              <1> ;Example Usage:
   259                              <1> ;	push	[numberToPrint]
   260                              <1> ;	push	[fractionalDigits]
   261                              <1> ;	call	PrintDWFloatSN
   262                              <1> extern		PrintDWFloatSN
   263                              <1> 
   264                              <1> ;Get a random number from the CPU
   265                              <1> ;Stack contents:
   266                              <1> ;	The maximum value of the random number
   267                              <1> ;	Signed = 1, Unsigned = 0
   268                              <1> ;Return Value:
   269                              <1> ;	eax = Random number value
   270                              <1> ;Example Usage:
   271                              <1> ;	push 	DWORD 200			;Will create a random number no greater than 200
   272                              <1> ;	push	DWORD 1				;1 = signed, 0 = uinsigned
   273                              <1> ;	call	GetRandomInt
   274                              <1> ;
   275                              <1> extern		GetRandomInt
   276                              <1> 
   277                              <1> ;Return, in eax, an integer entered by the user
   278                              <1> ;Arguments: none
   279                              <1> ;Example Usage:
   280                              <1> ;	call	InputInt
   281                              <1> extern		InputInt
   282                              <1> 
   283                              <1> ;Call the necessary interrupt with the necessary register values to read data from the keyboard
   284                              <1> ;Stack Contents:
   285                              <1> ;	Address of keyboard buffer
   286                              <1> ;	Size of the keyboard buffer
   287                              <1> ;Return:
   288                              <1> ;	eax will contain the number of characters the user input
   289                              <1> ;Example Usage:
   290                              <1> ;	push	readbuffer
   291                              <1> ;	push	readbuffer.len
   292                              <1> ;	call	ReadText
   293                              <1> extern		ReadText
   294                              <1> 
   295                              <1> ;Call the necessary interrupt with the necessary register values to read data from the keyboard
   296                              <1> ;Stack Contents:
   297                              <1> ;	Address of the string to print
   298                              <1> ;	Address of keyboard buffer
   299                              <1> ;	Size of the keyboard buffer
   300                              <1> ;Return:
   301                              <1> ;	eax will contain the number of characters input
   302                              <1> ;Example Usage:
   303                              <1> ;	push	inputPromptVariable
   304                              <1> ;	push	keyboardBufferVariable
   305                              <1> ;	push	keyboardBufferVariable.len  ;This is the maximum size of the buffer
   306                              <1> ;	call	ReadTextWPrompt
   307                              <1> extern		ReadTextWPrompt
   308                              <1> 
   309                              <1> ;Call the necessary interrupt with the necessary register values to read the system time Hour
   310                              <1> ;Arguments: None
   311                              <1> ;Return:  eax:  The current hour
   312                              <1> ;Example Usage:
   313                              <1> ;	call	GetCurrentHour
   314                              <1> extern		GetCurrentHour
   315                              <1> 
   316                              <1> ;Call the necessary interrupt with the necessary register values to read the system time Minute
   317                              <1> ;Arguments: None
   318                              <1> ;Return:  eax:  The current minute
   319                              <1> ;Example Usage:
   320                              <1> ;	call	GetCurrentMinute
   321                              <1> extern		GetCurrentMinute
   322                              <1> 
   323                              <1> ;Call the necessary interrupt with the necessary register values to read the system time Second
   324                              <1> ;Arguments: None
   325                              <1> ;Return:  eax:  The current second
   326                              <1> ;Example Usage:
   327                              <1> ;	call	GetCurrentSecond
   328                              <1> extern		GetCurrentSecond
   329                              <1> 
   330                              <1> ;Call the function to get the system time and then print it
   331                              <1> ;Arguments: None
   332                              <1> ;Return:  None
   333                              <1> ;Example Usage:
   334                              <1> ;	call	PrintSystemTime
   335                              <1> extern		PrintSystemTime
   336                              <1> 
   337                              <1> ;Call the function to get the CPU's Time Stamp Counter
   338                              <1> ;Arguments: None
   339                              <1> ;Return:  eax
   340                              <1> ;Example Usage:
   341                              <1> ;	call	GetTSC
   342                              <1> extern		GetTSC
   343                              <1> 
   344                              <1> ;An Internal function used to get the system time hours, minutes, seconds
   345                              <1> ;Stack Contents:
   346                              <1> ; None
   347                              <1> ;Return: None
   348                              <1> ;Example Usage
   349                              <1> ;   call GetSystemTime
   350                              <1> extern		GetSystemTime
   351                              <1> 
   352                              <1> ;Input UnSigned Int
   353                              <1> ;This function will let the user input an integer returned into the EAX register
   354                              <1> ;Arguments: None
   355                              <1> ;Return: 	eax will contain the usigned ingeter
   356                              <1> ;			Carry flag will be set if invalid integer was input
   357                              <1> ;Example Usage:
   358                              <1> ;	call	InputInt
   359                              <1> ;	Note: eax will contain the value of the unsigned integer entered
   360                              <1> ;	jnc		validIntegerInput
   361                              <1> ;	Otherwise, an invalid integer was input
   362                              <1> extern		InputUInt
   363                              <1> 
   364                              <1> ;Input Signed Int
   365                              <1> ;This function will let the user input a signed integer and put the value
   366                              <1> ;into the EAX register.
   367                              <1> ;Arguments: None
   368                              <1> ;Return: 	eax will contain the usigned ingeter
   369                              <1> ;			Carry flag will be set if invalid integer was input
   370                              <1> ;Example Usage:
   371                              <1> ;	call	InputSInt
   372                              <1> ;	Note: eax will contain the value of the signed integer entered
   373                              <1> ;	jnc		validIntegerInput
   374                              <1> ;	Otherwise, an invalid integer was input
   375                              <1> extern		InputSInt
   376                              <1> 
   377                              <1> ;Input Binary Number
   378                              <1> ;This function will let the user input a string, then it will check it to make sure it
   379                              <1> ;is a binary string.  It will then convert the ASCII string into a DWORD and return
   380                              <1> ;that value in the EAX register.
   381                              <1> ;Arguments:
   382                              <1> ;	None
   383                              <1> ;Return: 	eax will contain the numeric binary value
   384                              <1> ;			Carry flag will be set if invalid binary number was input
   385                              <1> ;Example Usage:
   386                              <1> ;	call	InputBin
   387                              <1> ;	jnc		ValidBinLabel
   388                              <1> ;	otherwise, a problem occured - print an error message
   389                              <1> extern		InputBin
   390                              <1> 
   391                              <1> ;This function will let the user input a string, then it will check it to make sure it
   392                              <1> ;is a hexidecimal string.  It will then convert the ASCII string into a DWORD and return
   393                              <1> ;that value in the EAX register.
   394                              <1> ;Arguments:
   395                              <1> ;	None
   396                              <1> ;Return: 	eax will contain the numeric hexidecimal value
   397                              <1> ;			Carry flag will be set if invalid hex number was input
   398                              <1> ;Example Usage:
   399                              <1> ;	call	InputHex
   400                              <1> ;	jnc		ValidHexLabel
   401                              <1> ;	otherwise, a problem occured - print an error message
   402                              <1> extern		InputHex
   403                              <1> 
   404                              <1> ;Input a Floating Point Number
   405                              <1> ;This function will let the user input a string, then it will check it to make sure it
   406                              <1> ;is a valid floating point number.  It will then convert the ASCII string into a EWORD
   407                              <1> ;and return that value in the EAX register.
   408                              <1> ;Stack Contents:
   409                              <1> ;	None
   410                              <1> ;Return: 	EAX and ST(0) will contain the number
   411                              <1> ;			Carry flag will be set if invalid binary number was input
   412                              <1> ;Example Usage:
   413                              <1> ;	call	InputFloat
   414                              <1> ;	jnc		ValidFloatLabel
   415                              <1> ;	otherwise, a problem occured - print an error message
   416                              <1> extern		InputFloat
   417                              <1> 
   418                              <1> ;Calculate the Average in a Double Word Array
   419                              <1> ;Arguments:	ArrayAddress (Stack)
   420                              <1> ;			Number of Items in the Array (Stack)
   421                              <1> ;Return:	eax will contain the average
   422                              <1> ;Example Usage:
   423                              <1> ;	push	arrayLabel
   424                              <1> ;	push	20
   425                              <1> ;	call	DWArrayAverage
   426                              <1> extern		DWArrayAverage
   427                              <1> 
   428                              <1> ;Calculate the Average in a Word Array
   429                              <1> ;Arguments:	ArrayAddress (Stack)
   430                              <1> ;			Number of Items in the Array (Stack)
   431                              <1> ;Return:	eax will contain the average
   432                              <1> ;Example Usage:
   433                              <1> ;	push	arrayLabel
   434                              <1> ;	push	20
   435                              <1> ;	call	WArrayAverage
   436                              <1> extern		WArrayAverage
   437                              <1> 
   438                              <1> ;Calculate the Average in a Byte Array
   439                              <1> ;Arguments:	ArrayAddress (Stack)
   440                              <1> ;			Number of Items in the Array (Stack)
   441                              <1> ;Return:	eax will contain the average
   442                              <1> ;Example Usage:
   443                              <1> ;	push	arrayLabel
   444                              <1> ;	push	20
   445                              <1> ;	call	BArrayAverage
   446                              <1> extern		BArrayAverage
   447                              <1> 
   448                              <1> ;Allocate some memory (x bytes)	and return the high address to EAX
   449                              <1> ;Stack Contents:
   450                              <1> ;	Number of BYTES to add to memory
   451                              <1> ;Return: 	EAX will contain the new high memory address
   452                              <1> ;Example Usage:
   453                              <1> ;	push	DWORD 1024			;increase memory by 1024 bytes
   454                              <1> ;	call	AllocateBytes
   455                              <1> extern		AllocateBytes
   456                              <1> 
   457                              <1> ;Free some memory (x bytes)	and return the high address to EAX
   458                              <1> ;Stack Contents:
   459                              <1> ;	Number of BYTES to remove from memory
   460                              <1> ;Return: 	EAX will contain the new high memory address
   461                              <1> ;Example Usage:
   462                              <1> ;	push	DWORD 1024			;reduce memory by 1024 bytes
   463                              <1> ;	call	FreeBytes
   464                              <1> extern		FreeBytes
   465                              <1> 
   466                              <1> ;Allocate some memory as a-word array
   467                              <1> ;Arguments:	Number of DWORDS to allocate (Stack)
   468                              <1> ;Return:	eax will contain highest address of this memory
   469                              <1> ;Example Usage:
   470                              <1> ;	push	20
   471                              <1> ;	call	AllocateWORDArray
   472                              <1> extern		AllocateWORDArray
   473                              <1> 
   474                              <1> ;Allocate some memory as a double-word array
   475                              <1> ;Arguments:	Number of DWORDS to allocate (Stack)
   476                              <1> ;Return:	eax will contain highest address of this memory
   477                              <1> ;Example Usage:
   478                              <1> ;	push	20
   479                              <1> ;	call	AllocateDWORDArray
   480                              <1> extern		AllocateDWORDArray
   481                              <1> 
   482                              <1> ;Simple xor encryption/decryption of a string using a user entered key
   483                              <1> ;Arguments:	String address to encrypt/decrypt (Stack ebp + 24)
   484                              <1> ;			Length of the string to encrypt (Stack ebp + 20)
   485                              <1> ;			string address to be used as a key (Stack ebp + 16)
   486                              <1> ;			integer value indicating the length of the key (Stack ebp + 12)
   487                              <1> ;			string address where the encrypted/decrypted data should go (Stack ebp + 8)
   488                              <1> ;Return:	Total bytes encrypted in eax
   489                              <1> ;Example Usage:
   490                              <1> ;	push	stringToEncrypt
   491                              <1> ;	push	20
   492                              <1> ;	push	keyAddress
   493                              <1> ;	push	8
   494                              <1> ;	push	targetString
   495                              <1> ;	call	EncryptString
   496                              <1> extern		EncryptString
   497                              <1> 
   498                              <1> ;Get the length of a string based on a null (00) delimeter
   499                              <1> ;Arguments: Address of the string
   500                              <1> ;Return:	Size of the string in eax
   501                              <1> ;Example Usage:
   502                              <1> ;	push	arrayLabel
   503                              <1> ;	call	StringSize
   504                              <1> extern		StringSize
   505                              <1> 
   506                              <1> ;Calculate the GCD of two numbers passed to this function
   507                              <1> ;Arguments: Integer #1 and Integer #2 in the stack
   508                              <1> ;Return:	GCD in eax
   509                              <1> ;Example Usage:
   510                              <1> ;	push	[number1]
   511                              <1> ;	push	[number2]
   512                              <1> ;	call	CalcGCD
   513                              <1> extern		CalcGCD
   514                              <1> 
   515                              <1> ;Calculate the factorial of a number passed to this function
   516                              <1> ;Arguments:	Integer number in the stack
   517                              <1> ;Return:	Factorial of x in eax
   518                              <1> ;Example Usage:
   519                              <1> ;	push	[number1]
   520                              <1> ;	call	CalcFactorial
   521                              <1> extern		CalcFactorial
   522                              <1> 
   523                              <1> ;Calculate the factorial of a number passed to this function
   524                              <1> ;Arguments:	Integer number in the stack
   525                              <1> ;Return:	Factorial of x in eax as a floating point value
   526                              <1> ;Example Usage:
   527                              <1> ;	push	[number1]
   528                              <1> ;	call	CalcFactorialFloat
   529                              <1> extern		CalcFactorialFloat
   530                              <1> 
   531                              <1> ;Set the carry flag if the floating poing number pushed onto the Stack
   532                              <1> ;is a +NAN, -NAN, +Infinity or -Infinity
   533                              <1> ;Stack Contents:
   534                              <1> ; DWORD Floating Point number (Stack)
   535                              <1> ;Return: Carry Flag Set if NAN, Clear if OK
   536                              <1> ;Example Usage
   537                              <1> ;   push  DWORD [floatingVariable]
   538                              <1> ;   call  IsNAN
   539                              <1> extern    IsNAN
   540                              <1> 
   541                              <1> ;Print the date in the format mm/dd/yyyy
   542                              <1> ;Stack Contents:
   543                              <1> ; None
   544                              <1> ;Return: None
   545                              <1> ;Example Usage
   546                              <1> ;   call PrintSystemDateEng
   547                              <1> extern		PrintSystemDateEng
   548                              <1> 
   549                              <1> ;Print the date in the format yyyy/mm/dd
   550                              <1> ;Stack Contents:
   551                              <1> ; None
   552                              <1> ;Return: None
   553                              <1> ;Example Usage
   554                              <1> ;   call PrintSystemDateEuro
   555                              <1> extern		PrintSystemDateEuro
   556                              <1> 
   557                              <1> ;Convert and then return in a byte array a64-but number in decimal format
   558                              <1> ;Stack contents:
   559                              <1> ;	Value to Convert to an Ascii String
   560                              <1> ;	Address of byte array to contain the result
   561                              <1> ;Return Value:
   562                              <1> ;	eax = Number of characters returned
   563                              <1> ;Example Usage:
   564                              <1> ;	push 	DWORD [doublewordvariable]
   565                              <1> ;	push 	stringbuffer
   566                              <1> ;	call	ToString32bitNumDecimal
   567                              <1> ;
   568                              <1> extern		ToString32bitNumDecimal
   569                              <1> 
   570                              <1> ;Convert and then return in a byte array a 64bit signed number in decimal format
   571                              <1> ;Stack contents:
   572                              <1> ;	Value to Convert to an Ascii String
   573                              <1> ;	Address of byte array to contain the result
   574                              <1> ;Return Value:
   575                              <1> ;	eax = Number of characters returned
   576                              <1> ;Example Usage:
   577                              <1> ;	push 	DWORD [doublewordvariable]
   578                              <1> ;	push 	stringbuffer
   579                              <1> ;	call	ToString32bitSNumDecimal
   580                              <1> ;
   581                              <1> extern		ToString32bitSNumDecimal
   582                              <1> 
   583                              <1> ;Get the system date in English format and return to the calling function in th array
   584                              <1> ;	provided
   585                              <1> ;Stack contents:
   586                              <1> ;	Address of byte array to contain the result
   587                              <1> ;Return Value:
   588                              <1> ;	eax = Number of characters returned
   589                              <1> ;Example Usage:
   590                              <1> ;	push 	stringbuffer
   591                              <1> ;	call	GetEngDateString
   592                              <1> ;
   593                              <1> extern		GetEngDateString
   594                              <1> 
   595                              <1> ;Get the system date in European format and return to the calling function in th array
   596                              <1> ;	provided
   597                              <1> ;Stack contents:
   598                              <1> ;	Address of byte array to contain the result
   599                              <1> ;Return Value:
   600                              <1> ;	eax = Number of characters returned
   601                              <1> ;Example Usage:
   602                              <1> ;	push 	stringbuffer
   603                              <1> ;	call	GetEuroDateString
   604                              <1> ;
   605                              <1> extern		GetEuroDateString
   606                              <1> 
   607                              <1> ;Get the system time and return to the calling function in th array
   608                              <1> ;	provided
   609                              <1> ;Stack contents:
   610                              <1> ;	Address of byte array to contain the result
   611                              <1> ;Return Value:
   612                              <1> ;	eax = Number of characters returned
   613                              <1> ;Example Usage:
   614                              <1> ;	push 	stringbuffer
   615                              <1> ;	call	GetTimeString
   616                              <1> ;
   617                              <1> extern		GetTimeString
   618                              <1> 
   619                              <1> ;Calculate the Variance from an array of numbers
   620                              <1> ;Stack contents:
   621                              <1> ;	Address of sample array of Double words
   622                              <1> ;	The number of samples to process
   623                              <1> ;Return Value:
   624                              <1> ;	eax = Calculated Variance
   625                              <1> ;Example Usage:
   626                              <1> ;	push 	sampleArray			;Address of the array of numeric samples
   627                              <1> ;	push	10					;process 10 of the numbers in the array
   628                              <1> ;	call	CalcVariance
   629                              <1> ;
   630                              <1> extern		CalcVariance
   631                              <1> 
   632                              <1> ;Calculate the Standard Deviation from an array of numbers
   633                              <1> ;Stack contents:
   634                              <1> ;	Address of sample array of Double words
   635                              <1> ;	The number of samples to process
   636                              <1> ;Return Value:
   637                              <1> ;	eax = Calculated Standard Deviation
   638                              <1> ;Example Usage:
   639                              <1> ;	push 	sampleArray			;Address of the array of numeric samples
   640                              <1> ;	push	10					;process 10 of the numbers in the array
   641                              <1> ;	call	CalcStdDev
   642                              <1> ;
   643                              <1> extern		CalcStdDev
   644                              <1> 
   645                              <1> ;Calculate the Mean from an array of numbers
   646                              <1> ;Stack contents:
   647                              <1> ;	Address of sample array of Double words
   648                              <1> ;	The number of samples to process
   649                              <1> ;Return Value:
   650                              <1> ;	eax = Calculated Mean
   651                              <1> ;Example Usage:
   652                              <1> ;	push 	sampleArray			;Address of the array of numeric samples
   653                              <1> ;	push	10					;process 10 of the numbers in the array
   654                              <1> ;	call	CalcMean
   655                              <1> ;
   656                              <1> extern		CalcMean
   657                              <1> 
   658                              <1> ;Fills an array with random double values
   659                              <1> ;Stack contents:
   660                              <1> ;	Address of array of Double words
   661                              <1> ;	The number of samples to process
   662                              <1> ;	Maximum value of the random number(s)
   663                              <1> ;	Signed = 1, Unsigned = 0
   664                              <1> ;Return Value:
   665                              <1> ;	Nothing
   666                              <1> ;Example Usage:
   667                              <1> ;	push 	sampleArray			;Address of the array of numeric samples
   668                              <1> ;	push	10					;process 10 of the numbers in the array
   669                              <1> ;	push	500					;The maximum random value should be 500
   670                              <1> ;	push	0					;Unsigned only
   671                              <1> ;	call	RandomArray
   672                              <1> ;
   673                              <1> extern		RandomArray
   674                              <1> 
     7                                   %include "./funcs.inc"
     1                              <1> ;example of usage:
     2                              <1> ;	
     3                              <1> ;the function assumes the address if rhge string will be in the ecx register 
     4                              <1> ;and that the length in the edx register
     5                              <1> extern DisplayText
     8                                  SECTION .data
     9 00000000 57656C636F6D652074-     	welcomeAct db "Welcome to Shahaf's Program", 0ah, 0dh, 0h
     9 00000009 6F2053686168616627-
     9 00000012 732050726F6772616D-
     9 0000001B 0A0D00             
    10 0000001E 4279652C2054616B65-     	byeAct db "Bye, Take Care", 0ah, 0dh, 0h
    10 00000027 20436172650A0D00   
    11                                   
    12                                  SECTION .bss
    13                                   
    14                                  SECTION     .text
    15                                  	global      _start
    16                                       
    17                                  _start:
    18                                  	;
    19                                  	;---- WELCOME ----
    20 00000000 68[00000000]                push	welcomeAct
    21 00000005 E8(00000000)                call    PrintString
    22 0000000A E8(00000000)                call 	Printendl
    23                                      
    24 0000000F 68[00000000]                push DisplayText
    25 00000014 E8(00000000)                call PrintString
    26 00000019 53                          push ebx
    27 0000001A E8(00000000)                call Print32bitNumHex
    28                                      
    29                                      ;--- GOODBYE----
    30 0000001F 68[1E000000]                push byeAct
    31 00000024 E8(00000000)                call PrintString
    32 00000029 E8(00000000)                call Printendl
    33                                  ;
    34                                  ;Setup the registers for exit and poke the kernel
    35                                  Exit: 
    36 0000002E B801000000              	mov		eax,sys_exit				;What are we going to do? Exit!
    37 00000033 BB00000000              	mov		ebx,0						;Return code
    38 00000038 CD80                    	int		80h							;Poke the kernel