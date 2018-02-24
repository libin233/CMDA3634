#include <stdio.h>
#include <math.h>
#include <stdbool.h>
int main()
{
int n;
printf("Enter a prime number: ");
scanf("%d", &n);
for(int i=1;i<n;i++)
{
    int c=1;
    for(int j=1; j<n-1; j++)
    {
       if((int)pow(i,j) % n==1)
        {
          c=0; 
        }
     }
    if(c!=0)
    {
       printf("%d is a generator of Z_%d \n", i, n);
    }
}
return 0;
}
