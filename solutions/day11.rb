input = File.read("day11_input.txt").strip.lines.map {|l| l.strip.chars }

# Part 1
def all_adjacent(input,x,y)
    adj = 0
    ([0, y-1].max..[input.length-1, y+1].min).each do |ay|
        ([0, x-1].max..[input[0].length-1, x+1].min).each do |ax|
            next if ay == y && ax == x
            adj += 1 if input[ay][ax] == '#'
        end
    end
    adj
end

def simulate_seats(input, occupied, adjacent)
    places = input
    loop do
        new_places = Array.new(input.length) { Array.new(input[0].length, '.') }
        places.each_with_index do |r,y|
            r.each_with_index do |c,x|
                next if c == '.'
                adj = adjacent.call(places, x, y)
                if c == 'L' && adj == 0
                    new_places[y][x] = '#'
                elsif c == '#' && adj >= occupied
                    new_places[y][x] = 'L'
                else
                    new_places[y][x] = c
                end
            end
        end
        # puts "#{ new_places.map{|l|l.join}.join("\n") }"
        break if new_places == places
        places = new_places
    end
    places
end

puts simulate_seats(input, 4, method(:all_adjacent)).join.count('#')

# Part 2
def seen_adjacent(input,x,y)
    height = input.length
    width = input[0].length
    adj = 0
    (-1..1).each do |ay|
        (-1..1).each do |ax|
            next if ay == 0 && ax == 0
            idy = y+ay
            idx = x+ax
            loop do
                break if !idy.between?(0, height-1) || !idx.between?(0, width-1)
                if input[idy][idx] == '#'
                    adj += 1
                    break
                elsif input[idy][idx] == 'L'
                    break
                end
                idy += ay
                idx += ax
            end
        end
    end
    adj
end

puts simulate_seats(input, 5, method(:seen_adjacent)).join.count('#')
