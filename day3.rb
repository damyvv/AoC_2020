$input = File.read('day3_input.txt').lines.map { |l| l.chars - ["\n"] }

def trees_at_slope(right, down)
    trees = 0
    (0..$input.size-1).step(down) do |y|
        r = $input[y]
        trees += 1 if r[(y*right/down) % r.size] == "#"
    end
    trees
end

# Part 1
puts trees_at_slope(3,1)

# Part 2
puts trees_at_slope(1,1) * trees_at_slope(3,1) * trees_at_slope(5,1) * trees_at_slope(7,1) * trees_at_slope(1,2)
