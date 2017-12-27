# Calculating digits of e using Brothers' Formulae
def fact(n)
  if n.zero?
    1
  else
    n * fact(n - 1)
  end
end

def calc_e(term)
  cons = 0
  for i in 0..term
    cons += ((9 * i * i) + 1) * @trick / fact(3 * i)
  end
  cons
end

# digits
digits = 1_000
# number of terms
term = 1_000
@trick = 10**digits

e = calc_e(term).to_s

old_sync = $stdout.sync
$stdout.sync = true
$stdout.write("#{e[0]}.#{e[1..digits]}")
$stdout.sync = old_sync
