#include <stdio.h>
void main()
{
 int b;
 int c=1;
 printf("Enter a number: ");
 scanf("%d", &b);
 if(b==1)
 {
   c=0;
 }
 for(int a=2; a<b;a++)
 { 
  if(b%a==0)
	c=0;
 }
 if(c==0)
 {
   printf("%d is not prime\n", b);
 }
 else
 {
   printf("%d is prime\n", b);
 } 
}
