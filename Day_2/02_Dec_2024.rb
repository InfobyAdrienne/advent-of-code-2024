# Read the data from the file 
input_file = File.open("data2.txt")
input_data = input_file.read

# Split the data so that each row/report is an array 
reports = input_data.split("\n")

# Turn each report into an array of integers
reports = reports.map {
  |report| report.split(" ").map(&:to_i)
}

# Look through each report to see if it's safe or not safe 
# Mark all reports with gaps larger than 3 as unsafe
# Mark all report that are not descending or ascending as unsafe
  
  unsafe_reports = reports.select do |report|
    # Check consecutive numbers gap differ by at least one or at most 3
    consecutive_unsafe = report.each_cons(2).any? do |a, b|
      (a - b).abs > 3 || (a - b).abs < 1
    end

    # Check if the numbers are in ascending or descending order
    order_unsafe = report.sort != report && report.sort.reverse != report

    consecutive_unsafe || order_unsafe
  end

  puts reports.count - unsafe_reports.size