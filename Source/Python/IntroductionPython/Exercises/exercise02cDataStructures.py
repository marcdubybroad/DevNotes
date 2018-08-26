
# Lists: declared by square brackets, can be mutable and mix of data types
list_of_randon = ['dude', 'man', 1, 2.3]
list_of_randon[1]       # get an element
list_of_randon[1:2]     # get a list

months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul']

# subset
months[2:4]     # Mar to Apr; upper bound not inclusive
months[:3]      # Jan to Mar; upper bound not inclusive
months[0:2] = ['January', 'February']       # use slicing to replace
print(sorted(months, reverse = True))       # get new sorted list, original list is unchanged

# join function
new_str = "-".join(["fore", "aft", "starboard", "port"])
print(new_str)              # get: fore-aft-startboard-port

# contains
greeting = "hello there"
print('her' in greeting)            # True


# quiz 01
month = 8
days_in_month = [31,28,31,30,31,30,31,31,30,31,30,31]
# use list indexing to determine the number of days in month
num_days = days_in_month[month - 1]
print(num_days)


# quiz 02
eclipse_dates = ['June 21, 2001', 'December 4, 2002', 'November 23, 2003',
                 'March 29, 2006', 'August 1, 2008', 'July 22, 2009',
                 'July 11, 2010', 'November 13, 2012', 'March 20, 2015',
                 'March 9, 2016']
# TODO: Modify this line so it prints the last three elements of the list
third_to_end_index = len(eclipse_dates) - 3
print(eclipse_dates[third_to_end_index:])
print(eclipse_dates[-3:])


# quiz 03
names = ["Carol", "Albert", "Ben", "Donna"]
names.append("Eugenia")
print(sorted(names))                # get: ['Albert', 'Ben', 'Carol', 'Donna', 'Eugenia']

# quiz 04
a = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
b = set(a)
print(len(a) - len(b))              # get: 6 -> 10 - 4




