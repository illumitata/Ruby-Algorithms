# Machin-like method

# Dlaczego arccotangensa?
# arctan(1/x) = arccot(x), GDY x > 0
# arccot(1/x) = arctan(x), GDY x > 0

=begin
def arccot(x, unity)
    xpow = unity / x
    x_square = x * x
    n = 1
    sign = 1
    sum = 0
    loop do
        term = xpow / n
        break if term == 0
        sum += sign * (xpow/n)
        xpow /= x_square
        n += 2
        sign = -sign
    end
    sum
end
=end

#fast af booooi - euler method
def self.arctan(x, unity)
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
    return total
end

def self.calc_pi(digits)
    #trik oszukuje liczby zmienno-przecinkowe
    #wynik wypisany jest w BigNum, a naszym zadaniem jest (*)
    trik = 10
    unity = 10**(digits+trik)
    ##################
    #podstawowa wersja J. Machin
    # pi = 4*(4*arccot(5, unity) - arccot(239, unity))
    ##################
    # Hwang Chien-Lih
    # pi = 4*(183*arccot(239, unity) + 32*arccot(1023, unity) - \
    #      68*arccot(5832, unity) + 12*arccot(110443, unity) - \
    #      12*arccot(4841182, unity) - 100*arccot(6826318, unity))
    ##################
    #world record setting cudo z 2002 roku całkiem fajna 5.25s dla 85000
    # pi = 176*arctan(57, unity) + 28*arctan(239,unity) - \
    #      48*arctan(682, unity) + 96*arctan(12943, unity)
    ##################
    # M. Wetherfield 4.8 sek dla 85000
    pi = 4*(83*arctan(107, unity) + 17*arctan(1710, unity) - \
         22*arctan(103697, unity) - 24*arctan(2513489, unity) - \
         44*arctan(18280007883, unity) + 12*arctan(7939642926390344818, unity) \
         + 22*arctan(3054211727257704725384731479018, unity))
    ##################
    return pi / (10**trik)
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
