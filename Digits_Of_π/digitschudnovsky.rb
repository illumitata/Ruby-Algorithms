# Chudnovsky brothers' method
# The most efficent to this day

# Binary splitting
def bs(a, b)
    if (b - a) == 1
        if a == 0
            pab = 1
            qab = 1
        else
            pab = ((6 * a)-5) * ((2 * a)-1) * ((6 * a)-1)
            qab = (a * a) * (a * $c3)
        end

        tab = pab * (13591409 + (545140134 * a))

        if a & 1 == 1
            tab = -tab
        end
    else
        m = 0
        m = ((a + b) / 2).round(0)

        pam, qam, tam = bs(a, m)
        pmb, qmb, tmb = bs(m, b)

        pab = pam * pmb
        qab = qam * qmb
        tab = qmb * tam + pam * tmb
    end
    return pab, qab, tab
end

# Square root algorithm by Isaac Newton and Joseph Raphson
def sqrtNew(n, one)
    f_prec = 10**16
    n_float = ((n * f_prec) / one).to_f / f_prec
    x = ((f_prec * Math.sqrt(n_float)).to_i * one) / f_prec
    n_one = n * one
		xold = 0
    while 1
        x = (x + n_one / x) >> 1 # >> 1 # / 2
        break if x == xold
				xold = x
    end
    return x
end

def pi_chudnovsky(digits)
    c = 640320
    $c3 = (c**3 / 24).round(0)
    digits_per_term = Math.log10($c3/72)
    n = (digits/digits_per_term + 1).to_i
		pelo, q, t = bs(0, n)
    one_squared = (10)**(2*digits)
    tmp = 10005 * one_squared
    elo = sqrtNew(tmp, one_squared)
		result = q * elo
    result *= 426880
    result = result / t
		return result
end

t1 = Time.now

digits = 1_000_000
pi = pi_chudnovsky(digits)#.to_s
pi = "%d" % pi

old_sync = $stdout.sync
$stdout.sync = true
$stdout.write("#{pi[0]}.#{pi[1..digits]}")
$stdout.sync = old_sync

t2 = Time.now
diff = t2 - t1
print ("\n\n1: #{t1}\n2: #{t2}\nczas: #{diff}\n")
