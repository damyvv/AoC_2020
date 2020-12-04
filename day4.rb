input = File.read('day4_input.txt').split("\n\n").map {|p| p.split.map {|l| Hash[*l.split(':')] }.inject(:merge!) }

# Part 1
puts (a = input.select { |pp| (pp.keys - ["cid"]).length == 7 }).count

# Part 2
puts a.filter { |pp|
    pp["byr"].to_i.between?(1920,2002) &&
    pp["iyr"].to_i.between?(2010,2020) &&
    pp["eyr"].to_i.between?(2020,2030) &&
    ((((pp["hgt"].match(/(\d+)cm/) || [0])[-1]).to_i).between?(150,193) ||
    (((pp["hgt"].match(/(\d+)in/) || [0])[-1]).to_i).between?(59,76)) &&
    pp["hcl"].match(/\A#[0-9a-f]{6}\Z/) &&
    pp["ecl"].match(/(amb|blu|brn|gry|grn|hzl|oth)/) &&
    pp["pid"].match(/\A\d{9}\Z/)
}.count
