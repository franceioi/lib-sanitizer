// Convertisseur d’unités
// http://www.france-ioi.org/algo/task.php?idChapter=509&idTask=0&sTab=task&iOrder=6
#include "sanitizer.h"
int main()
{
  cInt N = cInt::read().in(1, 10);
  for (int i = 1; i <= N ; i++)
  {
     cDouble::read(' ');// Read and eat the space after
     cChar::read().in("mgc");
  }
}
