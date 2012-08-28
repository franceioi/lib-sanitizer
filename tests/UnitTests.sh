#! /usr/bin/env 

#
# Test Cases
#

Suite() {
   shuRegTest Init
   shuRegTest TestMain
   shuRegTest TestError
   shuRegTest TestStringManipulationGood
   shuRegTest TestExamples
   shuRegTest Clean
}

Init()
{
   rm -f errLog
}

Clean()
{
   shuFailedTestCount=`expr ${shuTestNbr} - ${SHU_TOTAL_NR_SUCCEEDED}`
   if [ $shuFailedTestCount -eq 1 ]
   then
      rm -f errLog
   else
      echo ""
      echo "------------------------------"
      echo "Error log :"
      cat errLog
      echo "------------------------------"
   fi
   rm -f prog
}

TestMain()
{
   compileFile src/main.cpp 2>> errLog
   shuAssert "Expected compilable file." $?
   ./prog < inputs/main.in 2>> errLog && rm -f prog
   shuAssert "Execution" $?
}

TestError()
{
   compileFile src/UserError.cpp 2>> errLog
   shuAssert "Expected compilable file." $?
   ./prog < /dev/null 2>> errLog && rm -f prog
   shuDeny "Execution" $?
}

TestStringManipulationGood()
{
   compileFile src/StringManipulationsGood.cpp 2>> errLog
   shuAssert "Expected compilable file." $?
   ./prog < inputs/StringManipulationsGood.in 2>> errLog && rm -f prog
   shuAssert "Execution" $?
}

TestExamples()
{
   for f in ../examples/*.cpp
   do
      compileFile "$f" 2>> errLog
      shuAssert "Expected compilable file '$f'." $?
   done
}

#
# Main
#

. "../ext/shUnit/shUnit"
. "common.sh"

shuStart Suite
