# Calculating Phi from (1 + sqrt(5) / 2) by illumitata

# Square root algorithm by Isaac Newton and Joseph Raphson
def sqrt_new(n, one)
  f_prec = 10**16
  n_float = ((n * f_prec) / one).to_f / f_prec
  x = ((f_prec * Math.sqrt(n_float)).to_i * one) / f_prec
  n_one = n * one
  x_old = 0
  loop do
    x = (x + n_one / x) >> 1 # >> 1 # / 2
    break if x == x_old
    x_old = x
  end
  x
end

t1 = Time.now

digits = 1_000_000
trick = 10**digits
f = sqrt_new(5 * trick, trick)
phi = ((trick + f) / 2).to_s

# File.open('digits.txt', 'w+') do |file|
#  file.write("#{phi[0]}.#{phi[1..phi.length]}")
# end

old_sync = $stdout.sync
$stdout.sync = true
$stdout.write("#{phi[0]}.#{phi[1..phi.length]}")
$stdout.sync = old_sync

t2 = Time.now
diff = t2 - t1
print "\n\n1: #{t1}\n2: #{t2}\ntime: #{diff}\n"
