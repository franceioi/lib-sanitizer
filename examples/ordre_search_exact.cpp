// Densité du plastique
// http://www.france-ioi.org/algo/task.php?idChapter=525&idTask=0&sTab=task&iOrder=7
#include "sanitizer.h"
int main()
{
  const int MAX_N = 100 * 1000, MAX_D = 100 * 1000 * 1000, MAX_Q = 100 * 1000;
  cInt N = cInt::read().in(1, MAX_N);
  cVector<int>::read(N).in(0, MAX_D);
  cInt Q = cInt::read().in(1, MAX_Q);
  cMatrix<int>::read(Q, 1).in(0, MAX_D);
}
