import sys
list1=sys.argv[1].split(",")

def add_last (a):
    a.append ( a[len(a)-1] )
    return a

add_last (list1)
print list1
