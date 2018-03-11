# starting script

def larger_num(first , second):
    if first > second:
      print "%s is the larger then %s." % (first, second)
    elif first < second:
      print "%s is the larger then %s." % (second , first)
    else:
      print "%s is equal to %s." % (first , second)


def attach_strs (first , second):
    return first + second


def word_count (string1):
    return len(string1.split())


choice = raw_input('''choose an option:
1 - for checking which of the 2 numbers is larger
2 - for joining 2 strings
3 - for counting how many words in a string
''')

if choice == '1':
  fnum = raw_input('enter first number: ')
  snum = raw_input('enter second number: ') 
  if not float(fnum).is_integer or not float(snum).is_integer
    print "not a valid integer!" ; import sys; sys.exit(1)
  larger_num(fnum, snum)
elif choice == '2':
  print 'choice is 2'
elif choice == '3':
  print 'choice is 3'
else:
  print "choice is not valid!" ; import sys; sys.exit(1)

