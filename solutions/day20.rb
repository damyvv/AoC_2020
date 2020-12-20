input = File.read("day20_input.txt").split("\n\n").map do |t|
    a=t.split("\n");
    [a[0].scan(/\d+/)[0].to_i, { content: a[1..-1] }]
end

size = Math.sqrt(input.length).round

# Part 1
input.each do |tile|
    content = tile[1][:content]
    rot = content.map(&:chars).transpose.map(&:join)
    #                  Regular              Mirrored
    tile[1][:edges] = [content[0],          content[0].reverse, # Top
                       rot[-1],             rot[-1].reverse,    # Right
                       content[-1].reverse, content[-1],        # Bottom
                       rot[0].reverse,      rot[0]]             # Left
    tile[1][:solutions] = []
end

input.combination(2).each do |a,b|
    (a[1][:edges] & b[1][:edges]).each do |solution|
        ids = [a[1][:edges].index(solution), b[1][:edges].index(solution)]
        a[1][:solutions].push([b[0], ids])
        b[1][:solutions].push([a[0], ids.reverse])
    end
end

edges = input.select {|t| t[1][:solutions].map {|s| s[0]}.uniq.length == 2 }
p edges.map {|t| t[0]}.reduce(&:*)

# Part 2
image = Array.new(size) { Array.new(size) }
image[0][0] = edges.first

def rotate_tile(input, tile, from, to)
    flip_lut = [1, 0, 7, 6, 5, 4, 3, 2]
    if (from-to).odd?
        tile[1][:content] = tile[1][:content].map(&:reverse)
        tile[1][:solutions].each {|s| s[1][0] = flip_lut[s[1][0]] }
        from = flip_lut[from]
    end
    rot = (to/2-from/2) % 4
    (0..rot-1).each do |_|
        tile[1][:content] = tile[1][:content].map(&:chars).transpose.map(&:reverse).map(&:join)
        tile[1][:solutions].each {|s| s[1][0] = (s[1][0] + 2) % 8 }
    end
end

# Bit of a hack to fix the orientation of the first tile
while image[0][0][1][:solutions].map {|s| s[1][0]}.min != 2
    rotate_tile(input, image[0][0], 0, 2)
end

(0..size-1).each do |c|
    (0..size-1).each do |r|
        tile = image[c][r]
        neighbours = tile[1][:solutions]
        if c == 0 && r+1 < size
            right = neighbours.select {|n| n[1][0] == 2 }.first
            rtile = input.select {|t| t[0] == right[0] }.first
            rotate_tile(input, rtile, right[1][1], 7)
            image[c][r+1] = rtile
        end
        if c+1 < size
            below = neighbours.select {|n| n[1][0] == 5 }.first
            btile = input.select {|t| t[0] == below[0] }.first
            rotate_tile(input, btile, below[1][1], 0)
            image[c+1][r] = btile
        end
    end
end

stitched = image.map {|r| r.map {|t| t[1][:content][1..-2] }.transpose.map {|a| a.map {|sr| sr[1..-2] }.join } }.flatten

monster = "                  # \n#    ##    ##    ###\n #  #  #  #  #  #   "
monster_hash_count = monster.count("#")
monster_width = monster.split("\n")[0].length
monster = monster.gsub(/[ #]/, '#' => '1', ' ' => '0').split("\n").map {|s| s.to_i(2)}

hash_count = stitched.join.count('#')

monsters = 0
(0..7).each do |round|
    binary = stitched.map {|l| l.gsub(/[.#]/, '.' => 0, '#' => 1).to_i(2) }
    binary.each_cons(monster.length).each do |lines|
        (0..stitched[0].length-monster_width).each do |shift|
            monsters += 1 if [lines.map { |l| l >> shift }, monster].transpose.map { |a,b| (a & b) == b }.reduce(&:&)
        end
    end
    stitched = stitched.map(&:chars).transpose.map(&:reverse).map(&:join)
    stitched = stitched.reverse if round == 3
end
p hash_count - monsters*monster_hash_count
