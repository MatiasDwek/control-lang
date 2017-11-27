string b = "hola";
int a = 3;
while (a > 1) {
	pause 1;
	a = a - 1;
}

outstring "hola";
up 100;
down -1;
left a;
right a;

rclick;
rrelease;
lclick;
rrelease;

a = inint;
outint a;
b = instring;
outstring b;

presskey b;
pause 3;
releasekey b;
