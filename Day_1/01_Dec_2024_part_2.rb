# Collect all the numbers into a list and split them up into a list 1 of odd n and list 2 of even n
# retrun these as two seperate lists 


# Read the data from the file 
input_file = File.open("data.txt")
input_data = input_file.read

# Split all the data into an array of numbers
numbers = input_data.split(" ").map(&:to_i)

# Take every number in an even index into one array, and every number in an odd index into another array
# This will split the numbers into right and left 
# array_1 is the right side
array_1 = []
numbers.each_with_index do |num, index|
  array_1 << num if index.even?
end

# array_2 is the left side
array_2 = []
numbers.each_with_index do |num, index|
  array_2 << num if index.odd?
end

# Go through each number in array_1 and find out how many times it appears in array_2
# Each time the count is above 0, multiply the number from array_1 by the count and add it to a sum
sum = 0
array_1.each do |num|
  count = array_2.count(num)
  sum += num * count
end
puts sum
