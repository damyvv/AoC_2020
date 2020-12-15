input = File.read("day15_input.txt").strip.split(',').map(&:to_i)

# Part 1
seen = input.map.with_index { |i,idx| { i => [idx+1] } }.reduce(:merge!)
last = input[-1]
turn = input.count

while turn < 30000000
    turn += 1
    if seen[last].count == 1
        last = 0
    else
        last = seen[last][0] - seen[last][1]
    end

    seen[last] = [] if !seen.key?(last)
    seen[last].unshift(turn)
    p last if turn == 2020
end
p last
