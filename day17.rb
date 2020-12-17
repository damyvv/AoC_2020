require 'benchmark'
require 'set'
input = File.read("day17_input.txt").lines.map {|l| l.strip.chars }

cubes = Set.new
input.each.with_index {|r,y| r.each.with_index {|c,x| cubes.add([x,y,0]) if c == '#' } }

def cycle(cubes)
    dim = cubes.first.length
    new_cubes = Set.new
    to_check = Set.new
    cubes.each do |cube|
        to_check.merge((-1..1).to_a.repeated_permutation(dim).map { |space| cube.zip(space).map(&:sum) })
    end
    to_check.each do |space|
        seen = (-1..1).to_a.repeated_permutation(dim).map { |c| space.zip(c).map(&:sum) }.count do |coord|
            coord == space ? false : cubes.include?(coord)
        end
        new_cubes.add(space) if seen == 3
        if (seen == 2 && cubes.include?(space))
            new_cubes.add(space) 
        end
    end
    new_cubes
end

# Part 1
cubes1 = cubes.clone
6.times { cubes1 = cycle(cubes1) }
p cubes1.count

# Part 2
cubes2 = cubes.map {|c| c.push(0) }
6.times { cubes2 = cycle(cubes2) }
p cubes2.count
