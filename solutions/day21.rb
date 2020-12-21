input = File.read("day21_input.txt").lines.map {|l| l.split('(contains').map {|s| s.scan(/\w+/) } }

# Part 1
foods = input.map {|a| a[0] }.flatten
allergens = input.map {|a| a[1] }.flatten.uniq
af = allergens.map {|a| [a, foods.uniq] }.to_h
input.each { |food,allergen| allergen.each { |a| af[a] &= food } }
contains = af.to_a.map {|_,food| food }.flatten
p (foods - contains).count

# Part 2
closed = {}
while af.length > 0
    af = af.select do |food,allergen|
        if allergen.length > 1
            true
        else
            closed[food] = allergen.first
            false
        end
    end
    af.keys.each {|k| af[k] -= closed.values }
end
puts closed.keys.sort.map {|k| closed[k]}.join(',')
