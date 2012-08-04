# Common
compileFile()
{
   fileName="${1}"
   mode="${2:--1}"

   OPTIONS=""
   if [ $mode -ne -1 ]
   then
      OPTIONS="$OPTIONS -DMODE=$mode"
   fi
   g++ -std=c++0x $OPTIONS -W -Wall -Wno-unused-result -O2 -I../src/ -o prog $fileName
}

generateInputFile()
{
   fileName="${1}"
   args="${2}"

   if [ ! -e "${fileName}.in" ]
   then
      echo "Generating ${fileName}.in file"
      echo $args | python3 "inputs/gen${fileName}.py" > "${fileName}.in"
   fi
}

removeInputFile()
{
   fileName="${1}"
   rm -f "${fileName}.in"
}

timedEvalFileWithMode()
{
   fileName="${1}"
   nbModes="${2}"
   for mode in $(seq 0 $nbModes)
   do
      compileFile $fileName $mode
      time ./prog < VerticalIntegers.in
      echo ""
      rm -f prog
   done
}

runSpeedAnalysis()
{
   set -e

   nbIntegers=$((10 * 1000 * 1000))
   
   generateInputFile "VerticalIntegers" "${nbIntegers}"

   export TK_USE_CURRENT_LOCALE=1
   printf "Number of integers to read : %'d\n" $nbIntegers
   export TK_USE_CURRENT_LOCALE=0

   echo "CHECKING SPEED READ..."
   timedEvalFileWithMode src/speedReadVertical.cpp 3

   echo "CHECKING SPEED CHECK..."
   timedEvalFileWithMode src/speedCheckVertical.cpp 1

   removeInputFile "VerticalIntegers"
}

