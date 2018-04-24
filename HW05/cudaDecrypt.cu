#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <time.h>

#include "cuda.h"
#include "functions.c"
__device__ unsigned int aaa(unsigned int a, unsigned int b, unsigned int p) {
  unsigned int za = a;
  unsigned int ab = 0;

  while (b > 0) {
    if (b%2 == 1) ab = (ab +  za) % p;
    za = (2 * za) % p;
    b /= 2;
  }
  return ab;
}

__device__ unsigned int bbb(unsigned int a, unsigned int b, unsigned int p) {
  unsigned int z = a;
  unsigned int aExpb = 1;

  while (b > 0) {
    if (b%2 == 1) aExpb = aaa(aExpb, z, p);
    z = aaa(z, z, p);
    b /= 2;
  }
  return aExpb;
}
__global__ void ccc(unsigned int *p, unsigned int *g, unsigned int *h, unsigned int *x){     
  int threadid = threadIdx.x; //thread number
  int blockid = blockIdx.x; //block number
  int Nblock = blockDim.x;  //number of threads in a block

  int id = threadid + blockid*Nblock;

  if (id <*p-1){ 

  if (bbb(*g,id+1,*p)==*h) {
        printf("Secret key found! x = %u \n", id+1);
        *x = id +1;
      }
 }
}







int main (int argc, char **argv) {

  /* Part 2. Start this program by first copying the contents of the main function from 
     your completed decrypt.c main function. */

 igned int n, p, g, h, x;
  unsigned int Nints;

  printf("Enter the secret key (0 if unknown): "); fflush(stdout);
  char stat = scanf("%u",&x);

  printf("Reading file.\n");

  FILE *mess;
  mess = fopen("message.txt","r");
  FILE *key;
  key = fopen("public_key.txt","r");
  fscanf(key,"%u%u%u%u", &n, &p, &g, &h);
  fscanf(mess, "%u\n", &Nints);
  unsigned int *Zmessage =
      (unsigned int *) malloc(Nints*sizeof(unsigned int));

  unsigned int *a =
      (unsigned int *) malloc(Nints*sizeof(unsigned int));
  for (unsigned int i=0;i<Nints;i++) {
    fscanf(mess,"%u %u\n", &Zmessage[i], &a[i]);
  }

  fclose(mess);
  fclose(key);


  if (x==0 || modExp(g,x,p)!=h) {
    printf("Finding the secret key...\n");
    double startTime = clock();
    

    unsigned int *pp, *gg, *hh, *xx;
    cudaMalloc(&pp, sizeof(unsigned int));
    cudaMalloc(&gg, sizeof(unsigned int));
    cudaMalloc(&hh, sizeof(unsigned int));
    cudaMalloc(&xx, sizeof(unsigned int));

    cudaMemcpy(pp, &p, sizeof(unsigned int), cudaMemcpyHostToDevice);
    cudaMemcpy(gg, &g, sizeof(unsigned int), cudaMemcpyHostToDevice);
    cudaMemcpy(hh, &h, sizeof(unsigned int), cudaMemcpyHostToDevice);

    ccc<<<(p+1022)/1024, 1024>>>(pp, gg, hh, xx);
 
    cudaMemcpy(&x, xx, sizeof(unsigned int), cudaMemcpyDeviceToHost);
 }
    double endTime = clock();

    double totalTime = (endTime-startTime)/CLOCKS_PER_SEC;
    double work = (double) p;
    double throughput = work/totalTime;

    printf("Searching all keys took %g seconds, throughput was %g values tested per second.\n", totalTime, throughput);
  }

  int bufferSize = 1024;
  unsigned char *message = (unsigned char *) malloc(bufferSize*sizeof(unsigned char));
  ElGamalDecrypt(Zmessage,a,Nints,p,x);
  unsigned int cpi = (n-1)/8;
  convertZToString(Zmessage, Nints, message, Nints*cpi);


/* Q4 Make the search for the secret key parallel on the GPU using CUDA. */

  return 0;
}
