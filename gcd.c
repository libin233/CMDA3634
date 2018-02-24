#include <stdio.h>
int main()
{
  int a, b, i, gcd;
  printf("Enter the first number: ");
  scanf("%d", &a);
  printf("Enter the second number: ");
  scanf("%d",&b);

  for(i =1; i<=a&&i<=b; ++i)
  {
    if(a%i==0 && b%i==0)
	gcd=i;
  }
  printf("The greatest common divisor of %d and %d is %d\n",a,b,gcd);

  return 0;
}
