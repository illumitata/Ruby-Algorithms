# Metoda zaproponowana przez Dziadka
# "Komputer nie jest kamieniem więgielnym(fliozoficznym),
#  lecz osełką" ~ Hugo Battus

require 'bigdecimal'

if __FILE__ == $0

  prec = 50
  mone = BigDecimal.new("-1.0", prec)
  one  = BigDecimal.new("1.0", prec)
  two  = BigDecimal.new("2.0", prec)
  four = BigDecimal.new("4.0", prec)

  tmp1  = BigDecimal.new("0.0", prec)
  tmp2  = BigDecimal.new("0.0", prec)

  suma1 = BigDecimal.new("0.0", prec)
  n1    = BigDecimal.new("0.0", prec)
  suma2 = BigDecimal.new("0.0", prec)
  n2    = BigDecimal.new("0.0", prec)

  wynik = BigDecimal.new("0.0", prec)

  # arr = Array.new

  #obliczanie n-tego wyrazu
  for i in (0..150_000)
    tmp1 = two * n1
    tmp1 = tmp1 + one
    tmp2 = four / tmp1
    tmp1 = mone.power(n1, prec)
    tmp2 = tmp1 * tmp2
    # arr[i] = tmp2
    wynik += tmp2
    n1 = n1 + one
  end
=begin
  for i in (0..150_000)
    # wydrukowane kolejne wyrazy
    # print ("#{i} || #{arr[i]} \n")
  end
=end
  wynik = wynik.to_s('F')

  print ("#{wynik}\n")
end
