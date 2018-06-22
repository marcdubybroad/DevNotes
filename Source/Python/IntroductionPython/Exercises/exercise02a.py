



# avg electric bill quiz
x = 23 + 32 + 64
xAvg = x / 3
print (xAvg)

# tiling of floor
# 9 tiles wide by 7 tiles long
floor1 = 9 * 7
# 5 tiles wide by 7 tiles long
floor2 = 5 * 7

totalFloor = floor1 + floor2
print (totalFloor)

# if 17 boxes of 6 tiles each, how many left over
floorLeftOver = (17 * 6) - totalFloor
print (floorLeftOver)



# The current volume of a water reservoir (in cubic metres)
reservoir_volume = 4.445e8
# The amount of rainfall from a storm (in cubic metres)
rainfall = 5e6

# decrease the rainfall variable by 10% to account for runoff
rainfall *= 0.90
# print (rainfall)

# add the rainfall variable to the reservoir_volume variable
reservoir_volume += rainfall
# print (reservoir_volume)

# increase reservoir_volume by 5% to account for stormwater that flows
# into the reservoir in the days following the storm
reservoir_volume *= 1.05
# print (reservoir_volume)

# decrease reservoir_volume by 5% to account for evaporation
reservoir_volume *= 0.95
# print (reservoir_volume)

# subtract 2.5e5 cubic metres from reservoir_volume to account for water
# that's piped to arid regions.
reservoir_volume -= 2.5e5

# print the new value of the reservoir_volume variable
print (reservoir_volume)






sf_population, sf_area = 864816, 231.89
rio_population, rio_area = 6453682, 486.5

san_francisco_pop_density = sf_population/sf_area
rio_de_janeiro_pop_density = rio_population/rio_area

# Write code that prints True if San Francisco is denser than Rio, and False otherwise
sanfranciso_denser = (san_francisco_pop_density > rio_de_janeiro_pop_density)
print(sanfranciso_denser)


# TODO: Fix this string!
ford_quote = 'Whether you think you can, or you think you can\'t--you\'re right.'


username = "Kinari"
timestamp = "04:50"
url = "http://petshop.com/pets/mammals/cats"

# TODO: print a log message using the variables above.
# The message should have the same format as this one:
# "Yogesh accessed the site http://petshop.com/pets/reptiles/pythons at 16:20."

print(username + " accessed the site " + url + " at " + timestamp + ".")


given_name = "William"
middle_names = "Bradley"
family_name = "Pitt"

full_name = given_name + " " + middle_names + " " + family_name;
name_length = len(full_name) #todo: calculate how long this name is

# Now we check to make sure that the name fits within the driving license character limit
# Nothing you need to do here
driving_license_character_limit = 28
print(name_length <= driving_license_character_limit)


mon_sales = "121"
tues_sales = "105"
wed_sales = "110"
thurs_sales = "98"
fri_sales = "95"

#TODO: Print a string with this format: This week's total sales: xxx
# You will probably need to write some lines of code before the print statement.

total_sales = int(mon_sales) + int(tues_sales) + int(wed_sales) + int(thurs_sales) + int(fri_sales)
print("This week's total sales: " + str(total_sales))


