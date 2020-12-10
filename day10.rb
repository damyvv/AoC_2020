input = File.read("day10_input.txt").split.map(&:to_i)
input += [0, input.max + 3]
input.sort!

# Part 1
diff = input.each_cons(2).map {|a| a.reverse.reduce(:-) }
p diff.tally.to_a.map {|e| e[1]}.reduce(:*)

# Part 2
def tribonacci(idx)
    @cache[0] rescue @cache = [0, 1, 1]
    return @cache[idx] if @cache[idx]
    @cache[idx] = (1..3).map {|n| tribonacci(idx-n) }.sum
end

groups = diff.join.split('3').select { |s| s.length > 0 }
p groups.map {|s| tribonacci(s.length+1) }.reduce(:*)
