#include <stdio.h>
int main()
{
 int a, b, i, gcd, lcm;
 printf("Enter first number: ");
 scanf("%d", &a);
 printf("Enter second number: ");
 scanf("%d", &b);
 for(i=1; i<=a && i<=b; ++i)
 {
	if(a%i==0 && b%i==0)
	   gcd=i;
 }
 
 lcm=(a*b)/gcd;
 printf("The least common multiple of %d and %d is %d\n", a, b, lcm);
return 0;
}
