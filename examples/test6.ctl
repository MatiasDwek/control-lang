# Assisted movement and click

int movement;
int length;
int click;

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
	
	outstring "Choose click: \n 1. Right \n 2. Left \n 3. No click \n";
	
	outstring "Your choice: ";
	
	click = inint;
	
	if (click == 1) {
		rclick;
		pause 250000;
		rrelease;
	}  else {
		if (click == 2) {
			lclick;
			pause 250000;
			lrelease;
		}
	}
	
}
	


