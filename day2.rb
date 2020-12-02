input = File.read("day2_input.txt").lines.map do |l|
    a = l.split(' ')
    mm = a[0].split('-')
    { first: mm[0].to_i, second: mm[1].to_i, char: a[1][0], password: a[2] }
end

# Part 1
l = input.select do |i|
    count = i[:password].split('').tally[i[:char]] || 0
    count.between?(i[:first], i[:second])
end
puts l.size

# Part 2
l = input.select do |i|
    chars = i[:password].split('')
    (chars[i[:first]-1] == i[:char]) ^ (chars[i[:second]-1] == i[:char])
end
puts l.size
