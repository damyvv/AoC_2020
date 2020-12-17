lines = File.read("day13_input.txt").lines
timestamp = lines[0].to_i
busses = lines[1].strip.split(',')

# Part 1
p busses.select { |s| s != 'x' }.map { |i| { id: i.to_i, diff: i.to_i - (timestamp % i.to_i) } }.min { |a,b| a[:diff] <=> b[:diff] }.values.reduce(:*)

# Part 2
busses = busses.map.with_index { |b,idx| { id: b.to_i, idx: idx } }.select {|b| b[:id] != 0 }

calc_timestamp = busses.shift[:id]
lcm = calc_timestamp
while next_b = busses.shift
    next_timestamp = calc_timestamp
    loop do
        break if (next_timestamp + next_b[:idx]) % next_b[:id] == 0
        next_timestamp += lcm
    end
    calc_timestamp = next_timestamp
    lcm = lcm.lcm(next_b[:id])
end
p calc_timestamp
