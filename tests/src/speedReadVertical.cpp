#if MODE == 3
   #include "sanitizer.h"
#else
   #include <cstdio>
   #include "BuffChecker.h"
#endif

#if MODE == 1
LBuffer BuffCheck;
#endif


int main()
{
   int nbIntegers, sum = 0, checkSum;

   // scanf
   #if MODE == 0
   printf("Using scanf :\n");
   scanf("%d", &nbIntegers);
   int val;
   for(int i = 0 ; i < nbIntegers; i++)
   {
      scanf("%d", &val);
      sum += val;
   }
   #endif
   // buffer
   #if MODE == 1
   printf("Using the buffer :\n");
   nbIntegers = BuffCheck.getInt();
   BuffCheck.getChar('\n');
   int val;
   for(int i = 0 ; i < nbIntegers; i++)
   {
      val = BuffCheck.getInt();
      BuffCheck.getChar('\n');
      sum += val;
   }
   #endif
   // improved buffer
   #if MODE == 2
   FastIO fio;
   printf("Using improved buffer :\n");
   nbIntegers = fio.getInt();;
   fio.getChar('\n');
   int val;
   for(int i = 0 ; i < nbIntegers; i++)
   {
      val = fio.getInt();
      fio.getChar('\n');
      sum += val;
   }
   checkSum = fio.getInt();
   fio.getChar('\n');
   #endif
   // library
   #if MODE == 3
   printf("Using the library (adding some overhead) :\n");
   nbIntegers = cInt::read();
   for(int i = 0 ; i < nbIntegers; i++)
   {
      cInt val = cInt::read();
      sum += val;
   }
   checkSum = cInt::read();
   #endif

   #if MODE != 3
   scanf("%d", &checkSum);
   #endif
   if (checkSum != sum)
   {
      printf("ERROR %d vs %d!!", checkSum, sum);
      return 1;
   }
   return 0;
}
