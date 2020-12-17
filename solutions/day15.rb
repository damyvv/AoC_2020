input = File.read("day15_input.txt").strip.split(',').map(&:to_i)

# Part 1 & 2
seen = input.map.with_index { |i,idx| { i => [idx+1] } }.reduce(:merge!)
last = input[-1]
turn = input.count

while turn < 30000000
    turn += 1
    last = seen[last][1] ? seen[last][0] - seen[last][1] : 0
    seen[last] = [] if !seen.key?(last)
    seen[last][0],seen[last][1] = turn,seen[last][0]
    p last if turn == 2020
end
p last
