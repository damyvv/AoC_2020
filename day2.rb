input = File.read("day2_input.txt").lines.map do |l|
    m = l.match(/(\d+)-(\d+) (\D): (\D+)/)
    { first: m[1].to_i, second: m[2].to_i, char: m[3], password: m[4] }
end

# Part 1
puts input.select {|i| i[:password].chars.count(i[:char]).between?(i[:first], i[:second]) }.size

# Part 2
puts (input.select do |i|
    chars = i[:password].chars
    (chars[i[:first]-1] == i[:char]) ^ (chars[i[:second]-1] == i[:char])
end.size)
