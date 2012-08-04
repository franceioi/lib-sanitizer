// Parenthèses
// http://www.france-ioi.org/algo/task.php?idChapter=527&idTask=0&sTab=task&iOrder=2
#include "sanitizer.h"
int main()
{
   cInt length = cInt::read().greater(0);
   cString text = cString::readline();
   text.size().equal(length);
}
