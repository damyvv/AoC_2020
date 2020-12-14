input = File.read("day14_input.txt").lines

# Part 1
mask = "X"*36
mem = {}
input.each do |l|
    if m = l.match(/([01X]{36})/)
        mask = m[1]
    elsif m = l.match(/\[(\d*)\]\D*(\d*)/)
        val = mask.gsub(/X/, '0').to_i(2)
        bit_mask = mask.gsub(/1/, '0').gsub(/X/, '1').to_i(2)
        mem[m[1].to_i] = (m[2].to_i & bit_mask) | val
    end
end
p mem.values.sum

# Part 2
mask = "X"*36
mem = {}
input.each do |l|
    if m = l.match(/([01X]{36})/)
        mask = m[1]
    elsif m = l.match(/(\d+)\D+(\d+)/)
        change_mask = mask.gsub(/1/, '0').gsub(/X/, '1').to_i(2)
        or_mask = (mask.gsub(/X/, '0').to_i(2) | m[1].to_i) & ~change_mask
        iter = change_mask
        loop do
            mem[iter | or_mask] = m[2].to_i
            break if iter == 0
            iter = (iter-1) & change_mask
        end
    end
end
p mem.values.sum
