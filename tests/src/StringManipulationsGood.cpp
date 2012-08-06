#include "sanitizer.h"

int main()
{
   // Single caracters reading
   cChar::read(' ');
   cChar::read('-');
   cChar::read('\n');
   for (int i = 1 ; i <= 5 ; i++)
      cChar::read(cChar::NO_END);
   cChar::readNewLine();

   cInt::read(cInt::NO_END);
   cChar::read('\n');


   // Line/word reading
   cString::readLine();
   cString::readLine().size().equal(34);
   cString::readWord(' ');       // word with space at the end
   cString::readWord('\n');      // word with newline at the end
   cString::read(10, ' ', '\n'); // 10 chars separated by spaces and newline at the end
   cString::readChars(10, ' ');  // 10 chars with space at the end
   cString::readChars(5, '\n');  // 10 chars with newline at the end

   // Matrix
   cMatrix<char>::read(3, 2, ' ', '\n');
   cMatrix<char>::read(3, 2, '-', '\n');
   cMatrix<char>::readLines(3);
}

