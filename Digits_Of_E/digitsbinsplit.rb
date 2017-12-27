# Using binary splitting on the exponential series
def binary_split(a, b)
  if (b - a) == 1
      pab = 1
      qab = b
  else
    m = ((a + b) / 2).round(0)

    pam, qam = binary_split(a, m)
    pmb, qmb = binary_split(m, b)

    # P(a,b) = P(a,m)Q(m,b)+P(m,b)
    pab = pam * qmb + pmb
    # Q(a,b) = Q(a,m)Q(m,b)
    qab = qam * qmb
  end
  return pab, qab
end

def calc_e(digits)
  n = 1
  logFact = 0.0
  logMax = digits * Math.log10(10)
  while logFact < logMax
    logFact += Math.log10(n)
    n += 1
  end
  p_result, q_result = binary_split(0, n+1)
  trick = (10)**(2*digits)
  # 1 + P / Q
  result = trick + (p_result * trick) / q_result
  return result
end

t1 = Time.now

digits = 1_000_000

e = calc_e(digits).to_s

old_sync = $stdout.sync
$stdout.sync = true
$stdout.write("#{e[0]}.#{e[1..digits+20]}")
$stdout.sync = old_sync

t2 = Time.now
diff = t2 - t1
print "\n\n1: #{t1}\n2: #{t2}\ntime: #{diff}\n"
