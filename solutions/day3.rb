$input = File.read('day3_input.txt').lines.map { |l| l.chars - ["\n"] }

def trees_at_slope(right, down)
    (0..$input.size-1).step(down).count do |y|
        r = $input[y]
        r[(y*right/down) % r.size] == "#"
    end
end

# Part 1
puts trees_at_slope(3,1)

# Part 2
puts trees_at_slope(1,1) * trees_at_slope(3,1) * trees_at_slope(5,1) * trees_at_slope(7,1) * trees_at_slope(1,2)
