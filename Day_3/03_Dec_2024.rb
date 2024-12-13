input_file = File.open("data.txt")
input_data = input_file.read

# Use regex to define what a valid mul looks like, mul(XXX, XXX)
def mul(a,b)
  a * b
end

multiplications = []
total = []

# Use regex to define what a valid mul looks like, mul(XXX, XXX)
input_data.scan(/mul\(\d{1,3},\d{1,3}\)/) do |match|
  multiplications.push(match)

  # Extract the numbers from the string "mul(a,b)"
  numbers = match.scan(/\d+/).map(&:to_i)

  # Call the mul function with the extracted numbers
  results = mul(numbers[0], numbers[1])

  # Add the result together 
  # turning results into an array to use sum
  total.push(results)
end

puts total.sum