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
  if(gcd==1)
 {  
   printf("%d and %d are coprime\n", a, b);
 }
 else
{
printf ("%d and %d are not coprime\n", a, b);
}
  return 0;
}
