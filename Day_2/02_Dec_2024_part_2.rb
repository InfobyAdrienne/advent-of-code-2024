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

  # safe reports so far is 486
  safe_reports = reports.size - unsafe_reports.size

  require 'set'

  # Generate all possible modified reports by removing one element at a time
  modified_safe_reports = unsafe_reports.flat_map do |unsafe_report| 
    unsafe_report.each_index.map do |index|
      [unsafe_report, unsafe_report.dup.tap { |arr| arr.delete_at(index) }]
    end
  end
  
  # Use a set to track unique safe reports and original arrays that have been deemed safe
  unique_safe_reports = Set.new
  original_safe_reports = Set.new
  
  # Select the reports that meet the safety criteria
  modified_safe_reports.each do |original_report, report|
    # Skip further processing if the original report has already been deemed safe
    next if original_safe_reports.include?(original_report)
  
    consecutive_safe = report.each_cons(2).all? do |a, b|
      (a - b).abs < 4 && (a - b).abs > 0
    end
  
    order_safe = report.sort == report || report.sort.reverse == report
  
    if consecutive_safe && order_safe
      unique_safe_reports.add(report)
      original_safe_reports.add(original_report)
    end
  end

  puts unique_safe_reports.size + safe_reports

  # puts unique_safe_reports to debug what is happening
  # {[40, 42, 44, 47, 49, 50], 
  #   [65, 67, 70, 71, 72, 75], 
  #   [74, 76, 78, 81, 83, 85, 87], 
  #   [73, 76, 79, 81, 82, 85, 86], 
  #   [64, 67, 69, 70, 71, 72], 
  #   [57, 59, 61, 64, 65, 66], 
  #   [14, 16, 18, 19, 21, 24, 27], 
  #   [36, 37, 38, 39], 
  #   [74, 77, 79, 82, 83, 85, 88], 
  #   [76, 77, 79, 82, 83, 85, 88], # this is being counted twice 
  #   [67, 70, 72, 73], 
  #   [52, 53, 56, 58, 59], 
  #   [33, 36, 37, 40, 42, 45, 47], 
  #   [23, 24, 26, 27], 
  #   [26, 27, 29, 30, 33, 36], 
  #   [63, 61, 59, 58], # this is being counted twice - probably more being counted twice
  #   [63, 61, 59, 56], 
  #   [83, 80, 78, 77], 
  #   [37, 34, 32, 30, 29], 
  #   [78, 77, 75, 72, 69, 67], 
  #   [45, 44, 41, 40], 
  #   [45, 42, 41, 40], 
  #   [57, 56, 55, 54, 52, 51], 
  #   [32, 29, 26, 23], 
  #   [31, 29, 26, 23], 
  #   [65, 63, 61, 59, 56, 55, 54], 
  #   [17, 16, 15, 12, 10, 7, 5], 
  #   [78, 76, 75, 72, 70, 69], 
  #   [97, 94, 93, 90, 88], 
  #   [3, 6, 9, 12, 15, 18, 19], 
  #   [53, 55, 56, 58, 59], 
  #   [43, 45, 47, 49, 52], 
  #   [11, 12, 15, 18], 
  #   [49, 50, 53, 55, 58], 
  #   [49, 51, 53, 55, 58], 
  #   [60, 63, 66, 68, 71, 73], 
  #   [70, 71, 72, 75, 77, 79], 
  #   [77, 80, 83, 85, 88], 
  #   [79, 80, 83, 85, 88], 
  #   [73, 76, 78, 81, 84, 87], 
  #   [45, 47, 50, 52, 53], 
  #   [49, 50, 51, 53, 55], 
  #   [69, 71, 74, 76, 78], 
  #   [44, 46, 48, 49], 
  #   [81, 84, 87, 89, 91, 92, 95], 
  #   [29, 32, 35, 37], 
  #   [46, 44, 41, 39, 38], 
  #   [40, 39, 36, 35, 33, 31, 28], 
  #   [97, 96, 94, 92, 90], 
  #   [79, 77, 76, 75, 73, 70], 
  #   [88, 87, 86, 85, 83, 81, 78], 
  #   [97, 96, 94, 92, 90, 88], 
  #   [74, 72, 70, 68, 65, 62, 60], 
  #   [88, 86, 85, 82, 79, 77], 
  #   [91, 90, 89, 86, 85], 
  #   [60, 57, 55, 52, 49, 46, 44], 
  #   [74, 72, 71, 68, 67, 66], 
  #   [2, 3, 4, 5, 7], 
  #   [27, 28, 30, 32, 35, 37], 
  #   [56, 54, 52, 51, 49]}>