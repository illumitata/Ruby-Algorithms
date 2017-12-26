# fibonaczi all around

require 'bigdecimal'

def calc_phi(iter)
  # we can start with different fib numbers,
  # they are always close to the ratio
  # always use F(n) and F(n+1)
  # add more prec when numbers become bigger
  prec = 170_000
  fib1 = BigDecimal.new("46368.0", prec)
  fib2 = BigDecimal.new("75025.0", prec)
  fib1new = BigDecimal.new("0.0", prec)
  fib2new = BigDecimal.new("0.0", prec)
  # Fast fibonaczi algorithm using doubling
  for k in 1..iter
    fib1new = fib1 * (2 * fib2 - fib1)
    fib2new = (fib2**2) + (fib1**2)
    fib1 = fib1new
    fib2 = fib2new
  end
  result = BigDecimal.new("0.0", prec)
  result = (fib2 / fib1).to_s('F')
end

t1 = Time.now

# iterations on fibonaczi
iter = 14
phi = calc_phi(iter)

File.open('digits.txt', 'w+') { |file| file.write("#{phi}") }

old_sync = $stdout.sync
$stdout.sync = true
$stdout.write("#{phi}")
$stdout.sync = old_sync

t2 = Time.now
diff = t2 - t1
print ("\n\n1: #{t1}\n2: #{t2}\ntime: #{diff}\n")
