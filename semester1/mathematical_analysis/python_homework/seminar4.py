def sum(n):
  sum = 0
  minus = -1
  for i in range(1, n):
    sum -= minus / i
  minus *= (-1)
  return sum

if __name__ == '__main__':
  while True:
    print("1. limit of the series ((-1)^(n+1))/n")
    print("0. exit")
    userInput = input(">")
    if userInput.isdigit():
      if int(userInput) == 0:
        exit()
      else:
        print(sum(1001), "->", 0.69314718056)
    else:
      print("this option doesn't exist! try again!")
    