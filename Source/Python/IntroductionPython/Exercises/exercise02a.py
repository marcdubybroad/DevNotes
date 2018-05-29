



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



