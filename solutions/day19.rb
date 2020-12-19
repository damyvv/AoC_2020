require 'set'

rules,input = File.read("day19_input.txt").split("\n\n")
rules = rules.gsub(/\"/, '').scan(/^(\d+): (.*)$/).map { |id,s| { id.to_i => s.split('|').map { |r| r.strip.scan(/(\d+)|(\w+)/).map {|ss| ss[1] || ss[0].to_i } } } }.reduce(&:merge!)
input = input.strip.split("\n")

def conforms?(input, rules, current)
    rule = rules[current]
    if rule[0][0].kind_of?(String)
        return [input.start_with?(rule[0][0]), 1]
    end
    rule.each do |srule|
        eaten = 0
        conforms = true
        srule.each do |ssrule|
            res = conforms?(input[eaten..-1],rules,ssrule)
            if res[0]
                eaten += res[1]
            else
                conforms = false
                break
            end
        end
        return [true, eaten] if conforms
    end
    [false, 0]
end

# Part 1
p input.select { |i| conforms?(i, rules, 0)[1] == i.length }.count
