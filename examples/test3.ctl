string myKey;

int conversionMiliSeconds = 1000;
string returnKey = "Return";

outstring "Press a key and the program will echo it.\n";

while (1) {
	myKey = instring;
	presskey myKey;
	pause 100*conversionMiliSeconds;
	releasekey myKey;
	
	presskey returnKey;
	pause 100*conversionMiliSeconds;
	releasekey returnKey;
	
	myKey = instring;
}

