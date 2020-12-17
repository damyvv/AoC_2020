input = File.read("day12_input.txt").lines.map do |l|
    { dir: l[0], dist: l[1..-1].to_i }
end
directions = ['N', 'E', 'S', 'W']

# Part 1
ship = { x: 0, y: 0, dir: 1 }
input.each do |inst|
    dir = inst[:dir] == 'F' ? directions[ship[:dir]] : inst[:dir]
    case dir
    when 'N'
        ship[:y] += inst[:dist]
    when 'E'
        ship[:x] += inst[:dist]
    when 'S'
        ship[:y] -= inst[:dist]
    when 'W'
        ship[:x] -= inst[:dist]
    when 'L'
        ship[:dir] = (ship[:dir] - (inst[:dist] / 90)) % 4
    when 'R'
        ship[:dir] = (ship[:dir] + (inst[:dist] / 90)) % 4
    end
end

p ship[:x].abs + ship[:y].abs

# Part 2
waypoint = { x: 10, y: 1 }
ship = { x: 0, y: 0 }
input.each do |inst|
    case inst[:dir]
    when 'N'
        waypoint[:y] += inst[:dist]
    when 'E'
        waypoint[:x] += inst[:dist]
    when 'S'
        waypoint[:y] -= inst[:dist]
    when 'W'
        waypoint[:x] -= inst[:dist]
    when 'L', 'R'
        deg = inst[:dir] == 'L' ? -inst[:dist] : inst[:dist]
        case deg % 360
        when 90
            waypoint[:y],waypoint[:x] = -waypoint[:x],waypoint[:y]
        when 180
            waypoint[:x],waypoint[:y] = -waypoint[:x],-waypoint[:y]
        when 270
            waypoint[:y],waypoint[:x] = waypoint[:x],-waypoint[:y]
        end
    when 'F'
        ship[:x] += waypoint[:x]*inst[:dist]
        ship[:y] += waypoint[:y]*inst[:dist]
    end
end

p ship[:x].abs + ship[:y].abs
