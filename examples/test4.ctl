# Assisted movement

int movement;
int length;

while (1) {

	outstring "Choose direction: \n 1. Up \n 2. Down \n 3. Right \n 4. Left \n";
	
	outstring "Your choice: ";
	
	movement = inint;
	
	outstring "Choose length: ";
	
	length = inint;
	
	if (movement == 1) {
		up length;
	}  else {
		if (movement == 2) {
			down length;
		} else {
		
			if (movement == 3) {
				right length;
			} else {
				if (movement == 4) {
					down length;
				}
			}
			
		}
	}
	

	
}
	


