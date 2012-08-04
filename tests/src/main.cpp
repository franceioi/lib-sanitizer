#include "sanitizer.h"

// Example of personalize checker
template <typename T>
struct _in
{
   T minVal, maxVal;
   _in(T _a, T _b){minVal=_a;maxVal=_b;}
   
   template <typename C>
   void operator()(const C & caller, const T val, bool _true = true) const {
      const bool good = (val >= minVal) && (val <= maxVal); 
      if (!good == _true)
      {
         std::stringstream ss;
         ss << "The condition " << minVal << " <= " << val << " <= " << maxVal << " should be " << _STB(_true);
         caller.error(ss.str());
      }
   }
};

int main()
{
   cInt N = cInt::read().greater(5);
   cVector<int> VV = cVector<int>::read(10).in(1, 10);

   N.divisibleBy(2);
   cDouble X = cDouble::read(' ').greater(5.1, false);
   
   cVector<int> V = cVector<int>::read(5).call(_in<int>(-100,100)).divisibleBy(2);
   
   cMatrix<char> M = cMatrix<char>::read(2, 2).smaller('m');

   cString SS = cString::read(8, '\0').in("abcdefgh");
}

