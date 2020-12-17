input = File.read("day5_input.txt").gsub(/[FL]/, '0').gsub(/[BR]/, '1').lines.map { |s| s.to_i(2) }

# Part 1
p input.max

# Part 2
p (input.min..input.max).to_a.filter {|i| !input.include? i }
