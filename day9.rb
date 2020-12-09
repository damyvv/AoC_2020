input = File.read("day9_input.txt").split.map(&:to_i)

# Part 1
p d = input[25..-1].select.with_index { |n,i| !input[i..i+24].any? {|k| input[i..i+24].include?(n-k) } }.first

# Part 2
(4..input.count).each { |s| input.each_cons(s) { |a| return p (a.min+a.max) if a.reduce(:+) == d } }
