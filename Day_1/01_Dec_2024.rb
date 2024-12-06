# Collect all the numbers into a list and split them up into a list 1 of odd n and list 2 of even n
# retrun these as two seperate lists 


# Read the data from the file 
input_file = File.open("data.txt")
input_data = input_file.read

# Split the data into an array of numbers
numbers = input_data.split(" ").map(&:to_i)

# Take every number in an even index into one array, and every number in an odd index into another array
array_1 = []
numbers.each_with_index do |num, index|
  array_1 << num if index.even?
end

array_2 = []
numbers.each_with_index do |num, index|
  array_2 << num if index.odd?
end

# Order these two arrays from smallest to largest numbers
array_1 = array_1.sort 
array_2 = array_2.sort

# Do some maths, find the difference between the nth number in array 1 and the nth number in array 2
# Return these differences in an array 
differences = []
array_1.each_with_index do |num, index|
  difference = (num > array_2[index]) ? num - array_2[index] : array_2[index] - num
  differences << difference
end

# Add the differences together
sum = differences.sum
print sum

