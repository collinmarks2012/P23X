//************************************************************************
// This program calculates pi.
// It uses the the Salamin-Brent algorithm.
// It uses only the primitive floating point operations.
// - It does its own calculation of square roots.
// - It converts the floating point value to characters for printing.
//
// Owner:   Dana Lasher
//
// Version: 0611
//************************************************************************

#include <stdio.h>

float  froot  (float n);               // model for square root subroutine
void   output (float n);               // model for printing pi

int main()
{
   float a, b, c, d, s, t, pi, old;    // variables

     a   = (float)1.0;                 // a0 = 1
     b   = (float)1.0 ;                // b0 = 1
     b   = b / froot ((float)2.0);     // b0 = 1 / sqrt(2)
     s   = (float)1.0;                 // s is the sum in the denominator
     t   = (float)1.0;                 // the first value of 2**k when k = 0
     old = (float)0.0;                 // last value of pi calculated

   while (1)                           // loop forever
      {
      s = s - t * (a - b) * (a - b);   // subtract next value of sum from s
      pi = 4 * a * a / s;              // calc new value of pi
      c = (a + b) / 2.0;               // calc an+1 = (an + bn)/2
      d = froot (a * b);               // calc bn+1 = sqrt(an * bn)
      a = c;                           // set an+1
      b = d;                           // set bn+1
      t = 2 * t;                       // calc next value of 2**k
      output(pi);                      // print the current value of pi
      if (pi == old) break;            // exit the loop if pi is not changing
      old = pi;                        // save the current value of pi
      }

return (0);                            // exit
}



//************************************************************************
// Calculate square root of input n using the Newton iteration method.
// new_guess =  1/2 * (old_guess + n/old_guess)
//************************************************************************
float froot(float n)                   // square root subroutine
{
   float x, g=(float)0.0;              // x=new_guess   g=old_guess

   x = n/2.0;                          // guess that the root = n/2

   while ( x != g )                    // loop until new_guess == old_guess
      {
      g = x;                           // save old_guess
      x = (float)0.5*(g + n/g);        // calculate new_guess
      }

   return(x);                          // return
}



//************************************************************************ */
// Output each digit of a float n = 3.14159... up to 6 digits.
// Operation: Output the integer 3, then remove the 3 so n = .14159...,
// then multiply n by 10 so n = 1.4159..., then repeat.
//************************************************************************
void output(float n)                   // convert float to 16 characters
{
   int   i,j;                          // i == next digit  j is a counter
   float temp;                         // temp stores the working value
   int   first=0;                      // first digit switch

   for (j=0;j<6;j++)                   // get 16 digits from a float
      {
      i=(int)n;                        // i = integer part of float
      printf("%d",i);                  // print i
      if (first==0)                    // after the 3
         {
         printf(".");                  // print a decimal point
         first=1;                      // turn off first digit switch
         }
      temp=i;                          // temp == integer part
      n=n-temp;                        // remove integer part from n
      n=n*10.0;                        // multiply n by 10 to get next digit
      }
   printf("%\n");                      // print new line
}

