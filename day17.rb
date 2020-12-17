require 'set'
input = File.read("day17_input.txt").lines.map {|l| l.strip.chars }

cubes = Set.new
input.each.with_index {|r,y| r.each.with_index {|c,x| cubes.add({ x: x, y: y, z: 0 }) if c == '#' } }

# Part 1
def cycle1(cubes)
    new_cubes = Set.new
    to_check = Set.new
    cubes.each do |cube|
        (-1..1).to_a.repeated_permutation(3).to_a.map {|a| {x:cube[:x]+a[0], y:cube[:y]+a[1], z:cube[:z]+a[2]} }.each do |coord|
            to_check.add(coord)
        end
    end
    to_check.each do |space|
        seen = (-1..1).to_a.repeated_permutation(3).to_a.map {|a| {x:space[:x]+a[0], y:space[:y]+a[1], z:space[:z]+a[2]} }.count do |coord|
            coord == space ? false : cubes.include?(coord)
        end
        new_cubes.add(space) if seen == 3
        if (seen == 2 && cubes.include?(space))
            new_cubes.add(space) 
        end
    end
    new_cubes
end

cubes1 = cubes.clone
6.times { cubes1 = cycle1(cubes1) }
p cubes1.count

# Part 2
def cycle2(cubes)
    new_cubes = Set.new
    to_check = Set.new
    cubes.each do |cube|
        (-1..1).to_a.repeated_permutation(4).to_a.map {|a| {x:cube[:x]+a[0], y:cube[:y]+a[1], z:cube[:z]+a[2], w:cube[:w]+a[3]} }.each do |coord|
            to_check.add(coord)
        end
    end
    to_check.each do |space|
        seen = (-1..1).to_a.repeated_permutation(4).to_a.map {|a| {x:space[:x]+a[0], y:space[:y]+a[1], z:space[:z]+a[2], w:space[:w]+a[3]} }.count do |coord|
            coord == space ? false : cubes.include?(coord)
        end
        new_cubes.add(space) if seen == 3
        if (seen == 2 && cubes.include?(space))
            new_cubes.add(space) 
        end
    end
    new_cubes
end

cubes2 = cubes.map {|c| {x:c[:x],y:c[:y],z:c[:z],w:0} }
6.times { cubes2 = cycle2(cubes2) }
p cubes2.count
