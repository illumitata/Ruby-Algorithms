# fibbonaczi wchodzi do akcji
# ciekawa metoda
def arctan(x, unity)
    x_square = x * x
    x_square += 1
    term = ((x * unity) / x_square).floor
    total = term
    n = 2
    loop do
        divisor = (n + 1) * x_square
        term *= n
        term = (term / divisor).floor
        break if term == 0
        total += term
        n += 2
    end
    total
end

def calc_pi(digits)
    trik = 10
    unity = 10**(digits+trik)
    pi = 0
    fib1 = 1
    fib2 = 1
    for k in 1..21000
      # obliczenie potrzebnego fibonacziego
      fib3 = fib1 + fib2
      pi = pi + arctan(fib3, unity)
      # policzenie pośredniego fibonacziego
      fib2 = fib3 + fib2
      fib1 = fib3
    end
    pi *= 4
    pi / (10**trik)
end

t1 = Time.now
# ile liczb
digits = 100
result = calc_pi(digits).to_s
# (*) wrzucić to na string i dodać kropkę pomiędzy 3.14 :)
$stdout.write("#{result[0]}.#{result[1..digits]}")
t2 = Time.now
diff = t2 - t1
print ("\n\n1: #{t1}\n2: #{t2}\nczas: #{diff}\n")
