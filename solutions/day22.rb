require 'set'

input = File.read("day22_input.txt").split("\n\n").map {|pl| pl.split("\n")[1..].map(&:to_i) }

# Part 1
def play_round(input)
    p1 = input[0].shift
    p2 = input[1].shift
    input[p1 > p2 ? 0 : 1] += [p1,p2].sort.reverse
end

deck = input.map(&:dup)
play_round(deck) while deck[0].length > 0 && deck[1].length > 0
p deck.flatten.reverse.map.with_index { |n,idx| n*(idx+1) }.sum

# Part 2
def play_game(deck)
    seen = Set.new
    loop do
        return 0 if seen.include?(deck)
        seen.add(deck.map(&:dup))
        p1 = deck[0].shift
        p2 = deck[1].shift
        rwinner = p1 > p2 ? 0 : 1
        if deck[0].length >= p1 && deck[1].length >= p2
            rwinner = play_game([deck[0][..p1-1], deck[1][..p2-1]])
        end
        deck[rwinner] += rwinner == 0 ? [p1,p2] : [p2,p1]
        return 0 if deck[1].length == 0
        return 1 if deck[0].length == 0
    end
end

deck = input.map(&:dup)
winner = play_game(deck)
p deck[winner].reverse.map.with_index { |n,idx| n*(idx+1) }.sum
