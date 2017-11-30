# Assisted click

int click;

while (1) {


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
