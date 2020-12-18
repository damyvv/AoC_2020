input = File.read("day18_input.txt").split("\n").map { |l| l.scan(/\d+|[+*()]/) }

def parse(expr)
    loop do
        if subexpr = expr.index('(')
            par = parse(expr[subexpr+1..-1])
            expr = subexpr > 1 ? expr[0..subexpr-1].concat(par) : par
        elsif (eosubexp = expr.index(')')) && eosubexp > 1
            return [expr[0..eosubexp-1]].concat(expr[eosubexp+1..-1])
        else
            break
        end
    end
    return expr
end

# Part 1
def solve(expr)
    return expr.to_i if expr.kind_of?(String)
    while expr.count > 1
        lhs = solve(expr.shift)
        op = expr.shift.to_sym
        rhs = solve(expr.shift)
        expr.unshift([lhs,rhs].reduce(&op).to_s)
    end
    return expr[0].to_i
end

p input.map { |expr| parse(expr.clone) }.map { |tree| solve(tree) }.sum

# Part 2
def solve2(expr)
    return expr.to_i if expr.kind_of?(String)
    while expr.count > 1
        opidx = expr.index('+') || expr.index('*')
        lhs = solve2(expr.slice!(opidx-1))
        op = expr.slice!(opidx-1).to_sym
        rhs = solve2(expr.slice!(opidx-1))
        expr.insert(opidx-1,[lhs,rhs].reduce(&op).to_s)
    end
    return expr[0].to_i
end

p input.map { |expr| parse(expr) }.map { |tree| solve2(tree) }.sum

# Regex solutions
# Part 1
p File.read("day18_input.txt").split("\n").map { |l|
    loop do break unless l.sub!(/\((\d+)\)/, '\1') || 
                         l.sub!(/(.*?)(\d+\s*[+*]\s*\d+)(.*)/) { "#{$1}#{eval($2)}#{$3}" }
    end
    l
}.map(&:to_i).sum

# Part 2
p File.read("day18_input.txt").split("\n").map { |l| 
    loop do
        break unless
            l.sub!(/\((\d+)\)/, '\1') || 
            l.sub!(/(.*?)(\d+\s*[+]\s*\d+)(.*)/) { "#{$1}#{eval($2)}#{$3}" } ||
            l.sub!(/^(.*?)(\d+\s*[*]\s*\d+)([^(]*)$/) { "#{$1}#{eval($2)}#{$3}" } 
    end
    l
}.map(&:to_i).sum
