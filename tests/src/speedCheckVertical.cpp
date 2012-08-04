#include "sanitizer.h"

int main()
{
   int nbIntegers, sum = 0, checkSum = 0;
   nbIntegers = cInt::read();

   // Only read
   #if MODE == 0
   printf("Only read :\n");
   for(int i = 0 ; i < nbIntegers; i++)
   {
      cInt val = cInt::read();
      sum += val;
   }
   checkSum = cInt::read();
   #endif

   // Read + checks
   #if MODE == 1
   printf("Read + checks :\n");
   for(int i = 0 ; i < nbIntegers; i++)
   {
      cInt val = cInt::read().in(-10, 100 * 1000 * 1000);
      sum += val;
   }
   checkSum = cInt::read();
   #endif

   if (checkSum != sum)
   {
      printf("ERROR %d vs %d!!", checkSum, sum);
      return 1;
   }
   return 0;
}
