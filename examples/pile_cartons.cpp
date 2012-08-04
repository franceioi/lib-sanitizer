// Pile de cartons
// http://www.france-ioi.org/algo/task.php?idChapter=531&idTask=0&sTab=task&iOrder=3
#include "sanitizer.h"

using namespace std;

int main()
{
  cInt nbBoxes = cInt::read().in(1, 100 * 1000);
  vector<int> allIndices;
  int nbTot = 0;
  for (int i = 1; i <= nbBoxes + 1 ; i++)
  {
     cInt nbIns = cInt::read(' ');
     nbTot += nbIns;
     cVector<int> line = cVector<int>::read(nbIns).in(1, nbBoxes);
     for (int i = 0; i < nbIns; i++)
        allIndices.push_back(line[i]);
  }
  cVector<int> X(allIndices);
  X.unique();
  if (nbTot != nbBoxes)
     error("Wrong number !");
}
