def f1(x):
	return (x + 1, str(x) + "+1")
def f2(x):
	return (x + 2, str(x) + "+2")
def f3(x):
	return (x + 3, str(x) + "+3")
def unit(x):
 return (x, "Ops:")

def bind(t, f):
 res = f(t[0])
 return (res[0], t[1] + res[1] + ";")

x = int(input("정수 입력 : "))

print( bind(bind(bind(unit(x), f1), f2), f3) ) 