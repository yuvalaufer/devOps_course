#first import date and time
from datetime import datetime 
# assign the output of the datetime.now to now parameter
now = datetime.now()

print '%s/%s/%s' % (now.day, now.month, now.year)
print '%s:%s:%s' % (now.hour, now.minute, now.second)
