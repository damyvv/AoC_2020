require 'set'

rules,input = File.read("day19_input.txt").split("\n\n")
rules = rules.gsub(/\"/, '').scan(/^(\d+): (.*)$/).map { |id,s| { id.to_i => s.split('|').map { |r| r.strip.scan(/(\d+)|(\w+)/).map {|ss| ss[1] || ss[0].to_i } } } }.reduce(&:merge!)
input = input.strip.split("\n")

def conforms?(input, rules, current)
    rule = rules[current]
    if rule[0][0].kind_of?(String)
        return input.start_with?(rule[0][0]) ? [1] : []
    end
    result = []
    rule.each do |srule|
        eatens = [0]
        srule.each do |ssrule|
            next_eaten = []
            eatens.each do |eaten|
                ress = conforms?(input[eaten..-1],rules,ssrule)
                next if ress.length == 0
                ress.each do |res|
                    if res > 0
                        next_eaten.push(eaten+res)
                    end
                end
            end
            eatens = next_eaten
        end
        result += eatens if eatens.length > 0
    end
    result
end

# Part 1
p input.select { |i| conforms?(i, rules, 0).include?(i.length) }.count

# Part 2
rules[8].push([42, 8])
rules[11].push([42, 11, 31])
p input.select { |i| conforms?(i, rules, 0).include?(i.length) }.count
