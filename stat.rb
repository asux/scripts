#!/usr/bin/ruby -w
p = 0.95
tp = {
    0.95 => {
        2 => 12.706,
        3 => 4.303,
        4 => 3.182,
        5 => 2.776,
        6 => 2.571,
        7 => 2.447,
        8 => 2.365,
        9 => 2.306,
        10 => 2.262
  }
}
Q = {
    0.95 => {
        3 => 0.94,
        4 => 0.77,
        5 => 0.64,
        6 => 0.56,
        7 => 0.51,
        8 => 0.55,
        9 => 0.51,
        10 => 0.48,
    }
}
x = ARGV.map {|str| str.gsub(',', '.').to_f}
n = x.count
v = n - 1
puts "RAW x = #{x.join('; ')}"
x.sort!
R = x.max - x.min
q = {}
new_x = []
x.each_with_index {|xi, i| q[xi] = i<v ? (xi - x[i+1]).abs/R : (xi - x[i-1]).abs/R}
x.each do |k|
    value = q[k]
    if value < Q[p][n]
        pref = '+'
        new_x << k
    else
        pref = '-'
    end
    puts "#{pref} Q(#{k}) = #{value}"
end
x = new_x
n = x.count
v = n - 1
puts "CLEAR x = #{x.join('; ')}"
xm = x.inject(0) {|r, i| r + i} / n
s2 = x.inject(0) {|r, i| (xm - i) ** 2} / v
s = Math.sqrt s2
sx = s/(Math.sqrt n)
sr = s/xm
dx = tp[p][n]*sx
e = dx*100/xm
res = {'\bar{x}' => xm, 'S^2' => s2, 'S' => s, 'S_r' => sr, 'S_x' => sx, '\Delta x' => dx}
res.each { |key, value| puts "#{key} = #{value}" }
puts '\LaTeX'
puts "$x$ & $#{res.keys.join '$ & $'}$\\\\"
puts "#{x[0]} & #{res.values.join ' & '}\\\\".gsub('.', ',')
x[1..-1].each {|i| puts "#{i} & #{[].fill('&',0,res.count-1).join(' ')}\\\\".gsub('.',',')}
puts '\LaTeX'
puts "n = #{n}; P = #{p}; t_{P=#{p}, n=#{n}} = #{tp[p][n]}; \\varepsilon = #{e}\\%".gsub('.', ',')
