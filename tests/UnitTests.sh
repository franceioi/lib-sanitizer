#! /usr/bin/env 

#
# Test Cases
#

Suite() {
   shuRegTest Init
   shuRegTest TestMain
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
   fi
   rm -f prog
}

TestMain()
{
   compileFile src/main.cpp 2>> errLog
   shuAssert "Expected compilable file." $?
   ./prog < inputs/main.in 2>> errLog
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
