input = "137826495".chars.map(&:to_i)

class Node
    attr_accessor :next
    attr_reader :value
    def initialize value
        @value = value
    end
end

def play(rounds, first, hmap)
    current = first
    rounds.times do
        pickup_first = current.next
        pickup_last = pickup_first.next.next
        current.next = pickup_last.next
        dest = current.value == 1 ? hmap.size : current.value-1
        (dest = dest == 1 ? hmap.size : dest-1) while dest == pickup_first.value || dest == pickup_first.next.value || dest == pickup_first.next.next.value
        insert = hmap[dest]
        insert.next, pickup_last.next = pickup_first, insert.next
        current = current.next
    end
    current
end

# Part 1
list = input.map { |i| [i, Node.new(i)] }
list.each_cons(2) {|a,b| a[1].next = b[1] }
list[-1][1].next = list[0][1]

result = play(100, list[0][1], list.to_h)
result = result.next until result.value == 1
a1 = ""
8.times { result = result.next; a1 += result.value.to_s }
p a1.to_i

# Part 2
list = (input + (10..1000000).to_a).map { |i| [i, Node.new(i)] }
list.each_cons(2) {|a,b| a[1].next = b[1] }
list[-1][1].next = list[0][1]

result = play(10000000, list[0][1], list.to_h)
result = result.next until result.value == 1
a2 = 1
2.times { result = result.next; a2 *= result.value }
p a2
