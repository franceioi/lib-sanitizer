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



TestNoTest() {
  for shell in $available_shells
  do
    SuiteWithNoTest() {
      runEmbeddedTest $shell "Suite() { :; }"
    }
    stdout=`SuiteWithNoTest 2>/dev/null`
    stderr=`SuiteWithNoTest 2>&1 >/dev/null`
    [ 127 -eq $? ]
    shuAssert "Expected exit code 127 with $shell" $?
    assertContains 'shUnit: No tests to run' "$stderr" "$shell"
  done
}

Test1SuccessfulTest() {
  for shell in $available_shells
  do
    stdout=`runEmbeddedTest $shell "
      SuccessfulTest() { shuAssert 'Always true' 0; }
      Suite() { shuRegTest SuccessfulTest; }"`
    [ 0 -eq $? ]
    shuAssert "Expected exit code 0 with $shell" $?
    assertContains '1 test succeeded.' "$stdout" "$shell"
    assertContains 'No tests failed.' "$stdout" "$shell"
  done
}

Test1FailingTest() {
  for shell in $available_shells
  do
    stdout=`runEmbeddedTest $shell "
      FailingTest() { shuAssert 'Always false' 1; }
      Suite() { shuRegTest FailingTest; }"`
    [ 1 -eq $? ]
    shuAssert "Expected exit code 1 with $shell" $?
    assertContains 'No tests succeeded.' "$stdout" "$shell"
    assertContains '1 test failed.' "$stdout" "$shell"
  done
}

Test2SuccessfulTests() {
  for shell in $available_shells
  do
    stdout=`runEmbeddedTest $shell "
      FirstSuccessfulTest() { shuAssert 'Always true' 0;  }
      SecondSuccessfulTest() { shuAssert 'Always true' 0; }
      Suite() { shuRegTest FirstSuccessfulTest; shuRegTest SecondSuccessfulTest; }"`
    [ 0 -eq $? ]
    shuAssert "Expected exit code 0 with $shell" $?
    assertContains '2 tests succeeded.' "$stdout" "$shell"
    assertContains 'No tests failed.' "$stdout" "$shell"
  done
}

Test1SuccessAnd1FailureInTheSameTest() {
  for shell in $available_shells
  do
    stdout=`runEmbeddedTest $shell "
      TestWithASuccessAndAFailure() {
        shuAssert 'Always false' 1
        shuAssert 'Always true' 0
      }
      Suite() { shuRegTest TestWithASuccessAndAFailure; }"`
    [ 1 -eq $? ]
    shuAssert "Expected exit code 1 with $shell" $?
    assertContains 'No tests succeeded.' "$stdout" "$shell"
    assertContains '1 test failed.' "$stdout" "$shell"
  done
}

Test1SuccessAnd1FailureInDifferentTests() {
  for shell in $available_shells
  do
    stdout=`runEmbeddedTest $shell "
      SuccessfulTest() {  shuAssert 'Always true' 0; }
      FailingTest() { shuAssert 'Always false' 1; }
      Suite() { shuRegTest SuccessfulTest; shuRegTest FailingTest; }"`
    [ 1 -eq $? ]
    shuAssert "Expected exit code 1 with $shell" $?
    assertContains '1 test succeeded.' "$stdout" "$shell"
    assertContains '1 test failed.' "$stdout" "$shell"
  done
}

Test126FailingTests() {
  scriptWith126Failures=`scriptWithNFailures 126`
  
  for shell in $available_shells
  do
    stdout=`runEmbeddedTest $shell "$scriptWith126Failures"`
    [ 126 -eq $? ]
    shuAssert "Expected exit code 126 with $shell" $?
  done
}

Test127FailingTests() {
  scriptWith127Failures=`scriptWithNFailures 127`
  
  for shell in $available_shells
  do
    stdout=`runEmbeddedTest $shell "$scriptWith127Failures"`
    [ 126 -eq $? ]
    shuAssert "Expected exit code 126 with $shell" $?
  done
}

TestShuStartWith2Arguments() {
  for shell in $available_shells
  do
    shuStartWith2Arguments() {
      $shell <<-EOF
        Test1() { shuAssert 'Always true' 0; }
        Suite1() { shuRegTest Test1; }
        Suite2() { shuRegTest Test1; }
        . "../shUnit"
        shuStart Suite1 Suite2
EOF
    }
    stdout=`shuStartWith2Arguments 2>/dev/null`
    stderr=`shuStartWith2Arguments 2>&1 >/dev/null`
    
    shuDeny "Exit code should be KO" $?
    
    test "" = "$stdout"
    shuAssert "Standard output should be empty for $shell" $?
    
    test "shuStart: invalid number of arguments -- 2" = "$stderr"
    shuAssert "Error message for $shell" $?
  done
}

#
# Support Functions
#

assertContains() {
  expected_substring="$1"
  actual_string="$2"
  shell="$3"
  
  echo "$actual_string" | grep -q "$expected_substring"
  shuAssert "Expected '$expected_substring' with $shell" $?
}

getAvailableShellsAmong() {
  known_shells="$1"
  for shell in $known_shells
  do
    if (exec $shell -c exit 2>/dev/null)
    then
      echo -n "$shell "
    fi
  done
}

runEmbeddedTest() {
  shell="$1"
  embedded_script="$2"
  
  $shell <<-EOF
    $embedded_script
    . "../shUnit"
    shuStart Suite
EOF
}

scriptWithNFailures() {
  failingTestCount=${1}

  failingTestIdx=1
  testDeclarations=""
  testRegistration=""
  while [ $failingTestIdx -le $failingTestCount ]
  do
    testName="FailingTest$failingTestIdx"
    testDeclarations="$testDeclarations $testName() { shuAssert 'Always false' 1; };"
    testRegistration="$testRegistration shuRegTest $testName;"
    failingTestIdx=`expr $failingTestIdx + 1`
  done
  echo "$testDeclarations Suite() { $testRegistration }"
}

#
# Main
#

. "../ext/shUnit/shUnit"
. "common.sh"

shuStart Suite
