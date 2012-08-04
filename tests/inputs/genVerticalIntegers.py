nbIntegers = int(input())
print(nbIntegers)
s = 0
for i in range(nbIntegers):
   s = s + i
   print(i)
print( ((s+2**31) % (2**32)) - 2 ** 31)
