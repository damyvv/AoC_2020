require 'set'

input = File.read("day24_input.txt").lines.map { |l| l.scan(/e|se|sw|w|nw|ne/) }

# Part 1
movements = [[1,-1,0],[0,-1,1],[-1,0,1],[-1,1,0],[0,1,-1],[1,0,-1]]
tiles = Set.new
input.each do |instl|
    coord = [0,0,0]
    instl.each do |inst|
        case inst
        when 'e'  then coord=[coord,movements[0]].transpose.map(&:sum)
        when 'se' then coord=[coord,movements[1]].transpose.map(&:sum)
        when 'sw' then coord=[coord,movements[2]].transpose.map(&:sum)
        when 'w'  then coord=[coord,movements[3]].transpose.map(&:sum)
        when 'nw' then coord=[coord,movements[4]].transpose.map(&:sum)
        when 'ne' then coord=[coord,movements[5]].transpose.map(&:sum)
        end
    end
    tiles ^= [coord]
end
p tiles.length

# Part 2
100.times do
    to_check = tiles.clone
    next_tiles = tiles.clone
    tiles.each { |tile| movements.each { |mov| to_check.add([tile,mov].transpose.map(&:sum)) } }
    to_check.each do |tile|
        bn = movements.count {|mov| tiles.include?([tile,mov].transpose.map(&:sum)) }
        if tiles.include?(tile) && !bn.between?(1,2)
            next_tiles.delete(tile)
        elsif !tiles.include?(tile) && bn == 2
            next_tiles.add(tile)
        end
    end
    tiles = next_tiles
end
p tiles.length
