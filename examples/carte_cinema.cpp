// Carte de cinéma
// http://www.france-ioi.org/algo/task.php?idChapter=527&idTask=0&sTab=task&iOrder=3
#include "sanitizer.h"
int main()
{
  const int MAX_M = 1000 * 1000, MAX_N = 100 * 1000;
  cInt N = cInt::read().in(1, MAX_N);
  cVector<int>::read(N).in(0, MAX_M);
}
