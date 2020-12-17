input = File.read("day16_input.txt").split("\n\n")

props = input[0].lines.map do |l|
    m = l.match(/([^:]+): (\d+)-(\d+) or (\d+)-(\d+)/)
    { name: m[1], range: [(m[2].to_i..m[3].to_i), (m[4].to_i..m[5].to_i)] }
end

my_ticket = input[1].lines[1].strip.split(',').map(&:to_i)

other_tickets = input[2].lines[1..-1].map {|l| l.strip.split(',').map(&:to_i) }

# Part 1
all_ranges = props.map { |a| a[:range] }.flatten
valid_tickets = other_tickets.select { |t| t.all? { |n| all_ranges.any? {|r| r.include?(n) } } }

p (other_tickets-valid_tickets).map { |t| t.select { |n| !all_ranges.any? {|r| r.include?(n) } } }.flatten.sum

# Part 2
props = props.map do |prop|
    s = prop[:range].map {|r| valid_tickets.map {|t| t.map {|n| r.include? n } } }.transpose.map {|a,b| a.zip(b).map {|x,y|x|y} }
    { name: prop[:name], possible: s.reduce {|s,b| s.zip(b).map {|x,y| x&y} } }
end

ticket_headers = []
(0..props.first[:possible].count-1).each do |_|
    prop = props.select {|p| p[:possible].count {|b| b == true} == 1 }.first
    idx = prop[:possible].index(true)
    ticket_headers[idx] = prop[:name]
    props.each {|p| p[:possible][idx] = false }
end

p ticket_headers.map.with_index {|h,i| h.start_with?('departure') ? i : -1 }.select {|i| i >= 0 }.map {|i| my_ticket[i] }.reduce(&:*)
