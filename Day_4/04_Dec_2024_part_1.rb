input_file = File.open("data.txt")
input_data = input_file.read


grid = input_data.split("\n").map { |row| row.split("") }

word = "XMAS"
word_length = word.length

# Defining the directions of horizontal, vertical and diagonal 
directions = [
  [0,1], # up
  [1,0], # right
  [1,1], # up-right
  [-1,1], # up-left
  [1,-1], # down-right
  [-1,-1], # down-left
  [0,-1], # down
  [-1,0] # left
]

def search_word(grid, word, start_row, start_col, direction)
  word_length = word.length
  (0...word_length).each do |i|
    row = start_row + i * direction[0]
    col = start_col + i * direction[1]
    # Check if the position is out of bounds
    return false if row < 0 || row >= grid.length || col < 0 || col >= grid[0].length
    # Check if the character matches
    return false if grid[row][col] != word[i]
  end
  true
end

found = []
grid.each_with_index do |row, row_index|
  row.each_with_index do |cell, col_index|
    directions.each do |direction|
      if search_word(grid, word, row_index, col_index, direction)
        found << [row_index, col_index, direction]
      end
    end
  end
end

# Output the found positions
puts found.length

