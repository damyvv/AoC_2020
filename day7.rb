input = File.read('day7_input.txt').lines
    .map do |l|
        m = l.match(/(\D*) bags contain (.*)/)
        {   m[1] => m[2].split(',').map do |b|
                if b.start_with?("no")
                    {}
                else
                    m2 = b.match(/(\d+) (\D*) bag.*/)
                    { m2[2] => m2[1] }
                end
            end.reduce(Hash.new, :merge)
        }
    end.reduce(Hash.new, :merge)

# Part 1
fixed_point = ["shiny gold"]
prev_size = 0
while prev_size != fixed_point.size
    prev_size = fixed_point.size
    fixed_point |= input.filter { |_,v| v.any? { |k,vv| fixed_point.include? k } }.keys
end
p fixed_point.size-1

# Part 2
while input.any? {|k,v| v.is_a? Hash }
    input.each do |k,v|
        next if v.is_a? Integer
        next if v.keys.any? { |b| input[b].is_a? Hash }
        bags = 0
        v.each do |j,k|
            bags += input[j]*k.to_i+k.to_i
        end
        input[k] = bags
    end
end
p input["shiny gold"]
