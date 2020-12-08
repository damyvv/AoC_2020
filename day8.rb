input = File.read("day8_input.txt").lines.map {|l| l.split }

class Computer
    attr_reader :pc, :acc

    def initialize(instructions)
        @pc = 0
        @acc = 0
        @inst = instructions.clone
    end

    def step
        prev = @pc
        arg = @inst[@pc][1].to_i
        case @inst[@pc][0]
        when "nop"
            @pc += 1
        when "acc"
            @acc += arg
            @pc += 1
        when "jmp"
            @pc += arg
        else
            throw "Unknown instruction"
        end
        prev
    end

    def terminated?
        @pc == @inst.length
    end
end

# Part 1
def contains_loop?(c)
    seen = []
    seen.push c.step until (c.terminated? || seen.include?(c.pc))
    return c.terminated? ? nil : seen
end

c = Computer.new input
seen = contains_loop?(c)
puts "Acc: #{c.acc}"

# Part 2

while seen.count
    change = seen.pop
    cinput = input.clone
    case input[change][0]
    when "nop"
        cinput[change][0] = "jmp"
    when "jmp"
        cinput[change][0] = "nop"
    else
        next
    end
    c = Computer.new cinput
    if !contains_loop?(c)
        puts "Change instruction #{change} to #{cinput[change]}"
        puts "Acc: #{c.acc}"
        break
    end
end
