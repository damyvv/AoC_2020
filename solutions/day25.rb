cpub,dpub = File.read("day25_input.txt").split("\n").map(&:to_i)
subject = 7

cl = 0
k = 1
until k == cpub
    k = (k*subject) % 20201227
    cl += 1
end

key = 1
cl.times { key = (key*dpub) % 20201227 }
p key
