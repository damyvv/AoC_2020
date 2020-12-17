# Original solution
input = File.read('day6_input.txt').strip.split("\n\n").map {|l| l.chars.tally }

# Part 1
p input.map {|l| (l.keys - ["\n"]).count }.sum

# Part 2
p input.map {|l| l.filter {|k,v| v == ((l["\n"] || 0) + 1) }.keys.count }.sum


# Another solution using sets
require 'set'

input = File.read('day6_input.txt').strip.split("\n\n").map {|l| l.split("\n").map {|s| s.chars.to_set } }

# Part 1
p input.map {|sl| sl.reduce(:|).count }.sum

# Part 2
p input.map {|sl| sl.reduce(:&).count }.sum
