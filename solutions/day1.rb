input = File.read("day1_input.txt").lines.map { |l| l.to_i }

# Part 1
input.combination(2) { |a| puts a[0]*a[1] if a[0]+a[1] == 2020 }

# Part 2
input.combination(3) { |a| puts a[0]*a[1]*a[2] if a[0]+a[1]+a[2] == 2020 }
